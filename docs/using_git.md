# Git walkthrough


It might be useful to read over the general [git section under tooling](../../tooling/using_git.html) 
before reading through but its not necessary. 

Ensure that you have access to the access to GitHub repository. Request access if you do not have it. 


After completing this section you will have: 

1. Set up your computer to communicate with GitHub

2. Completed a sample pull request and created an issue from a demo_project repository


## Connecting to GitHub 

Connection to GitHub cloud server is via a sshkey authentication. This means that you
create a public private ssh key locally and you share your public key pair with GitHub 
which uses a one-way crytographic hash function to authenticate the pair. 

### Local Git installation 

We need a local git installation to use it and to interact with GitHub which is basically a git cloud hosted service with a nice front end. 

#### Installing 

##### Windows

You have two options, one is to [install linux on windows](https://learn.microsoft.com/en-us/windows/wsl/install) and follow Linux/Mac commands 
or you can install a command line emulator as documented below. 

If you decide to use a bash emulator, [see this handy Atlassian tutorial for more info](https://www.atlassian.com/git/tutorials/git-bash)
   
   1. Download and install from [gitforwindow.org](https://gitforwindows.org/)
   
   2. You will be asked about many features, at a minimum you need to install git but there other features that might be worthwhile exploring.

#####  Linux/ Mac

  1. Open command line and type  `git --version` to see if it installed, make sure its the most recent 
  
  2. can be installed via package managers like `apt-get` for Ubuntu or `homebrew` for mac 

#### Configuring 

Users need to set the default email address and name used for git using 

```bash 
git config --global user.name "First Last"
git config --global user.email "first.last@yale.edu"
```
Note that the email should match the email on your github account. 


### Connecting to GitHub 

Authentication happens via [ssh keys](https://en.wikipedia.org/wiki/Public-key_cryptography).  
These are created via the command line and used as a way for third-party's to authenticate with your computer. 
We use and create these to communicate with GitHub. 

Given that we installed git-bash on Windows, the process of creating ssh-keys is the same in all environments and 
involves typing a couple of commands into the terminal. The process creates a ssh-key pair. 
 
  - a public key ,e.g. `id_rsa.pub` with the `pub` stub 
  - a private key, e.g. `id_rsa` which should never be shared
  
  We will share the public key with gitHub. Note a nice overview is [found here](https://www.atlassian.com/git/tutorials/git-ssh)
  
  
### Create ssh keys locally
  
  Open a terminal if using Linux/Mac or gitbash if using Windows and type in the following
  
```bash
  ssh-keygen -t rsa -b 4096 -C "your_email@yale.edu"
```
  
  It will take a second to create ssh-keys for you 
  
```bash
 Generating public/private rsa key pair.
```
 Then it will ask where to save your keys. By default it saves in your home directory under 
 the `.ssh` folder which is hidden by default since it start with a dot. You will need to be able to access the 
 folder to copy in your public key to github. If you are unsure, keep the default. 
 
```bash 
Enter file in which to save the key (/home/user-name/.ssh/id_rsa): 
```

Next it will ask you to create a passphrase. I suggest entering a passphrase that is easy for you to 
remember in that it gives an extra level of protection. 

### Start ssh agents 
Next you will need to start the ssh agent and add your keys to it so your computer knows where to look for them. 
``` bash
 eval "$(ssh-agent -s)"
```

which will return something like `> Agent pid 59566`

Next add your keys to the ssh-agent by 

```bash
ssh-add  /Users/you/.ssh/id_rsa
```

### Share public key with GitHub 

Open up your GitHub account , under your profile there is a setting button, click on that. 
Go to the left hand side and got to the `SSH and GPG keys ` menu 

![Navigating to ssh key](../assets/github-adding-public-sshkey.gif)

Next go ahead and add the public key you [saved above in creating ssh keys](#create-ssh-keys-locally ) by 
clicking on the green button.

![Press green button  ](../assets/github-addsshkey-button.png)

Next you will be prompted with 

![Add public ssh key](../assets/github-add-public-key-button.png)


### Test connection 

Open up a terminal, if your in windows this would be a bash emulator or WSL which runs a linux virtualization within windows.

`ssh -T git@github.com`


## Example workflow example 


Lets use the example repository in our group called [demo_project](https://github.com/DISSC-yale/demo)
to work through and example workflow. 

1. Create an issue and call out a team member 

2. Clone the repository locally 

3. Make changes to the local repository, commit locally 

4. Pushing changes and ensuring you have the most upto date version.

#### 1. Create an issue

Create an issue and call out a team member 

Create an issue in the  [demo_project](https://github.com/DISSC-yale/demo) repository. Note that 
we have created some templates to try to make it easier to decide what should be an issue. In general, 
information about a project or dataset that might be useful for future researchers to have access to are probably a good place to put the here 
. ![Create an issue and call out a team member](../assets/github-demo-create-issue.gif)


#### 2. Clone repo locally 

Go to the  [demo_project](https://https://github.com/DISSC-yale/demo) repository and click on the clone button and copy the ssh code 
![get clone string](../assets/cloning-a-repository.gif)

Next on your local machine open up a terminal or command line and type in the folloiwng 

```bash 
git clone git@github.com:DISSC-yale/demo.git
```
This create a local clone of the git repository so you can make changes. 

Note since we cloned it from github the origin remote is our github repo. 
You can see this by typing 

```bash 
git remote -v 
```
And it prints out the remotes 

```bash 
origin	git@github.com:DISSC-yale/demo.git (fetch)
origin	git@github.com:DISSC-yale/demo.git (push)
```

When we are pushing, pulling and fetching changes we will do this against the `origin` remote which is linked
to github. Note the origin remote could be a forked version or even just another version of the code living in a different path.

#### 3. Make changes locally 

Lets go ahead and make a change to the demo repository. 

 - [ ] Create a file in the repository and add some text to it
 
 You can do this from a linux type terminal by doing the following 
 
 ```bash 
echo "This is a test by user1" >> newfile
 ```

And lets make another file 

 ```bash 
echo "This is a test by user1" >> makingchanges
 ```

#### 4. Update local git repository

Once changes have been made there are two steps to adding them to the git repository. 

You can check the status of your changes by typing in to the command line 
```bash 
git status
```
Which shows
 ![status not staged](../assets/gitlocal-status-not-staged.png)
 
 If you are using a full fledged text editor you can avoid the command line, for example here is what it looks like in vscode
 and the changes show up automatically in the text editor and its very easy to see what has changed. 
 ![vscode-status](../assets/vscode-git-status.png)

 
#####  Prep-changes to be added (Stage)
`Stageing`  has two functions, it allows you to easily checkpoint change you are making so you can track difference and it 
allows you to group changes together so they can be ready to be commited. 

We go ahead and stage changes by using an IDE or by using 

```bash 
git add makingchanges newfile 
```

Then by checking on `git status`

 ![status not staged](../assets/gitlocal-status-staged.png)


#####  Adding changes to repository (Commit)

So we have our changes staged, next we add them to the repository. This is immutable, once a change is commited 
it stays in the log. You are also prompted for message to the changes you are adding. 

You should make things as concise as possible and focus on the **WHY** of the change, since its pretty easy to look at diffs. 
If the change is addressing a bug  or an issue it worth adding a link to the commit about that as well. 

Not you can add the message in the command line 
```bash
git commit -m "Testing out git functionality"
```

Or leave it out, in which case a text editor will open for you to make the change. The first line is often very concise and the body can be much longer if you want. If you have a long message its worth using `git commit`
```bash
git commit
```


#### 5. Update GitHub 

#####  Send (push) local changes to Github 

Now the local repository is out of sync with the repository hosted at GitHub. Local changes to need to be 
sent or pushed in git terminology to github. 

Pushing changes takes two parameter 
   1. git remotes which are the  location of other copies of the repo. When you clone a repo from GitHub the default name is `origin` 
   2. A branch so git know where to put our changes 
   
   The remote is pretty clear, its `origin` and can be checked with `git remote -v`. The branch is more flexible and in line with our
   workflow, the main branch can not have any changes pushed to it. Each user will push there changes to branch of there choosing, 
   in general it should be there name. 
   
   Locally we are working on the `main` branch by default and that can be checked by `git branch`.
   
   So we use the `git push` command and the remote we want to push it to, `origin` and a branch. If the branch does not exist
   we use the following `main:maurice` which says send the `main` local branch to remote `maurice` branch 
   
   ```bash
   git push origin main:origin/maurice
   ```

All of this is made much easier by using an IDE like EMACS or Vscode. 

#####  Create a pull  request on GitHub 
 
 Go to the GitHub reposotory and there should be a green blob at the top that says, you have a new branch. 
 Do you want to create a pull request. Click on it. 
 
 You are prompted to write a little about the pull request. Again focusing on the why or referencing relevent issues, emails or pr are worth while. 
 
 Add a reviewer if you want someone to take a look. 
 
 Create the pull request.
 
 Once you create it there is the ability to add comments around the code. 
 
Someone needs to accept the pull request before it gets merged in. If you want someone to take a look they will do that. if you are 
just documenting changes you made, e.g. these are the changes for the conference. You can accept the change and merge it yourself. 

![GitHub pull request](../assets/github-pull-request.gif)
 
 
#### 6.  Get new GitHub change locally (fetch-pull)

If you are working with someone else or returning to a repository where many people are making changes. Its best to 
make sure you have all of the most recent changes. 

`git fetch origin ` will get all changes on origin 
`git pull origin main ` will pull all of the changes from origin on the main branch to the current branch. 

- may cause some conflict 
- git pull only brings things in from the last git fetch, so important to run git fetch so changes in the 
 cloud are cached or flagged locally.


# Using IDES 

Using git is much easier if you use and IDE like vscode or emacs or local gui front end like gitKraken.

For example this is what it looks like in emacs 

![Emacs magit](../assets/emacs-magit-showcase.gif)


# Other resources 

- [Reading on some common git workflow](https://www.atlassian.com/git/tutorials/comparing-workflows)

- [Overview of some common git syncing commands ](https://www.atlassian.com/git/tutorials/syncing)

- [BitBucket is a GitHub competitor but has good documention](https://www.atlassian.com/git/tutorials/what-is-version-control)

-  [More BitBucket reading on setting up a repo](https://www.atlassian.com/git/tutorials/setting-up-a-repository)
  
