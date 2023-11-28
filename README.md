# Simple Terraform AWS Infrastructure

이 문서는 AWS 상에 EC2 인스턴스, 타겟 그룹, 로드 밸런서 규칙 및 Route 53 설정을 자동으로 구성하는 Terraform 코드에 대한 가이드입니다.

## 개요

본 Terraform 구성은 다음의 리소스를 생성 및 관리합니다:

- **EC2 인스턴스**: 애플리케이션을 호스팅하는 가상 서버.
- **타겟 그룹**: 로드 밸런서가 트래픽을 전송할 EC2 인스턴스 그룹.
- **로드 밸런서 규칙**: 트래픽을 적절한 타겟 그룹으로 라우팅.
- **Route 53 설정**: 도메인 이름을 로드 밸런서와 연결.

## 시작하기 전에

이 코드를 실행하기 전에 AWS 계정 및 Terraform이 설치되어 있어야 합니다.

### 필요 조건

- AWS 계정 및 관리자 접근 권한
- Terraform v1.0+

### 구성

`variables.tf` 파일을 통해 사용자 정의 변수를 받습니다. 필요한 변수들은 다음과 같습니다:

- vpc id
- ami
- key name
- lb_name
- target_port
- sub_domain
- domain_name

`env.tf` 파일을 통해 AWS 관련 key 변수를 받습니다.

- access_key
- secret_key
- region

## 사용 방법

1. **init**: Terraform 초기화를 위해 아래 명령어를 실행합니다: `terraform init`
2. **plan**: Terraform이 수행할 작업을 미리 볼 수 있습니다: `terraform plan`
3. **apply**: Terraform을 사용하여 인프라를 배포합니다:: `terraform apply`
4. **destroy**: 더 이상 리소스가 필요 없을 때는 다음 명령어로 리소스를 제거할 수 있습니다:: `terraform destroy`

## 주의 사항

- 이 구성은 예제를 위한 것이므로, 실제 프로덕션 환경에 적용하기 전에 보안 및 접근성을 고려해야 합니다.
- AWS 비용이 발생할 수 있으므로, 리소스 사용에 주의하세요.
