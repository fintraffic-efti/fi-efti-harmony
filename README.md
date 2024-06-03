# eFTI Harmony Docker Image

This image enhances
[Harmony docker image](https://github.com/nordic-institute/harmony-common/blob/main/packaging/ap/docker/Dockerfile)
with automatic pmode and keystore/truststore upload. See [compose.yml](compose.yml) for usage example.

## Utilities

### Creating keystores and truststores for a pair of harmony instances
```shell
scripts/create-stores-for-pair.sh h1/stores h1 harmony-h1 h2/stores h2 harmony-h2
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

Launch example setup of two harmony instances with:

```shell
./start.sh
```

Harmony uis are available at:
* h1: https://localhost:10443
* h2: https://localhost:10444

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
* Sender h2, receiver h1: https://localhost:10444/connections
