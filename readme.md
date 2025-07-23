# Local GitOps Demo with Kubernetes (kind) & Argo CD

This project demonstrates a fully automated **GitOps** workflow using a local **Kubernetes** cluster. It showcases how modern cloud-native applications are deployed and managed declaratively.

## Architecture & Workflow

1.  **Cluster Creation**: A local Kubernetes cluster is provisioned in seconds using **kind** (Kubernetes in Docker).
2.  **GitOps Tooling**: **Argo CD**, a declarative GitOps engine, is installed into the cluster.
3.  **Deployment**: The user applies a single YAML file (`argocd-app.yaml`) to Argo CD. This file tells Argo CD to monitor a public Git repository.
4.  **Automated Sync**: Argo CD automatically pulls the Kubernetes manifests from the target repository and deploys the "guestbook" application. It continuously monitors the repository, and any changes committed to the Git repo are automatically applied to the cluster.

## How to Run This Demo

**Prerequisites**: You must have [Docker](https://www.docker.com/products/docker-desktop/) and [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) installed.

1.  Clone this repository.
2.  Make the setup script executable:
    ```bash
    chmod +x setup.sh
    ```
3.  Run the script:
    ```bash
    ./setup.sh
    ```
4.  Once the script finishes, access the Argo CD UI at `https://localhost:8080`. Log in with the username `admin` and the password provided by the script.
5.  To deploy the sample application, apply the `argocd-app.yaml` manifest using the Argo CD UI or CLI.
