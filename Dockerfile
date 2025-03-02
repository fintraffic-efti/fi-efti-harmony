FROM niis/harmony-ap:2.5.0@sha256:641a9bd5cef528d75bcb566129379f65a3e37ff8ba0240e9308461f8948e1acf

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
