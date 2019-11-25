.. _readme:

django
======

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/django-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/django-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Set up and configure the Django web application framework.

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please pay attention to the ``pillar.example`` file and/or `Special notes`_ section.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Special notes
-------------

None

Available states
----------------

.. contents::
   :local:

``django``
^^^^^^^^^^

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
^^^^^^^^^^^^^^

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


Full-stack App Deployment
-------------------------

This formula also provides an example of how Salt can be used to deploy a
Django app in a single command, using the `OverState System`_. It installs
Django into a virtualenv, using pip with a requirements.txt.

.. _`OverState System`: http://docs.saltstack.com/en/latest/topics/tutorials/states_pt5.html#states-overstate

This example makes use of the following three files:

* `pillar.example`_ - Pillar data
* `overstate.single`_ - Single-host OverState deployment stages 
* `overstate.multi`_ - Multi-host OverState deployment stages

.. _pillar.example: https://github.com/saltstack-formulas/django-formula/blob/master/pillar.example
.. _overstate.single: https://github.com/saltstack-formulas/django-formula/blob/master/overstate.single
.. _overstate.multi: https://github.com/saltstack-formulas/django-formula/blob/master/overstate.multi

Deploying this example will require that the relevant files from above (the
Pillar data and appropriate OverState config file) are copied to the Master and
edited as necessary. The Pillar data will need to be available to all involved
minions.

Additionally, this example makes use of several other Salt formulae:

* `apache-formula`_
* `git-formula`_
* `mysql-formula`_
* `pip-formula`_
* `virtualenv-formula`_

.. _apache-formula: https://github.com/saltstack-formulas/apache-formula.git
.. _git-formula: https://github.com/saltstack-formulas/git-formula.git
.. _mysql-formula: https://github.com/saltstack-formulas/mysql-formula.git
.. _pip-formula: https://github.com/saltstack-formulas/pip-formula.git
.. _virtualenv-formula: https://github.com/saltstack-formulas/virtualenv-formula.git

An easy way to use these would be to add them as gitfs sources. It is not
recommended to add the master copy of the repo (the one within the
`saltstack-formulas`_ account), as others may be pushing to this repository.
Instead, it's safer to fork the repository on GitHub, and use the fork as a
gitfs remote. For example:

.. _saltstack-formulas: https://github.com/saltstack-formulas

.. code-block:: yaml

    gitfs_remotes:
      - https://github.com/yourusername/django-formula.git
      - https://github.com/yourusername/apache-formula.git
      - https://github.com/yourusername/git-formula.git
      - https://github.com/yourusername/mysql-formula.git
      - https://github.com/yourusername/pip-formula.git
      - https://github.com/yourusername/virtualenv-formula.git


It is also a good idea, though not mandatory, to create a branch and use that
to make any needed changes. This allows you to pull from the
`saltstack-formulas`_ version of the repo into your local fork's ``master``
branch, and evaluate the changes without causing conflicts with whatever
changes you made.

.. code-block:: bash

    $ git branch
    * master
    $ git checkout -b deployment
    Switched to a new branch 'deployment'
    $ git push -u origin deployment 

This would need to be repeated for each gitfs remote.

To deploy the entire stack (Apache, MySQL, Django, application) to a single
host, run the following command:

.. code-block:: bash

    # salt-run state.over deployment /path/to/overstate.single

To deploy using one database server (and one or more web servers), run the
following command:

.. code-block:: bash

    # salt-run state.over deployment /path/to/overstate.multi

.. note::

   If you did not create a separate ``deployment`` branch as recommended above,
   then replace ``deployment`` with ``base`` in the above ``salt-run``
   commands.


Other Tips
----------

Create ``settings.py`` using data from Pillar
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The easiest way to create Django's ``settings.py`` file using data from Pillar
is to simply transform a dictionary in YAML into a dictionary in Python.

``/srv/salt/mysite.sls``::

    include:
      - django.pip

    mysite:
      git:
        - latest
        - name: git@git.example.com/mysite
        - target: /var/www/mysite
        - require:
            - pip: django_pip

    mysite_settings:
      file:
        - managed
        - name: /var/www/mysite/settings.py
        - contents: |
            globals().update({{ salt['pillar.get']('mysite:settings') | python() | indent(8) }})
        - require:
          - git: mysite

``/srv/pillar/mysite.sls``::

    mysite:
      settings:
        ROOT_URLCONF: mysite.urls
        SECRET_KEY: 'gith!)on!_dq0=2l(otd67%#0urmrk6_d0!zu)i9fn=!8_g5(c'
        DATABASES:
          default:
            ENGINE: django.db.backends.mysql
            NAME: mysitedb
            USER: mysiteuser
            PASSWORD: mysitepass
            HOST: localhost
            PORT: 3306
        TEMPLATE_DIRS:
          - /var/www/mysite/django-tutorial/templates
        STATICFILES_DIRS:
          - /var/www/mysite/django-tutorial/static
        STATIC_ROOT: /var/www/mysite/django-tutorial/staticroot

Create ``settings.py`` with a template file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A more traditional (and flexible) method of creating the ``settings.py`` file
is to actually create the file as a template.

``/srv/salt/mysite/mysite.sls``::

    include:
      - django.pip

    mysite:
      git:
        - latest
        - name: git@git.example.com/mysite
        - target: /var/www/mysite
        - require:
            - pip: django_pip

    mysite_settings:
      file:
        - managed
        - name: /var/www/mysite/settings.py
        - source: salt://mysite/files/settings-tmpl.py
        - template: jinja
        - require:
          - git: mysite

``/srv/salt/mysite/files/settings-tmpl.py``::

    {# Data can be defined inline, in Grains, in Pillar, etc #}

    {% set db_settings = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'HOST': 'localhost',
            'NAME': 'polldb',
            'PASSWORD': 'pollpass',
            'PORT': 3306,
            'USER': 'polluser',
        }
    } %}

    {% set staticfiles_dirs_settings = [
        '/var/www/poll/django-tutorial/static',
    ] %}

    {% set template_dirs_settings = [
        '/var/www/poll/django-tutorial/templates',
    ] %}

    ROOT_URLCONF = mysite.urls

    {# Have Salt automatically generate the SECRET_KEY for this minion #}
    SECRET_KEY = '{{ salt['grains.get_or_set_hash']('mysite:SECRET_KEY', 50) }}'

    DATABASES = {{ db_settings | python() }}

    TEMPLATE_DIRS = {{ template_dirs_settings | python() }}

    STATICFILES_DIRS = {{ staticfiles_dirs_settings | python() }}

    STATIC_ROOT = /var/www/mysite/django-tutorial/staticroot

Run ``syncdb`` or ``collectstatic`` automatically
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A wait state can be used to trigger ``django-admin.py syncdb`` or
``django-admin.py collectstatic`` automatically. The following example runs
both commands whenever the Git repository containing the "mysite" Django
project is updated.

::

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

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``django.pip`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
