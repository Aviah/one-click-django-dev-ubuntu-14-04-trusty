# replace the "replace-with..." strings with the actual data
# run this script from it's directory 

# edit tp replace
sed -i "s/PUB.IP.IP.IP/replace-with-actual-vps-ip/g" setup.sh
sed -i "s/myusername/replace-with-your-username/g" setup.sh etc/apache2.conf scripts/django_projects.pth 

# Optional, uncomment to replace
#sed -i "s/myprojects/replace-with-another-projects-dir-name/g" setup.sh etc/apache2.conf scripts/django_projects.pth
#sed -i "s/mysite/replace-with-another-project-name/g" setup.sh scripts/django_projects.pth etc/apache2.conf

echo "Done"