## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_nat\_gateway | n/a | `bool` | `true` | no |
| create\_public\_ip | Should we create a public IP or not? | `bool` | `true` | no |
| environment | Project environment | `string` | n/a | yes |
| label\_order | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| location | Azure region to use | `string` | n/a | yes |
| managedby | ManagedBy, eg ''. | `string` | `""` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| nat\_gateway\_custom\_name | Custom name for Nat gateway | `string` | `null` | no |
| nat\_gateway\_idle\_timeout | Idle timeout configuration in minutes for Nat Gateway | `number` | `4` | no |
| public\_ip\_custom\_name | Custom name for public IP | `string` | `null` | no |
| public\_ip\_ids | List of public ips to use. Create one ip if not provided | `list(string)` | `[]` | no |
| public\_ip\_zones | Public ip Zones to configure. | `list(string)` | `null` | no |
| repository | Terraform current module repo | `string` | `""` | no |
| resource\_group\_name | Name of the resource group to use | `string` | n/a | yes |
| subnet\_ids | Ids of subnets to associate with the Nat Gateway | `list(string)` | `[]` | no |

## Outputs

No output.

