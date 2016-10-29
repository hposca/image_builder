# Intro

Builds an AMI on AWS with all that is needed to build a docker image. After the AMI is built you can boot up an EC2 instace and use it.

The AMI will have [Docker](https://www.docker.com/) and [Rocker](https://github.com/grammarly/rocker) installed.

# Which thing does what?

- [Packer](https://www.packer.io/) builds the AMI
    - [Ansible](https://www.ansible.com/) installs and configures [Docker](https://www.docker.com/) and [Rocker](https://github.com/grammarly/rocker)
- [Terraform](https://www.terraform.io/) starts the EC2 instance

# Testing locally

To test if all the necessary packages and configuration will be installed correctly run the installation process in isolation:

    vagrant up
    vagrant ssh
    cd /vagrant
    ansible-playbook -i hosts -c localhost playbook.yml
    # after the installation finished successfully become the 'ubuntu' user:
    sudo su - ubuntu
    rocker --help

# Prerequisites

- Have your `awscli` installed and configured
- Install [packer](https://www.packer.io/downloads.html) and [terraform](https://www.terraform.io/downloads.html)
    - [Packer Installation Guide](https://www.packer.io/intro/getting-started/setup.html)
    - [Terraform Installation Guide](https://www.terraform.io/intro/getting-started/install.html)
- Discover your `AWS Account Number` and copy it:
    - One way to discover it is to log into your account then go to the support center page. At the upper right corner you'll see the `Account Number`
    - Another way is, if you already have an AMI built, go to the `AMIs` page on `EC2`. It will have an `Owner` column
- Have a `Key Pair` to use in the instances
    - To create a Key Pair go to the `EC2 page` > `Network & Security & Key Pairs` and click on `Create Key Pair`
    - Make sure to download the created Key Pair

# Steps

- Build the AMI:

    packer build packer.json

- Paste your `owner` and `keypair` at the `main.tf` file
- Create the EC2 instance that will use the built AMI:

    terraform get
    terraform plan
    terraform apply

- SSH into the newly created instance and play with it:

    ssh -i <your key pair PEM file> ubuntu@<instance public IP address>
