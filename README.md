# one-click-django-server
A set of scripts to auto install development website for a django 1.8 website, on ubuntu machine
Tested on Ubuntu 14.04 LTS

## Intro
Tutorial with a real site, local after server set
Http
Re build and try


## Prep:

### Overview:
1. Install the server, see one-click-django server
2. Donwload the one-click-django-dev files to your local machine (you don't need to clone a repository, just the files)
3. Replace the required texts in the config files (see "Text to Replace")
4. SSH access to the server. If the django dev machine is not the one you installed the server from, you will need to set SSH


### Text to Replace:
Edit the scripts with your site specific info, e.g. username.
Simply edit and run the find_replace.sh script: 
    
    ```you@dev-machine$ nano find_replace.sh
    you@dev-machine$ ./find_replace.sh```
    

These are the texts that you should replace (either with the script or, your editor of choice):

1. Replace "myusername" with your actual username (files: setup.sh, scripts/django_projects.pth)
2. Replace "PUB.IP.IP.IP" with your actual vps IP (files: setup.sh)
3. Optional: Replace "myprojects" with another projects directory name (files: setup.sh, scripts/django_projects.pth,etc/apache2.conf)
4. Optional: Replace "mysite" with the actual project name on the server (files: setup.sh, scripts/django_projects.pth,etc/apache2.conf)

**Note: the project name is located on the server at /home/django** 


## Install
** Only after prep, text was replaced **

From the command line (make sure you are in the one-click-django-dev directory):

1. Run setup:
 ```you@dev-machine$ ./setup.sh```
        
2. Check: Browse to the site at 127.0.0.1
