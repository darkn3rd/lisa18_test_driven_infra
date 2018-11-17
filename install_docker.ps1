If (-Not $(Get-Command 'choco' 2> $null))  {
  "Chocolately Not Found, Installing Chocolatey"
  $script = 'https://chocolatey.org/install.ps1'
  Set-ExecutionPolicy Bypass -Scope Process -Force
  iex ((New-Object System.Net.WebClient).DownloadString($script))
}

# installs docker-for-windows (now docker-desktop) that uses hyper-v
choco install 'docker-for-windows'
