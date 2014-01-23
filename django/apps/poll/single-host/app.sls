{% set poll_venv = salt['pillar.get']('django_apps:poll-single:venv') %}
{% set poll_proj = salt['pillar.get']('django_apps:poll-single:proj') %}
{% set poll_settings = salt['pillar.get']('django_apps:poll-single:settings') %}

include:
  - git
  - pip
  - virtualenv

empty_venv:
  virtualenv:
    - managed
    - name: /var/www/BASELINE
    - require:
      - pkg: virtualenv

poll_venv:
  virtualenv:
    - managed
    - name: {{ poll_venv }}
    - system_site_packages: True
    - require:
      - pkg: virtualenv

poll_gitsource:
  git.latest:
    - name: https://github.com/terminalmage/django-tutorial.git
    - target: {{ poll_proj }}
    - force: True
    - require:
      - pkg: git
      - virtualenv: poll_venv

poll_pkgs:
  pip:
    - installed
    - bin_env: {{ poll_venv }}
    - requirements: {{ poll_proj }}/requirements.txt
    - require:
      - git: poll_gitsource
      - pkg: pip
      - virtualenv: poll_venv

poll_settings:
  file:
    - managed
    - name: {{ poll_proj }}/poll/settings.py
    - source: salt://django/apps/poll/single-host/files/settings.py
    - template: jinja
    - require:
      - git: poll_gitsource

poll_wsgi:
  file:
    - managed
    - name: {{ poll_proj }}/poll/wsgi.py
    - source: salt://django/apps/poll/single-host/files/wsgi.py
    - template: jinja
    - require:
      - git: poll_gitsource

poll_syncdb:
  module:
    - run
    - name: django.syncdb
    - settings_module: {{ poll_settings }}
    - bin_env: {{ poll_venv }}
    - pythonpath: {{ poll_proj }}
    - require:
      - file: poll_settings
      - pip: poll_pkgs

poll_collectstatic:
  module:
    - run
    - name: django.collectstatic
    - settings_module: {{ poll_settings }}
    - bin_env: {{ poll_venv }}
    - pythonpath: {{ poll_proj }}
    - require:
      - file: poll_settings
      - pip: poll_pkgs
