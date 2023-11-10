# k8s-helm-mern

Deploy express+mongo app in k8s with helm and kubeapps

## Prerequisites

- Dockerhub account created [Dockerhub](https://hub.docker.com/)
- Docker-compose installed [docker](https://docs.docker.com/compose/install/)
- Docker desktop (MAC or WINDOW) [docker](https://docs.docker.com/get-docker/)
- Minikube [minikube](https://minikube.sigs.k8s.io/docs/start/)
- Helm [helm](https://helm.sh/docs/intro/install/)


## Installation

Clone project

```bash
  git https://github.com/evandjefie/k8s-helm-mern.git
  cd k8s-helm-mern
```

Launch minikube (kubernetes)

```bash
  minikube start --driver=docker
```

Install kubeapps

```bash
  helm repo add bitnami https://charts.bitnami.com/bitnami
```

```bash
  helm install -n kubeapps --create-namespace kubeapps bitnami/kubeapps
```

## Setup

- Follow instructions to connect to kubeapps [here](https://kubeapps.dev/)

- Deploy mongodb from kubeapps GUI

- Follow run.sh instructions to Deploy express api


## Follow me
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://evandjefie.my.canva.site)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/evan-djefie)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/EvanDjefie)