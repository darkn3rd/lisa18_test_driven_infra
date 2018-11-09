#!/usr/bin/env bash
main() {
  $(uname -s)
}

Linux() {
  sudo apt-get update -qq
  sudo apt-get install -y apt-transport-https \
   curl ca-certificates software-properties-common

  DOCKER_REPO="https://download.docker.com/linux/ubuntu"
  curl -fsSL ${DOCKER_REPO}/gpg | \
    sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] ${DOCKER_REPO} \
    $(lsb_release -cs) \
    stable"

  sudo apt-get update -qq
  sudo apt-get install -y docker-ce
  sudo usermod -aG docker $USER
}

Darwin() {
  # Get Homebrew
  BREWRL="https://raw.githubusercontent.com/Homebrew/install/master/install"
  which -s brew || /usr/bin/ruby -e "$(curl -fsSL ${BREWRL})"
  # Install Latest
  brew cask install docker
}

main
