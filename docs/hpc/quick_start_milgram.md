# YCRC Milgram quick start with access controls

This document outlines the process for getting an account, accessing data, transferring files, and working on the Yale Milgram high-performance computing (HPC) cluster.

## Requesting a YCRC Account

If you do not already have a Yale Center for Research Computing (YCRC) High-Performance Computing (HPC) account, you can request one for the Milgram cluster by filling out the [account request form](https://research.computing.yale.edu/support/hpc/account-request).

## Requesting Data Access for Users

To grant another user access to your data, follow these steps:

1.  Ensure the user has requested a Milgram account with you listed as the PI on the [account request form](https://research.computing.yale.edu/support/hpc/account-request).
2.  If the user is a non-Yale collaborator, you must first request a sponsored identity for them.
3.  Email `dissc@yale.edu` with the following information:
    * User's first and last name.
    * User's NetID, if possible (it is not strictly necessary).
    * The full path of the folder you want to grant them access to.
4.  DISSC will apply the necessary Access Control Lists (ACLs) and log the request.

## Transferring Data to the Cluster

For comprehensive documentation, please see the official YCRC guides:

* [Data Transfer Overview](https://docs.ycrc.yale.edu/data/transfer/)
* [Using Globus](https://docs.ycrc.yale.edu/data/globus/)

### Small Data (< 10 GiB)

The easiest method for small files is to use the **File Transfer** feature directly within Open OnDemand.

### Medium to Large Data

* **Globus**: Provides a user-friendly graphical interface for managing transfers. To use it, download **Globus Connect Personal**, complete the setup process, and connect your local computer with the “Yale CRC Milgram” collection.
* **Command Line**: Tools like `rsync` or `scp` are effective for transferring medium-sized data directly from your terminal.

> For assistance with any data transfer method, please reach out to DISSC or YCRC at `hpc@yale.edu`.

## Working on Milgram with Open OnDemand (OOD)

Open OnDemand (OOD) provides a web-based portal to access the Milgram cluster's resources.

**OOD Dashboard Link**: [https://ood-milgram.ycrc.yale.edu/pun/sys/dashboard/](https://ood-milgram.ycrc.yale.edu/pun/sys/dashboard/)

### Starting an Interactive Session

From the OOD dashboard, you can launch an interactive session (e.g., Stata, RStudio, or a general Linux Desktop).

1.  Choose the type of instance you want to start.
2.  Configure the session resources:
    * **Partition**: The `devel` partition is the default but limits you to 32 GB of memory. The `day` partition provides access to higher-memory machines. See all [available partitions here](https://docs.ycrc.yale.edu/clusters/milgram/).
    * **Number of Hours**: How long you need the session to run. Start with a short duration for testing. You must stop your session when you are finished.
    * **Number of CPUs**: The number of CPU cores your session can use. For simple tasks, 1 or 2 CPUs is sufficient.
    * **Modules**: YCRC uses modules to manage software environments. When you launch a specific application like `RStudio` or `Stata`, the required modules are loaded automatically. To use software from the generic Desktop instance, you will need to load the modules manually.

> **TODO**: Check the Milgram Stata license to determine the maximum number of cores it can use.

### Submitting Batch Jobs

If you require more resources or need to run a non-interactive task, you can submit a batch job to the cluster. Please contact DISSC or `hpc@yale.edu` for an example submission script.

### Working on the Virtual Desktop

DISSC is developing simple shortcuts for launching applications like LibreOffice (for Word/Excel documents), RStudio, and Stata directly from the virtual desktop. We will work with you to set this up and update this documentation accordingly.
