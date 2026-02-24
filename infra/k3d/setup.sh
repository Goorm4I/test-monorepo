#!/bin/bash
set -e

CLUSTER_NAME="timedeal"
CONFIG_FILE="$(dirname "$0")/cluster.yaml"

echo "=== k3d 클러스터 세팅 시작 ==="

# 의존성 확인
check_dependency() {
  if ! command -v "$1" &> /dev/null; then
    echo "[ERROR] $1 이 설치되어 있지 않습니다."
    echo "  설치 방법: README.md 참고"
    exit 1
  fi
}

check_dependency k3d
check_dependency kubectl
check_dependency helm

# 기존 클러스터 확인
if k3d cluster list | grep -q "^$CLUSTER_NAME"; then
  echo "[INFO] '$CLUSTER_NAME' 클러스터가 이미 존재합니다."
  echo "  삭제 후 재생성하려면: ./teardown.sh"
  exit 0
fi

# 클러스터 생성
echo "[1/3] 클러스터 생성 중..."
k3d cluster create --config "$CONFIG_FILE"

# 확인
echo "[2/3] 노드 상태 확인 중..."
kubectl wait --for=condition=Ready nodes --all --timeout=60s

# 로컬 레지스트리 hosts 등록 안내
echo "[3/3] 로컬 레지스트리 설정..."
if ! grep -q "timedeal-registry" /etc/hosts; then
  echo ""
  echo "[주의] 아래 명령어를 한 번만 실행해주세요 (관리자 권한 필요):"
  echo "  echo '127.0.0.1 timedeal-registry' | sudo tee -a /etc/hosts"
fi

echo ""
echo "=== 완료 ==="
kubectl get nodes
echo ""
echo "로컬 레지스트리: localhost:5001"
echo "Ingress:         http://localhost:8080"
