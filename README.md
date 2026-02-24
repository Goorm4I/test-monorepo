# timedeal-project

타임딜 이커머스 플랫폼 모노레포

## 프로젝트 구조

```
test-monorepo/
├── backend/            # 백엔드 서비스
│   ├── order-service/  # 주문 서비스
│   └── ...
├── frontend/           # 프론트엔드
├── infra/              # 인프라 설정
│   ├── docker-compose.yaml
│   ├── k3d/            # 로컬 K8s 환경
│   ├── helm/           # Helm 차트
│   └── terraform/      # AWS 인프라 코드
└── README.md
```

## 로컬 환경 실행

```bash
# 전체 스택 실행
docker compose -f infra/docker-compose.yaml up -d
```

## 브랜치 전략

```
main
 └── develop
      ├── feature/backend-*
      ├── feature/frontend-*
      └── feature/infra-*
```

- `main`: 프로덕션 배포 브랜치
- `develop`: 개발 통합 브랜치
- `feature/*`: 기능 개발 브랜치 (PR → develop)
