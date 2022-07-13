#!/bin/bash
set -x
sudo yum install -y python3
pip3 install --user awscli
mkdir immuta
pushd immuta
aws s3 cp s3://immuta-rke2/immuta-2022.2.0-trino-389-rke2-v1.23.8.tar.gz .
tar xf immuta-2022.2.0-trino-389-rke2-v1.23.8.tar.gz
python3 -m venv .venv
. .venv/bin/activate
pip3 install --upgrade pip
pip3 install -r requirements.txt
ansible-playbook --become --connection=local  playbook.yml --skip-tags=immuta-driver
