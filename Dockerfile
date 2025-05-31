
FROM python:3.12-slim


WORKDIR /app

COPY ./hello /app/hello
COPY hello/requirements.txt requirements.txt
#COPY hello/.env .env we have no .env in our github repo

# SSH
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# SSH yapılandırması
RUN mkdir /var/run/sshd

# 8000 Flask, 22 SSH
EXPOSE 8000 22


CMD ["python", "hello/hello.py"]
