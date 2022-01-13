# Instructions

This module is used to launch ElastiCache which includes the following resources:

- AWS ELASTICACHE CLUSTER
- AWS ELASTICACHE GLOBAL REPLICATION GROUP
- AWS ELASTICACHE PARAMETER GROUP
- AWS ELASTICACHE REPLICATION GROUP
- AWS ELASTICACHE SECURITY GROUP
- AWS ELASTICACHE SUBNET GROUP
- AWS ELASTICACHE USER
- AWS ELASTICACHE USER GROUP

# repo-name

Repo link :- 

# Example

```hcl
module "elasticache-example" {                 
  source                        = "github.com/kmsatyam/elasticache-module?ref=v0.1"
  name                          = "elasticache"
}
```

# Usage
- A cluster is a collection of one or more cache nodes, all of which run an instance of the Memcached cache engine software. Most ElastiCache operations are performed at the cluster level. 
- You can set up a cluster with a specific number of nodes and a parameter group that controls the properties for each node.
## ELASTICACHE CLUSTER
```hcl
resource "aws_elasticache_cluster" "cluster" {
  count       = var.elasticache_enabled && var.cluster_create ? 1 : 0
  
  cluster_id                   = var.cluster_cluster_id
  engine                       = var.cluster_engine
  node_type                    = var.cluster_node_type
  num_cache_nodes              = var.cluster_num_cache_nodes
  parameter_group_name         = var.cluster_parameter_group_name
  port                         = var.cluster_port
  apply_immediately            = var.cluster_apply_immediately
  availability_zone            = var.cluster_availability_zone
  az_mode                      = var.cluster_az_mode
  engine_version               = var.cluster_engine_version
  final_snapshot_identifier    = var.cluster_final_snapshot_identifier
  maintenance_window           = var.cluster_maintenance_window
  notification_topic_arn       = var.cluster_notification_topic_arn
  preferred_availability_zones = var.cluster_preferred_availability_zones
  replication_group_id         = var.cluster_replication_group_id
  security_group_ids           = var.cluster_security_group_ids
  security_group_names         = var.cluster_security_group_names
  snapshot_arns                = var.cluster_snapshot_arns
  snapshot_name                = var.cluster_snapshot_name
  snapshot_retention_limit     = var.cluster_snapshot_retention_limit
  snapshot_window              = var.cluster_snapshot_window
  subnet_group_name            = var.cluster_subnet_group_name

}
```

## ELASTICACHE GLOBAL REPLICATION GROUP
- ElastiCache Global Replication Group resource manages replication between two or more Replication Groups in different regions
```hcl
resource "aws_elasticache_global_replication_group" "global_replication_group" {
  count       = var.elasticache_enabled && var.global_replication_group_create ? 1 : 0

  global_replication_group_id_suffix = var.global_replication_group_global_replication_group_id_suffix
  primary_replication_group_id       = var.global_replication_group_primary_replication_group_id
  global_replication_group_description = var.global_replication_group_global_replication_group_description

}
```

## ELASTICACHE PARAMETER GROUP
- You need to create a new parameter group if there is one or more parameter values that you want changed from the default values.
```hcl
resource "aws_elasticache_parameter_group" "parameter_group" {
  count       = var.elasticache_enabled && var.parameter_group_create ? 1 : 0

  name   = var.parameter_group_name
  family = var.parameter_group_family
  description = var.parameter_group_description

  dynamic  "parameter" {
    for_each = try(toset(var.parameter_group), [])
    content {
      name  = try(parameter.value["parameter_group_name"], null)
      value = try(parameter.value["parameter_group_value"], null)
    }    
  }

}
```

