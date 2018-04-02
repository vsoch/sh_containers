# sh_rstudio

This is an effort to get an rstudio running from a Singularity container,
deployed on an interactive node with srun, and then tunnelled via a head
node to the user's local machine. We need to satisfy the following:

 - the entire software stack should be provided within the container to reduce errors that come with changes on the host.
 - the URL provided to the user should be a [secure link](https://www.nginx.com/blog/securing-urls-secure-link-module-nginx-plus/) so that others cannot discover it easily.
 - the secure link should still have a login screen for the user. 

The above means that the following needs to happen at runtime:

 - generation of the cluster and local port, and printing instructions to the console for the user
 - generation of the secure link, also with the instruction


## Usage

You can use the Makefile to build the container. It will be called sh_rstudio. 

```
make
```

If you are on a research cluster where you want to submit this with a job, you
would want to use the [rstudio.sh](rstudio.sh) script provided. Of course you
should have the container alongside it!

```
├── rstudio.sh
└── sh_rstudio
```
The script [rstudio.sh](rstudio.sh) if used off of Sherlock would need to be
be customized to load Singularity and (optionally) define a cache, or run with
a --pwd for the user. This script along with the actual submission command
(below) would ideally operate behind a nice executable to take user requests
for custom nodes, binds, etc. (@kilian already has these). Here is an example
run:

```
$ srun -J job-name -p dev -t 01:00:00 --qos normal --mem 4GB --x11=first --unbuffered /bin/bash rstudio.sh
Step 1: Create a tunnel from your local machine to the cluster
ssh -f -L 9000:sh-101-58:9000 vsochat@login.sherlock.stanford.edu sleep 300
Step 2: open http://localhost:9000
```
And here is what happens when we control+C, appropriately the job is killed.
```
^Csrun: interrupt (one more within 1 sec to abort)
srun: step:13218794.0 task 0: running
^Csrun: sending Ctrl-C to job 13218794.0
srun: Job step aborted: Waiting up to 32 seconds for job step to finish.
slurmstepd: error: *** STEP 13218794.0 ON sh-101-58 CANCELLED AT 2018-04-02T11:14:20 ***
[vsochat@sh-ln01 login! /scratch/users/vsochat]$ 
```

## Testing

It's helpful to work with the container from an interactive node to test.

```
srun -J job-name -p dev -t 01:00:00 --qos normal --mem 4GB --x11=first --pty --unbuffered /bin/bash
module load singularity/2.4.5
singularity shell -p sh_rstudio
```
