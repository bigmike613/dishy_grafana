#Use to rebuild the docker image if https://github.com/sparky8512/starlink-grpc-tools.git is ever updated.

FROM python:3.9
LABEL maintainer="neurocis <neurocis@neurocis.me>"

RUN true && \
\
ARCH=`uname -m`; \
if [ "$ARCH" = "armv7l" ]; then \
    NOBIN_OPT="--no-binary=grpcio"; \
else \
    NOBIN_OPT=""; \
fi; \
# Install python prerequisites
pip3 install --no-cache-dir $NOBIN_OPT \
    croniter==2.0.5 pytz==2024.1 six==1.16.0 \
    grpcio==1.62.2 \
    influxdb==5.3.2 certifi==2024.2.2 charset-normalizer==3.3.2 idna==3.7 \
        msgpack==1.0.8 requests==2.31.0 urllib3==2.2.1 \
    influxdb-client==1.42.0 reactivex==4.0.4 \
    paho-mqtt==2.0.0 \
    pypng==0.20220715.0 \
    python-dateutil==2.9.0 \
    typing_extensions==4.11.0 \
    yagrc==1.1.2 grpcio-reflection==1.62.2 protobuf==4.25.3

WORKDIR /app
RUN git clone https://github.com/sparky8512/starlink-grpc-tools.git
RUN cp  -r starlink-grpc-tools/* /app/ 


ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
CMD ["dish_grpc_influx.py status alert_detail"]
