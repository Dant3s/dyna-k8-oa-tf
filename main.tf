data "http" "dynakube" {
  url = var.dt_dynakube_resource
}

//Create NS
resource "kubectl_manifest" "dynaNs" {
  yaml_body = <<YAML
    apiVersion: v1
    kind: Namespace
    metadata:
      name: dynatrace
  YAML
}

//Create CRD Via Helm Chart Spec.
resource "kubectl_manifest" "dynakube_yaml" {
  depends_on = [
    kubectl_manifest.dynaNs
  ]
  yaml_body = data.http.dynakube.body
}

//Execute Helm Chart
resource "helm_release" "dynatrace-operator" {
  namespace  = "dynatrace"
  name       = "dynatrace-operator"
  repository = "https://raw.githubusercontent.com/Dynatrace/helm-charts/master/repos/stable"
  chart      = "dynatrace-operator"
  set {
    name  = "name"
    value = var.dynakubeName
  }
  set {
    name  = "classicFullStack.enabled"
    value = "true"
  }
  set {
    name  = "activeGate.capabilities"
    value = "{kubernetes-monitoring,routing}"
  }
  set {
    name  = "activeGate.resources.limits.cpu"
    value = "300m"
  }
  set {
    name  = "activeGate.resources.limits.memory"
    value = "1G"
  }
  set {
    name  = "activeGate.resources.requests.cpu"
    value = "150m"
  }
  set {
    name  = "activeGate.resources.requests.memory"
    value = "250Mi"
  }
  set {
    name  = "skipCertCheck"
    value = "true"
  }
  set {
    name  = "apiUrl"
    value = var.dt_api_url
  }
  set {
    name  = "apiToken"
    value = var.dt_api_token
  }
  set {
    name  = "paasToken"
    value = var.dt_paas_token
  }
}

//Add Automatic AG connection via local AG Annotations to dynakube.
resource "kubectl_manifest" "dynakube_ag_auto" {
depends_on = [
    helm_release.dynatrace-operator
  ]
  yaml_body = <<YAML
apiVersion: dynatrace.com/v1beta1
kind: DynaKube
metadata:
  name: dynakube
  namespace: dynatrace
  annotations:
    alpha.operator.dynatrace.com/feature-automatic-kubernetes-api-monitoring: "true"
  YAML
}
