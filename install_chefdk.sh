#!/usr/bin/env bash
main() {
  $(uname -s) "$@"
}

Linux() {
  # Optional Parameter
  VER=${1:-'3.2.30'}
  PKG=chefdk_${VER}-1_amd64.deb
  PREFIX=https://packages.chef.io/files/stable/chefdk/

  # Fetch and Install
  wget --quiet ${PREFIX}/${VER}/ubuntu/16.04/${PKG}
  sudo dpkg -i ${PKG}

  # Local ChefDK Ruby Gems
  chef gem install kitchen-ansible
  chef gem install kitchen-docker
}

Darwin() {
  # Get Homebrew
  BREWRL="https://raw.githubusercontent.com/Homebrew/install/master/install"
  which -s brew || /usr/bin/ruby -e "$(curl -fsSL ${BREWRL})"
  # Install Latest
  brew tap chef/chef
  brew cask install chefdk
  chef gem install kitchen-ansible
  chef gem install kitchen-docker
}

main
