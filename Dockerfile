
FROM python:3.12-slim

ENV SSH_PASSWD=root:Docker!

WORKDIR /app

COPY ./hello /app/hello
COPY hello/requirements.txt /app/requirements.txt
#COPY hello/.env .env we have no .env in our github repo

# SSH
RUN apt-get update && \
    apt-get install -y openssh-server --no-install-recommends && \
    mkdir -p /var/run/sshd && \
    echo "$SSH_PASSWD" | chpasswd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# SSH yapılandırması
RUN mkdir /root/.ssh

# 8000 Flask, 2222 SSH

EXPOSE 8000 2222

# Run SSHD in background, then start gunicorn
CMD bash -c "/usr/sbin/sshd && exec gunicorn --timeout 120 --bind 0.0.0.0:8000 hello.hello:app"
