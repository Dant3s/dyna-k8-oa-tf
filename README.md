# Dynatrace Terraform OA Deploy

This is a simple terraform configuration, to deploy the OA in FS mode using the helm chart Operator and the CR.

# Requirments

This works with 3 Providers:

* hashicorp/http 
    To Reach and download the cr.

* gavinbunney/kubectl
    To execute the kubectl creation of the cr.

* hashicorp/helm
    To handle the Helm chart.


# Disclaimer

This is just to test the deployment via TF of the HC. Needs to be extendend/hacked to allow more use cases.

Cheers.