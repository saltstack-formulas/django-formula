include:
  - mysql.server
  - mysql.python

# Remove the "test" database
mysql_remove_testdb:
  mysql_database:
    - absent
    - name: test

{% for name, db in salt['pillar.get']('django_apps:poll-single:DATABASES', {}).iteritems() %}
polldb:
  mysql_database:
    - present
    - name: {{ db.get('NAME') }}
    - require:
      - service: mysqld
      - pkg: mysql-python

polldb_user:
  mysql_user:
    - present
    - name: {{ db.get('USER') }}
    - host: {{ db.get('HOST') }}
    - password: {{ db.get('PASSWORD') }}
    - require:
      - mysql_database: polldb

polldb_grants:
  mysql_grants:
    - present
    - grant: all privileges
    - database: {{ db.get('NAME') }}.*
    - user: {{ db.get('USER') }}
    - host: {{ db.get('HOST') }}
    - require:
      - mysql_user: polldb_user
{% endfor %}
