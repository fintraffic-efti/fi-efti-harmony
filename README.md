# eFTI Harmony Docker Image

This image enhances [Harmony docker image](https://github.com/nordic-institute/harmony-common/blob/main/packaging/ap/docker/Dockerfile) with automatic pmode upload. See [compose.yml](compose.yml) for usage example. 

## Development

Launch example setup with:
```shell
./start.sh
```

Verify pmode upload from logs or: https://localhost:10443/pmode-current (harmony/efti)
