# helm-charts

This is the central repository for all Helm charts used by the ShopHub platform, and is the infrastructure as code part of the project. Rather than each microservice carrying its own chart, every chart needed to deploy the platform lives here and is published as an OCI artifact, for example under `oci://ghcr.io/shophub-platform/helm-charts`, which the `kube-state` repository then references through ArgoCD Application resources.

## Structure

Under `charts/`, the `shophub` chart is the platform's main chart. It deploys the back end and front end applications along with an HPA, Ingress, Service, ServiceAccount, and Secret. Its `Chart.yaml` declares dependencies on the Bitnami `postgresql` chart for ShopHub's own database and on `shop-operator` as a subchart, so a single install brings up both the operator and its CRDs. The `shop-operator` chart, included as a subchart inside `shophub/charts/`, deploys the operator itself (ClusterRole, ServiceAccount, Deployment) and installs its CRDs (`shop.shophub.io_shops.yaml`, `_discordchannels.yaml`, `_wallets.yaml`). The `shop` chart is a template for a single Shop instance, covering ConfigMap, Deployment, Ingress, Secret, and Service; it is not installed manually, and is instead used internally by `shop-operator` when it provisions a new shop from a `Shop` custom resource. The `bitcoin` chart deploys a Bitcoin full node on testnet, used for on chain payment verification, with a Deployment, PVC, and Service. The `celestia` chart deploys a Celestia light node, acting as the data availability layer for the blockchain part of the platform, also with a Deployment, PVC, and Service.

Every chart follows the standard Helm layout, with `Chart.yaml`, `values.yaml`, and a `templates/` directory containing deployment, service, and where applicable ingress, hpa, and secret templates, plus `_helpers.tpl`, and a `NOTES.txt` in the `shophub` chart.

## Role in the architecture

This repository is the single source of truth for how every component of the ShopHub platform gets installed into Kubernetes. The `kube-state` repository then references these charts by name and version in OCI format and applies them through ArgoCD using GitOps, with `values.yaml` overrides specific to each cluster or environment.

## Technical stack

Charts use Helm v3 and are of type application, distributed through an OCI registry at `ghcr.io/shophub-platform/helm-charts`. Chart dependencies are managed through `Chart.yaml` and locked in `Chart.lock`; for example, the `shophub` chart pulls in the Bitnami `postgresql` chart and a local `shop-operator` subchart. The layout follows the project requirement that CRDs and the operator ship together with the `shophub` chart, while the `shop` chart remains an internal tool used by the operator rather than a standalone deployment.
