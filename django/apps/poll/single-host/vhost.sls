{% from "apache/map.jinja" import apache with context %}

include:
  - apache
  - apache.mod_wsgi
{% if grains['os'] == 'CentOS' %}
  - django.apps.poll.single-host.firewall
{% endif %}

poll-vhost:
  file.managed:
    - name: {{ apache.vhostdir }}/poll-vhost.conf
    - source: salt://django/apps/poll/single-host/files/poll-vhost.conf
    - template: jinja
    - require:
      - pkg: apache
      - pkg: mod_wsgi
    - watch_in:
      - service: apache


{# Remove the default site (and enable the app's site if necesssary) #}
{% if grains.os_family == 'Debian' %}
a2ensite poll-vhost.conf:
  cmd.run:
    - require:
      - pkg: apache
      - file: poll-vhost

# TODO: Check other Debian/Ubuntu releases and make this more accurate
{% set osrelease = grains['osrelease'] %}
{% if grains['os'] == 'Ubuntu' and osrelease|float >= 14.04 %}
    {% set default_site = '000-default' %}
{% else %}
    {% set default_site = 'default' %}
{% endif %}

a2dissite {{ default_site }}:
  cmd.run:
    - require:
      - pkg: apache

service apache2 reload:
  cmd.run:
    - onchanges:
      - cmd: a2ensite poll-vhost.conf
      - cmd: a2dissite {{ default_site }}
{% elif grains.os_family == 'RedHat' %}
{{ apache.vhostdir }}/welcome.conf:
  file.absent:
    - require:
      - pkg: apache
{% endif %}
