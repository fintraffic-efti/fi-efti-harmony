FROM niis/harmony-ap:2.4.0

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
