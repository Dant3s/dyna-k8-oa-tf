# Dynatrace Terraform OA Deploy

This is a simple terraform configuration, to deploy the OA in FS mode using the helm chart Operator and the CR.

# Requirements

This works with 3 Providers:

* hashicorp/http 
    To Reach and download the cr.

* gavinbunney/kubectl
    To execute the kubectl creation of the cr.

* hashicorp/helm
    To handle the Helm chart.

In case of addition Configuration, the Helm Chart Default values.yaml has a good start of options that can be used to do a few changes to the configuration (Ex: add k8 monitoring to AG)

# Vars

This use the following Variables:

dt_api_token         = ApiToken

dt_paas_token        = PaaS Token

dt_api_url           = Enfiroment /api url 

dt_dynakube_resource = For DynaKube Resource Should be https://github.com/Dynatrace/dynatrace-operator/releases/download/v0.4.2/dynatrace.com_dynakubes.yaml also in the documentation.

k8context            = For K8 Cluster Context

k8configpath         = For K8 config file (ex ~/.kube/config)

This was NOT tested with the Api Access Token with Api & PaaS.

# Disclaimer

This is just to test the deployment via TF of the HC. Needs to be extendend/hacked to allow more use cases.

Creating it just for fun.

Cheers.