# GitHub Actions and JFrog Integration with OIDC Example

This example repository demonstrates how to seamlessly integrate GitHub Actions with JFrog, leveraging OpenID Connect (OIDC) for secure and authenticated interactions. This integration ensures a streamlined and automated workflow for managing artifacts with JFrog Artifactory in your GitHub repositories.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Workflow Overview](#workflow-overview)
- [Configuration](#configuration)
- [Secrets](#secrets)
- [References](#references)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This example illustrates how to set up GitHub Actions workflows to interact with JFrog Artifactory using OpenID Connect (OIDC) for authentication. GitHub Actions provide a powerful and automated way to build, test, and deploy your applications, and integrating JFrog adds efficient artifact management to the process.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- A GitHub account
- A JFrog Artifactory account
- Local/Remote and Virtual NPM Repository created for Build, to Resolve and Deploy(see documentation)
- OIDC configured in JFrog Artifactory (see documentation)

## Getting Started

1. Clone this repository:

```
git clone https://github.com/jfrog/trainings.git
cd trainings
```

2. Customize the GitHub Actions workflows in the `.github/workflows` directory to suit your project's needs.

3. Update the configuration files and scripts as required for your specific use case.

4. Commit your changes and push them to your GitHub repository.

5. Check the Actions tab on your GitHub repository to see the workflow in action.

## Workflow Overview

The workflow in this example includes the following steps:

1. **Build**: Build your project using GitHub Actions.
2. **Authenticate with JFrog**: Authenticate with JFrog Artifactory using OIDC.
3. **Publish Artifact**: Publish the built artifact to JFrog Artifactory.

## Configuration

Adjust the configuration files to match your project structure and requirements:

- `.github/workflows/github-oidc.yml`: GitHub Actions workflow configuration.


## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [JFrog Artifactory OIDC Documentation](https://jfrog.com/help/r/jfrog-platform-administration-documentation/github-actions-oidc-integration-workflow)
- [OpenID Connect (OIDC) Documentation](https://openid.net/connect/)

## Contributing

Feel free to contribute to this example by creating issues or pull requests. Your feedback and contributions are highly appreciated!

## License

This example repository is licensed under the [MIT License](LICENSE).

---

**Disclaimer**: This example is for educational and illustrative purposes. Ensure you adhere to the terms and conditions of GitHub and JFrog when using their services.
