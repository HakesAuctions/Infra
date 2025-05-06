$ConfigPath = "config.json"

# Apply the configuration and start the agent
Write-Host "Applying CloudWatch Agent configuration..."
& "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" `
  -a fetch-config `
  -m ec2 `
  -c file:$ConfigPath `
  -s

Write-Host "CloudWatch Agent setup complete."
