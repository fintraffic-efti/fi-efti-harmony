FROM niis/harmony-ap:2.6.0@sha256:09a3bebef20ab7d3a0555088cba612567b54458d05767ef39a65407b4215e13d
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

ENTRYPOINT ["/opt/efti/bin/aggregate_entrypoint.sh"]
