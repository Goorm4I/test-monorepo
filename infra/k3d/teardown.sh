#!/bin/bash
set -e

CLUSTER_NAME="timedeal"

echo "=== '$CLUSTER_NAME' 클러스터 삭제 ==="
k3d cluster delete "$CLUSTER_NAME"
echo "완료."
