# Set script to fail fast
$ErrorActionPreference = "Stop"

# Variables
$CloudWatchAgentMsiUrl = "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi"
$InstallerPath = "C:\Temp\amazon-cloudwatch-agent.msi"
$ConfigPath = "config.json"

# Create folders if they don't exist
New-Item -Path "C:\Temp" -ItemType Directory -Force | Out-Null
New-Item -Path "C:\CWAgent" -ItemType Directory -Force | Out-Null

# Download the CloudWatch Agent installer
Write-Host "Downloading CloudWatch Agent..."
Invoke-WebRequest -Uri $CloudWatchAgentMsiUrl -OutFile $InstallerPath

# Install CloudWatch Agent silently
Write-Host "Installing CloudWatch Agent..."
Start-Process msiexec.exe -ArgumentList "/i `"$InstallerPath`" /qn" -Wait

# Apply the configuration and start the agent
Write-Host "Applying CloudWatch Agent configuration..."
& "C:\Program Files\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1" `
  -a fetch-config `
  -m ec2 `
  -c file:$ConfigPath `
  -s

Write-Host "CloudWatch Agent setup complete."
