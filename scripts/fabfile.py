import datetime
from fabric.api import *


@hosts('django@PUB.IP.IP.IP')
def deploy(collectstatic=False):

    local('git --git-dir=/home/myusername/myprojects/mysite/site_repo/.git push production master')
    with cd('~/mysite/site_repo'):
        run('git reset --hard')
    
    if collectstatic:
        run('python ~/mysite/manage.py collectstatic')
        
    run('rm ~/mysite/site_config/*.py')
    run('touch ~/mysite/site_config/__init__.py')
    run('cp ~/mysite/site_repo/settings_production.py ~/mysite/site_config/')
    run('touch ~/mysite/site_repo/wsgi.py')

@hosts('django@PUB.IP.IP.IP')
def migrate():
    run('python ~/mysite/manage.py migrate')
    
@hosts('django@PUB.IP.IP.IP')
def backup(backup_name=None):

    if backup_name == None:
        backup_name = datetime.datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
    with cd('~/mysite/'):
        run('python manage.py dumpdata > db_backup/%s'%backup_name)


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
    
