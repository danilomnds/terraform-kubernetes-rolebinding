# Module - Role binding k8s
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the creation of role bindings in K8S environments.

## Dependency

For the default use case, this module depends on the module [https://dev.azure.com/timbrasil/Projeto_IaC/_git/k8s-module-role](https://dev.azure.com/timbrasil/Projeto_IaC/_git/k8s-module-role). 

The role binding will point to the role created by the module reffered above.


## Compatibility matrix

| Module Version | Terraform Version | Kubernetes Provider Version |
|----------------|-------------------| --------------------------- |
| v1.0.0         | v1.3.6            | 2.17.0                      |

## Specifying a version

To avoid that your code get automatically updates for the module is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can use a specific version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case for the creation of role bindings for the standard role.
```hcl
module "<clustername>-rolebinding" {
  source = "git::https://github.com/danilomnds/terraform-kubernetes-rolebinding?ref=v1.0.0"  
  subjects = {
    <group name> = {
      name      = "<group id>"
      kind      = "Group"
      api_group = "rbac.authorization.k8s.io"
      namespace = "<namespace>"
    }
    <service account name> = {
      name      = "SPN ID"
      kind      = "User"
      api_group = "rbac.authorization.k8s.io"
      namespace = "<namespace>"
    }
  }
}
```
## Use case for the creation of a role binding for a customized role.

```hcl
module "<clustername>-rolebinding" {
  source = "git::https://github.com/danilomnds/terraform-kubernetes-rolebinding?ref=v1.0.0"  
  subjects = {
    grupo1 = {
      name      = "<group id>"
      kind      = "Group"
      api_group = "rbac.authorization.k8s.io"
      namespace = "<namespace>"
      role = "<role name>"
      namerolebinding = "<role binding name>"
    }    
  }
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subjects | parameters used in the role binding such as target namespace, custom role binding name, user, groups or service accounts and role | `any` | n/a | `Yes` |

## List of parameters that can be defined in each assignment (subject map)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | user id, group id ou service account id that will be associated to the role | `string` | n/a | `Yes` |
| role | you can specify a custom role name that will be used in the assignment | `string` | `role-<namespace>` | No |
| kind | user, group or serviceaccount | `string` | n/a | `Yes` |
| namerolebinding | custom role binding name | `string` | `rolebinding-<namespace>` | No |

## Documentation
Terraform kubernetes_rolebinding: <br>
[https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding)<br>