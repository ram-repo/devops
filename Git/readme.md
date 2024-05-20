# Git Concepts

## Version Control System (VCS)
Git is a distributed version control system used for tracking changes in source code during software development.

## Repository (Repo)
A repository is a storage location where Git keeps the files and metadata for a project. It can be local or hosted on a remote server.

## Commit
A commit is a snapshot of changes to the repository. It records changes to one or more files along with a commit message describing the changes.

## Branch
A branch is a parallel version of the repository that allows for independent development without affecting the main codebase. Branches can be created, merged, and deleted.

### Branching Strategies
- **Feature Branching**: Each new feature or bug fix is developed in its own branch, which is later merged into the main branch (e.g., master or main).
- **Gitflow Workflow**: A branching model that defines a strict branching structure with dedicated branches for features, releases, and hotfixes.
- **Trunk-Based Development**: Development primarily occurs on a single branch (e.g., master or main), promoting frequent integration and continuous delivery.

## Merge
Merging combines changes from one branch (the source branch) into another (the target branch). It integrates the changes while preserving the commit history.

## Rebase
Rebasing integrates changes by moving or reapplying commits from one branch onto another. It results in a linear commit history but should be used cautiously to avoid rewriting shared history.

## Cherry-pick
Cherry-picking allows you to select and apply specific commits from one branch to another. It's useful for applying individual changes without merging entire branches.

## Pull Request (PR)
A pull request is a request to merge changes from one branch into another. It allows collaborators to review and discuss proposed changes before they are merged.

## Remote
A remote is a version of the repository stored on another computer or server. It can be used for collaboration and sharing changes with others.

## Clone
Cloning creates a local copy of a remote repository on your machine. It allows you to work on the code locally and synchronize changes with the remote repository.

## Conflict
A conflict occurs when Git cannot automatically merge changes from different branches. It requires manual intervention to resolve conflicting changes.

## Tag
A tag is a named reference to a specific commit in the repository's history. It is often used to mark release versions or significant milestones.

## Ignore File (.gitignore)
A .gitignore file specifies intentionally untracked files that Git should ignore. It helps prevent irrelevant files (e.g., build artifacts, logs) from being committed to the repository.

## Submodule
A submodule allows you to include another Git repository as a subdirectory within your own repository. It enables modular code organization and dependency management.

## Git Workflow
A Git workflow defines a set of conventions and practices for collaborating on a project using Git. Common workflows include:
- **Centralized Workflow**: A single, shared repository where all contributors commit directly to the main branch.
- **Feature Branch Workflow**: Each new feature or bug fix is developed in its own branch and later merged into the main branch via pull requests.
- **Gitflow Workflow**: A branching model with dedicated branches for features, releases, and hotfixes, facilitating parallel development and release management.
- **Forking Workflow**: Contributors fork the main repository, make changes in their own fork, and propose changes via pull requests.
