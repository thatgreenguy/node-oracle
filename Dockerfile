FROM node:10-slim
COPY *.zip ./
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y libaio1 unzip \
  && mkdir -p /opt/oracle \
  && unzip "*.zip" -d /opt/oracle \
  && mv /opt/oracle/instantclient_19_3 /opt/oracle/instantclient \
  && rm *.zip \
  && apt-get remove -y --purge unzip \
  && apt-get autoremove -y --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
  
ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"

RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig