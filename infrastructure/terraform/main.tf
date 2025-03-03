provider "kubernetes" {
  config_path = var.kube_config_path
}

# ✅ Define Namespace
resource "kubernetes_namespace" "pipelinecraft" {
  metadata {
    name = "pipelinecraft"
  }
}

# ✅ Backend Deployment
resource "kubernetes_deployment" "backend" {
  metadata {
    name      = "backend-deployment"
    namespace = kubernetes_namespace.pipelinecraft.metadata[0].name
    labels = {
      app = "backend"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "backend"
        }
      }
      spec {
        container {
          image = "registry.gitlab.com/your-namespace/pipelinecraft-backend:latest"
          name  = "backend"
          port {
            container_port = 5000
          }
          env {
            name  = "PORT"
            value = "5000"
          }
        }
      }
    }
  }
}

# ✅ Backend Service
resource "kubernetes_service" "backend_service" {
  metadata {
    name      = "backend-service"
    namespace = kubernetes_namespace.pipelinecraft.metadata[0].name
  }
  spec {
    selector = {
      app = "backend"
    }
    port {
      protocol    = "TCP"
      port        = 5000
      target_port = 5000
    }
    type = "ClusterIP"
  }
}

# ✅ Frontend Deployment
resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend-deployment"
    namespace = kubernetes_namespace.pipelinecraft.metadata[0].name
    labels = {
      app = "frontend"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }
      spec {
        container {
          image = "registry.gitlab.com/your-namespace/pipelinecraft-frontend:latest"
          name  = "frontend"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# ✅ Frontend Service
resource "kubernetes_service" "frontend_service" {
  metadata {
    name      = "frontend-service"
    namespace = kubernetes_namespace.pipelinecraft.metadata[0].name
  }
  spec {
    selector = {
      app = "frontend"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
