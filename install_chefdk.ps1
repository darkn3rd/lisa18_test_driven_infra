If (-Not $(get-command 'choco' 2> $null))  {
  "Chocolately Not Found, Installing Chocolatey"
  $script = 'https://chocolatey.org/install.ps1'
  Set-ExecutionPolicy Bypass -Scope Process -Force
  iex ((New-Object System.Net.WebClient).DownloadString($script))
}

choco install chefdk
chef gem install kitchen-ansible
chef gem install kitchen-docker
