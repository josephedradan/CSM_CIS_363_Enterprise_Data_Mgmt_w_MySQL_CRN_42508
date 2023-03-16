#!/usr/bin/env python
"""
First you need this:
    python36 -m pip install --upgrade pip
    python36 -m pip install mysqlclient
    python36 -m pip install django-crispy-forms

To Run:
    python36 "H:\Programming\Python\Projects_School\College_of_San_Mateo\CSM CIS 363 Enterprise Data Mgmt w MySQL CRN 42508\Final Project\amazon_clone\manage.py" runserver 127.0.0.1:8000

Logging on to myql if you didn't remember:
    mysql -u root -p

IF YOUR HAVING MYSQL ERROR
    django.db.utils.OperationalError: (1045, "Access denied for user 'Joseph'@'localhost' (using password: NO)")

        mysql -u root -p
        SELECT User, Host FROM mysql.user;

        Reference:
            https://linuxize.com/post/how-to-show-mysql-users/#:~:text=Show%20All%20MySQL%20Users,-MySQL%20stores%20information&text=A%20user%20account%20in%20MySQL,query%20against%20a%20selected%20data.

****** ONCE THE SERVER IS RUNNING AND THE PAGE DOES NOT UPDATE THE CSS EVEN THOUGH YOU CHANGED IT
    CLEAR YOU CACHE ON THE WEBSITE
    Chrome:
        Ctrl + Shift + R

    Reference:
        https://stackoverflow.com/questions/23751767/chrome-disable-cache-for-localhost-only
"""


"""Django's command-line utility for administrative tasks."""
import os
import sys


def main():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'amazon_clone.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
