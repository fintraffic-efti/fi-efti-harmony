FROM niis/harmony-ap:2.4.0@sha256:da7a20d9409573f26466da1d5f8c1dd817415158f691f46e139e89c6e98c8476

USER root
RUN apt-get -qqy update \
 && apt-get -qqy upgrade \
 && apt-get -qqy install curl \
 && apt-get autoremove \
 && apt-get clean

COPY files/bin/* /opt/efti/bin/
RUN chmod -R a+rX /opt/efti/bin

COPY files/lib/* /opt/harmony-ap/webapps/ROOT/WEB-INF/lib/

USER harmony-ap

VOLUME /var/opt/harmony-ap
VOLUME /tmp

ENTRYPOINT ["/opt/efti/bin/aggregate_entrypoint.sh"]
