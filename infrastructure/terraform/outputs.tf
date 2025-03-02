output "frontend_service_ip" {
  value = kubernetes_service.frontend_service.status[0].load_balancer[0].ingress[0].ip
}

output "backend_service_ip" {
  value = kubernetes_service.backend_service.status[0].load_balancer[0].ingress[0].ip
}
