command = 'dbms_template_path/venv/bin/gunicorn'
pythonpath = 'dbms_template_path/prodject_new/'
bind = '127.0.0.1:8001'
workers = dbms_template_workers
user = 'dbms_template_user'
limit_request_fields = 32000
limit_request_fields_size = 0
rav_env = 'DJANGO_SETTINGS_MODULE=prodject1.settings'