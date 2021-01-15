FROM openjdk:8

ARG APP_PATH="/app"
ARG DATA_PATH="/data"
ARG APP_USER="app"
ARG GRAPHHOPPER_VERSION="2.3"

ENV APP_PATH="${APP_PATH}" \
    APP_USER="${APP_USER}" \
    DATA_PATH="${DATA_PATH}" \
    GRAPHHOPPER_VERSION="${GRAPHHOPPER_VERSION}"

RUN mkdir -p $DATA_PATH && \
    mkdir -p $APP_PATH && \
    wget -O $APP_PATH/graphhopper-web.jar https://graphhopper.com/public/releases/graphhopper-web-${GRAPHHOPPER_VERSION}.jar

RUN apt-get update && \
      apt-get install -y --no-install-recommends gosu && \
      rm -rf /var/lib/apt/lists/* && \
      gosu nobody true

COPY /config.yml $APP_PATH/config.yml

COPY /scripts/entrypoint.sh /usr/sbin/entrypoint
RUN chmod a+x /usr/sbin/entrypoint

COPY /scripts/set-app-permissions.sh /usr/sbin/set-app-permissions
RUN chmod a+x /usr/sbin/set-app-permissions

COPY /scripts/download-data.sh /usr/sbin/download-data
RUN chmod a+x /usr/sbin/download-data

COPY /scripts/start-app.sh /usr/sbin/start-app
RUN chmod a+x /usr/sbin/start-app

RUN useradd --shell /bin/bash --no-log-init -c "" -m $APP_USER
RUN echo 'PATH=$PATH:/usr/local/openjdk-8/bin' >> /home/$APP_USER/.bashrc

WORKDIR $APP_PATH

ENTRYPOINT [ "bash", "--login", "/usr/sbin/entrypoint" ]
CMD        [ "bash", "--login" ]

EXPOSE 8989
    