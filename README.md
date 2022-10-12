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


dt_dynakube_resource_def = For DynaKube Resource

dt_chart             = For Chart Definition.

k8context            = For K8 Cluster Context

k8configpath         = For K8 config file (ex ~/.kube/config)

This was last tested with 0.8.2 and crd for 0.9.0 with Auth token ff.

Simple Usage/testing:

Have in dir:

*   dynakube.yaml -> full definition of crd
*   terraform.tfvars -> definition of dt_chart, dt_dynakube_resource_def, k8context and k8configpath. 


# Disclaimer

This is just to test the deployment via TF of the HC. Needs to be extendend/hacked to allow more use cases.

Creating it just for fun.

Cheers.