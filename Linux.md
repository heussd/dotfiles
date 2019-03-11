# Linux / APT

## Update / Upgrade
	sudo apt update 
	sudo apt upgrade -y 

## Install packages

	sudo apt install -y \
		vim \
		stow

## Clean up

	sudo apt autoremove -y



## Install Docker

	sudo apt-get update
	sudo apt-get install -y \
	    apt-transport-https \
	    ca-certificates \
	    curl \
	    gnupg-agent \
	    software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   	sudo apt-get update
 	sudo apt-get install -y docker-ce
 	
## Install Docker compose

	sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
