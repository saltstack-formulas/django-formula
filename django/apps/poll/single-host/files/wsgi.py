"""
WSGI config for poll project.

This module contains the WSGI application used by Django's development server
and any production WSGI deployments. It should expose a module-level variable
named ``application``. Django's ``runserver`` and ``runfcgi`` commands discover
this application via the ``WSGI_APPLICATION`` setting.

Usually you will have the standard Django WSGI application here, but it also
might make sense to replace the whole Django WSGI application with a custom one
that later delegates to the Django one. For example, you could introduce WSGI
middleware here, or combine a Django application with an application of another
framework.

"""
import os
import site
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "{{ salt['pillar.get']('django_apps:poll-single:settings') }}")

{% set poll_sitepackages = salt['cmd.exec_code'](
    salt['pillar.get']('django_apps:poll-single:venv') ~ '/bin/python',
    'from distutils import sysconfig; print sysconfig.get_python_lib()'
) %}

site.addsitedir('{{ poll_sitepackages }}')

sys.path.append('{{ salt['pillar.get']('django_apps:poll-single:proj') }}')

# This application object is used by any WSGI server configured to use this
# file. This includes Django's development server, if the WSGI_APPLICATION
# setting points here.
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

# Apply WSGI middleware here.
# from helloworld.wsgi import HelloWorldApplication
# application = HelloWorldApplication(application)
