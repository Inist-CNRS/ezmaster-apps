FROM ollama/ollama:0.3.0

# ----------------------------------------------- #
# ezMaster configuration                          #
# ----------------------------------------------- #
EXPOSE 11434
RUN echo '{ \
  "httpPort": 11434, \
  "dataPath": "/usr/share/ollama/", \
  "configPath": "/tmp/config.json", \
  "technicalApplication": false \
  }' > /etc/ezmaster.json
# ----------------------------------------------- #
