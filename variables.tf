
# ---------------------------------------------------------------------------------------------------------------------
# PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------------------------------------------

variable "elasticache_enabled" {
  description = "Enabling Elasticache service"
  type        = bool
  default     = true
}

variable "cluster_create" {
  description = ""
  type        = bool
  default     = false
}

variable "global_replication_group_create" {
  description = ""
  type        = bool
  default     = false
}

variable "parameter_group_create" {
  description = ""
  type        = bool
  default     = false
}

variable "replication_group_create" {
  description = ""
  type        = bool
  default     = false
}

variable "security_group_create" {
  description = ""
  type        = bool
  default     = false
}

variable "subnet_group_create" {
  description = ""
  type        = bool
  default     = false
}

variable "user_create" {
  description = ""
  type        = bool
  default     = false
}

variable "user_group_create" {
  description = ""
  type        = bool
  default     = false
}



###############  AWS ELASTICACHE CLUSTER  ###############

variable "cluster_cluster_id" {
  description  = "(Required) Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource."
  type         = string    
  default      = null
}
 
variable "cluster_engine" {
  description  = " (Required) unless replication_group_id is provided) Name of the cache engine to be used for this cache cluster. Valid values are memcached or redis."
  type         = string
  default      = null
}

variable "cluster_node_type" {
  description  = "(Required unless replication_group_id is provided) The instance class used. See AWS documentation for information on supported node types for Redis and guidance on selecting node types for Redis."
  type         = string 
  default      = null
}

variable "cluster_num_cache_nodes" {
  description  = "(Required unless replication_group_id is provided) The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40."
  type         = number
  default      = null
}

variable "cluster_parameter_group_name" {
  description  = "(Required unless replication_group_id is provided) The name of the parameter group to associate with this cache cluster."
  type         = string
  default      = null
}

variable "cluster_port" {
  description  = ""
  type         = number     
  default      = null
}

variable "cluster_apply_immediately" {
  description  = " (Optional) Whether any database modifications are applied immediately, or during the next maintenance window. Default is false."
  type         = bool
  default      = null
}

variable "cluster_availability_zone" {
  description  = " (Optional) Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use preferred_availability_zones instead. Default: System chosen Availability Zone. Changing this value will re-create the resource."
  type         = string
  default      = null
}

variable "cluster_az_mode" {
  description  = "(Optional, Memcached only) Whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region"
  type         = string
  default      = null
}

variable "cluster_engine_version" {
  description  = "(Optional) Version number of the cache engine to be used."
  type         = number
  default      = null
}

variable "cluster_final_snapshot_identifier" {
  description  = "(Optional, Redis only) Name of your final cluster snapshot. If omitted, no final snapshot will be made."
  type         = string
  default      = null
}

variable "cluster_maintenance_window" {
  description  = "(Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi"
  type         = any
  default      = null
}

variable "cluster_notification_topic_arn" {
  description  = "(Optional) ARN of an SNS topic to send ElastiCache notifications to."
  type         = string
  default      = null
}

variable "cluster_preferred_availability_zones" {
  description  = "(Optional, Memcached only) List of the Availability Zones in which cache nodes are created."
  type         = list(string)
  default      = []
}

variable "cluster_replication_group_id" {
  description  = "(Optional) ID of the replication group to which this cluster should belong. "
  type         = string
  default      = null
}

variable "cluster_security_group_ids" {
  description  = " (Optional, VPC only) One or more VPC security groups associated with the cache cluster"
  type         = list(string)
  default      = null
}

variable "cluster_security_group_names" {
  description  = "(Optional, EC2 Classic only) List of security group names to associate with this cache cluster."
  type         = list(string)
  default      = []
}

variable "cluster_snapshot_arns" {
  description  = "(Optional, Redis only) Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3."
  type         = list(string)
  default      = null
}

variable "cluster_snapshot_name" {
  description  = "(Optional, Redis only) Name of a snapshot from which to restore data into the new node group. Changing snapshot_name forces a new resource."
  type         = string
  default      = null
}

variable "cluster_snapshot_retention_limit" {
  description  = "(Optional, Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. "
  type         = number
  default      = null
}

variable "cluster_snapshot_window" {
  description  = "(Optional, Redis only) Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster."
  type         = any
  default      = null
}

