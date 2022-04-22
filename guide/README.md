

## KBase Build & Release Guide

This guide describes how to set up and use the standard KBase build and release scripts.
These scripts allow KBase developers to:

- Automatically build test images when a pull request is created
- Tag images as `latest` once a pull request is merged
- Create production-ready images with semantic versions (e.g. `1.1.4`) using GitHub's [Release](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases) process
- Enable repos to use optional fully automated [continuous deployment](https://en.wikipedia.org/wiki/Continuous_deployment) to development (e.g. `CI`) enviroments once these environments are deployed on Rancher2.

---

### Contents

#### Enable Build Workflows

  - [New Repository](new-repository.md)
  - [Existing Repository](existing-repository.md)

#### Enable Required Branch Rules

- [Enable `development` and `main`/`master` branch rules](enable-branch-rules.md)

#### 	Workflow Processes

- [Development Workflow](development-workflow.md)
- [Release Workflow](release-workflow.md)


---
**|| Next: [New Repository](new-repository.md) ||**

