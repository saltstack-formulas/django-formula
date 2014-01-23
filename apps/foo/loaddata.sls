{% set poll_venv = salt['pillar.get']('django_apps:poll:venv') %}
{% set poll_proj = salt['pillar.get']('django_apps:poll:proj') %}
{% set poll_settings = salt['pillar.get']('django_apps:poll:settings') %}

poll_loaddata:
  module:
    - run
    - name: django.loaddata
    - fixtures: ' {{ poll_proj }}/poll/fixtures/poll.json'
    - settings_module: {{ poll_settings }}
    - bin_env: {{ poll_venv }}
    - pythonpath: {{ poll_proj }}