variable "cluster_subnet_group_name" {
  description  = "(Optional, VPC only) Name of the subnet group to be used for the cache cluster"
  type         = string
  default      = null
}


###############  AWS ELASTICACHE GLOBAL REPLICATION GROUP  ###############


variable "global_replication_group_global_replication_group_id_suffix" {
  description  = "(Required) The suffix name of a Global Datastore."
  type         = string
  default      = null
}


variable "global_replication_group_primary_replication_group_id" {
  description  = "(Required) The ID of the primary cluster that accepts writes and will replicate updates to the secondary cluster."
  type         = string
  default      = null
}

variable "global_replication_group_global_replication_group_description" {
  description  = "(Optional) A user-created description for the global replication group."
  type         = string
  default      = null
}


###############  AWS ELASTICACHE PARAMETER GROUP  ###############


variable "parameter_group_name" {
  description  = "(Required) The name of the ElastiCache parameter group."
  type         = string
  default      = null
}

variable "parameter_group_family" {
  description  = "(Required) The family of the ElastiCache parameter group."
  type         = string
  default      = null
}

variable "parameter_group_description" {
  description  = "(Optional) The description of the ElastiCache parameter group."
  type         = string
  default      = null
}

variable "parameter_group" {
  description  = "(Optional) A list of ElastiCache parameters to apply."
  type = list(object({
    parameter_group_name = string
    parameter_group_value = string
    }))
  default      = []
}

###############  AWS ELASTICACHE REPLICATION GROUP  ###############


variable "replication_group_automatic_failover_enabled" {
  description  = " (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, number_cache_clusters must be greater than 1"
  type         = bool
  default      = null
}

variable "replication_group_availability_zones" {
  description  = "(Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important."
  type         = list(string)
  default      = null
}

variable "replication_group_replication_group_id" {
  description  = "(Required) The replication group identifier. This parameter is stored as a lowercase string."
  type         = string
  default      =  null
}

variable "replication_group_replication_group_description" {
  description  = "(Required) A user-created description for the replication group."
  type         = string
  default      = null
}

variable "replication_group_node_type" {
  description  = "(Optional) The instance class to be used."
  type         = string
  default      = null
}

variable "replication_group_number_cache_clusters" {
  description  = "(Optional) The number of cache clusters (primary and replicas) this replication group will have."
  type         = number
  default      = null
}

variable "replication_group_parameter_group_name" {
  description  = "(Optional) The name of the parameter group to associate with this replication group"
  type         = string
  default      = null
}

variable "replication_group_port" {
  description  = "(Optional) The port number on which each of the cache nodes will accept connections"
  type         = number
  default      = null
}

variable "replication_group_apply_immediately" {
  description  = "(Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window."
  type         = bool
  default      = null
}

variable "replication_group_at_rest_encryption_enabled" {
  description  = "(Optional) Whether to enable encryption at rest."
  type         = bool
  default      = null
}

variable "replication_group_auth_token" {
  description  = " (Optional) The password used to access a password protected server."
  type         = string
  default      = null
}

variable "replication_group_auto_minor_version_upgrade" {
  description  = "(Optional) Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window"
  type         = bool
  default      = null
}

variable "cluster_mode_replicas_per_node_group" {
  description  = " (Required) Number of replica nodes in each node group. Valid values are 0 to 5."
  type         = number
  default      = null
}

variable "cluster_mode_num_node_groups" {
  description  = "(Optional) Number of node groups (shards) for this Redis replication group. "
  type         = number
  default      = null
}

variable "replication_group_data_tiering_enabled" {
  description  = "(Optional) Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. "
  type         = bool
  default      = null
}

variable "replication_group_engine" {
  description  = "(Optional) The name of the cache engine to be used for the clusters in this replication group"
  type         = string
  default      = null
}

variable "replication_group_engine_version" {
  description  = " (Optional) The version number of the cache engine to be used for the cache clusters in this replication group"
  type         = string
  default      = null
}

variable "replication_group_final_snapshot_identifier" {
  description  = "(Optional) The name of your final node group (shard) snapshot."
  type         = string
  default      = null
}

variable "replication_group_global_replication_group_id" {
  description  = " (Optional) The ID of the global replication group to which this replication group should belong."
  type         = string
  default      = null
}

