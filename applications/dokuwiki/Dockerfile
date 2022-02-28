FROM crazymax/dokuwiki:2020-07-29

# ----------------------------------------------- #
# ezMaster configuration                          #
# ----------------------------------------------- #
EXPOSE 8000
RUN echo '{ \
  "httpPort": 8000, \
  "dataPath": "/data", \
  "configPath": "/tmp/config.json" \
}' > /etc/ezmaster.json
# ----------------------------------------------- #
