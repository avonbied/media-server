# syntax=docker/dockerfile:1
FROM alpine:latest

RUN apk update && apk --no-cache add curl sqlite3
RUN wget -O Radarr.linux.tar.gz 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64' \
    tar -xvzf Radarr*.linux*.tar.gz \
    mv Radarr /opt/

RUN addgroup radarr &&\
    adduser -D -G radarr radarr &&\
    chown radarr:radarr -R /opt/Radarr

# Create Radarr RC file
COPY radarr.conf /etc/conf.d/

# Start Service
RUN rc-service --list |\
    rc-update add radarr default

# Cleans up TAR
RUN rm Radarr*.linux*.tar.gz

EXPOSE 7878

ENTRYPOINT sh