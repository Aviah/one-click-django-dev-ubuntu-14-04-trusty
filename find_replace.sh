# replace the "replace-with..." strings with the actual data
# run this script from it's directory 

# edit tp replace
sed -i "s/PUB.IP.IP.IP/replace-with-actual-vps-ip/g" setup.sh scripts/fabfile.py
sed -i "s/myusername/replace-with-your-username/g" setup.sh etc/apache2.conf etc/django-site-nginx scripts/django_projects.pth scripts/site-reload.sh scripts/tail-logs.sh scripts/fabfile.py

# Optional, uncomment to replace
#sed -i "s/myprojects/replace-with-another-projects-dir-name/g" setup.sh etc/apache2.conf etc/django-site-nginx scripts/django_projects.pth scripts/site-reload.sh scripts/tail-logs.sh 
#sed -i "s/mysite/replace-with-another-project-name/g" setup.sh scripts/django_projects.pth etc/django-site-nginx etc/apache2.conf scripts/site-reload.sh scripts/tail-logs.sh

echo "Done"