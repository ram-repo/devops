
# Git

```bash
# Install Git
# For Debian/Ubuntu
sudo apt-get install git

# For MacOS using Homebrew
brew install git

# For Windows, download the installer from https://git-scm.com/
```

# Configure Git
```bash
# Set your username
git config --global user.name "Your Name"

# Set your email
git config --global user.email "your.email@example.com"

# Set your preferred text editor
git config --global core.editor "code --wait" # For VSCode

# Check Configuration
git config --list
Creating and Cloning Repositories
```

# Initialize a new Git repository
```bash
git init

# Clone an existing repository
git clone <repository-url>
Basic Workflow

# Check the status of your repository
git status

# Add changes to the staging area
git add <file> # Add a specific file
git add .      # Add all changes in the current directory

# Commit changes
git commit -m "Your commit message"

# Push changes to a remote repository
git push origin <branch-name>

# Pull changes from a remote repository
git pull origin <branch-name>
```

# Branching and Merging

```bash
# Create a new branch
git branch <branch-name>

# Switch to a branch
git checkout <branch-name>

# Create and switch to a new branch
git checkout -b <new-branch-name>

# Merge a branch into your current branch
git merge <branch-name>
```
# Viewing History

```bash
# View commit history
git log

# View a summarized commit history
git log --oneline --graph --decorate --all
```
# Undoing Changes
```bash
# Unstage a file
git reset <file>

# Revert changes in a file
git checkout -- <file>

# Reset to a specific commit
git reset --hard <commit-hash>
```
# Working with Remotes

```bash
# Add a remote repository
git remote add <remote-name> <repository-url>

# View remote repositories
git remote -v

# Fetch changes from a remote repository
git fetch <remote-name>
```
# Advanced Commands

```bash
# Rebase a branch
git rebase <branch-name>

# Cherry-pick a commit
git cherry-pick <commit-hash>
```
# Cleaning Up

```bash
# Remove untracked files
git clean -f
