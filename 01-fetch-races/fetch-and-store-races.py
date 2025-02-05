# Deprecated since we can just download an XLS file and load it into the db

import requests
import psycopg2
from psycopg2.extras import Json


def fetch_races(url):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }

    try:
        print("Fetching races...")
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        races = response.json()
        print("Races fetched successfully")

        return races
    except requests.exceptions.RequestException as e:
        print(f"Error fetching races: {e}")
        return None


def store_races(races_data, url):
    try:
        print("Storing races data...")
        conn = psycopg2.connect(
            dbname="pro_cycling",
            user="postgres",
            password="postgres",
            host="localhost",
        )
        cur = conn.cursor()

        # Insert the JSON data into the races_raw table
        cur.execute(
            "INSERT INTO uci_world_tour.races_raw (request_url, json_data) VALUES (%s, %s)",
            (url, Json(races_data)),
        )

        conn.commit()
        print("Races data stored successfully")

    except psycopg2.Error as e:
        print(f"Database error: {e}")
        if conn:
            conn.rollback()
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()


if __name__ == "__main__":
    url = "https://www.uci.org/api/calendar/upcoming?discipline=ROA&seasonId=989"
    races_data = fetch_races(url)
    if races_data:
        store_races(races_data, url)
