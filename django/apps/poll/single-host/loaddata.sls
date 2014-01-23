{% set poll_venv = salt['pillar.get']('django_apps:poll-single:venv') %}
{% set poll_proj = salt['pillar.get']('django_apps:poll-single:proj') %}
{% set poll_settings = salt['pillar.get']('django_apps:poll-single:settings') %}

poll_loaddata:
  module:
    - run
    - name: django.loaddata
    - fixtures: ' {{ poll_proj }}/poll/fixtures/poll.json'
    - settings_module: {{ poll_settings }}
    - bin_env: {{ poll_venv }}
    - pythonpath: {{ poll_proj }}
