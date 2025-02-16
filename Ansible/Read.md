Steps to install ansible in ubuntu
----------------------------------

•	sudo apt update

•	sudo apt install ansible -y

•	ansible --version

•	python3 --version


Steps to create Ansible playbook for Nginx Install
--------------------------------------------------

1. Create a new directory to store playbook
	mkdir deploy-nginx
	cd deploy-nginx/
	
2. Create & update ansible playbook for nginx install
	vi install-nginx.yml 

3. Run ansible playbook
	ansible-playbook install-nginx.yml

4. Check Nginx webserver
	curl http://localhost
	
5. Location of webserver pages
	ll /var/www/html

6. Create a fresh index.html pages
	sudo vi /var/www/html/index.html
	curl http://localhost
