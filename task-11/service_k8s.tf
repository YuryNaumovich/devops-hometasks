resource "kubernetes_service" "Service" {
    metadata {
        name = var.k8s_service_metadata_name
    }

    spec {
        selector = {
            app = var.k8s_service_app_name
        }

        port {
            node_port = var.k8s_service_node_port
            protocol = "TCP"
            port = var.apache2_port
            target_port = var.apache2_port
        }

        type = "LoadBalancer"
    }
} 
