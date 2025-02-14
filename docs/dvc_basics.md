# What is DVC? 

Make sure you have installed it, go to the onboading section 

DVC was built to solve the problem that git does not like it when you add large files into a repository 
but there is value in being able to have your code connected to your data. 

We want to be able to commit, code and data together so its easy to replicate results or debug certain issues which arise. 
DVC makes this a two step process, where code is still added to git but `.dvc` metadata files are added to git which link to a remote location. This remote location 
can be on your machine, on a separate window storage mount or on the cloud. 

## Lets make a repository 

We are interested in studying hospital characteristics. 

#### Create a git repository 
Lets create a git repository to save our code and data. 

```bash
mkdir hospital_characteristics
cd   hospital_characteristics
git init 
```

#### Initialize a DVC repository 
Next lets initialize a DVC repository alongside our 

```bash
dvc init
```
and its spits out 

```bash
(base) maurice@maurice:~/walkthrough/hospital_characteristics$ dvc init
Initialized DVC repository.

You can now commit the changes to git.

+---------------------------------------------------------------------+
|                                                                     |
|        DVC has enabled anonymous aggregate usage analytics.         |
|     Read the analytics documentation (and how to opt-out) here:     |
|             <https://dvc.org/doc/user-guide/analytics>              |
|                                                                     |
+---------------------------------------------------------------------+

What's next?
------------
- Check out the documentation: <https://dvc.org/doc>
- Get help and share ideas: <https://dvc.org/chat>
- Star us on GitHub: <https://github.com/iterative/dvc>
```

#### Lets create some data 
Make sure you are in the repository and lets just save the data at the top of the repository. 

```stata
set obs 50
gen state = _n
save state_data,replace 
```

#### Next add data to DVC

```bash 
dvc add state_data
```
![dvc add ](../assets/example_dvc_add.png)

This does the following things  
  
**Add the file,e.g. `state_data.dta`, to your `.gitignore`**
This ensures that you do not accidentally add the file to git
   
**Create a meta data file*, `state_data.dta.dvc`**  

It creates a file that matches the file you added but with a `.dvc` stub, e.g. `state_data.dta.dvc` 
which containts metadata about the file. Mostly it has the md5 hash for the data you added. 
That provides the connection to the file.       

**Creates a copy in the cache**

It adds the file stored as an md5 hash in `.dvc` under cache. 

```bash 
      .dvc
├── cache
│   └── files
│       └── md5
│           └── 24
│               └── 1ca1b39e70925e1a70272afce3168d
```

To things to note , 

1. We are now carrying an extra copy of this file in the directory and the cache 

2. We have not added the metadata to git yet as is demontrated by looking at `git status`

```bash 
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   .dvc/.gitignore
	new file:   .dvc/config
	new file:   .dvcignore

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitignore
	state_data.dta.dvc
```
#### Next we need to add metadata to git 

We need to add the metadata and gitignore changes to github. 

```bash 
git add state_data.dta.dvc .gitignore
```
Next we can commit these, as followings. 

```bash
git commit -m "added a test data"
```

#### Pushing data to remotes 

The idea of remotes is the main reason that the added complexity of DVC is worth the effort. 
Broadly, the cooper lab will host a remote which all data will be pushed too, therefor allowing 
for replication and easier sharing of both code and data. 

Before configuring the main remotes used lets create a toy example, by using a local remote. 
This will work similarlly to the remotes when we are dealing with servers. . 

Let create a folder as follows 

```bash
mkdir ~/dvc_test
```

Next make sure you are the dvc repo we created. 
Then we need to create a remote, 

```bash
dvc remote add testlocal ~/dvc_test
```

We can check the remote by typing 
```bash
dvc remote list

testlocal	/home/maurice/dvc_test
```

Next lets push or data to the remote 

```
dvc push --remote testlocal state_data.dta.dvc 
```

Now our data lives in the remote. 
