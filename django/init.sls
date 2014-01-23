{% from "django/map.jinja" import django with context %}

django:
  pkg:
    - installed
    - name: {{ django.pkg }}
