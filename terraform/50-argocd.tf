module "argocd" {
  source  = "aigisuk/argocd/kubernetes"
  version = "0.2.7"

  argocd_chart_version = "6.7.1"
  namespace            = "argocd"
}