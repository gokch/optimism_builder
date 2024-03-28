#!/bin/bash
set -eu

echo "[4/5] : deploy contract"
# base gas 너무 높으면 디플로이 하다가 실패할 수 있음..( 대략 50 gwei 이상부터 )
# TODO : base gas 낮은거 확인하고 배포하는 얼럿 추가?

cd ~/optimism/packages/contracts-bedrock && \
forge script scripts/Deploy.s.sol:Deploy \
    --private-key "$GS_ADMIN_PRIVATE_KEY" \
    --broadcast \
    --rpc-url "$L1_RPC_URL" \
    --slow