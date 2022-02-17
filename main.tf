data "http" "dynakube" {
  url = var.dt_dynakube_resource
}

resource "kubectl_manifest" "dynakube_yaml" {
  yaml_body = data.http.dynakube.body
}

resource "helm_release" "dynatrace-operator" {
  create_namespace = true
  namespace        = "dynatrace"
  name             = "dynatrace-operator"
  repository       = "https://raw.githubusercontent.com/Dynatrace/helm-charts/master/repos/stable"
  chart            = "dynatrace-operator"
  set {
    name = "classicFullStack.enabled"
    value = "true"
  }
  set{
      name = "activeGate.capabilities"
      value = "{routing}"
  }
  set {
    name = "skipCertCheck"
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
    name = "paasToken"
    value = var.dt_paas_token
  }
}
