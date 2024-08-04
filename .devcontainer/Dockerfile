FROM ghcr.io/hellodword/devcontainers-images-go-and-node

# https://github.com/bengreenier/browserd/blob/master/components/stream-provider/Dockerfile
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgtk-3-0 libgbm1 libasound2 libegl1 libgl1-mesa-dri xvfb xauth \
  packagekit-gtk3-module \
  libsecret-1-0 gnome-keyring dbus-x11 \
  xdg-utils rpm \
  protobuf-compiler libprotoc-dev

RUN go install github.com/extism/cli/extism@latest && \
  mkdir -p /tmp/js-pdk-install && cd /tmp/js-pdk-install && \
  curl -fsSL --output install.sh https://raw.githubusercontent.com/extism/js-pdk/main/install.sh && \
  sh install.sh && cd / && rm -rf /tmp/js-pdk-install

RUN cd /tmp && \
  wget https://github.com/tinygo-org/tinygo/releases/download/v0.32.0/tinygo_0.32.0_amd64.deb && \
  sudo dpkg -i /tmp/tinygo_0.32.0_amd64.deb &&
  rm /tmp/tinygo_0.32.0_amd64.deb

ENV ELECTRON_SKIP_SENTRY=1
ENV SERVER_PORT=31000
