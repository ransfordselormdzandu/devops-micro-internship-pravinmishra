# Assignment 4 — Building Your AI Team

Part of the DevOps Micro Internship (DMI) Cohort 3 with Agentic AI

---

## Purpose

In this assignment, you will build and configure a set of specialized AI subagents inside your project. You will learn how different models and tool permissions define agent behavior, and you will trigger two real agent delegations to analyze security and cost aspects of your Terraform infrastructure.

---

# Task 1 — Create the Agents Folder and Add Files

## Goal

Create the `.claude/agents/` directory and add all required agent files.

### Evidence

#### Screenshot 1 — VS Code sidebar showing `.claude/agents/` with all 3 files

![.claude/agents/](screenshots/04_01.png)

---

# Task 2 — Compare the Agent Configurations

## Goal

Analyze the configuration differences between the three agents and demonstrate understanding of model and tool selection.

### Written Answers

#### 1. Why does the cost optimizer use Haiku instead of Sonnet?

Cheaper — reduces the cost of running the optimizer itself
Fast — handles simple repetitive tasks quickly
Right-sized — optimization tasks don't need Sonnet's advanced capabilities

Its always prudent to use the simplest model that gets the job done, no need for a powerful model to do simple comparisons and analysis.

---

#### 2. Why does the security auditor NOT have Write in its tools list?

The security auditor has no Write tools because:

Read-only by design — its job is to audit and review, not make changes
Least privilege — only gets permissions it actually needs
Prevents accidental modifications — can't tamper with what it's auditing
Maintains integrity — audit results stay trustworthy

A security auditor observes and reports, it never modifies. It does not have editing and writing rights. 

---

#### 3. Why does the tf-writer use `inherit` instead of a specific model?

The tf-writer uses inherit instead of a specific model because:

Flexibility — automatically uses whatever model the parent/caller is using
Consistency — ensures the same model is used throughout the workflow
No hardcoding — avoids being locked to a specific model version
Easy updates — when the parent model changes, tf-writer updates automatically

inherit means use whatever model is already being used thus keeping everything consistent without hardcoding a specific model. 

---

### Evidence

#### Screenshot 2 — `security-auditor.md` frontmatter showing model and tools configuration

![security-auditor.md frontmatter](screenshots/04_02.png)

---

#### Screenshot 3 — `cost-optimizer.md` frontmatter showing the model and tools configuration

[Cost-optimizer.md frontmatter](screenshots/04_03.png)

---

# Task 3 — Run the Security Auditor

## Goal

Trigger the security auditor agent and analyze the generated security report for your Terraform infrastructure.

### Evidence

#### Screenshot 4 — The delegation message showing Claude launched the security-auditor

![delegation message](screenshots/04_04.png)

---

#### Screenshot 5 — Security audit report output

![security audit report 1](screenshots/04_05a.png)
![security audit report 2](screenshots/04_05b.png)

---

# Task 4 — Run the Cost Optimizer

## Goal

Trigger the cost optimizer agent and review the generated cost optimization report.

### Evidence

#### Screenshot 6 — The full cost optimization report

![full cost optimisation report 1](screenshots/04_06a.png)
![full cost optimization report 2](screenshots/04_06b.png)

---

# Submission Instructions

- Ensure all agent files are committed in `.claude/agents/`
- Complete all written answers in your GitHub Repo
- Push final changes to your forked GitHub repository

---

## GitHub Repository URL

Paste your forked repository URL here:

https://github.com/ransfordselormdzandu/devops-micro-internship-pravinmishra

---

# Completion Checklist

- [ ] `.claude/agents/` folder contains all 3 agent files
- [ ] Screenshot 2 shows correct `security-auditor.md` configuration
- [ ] Screenshot 3 shows correct `cost-optimizer.md` configuration
- [ ] All 3 written answers completed 
- [ ] Security auditor executed successfully
- [ ] Cost optimizer executed successfully
- [ ] Security report is visible with findings
- [ ] Cost report is visible with recommendations
- [ ] All required screenshots added
- [ ] GitHub repo updated with agents

---

## 📌 About DMI & CloudAdvisory

DevOps Micro Internship (DMI) is a project-based DevOps program run by Pravin Mishra (The CloudAdvisory) focused on real-world execution, systems thinking, and career readiness.

It helps learners build strong DevOps foundations with hands-on experience.

---

## 📌 Resources

- 🌐 DMI Official Website: https://pravinmishra.com/dmi  
- 🎓 DevOps for Beginners (Udemy): https://www.udemy.com/course/devops-for-beginners-docker-k8s-cloud-cicd-4-projects/  
- 🎓 Agentic AI DevOps with Claude Code: https://www.udemy.com/course/ultimate-agentic-ai-devops-with-claude-code/  
- 🎓 DevOps with Claude Code: Terraform, EKS, ArgoCD & Helm: https://www.udemy.com/course/devops-with-claude-code-terraform-eks-argocd-helm/  
- ▶️ YouTube Playlist: https://www.youtube.com/playlist?list=PLFeSNDtI4Cho  
- 🔗 Pravin Mishra (LinkedIn): https://www.linkedin.com/in/pravin-mishra-aws-trainer/  
- 🏢 CloudAdvisory (LinkedIn): https://www.linkedin.com/company/thecloudadvisory/

---

*This submission is part of DevOps Micro Internship (DMI) Cohort 3 — Agentic AI Track.*