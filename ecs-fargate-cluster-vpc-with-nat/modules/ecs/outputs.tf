output "aws_ecs_cluster_tfer--DevCluster_id" {
  value = "${aws_ecs_cluster.tfer--DevCluster.id}"
}

output "aws_ecs_service_tfer--DevCluster_sports-api_id" {
  value = "${aws_ecs_service.tfer--DevCluster_sports-api.id}"
}

output "aws_ecs_task_definition_tfer--task-definition-002F-resume-dev_id" {
  value = "${aws_ecs_task_definition.tfer--task-definition-002F-resume-dev.id}"
}

output "aws_ecs_task_definition_tfer--task-definition-002F-sports-api_id" {
  value = "${aws_ecs_task_definition.tfer--task-definition-002F-sports-api.id}"
}
