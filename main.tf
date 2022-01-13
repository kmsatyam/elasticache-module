# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE AND MANAGE AN AWS ELASTICACHE ON AMAZON WEB SERVICES (AWS)
# This module is used to launch ElastiCache which includes the following resources:
# - AWS ELASTICACHE CLUSTER
# - AWS ELASTICACHE GLOBAL REPLICATION GROUP
# - AWS ELASTICACHE PARAMETER GROUP
# - AWS ELASTICACHE REPLICATION GROUP
# - AWS ELASTICACHE SECURITY GROUP
# - AWS ELASTICACHE SUBNET GROUP
# - AWS ELASTICACHE USER
# - AWS ELASTICACHE USER GROUP

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ELASTICACHE REPOSITORY
# Amazon ElastiCache is a fully managed, in-memory caching service supporting flexible, real-time use cases. You can use ElastiCache for 
# caching, which accelerates application and database performance, or as a primary data store for use cases that don't require durability 
# like session stores, gaming leaderboards, streaming, and analytics. ElastiCache is compatible with Redis and Memcached. 
# ---------------------------------------------------------------------------------------------------------------------

# Create AWS ELASTICACHE CLUSTER

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


# Create AWS ELASTICACHE GLOBAL REPLICATION GROUP

resource "aws_elasticache_global_replication_group" "global_replication_group" {
  count       = var.elasticache_enabled && var.global_replication_group_create ? 1 : 0

  global_replication_group_id_suffix = var.global_replication_group_global_replication_group_id_suffix
  primary_replication_group_id       = var.global_replication_group_primary_replication_group_id
  global_replication_group_description = var.global_replication_group_global_replication_group_description

}

# Create ELASTICACHE PARAMETER GROUP

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


# Create AWS ELASTICACHE REPLICATION GROUP

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

# Create AWS ELASTICACHE SECURITY GROUP

resource "aws_elasticache_security_group" "security_group" {
  count       = var.elasticache_enabled && var.security_group_create ? 1 : 0

  name                 = var.security_group_name
  security_group_names = var.security_group_security_group_names
  description = var.security_group_description 
}

# Create AWS ELASTICACHE SUBNET GROUP

resource "aws_elasticache_subnet_group" "subnet_group" {
  count       = var.elasticache_enabled && var.subnet_group_create ? 1 : 0

  name       = var.subnet_group_name
  subnet_ids = var.subnet_group_subnet_ids
  description = var.subnet_group_description

}

# Create AWS ELASTICACHE USER

resource "aws_elasticache_user" "user" {
  count       = var.elasticache_enabled && var.user_create ? 1 : 0

  user_id       = var.user_user_id
  user_name     = var.user_user_name
  access_string = var.user_access_string
  engine        = var.user_engine
  passwords     = var.user_passwords
  no_password_required = var.user_no_password_required
}

# Create AWS ELASTICACHE USER GROUP

resource "aws_elasticache_user_group" "user_group" {
  count       = var.elasticache_enabled && var.user_group_create ? 1 : 0

  engine        = var.user_group_engine
  user_group_id = var.user_group_user_group_id
  user_ids      = var.user_group_user_ids
  
}

