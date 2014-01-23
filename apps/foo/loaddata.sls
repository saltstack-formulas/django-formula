{% set foo_venv = salt['pillar.get']('django_apps:foo:venv') %}
{% set foo_proj = salt['pillar.get']('django_apps:foo:proj') %}
{% set foo_settings = salt['pillar.get']('django_apps:foo:settings') %}

foo_loaddata:
  module:
    - run
    - name: django.loaddata
    - fixtures: ' {{ foo_proj }}/foo/fixtures/foo.json'
    - settings_module: {{ foo_settings }}
    - bin_env: {{ foo_venv }}
    - pythonpath: {{ foo_proj }}
