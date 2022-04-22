## KBase Development Workflow

**Contents**

- [Prerequisites](#prerequisites)
- [Summary](#summary) 
- [Process Details](#process-details)
   - [1 .Set Up A Feature Branch](#1-set-up-a-feature-branch)
      - [Option 1: Repo Branch](#option-1-repo-branch)
      - [Option 2: Personal Fork](#option-2-personal-fork)
      - [Create Branch Demo](#create-branch-demo)
   - [2. Develop Improvements](#2-develop-improvements)
   - [3. Create Pull Request](#3-create-pull-request)
      - [Option 1: From a Branch](#option-1-from-a-branch)
      - [Option 2: From a Personal Fork](#option-2-from-a-personal-fork)
      - [Create PR Demo](#create-pr-demo)
   - [4. Test Image](#4-test-image)
      - [Build Develop Image Demo](#build-develop-image-demo)
   - [5. Merge Pull Request](#5-merge-pull-request)
      - [Merge Pull Request Demo](#merge-pull-request-demo)
      - [Automatic Image Tagging](#automatic-image-tagging)

---



### Prerequisites

The KBase Development workflow requires the following:

1. Three branches must exist, named:
   - `main` or `master`
   - `develop`
   - `inbox`
2. The `pr_build.yml` and `prod_release.yml` workflows described in the [New Repository](new-repository.md) and [Existing Repository](existing-repository.md) sections must be present in the repo.
3. The branch rules discussed in [Enable Branch Rules](enable-branch-rules.md) must be enabled.


### Summary 

- All work is performed in feature branches or personal forks
  - Branches should matching any JIRA or GitHub issue numbers
- Feature branches are merged via pull requests to the `develop` branch
  - A test image named `{REPONAME}-develop` is automatically created with a tag that matches the pull request number (e.g.`{REPONAME}-develop:pr-42`)
- Once a pull request is merged to `develop`, the image created above is automatically tagged as `latest`
- Images must initially be [made public](https://docs.github.com/en/packages/learn-github-packages/configuring-a-packages-access-control-and-visibility) by an administrator
- Once the code in the `develop` branch is ready for release, the [Release Workflow](release-workflow.md) is used to create the production image

---

### Process Details

Before proceeding, please confirm that all prerequisites above are met.

#### 1. Set Up A Feature Branch

To start development, first create a feature branch off of `develop`, either in the KBase repo, or in a personal fork.

##### Option 1: Repo Branch

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Instructions</summary>

If you have write access to a repo in the github.com/kbase organization, you can create a feature branch directly in the repo. Simply:

1. Ensure you're currently viewing the `develop` branch.
2. [Create a feature branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository) from `develop` (not main!), giving it the same name as the relevant Jira or GitHub issue (e.g. `PTV-510`).

</details>


##### Option 2: Personal Fork

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Instructions</summary>

If you don't have write access to a repo in the github.com/kbase organization, or if you prefer working in a personal fork, do the following:

1. [Create](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository) or [update](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository) a personal fork of the KBase repo in question.
2. Ensure the `develop` branch is up to date with the original KBase repo.
3. [Create a feature branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository) from `develop` (not main!), giving it the same name as the relevant Jira or GitHub issue (e.g. `PTV-510`).

</details>


##### Create Branch Demo

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Demo</summary>

![CreateBranch](https://user-images.githubusercontent.com/6155956/164559332-da5d531f-5681-4699-a680-962f91f7dbde.gif)

</details>


#### 2. Develop Improvements

Perform any development work in the feature branch created above. Commit early and commit often!

#### 3. Create Pull Request

When any changes in the feature branch are ready for testing and merging to the `develop` branch, [create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) using one of the following techniques:

##### Option 1: From a Branch

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Instructions</summary>

If you're using a feature branch in the original github.com/kbase repo, simply:

1. [Create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) from your feature branch, to the `develop` branch.
1. Review the newly created pull request, and [update your feature branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/keeping-your-pull-request-in-sync-with-the-base-branch#updating-your-pull-request-branch) if requested.

</details>


##### Option 2: From a Personal Fork

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Instructions</summary>

If you're using a personal fork:

1. [Create a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) from the feature branch in your fork to the `inbox` branch in the original github.com/kbase repo.
2. Review the newly created pull request, and [update your feature branch](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/keeping-your-pull-request-in-sync-with-the-base-branch#updating-your-pull-request-branch) if requested.
3. Request that a developer with write access to the original repo review the pull request to `inbox`.
4. Once merged to `inbox`, request that a developer with write access to the original repo create a pull request from `inbox` to `develop`.

   
| ℹ️ Why We Use `inbox` With Forks                      |
| :----------------------------------------------------------- |
| Due to a security feature in GitHub Actions, pull requests from a fork can't make use of automated build scripts in the original repository. <br /><br />Pull requests from forks must be merged to `inbox` first, to ensure no malicious code has been added to the workflow code. Once merged to `inbox`, the build scripts will work normally via a pull request from `inbox` to `develop`. |

</details>

##### Create PR Demo

<!-- This code creates a simple dropdown -->
<details>
<summary>   Expand For Demo</summary>

![PullRequest](https://user-images.githubusercontent.com/6155956/164575563-7add0f2e-e334-4807-bbf7-6bd92b03ab83.gif)

</details>


#### 4. Test Image

When a pull request to `develop` is created or updated, the `pr_build.yml` workflow will automatically start building a test image. To utilize this image for testing in non-prod environments:

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Instructions</summary>

1. Allow the `pull_request` job in the `Bueild & Tage Image on PR` workflow to complete.
   - The status of of the build will be visible in the `Checks` section of the pull request
   - The status can also be viewed from the `Actions` tab. 
2. Once the build completes successfully, click the `Code` tab in the repo.
3. Navigate to the `Packages` section on the right of the screen, and click `{REPONAME}-develop`.
4. In the packages view, confirm that an image matching the pull request number exists (e.g. `{REPONAME}-develop:pr-42`).
5. Test this image, and optionally deploy to a non-production environment.

| ⚠️ Where's The Image?                                      |
| :----------------------------------------------------------- |
| If the `{REPONAME}-develop` image doesn't appear under the `Code` tab under `Packages`, ask a KBase administrator to make the image public & link the package to the repo. |
   
</details>

##### Build Develop Image Demo

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Demo</summary>

   
Demonstrates:
- The automatic build process
- How to view builds in the pull request
- How to view builds in the Actions tab
- Location of the `{REPONAME}-develop` images
- How image tags match their respective pull request numbers
   


![BuildDevelopImage](https://user-images.githubusercontent.com/6155956/164583409-a93ae22b-a38a-44ba-83d9-64f4358eb406.gif)
   
</details>


#### 5. Merge Pull Request

Once all builds pass, and the images have been tested in a non-production enviroment, request a [pull request review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/requesting-a-pull-request-review) from another developer with access to the repo in question.

After approving and merging the pull request, please delete the source branch (unless the source branch is `inbox`, due to the forking workflow)

##### Merge Pull Request Demo

<!-- This code creates a simple dropdown -->
<details>
<summary>Expand For Demo</summary>

![MergePR](https://user-images.githubusercontent.com/6155956/164587922-bf48b32e-7d87-4345-b03e-dae8b0057bac.gif)
   
</details>

##### Automatic Image Tagging

After the pull request is merged, the `Build & Tag Image on PR` workflow will trigger the `tag_on_merge` job, which automatically tags the image created above as `latest`. This image is now ready to be deployed to `CI` or other non-production environments.

| 🎬 Coming Soon - Continuous Delivery                          |
| :----------------------------------------------------------- |
| Once all non-production environments are migrated to Rancher 2, developers will have the option to automatically deploy the `latest` image to a development cluster when a pull request is merged! |

---
**|| Previous: [Enable Branch Rules](enable-branch-rules.md) || [Home](README.md) || Next: [Release Workflow](release-workflow.md) ||**
