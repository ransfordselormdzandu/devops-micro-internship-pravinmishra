# Assignment 7 — Capstone: Deploy a Production-Grade Stack for The EpicBook

Part of the DevOps Micro Internship (DMI) with Agentic AI

---

## Purpose

In this assignment, you will deploy the EpicBook application as a production-oriented Docker Compose stack on a cloud VM. You will use optimized container images, isolated networks, health checks, persistent MySQL storage, a selected reverse proxy, logging, backup and restore testing, and reliability procedures.

---

# Task 0 — App Discovery and Architecture

## Goal

Review the EpicBook repository and design the intended application architecture.

### Evidence

#### Screenshot 1 — EpicBook Project Structure

Add a terminal screenshot showing the EpicBook project structure after cloning the repository.

![alt text](screenshots/07_01_a.png)
![alt text](screenshots/07_01_b.png)
---

#### Screenshot 2 — Architecture Diagram

Add a screenshot of your architecture diagram showing:

- Public user
- Reverse proxy
- Frontend
- Backend
- Database
- Docker networks
- Public and private ports
- Persistent database storage

Add your full name inside the diagram or as a clear caption below it.

![alt text](screenshots/07_02.png)

---

#### Screenshot 3 — Environment Variables and Ports Document

Add a screenshot showing the contents of:

```text
docs/02-env-and-ports.md
```

It must document environment-variable names, internal ports, persistent-data details, and the health-check method. Do not expose real credentials or values.

![alt text](screenshots/07_03.png)
![alt text](screenshots/07_03_b.png)

---

# Task 1 — Create Production Docker Images

## Goal

Create optimized production images for the EpicBook backend and frontend.

### Evidence

#### Screenshot 4 — Backend Dockerfile

Add a screenshot showing `backend/Dockerfile`, including:

- Dependency stage
- Minimal runtime stage
- Production startup command
- Internal backend port
- Non-root user configuration

![alt text](screenshots/07_04.png)

---

#### Screenshot 5 — Frontend Dockerfile

Add a screenshot showing `frontend/Dockerfile`, including:

- Nginx runtime image
- Static frontend files copied to the Nginx web root

![alt text](screenshots/07_05.png)

---

#### Screenshot 6 — Docker Ignore Files

Add a screenshot showing both:

```text
backend/.dockerignore
frontend/.dockerignore
```

![alt text](screenshots/07_06.png)

---

#### Screenshot 7 — Docker Image Builds and Size Comparison

Add a terminal screenshot showing successful builds of:

- Baseline backend image
- Optimized backend image
- Frontend image

The screenshot must also show the baseline and optimized backend image-size comparison.

![alt text](screenshots/07_07.png)

---

#### Screenshot 8 — Backend Running as Non-Root User

Add a terminal screenshot showing the optimized backend container running as a non-root user.

![alt text](screenshots/07_08.png)

---

### Notes

Write a short note covering:

- Baseline and optimized backend image sizes
- The image-size reduction achieved
- One Docker layer-caching optimization used
- The security benefit of running the backend as a non-root user

Backend Docker Image Optimization

1. Baseline and Optimized Image Sizes

The baseline backend Docker image (epicbook-backend:single) had a disk usage size of 1.68 GB. After optimization, the production backend image (epicbook-backend:1.0) was reduced to 218 MB.

2. Image-Size Reduction Achieved

The optimization reduced the backend image size by approximately 1,462 MB (87%). This was achieved by using a multi-stage Docker build and a smaller Alpine-based Node.js runtime image, reducing unnecessary files and dependencies in the final image.

3. Docker Layer-Caching Optimization

One layer-caching optimization was copying package.json and package-lock.json before copying the application source code, then running npm ci --omit=dev. This allows Docker to reuse the dependency installation layer when application code changes but dependency files remain unchanged, making subsequent builds faster.

4. Security Benefit of Running as a Non-Root User

The optimized backend container runs using the node user instead of the root user. This follows the principle of least privilege by limiting the permissions available to the application. If the application is compromised, running as a non-root user reduces the potential damage an attacker can cause inside the container.