## ELASTICACHE REPLICATION GROUP
- A replication group is a set of servers, or members, that participate in the replication of one or more folders. 
- A replicated folder is kept synchronized among the members of a replication group.
```hcl
resource "aws_elasticache_replication_group" "replication_group" {
  count       = var.elasticache_enabled && var.replication_group_create ? 1 : 0

  replication_group_id          = var.replication_group_replication_group_id
  replication_group_description = var.replication_group_replication_group_description
  apply_immediately             = var.replication_group_apply_immediately
  at_rest_encryption_enabled    = var.replication_group_at_rest_encryption_enabled
  auth_token                    = var.replication_group_auth_token
  auto_minor_version_upgrade    = var.replication_group_auto_minor_version_upgrade
  automatic_failover_enabled    = var.replication_group_automatic_failover_enabled
  availability_zones            = var.replication_group_availability_zones

  cluster_mode {
    replicas_per_node_group = var.cluster_mode_replicas_per_node_group
    num_node_groups         = var.cluster_mode_num_node_groups
  }


  data_tiering_enabled         = var.replication_group_data_tiering_enabled
  engine                       = var.replication_group_engine
  engine_version               = var.replication_group_engine_version
  final_snapshot_identifier    = var.replication_group_final_snapshot_identifier
  global_replication_group_id  = var.replication_group_global_replication_group_id
  kms_key_id                   = var.replication_group_kms_key_id
  maintenance_window           = var.replication_group_maintenance_window
  multi_az_enabled             = var.replication_group_multi_az_enabled
  node_type                     = var.replication_group_node_type
  notification_topic_arn       = var.replication_group_notification_topic_arn
  number_cache_clusters         = var.replication_group_number_cache_clusters
  parameter_group_name          = var.replication_group_parameter_group_name
  port                          = var.replication_group_port
  security_group_ids           = var.replication_group_security_group_ids
  security_group_names         = var.replication_group_security_group_names
  snapshot_arns                = var.replication_group_snapshot_arns
  snapshot_name                = var.replication_group_snapshot_name
  snapshot_retention_limit     = var.replication_group_snapshot_retention_limit
  snapshot_window              = var.replication_group_snapshot_window
  subnet_group_name            = var.replication_group_subnet_group_name
  transit_encryption_enabled   = var.replication_group_transit_encryption_enabled

}
```

## ELASTICACHE SECURITY GROUP
- Provides an ElastiCache Security Group to control access to one or more cache clusters.
```hcl
resource "aws_elasticache_security_group" "security_group" {
  count       = var.elasticache_enabled && var.security_group_create ? 1 : 0

  name                 = var.security_group_name
  security_group_names = var.security_group_security_group_names
  description = var.security_group_description 
}
```

## ELASTICACHE SUBNET GROUP
- A subnet group is a collection of subnets (typically private) that you can designate for your clusters running in an Amazon Virtual Private Cloud (VPC) environment.
- ElastiCache uses that subnet group to choose a subnet and IP addresses within that subnet to associate with your nodes.
```hcl
resource "aws_elasticache_subnet_group" "subnet_group" {
  count       = var.elasticache_enabled && var.subnet_group_create ? 1 : 0

  name       = var.subnet_group_name
  subnet_ids = var.subnet_group_subnet_ids
  description = var.subnet_group_description

}
```

## ELASTICACHE USER
```hcl
resource "aws_elasticache_user" "user" {
  count       = var.elasticache_enabled && var.user_create ? 1 : 0

  user_id       = var.user_user_id
  user_name     = var.user_user_name
  access_string = var.user_access_string
  engine        = var.user_engine
  passwords     = var.user_passwords
  no_password_required = var.user_no_password_required

}
```

