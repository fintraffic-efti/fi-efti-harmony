FROM niis/harmony-ap:2.2.0

USER root
RUN apt-get -qqy update \
 && apt-get -qqy install curl \
 && apt-get autoremove \
 && apt-get clean

COPY files/bin/* /opt/efti/bin/
RUN chmod -R a+rX /opt/efti/bin \
  && chmod 755 /opt/harmony-ap/plugins/config \
  && chown harmony-ap:harmony-ap /opt/harmony-ap/plugins/config

USER harmony-ap

ENTRYPOINT ["/opt/efti/bin/aggregate_entrypoint.sh"]
