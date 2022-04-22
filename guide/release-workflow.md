## KBase Release Workflow

**Contents**

- [Prerequisites](#prerequisites)
- [Summary](#summary)
- [Process Details](#process-details)
   1. [Create a Pull Request](#1-create-a-pull-request)
   2. [Test Image](#2-test-image)
   3. [Merge Pull Request](#3-merge-pull-request)
      - [Merge Pull Request Demo](#merge-pull-request-demo)
      - [Automatic Image Tagging](#automatic-image-tagging)
   4. [Create Release](#4-create-release)
      - [Create Release Demo](#create-release-demo)


---



### Prerequisites

The KBase Release workflow requires the following:

1. The `develop` branch must contain all code that is to be released.
   - See the [Development Workflow](development-workflow.md) for more
2. The `pr_build.yml` and `prod_release.yml` workflows described in the [New Repository](new-repository.md) and [Existing Repository](existing-repository.md) sections must be present in the repo.
3. The branch rules discussed in [Enable Branch Rules](enable-branch-rules.md) must be enabled.


### Summary 

- To start the production release process, a pull request from `develop` to `main` or `master` is created.
- On pull request creation, an image is built with a tag that matches the pull request (e.g. `{REPONAME}:pr-42`)
- The developer repsonsible for releases merges the pull request, which tags the image as `{REPONAME}:latest-rc`
- A production release is created using the GitHub [Create a release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository#creating-a-release) process.
- A final production image is tagged as `{REPONAME}:x.x.x` and  `{REPONAME}:latest`

---

### Process Details

Before proceeding, please confirm that all prerequisites above are met.

#### 1. Create a Pull Request

To start the release process, create a pull request from the `develop` branch to the `main` or `master` branch.

See the [Development Workflow](development-workflow.md) for general steps, making sure to create a pull request from `develop` to `main` or `master`.


#### 2. Test Image

When a pull request to `main` or `master`  is created or updated, the `pr_build.yml` workflow will automatically start building a test image. To utilize this image for testing in non-prod environments:

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Instructions</summary>

1. Allow the `pull_request` job in the `Build & Tag Image on PR` workflow to complete.
   - The status of of the build will be visible in the `Checks` section of the pull request
   - The status can also be viewed from the `Actions` tab. 
2. Once the build completes successfully, click the `Code` tab in the repo.
3. Navigate to the `Packages` section on the right of the screen, and click `{REPONAME}`.
4. In the packages view, confirm that an image matching the pull request number exists (e.g. `{REPONAME}:pr-42`).
5. Test this image, and optionally deploy to a pre-production environment, such as `next`.

| ⚠️ Where's The Image?                                         |
| :----------------------------------------------------------- |
| If the `{REPONAME}` image doesn't appear under the `Code` tab under `Packages`, ask a KBase administrator to make the image public & link the package to the repo. |

</details>


#### 3. Merge Pull Request

Once all builds pass, and the images have been tested in a pre-production enviroment, request a [pull request review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/requesting-a-pull-request-review) from another developer with access to the repo in question.

##### Merge Pull Request Demo

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Demo</summary>

This demo shows a pull request from a feature branch to `develop`, but the process is the same for a pull request from `develop` to `main` or `master`.

![MergePR](https://user-images.githubusercontent.com/6155956/164587922-bf48b32e-7d87-4345-b03e-dae8b0057bac.gif)

</details>

##### Automatic Image Tagging

After the pull request is merged, the `Build & Tag Image on PR` workflow will trigger the `tag_on_merge` job, which automatically tags the image created above as `latest-rc`. This image is now ready to be deployed to `next` or other pre-production environments.

#### 4. Create Release

1. Once the code in the repo's `main` or `master` branch is ready to be deployed to production, use the GitHub [Creating a Release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository#creating-a-release) process to build a new semantic release.
2. Make sure the release is using `Target:` `main` or `master`.
3. Enter a new tag that uses [semantic versioning](https://semver.org/).
4. Once released, a new image will be deployed as `{APPNAME}` with both the semantic version and `latest` as tags.

##### Create Release Demo

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Demo</summary>

This demo shows a pull request from a feature branch to `develop`, but the process is the same for a pull request from `develop` to `main` or `master`.

![ReleaseWorkflow](https://user-images.githubusercontent.com/6155956/164643929-e8342830-0875-4f56-8366-a0d696ad14d1.gif)

</details>

---

**|| Previous: [Development Workflow](development-workflow.md) || [Home](README.md) ||**
