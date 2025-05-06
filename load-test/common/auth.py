from bs4 import BeautifulSoup

def login(client):
    """Reusable login function with __RequestVerificationToken."""
    # Step 1: Get the login page to retrieve the token
    response = client.get("/login")
    if response.status_code != 200:
        print("Failed to load login page!")
        return response

    # Step 2: Parse the token from the HTML
    soup = BeautifulSoup(response.text, "html.parser")
    token = soup.find("input", {"name": "__RequestVerificationToken"})
    if not token or not token.get("value"):
        print("Failed to retrieve __RequestVerificationToken!")
        return response

    # Step 3: Use the token in the login POST request
    response = client.post(
        "/login",
        data={
            "UserName": "hskrtich@soaringtech.com",
            "Password": "Reconvene-Satisfy3-Comply-Counting",
            "RememberMe": "false",
            "__RequestVerificationToken": token["value"],
        },
    )
    if response.status_code != 200:
        print("Login failed!")
    return response