Conclusion

The optimization reduced the backend Docker image size by approximately 87%, improved build efficiency through Docker layer caching, and strengthened container security by running the application as a non-root user.

---

# Task 2 — Create the Docker Compose Stack and Networks

## Goal

Create one Docker Compose stack containing the reverse proxy, frontend, backend, and MySQL database.

### Evidence

#### Screenshot 9 — Docker Compose Services

Add a screenshot showing `docker-compose.yml` with all four services:

```text
reverse-proxy
frontend
backend
database
```

![alt text](screenshots/07_09_a.png)
![alt text](screenshots/07_09_b.png)
![alt text](screenshots/07_09_c.png)
![alt text](screenshots/07_09_d.png)
![alt text](screenshots/07_09_e.png)

---

#### Screenshot 10 — Networks and Named Volume

Add a screenshot showing:

- `front-tier` network
- `back-tier` network
- `db_data` named volume

![alt text](screenshots/07_10_a.png)
![alt text](screenshots/07_10_b.png)

---

#### Screenshot 11 — Docker Compose Validation

Add a terminal screenshot showing successful Docker Compose validation without exposing environment-variable values or secrets.

![alt text](screenshots/07_11.png)

---

# Task 3 — Configure Health Checks and Startup Dependencies

## Goal

Configure health checks and ensure services start only after their dependencies are healthy.

### Evidence

#### Screenshot 12 — Backend Health Endpoint

Add a screenshot showing the backend application configuration for the `/health` endpoint.

![alt text](screenshots/07_12.png)

---

#### Screenshot 13 — MySQL and Backend Health Checks

Add a screenshot showing `docker-compose.yml` with health checks for MySQL and the backend.

![alt text](screenshots/07_13_a.png)
![alt text](screenshots/07_13_b.png)
---

#### Screenshot 14 — Frontend and Reverse-Proxy Health Checks

Add a screenshot showing:

- Frontend health check
- Reverse-proxy health check
- `depends_on` conditions using `service_healthy`

![alt text](screenshots/07_14.png)
![alt text](screenshots/07_14_b.png)

---

#### Screenshot 15 — Running Healthy Services

Add a terminal screenshot showing Docker Compose service status. The database, backend, frontend, and reverse proxy must be running successfully.

![alt text](screenshots/07_15.png)

---

#### Screenshot 16 — Public Health Endpoint

Add a terminal screenshot showing a successful response from the public application health endpoint through the reverse proxy.

![alt text](screenshots/07_16.png)

---

#### Screenshot 17 — Health-Check and Startup-Order Document

Add a screenshot showing the contents of:

```text
docs/03-healthchecks-and-depends-on.md
```

Explain the health-check method for each service and the startup dependency order.

![alt text](screenshots/07_17.png)
![alt text](screenshots/07_17_b.png)

---

# Task 4 — Configure the Reverse Proxy and Same-Origin Routing

## Goal

Use either Nginx or Traefik as the only public entry point for the EpicBook application.

### Evidence

#### Screenshot 18 — Selected Reverse-Proxy Configuration

Add a screenshot showing the configuration for your selected reverse proxy.

It must show routes for:

- Static frontend assets
- Application pages
- API requests
- Health endpoint

![alt text](screenshots/07_18.png)

---

#### Screenshot 19 — Only Reverse Proxy Publishes Port 80

Add a screenshot of `docker-compose.yml` showing that only the `reverse-proxy` service publishes port 80.

![alt text](screenshots/07_19.png)

---

#### Screenshot 20 — Reverse-Proxy Route Testing

Add a terminal screenshot showing successful requests through the selected reverse proxy to:

- Application page
- One API endpoint
- One static asset
- Health endpoint

![alt text](screenshots/07_20.png)

---

#### Screenshot 21 — EpicBook Application Through Public IP

Add a browser screenshot showing the EpicBook application loaded through the VM public IP address.

