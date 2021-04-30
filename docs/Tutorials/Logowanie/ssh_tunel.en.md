---
title: ""
date: 2020-05-14
draft: false
---

!!! Info
     ICM login: `ssh username @ hpc.icm.edu.pl`
     For some systems, an additional login step is possible / required from the hpc.icm.edu.pl computer, e.g. `ssh rysy`,`ssh okeanos`.

Multiple-step logging can be troublesome when working with files.

- Having to enter a password every time can be simplified by using [ssh key] (ssh.en.md).

- The need for multi-step login can be simplified by tunneling the connection.

## ssh tunneling - instruction for LINUX systems

[Tunnel](https://en.wikipedia.org/wiki/Tunneling_protocol) - establishing a connection between two distant hosts so as to create the impression that they are connected directly. - Wikipedia.

To configure connection tunneling, edit the `~/.ssh/config` and `/etc/ hosts` files.
Enter your login in place of `username`.


### ~/.ssh/config

```.sh
Host *
  ServerAliveInterval 100
  ServerAliveCountMax 2
  ControlPath ~/.ssh/%r@%h:%p
  ControlMaster auto
  User nazwa_uzytkownika

Host hpc
  HostName hpc.icm.edu.pl
  User nazwa_uzytkownika
  LocalForward 8022 rysy:22
  LocalForward 8023 okeanos:22
  

Host icm-okeanos
  Port 8023
  User nazwa_uzytkownika


Host icm-rysy
  Port 8022
  User nazwa_uzytkownika
```

### /etc/hosts

```.sh
127.0.0.1 localhost
127.0.1.1 nazwa_uzytkownika_na_lokalnym_kompuerze
127.0.0.1 icm-rysy
127.0.0.1 icm-okeanos


# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

!!! note
     For the tunnel to be open, one have to log in to the access (login) node, namely `ssh username@hpc.icm.edu.pl`.

## Copying files and logging - tips & tricks (LINUX)

Example of use:

```.sh
$ to_hpc local_source_folder remote_destination_folder
$ to_rysy local_source_folder remote_destination_folder
$ to_okeanos local_source_folder remote_destination_folder

$ from_hpc remote_source_folder local_destination_folder
$ from_rysy remote_source_folder local_destination_folder
$ from_okeanos remote_source_folder local_destination_folder

$ rysy # log in directly to the Rysy cluster (if the tunnel has not been opened before, the function will do it automatically).
$ okeanos # log in directly to the okeanos cluster (if the tunnel has not been opened before, the function will do it automatically).

$ mkdir $HOME/Desktop/mountDir/OKEANOS
$ mount-okeanos # the user's remote home directory will be mounted under $HOME/Desktop/mountDir/OKEANOS

$ mkdir $HOME/Desktop/mountDir/TOPOLA
$ mount-topola # the user's remote home directory will be mounted to $HOME/ Desktop/mountDir/TOPOLA
```

Local_folder means a folder located on the user's local computer (PC).
For the functions `to_XXX/from_XXX, etc` to be visible on the system, they must be added to the `~/.bashrc` file.

### ~/.bashrc

```.sh
# Add the following lines to the end of the .bashrc file
# This file is loaded at system startup.
# To update the environment (without rebooting) use the command $source .bashrc

export ICM_USERNAME = "username"

function rysy() {
    if ! ssh -O check hpc;
    then
        ssh -N -f -M  hpc
    fi
    ssh icm-rysy
}


function okeanos() {
    if ! ssh -O check hpc;
    then
        ssh -N -f -M  hpc
    fi
    ssh icm-okeanos
}


function mount-okeanos()
{
   MOUNTDIR="$HOME/Desktop/mountDir/OKEANOS"
   mkdir -p $MOUNTDIR
   sshfs $ICM_USERNAME@icm-okeanos:/lustre/tetyda/home/$ICM_USERNAME ${MOUNTDIR}
}

function mount-topola()
{
   MOUNTDIR="$HOME/Desktop/mountDir/TOPOLA"
   mkdir -p $MOUNTDIR
   sshfs $ICM_USERNAME@hpc:/icm/home/$ICM_USERNAME ${MOUNTDIR}
}


function to_host {
    LOCAL_SOURCE=$1
    REMOTE_DESTINATION_DIR=$2
    # echo -e "Stuff to be copied to remote: $LOCAL_SOURCE \n"

    if ! test -z "$LOCAL_SOURCE" && ! test -z "$REMOTE_DESTINATION_DIR"
    then
        rsync -avzhe ssh --progress ${LOCAL_SOURCE} ${REMOTE_HOME_DIR}${REMOTE_DESTINATION_DIR}
    else
        echo "Usage: to_remote LOCAL_SOURCE REMOTE_DESTINATION_DIR"
    fi
}

function from_host {
  SOURCE_ON_REMOTE=$1
  LOCAL_DESTINATION_DIR=$2
  # echo -e "Stuff to be copied from remote: $SOURCE_ON_REMOTE \n"

  if ! test -z "$SOURCE_ON_REMOTE" && ! test -z "$LOCAL_DESTINATION_DIR"
  then
    rsync -avzhe ssh --progress ${REMOTE_HOME_DIR}${SOURCE_ON_REMOTE} ${LOCAL_DESTINATION_DIR}
  else
    echo "Usage: from_remote SOURCE_ON_REMOTE LOCAL_DESTINATION_DIR"
  fi
}

function to_hpc {
    REMOTE_HOME_DIR="${ICM_USERNAME}@hpc:/icm/home/${ICM_USERNAME}/"
    to_host $@
}

function from_hpc {
    REMOTE_HOME_DIR="${ICM_USERNAME}@hpc:/icm/home/${ICM_USERNAME}/"
    from_host $@
}

function to_okeanos {
    REMOTE_HOME_DIR="${ICM_USERNAME}@icm-okeanos:/lustre/tetyda/home/${ICM_USERNAME}/"
    to_host $@
}

function from_okeanos {
    REMOTE_HOME_DIR="${ICM_USERNAME}@icm-okeanos:/lustre/tetyda/home/${ICM_USERNAME}/"
    from_host $@
}

function to_rysy {
    REMOTE_HOME_DIR="${ICM_USERNAME}@icm-rysy:/home/${ICM_USERNAME}/"
    to_host $@
}

function from_rysy {
    REMOTE_HOME_DIR="${ICM_USERNAME}@icm-rysy:/home/${ICM_USERNAME}/"
    from_host $@
}

```

#### Transferring files with sftp

The `sftp` application is an another utility to transfer files.

```.sh
# terminal A - create tunnel
john@home-pc:~$ ssh hpc

# next, in terminalu B
john@home-pc:~$ sftp icm-okeanos 
Connected to icm-okeanos.
sftp> pwd
Remote working directory: /lustre/tetyda/home/icm_user_name
sftp> lpwd
Local working directory: /home/john/

sftp> help
Available commands:
bye                                Quit sftp
cd path                            Change remote directory to 'path'
chgrp [-h] grp path                Change group of file 'path' to 'grp'
chmod [-h] mode path               Change permissions of file 'path' to 'mode'
chown [-h] own path                Change owner of file 'path' to 'own'
df [-hi] [path]                    Display statistics for current directory or
                                   filesystem containing 'path'
exit                               Quit sftp
get [-afpR] remote [local]         Download file
help                               Display this help text
lcd path                           Change local directory to 'path'
lls [ls-options [path]]            Display local directory listing
lmkdir path                        Create local directory
ln [-s] oldpath newpath            Link remote file (-s for symlink)
lpwd                               Print local working directory
ls [-1afhlnrSt] [path]             Display remote directory listing
lumask umask                       Set local umask to 'umask'
mkdir path                         Create remote directory
progress                           Toggle display of progress meter
put [-afpR] local [remote]         Upload file
pwd                                Display remote working directory
quit                               Quit sftp
reget [-fpR] remote [local]        Resume download file
rename oldpath newpath             Rename remote file
reput [-fpR] local [remote]        Resume upload file
rm path                            Delete remote file
rmdir path                         Remove remote directory
symlink oldpath newpath            Symlink remote file
version                            Show SFTP version
!command                           Execute 'command' in local shell
!                                  Escape to local shell
?                                  Synonym for help

```

## Remote Editing of text files

Users who would like to edit text files in a graphical environment can use the `VScode` program.
It has a `Remote-SSH` plugin, which allows you to edit files remotely.
Another plugin of note is `Live Share` - it allows you to share your terminal with another VScode user.
