import re
import random
import json
import time
from bs4 import BeautifulSoup
from locust import task, run_single_user
from locust import FastHttpUser
from common.auth import login

class Bidders(FastHttpUser):
    weight = 6  # More users of this type
    host = "https://app.hakes.com"
    default_headers = {
        "accept-encoding": "gzip, deflate, br, zstd",
        "accept-language": "en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7",
        "cache-control": "no-cache",
        "pragma": "no-cache",
        "sec-ch-ua": '"Brave";v="135", "Not-A.Brand";v="8", "Chromium";v="135"',
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": '"Windows"',
        "sec-gpc": "1",
        "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36",
    }

    def on_start(self):
        """Log in before executing tasks."""
        login(self.client)

    @task(2)
    def view_homepage(self):
        self.client.get("/")

    @task(1)
    def view_mybids(self):
        self.client.get("/Account")  # View account page
        self.client.get("/Account/Bids")  # View bids page

    @task(2)
    def browse_auctions(self):
        # View browse auction
        self.client.get("/Auction/BrowseAuction")

        # View all auction items
        self.client.get("/Auction/CategoryItemList")

    @task(2)
    def view_meetthestaff(self):
        self.client.get("/Article/1250/198076")  # Meet The Staff

    @task(2)
    def view_howtoconsign(self):
        self.client.get("/Article/1250/154747/How-To-Consign")  # How To Consign

    @task(2)
    def view_hakesstory(self):
        self.client.get("/Article/1250/196530/Hake's%20Americana%20and%20Collectibles%20Turns%2050'")  # Hake's Story

    @task(2)
    def view_auctionclosingproceduref(self):
        self.client.get("/Article/1250/154748/Auction-Closing-Procedures")  # Auction Closing Procedure

    @task(2)
    def view_mybids(self):
        self.client.get("/Account/Bids")  # My Bids

        # Set the Content-Type header for the POST request
        headers = {
            "Content-Type": "application/json",  # Set the desired Content-Type
            "Content-Length": 0, # For some reason, this is required
        }

        # Call this a ton to mimic the load from a real user
        for _ in range(60):
            # Make the POST request with the headers
            self.client.post(
                "/Account/BidsData",
                headers=headers,
            )
            time.sleep(1)  # Add a 1-second delay between requests

    @task(2)
    def view_accountdetails(self):
        self.client.get("/Account/Detail")  # Account Details

    @task(5)
    def browse_random_item(self):
        # View browse auction
        self.client.get("/Auction/BrowseAuction")

        # View all auction items
        self.client.get("/Auction/CategoryItemList")

        """Simulate clicking a random item from the _rowSet array."""
        # Step 1: View all items on a single page
        response = self.client.get("/Auction/CategoryItemList?dgv-rowsPerPage=ALL&dgv-page=1&dgv-sortCol=ItemcodeFull&dgv-sortDir=asc")
        if response.status_code != 200:
            print("Failed to load the page!")
            return

        # Step 2: Extract the _rowSet array from the JavaScript
        match = re.search(r"_rowSet\s*=\s*(\[[^\]]*\])", response.text)  # Use raw string (r"")
        if not match:
            print("Failed to find _rowSet in the page!")
            return

        # Step 3: Parse the _rowSet array safely
        row_set_json = match.group(1)
        try:
            row_set = json.loads(row_set_json)
        except json.JSONDecodeError as e:
            print(f"Failed to parse _rowSet: {e}")
            return

        #print("Extracted _rowSet:", row_set)

        if not row_set:
            print("No items found in _rowSet!")
            return

        # Step 4: Randomly select an item from the _rowSet array
        random_item = random.choice(row_set)
        item_id = random_item.get("Id")

        # Step 5: Generate the URL for the selected item
        # https://app.hakes.com/Auction/ItemDetail/298574/
        self.client.get(f"/Auction/ItemDetail/{item_id}/")


if __name__ == "__main__":
    run_single_user(browse_random_item)
