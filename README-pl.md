# Instrukcja użytkowania serwisu/repozytorium

## Edycja treści z poziomu WWW

   1. Zakładamy konto użytkownika Github: https://github.com
   2. W serwisie z dokumentacją (https://icm-uw.github.io/hpc-docs/): na każdej (pod)stronie przy nagłówku działu znajduje się link o nazwie **Edit this page**, prowadzący do logowania w serwisie Github (punkt 1). Zalogowanie pozwala na edycję treści danej strony w repozytorium bezpośrednio z poziomu przeglądarki internetowej.

## Edycja treści z poziomu klienta **git**

1. Klonujemy repozytorium z dokumentacją:
```sh
$ git clone https://github.com/icm-uw/hpc-docs.git
```

2. Instalujemy środowisko wirtualne Pythona, a w nim **mkdocs** wraz z zależnościami określonymi w pliku *requirements.txt*:

```sh
$ pyenv python-venv
# A w przypadku Pythona 3:
$ python -m venv python-venv
```

i aktywujemy je:

```sh
$ source ./python-venv/bin/activate
```

3. Przechodzimy do sklonowanego repozytorium i uruchamiany lokalną instancję **mkdocs**, żeby monitorować (na razie offline) wprowadzane zmiany:
```sh
$ cd hpc-docs
$ mkdocs serve
```

4. Wprowadzamy zmiany w plikach Markdown (*.md) lub tworzony nowe. Żeby sprawdzić efekt zmian kierujemy przeglądarkę internetową na adres http://127.0.0.1:8000

5. Jeżeli zmiany są zadowalające, wysyłamy je na serwer:
```sh
$ cd hpc-docs
$ mkdocs gh-deploy
```

6. Dodatkowo dodajemy do repozytorium zmodyfikowane pliki źródłowe (*.md):
```sh
$ cd hpc-docs
$ git add ./
$ git commit -m "Adding this and that"
$ git push
```
