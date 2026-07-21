FROM niis/harmony-ap:2.6.2@sha256:1c174c9a816719520c019a763a19d64358dbc448300d1f779322d249eaf80a4e
USER root
RUN apt-get -qqy update \
 && apt-get -qqy upgrade \
 && apt-get -qqy install curl \
 && apt-get autoremove \
 && apt-get clean

COPY files/bin/* /opt/efti/bin/
RUN chmod -R a+rX /opt/efti/bin

COPY files/s6-overlay/ /etc/s6-overlay/s6-rc.d/

COPY files/lib/* /opt/harmony-ap/webapps/ROOT/WEB-INF/lib/

USER harmony-ap

VOLUME /var/opt/harmony-ap
VOLUME /tmp
VOLUME /run

ENTRYPOINT ["/opt/efti/bin/aggregate_entrypoint.sh"]
