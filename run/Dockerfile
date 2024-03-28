FROM golang:1.22 as op

WORKDIR /app

ENV OP_REPO=https://github.com/ethereum-optimism/optimism.git
ENV OP_VERSION=${OP_VERSION:-v1.7.2}

RUN git clone $OP_REPO --branch op-node/$OP_VERSION --single-branch . && \
    git switch -c branch-$OP_VERSION

RUN make -C op-node VERSION=$OP_VERSION op-node
RUN make -C op-batcher VERSION=$OP_VERSION op-batcher
RUN make -C op-proposer VERSION=$OP_VERSION op-proposer

FROM golang:1.22 as geth

WORKDIR /app

ENV GETH_REPO=https://github.com/ethereum-optimism/op-geth.git
ENV GETH_VERSION=${GETH_VERSION:-v1.101308.2}

RUN git clone $GETH_REPO --branch $GETH_VERSION --single-branch . && \
    git switch -c branch-$GETH_VERSION && \
    make geth

FROM golang:1.22

WORKDIR /app

RUN apt-get update && \
    apt-get install -y sudo jq curl && \
    rm -rf /var/lib/apt/lists

COPY --from=op /app/op-node/bin/op-node ./
COPY --from=op /app/op-batcher/bin/op-batcher ./
COPY --from=op /app/op-proposer/bin/op-proposer ./
COPY --from=geth /app/build/bin/geth ./
COPY entrypoint-init .
COPY entrypoint-geth .
COPY entrypoint-op-node .
COPY entrypoint-op-batcher .
COPY entrypoint-op-proposer .