FROM node:latest 

WORKDIR /app

RUN apt-get update && apt-get install -y sudo jq git
RUN npm install -g pnpm only-allow

ENV BRIDGE_REPO=https://github.com/justpandaever/op-stack-bridge.git
ENV BRIDGE_BRANCH=feature/migrate-viem

RUN git clone $BRIDGE_REPO --depth 1 --branch $BRIDGE_BRANCH --single-branch . && \
    git switch -c branch-$BRIDGE_BRANCH && \
    yarn install && yarn build
