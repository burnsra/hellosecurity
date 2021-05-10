<div align="center">
	<h1>spring-boot-webapp</h1>
  <p>default Spring Boot web application template</p>
</div>

<p align="center">
	🔩&nbsp;<a href="CONTRIBUTING.md">How to Contribute</a>&nbsp;
	&nbsp;
	💬&nbsp;
	<a href="">Teams channel</a>
</p>

[![GitHub Actions](https://tech-radar-github-app.azurewebsites.net/badges/issues/GitHub%20Actions)](https://github.kroger.com/kt/radar/issues/11)

# Overview <!-- omit in toc -->

This template repository composes [building blocks](https://github.com/krogertechnology/building-blocks) into an end-to-end application delivery pipeline. It extends the generic [`webapp` template](https://github.com/krogertechnology/webapp) with workflows specific to Spring Boot applications.

## Table of Contents <!-- omit in toc -->
- [Development Workflow](#development-workflow)
  - [Provisioning cloud infrastructure](#provisioning-cloud-infrastructure)
  - [Using a feature branch](#using-a-feature-branch)
  - [Review environments](#review-environments)
  - [Automated versioning](#automated-versioning)
  - [Cutover](#cutover)
- [Pipeline](#pipeline)
- [Migration](#migration)
- [Building Blocks](#building-blocks)
- [References](#references)
- [Pipeline](#pipeline)
- [Migration](#migration)
- [Building Blocks](#building-blocks)
- [References](#references)


## Development Workflow

You can tweak this template to fit any unique needs, but it makes a few assumptions including generally-recommended development workflow best practices including:

- Production deployments occur from a protected `"main"` branch
- Pull requests control the flow of changes into the protected branch(es)

### Provisioning cloud infrastructure

This template contains Terraform infrastructure-as-code to manage Azure App Service instances from files in your codebase. You can use other [module building blocks](https://github.com/krogertechnology/building-blocks#-Modules) to stand up various cloud infrastructure. Commit your changes in the `terraform/` directory, and a GitHub Actions workflow will apply them to your environment.

### Using a feature branch

All new development in your repository should happen in unprotected "feature" branches. The GitHub Actions workflow will test your code, build a Docker container, and deploy to dev for each commit. Create a pull request into your protected default branch (`main`), and your team can review feedback from the pipeline before merging the branch. This practice keeps your default branch (from which production code is deployed) pristine with only good code.

### Review environments

The GitHub Actions workflow will deploy a "review app" [deployment](./deployments) for each opened pull request. Once the pull request is closed, GitHub Actions will delete the environment.

### Automated versioning

Label your pull requests with a [semantic versioning](https://semver.org/)-compliant label such as `major` or `minor` and a GitHub Actions workflow will automatically create a new [draft pre-release](./releases) after the pull request has been merged. The workflow posts a message to a configurable Teams webhook with a prompt for a maintainer to publish the release.

The workflow deploys the latest published release to a `staging` slot in the production App Service instance. If a repository maintainer additionally un-selects the pre-release option to mark the release production-ready, the workflow will deploy the release to production using a [slot swap](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots). Alternatively a manually-triggered "cutover" workflow may deploy the staged version to production.

### Cutover

The template includes "cutover" workflows to swap App Service [slots](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots). Use this for a "blue/green" promotion of `staging` (or any release/slot name) to `production`: https://github.com/krogertechnology/spring-boot-webapp/actions?query=workflow%3A"swap+slot+to+production+environment"

## Pipeline

This default web application pipeline uses a container as the common application package format, usually built with a `Dockerfile` in the application repository. This Spring Boot-specific template builds upon this base template.

| Workflow | Trigger | Description |
|---|---|---|
| [`ci.yml`](https://github.com/krogertechnology/spring-boot-webapp/blob/main/.github/workflows/build.yml) | push to `src/` | unit test, Sonar scan, build Docker container, deploy to `dev` (or `test` for `main` branch) |
| [`provision-nonprod.yml`](https://github.com/krogertechnology/spring-boot-webapp/blob/main/.github/workflows/provision-nonprod.yml) | push to `terraform/nonprod` in any branch | apply infrastructure changes in nonprod |
| [`provision-prod.yml`](https://github.com/krogertechnology/spring-boot-webapp/blob/main/.github/workflows/provision-prod.yml) | push to `terraform/prod` in `main` branch | apply infrastructure changes in prod |
| [`review.yml`](https://github.com/krogertechnology/spring-boot-webapp/blob/main/.github/workflows/review.yml) | open pull request | deploy review app for pull request |
| [`review-cleanup.yml`](https://github.com/krogertechnology/spring-boot-webapp/blob/main/.github/workflows/review-cleanup.yml) | close pull request | delete review app for pull request |
| [`version.yml`](https://github.com/krogertechnology/spring-boot-webapp/blob/main/.github/workflows/version.yml) | merge pull request | increment application version and create release |
| [`release-deploy.yml`](https://github.com/krogertechnology/spring-boot-webapp/blob/main/.github/workflows/release-deploy.yml) | create release | tag release artifact and deploy to `staging` slots |

## Migration

- Migrations from GitLab and TeamCity
- SQL data migration

## Building Blocks

Coming soon: Links to building blocks used in this template

## References

Coming soon
