data "kubectl_file_documents" "dynakuberc" {
    content = file(var.dt_dynakube_resource_def)
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

//Execute Helm Chart
resource "helm_release" "dynatrace-operator" {
  namespace  = "dynatrace"
  name       = "dynatrace-operator"
  repository = var.dt_chart
  chart      = "dynatrace-operator"
  set {
    name  = "installCRD"
    value = "true"
  }
}

//Create CR via defined yaml
resource "kubectl_manifest" "dynakube_yaml" {
  depends_on = [
    helm_release.dynatrace-operator
  ]
    for_each  = data.kubectl_file_documents.dynakuberc.manifests
    yaml_body = each.value
  }


