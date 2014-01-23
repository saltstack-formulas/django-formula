{% from "apache/map.jinja" import apache with context %}

include:
  - apache
  - apache.mod_wsgi
{% if grains['os'] == 'CentOS' %}
  - foo.firewall
{% endif %}

foo-vhost:
  file:
    - managed
    - name: {{ apache.vhostdir }}/foo-vhost.conf
    - source: salt://apps/foo/files/foo-vhost.conf
    - template: jinja
    - require:
      - pkg: apache
      - pkg: mod_wsgi
    - watch_in:
      - service: apache


{% if grains.os_family == 'Debian' %}
a2ensite foo-vhost.conf:
  cmd:
    - run
    - require:
      - pkg: apache
      - file: foo-vhost
{% endif %}


{# Remove the default site #}

{% if grains.os_family == 'RedHat' %}
{{ apache.vhostdir }}/welcome.conf:
  file:
    - absent
    - require:
      - pkg: apache
{% endif %}

{% if grains.os_family == 'Debian' %}
a2dissite default:
  cmd:
    - run
    - require:
      - pkg: apache
{% endif %}
