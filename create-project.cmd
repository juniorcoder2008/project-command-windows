mkdir %1 && cd %1 && mkdir js && mkdir style && (
    echo ^<!DOCTYPE html^>
    echo ^<html^>
    echo    ^<head^>
    echo        ^<meta charset="UTF-8"^>
    echo        ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
    echo        ^<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" /^>
    echo        ^<title^>%1^</title^>
    echo        ^<link rel="stylesheet" href="./style/index.min.css"^>
    echo    ^</head^>
    echo    ^<body^>
    echo        ^<h1^>Template^</h1^>
    echo        ^<script src="./js/app.js"^>^</script^>
    echo    ^</body^>
    echo ^</html^>
)>"index.html" && cd js && type nul > app.js && cd .. && cd style && (
    echo *{margin:0;padding:0;box-sizing:border-box}body{height:100vh;width:100%;background-color:#f1f1f1;margin:0;padding:0;box-sizing:border-box;font-family: sans-serif}
)>"index.scss" && (
    echo *{margin:0;padding:0;box-sizing:border-box}body{height:100vh;width:100%;background-color:#f1f1f1;margin:0;padding:0;box-sizing:border-box;font-family: sans-serif}
)>"index.min.css" && type nul > index.min.css.map && cd .. && npm init -y && npm i browser-sync && (
    echo {
    echo  "name": "%1",
    echo  "version": "1.0.0",
    echo  "description": "",
    echo  "main": "index.js",
    echo  "scripts": {
    echo    "start": "browser-sync start --server --files 'style/*.css', '*.html', 'js/*.js' --port=5300 --no-notify",
    echo    "build": "docker build -t %1 .",
    echo    "container": "docker run --name %1 -d -p 80:80 %1"
    echo  },
    echo  "keywords": [],
    echo  "author": "",
    echo  "license": "ISC",
    echo  "dependencies": {
    echo    "browser-sync": "^2.26.14"
    echo  }
    echo }
)>package.json && echo "/node_modules" > .dockerignore && (
    echo FROM node:15.8.0-alpine as build
    echo WORKDIR /.
    echo COPY package.json /.
    echo RUN npm install
    echo COPY . .
    echo FROM httpd:2.4
    echo COPY --from=build ./ /usr/local/apache2/htdocs/
) > Dockerfile && git init && echo node_modules > .gitignore && code . && browser-sync start --server --files 'style/*.css', '*.html', 'js/*.js' --port=5300 --no-notify
