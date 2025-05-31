
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

# init cmd
COPY init.sh /usr/local/bin/init.sh
RUN dos2unix /usr/local/bin/init.sh && chmod +x /usr/local/bin/init.sh

# 8000 Flask, 2222 SSH
ENV PORT 8000
ENV SSH_PORT 2222
EXPOSE 8000 2222


CMD ["/usr/local/bin/init.sh"]
