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

# Replace tenforce's script (modified loading)
# ADD virtuoso.sh /virtuoso.sh
# ADD config2ini.py /config2ini.py
