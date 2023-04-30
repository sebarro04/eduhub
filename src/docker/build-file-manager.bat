cd file-manager

docker login

@echo off
set /p "username=Enter your docker username = "

docker build -t %username%/file-manager:latest .
docker push %username%/file-manager:latest