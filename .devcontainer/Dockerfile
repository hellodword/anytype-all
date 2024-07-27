FROM ghcr.io/hellodword/devcontainers-images-go-and-node

# https://github.com/bengreenier/browserd/blob/master/components/stream-provider/Dockerfile
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2 libegl1 libgl1-mesa-dri xvfb xauth \
  packagekit-gtk3-module \
  libsecret-1-0 gnome-keyring dbus-x11 \
  xdg-utils rpm \
  protobuf-compiler libprotoc-dev

ENV ELECTRON_SKIP_SENTRY=1
ENV SERVER_PORT=31000
