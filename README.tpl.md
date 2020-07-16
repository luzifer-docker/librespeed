# Luzifer-docker / librespeed

This is a container setup for the [Go variant](https://github.com/librespeed/speedtest-go) of the [LibreSpeed speed test](https://librespeed.org/), fully configurable through environment variables and runnable out-of-the-box.

For security reasons the statistics password will be auto-generated every run of the container if not explicitly set.

To use your own configuration file make it available in the container as `/etc/speedtest/settings.toml` which will disable the config generator.

## Available configuration variables

For reference please refer to the [config example](https://github.com/librespeed/speedtest-go/blob/master/settings.toml) in the upstream repo.

| ENV Variable | Default Value |
| ------------ | ------------- |
