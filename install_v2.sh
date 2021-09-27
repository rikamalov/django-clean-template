#!/bin/bash
base_python_interpreter=""
project_name=""
project_domain=""
project_port=""
project_workers=""
project_path=`pwd`
user_linux=`echo $USER`
echo Ваш текущий путь к Python:
which python3

read -p "Укажите путь к Python: " base_python_interpreter
read -p "Ваше доменное имя, без http (for example, google.com): " project_domain
read -p "Порт проекта (8001 если первый проект на сервере, 8002 если второй, итд.): " project_port
read -p "Укажите имя проекта (латинскими буквами без проблелов): " project_name
read -p "Укажите количество workers, это цифра равна количество ядер умноженные на 2 + 1 (прим: 1 ядро - 3 workers): " project_workers
`$base_python_interpreter -m venv env`
source env/bin/activate
pip install -U pip
pip install django
pip install gunicorn
django-admin startproject config
mv config $project_name
sudo sed -i "s~dbms_template_path~$project_path~g" gunicorn_config.py
sudo sed -i "s~dbms_template_user~$user_linux~g" gunicorn_config.py
sudo sed -i "s~dbms_template_workers~$project_workers~g" gunicorn_config.py

sudo sed -i "s~djangowebsite~$project_name~g" gunicorn_config.py
sudo sed -i "s~8001~$project_port~g" gunicorn_config.py

sudo sed -i "s~dbms_template_path~$project_path~g" default
sudo sed -i "s~dbms_template_web_address~$project_domain~g" default

sudo sed -i "s~djangowebsite~$project_name~g" default
sudo sed -i "s~8001~$project_port~g" default

sudo sed -i "s~dbms_template_path~$project_path~g" bin/start_gunicorn.sh
sudo sed -i "s~djangowebsite~$project_name~g" bin/start_gunicorn.sh
sudo chmod +x bin/start_gunicorn.sh

sudo sed -i "s~dbms_template_path~$project_path~g" djangowebsite.conf
sudo sed -i "s~dbms_template_user~$user_linux~g" djangowebsite.conf

sudo sed -i "s~program:gunicorn~program:gunicorn_$project_name~g" djangowebsite.conf

mv default nginx_$project_name.conf
mv djangowebsite.conf supervisor_$project_name.conf

sudo cp -f nginx_$project_name.conf /etc/nginx/sites-enabled
sudo cp -f gunicorn_config.py $project_path/$project_name
sudo cp -f supervisor_$project_name.conf /etc/supervisor/conf.d
sudo service nginx restart
sudo service supervisor start
sudo service supervisor restart
sudo rm -r .git/
