import requests
import json


def fetch_races():
    url = "https://www.uci.org/api/calendar/upcoming?discipline=ROA"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }

    try:
        print("Fetching races...")
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        races = response.json()
        return races
    except requests.exceptions.RequestException as e:
        print(f"Error fetching races: {e}")
        return None


if __name__ == "__main__":
    races_data = fetch_races()
    if races_data:
        # print(json.dumps(races_data, indent=2))
        # The items contain the months, print April only
        print(json.dumps(races_data["items"][3], indent=2))
