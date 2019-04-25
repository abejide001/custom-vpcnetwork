#!/usr/bin/env bash

function install_ansible() {
    sudo apt-get update
    sudo apt-get install software-properties-common -y
    sudo apt-get repository --yes ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install ansible -y
}

function main {
    install_ansible
}
install_ansible
