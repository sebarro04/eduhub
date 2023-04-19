cd api

docker login

@echo off
set /p "username=Enter your docker username = "

docker build -t %username%/edubub:latest .
docker push %username%/edubub:latest