resource "kubernetes_deployment" "deployment" {
   metadata {  
     name = "apache2-deployment"
     labels = {
         app = "apache2"
     }    
   }

   spec {
       replicas = 3

       selector {
           match_labels = {
               app = "apache2"
           }
       }

       template {
           metadata {
               labels = {
                   app = "apache2"
               }
           }

           spec {
           container {
               name = var.apache2_container_name
               image = var.apache2_container_image

               port {
                   container_port = var.apache2_port
                   name = "http-port"
               }

               readiness_probe {
                   initial_delay_seconds = 5
                   period_seconds = 10
                   timeout_seconds = 1
                   success_threshold = 1
                   failure_threshold = 1

                   http_get {
                       scheme = "HTTP"
                       path = "/"
                       port = var.apache2_port
                   }
               }

               liveness_probe {
                   initial_delay_seconds = 15
                   period_seconds = 20

                   http_get {
                       scheme = "HTTP"
                       path = "/"
                       port = var.apache2_port
                    }
                }
            }
            }
        }
    }
}
