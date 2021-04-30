---
title: ""
date: 2020-05-14
draft: false
--- 

!!! Info
    Logowanie do ICM: `ssh username@hpc.icm.edu.pl`
    W przypadku niektórych systemów możliwy/wymagany jest dodatkowy krok logowania wykonany z komputera hpc.icm.edu.pl, np. `ssh rysy`, `ssh okeanos`.

Wieloetapowe logowanie bywa uciążliwe przy pracy na plikach.

- Konieczność każdorazowego wpisywanie hasła można uprościć poprzez użycie [klucza ssh](ssh.pl.md).

- Konieczność wieloetapowego logowania można uprościć poprzez tunelowanie połączenia.

## Tunelowanie ssh - intrukcja dla systemów LINUX

[Tunel](https://pl.wikipedia.org/wiki/Tunel_(informatyka)) – zestawienie połączenia między dwoma odległymi hostami tak, by stworzyć wrażenie, że są połączone bezpośrednio. - Wikipedia.

W celu zkonfigurowania tunelowania połaczeń należy zedytować pliki `~/.ssh/config` oraz `/etc/hosts`.
Wpisz swój login w miejsce `nazwa_uzytkownika`.

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
    Aby tunel był otwarty należy zalogować się na węzeł dostępowy  `ssh nazwa_uzytkownika@hpc.icm.edu.pl`.

## Kopiowanie plików i logowanie - tips & tricks (LINUX)

Przykład użycia:

```.sh
$ to_hpc lokalny_folder_zrodlowy zdalny_folder_docelowy
$ to_rysy lokalny_folder_zrodlowy zdalny_folder_docelowy
$ to_okeanos lokalny_folder_zrodlowy zdalny_folder_docelowy

$ from_hpc zdalny_folder_zrodlowy lokalny_folde_docelowy
$ from_rysy zdalny_folder_zrodlowy lokalny_folde_docelowy
$ from_okeanos zdalny_folder_zrodlowy lokalny_folde_docelowy

$ rysy # zaloguj się bezpośrednio na klaster rysy (jeżeli tunel nie był wcześniej otwarty, to funkcja zrobi to automatycznie).
$ okeanos # zaloguj się bezpośrednio na klaster okeanos (jeżeli tunel nie był wcześniej otwarty, to funkcja zrobi to automatycznie).

$ mkdir $HOME/Desktop/mountDir/OKEANOS
$ mount-okeanos # zdalny katalog domowy użytkownika zostanie zamontowany pod $HOME/Desktop/mountDir/OKEANOS

$ mkdir $HOME/Desktop/mountDir/TOPOLA
$ mount-topola # zdalny katalog domowy użytkownika zostanie zamontowany pod $HOME/Desktop/mountDir/TOPOLA
```

Poprzez lokalny_folder rozumie się folder znajdujący się na lokalnym komputerze (PC) użytkownika.
Aby funkcje `to_XXX/from_XXX, itd` były widoczne w systemie, należy je dodać do pliku `~/.bashrc`.

### ~/.bashrc

```.sh
# Dodaj poniższe linijki pod koniec pliku .bashrc
# Plik ten jest wczytywany przy uruchomieniu systemu.
# Aby zaktualizować środowisko (bez konieczności restartu) użyj komendy $source .bashrc

export ICM_USERNAME="nazwa_uzytkownika"


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

#### Kopiowanie przy użyciu sftp

Do kopiowania plików przydatny może być też program `sftp`.

```.sh
# terminal A - tworzymy tunel
john@home-pc:~$ ssh hpc

# następnie w terminalu B
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

## Zdalne Edytowanie plików textowych

Użykownicy, którzy lubią edytować pliki tekstowe w środowisku graficznym mogą skorzystać z programu `VScode`.
Posiada on wtyczkę `Remote-SSH`, która pozwala na zdalną edycję plików.
Inną wartą uwagi wtyczką jest `Live Share` - umożliwa ona współdzielenie terminala z innym użytkownikem programu VScode.
