# Node.js App Deployment with CI/CD on AKS

This project demonstrates automated deployment of a Node.js application to **Azure Kubernetes Service (AKS)** using **GitHub Actions CI/CD pipeline**.

---

## 🧱 Project Structure

├── app/ # Node.js application source code
├── Dockerfile # Docker image build instructions
├── terraform/ # Terraform files for Azure infrastructure
└── .github/
└── workflows/
└── ci-cd.yaml # GitHub Actions pipeline definition

---

## ⚙️ CI/CD Pipeline Overview

The pipeline automatically:
1. **Builds** the Node.js Docker image.
2. **Pushes** the image to **Azure Container Registry (ACR)**.
3. **Deploys** the image to **Azure Kubernetes Service (AKS)**.

### Workflow Steps

- **Trigger:** On every `push` to the `main` branch.  
- **Build & Push Image:** Uses `docker build` and `docker push` commands.  
- **Deploy:** Uses `kubectl apply` to update AKS with the new image version.

---

## ☁️ Prerequisites

- Azure account
- AKS cluster and ACR created
- GitHub repository connected to your Azure credentials (via secrets)
- Terraform for infrastructure setup (optional if already created)

---

## 🧩 Deployment Files

### **Deployment YAML**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nodejs-app
  template:
    metadata:
      labels:
        app: nodejs-app
    spec:
      containers:
      - name: nodejs-container
        image: <your-acr-name>.azurecr.io/node-demo:v1
        ports:
        - containerPort: 3000
```
---
### **Service YAML**
```
apiVersion: v1
kind: Service
metadata:
  name: nodejs-service
spec:
  type: LoadBalancer
  selector:
    app: nodejs-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
```
---
### 🌐 Accessing the Application

After successful deployment:
```
kubectl get svc
```
---
Find the EXTERNAL-IP for nodejs-service.
Open it in your browser:
```
http://<EXTERNAL-IP>
```
---
### 🧠 Notes

CI/CD pipeline automates manual steps such as building, pushing, and deploying the image.

You can manually trigger the pipeline from the GitHub Actions tab.

Use kubectl get pods and kubectl logs <pod-name> for debugging.

---
### 📸 Example Output

After deployment, visiting the LoadBalancer IP in the browser should display your Node.js app’s homepage or API output.
![nodejs ouput](https://github.com/vijaya3121/nodejs-aks-demo/blob/main/nodejs%20output.png)

---
### 👩‍💻 Author

Developed and automated by Vijaya Reddy as part of a DevOps learning project.



