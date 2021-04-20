---
title: "Instalacja Oprogramowania"
date: 2020-07-14
draft: false
---


Dostępność oprogramowania oraz wymagania dla instalacji nowych programów na komputerach ICM opisane są [tu](../../O_zasobach_ICM/Aplikacje/aplikacje.md).
Ze względów bezpieczeństwa, administratorzy nie mogą instalować mało rozpoznawalnego i słabo udokumentowanego oprogramowania w systemie.

W takiej sytuacji użytkownik może zainstalować program lokalnie, na swoim koncie.

!!! note "Ogólna procedura"  
    Aplikacje różnią się między sobą. Poniższa, ogólna procedura może stanowić punkt startowy.

### Ściągnięcie kodu źródłowego

```.sh
wget https://somewhere.com/archive.tar.gz
tar -zxvf archive.tar.gz
# lub
git clone https://github.com/somewhere/something.git
```

### Instalacja programu w lokalnym katalogu

Instalacja programu w lokalnym katalogu użytkownika, np. `$HOME/myapps`.

```.sh
cd extracted_archive
make configure
./configure --prefix=$HOME/myapps
make
make install
```

### Wybór kompilatora - Okeanos

Superkomputer Okeanos został zbudowany przez firmę Cray.
Udostępnia ona polecenia `cc`/`CC`, które są uniwersalnym opakowaniem na kompilatory języka C/C++.
Pod maską używany jest żądany kompilator (gcc, icc, itp.) oraz odpowiednie biblioteki MPI.
Po załadowaniu żądanego środowiska, należy używać tylko polecenia `cc`/`CC`.
Na przykład:

```.sh
$ module list
...
...
PrgEnv-cray/6.0.5 # środowisko domyślne
...
...

$ cc --version
Cray clang version 9.0.2 (2a3a7003aaa5b93e2070bde59a5ee6b9682b67d7) (based on LLVM 9.0.0svn)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /opt/cray/pe/cce/9.0.2/cce-clang/x86_64/bin

$ module switch PrgEnv-cray PrgEnv-intel
$ cc --version
icc (ICC) 19.1.0.166 20191121
Copyright (C) 1985-2019 Intel Corporation.  All rights reserved.

$ module switch PrgEnv-intel PrgEnv-gnu
$ cc --version
gcc (GCC) 8.3.0 20190222 (Cray Inc.)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
$ CC --version
g++ (GCC) 8.3.0 20190222 (Cray Inc.)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


```

### Dodatek - zmienna $PATH

Aby nie musieć każdorazowo wpisywać pełnej ścieżki do programu w celu jego uruchomienia, można zmodyfikować systemową zmienną `$PATH`.
<!-- Jeżeli użytkownik chce mieć możliwość uruchomienia programu wpisując jego nazwę w linii poleceń, to powinien dodać pełną ścieżkę do programu do systemowej zmiennej `$PATH`. -->

Więcej w Google: *How to set your $PATH variable in Linux*

- <https://opensource.com/article/17/6/set-path-linux>

- <https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path>

- <https://linuxize.com/post/how-to-add-directory-to-path-in-linux/>

Różne systemy mogą mieć ustawione różne domyślne powłoki.

```.sh
echo "$SHELL"
/bin/tcsh # topola i okeanos
/bin/bash # rysy
```

Przykładowo, jeżeli korzystamy z powłoki `bash`, to należy zmodyfikować plik `~/.bashrc`

```.sh
export PATH=$PATH:$HOME/myapps/application_XYZ/place_with_the_file
```

Plik ten wczytywany automatycznie w trakcie ładowania powłoki `bash`
(np. podczas logowania - o ile `bash` jest ustawiony jako domyślna powłoka).
Aby nie logować się ponownie, wystarczy wczytać plik `~/.bashrc`.

```.sh
$ source ~/.bashrc
```

Celem ćwiczenia, użytkownik może dodać poniższe linie do pliku  `~/.bashrc`

```.sh
alias say_something='/usr/bin/echo '
alias say_hello_user="say_something hello ${USER}"
```

Następnie można sprawdzić działanie nowych skrótów:

```.sh
[someone@hpc ~]$ say_hello_user
say_hello_user: Command not found.
$ source ~/.bashrc
... some errors - powłoka tcsh nie interpretuje niektórych komend bash'a
[someone@hpc ~]$ bash -l
[someone@hpc ~]$ say_something blahblah
blahblah
[someone@hpc ~]$ say_hello_user
hello someone
```

Dla innych powłok procedura jest podobna.

Chcąc zmienić powłokę należy wpisać `bash | tcsh | ksh ` w linii poleceń.
