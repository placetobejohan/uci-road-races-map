import os
import psycopg
import sqlite_utils
from types import SimpleNamespace

# --- Config ---
PG_CONN_STR = "dbname=pro_cycling user=postgres password=postgres host=localhost"
PG_SCHEMA = "uci_road"
SQLITE_DB_PATH = "data/uci_road.db"
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

    # Build SELECT clause, replacing geometry with ST_AsGeoJSON
    select_parts = []
    for col in columns:
        if col == "geom":
            select_parts.append(f"postgis.st_asgeojson({col}) AS {col}")
        else:
            select_parts.append(col)
    select_clause = ", ".join(select_parts)

    cursor.execute(f"SELECT {select_clause} FROM {schema}.{table_name}")
    rows = cursor.fetchall()
    data = [dict(zip(columns, row)) for row in rows]

    print(f"Inserting {len(data)} rows into {table_name}")
    sqlite_db[table_name].insert_all(data, pk="id")


def main():
    # Remove the existing sqlite file
    if os.path.exists(SQLITE_DB_PATH):
        os.remove(SQLITE_DB_PATH)

    sqlite_db = sqlite_utils.Database(SQLITE_DB_PATH)

    with psycopg.connect(PG_CONN_STR) as pg_conn:
        with pg_conn.cursor() as pg_cur:
            tables = get_table_names(pg_cur, PG_SCHEMA)

            # Export each table to SQLite
            for table_name in tables:
                export_table(pg_cur, PG_SCHEMA, table_name, sqlite_db)

            # Add foreign keys
            for table_name in tables:
                foreign_constraints = get_foreign_constraints(
                    pg_cur, PG_SCHEMA, table_name
                )
                for fk in foreign_constraints:
                    print(
                        f"Adding foreign key constraint {table_name}.{fk.column} -> {fk.foreign_table}.{fk.foreign_column}"
                    )
                    sqlite_db[table_name].add_foreign_key(
                        fk.column, fk.foreign_table, fk.foreign_column
                    )

    print("Done.")


if __name__ == "__main__":
    main()