Add your full name as a clear caption below the screenshot.

![alt text](screenshots/07_21.png)

---

#### Screenshot 22 — Proxy Routing and CORS Document

Add a screenshot showing the contents of:

```text
docs/04-proxy-routing-and-cors.md
```

Explain the proxy routes and state whether CORS was required and why.

![alt text](screenshots/07_22.png)

---

# Task 5 — Prove Data Persistence, Backup, and Restore

## Goal

Verify MySQL persistence and perform a controlled backup and restore drill.

### Evidence

#### Screenshot 23 — MySQL Volume Configuration

Add a terminal screenshot showing the `db_data` named volume and its MySQL mount configuration.

![alt text](screenshots/07_23.png)

---

#### Screenshot 24 — Test Data Before Backup

Add a terminal screenshot showing the selected test data before the backup and restore drill.

![alt text](screenshots/07_24.png)

---

#### Screenshot 25 — Successful Backup Creation

Add a terminal screenshot showing successful backup creation and the backup file stored in the host backup directory.

![alt text](screenshots/07_25.png)

---

#### Screenshot 26 — Controlled Data-Loss Test

Add a terminal screenshot showing that the selected test record was removed during the controlled data-loss test.

![alt text](screenshots/07_26.png)

---

#### Screenshot 27 — Restore Verification

Add a terminal screenshot showing successful restore and verification that the deleted test record is available again.

![alt text](screenshots/07_27.png)

---

#### Screenshot 28 — Persistence After Down/Up Cycle

Add a terminal screenshot showing that database data remains available after a non-destructive Docker Compose down/up cycle.

Do not use `docker compose down -v`.

![alt text](screenshots/07_28_a.png)

---

#### Screenshot 29 — Persistence and Backup Document

Add a screenshot showing the contents of:

```text
docs/05-persistence-and-backup.md
```

Include the backup plan and restore procedure.

![alt text](screenshots/07_29_a.png)
![alt text](screenshots/07_29_b.png)
![alt text](screenshots/07_29_c.png)
![alt text](screenshots/07_29_d.png)
![alt text](screenshots/07_29_e.png)

---

# Task 6 — Configure Logging and Observability

## Goal

Configure useful reverse-proxy and backend logs without exposing sensitive information.

### Evidence

#### Screenshot 30 — Logging Configuration

Add a screenshot showing:

- Configuration for the selected reverse proxy
- Proxy log format
- Docker Compose host log-directory bind mount

![alt text](screenshots/07_30_a.png)
![alt text](screenshots/07_30_b.png)
![alt text](screenshots/07_30_c.png)

---

#### Screenshot 31 — Persistent Proxy Logs and Backend Logs

Add a terminal screenshot showing:

- Selected reverse-proxy logs available from the host directory after a proxy restart
- Backend logs displayed through Docker Compose

![alt text](screenshots/07_31.png)

---

### Notes

Write a short note covering:

- The selected reverse proxy
- Host path used for reverse-proxy logs
- How backend logs are viewed
- Whether JSON or standard text logs were used
- Why passwords, tokens, headers, and database connection strings must not appear in logs

Reverse Proxy and Logging

1. Selected Reverse Proxy

I selected Nginx as the reverse proxy for The EpicBook application. Nginx receives incoming HTTP requests on port 80 and forwards them to the appropriate backend or frontend service. It provides a single public entry point while keeping the backend and database ports private.

2. Host Path for Reverse-Proxy Logs

The intended host directory for storing reverse-proxy logs is ~/theepicbook/logs/. A Docker Compose bind mount can make Nginx access and error logs available on the EC2 host for troubleshooting and monitoring.

3. Viewing Backend Logs

Backend application logs can be viewed using the following Docker command:

bash
docker compose logs backend


Alternatively, the command docker logs backend displays logs directly from the backend container. These logs help identify application errors and database connection problems.

4. Log Format Used

Standard text logs were used for the application and container monitoring. Docker captures the container output, which can be inspected using Docker logging commands. JSON-formatted application logging was not specifically configured.

