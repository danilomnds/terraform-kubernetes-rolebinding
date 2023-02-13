resource "kubernetes_role_binding" "rolebinding" {
  for_each = var.subjects
  metadata {    
    name      = try(each.value.namerolebinding, lower("rolebinding-${each.value.namespace}"))
    namespace = each.value.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = try(each.value.role, lower("role-${each.value.namespace}"))
  }
  subject {
      name      = each.value.name
      namespace = try(each.value.namespace, null)
      kind      = each.value.kind
      api_group = try(each.value.api_group, null)
  }
}