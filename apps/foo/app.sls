{% set foo_venv = salt['pillar.get']('django_apps:foo:venv') %}
{% set foo_proj = salt['pillar.get']('django_apps:foo:proj') %}
{% set foo_settings = salt['pillar.get']('django_apps:foo:settings') %}

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

foo_venv:
  virtualenv:
    - managed
    - name: {{ foo_venv }}
    - system_site_packages: True
    - require:
      - pkg: virtualenv

foo_gitsource:
  git.latest:
    - name: https://github.com/terminalmage/django-tutorial.git
    - target: {{ foo_proj }}
    - force: True
    - require:
      - pkg: git
      - virtualenv: foo_venv

foo_pkgs:
  pip:
    - installed
    - bin_env: {{ foo_venv }}
    - requirements: {{ foo_proj }}/requirements.txt
    - require:
      - git: foo_gitsource
      - pkg: pip
      - virtualenv: foo_venv

foo_settings:
  file:
    - managed
    - name: {{ foo_proj }}/foo/settings.py
    - source: salt://apps/foo/files/settings.py
    - template: jinja
    - require:
      - git: foo_gitsource

foo_wsgi:
  file:
    - managed
    - name: {{ foo_proj }}/foo/wsgi.py
    - source: salt://apps/foo/files/wsgi.py
    - template: jinja
    - require:
      - git: foo_gitsource

foo_syncdb:
  module:
    - run
    - name: django.syncdb
    - settings_module: {{ foo_settings }}
    - bin_env: {{ foo_venv }}
    - pythonpath: {{ foo_proj }}
    - require:
      - file: foo_settings
      - pip: foo_pkgs

foo_collectstatic:
  module:
    - run
    - name: django.collectstatic
    - settings_module: {{ foo_settings }}
    - bin_env: {{ foo_venv }}
    - pythonpath: {{ foo_proj }}
    - require:
      - file: foo_settings
      - pip: foo_pkgs