5. Importance of Protecting Sensitive Information in Logs

Passwords, authentication tokens, authorization headers, and database connection strings must never appear in logs because they may expose confidential information. If attackers gain access to these logs, they could use the leaked credentials to access application services or databases.

Avoiding sensitive information in logs protects user data, reduces security risks, and follows the principle of least privilege.

Conclusion

Nginx provides a controlled entry point for The EpicBook application, while Docker logging supports troubleshooting and monitoring. Keeping logs accessible and excluding sensitive information improves application security and maintainability.

---

# Task 7 — Deploy and Verify the Stack on a Cloud VM

## Goal

Deploy the completed Docker Compose stack on an AWS or Azure VM and verify public access.

### Evidence

#### Screenshot 32 — VM Public IP and Inbound Rules

Add a cloud-console screenshot showing:

- VM public IP address
- SSH port 22 restricted to your IP address
- HTTP port 80 allowed from Anywhere

![alt text](screenshots/07_32.png)
![alt text](screenshots/07_32_b.png)

---

#### Screenshot 33 — Cloud VM Stack Verification

Add a VM terminal screenshot showing:

- Docker Compose service status
- Successful public health or API response
- No published database, frontend, or backend ports

![alt text](screenshots/07_33.png)

---

#### Screenshot 34 — EpicBook Application on Cloud VM

Add a browser screenshot showing the EpicBook application loaded through the VM public IP address.

Add your full name as a clear caption below the screenshot.

![alt text](screenshots/07_34.png)

---

### Notes

Write a short note covering:

- Cloud provider used
- VM operating system
- Public port exposed
- Security rules configured
- Confirmation that the application and backend API worked through the reverse proxy

Cloud Deployment and Security

I deployed The EpicBook application on an Amazon Web Services (AWS) EC2 Ubuntu instance using Docker Engine and Docker Compose. The application consists of four containerized services: MySQL database, Node.js backend, frontend, and Nginx reverse proxy.

Cloud Provider: Amazon Web Services (AWS)

Virtual Machine: Ubuntu Linux EC2 instance

Public IP Address: 98.91.227.108

Application URL: http://98.91.227.108

Public Port: TCP port 80 (HTTP)

Private Ports: TCP port 3306 for MySQL, TCP port 8080 for the backend, and the frontend's internal TCP port 80.

I configured the AWS security group to allow HTTP traffic on port 80 from anywhere while restricting SSH access on port 22 to my IP address. Unnecessary public HTTPS access on port 443 was removed.

Nginx serves as the application's reverse proxy and is the only container that publishes a port to the EC2 host. The backend, frontend, and MySQL database communicate through Docker's internal networks without exposing their application ports publicly.

I verified the deployment using Docker Compose and confirmed that all four containers were running with healthy statuses. I also tested the homepage, /health endpoint, and frontend CSS asset through the reverse proxy. All three requests returned HTTP 200, confirming successful routing and communication between the services.

A non-destructive Docker Compose shutdown and startup test was also performed, and the database records remained intact, demonstrating persistent storage and successful service recovery.

---

# Task 8 — Automate Deployment with CI/CD (Optional)

## Goal

Optionally automate image build, image push, and deployment through GitHub Actions or Azure Pipelines.

### Optional Evidence

#### Optional Screenshot — Successful CI/CD Pipeline Run

Add a screenshot showing a successful pipeline run with build, image push, deployment, and verification stages.

![alt text](screenshots/CI-CD_a.png)
![alt text](screenshots/CI-CD_b.png)
![alt text](screenshots/CI-CD_c.png)

---

### Optional Notes

Write a short note covering:

- CI/CD platform used
- Image-tagging method
- Registry used
- Deployment trigger
- Manual approval or secret-handling approach

CI/CD Implementation Notes

For this task, I implemented a CI/CD workflow for The EpicBook application using GitHub Actions, GitHub Container Registry (GHCR), Docker, and AWS EC2.

