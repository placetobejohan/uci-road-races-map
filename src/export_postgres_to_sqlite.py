"""
Export data from PostgreSQL to SQLite.
"""

import os
import psycopg
import sqlite_utils
from types import SimpleNamespace
from pg_config import PG_CONN_STR, PG_SCHEMA
from clean_up_website_urls import main as clean_up_website_urls

# --- Config ---
SQLITE_DB_PATH = "data/uci_road.db"
DATASETTE_SCHEMA = "uci_road_datasette"  # New schema for data transformation
# ----------------


def get_table_names(cursor, schema):
    """Get all table names from the specified schema."""
    cursor.execute(
        """
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = %s
        """,
        (schema,),
    )
    table_names = [row[0] for row in cursor.fetchall()]
    return table_names


def get_column_names(cursor, schema, table_name):
    """Get all column names for a specific table."""
    cursor.execute(
        """
        SELECT column_name
        FROM information_schema.columns
        WHERE table_schema = %s
            AND table_name = %s
        """,
        (schema, table_name),
    )
    column_names = [row[0] for row in cursor.fetchall()]
    return column_names


def get_foreign_constraints(cursor, schema, table_name):
    """Get all foreign constraints for a specific table."""
    cursor.execute(
        """
        SELECT
            kcu.column_name,
            ccu.table_name AS foreign_table_name,
            ccu.column_name AS foreign_column_name
        FROM
            information_schema.table_constraints AS tc
            JOIN information_schema.key_column_usage AS kcu
              ON tc.constraint_name = kcu.constraint_name
              AND tc.table_schema = kcu.table_schema
            JOIN information_schema.constraint_column_usage AS ccu
              ON ccu.constraint_name = tc.constraint_name
              AND ccu.table_schema = tc.table_schema
        WHERE constraint_type = 'FOREIGN KEY'
            AND tc.table_name = %s
            AND tc.table_schema = %s
        """,
        (table_name, schema),
    )

    rows = cursor.fetchall()
    foreign_constraints = [
        SimpleNamespace(
            column=row[0],
            foreign_table=row[1],
            foreign_column=row[2],
        )
        for row in rows
    ]
    return foreign_constraints


def export_table(cursor, schema, table_name, sqlite_db):
    """Export a table from Postgres to SQLite."""
    columns = get_column_names(cursor, schema, table_name)

    # Build SELECT clause, replacing geometry with longitude and latitude
    select_parts = []
    for col in columns:
        if col == "geom":
            select_parts.append(
                f"postgis.st_x(postgis.ST_PointOnSurface({col})) AS longitude"
            )
            select_parts.append(
                f"postgis.st_y(postgis.ST_PointOnSurface({col})) AS latitude"
            )
        else:
            select_parts.append(col)
    select_clause = ", ".join(select_parts)

    cursor.execute(f"SELECT {select_clause} FROM {schema}.{table_name}")
    columns = [desc[0] for desc in cursor.description]
    rows = cursor.fetchall()
    data = [dict(zip(columns, row)) for row in rows]

    print(f"Inserting {len(data)} rows into {table_name} from {schema}")
    sqlite_db[table_name].insert_all(data, pk="id")


def main():
    # Remove the existing sqlite file
    if os.path.exists(SQLITE_DB_PATH):
        os.remove(SQLITE_DB_PATH)

    # In case the data has been updated, clean up the website URLs again
    clean_up_website_urls()

    sqlite_db = sqlite_utils.Database(SQLITE_DB_PATH)
    exported_tables = set()

    with psycopg.connect(PG_CONN_STR) as pg_conn:
        with pg_conn.cursor() as pg_cur:
            # First, export tables from the datasette schema
            print(f"Exporting tables from {DATASETTE_SCHEMA} schema...")
            datasette_tables = get_table_names(pg_cur, DATASETTE_SCHEMA)

            for table_name in datasette_tables:
                export_table(pg_cur, DATASETTE_SCHEMA, table_name, sqlite_db)
                exported_tables.add(table_name)

            # Then, export tables from the main schema that don't exist in datasette schema
            print(f"Exporting missing tables from {PG_SCHEMA} schema...")
            main_tables = get_table_names(pg_cur, PG_SCHEMA)

            for table_name in main_tables:
                if table_name not in exported_tables:
                    export_table(pg_cur, PG_SCHEMA, table_name, sqlite_db)

            # Add foreign keys from the main schema only
            print("Adding foreign key constraints from main schema...")
            all_tables = get_table_names(pg_cur, PG_SCHEMA)
            for table_name in all_tables:
                foreign_constraints = get_foreign_constraints(
                    pg_cur, PG_SCHEMA, table_name
                )
                for fk in foreign_constraints:
                    print(
                        f"Adding foreign key constraint {table_name}.{fk.column} -> {fk.foreign_table}.{fk.foreign_column}"
                    )
                    try:
                        sqlite_db[table_name].add_foreign_key(
                            fk.column, fk.foreign_table, fk.foreign_column
                        )
                    except Exception as e:
                        print(f"Warning: Could not add foreign key: {e}")

    print("Done.")


if __name__ == "__main__":
    main()
