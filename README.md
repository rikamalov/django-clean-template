# django-clean-template
Чистый шаблон django: nginx + gunicorn + supervisor

## Актуальная версия 2.0 от 19.07.21
### Цель обновления версии:
 - Генерация множества "чистых" django проектов на одном сервере, но на разных портах и с разными конфигурациями. 
### Список изменений в файл install.sh:
 - От пользователя запрашиваются новые данные имя проекта латиницей и номер порта.
 - Замена номера порта в файлах gunicorn_config.py и default автоматически.
 - Замена имени папки djangowebsite на имя проекта.
 - Замена путей /djangowebsite/ на /имя_проекта/
 - Замена program:gunicorn на program:gunicorn_имя_проекта в файле djangowebsite.conf
 - Замена имени конфигурационных файлов nginx и supervisor на файлы с именем проекта воизбежания конфликтов имён.

### Важно, версия 1.0 остаётся в репозитории, остальные файлы данного проекта остались без изменений для обратной совместимости с версией 1.0


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
