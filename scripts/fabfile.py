from fabric.api import *


@hosts('django@PUB.IP.IP.IP')
def deploy(collectstatic=False):

    local('git -C ~/myprojects/mysite/site_repo/ push')
    run('git -C ~/mysite/site_repo/ pull')
    if collectstatic:
        run('python ~/mysite/manage.py collectstatic')
    run('touch ~/mysite/site_repo/wsgi.py')

@hosts('django@PUB.IP.IP.IP')
def migrate():
    run('python ~/mysite/manage.py migrate')

@hosts('myusername@PUB.IP.IP.IP')
def site_maintenance():
    run('sudo /usr/local/bin/./site-maintenance.sh')

@hosts('myusername@PUB.IP.IP.IP')
def site_up():
    run('sudo /usr/local/bin/./site-up.sh')


@hosts('myusername@PUB.IP.IP.IP')
def site_auth_on():
    run('sudo /usr/local/bin/./site-auth-on.sh')

@hosts('myusername@PUB.IP.IP.IP')
def site_auth_off():
    run('sudo /usr/local/bin/./site-auth-off.sh')