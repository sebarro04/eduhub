FROM python:3.10.7-slim-bullseye

EXPOSE 5000
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update -y
RUN apt-get install curl gnupg -y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update -y
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18

# to blob 
RUN sudo apt install python3-pip
RUN pip install azure-storage-blob
RUN pip install azure-storage-blob azure-identity   

WORKDIR /app

COPY app/. .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD [ "flask",  "--__init__", "__init__", "run", "--host=0.0.0.0" ]