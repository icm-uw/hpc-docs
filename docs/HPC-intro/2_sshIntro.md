---
title: "2 SSH Introduction"
date: 2020-02-26
draft: false
---

## Generating ssh keys

```.sh
# On your local computer, generate a SSH key pair by typing:
ssh-keygen
# Next, copy your Public Key Using SSH-Copy-ID
ssh-copy-id -i ~/.ssh/mypubkey user@your.server.example.com
# Keys need to be only readable by you:
chmod 400 ~/.ssh/myprivkey
# if you used an already existing key don't forger to add it to the ssh agent on the local machine
ssh-add ~/.ssh/myprivkey

# login using specific key
ssh -o IdentitiesOnly=yes -i ~/.ssh/example_rsa user@your.server.example.com
# login using password (even if pubkey is available)
ssh -o PubkeyAuthentication=no user@your.server.example.com
```

## Using ssh

```.sh
#to login
ssh user@your.server.example.com
#to copy (overwrites) from remote machine to local one
scp -r user@your.server.example.com:/path/to/source_folder /home/user/Desktop/destination_folder
#to mount remote folder at local machine
sshfs user@your.server.example.com:/path/to/source_folder /home/user/Desktop/destination_folder
#to synchronize (only new files) content of the local folder with a remote one (or vice versa)
rsync -avzhe ssh --progress /home/user/Desktop/source_folder/  user@your.server.example.com:/path/to/destination_folder/

#If you need to exclude the sub-directories that dont contain the file and still retain the directory structure, use
rsync -zarv  --prune-empty-dirs --include "*/"  --include="*.csv" --exclude="*" "$FROM" "$TO"
```

## Slurm commands

'The Slurm Workload Manager, or Slurm, is a free and open-source job scheduler for Linux and Unix-like kernels, used by many of the world's supercomputers and computer clusters.' - Wikipedia

Official documentation:

<https://slurm.schedmd.com/documentation.html>

### Selected commands

To schedule a job use salloc, sbatch or srun command.

* `sbatch` always creates a new resource allocation when it is invoked, executes a job script on one of the allocated nodes (master node), then releases the allocation once the script terminates. An additional feature of sbatch is that it will parse this script at job submission time for lines that begin with #SBATCH and contain sbath options in lieu of command line arguments. Command line arguments override the same #SBATCH options in the script, so a single batch script can be invoked for different task-sized allocations by specifying -N or -n options on the command line when submitting a job script withsbatch

* `srun` may or may not create an allocation, depending on how it is invoked. If it is invoked on the command line of a login node, then it will create a new allocation and execute the command following srun. If it is invoked in a batch script, it will simply run a task on the current allocation. Likewise, srun may be given a --jobid argument that tells it to run the task as part of the given job, on the specified job's own allocation.

* `salloc` always creates a new resource allocation when it is invoked, but doesn't necessarily run any tasks on the allocated nodes. The typical use case of salloc is to create an allocation in order to run a series of subsequent srun commands either through an interactive bash session, or a script which runs from the login node. It releases the allocation after the script or bash session terminates.

Source: <https://cvw.cac.cornell.edu/slurm/basics_allocation>

Example of starting of an interactive job

```.sh
srun -p <partition_name>  -A <grant_name> -N 1 -n 12 --time=1:00:00 --pty /bin/bash -l
```

To check job/grant/account status

```.sh
squeue # lista aktualnie zakolejkowanych/uruchomionych zadań
squeue -l -j <job_ID> # Check job status
squeue --start -j <job_ID> # to see when a job will start
squeue -u $USER # show your jobs
scontrol show job <job_ID> - szczegóły zadania
sstat -a -j ID_zadania/ID_zadania.batch - zużycie zasobów w ramach kroków (step) działającego zadania
sacct - zużycie zasobów zakończonego już zadania/kroku

scontrol show job <job_ID>
scontrol show partition <nazwa_partycji> - właściwości partycji
scontrol show node <nazwa_węzła> - właściwości węzła

sinfo - lista węzłów
scancel - kill the job

/apps/bin/chkgrantusage grant_id [yyyy-mm-dd yyyy-mm-dd]

sacctmgr show assoc where account=grant_id format=user,GrpTRESMins%50

```

Example of formating 'squeue' output

```.sh
# squeue - format output
#  %j   Job or job step name.
#  %i   Job or job step id.

squeue -o "%16j %i"
CLB:batch_HotKar 17817851
CLB:batch_HotKar 17817852
CLB:batch_HotKar 17817853
CLB:d3q27q7/batc 17817943
CLB:d3q27q7/batc 17817944
CLB:d3q27q7/batc 17817945

# print second column
squeue -o "%16j %i" | grep "d3q27*" | awk '{print $2}'  
17817943
17817944
17817945
```
