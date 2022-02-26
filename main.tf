data "http" "dynakube" {
  url = var.dt_dynakube_resource
}

resource "kubectl_manifest" "dynakube_yaml" {
  yaml_body = data.http.dynakube.body
}

//Add Automatic AG connection via local AG.
resource "kubectl_manifest" "dynakube_ag_auto" {
  yaml_body = <<YAML
    apiVersion: dynatrace.com/v1beta1
    kind: DynaKube
    metadata:
      name: ${var.dynakubeName}
      namespace: dynatrace
      annotations:
        alpha.operator.dynatrace.com/feature-automatic-kubernetes-api-monitoring: "true"
        alpha.operator.dynatrace.com/disable-metadata-enrichment: "false"
  YAML
  depends_on = [
    kubectl_manifest.dynakube_yaml
  ]
}

resource "helm_release" "dynatrace-operator" {
  create_namespace = true
  namespace        = "dynatrace"
  name             = "dynatrace-operator"
  repository       = "https://raw.githubusercontent.com/Dynatrace/helm-charts/master/repos/stable"
  chart            = "dynatrace-operator"
  set {
    name = "name"
    value = var.dynakubeName
  }
  set {
    name  = "classicFullStack.enabled"
    value = "true"
  }
  set {
    name  = "activeGate.capabilities"
    value = "{routing}"
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
