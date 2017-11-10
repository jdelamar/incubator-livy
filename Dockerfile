FROM gcr.io/npav-172917/spark-2.2.0-hadoop-2.7:latest

RUN apt-get update && \
    apt-get install -y bc vim wget git maven python-dev \
                       libkrb5-dev gcc r-base r-base-dev \
                       libsnappy1.0.3-java python3 python3-dev && \
    apt-get clean 

RUN pip install setuptools pyhocon cloudpickle requests requests-kerberos flake8 flaky pytest

COPY . /opt/apache-livy-src

# Apache livy has a cute little feature that checks for Apache licenses on all file. We don't want to add that
# to our docker file and makefile, so lets just remove them from the build :)
RUN cd  /opt/apache-livy-src && rm Dockerfile* Makefile 

RUN cd /opt/apache-livy-src && \
  mvn package

ENV PATH /opt/sbt/bin:$PATH


EXPOSE 8090 9999 

#COPY ./docker-entrypoint.sh /
#RUN chmod +x /docker-entrypoint.sh
#
#ENTRYPOINT ["/docker-entrypoint.sh"]



