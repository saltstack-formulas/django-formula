======
django
======

Set up and configure the Django web application framework.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``django``
----------

Install Django from the system package manager. Note, the Django version
available varies by platform.

Example usage::

    include:
      - django

    mysite:
      git:
        - latest
        - name: git@git.example.com/mysite
        - target: /var/www/mysite
        - require:
            - pkg: django

``django.pip``
--------------

Install Django via pip.

Example usage::

    include:
      - django.pip

    mysite:
      git:
        - latest
        - name: git@git.example.com/mysite
        - target: /var/www/mysite
        - require:
            - pip: django_pip

Other Tips
==========

Running ``syncdb`` or ``collectstatic`` automatically
-----------------------------------------------------

A wait state can be used to trigger ``django-admin.py syncdb`` or
``django-admin.py collectstatic`` automatically::

    include:
      - django.pip

    mysite:
      git:
        - latest
        - name: git@git.example.com/mysite
        - target: /var/www/mysite
        - require:
            - pip: django_pip

    mysite_syncdb:
      module:
        - wait
        - name: django.syncdb
        - settings_module: "mysite.settings"
        - bin_env: /path/to/virtualenv          # optional
        - pythonpath: /path/to/mysite_project   # optional
        - watch:
          - git: mysite

    mysite_collectstatic:
      module:
        - wait
        - name: django.collectstatic
        - settings_module: "mysite.settings"
        - bin_env: /path/to/virtualenv          # optional
        - pythonpath: /path/to/mysite_project   # optional
        - watch:
          - git: mysite
