#!/bin/bash
base_python_interpreter=""
project_domain=""
project_ip=""
project_workers=""
project_path=`pwd`
user_linux=`echo $USER`
echo Ваш текущий путь к Python:
which python3

read -p "Укажите путь к Python: " base_python_interpreter
read -p "Ваше доменное имя, без http (for example, google.com): " project_domain
read -p "IP адрес сервера, без порта (for example, 155.155.255.50): " project_ip
read -p "Укажите количество workers, это цифра равна количество ядер умноженные на 2 + 1 (прим: 1 ядро - 3 workers): " project_workers
`$base_python_interpreter -m venv env`
source env/bin/activate
pip install -U pip
pip install django
pip install gunicorn
django-admin startproject config
mv config djangowebsite
sudo sed -i "s~dbms_template_path~$project_path~g" gunicorn_config.py
sudo sed -i "s~dbms_template_user~$user_linux~g" gunicorn_config.py
sudo sed -i "s~dbms_template_workers~$project_workers~g" gunicorn_config.py

sudo sed -i "s~dbms_template_path~$project_path~g" bin/start_gunicorn.sh
sudo chmod +x bin/start_gunicorn.sh
sudo sed -i "s~dbms_template_path~$project_path~g" djangowebsite.conf
sudo sed -i "s~dbms_template_user~$user_linux~g" djangowebsite.conf

sudo cp -f default /etc/nginx/sites-enabled
sudo cp -f gunicorn_config.py $project_path/djangowebsite
sudo cp -f djangowebsite.conf /etc/supervisor/conf.d
sudo service nginx restart
sudo service supervisor start
