# Odoo Production Environment Template
## Using Odoo + Postgresql + Nginx with Docker-compose

## Odoo conf

<code>[options]<br/>
; Modules Config<br/>
addons_path = /mnt/extra-addons<br/>
; Security Config<br/>
admin_passwd = your_master_passwd<br/>
csv_internal_sep = ,<br/>
data_dir = /var/lib/odoo<br/>
; Database config<br/>
db_host = db ;Docker reference to postgre database<br/>
db_maxconn = 9<br/>
db_name = your_database<br/>
db_filter = your_database<br/>
db_password = your_db_password<br/>
db_port = 5432<br/>
db_template = template1<br/>
db_user = your_db_user<br/>
; Server Config<br/>
demo = {}<br/>
email_from = False<br/>
geoip_database = /usr/share/GeoIP/GeoLite2-City.mmdb<br/>
limit_memory_hard = 6000000000<br/>
limit_memory_soft = 6000000000<br/>
limit_request = 8192<br/>
limit_time_cpu = 43200<br/>
limit_time_real = 86400<br/>
limit_time_real_cron = -1<br/>
list_db = True<br/>
log_db = False<br/>
log_db_level = warning<br/>
log_handler = :INFO<br/>
log_level = info<br/>
logfile = None<br/>
logrotate = False<br/>
longpolling_port = 8072<br/>
max_cron_threads = 2<br/>
osv_memory_age_limit = 1.0<br/>
osv_memory_count_limit = False<br/>
pg_path = None<br/>
pidfile = None<br/>
proxy_mode = True<br/>
reportgz = False<br/>
server_wide_modules = web<br/>
smtp_password = False<br/>
smtp_port = 25<br/>
smtp_server = localhost<br/>
smtp_ssl = False<br/>
smtp_user = False<br/>
syslog = False<br/>
test_commit = False<br/>
test_enable = False<br/>
test_file = False<br/>
test_report_directory = False<br/>
translate_modules = ['all']<br/>
unaccent = False<br/>
without_demo = True<br/>
;workers = 5<br/>
xmlrpc = True<br/>
xmlrpc_port = 8069<br/>
xmlrpc_interface = 0.0.0.0<br/></code>



## Nginx Default Config
server {
    listen [::]:80;
    listen 80;

    location ~ /.well-known/acme-challenge {
        allow all;
        root /var/www/html;
    }

    location / {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://odoo:8069;
    }

    location ~* /web/static/ {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $host;
        proxy_pass http://odoo:8069;
    }
}

