# Default SSH Key
resource "aws_key_pair" "ed25519" {
  key_name   = "hakes-2025-ed25519"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIECkdGos/Pg8zX4kPT/eIjA+e6CDahu+c+tDa0N9mXMY hakes-2025-ed25519"
}

# Windows Only Key
# ssh-keygen -t rsa -b 4096 -m pem -C "hakes-2025-rsa" -f hakes-2025-rsa
resource "aws_key_pair" "rsa" {
  key_name   = "hakes-2025-rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCdxA03aYdY9d4xNZ9n9viwdPPTlAx3dCdFVpS1PzBacIHKdYflHjnHvHbb1rAArGZE7+NOLmXz4INpEcaYxxFLp1MeVU1t9GkG6XfmW9N8kKJrpLFVILBHDz/d/YtW0AwNnqelYse5b5uquOmS03EW67gbqbOP3dKhaH/X7S0yMDsRdzGDf5v+52QBYFj8/A03JCAj+5HhrB43HNKf3aXJkCREW3Jr0LJJuE2QcujvIwqG4v/VAMIfS5DlcDieNHQoxF7s3yValhNR/QlpQtn8pPF5SAy5zoHC1qb7BPe2je2AM80/fRhqiXus+rt3WMa0vecTZvLir4p3ep9/4MdrCmJNnn5tg+cv1bWGKF7BvYlCPk2PurryVcB9tNvg3xrZWZMqVWV8P7X7KDaL8+u3gcR8eMrCIlW/Tdlo0WBNri8+3/YFz6jM1S2NdHQGkAyItRMSuX03q3zDEApfdFP4+H+xyjyZfNbKNccTbW24uMrqTNQpv66prEduz1CEO3POCUIyjYSiPAyi9UGR/YdYFhqxaCQzrXmdwKeKiFQeIytpdWeriy7pwJyjSqbrCvHlKgSAUAnVDHG1ojXJrNHM6hcCEGuR0OIH3JKeDn2MOKDB8YkOAyzWDqBBna5QRmOQsN6glyL3Ggf7hKGu4Po7hTrHBC2n2aCw9sOVjWvSjw== hakes-2025-rsa"
}
