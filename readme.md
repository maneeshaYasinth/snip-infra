# snip. — Containerized URL Shortener on AWS

A cloud-native URL shortener built on a containerized, scalable 3-tier architecture on AWS.

Inspired by the [AWS Guidance for Building a Containerized and Scalable Web Application](https://aws.amazon.com/solutions/guidance/building-a-containerized-and-scalable-web-application-on-aws/).

---

## Architecture

| Layer | Service |
|---|---|
| Frontend | S3 + CloudFront |
| Auth | Amazon Cognito |
| API | API Gateway + ALB |
| Compute | ECS Fargate (Node.js) |
| Database | DynamoDB |
| Registry | ECR |
| DNS | Route 53 |
| Observability | CloudWatch |
| IaC | Terraform |
| CI/CD | GitHub Actions |

---

## Project Structure

```
snip-infra/
├── app/                  # Node.js + Express application
│   ├── public/           # Static frontend (HTML/CSS)
│   ├── server.js
│   ├── Dockerfile
│   └── package.json
├── infra/                # Terraform infrastructure
│   ├── modules/
│   │   ├── vpc/
│   │   ├── ecr/
│   │   ├── dynamodb/
│   │   ├── ecs/
│   │   ├── alb/
│   │   └── cloudfront/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── backend.tf
└── .github/
    └── workflows/
        └── deploy.yml
```

---

## API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/shorten` | Shorten a URL |
| `GET` | `/:code` | Redirect to original URL |
| `GET` | `/urls` | List all shortened URLs |
| `GET` | `/health` | Health check (ALB) |