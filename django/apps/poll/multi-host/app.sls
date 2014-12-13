{% set poll_venv = salt['pillar.get']('django_apps:poll-multi:venv') %}
{% set poll_proj = salt['pillar.get']('django_apps:poll-multi:proj') %}
{% set poll_settings = salt['pillar.get']('django_apps:poll-multi:settings') %}

include:
  - git
  - pip
  - virtualenv
  - mysql.python

empty_venv:
  virtualenv.managed:
    - name: /var/www/BASELINE
    - require:
      - pkg: virtualenv

poll_venv:
  virtualenv.managed:
    - name: {{ poll_venv }}
    - system_site_packages: True
    - require:
      - pkg: virtualenv

poll:
  git.latest:
    - name: https://github.com/terminalmage/django-tutorial.git
    - target: {{ poll_proj }}
    - force: True
    - require:
      - pkg: git
      - virtualenv: poll_venv

poll_pkgs:
  pip.installed:
    - bin_env: {{ poll_venv }}
    - requirements: {{ poll_proj }}/requirements.txt
    - require:
      - git: poll
      - pkg: pip
      - virtualenv: poll_venv

{% set db_server = salt['pillar.get']('django_apps:poll-multi:minion_roles:database', 'django-db') %}
# Get salt['mine.get'](db_server, 'network.interfaces')[db_server]['eth0']['inet'][0]['address']
{% set db_server_ip = salt['mine.get'](db_server, 'network.interfaces').get(db_server, {}).get('eth0', {}).get('inet', [{}])[0].get('address') %}
{% if db_server_ip %}
poll_settings:
  file.managed:
    - name: {{ poll_proj }}/poll/settings.py
    - source: salt://django/apps/poll/multi-host/files/settings.py
    - template: jinja
    - context:
      db_server_ip: {{ db_server_ip }}
    - require:
      - git: poll
      - pkg: mysql-python
{% endif %}

poll_wsgi:
  file.managed:
    - name: {{ poll_proj }}/poll/wsgi.py
    - source: salt://django/apps/poll/multi-host/files/wsgi.py
    - template: jinja
    - require:
      - git: poll

poll_syncdb:
  module.run:
    - name: django.syncdb
    - settings_module: {{ poll_settings }}
    - bin_env: {{ poll_venv }}
    - pythonpath: {{ poll_proj }}
    - require:
      - file: poll_settings
      - pip: poll_pkgs

poll_collectstatic:
  module.run:
    - name: django.collectstatic
    - settings_module: {{ poll_settings }}
    - bin_env: {{ poll_venv }}
    - pythonpath: {{ poll_proj }}
    - require:
      - file: poll_settings
      - pip: poll_pkgs
