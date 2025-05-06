from locust import task, run_single_user
from locust import FastHttpUser
from common.auth import login

class admins(FastHttpUser):
    weight = 1  # Fewer users of this type
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

    @task
    def view_admindashboard(self):
        self.client.get("/Admin")  # Admin Dashboard

    @task
    def view_adminorderlist(self):
        self.client.get("/Admin/Order/List")  # Admin Order List

        # Set the Content-Type header for the POST request
        headers = {
            "Content-Type": "application/json",  # Set the desired Content-Type
        }

        # Make the POST request with the headers
        self.client.post(
            "/Admin/Order/ListData/",
            headers=headers,
            json={"type": "2"},  # Use `json` for JSON payloads
        )

    @task
    def view_adminacutionlist(self):
        self.client.get("/Admin/Auction/Dashboard")  # Admin Acution List

        # Call this a ton to mimic the load from a real user
        for _ in range(1000):
            self.client.post("/Admin/Auction/GetOpenAuctionItemData", data={type: "2"})  # Admin Order data
