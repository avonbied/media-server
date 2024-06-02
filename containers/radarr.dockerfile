# syntax=docker/dockerfile:1
FROM alpine:latest

RUN sudo apt install curl sqlite3
RUN wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64' \
    tar -xvzf Radarr*.linux*.tar.gz \
    sudo mv Radarr /opt/
RUN sudo chown radarr:radarr -R /opt/Radarr

# Create Radarr service file
RUN cat << EOF | sudo tee /etc/systemd/system/radarr.service > /dev/null \
COPY radarr.service /etc/systemd/system/radarr.service

# Set systemd daemon
RUN sudo systemctl -q daemon-reload && sudo systemctl enable --now -q radarr
# Cleans up TAR
RUN rm Radarr*.linux*.tar.gz

EXPOSE 7878

ENTRYPOINT sh