{% from "django/map.jinja" import django with context %}

django_pip:
  pip:
    - installed
    - name: {{ salt['pillar.get']('django:lookup:pip', 'Django') }}
