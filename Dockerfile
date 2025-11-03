FROM ubuntu
ENV TZ=Europe/Berlin
copy ./xmas3.pas /
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  && \
apt-get update && \
apt-get -y upgrade && \
apt-get install -y fpc && \
/usr/bin/fpc /xmas3.pas && \
apt-get purge -y fpc && \
apt-get autoremove -y
ENTRYPOINT ["/xmas3"]
