#!/bin/bash

curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -o /tmp/ez_setup.py
sudo python /tmp/ez_setup.py
rm /tmp/ez_setup.py

curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py -o /tmp/get-pip.py
sudo python /tmp/get-pip.py
rm /tmp/get-pip.py

sudo pip install virtualenv
sudo pip install virtualenvwrapper
