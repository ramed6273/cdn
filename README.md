
# Local CDN Simulation with Nginx, Lua, Redis, RabbitMQ, Kafka & Docker

## Project Goal

This project simulates a real-world CDN (Content Delivery Network) architecture **locally** for educational and DevOps training purposes. The goal is to deeply learn infrastructure components like caching, message brokers, event streaming, and observability through a modular and production-like setup.

---

```mermaid
graph TD
  client[Client (curl/Browser)]
  edge[Edge Server (OpenResty)]
  redis[Redis]
  origin[Origin Server (Static Files)]

  client --> edge
  edge --> redis
  edge --> origin
```

## Architecture Overview

```text
           +----------------------+
           |    Control Plane     |
           | (API, Monitoring)    |
           +----------+-----------+
                      |
   +------------------+------------------+
   |                  |                  |
+--v--+          +----v----+         +---v---+
|Edge1|          | Edge2   |         | Edge3 |
|Tehran          | Shiraz  |         | Tabriz|
+--+--+          +----+----+         +---+---+
   |                  |                  |
   |      Redis <-----+------------------+
   |   RabbitMQ <------+-----------------+
   |      Kafka <------+-----------------+
   |
   |   [Cache Miss]
   v
+------------+
|   Origin   |
|   Server   |
+------------+
```

## Stack & Components

| Component        | Tool/Technology      |
| ---------------- | -------------------- |
| Edge Servers     | Nginx + Lua          |
| Origin Server    | Static Nginx or API  |
| Caching Layer    | Redis                |
| Message Queue    | RabbitMQ             |
| Log/Event Stream | Apache Kafka         |
| Control Plane    | FastAPI or Django    |
| Monitoring       | Prometheus + Grafana |

## TODO
- [ ] ...

## Getting Started (Local)

    git clone https://github.com/yourname/cdn-lab.git
	cd cdn-lab
	docker-compose -f infra/docker-compose.yml up -d

## Default Ports
| Service     | Port  |
| ----------- | ----- |
| Redis       | 6379  |
| RabbitMQ UI | 15672 |
| Kafka       | 9092  |
| Origin      | 9090  |
| Prometheus  | 9091  |
| Grafana     | 3000  |
| Edge 1      | 8081  |
| Edge 2      | 8082  |
| Edge 3      | 8083  |


## 🤝 Contribution
Ideas, PRs, and feature suggestions are welcome — especially around:
- TLS offloading
- WebSocket/CDN Push
- Regional DNS logic
- Distributed cache invalidation


