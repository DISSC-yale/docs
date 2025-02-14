
# DVC walkthrough 

Our centralized data repository uses [Data Version Control](https://dvc.org/) and is built on top of git repositories for finding data 

This will focus on getting you up and runnignw with accessing data with DVC quickly and will leave: 
 
 - [using DVC to tooling section on DVC](../tooling/dvc_basics.md)
  
 The problem: 
   - You are tasked with finding the most recent AHA cleaned data 

Dependencies 
  - If you have not worked through the [Using GitHub](connecting_to_git.md) walkthough and install you should start there
  
Things to be aware of when using DVC
  - DVC ends up creating many copies of your data. 
    Important to keep in mind when working with large data. 

## Installing 

The easiest way is to install from the downloaded version on the [DVC website landing page ](https://dvc.org/) and choose the installation based on your operating system. 
The only caveat there is that you will need to repeat the process to update the software in the future. 

Note if you are working on Windows Linux Subsystem(WSL) on a windows machine then you need to install from the command line and that would look like the following 
as [documented in the docs](https://dvc.org/doc/install/linux)
!NOT WORKING!
```bash
sudo wget \
       https://dvc.org/deb/dvc.list \
       -O /etc/apt/sources.list.d/dvc.list
wget -qO - https://dvc.org/deb/iterative.asc | gpg --dearmor > packages.iterative.gpg
sudo install -o root -g root -m 644 packages.iterative.gpg /etc/apt/trusted.gpg.d/
rm -f packages.iterative.gpg
sudo apt update
sudo apt install dvc
```

### OSx 

Install homebrew package manager. 


Next open a terminal and type 

```
brew install dvc
```
 
This might take a little while as we have to install dependencies, including arrow. 


### Validate install 

From the command line type in 

```bash 
dvc --version
```

And it should spit out the version for you. 

## Setting a global cache 

DVC works by caching files. By fefault it will cache each files inside of the git repository. This is not efficient if you are using the same file in different projects. Its recommended you create a centralized cache to avoid taking up too much space. 

You do this by selectiong a location and creating a folder and adding a chacne through the DVC command line 
```bash 
# Create directory for cahc if it doesnt exist
mkdir -p ~/.config/dvc/cache
dvc cache dir --global ~/.config/dvc/cache
```
You can check that it is set by 

```bash
dvc config -l
```



## Remotes 

DVC overcomes some of git's shortcoming around working with large datasets by relying on what they refer to as 
remote storage locations. These can be separate folders locally, cloud blob storage or sftp locations. 

We have decided to use cloud storage and we need to define the remotes locall before we get going. 

### Defining a remote 

Easiest way is to find the dvc config file. Lets first add a global remote so our dvc file has something to report.

Next type in the following to get the locaiton of the file

```bash
dvc config -l --show-origin
```
This will return a bunch of lines. What we are looking for is the first part which ends in config. You will want to open that file in 
a text editor. For example, when I type the command on a mac it returns 
```bash
#---returns 
/Users/../../dvc/config	remote.wasabi.url=s3://url/to/bucket
```
Where `/Users/../../dvc/config` is my config file. We want to open that file 
and add the following which defined a global remote called wasabi.  The remote wasabi has the connection details. 

```yaml
[core]
    remote = wasabi
    autostage = true
['remote "wasabi"']
    url = {s3://your-s3/bucket}
    region = us-east1
    endpointurl = {endpoint}
    access_key_id = {access_key_id}
    secret_access_key = {secret_access_key}
```


```bash 
dvc remote default --global  wasabi 
```


## Task: Lets get some data 

Lets say we are interested in pulling in some of the work that crosswalks hospital ID found in NPPES and CMS data. 

### Finding data 

We first would find the repo of interest, which could be done by searching for NPPES. 

Note that search in github will search across all of the codebase in the repository as well as repository descriptions. 
Since were looking for data, probably makes sense to filter on repositorys. 


From looking at the repos we are interested in the `infra_provider-xw` repository. 

To bring that data into our project we need only the gitHub repo, a link to the relative path to the data folder or files we want to import. 
I we look at the raw data folder, we see the following. We can either choose to import the entire directory or a single file. Lets assume we are not sure what file we need and we just 
want to pull the entire directory. 
```
0raw
│   ├── hosp_npi_aha_crosswalk_yale.csv.dvc
│   └── hosp_npi_aha_crosswalk_yale.csv.readme.dvc
```

### Getting data 

1. You need to be inside a git and dvc repository 

    a. `mkdir project`
    
    b. `git init`
    
    c. `dvc init`

2. The dit/dvc repository needs to now where the remote repository lives 

    a. from inside the new git repository enter the following 
    
    ```
    dvc remote default wasabi --local 
    ```

3. Import the data     

    a. `--out` tells dvc where to save files 
    
    b. `--remote` tells which remote to use to get data. Need this with samba since maybe mounted at different point on different machines 
    
    c.  `git clone stub`: this is the location of the git repo which holds meta data for data 
    
    d. `data file or folder ,e.g  0raw`: Tells DVC which data files to grab within repo. Can find this in github repo with files ending in `dvc` 
    
    This can be done from the command line, if you are in windows you can do this through.the bash emulator.

```
dvc import --out dependency/infra_xw --remote wasabi git@github.com:cooper-lab/infra_provider-xw.git 0raw 
```

    !!! dvc import can be a little finicky, need to make sure remotes are set locally 

![Using VScode plug in allows you to search repos with a front end](../assets/dvc_vsvode_within_repo_data_remote.png).

## Task: Project data 

It can also be used to save entire projects where the code and remote data are linked and several users can work with the same 
data or easily move to a new environment.
