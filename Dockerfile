FROM niis/harmony-ap:2.6.1@sha256:cdee9ca33182b0b4331068791a0fa48f546c0d2beca3a26edf15463e72eaab36
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
