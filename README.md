# eFTI Harmony Docker Image

This image enhances
[Harmony docker image](https://github.com/nordic-institute/harmony-common/blob/main/packaging/ap/docker/Dockerfile)
with automatic pmode and keystore/truststore upload. See [compose.yml](compose.yml) for usage example.

## Development

Launch example setup with:

```shell
./start.sh
```

Harmony ui is available at https://localhost:10443. Login with:
* user: harmony
* password: efti

Verify pmode upload from logs or:
* https://localhost:10443/pmode-current 

Verify keystore/truststore uploads from:
* https://localhost:10443/keystore
* https://localhost:10443/truststore
* https://localhost:10443/tlstruststore
