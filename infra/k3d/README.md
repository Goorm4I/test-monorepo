# k3d 로컬 Kubernetes 환경

로컬에서 EKS와 동일한 K8s 환경을 구동합니다.

## 클러스터 구성

| 항목 | 값 |
|------|-----|
| 클러스터 이름 | timedeal |
| 서버 (Control Plane) | 1개 |
| 에이전트 (Worker) | 2개 |
| Ingress HTTP | localhost:8080 |
| Ingress HTTPS | localhost:8443 |
| 로컬 레지스트리 | localhost:5001 |

---

## 1. 사전 준비 (최초 1회)

### macOS

```bash
brew install k3d kubectl helm
```

### Windows (WSL2)

```bash
# k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

# helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

---

## 2. 클러스터 시작

```bash
cd infra/k3d
chmod +x setup.sh teardown.sh
./setup.sh
```

### 수동으로 하려면

```bash
k3d cluster create --config infra/k3d/cluster.yaml

# hosts 등록 (최초 1회)
echo '127.0.0.1 timedeal-registry' | sudo tee -a /etc/hosts
```

---

## 3. 상태 확인

```bash
# 노드 확인
kubectl get nodes

# 예상 출력:
# NAME                     STATUS   ROLES
# k3d-timedeal-server-0    Ready    control-plane
# k3d-timedeal-agent-0     Ready    <none>
# k3d-timedeal-agent-1     Ready    <none>
```

---

## 4. 로컬 이미지 빌드 & 배포

```bash
# 이미지 빌드
docker build -t timedeal-registry:5001/order-service:latest ./backend/order-service

# 레지스트리에 push
docker push timedeal-registry:5001/order-service:latest

# K8s에서 사용할 때 이미지 주소
# image: timedeal-registry:5001/order-service:latest
```

---

## 5. 클러스터 종료 / 삭제

```bash
# 일시 중지 (데이터 유지)
k3d cluster stop timedeal

# 재시작
k3d cluster start timedeal

# 완전 삭제
./teardown.sh
```

---

## 자주 쓰는 명령어

```bash
k3d cluster list              # 클러스터 목록
kubectl get pods -A           # 전체 네임스페이스 파드 확인
kubectl get svc -A            # 서비스 목록
kubectl logs <pod-name>       # 파드 로그
kubectl describe pod <name>   # 파드 상세 정보
```
