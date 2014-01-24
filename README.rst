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


Full-stack App Deployment
=========================

This formula also provides an example of how Salt can be used to deploy a
Django app in a single command, using the `OverState System`_. It installs
Django into a virtualenv, using pip with a requirements.txt.

.. _`OverState System`: http://docs.saltstack.com/ref/states/overstate.html

This example makes use of the following three files:

* `pillar.example`_ - Pillar data
* `overstate.single`_ - Single-host OverState deployment stages 
* `overstate.multi`_ - Multi-host OverState deployment stages

.. _pillar.example: https://github.com/saltstack-formulas/django-formula/blob/master/pillar.example
.. _overstate.single: https://github.com/saltstack-formulas/django-formula/blob/master/overstate.single
.. _overstate.multi: https://github.com/saltstack-formulas/django-formula/blob/master/overstate.multi

Deploying this example will require that the relevant files are copied and
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
Instead, it's safer to fork the repository on github, and use the fork as a
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
to make any needed changes. This allows one to pull from the
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

To deploy using one database server (and one or more webservers), run the
following command:

.. code-block:: bash

    # salt-run state.over deployment /path/to/overstate.multi

.. note::

   If you did not create a separate ``deployment`` branch as recommended above,
   then replace ``deployment`` with ``base`` in the above ``salt-run``
   commands.


Other Tips
==========

Running ``syncdb`` or ``collectstatic`` automatically
-----------------------------------------------------

A wait state can be used to trigger ``django-admin.py syncdb`` or
``django-admin.py collectstatic`` automatically. The following example runs
both commands whenever the Git repository containing the example Django project
is updated.

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
