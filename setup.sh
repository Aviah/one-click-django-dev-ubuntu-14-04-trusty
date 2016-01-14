# Edits:
# Username: Replace "myusername" with your actual username

USERNAME="myusername"
SITEPROJECTNAME="mysite"
PROJECTSDIR='myprojects'

usermod -a -G www-data $USERNAME

# django site
apt-get install python-pip
pip install Django==1.8.7
mkdir -p /home/$USERNAME/$PROJECTSDIR/
mkdir /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME
mkdir /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/static_root
mkdir /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_resources
mkdir /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_uploads
cp images/favicon.ico images/powered-by-django.gif  /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_resources/
cp images/avatar.png /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/media_uploads
mkdir /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config
touch /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/__init__.py
cp scripts/settings_tmp.py /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/
cp scripts/secrets.py /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/
mkdir /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs
touch /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs/main.log
touch /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs/debug.log
touch /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/logs/debug_db.log
mkdir /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/django_cache
apt-get install git
chown -R $USERNAME:www-data /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/
su $USERNAME -c "git clone django@PUB.IP.IP.IP:/home/django/site_repo.git /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_repo"
su $USERNAME -c "git --git-dir=/home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_repo/.git remote add production django@PUB.IP.IP.IP:/home/django/$SITEPROJECTNAME/site_repo/ "
cp scripts/manage.py /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/
cp /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_repo/settings_dev.py /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/site_config/
chown -R $USERNAME:www-data /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/
cp scripts/django_projects.pth /usr/lib/python2.7/dist-packages/

# Webservers
apt-get install nginx
service nginx stop
apt-get install apache2-mpm-worker libapache2-mod-wsgi
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig
cp /etc/apache2/ports.conf /etc/apache2/ports.conf.orig
cp etc/nginx.conf /etc/nginx/
cp etc/apache2.conf /etc/apache2/
cp etc/ports.conf /etc/apache2/
cp etc/django-site-nginx /etc/nginx/sites-available/django
ln -s /etc/nginx/sites-available/django /etc/nginx/sites-enabled/django
rm /etc/nginx/sites-enabled/default
cp etc/django-site-apache /etc/apache2/sites-available/django
ln -s /etc/apache2/sites-available/django /etc/apache2/sites-enabled/django
rm /etc/apache2/sites-enabled/000-default.conf
service nginx restart
service apache2 restart

# Database
echo; echo ">>> During the follwing MySQL installation, you will be asked to enter the MySQL root password."
echo ">>> Select a strong password, and rememeber it, you will need it soon! (press any key to continue)"
echo "[Press ENTER to continue]"
read dummy
apt-get install mysql-server mysql-client
echo; echo ">>> Running mysql_secure_installation. If the root password you just entered is strong, you don't need to change it"
echo ">>> For the rest of the options, select the defaults"
echo "[Press ENTER to continue]"
read dummy
mysql_secure_installation
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.orig
cp etc/my.cnf /etc/mysql/my.cnf
service mysql restart
apt-get install python-mysqldb
python scripts/replace_django_mysql_passwd.py 
echo "Use MySQL root password"
mysql -uroot -p < scripts/db.sql

# command line scripts
cp scripts/site*.sh /usr/local/bin/
cp scripts/tail-logs.sh /usr/local/bin/
su $USERNAME -c "touch /home/$USERNAME/.bash_aliases"
su $USERNAME -c "cp user/django_site_aliases /home/$USERNAME/.django_site_aliases"
su $USERNAME -c "echo . /home/$USERNAME/.django_site_aliases >> /home/$USERNAME/.bash_aliases"


# Init
/home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/manage.py migrate
echo ">>> Adding django site superuser (access to the site django administration)"
echo "[Press ENTER to continue]"
read dummy
/home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/manage.py createsuperuser
/home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/manage.py collectstatic
chown -R $USERNAME:www-data /home/$USERNAME/$PROJECTSDIR/$SITEPROJECTNAME/
service apache2 restart
service nginx restart

# fabric
apt-get install fabric
touch /home/$USERNAME/.fabricrc
cp /home/$USERNAME/.fabricrc /home/$USERNAME/.fabricrc.orig
echo "fabfile=/home/$USERNAME/fab_$SITEPROJECTNAME.py" > /home/$USERNAME/.fabricrc
cp scripts/fabfile.py /home/$USERNAME/fab_$SITEPROJECTNAME.py
chown $USERNAME:$USERNAME /home/$USERNAME/.fabric* /home/$USERNAME/fab_$SITEPROJECTNAME.py

echo "Woohoo! If everything OK you should be able to visit the site in your browser http://127.0.0.1, or with manage.py runserver at http://127.0.0.1:8000"












