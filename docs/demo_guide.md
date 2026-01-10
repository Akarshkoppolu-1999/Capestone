# 🎙️ Professional Demo Walkthrough Guide
**Project:** Capstone CI/CD System | **By:** Favour Lawrence

Use this guide to record your video walkthrough or perform a live demonstration.

---

## ✅ Pre-Demo Checklist
- [ ] Docker Desktop is running.
- [ ] Your containers are up (`docker-compose up -d`).
- [ ] Jenkins is open at `localhost:8080`.
- [ ] Your Website is open at `localhost:8081`.
- [ ] GitHub Repository is open.

---

## 🎬 Part 1: Architecture & Code (2 Minutes)
*Goal: Show that you understand the "How" and "Why".*

- **Project Structure**: Point to the `backend/` and `frontend/` folders. Explain why they are separate (2-tier architecture).
- **Backend Dockerfile**: Show the `backend/Dockerfile` and highlight:
  - **Multi-stage Build**: "I used a builder stage to keep the final image small and secure."
  - **Non-root User**: "The app runs as `appuser`, not root, for security."
- **Docker Compose**: Show `docker-compose.yml`. Explain how it orchestrates the **Backend**, **Frontend**, and **PostgreSQL Database** on a single network.

---

## ⚙️ Part 2: The Jenkins Pipeline (3 Minutes)
*Goal: Demonstrate automation and security.*

- **The Pipeline**: Open Jenkins and show the 6 circular stages in the "Stage View".
- **Key Stages to Highlight**:
  - **Unit Tests**: "Every code change is automatically tested using Pytest."
  - **Security Scan**: "We use **Trivy** to scan every build. Only secure images are allowed to proceed."
  - **Push**: "Automated push to Docker Hub ensures our latest version is always ready."
- **Staging Deployment**: Show the `Deploy to Staging` logs. "This stage runs a bash script that verifies the app's health before finishing."

---

## 🌐 Part 3: Live Application (2 Minutes)
*Goal: Show the final result.*

- **Browser View**: Go to `http://localhost:8081`. 
- **System Status**: Show the "Backend: Online" and "Database: Connected" badges.
- **Interaction**: Click the **Refresh Status** button.
- **Staging Verification**: "This represents our **Staging Environment**. Any change I make in code and push to Jenkins will automatically update this site without manual work."

---

## 🏆 Part 4: Conclusion (30 Seconds)
- **Summary**: "We have built a complete, enterprise-grade CI/CD system that automates testing, security, and deployment."
- **Closing**: "Thank you for watching the demo of my Capstone Project."

---

## 💡 Speaker Tips
- **Confidence**: Speak clearly and slowly. 
- **Mouse Movement**: Use your mouse cursor to point at the code lines or buttons you are talking about.
- **Transitions**: Use phrases like "Moving on to the automation part..." or "Now, let's look at the result."
