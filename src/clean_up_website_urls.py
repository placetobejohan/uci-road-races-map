"""
Clean up the website URLs in the races table.
"""

import psycopg
import validators
from pg_config import PG_CONN_STR, PG_SCHEMA


def main():
    with psycopg.connect(PG_CONN_STR) as pg_conn:
        with pg_conn.cursor() as pg_cur:
            # Add https to any website URLs that don't have it
            pg_cur.execute(
                f"""
                UPDATE {PG_SCHEMA}.races
                SET website = 'https://' || website
                WHERE website IS NOT NULL
                    AND NOT website ~ '^https?://'
                """
            )

            # Validate the website URLs
            races = pg_cur.execute(
                f"""
                SELECT id, website
                FROM {PG_SCHEMA}.races
                WHERE website IS NOT NULL
                """
            )

            invalid_ids = []
            for race in races:
                id = race[0]
                website = race[1]
                if not validators.url(website):
                    invalid_ids.append(id)
                    print(f"Invalid URL, fix manually: {id}, {website}")

            # Remove https:// for invalid URLs
            result = pg_cur.execute(
                f"""
                UPDATE {PG_SCHEMA}.races
                SET website = REPLACE(website, 'https://', '')
                WHERE id = ANY(%s)
                """,
                (invalid_ids,),
            )

    print("Done.")


if __name__ == "__main__":
    main()
