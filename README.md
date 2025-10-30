# eFTI Harmony Docker Image

This image enhances
[Harmony docker image](https://github.com/nordic-institute/harmony-common/blob/main/packaging/ap/docker/Dockerfile)
with:

* Automatic upload of pmode.xml and keystore/truststore files
* Passing pmode.xml and keystore/trustore contents via environment variables as base64 encoded binaries
* Json logging support via [logstash-logback-encoder](https://github.com/logfellow/logstash-logback-encoder) and
  passing logback.xml via environment variable

See [compose.yml](compose.yml) for usage example.

To start a development setup via docker compose, just run the start script (see [Development](#development) for details):
```shell
./start.sh
````

## Environment variables

This image supports passing specific configuration files via environment variables as base64 encoded strings.

* EFTI_WSPLUGIN_PROPERTIES_BASE64 - wsplugin.properties
* EFTI_LOGBACK_XML_BASE64 - (optional) logback.xml

## Utilities

### Creating keystores and truststores for a pair of harmony instances
```shell
scripts/create-stores-for-pair.sh local/h1/stores h1 harmony-h1 local/h2/stores h2 harmony-h2
```

Where:
* `h1/stores` - directory for instance 1 store files
* `h1` - party name for instance 1 in pmode configuration
* `harmony-h1` - domain name for instance 1

Passphrases are of the format:
* ap-keystore.p12: `ap-keystore-<party name>`
* ap-truststore.p12: `ap-truststore-<party name>`
* tls-keystore.p12: `tls-keystore-<party name>`
* tls-truststore.p12: `tls-truststore-<party name>`

### Reviewing store contents
```shell
scripts/dump-stores.sh local h1
```

Where:
* `local` - Root dir for instances
* `h1` - Instance name under that root dir

### Building the image for local testing
Build the image with the following command:
```shell
./build.sh 
```

## Development

In [compose.yml](compose.yml) there is a local development setup:

* Harmony 1 (h1) - Regular harmony instance, not behind a load balancer
* Harmony 2 (h2) - Cluster of two harmony instances, behind a load balancer (nginx)

Launch the setup with:
```shell
./start.sh
```

Harmony uis are available at:
* h1: https://localhost:10443
* h2: http://localhost:10444 (NOTE: http)

Login with:
* user: harmony
* password: efti

Verify pmode upload from logs or:
* https://localhost:10443/pmode-current

Verify keystore/truststore uploads from:
* https://localhost:10443/keystore
* https://localhost:10443/truststore
* https://localhost:10443/tlstruststore

Verify connection between the two instances by clicking "Send" for either:
* Sender h1, receiver h2: https://localhost:10443/connections
* Sender h2, receiver h1: http://localhost:10444/connections

## Known limitations

* After changing EXTRENAL_LB from true to false on an existing container and restarting the container, harmony
  does not start/respond (message "Harmony is unavailable - sleeping" can be seen repeated in logs)
* Changes to stores do not necessarily be taken into use after container restart