variable "replication_group_kms_key_id" {
  description  = "(Optional) The ARN of the key that you wish to use if encrypting at rest."
  type         = string
  default      = null
}
variable "replication_group_maintenance_window" {
  description  = "(Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed"
  type         = any
  default      = null
}

variable "replication_group_multi_az_enabled" {
  description  = "(Optional) Specifies whether to enable Multi-AZ Support for the replication group"
  type         = bool
  default      = null
}

variable "replication_group_notification_topic_arn" {
  description  = "(Optional) An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to"
  type         = string
  default      = null
}

variable "replication_group_security_group_ids" {
  description  = "(Optional) One or more Amazon VPC security groups associated with this replication group. Use this parameter only when you are creating a replication group in an Amazon Virtual Private Cloud"
  type         = list(string)
  default      = null
}

variable "replication_group_security_group_names" {
  description  = " (Optional) A list of cache security group names to associate with this replication group."
  type         = list(string)
  default      = null
}

variable "replication_group_snapshot_arns" {
  description  = "(Optional) A list of Amazon Resource Names (ARNs) that identify Redis RDB snapshot files stored in Amazon S3. "
  type         = list(string)
  default      = []
}

variable "replication_group_snapshot_name" {
  description  = "(Optional) The name of a snapshot from which to restore data into the new node group"
  type         = string
  default      = null
}
variable "replication_group_snapshot_retention_limit" {
  description  = "(Optional, Redis only) The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  type         = number
  default      = null
}

variable "replication_group_snapshot_window" {
  description  = "(Optional, Redis only) The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. "
  type         = any
  default      = null
}

variable "replication_group_subnet_group_name" {
  description  = "(Optional) The name of the cache subnet group to be used for the replication group."
  type         = string
  default      = null
}

variable "replication_group_transit_encryption_enabled" {
  description  = "(Optional) Whether to enable encryption in transit."
  type         = bool
  default      = null
}


###############  AWS ELASTICACHE SECURITY GROUP  ###############

variable "security_group_name" {
  description  = "(Required) Name for the cache security group. This value is stored as a lowercase string."
  type         = string
  default      =  null
}

variable "security_group_security_group_names" {
  description  = "(Required) List of EC2 security group names to be authorized for ingress to the cache security group"
  type         = list(string)
  default      = []
}

variable "security_group_description" {
  description  = " (Optional) description for the cache security group. Defaults to."
  type         = string
  default      = null
}

###############  AWS ELASTICACHE SUBNET GROUP  ###############

variable "subnet_group_name" {
  description  = " (Required) Name for the cache subnet group. Elasticache converts this name to lowercase."
  type         = string
  default      = null
}

variable "subnet_group_subnet_ids" {
  description  = "(Required) List of VPC Subnet IDs for the cache subnet group"
  type         = list(string)
  default      = []
}

variable "subnet_group_description" {
  description  = "(Optional) Description for the cache subnet group. "
  type         = string
  default      = null
}

###############  AWS ELASTICACHE USER  ###############

variable "user_user_id" {
  description  = "(Required) The ID of the user."
  type         = string
  default      = null
}

variable "user_user_name" {
  description  = "(Required) The username of the user."
  type         = string
  default      = null
}

variable "user_access_string" {
  description  = " (Required) Access permissions string used for this user."
  type         = any
  default      = null
}

variable "user_engine" {
  description  = "(Required) The current supported value is REDIS."
  type         = string
  default      = "REDIS"
}

variable "user_passwords" {
  description  = " (Optional) Passwords used for this user. You can create up to two passwords for each user."
  type         = list(string)
  default      = null
}

variable "user_no_password_required" {
  description  = "(Optional) Indicates a password is not required for this user."
  type         = any
  default      = null
}

###############  AWS ELASTICACHE USER GROUP  ###############

variable "user_group_engine" {
  description  = "(Required) The current supported value is REDIS."
  type         = string
  default      = "REDIS"
}

variable "user_group_user_group_id" {
  description  = "(Required) The ID of the user group."
  type         = string
  default      = null
}

variable "user_group_user_ids" {
  description  = "(Optional) The list of user IDs that belong to the user group."
  type         = list(string)
  default      = []
}

