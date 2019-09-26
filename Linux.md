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
	curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
	sudo usermod -aG docker $USER
	docker run hello-world

## Install Docker-Compose
	sudo apt-get install -y python3-pip python3-dev
	sudo pip3 install docker-compose
	docker-compose --version
