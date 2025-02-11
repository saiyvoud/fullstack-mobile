# restaurant_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


[program:sample]
command=node /cloudclusters/Scholarship/src/server.js
autostart=true
startsecs=10
autorestart=true
startretries=3
redirect_stderr=true
stdout_logfile = /var/log/supervisor/nodejs.log
directory = /cloudclusters/Scholarship
logfile_maxbytes=50MB
logfile_backups=5
server {
    listen 80;
    server_name https://nodejsclusters-183358-0.cloudclusters.net/;

    location / {
        proxy_pass http://127.0.0.1:8001$request_uri;
    }
}

server {
    listen 80;
    server_name ec2-47-129-60-120.ap-southeast-1.compute.amazonaws.com;

    location / {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $server_name;
        proxy_cache_bypass $http_upgrade;
    }

    # Redirect all HTTP requests to HTTPS
    return 301 https://$server_name$request_uri;
}