## ELASTICACHE USER GROUP
```hcl
resource "aws_elasticache_user_group" "user_group" {
  count       = var.elasticache_enabled && var.user_group_create ? 1 : 0

  engine        = var.user_group_engine
  user_group_id = var.user_group_user_group_id
  user_ids      = var.user_group_user_ids
  
}
```

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| aws | >= 3.20.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.20.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| elasticache\_enabled | Enabling elasticache service | `bool` | `true` | no |
| cluster\_create | n/a | `bool` | `false` | no |
| global\_replication\_group\_create | n/a | `bool` | `false` | no |
| parameter\_group\_create | n/a | `bool` | `false` | no |
| replication\_group\_create | n/a | `bool` | `false` | no |
| security\_group\_create | n/a | `bool` | `false` | no |
| subnet\_group\_create | n/a | `bool` | `false` | no |
| user\_create | n/a | `bool` | `false` | no |
| user\_group\_create | n/a | `bool` | `false` | no |
| cluster\_cluster\_id | (Required) Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource. | `string` | `null` | yes |
| cluster\_engine | (Required) unless replication_group_id is provided) Name of the cache engine to be used for this cache cluster. Valid values are memcached or redis. | `string` | `null` | yes |
| cluster\_node\_type | (Required unless replication_group_id is provided) The instance class used. See AWS documentation for information on supported node types for Redis and guidance on selecting node types for Redis. | `string` | `null` | yes |
| cluster\_num\_cache\_nodes | (Required unless replication_group_id is provided) The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40 | `number` | `null` | yes |
| cluster\_parameter\_group\_name | (Required unless replication_group_id is provided) The name of the parameter group to associate with this cache cluster. | `string` | `null` | yes |
| cluster\_port | n/a | `number` | `null` | no |
| cluster\_apply\_immediately | (Optional) Whether any database modifications are applied immediately, or during the next maintenance window. Default is false. | `bool` | `null` | no |
| cluster\_availability\_zone | (Optional) Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use preferred_availability_zones instead. Default: System chosen Availability Zone. Changing this value will re-create the resource. | `string` | `null` | no |
| cluster\_az\_mode | (Optional, Memcached only) Whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region | `string` | `null` | no |
| cluster\_engine\_version | (Optional) Version number of the cache engine to be used. | `number` | `null` | no |
| cluster\_final\_snapshot\_identifier | (Optional, Redis only) Name of your final cluster snapshot. If omitted, no final snapshot will be made. | `string` | `null` | no |
| cluster\_maintenance\_window | (Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi | `any` | `null` | no |
| cluster\_notification\_topic\_arn | (Optional) ARN of an SNS topic to send ElastiCache notifications to. | `string` | `null` | no |
| cluster\_preferred\_availability\_zones | (Optional, Memcached only) List of the Availability Zones in which cache nodes are created. | `list(string)` | `[]` | no |
| cluster\_replication\_group\_id | (Optional) ID of the replication group to which this cluster should belong. | `string` | `null` | no |
| cluster\_security\_group\_ids | (Optional, VPC only) One or more VPC security groups associated with the cache cluster | `list(string)` | `null` | no |
| cluster\_security\_group\_names | (Optional, EC2 Classic only) List of security group names to associate with this cache cluster. | `list(string)` | `[]` | no |
| cluster\_snapshot\_arns | (Optional, Redis only) Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. | `list(string)` | `null` | no |
| cluster\_snapshot\_name | (Optional, Redis only) Name of a snapshot from which to restore data into the new node group. Changing snapshot_name forces a new resource. | `string` | `null` | no |
| cluster\_snapshot\_retention\_limit | (Optional, Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. | `number` | `null` | no |
| cluster\_snapshot\_window | (Optional, Redis only) Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. | `any` | `null` | no |
| cluster\_subnet\_group\_name | (Optional, VPC only) Name of the subnet group to be used for the cache cluster  | `string` | `null` | no |
| global\_replication\_group\_global\_replication\_group\_id\_suffix | (Required) The suffix name of a Global Datastore.  | `string` | `null` | yes |
| global\_replication\_group\_primary\_replication\_group\_id | (Required) The ID of the primary cluster that accepts writes and will replicate updates to the secondary cluster.  | `string` | `null` | yes |
| global\_replication\_group\_global\_replication\_group\_description | (Optional) A user-created description for the global replication group.  | `string` | `null` | no |
| parameter\_group\_name | (Required) The name of the ElastiCache parameter group.  | `string` | `null` | yes |
| parameter\_group\_family | (Required) The family of the ElastiCache parameter group.  | `string` | `null` | yes |
| parameter\_group\_description | (Optional) The description of the ElastiCache parameter group.  | `string` | `null` | no |
| parameter\_group | (Optional) A list of ElastiCache parameters to apply.  | <pre>list(object({ <br/>parameter_group_name = string<br/>parameter_group_value = string<br/>})) </pre> | `[]` | no |
| replication\_group\_automatic\_failover\_enabled | (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, number_cache_clusters must be greater than 1  | `bool` | `null` | no |
| replication\_group\_availability\_zones | (Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important.  | `list(string)` | `null` | no |
| replication\_group\_replication\_group\_id | (Required) The replication group identifier. This parameter is stored as a lowercase string.  | `string` | `null` | yes |
| replication\_group\_replication\_group\_description | (Required) A user-created description for the replication group.  | `string` | `null` | yes |
| replication\_group\_node\_type | (Optional) The instance class to be used.  | `string` | `null` | no |
| replication\_group\_number\_cache\_clusters | (Optional) The number of cache clusters (primary and replicas) this replication group will have.  | `number` | `null` | no |
| replication\_group\_parameter\_group\_name | (Optional) The name of the parameter group to associate with this replication group  | `string` | `null` | no |
| replication\_group\_port | (Optional) The port number on which each of the cache nodes will accept connections  | `number` | `null` | no |
| replication\_group\_apply\_immediately | (Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window.  | `bool` | `null` | no |
| replication\_group\_at\_rest\_encryption\_enabled | (Optional) Whether to enable encryption at rest.  | `bool` | `null` | no |
| replication\_group\_auth\_token | (Optional) The password used to access a password protected server.  | `string` | `null` | no |
| replication\_group\_auto\_minor\_version\_upgrade | (Optional) Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window  | `bool` | `null` | no |
| cluster\_mode\_replicas\_per\_node\_group | (Required) Number of replica nodes in each node group. Valid values are 0 to 5.  | `number` | `null` | yes |
| cluster\_mode\_num\_node\_groups | (Optional) Number of node groups (shards) for this Redis replication group.  | `number` | `null` | no |
| replication\_group\_data\_tiering\_enabled | (Optional) Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type.  | `bool` | `null` | no |
| replication\_group\_engine | (Optional) The name of the cache engine to be used for the clusters in this replication group  | `string` | `null` | no |
| replication\_group\_engine\_version | (Optional) The version number of the cache engine to be used for the cache clusters in this replication group  | `string` | `null` | no |
| replication\_group\_final\_snapshot\_identifier | (Optional) The name of your final node group (shard) snapshot.  | `string` | `null` | no |
| replication\_group\_global\_replication\_group\_id | (Optional) The ID of the global replication group to which this replication group should belong.  | `string` | `null` | no |
| replication\_group\_kms\_key\_id | (Optional) The ARN of the key that you wish to use if encrypting at rest.  | `string` | `null` | no |
| replication\_group\_maintenance\_window | (Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed  | `any` | `null` | no |
| replication\_group\_multi\_az\_enabled | (Optional) Specifies whether to enable Multi-AZ Support for the replication group  | `bool` | `null` | no |
| replication\_group\_notification\_topic\_arn | (Optional) An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to  | `string` | `null` | no |
| replication\_group\_security\_group\_ids | (Optional) One or more Amazon VPC security groups associated with this replication group.  | `list(string)` | `null` | no |
| replication\_group\_security\_group\_names | (Optional) A list of cache security group names to associate with this replication group.  | `list(string)` | `null` | no |
| replication\_group\_snapshot\_arns | (Optional) A list of Amazon Resource Names (ARNs) that identify Redis RDB snapshot files stored in Amazon S3.  | `list(string)` | `[]` | no |
| replication\_group\_snapshot\_name | (Optional) The name of a snapshot from which to restore data into the new node group  | `string` | `null` | no |
| replication\_group\_snapshot\_retention\_limit | (Optional, Redis only) The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them  | `number` | `null` | no |
| replication\_group\_snapshot\_window | (Optional, Redis only) The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster.  | `any` | `null` | no |
| replication\_group\_subnet\_group\_name | (Optional) The name of the cache subnet group to be used for the replication group.  | `string` | `null` | no |
| replication\_group\_transit\_encryption\_enabled | (Optional) Whether to enable encryption in transit.  | `bool` | `null` | no |
| security\_group\_name | (Required) Name for the cache security group. This value is stored as a lowercase string.  | `string` | `null` | yes |
| security\_group\_security\_group\_names | (Required) List of EC2 security group names to be authorized for ingress to the cache security group  | `list(string)` | `null` | yes |
| security\_group\_description | (Optional) description for the cache security group.  | `string` | `null` | no |
| subnet\_group\_name |  (Required) Name for the cache subnet group. Elasticache converts this name to lowercase.  | `string` | `null` | yes |
| subnet\_group\_subnet\_ids | (Required) List of VPC Subnet IDs for the cache subnet group  | `list(string)` | `[]` | yes |
| subnet\_group\_description | (Optional) Description for the cache subnet group.  | `string` | `null` | no |
| user\_user\_id | (Required) The ID of the user.  | `string` | `null` | yes |
| user\_user\_name | (Required) The username of the user.  | `string` | `null` | yes |
| user\_access\_string | (Required) Access permissions string used for this user.  | `any` | `null` | yes |
| user\_engine | (Required) The current supported value is REDIS.  | `string` | `REDIS` | yes |
| user\_passwords |  (Optional) Passwords used for this user. You can create up to two passwords for each user.  | `list(string)` | `null` | no |
| user\_no\_password\_required | (Optional) Indicates a password is not required for this user.  | `any` | `null` | no |
| user\_group\_engine | (Required) The current supported value is REDIS.  | `string` | `REDIS` | yes |
| user\_group\_user\_group\_id | (Required) The ID of the user group.  | `string` | `null` | yes |
| user\_group\_user\_ids | (Optional) The list of user IDs that belong to the user group.  | `list(string)` | `[]` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->