CI/CD Platform: GitHub Actions  
Pipeline Trigger Branch: main
Workflow File: .github/workflows/deploy.yml  
Container Registry: GitHub Container Registry (GHCR)  
Image Tagging Method: Full Git commit SHA  
Cloud Deployment Platform: AWS EC2 (Ubuntu Linux)  
Deployment Method: Manual deployment of CI-built images using Docker Compose  
Health Verification: Public /health endpoint

 1. Pipeline Configuration and Trigger

I created a GitHub Actions workflow that runs automatically whenever changes are pushed to the main branch. The workflow can also be started manually using the workflow_dispatch trigger.

The pipeline uses a build matrix to build separate production Docker images for the backend and frontend services.

2. Docker Image Building and Tagging

The workflow builds the backend image from backend/Dockerfile and the frontend image from frontend/Dockerfile.

Each image is tagged with the full Git commit SHA to provide a unique, traceable version. For the successful pipeline run, the commit SHA was:

3c8ec2cfef40b7d597e167fd4ab5c516e42c8bd7

This tagging approach makes it possible to identify exactly which application version was built and deployed.

3. Container Registry and Security

After building the images, GitHub Actions automatically pushes them to GitHub Container Registry.

The published images are:

- ghcr.io/ransfordselormdzandu/epicbook-backend
- ghcr.io/ransfordselormdzandu/epicbook-frontend

The workflow authenticates to GHCR using GitHub's built-in GITHUB_TOKEN rather than hardcoding registry credentials.

The application's database credentials remain in the EC2 instance's local .env file, which is excluded from Git tracking.

4. Deployment to AWS EC2

I successfully downloaded both published Docker images from GHCR onto my AWS EC2 instance.

I created a separate docker-compose.prod.yml file to reference the versioned production images while preserving the original Docker Compose configuration.

I then manually deployed the backend and frontend images using Docker Compose. The deployment preserved the existing MySQL database container, reverse proxy, internal networks, and persistent database volume.

After deployment, all four services—database, backend, frontend, and reverse proxy—were confirmed healthy.

5. Deployment Verification

I verified the deployment by accessing the public health endpoint:

http://98.91.227.108/health

The endpoint returned HTTP 200 OK, confirming that the reverse proxy could successfully communicate with the deployed backend.

Docker Compose also confirmed that only the reverse proxy published port 80 to the host, while the backend and database ports remained private.

6. Pipeline Results and Implementation Scope

The GitHub Actions workflow completed successfully, including both backend and frontend image builds and pushes to GHCR.

The published images were successfully pulled and manually deployed to EC2, and the public health check passed.

The automatic EC2 deployment stage was not implemented because Task 8 was optional. Therefore, the completed implementation provides automated image building and publishing, with manually executed deployment and verification.

Conclusion

This task gave me practical experience using GitHub Actions to automate Docker image builds, publish versioned images to a container registry, and deploy those images to an AWS EC2 instance.

I also learned the importance of immutable image tags, secure credential management, deployment verification, and preserving persistent database storage during application updates.

---

# Task 9 — Perform Reliability Tests and Create an Operations Runbook

## Goal

Test controlled service failures and document safe operating procedures.

### Evidence

#### Screenshot 35 — Backend Failure and Recovery

Add a terminal screenshot showing:

- Backend failure test
- Expected unavailable response through the reverse proxy
- Backend restart
- Successful health-check recovery

![alt text](screenshots/07_35.png)
![alt text](screenshots/07_35_b.png)

---

#### Screenshot 36 — Database Failure and Recovery

Add a terminal screenshot showing:

- Database outage test
- Failed database-dependent request
- Database restart
- Successful application recovery

![alt text](screenshots/07_36_a.png)
![alt text](screenshots/07_36_b.png)

---

### Notes

Write a short operations runbook covering:

- Safe restart procedure for reverse proxy, frontend, backend, and database
- Backup and restore procedure
- Secret-rotation approach
- Database recovery procedure
- What to check when the application returns an error
- Results of backend and database reliability tests

 #### Backend Failure and Recovery Test ####

