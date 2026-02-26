# Scaling Strategy for 20,000 requests/second

To handle a load of 20k req/s or concurrent actions, the following architecture is recommended:

## 1. Stateless API & Horizontal Scaling
- **NestJS** nodes are completely stateless.
- Deploy across multiple availability zones using **Kubernetes (EKS/GKE)**.
- Use **Horizontal Pod Autoscaler (HPA)** based on CPU/Memory and custom metrics (Req/sec).

## 2. Load Balancing
- **L7 Load Balancer** (e.g., NGINX Ingress or AWS ALB) to distribute traffic.
- Implement **Global Accelerator** if students are distributed geographically.

## 3. Caching Strategy (Redis)
- Use **Redis Cluster** for session management and rate limiting.
- **Write-around cache**: Fetch exam questions from Redis (populated on exam publish).
- **Session Locking**: Use Redis `SET NX` to ensure one device per session.

## 4. Database Optimization (PostgreSQL)
- Use **Connection Pooling** (e.g., PgBouncer) to handle thousands of concurrent connections.
- **Read Replicas**: Distribute read traffic (viewing results, room details) to replicas.
- **Partitioning**: Partition `answers` and `proctor_events` tables by `exam_id` or `date`.

## 5. Incremental Answer Submission
- Instead of large payloads, send small, incremental answer updates.
- Use a **Message Queue (BullMQ/Kafka)** for heavy processing tasks like automatic grading or report generation to keep the request-response cycle fast.

## 6. Real-time Monitoring
- **Prometheus & Grafana** for infrastructure metrics.
- **Sentry** for error tracking.
- **OpenTelemetry** for distributed tracing to identify bottlenecks in the 20k/s flow.
