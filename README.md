# django-clean-template
Чистый шаблон django: nginx + gunicorn + supervisor

### 1. Ставим необходимые пакеты 
```
sudo apt-get update
```
```
sudo apt-get install -y  htop git curl nano nginx  supervisor
```
```
sudo apt-get install -y python3-pip python3-dev python3-venv
```
### 2. Создаём папку и скачиваем проект
#### создаём директорию в папке юзера если нужно
```
mkdir <dir-name>
```
#### скачиваем проект в созданную директорию
```
git clone <link>
```
### 3. Переименовываем папку `django-clean-template`
```
mv django-clean-template <new-dir-name>
```
### 4. Запускаем установку
```
. install.sh
```
### 5. Настраиваем файл settings.py 
```
ALLOWED_HOSTS = []
```
### 6. Заливаем свой проект по sftp не перезатирая файл `wsgi` и не меняя название папки `config` 


## Графическая схема шагов установки, что и упакованно в install.sh 


<img src="https://getwebcode.ru/static/shareimg/roadmapserverstartapp.png">