I performed a controlled backend failure test to verify the reliability and recovery of The EpicBook application. First, I stopped the backend container using docker stop backend. I then accessed the application health endpoint through the Nginx reverse proxy and received an HTTP 502 Bad Gateway response, confirming that the backend was unavailable.
Next, I restarted the backend container using docker start backend. Docker confirmed that the backend returned to a healthy state. I tested the health endpoint again and received HTTP 200 OK with the response {"status":"ok"}.

Result: The backend recovered successfully without rebuilding containers or deleting application data.

### Database Failure and Recovery Test ####

I performed a controlled database failure test to verify how The EpicBook application responds when MySQL becomes unavailable.
First, I stopped the MySQL container using docker stop database. I then tested the application's health endpoint through the Nginx reverse proxy. The application returned HTTP 503 Service Unavailable with the message {"status":"unavailable"}, confirming that the backend detected the database outage.

Next, I restarted the MySQL container using docker start database. After the database restarted, I checked the container status and confirmed that both the database and backend were healthy.
Finally, I tested the application health endpoint again and received HTTP 200 OK, confirming that the backend successfully reconnected to MySQL and the application recovered.

Result: The database failure was detected correctly, and the application recovered successfully without removing containers or deleting persistent database storage.

---

# Final Public Application URL

**EpicBook URL:** http://98.91.227.108

Replace the placeholder with your working public URL.

---

# GitHub Repository URL

**Your Fork or Repository URL:** https://github.com/ransfordselormdzandu/theepicbook.git

---

# LinkedIn Requirement

## Goal

Create a professional LinkedIn post of 6–10 lines about your EpicBook capstone deployment.

Your post must include:

- The architectural decision that most improved reliability
- Your biggest image-size reduction, with numbers
- Key production-hardening lessons
- A deployment verification image

### Evidence

**LinkedIn Post URL:** https://www.linkedin.com/posts/ransfordselormdzandu_from-containerization-to-cloud-deployment-share-7515822214034837504-G076/?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEwl7_QBxhr73Ja5tGLqw7xByGHiHbrAk08

#### LinkedIn Post Screenshot

![alt text](screenshots/LinkedIn_1.png)
![alt text](screenshots/LinkedIn_2.png)

---

# Submission Checklist

- [ ] EpicBook repository reviewed and architecture diagram created
- [ ] Environment variables, ports, persistence, and health-check details documented
- [ ] Backend and frontend production Dockerfiles created
- [ ] Backend runs as a non-root user
- [ ] Docker image-size comparison completed
- [ ] Docker Compose stack includes reverse proxy, frontend, backend, and database
- [ ] `front-tier` and `back-tier` networks configured
- [ ] `db_data` named volume configured
- [ ] MySQL, backend, frontend, and reverse-proxy health checks configured
- [ ] Startup dependencies use `service_healthy`
- [ ] Nginx or Traefik selected as the only public reverse proxy
- [ ] Only reverse-proxy port 80 is publicly published
- [ ] Same-origin routing configured and CORS used only when required
- [ ] Backup, restore, and persistence testing completed
- [ ] Reverse-proxy and backend logs verified
- [ ] Cloud VM deployment verified through the public IP
- [ ] Backend and database reliability tests completed
- [ ] Screenshots 1–36 included
- [ ] Required notes completed
- [ ] LinkedIn post URL and screenshot included
- [ ] Full name visible in required screenshots or captions
- [ ] No passwords, tokens, private keys, account IDs, or other sensitive information exposed

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://dmi.pravinmishra.com?utm_source=github&utm_medium=readme  
- 🎓 University: https://university.pravinmishra.com?utm_source=github&utm_medium=readme  
- 💬 Discord Community: https://discord.pravinmishra.com?utm_source=github&utm_medium=readme  
- 📝 Blog: https://dmi.pravinmishra.com/blog?utm_source=github&utm_medium=readme  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) — Agentic AI Track.*
