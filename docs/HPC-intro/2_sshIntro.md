---
title: "2 Logowanie SSH - Podstawy"
date: 2020-02-26
draft: false
---

## SSH - logowanie

!!! Info
    Logowanie do ICM: `ssh username@login.icm.edu.pl`

## Tworzenie kluczy SSH

Logowanie użytkowania może być uwierzytelnione poprzez podanie hasła lub użycie klucza kryptograficznego.
Klucze są bezpieczniejsze (i wygodniejsze).

```.sh
# Aby wygenerować klucze SSH na lokalnym komputerze należy użyć komendy:
ssh-keygen
# Następnie należy skopiować klucz publiczny na serwer docelowy:
ssh-copy-id -i ~/.ssh/mykey.pub user@your.server.example.com
# Tylko Ty (i żaden inny użytkownik) powinieneś mieć możliwość odczytywania kluczy:
chmod 400 ~/.ssh/mykey
# Jeśli chcesz użyć już istniejącego klucza, nie zapomnij dodać go do 'ssh agent' na lokalnej maszynie
ssh-add ~/.ssh/mykey
# if `ssh-add` fails saying `Could not open a connection to your authentication agent.` you have to start the ssh-agent
eval `ssh-agent -s`

# logowanie
ssh user@your.server.example.com
# logowanie z użyciem konkretnego klucza
ssh -o IdentitiesOnly=yes -i ~/.ssh/example_rsa user@your.server.example.com
# logowanie z użyciem hasła (zamiast klucza)
ssh -o PubkeyAuthentication=no user@your.server.example.com

```

### Zmiana kluczy

1\. System Windows + Putty (klient ssh): Należy uruchomić program
'regedit' (systemowa aplikacja w Windows). Następnie w panelu po lewej
stronie wyszukać w drzewie wpis:

```.sh
HKEY\_CURRENT\_USER\\Software\\SimonTatham\\PuTTY\\SshHostKeys
```

i w oknie po prawej stronie odszukać wiersz zawierający nazwę
'login.icm.edu.pl' lub 'hpc.icm.edu.pl', a następnie go usunąć.

2\. System Linux: Aby usunąć stary klucz wykonujemy w terminalu komendę:

```.sh
ssh-keygen -f \$HOME/.ssh/known\_hosts -R hpc.icm.edu.pl
```

### Kopiowanie plików - wstęp

Do kopiowania plików używa się komendy cp:
`cp kopiowany\_plik ścieżka\_docelowa\`

Katalogi można kopiować komendą `cp` z opcją `-r`:
`cp -r katalog ścieżka_decelowa`

Podczas kopiowania można używać uogólnionych nazw z `\*`:

- `*` – wszystkie pliki/katalogi
- `*.roz` – wszystkie pliki z rozszerzeniem .roz
- `a*` – wszystkie pliki/katalogi zaczynające się od a

### Kopiowanie plików - SSH

Aby przegrać pliki pomiędzy maszynami korzystamy z polecenia *scp*.
Składnia jest taka jak przy zwykłym kopiowaniu *cp*.

Przydatne opcje:

| Opcja    | Znaczenie                                                              |
|----------| :----------------------------------------------------------------------|
| -C       |  włącza kompresję (w przypadku pliku skompresowanego nie ma to sensu)  |
| -p       |  zachowuje oryginalną datę stworzenia pliku                            |
| -r       |  (recursive) kopiowanie całego podkatalogu                             |
| -v       |  (verbose) przydatne, jeśli nie udaje nam się połączyć                 |

Uwagi:

- swój katalog domowy można zastąpić przez znak `~`
- nie podanie ścieżki spowoduje wgrywanie plików względem katalogu domowego
- Sprawdzenie dostępnego miejsca w katalogu użytkownika `quota -v login_uzytkownika`

**Przykłady:**

```.sh
# Kopiowanie pliku do ICM:
    scp -C -p plik.tar.gz username@login.icm.edu.pl:.
# Kopiowanie pliku z ICM:
    scp -C -p username@login.icm.edu.pl:plik.tar.gz destination_folder
# Kopiowanie zawartości katalogu do ICM:
    scp -r -C -p source_folder username@login.icm.edu.pl:destination_folder
# Kopiowanie zawartości katalogu z ICM:
    scp -r -C -p username@login.icm.edu.pl:source_folder destination_folder
```

!!! Note
    Użytkownicy Windowsa mogą skorzystać z darmowej aplikacji `WinScp` lub `Filezilla`.

### Synchronizacja i montowanie katalogów

```.sh
# Zamontowanie zdalnego folderu na lokalnej maszynie
    sshfs user@your.server.example.com:/source_folder destination_folder

# Synchronizacja (tylko nowe pliki) zawartości lokalnego folderu ze zdalnym (lub vice versa)
    rsync -avzhe ssh --progress source_folder/  user@your.server.example.com:/destination_folder/

# Synchronizacja z zastrzeżeniem do plików `.csv` i zachowaniem struktury katalogów
    rsync -zarv --prune-empty-dirs --include "*/"  --include="*.csv" --exclude="*" "$FROM" "$TO"
```

## Przechowywanie Danych

Poniższa tabelka prezentuje dostępne w infrastrukturze ICM zasoby służące przechowywaniu danych.

| Zasób                  | widoczny na     | pod ścieżką       | quota      | limit plików   | backup  |
|----------------------- |-----------------| ----------------- | ---------- |--------------- |---------|
| Lokalny                | topola          |  /icm/home        | 100 GB     | 140 000        | nie     |
| Współdzielony wymiany  | okeanos, topola |  /icm/tmp         | 1 000 GB   | 300 000        | nie     |
| Lokalny tymczasowy     | topola          |  /lu/topola/temp  | -          |                | nie     |
| Lokalny                | okeanos, topola |  /lu/tetyda/home  | -          |                | nie     |
| Lokalny                | rysy            |  /home            | 200 GB     |                | nie     |

!!! warning
    Nie wolno wykorzystywać katalogu domowego do intensywnego zapisu i odczytu plików tymczasowych generowanych w trakcie obliczeń, o ile informacje widoczne podczas logowania nie mówią inaczej.
    Do tego celu na każdym systemie obliczeniowym przeznaczone są katalogi tymczasowe.

### Kopiowanie poprzez zasób współdzielony

Ponieważ część maszyn ICM'u dysponuje współdzielonymi systemami plików, na których można operować tak, jak na dysku lokalnym (kopiowanie za pomocą cp). Aktualnie do zasobów współdzielonych należą:

```.sh
/icm/tmp (uniwersalny zasób dyskowy)
/lu/topola (dla topoli)
/lu/tetyda (dla okeanosa)
```

Katalog domowy okeanosa */lustre/tetyda/home/* jest widoczny pod scieżką */lu/tetyda/home/user_name/* z topoli.

## Kończenie pracy

Po skończeniu pracy należy się wylogować poleceniem `exit` lub `logout`
lub kombinacją klawiszy `Ctrl+D`.
