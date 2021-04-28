
# SSH - logowanie

!!! Tip
    Logowanie do ICM: `ssh username@hpc.icm.edu.pl`.
    Logowanie odbywa się przy pomocy loginu (do 8 liter, nie adresu e-mail).
    W przypadku niektórych systemów możliwy/wymagany jest dodatkowy krok logowania wykonany z komputera hpc.icm.edu.pl, np. `ssh rysy`, `ssh okeanos`.

!!! Info
    Od grudnia 2020 r. logowanie za pomocą protokołu ssh wymaga autoryzacji dwu-składnikowej (2FA - 2 Factors Authentication) z użyciem tokenów typu TOTP (Time-based One-time Password).

## Nazwa konta i ustawianie hasła

Przy pierwszym logowaniu konieczna jest [zmiana hasła](./nazwa_konta_i_haslo.pl.md).

## Autoryzacja dwu-składnikowa (2FA)

Logując się przy użyciu ssh na serwer `hpc.icm.edu.pl` użytkownik podaje dane (hasło/klucz) po czym pojawia się dodatkowe zapytanie o **OTP** (one time password), czyli jednorazowy kod, indywidualny dla każdego, generowany przy użyciu specjalnej aplikacji.

### 2FA - rejestracja tokenu TOTP

W celu rejestracji tokenu prosimy o zalogowanie się swoimi danymi w ICM UW do serwisu `https://mfa.hpc.icm.edu.pl` 
i wygenerowanie tokenu bez zmiany domyślnych ustawień (enroll token). 
Pojawi się kod QR, który należny wskanować [do aplikacji](./ssh.pl.md#aplikacje-do-obsugi-tokenow-totp).
System będzie oczekiwał podania aktualnej wartości tokenu wyświetlanej w aplikacji przy logowaniu się na `hpc.icm.edu.pl`, nawet jeśli dotychczas nie został on wygenerowany.

!!! Warning
    Po usunięciu tokenu z aplikacji w telefonie nie ma możliwości jego odzyskania (tylko reset wykonany przez administratora).

### Aplikacje do obsługi tokenów TOTP

W celu uzyskania kodu konieczne jest zainstalowanie na swoim telefonie aplikacji obsługującej mechanizm tokenów **TOTP** (Time-based One-time Password), np. `FreeOTP` lub `GoogleAuthenicator`.
Aplikację są dostępne w GooglePlay i AppStore, są darmowe i nie wymagają dostępu do internetu (działają w trybie offline).

Użycie aplikacji na telefon jest preferowane ponieważ:

- jest łatwiejsze w obsłudze
- inne urządzenie stanowi dodatkowy czynnik zabezpieczający

Jeżeli nie jest to możliwe, należy zainstalować aplikację na komputerze.
Szczegóły poniżej.

#### GNU/Linux

TOTP token może być zarejstrowany w aplikacji z interfejsem graficznym (GUI), np <https://keepassxc.org/>

Alternatywnie, token TOTP może być zarejestrowany przy pomocy aplikacji "pass" (CLI - command line interface) w systemie operacyjnym GNU/Linux:

1. Instalujemy aplikację "pass". Najwygodniej jest to zrobić za pośrednictwem repozytorium pakietów właściwego dla naszej dystrybucji systemu. Alternatywnie - program można pobrać ze strony: <https://github.com/tadfisher/pass-otp>

2. Program "pass" przechowuje hasła w postaci zaszyfrowanej, dlatego konieczne będzie zainstalowanie pakietu "gnupg" (z repozytorium pakietów systemu) i wygenerowanie klucza GPG, który będzie służył do szyfrowania naszych danych. Można to zrobić wydając instrukcję:

	`gpg --full-gen-key`

	i postępując zgodnie z wyświetlanymi na ekranie poleceniami
	(a w razie wątpliwości akceptując domyślne parametry).

	Dalej inicjujemy bazę haseł programu "pass":

	`pass init <gpg-id lub adres e-mail klucza GPG>`

3. Wchodzimy w przeglądarce internetowej na stronę
   https://mfa.hpc.icm.edu.pl i logujemy się do serwisu przy użyciu
   dotychczasowej nazwy użytkownika i hasła.

4. Wybieramy opcję "Enroll Token" i bez zmiany domyślnych parametrów 
   wybieramy "Enroll".

	!!!Note
		Tu musimy działać powoli, zbyt szybkie przejście dalej spowoduje niemożliwość wykorzystania wygenerowanego tokenu.


      Pojawi się nowa strona z obrazem kodu QR
      odpowiadającemu tokenowi. Obok kodu jest dostępny
      link (pokolorowane "here"). Kopiujemy adres, na który
      wskazuje link do schowka lub do dowolnego edytora
      tekstu.

5. W terminalu wykonujemy instrukcję:

     `pass otp insert icm`

     Program poprosi nas o podanie "otpauth://". W tym miejscu
     wklejamy w całości skopiowany wcześniej link.

     Pojawienie się komunikatu `Error: otp is not in the password store.` świadczy o niepoprawnym zainstalowaniu
     wtyczki 'pass-otp' do programu 'pass'. W rezultacie komenda 'otp' nie jest rozpoznawana.
     Przykład z błędem poniżej:

     ```.bash
     username@hostname:~$ pass blahblah
     Error: blahblah is not in the password store.

     username@hostname:~$ pass blahblah insert
     Error: blahblah is not in the password store.

     username@hostname:~$ pass blahblah insert icm
     Error: blahblah is not in the password store.
     ```

6. Gotowe. Można już zamknąć stronę internetową rejestracji tokenu, a
   link nie będzie już potrzebny. Żeby wygenerować token, wystarczy wydać
   w terminalu polecenie:

    `pass otp icm`

    Program zapyta nas o hasło – UWAGA: nie jest to hasło ICM, ale
    hasło klucza GPG, który wygenerowaliśmy w punkcie 1.

    Proces wpisywanie tokenu podczas sesji SSH można nieco uprościć -
    wydając polecenie:

    `pass otp -c icm`

    Wówczas token nie zostanie wyświetlony na ekranie, ale
    automatycznie umieszczony w schowku -- można natychmiast wkleić go
    do sesji SSH.

    Opcjonalnie, żeby proces logowania do systemów ICM był
    wygodniejszy, można utworzyć następujący alias (i umieścić
    poniższą linię w pliku ~/.bashrc) - dla powłoki Bash:

    ```.sh
    alias sshicm='pass otp -c icm && ssh 213.135.51.79'
    ```

    Chcąc zalogować się do systemu ICM wystarczy wówczas napisać w
    terminalu:

    `sshicm`

    Program wygeneruje token (prosząc jedynie o hasło klucza GPG),
    umieści go w schowku i połączy się z systemem dostępowym ICM,
    gdzie możemy natychmiast wkleić token ze schowka.

#### MS Windows

Rejestracja tokenu TOTP przy pomocy aplikacji "OTP Manager" w Windows
10 (do pobrania z Windows Store):

1. Instalujemy aplikację OTP Manager.

2. Uruchamiamy aplikację i wybieramy manualne dodanie nowego tokenu.

3. Wchodzimy w przeglądarce internetowej na stronę
https://mfa.hpc.icm.edu.pl i logujemy się do serwisu przy użyciu
dotychczasowej nazwy użytkownika i hasła.

4. Wybieramy opcję "Enroll Token" i bez zmiany domyślnych parametrów
wybieramy "Enroll".

	  Uwaga! Tu musimy działać powoli, zbyt szybkie przejście
	  dalej spowoduje niemożliwość wykorzystania wygenerowanego
	  tokenu.

5. Pojawi się nowa strona z obrazkiem kodu QR odpowiadającemu
tokenowi. Obok kodu jest dostępny link (pokolorowane
"here"). Kopiujemy adres na który wskazuje link do notatnika lub
innego edytora tekstowego. Adres ma postać:

       `otpauth://totp/?secret=AAABBBCCCDDDEEFFFGGGGHHH&algorithm=SHA1&digits=6&period=30`

6. Kopiujemy ciąg znaków zaczynający się po "secret=" i kończący się
przed znakiem "&" (w przykładzie powyżej:
AAABBBCCCDDDEEFFFGGGGHHH). To nasz sekretny klucz tokenu. Powinniśmy
go chronić lub po zakończeniu rejestracji zapomnieć.

7. Wklejamy sekretny klucz do aplikacji OTP Manager w polu "Secret", a
pozostałe nazwy możemy wypełnić dowolnie. Zapisujemy token za pomocą
ikony dyskietki w górnej listwie aplikacji.

8. W tym momencie OTP Manager powinien wyświetlać 6 cyfrowy kod OTP do
wpisania przy logowaniu do ICM. Możemy go przetestować.

9. Możemy zamknąć stronę rejestracji tokenu i zapomnieć sekretny klucz.

## Tworzenie kluczy SSH

Logowanie użytkowania może być uwierzytelnione poprzez podanie hasła lub użycie klucza kryptograficznego.
Klucze są bezpieczniejsze (i wygodniejsze - nie trzeba za każdym razem wpisywać hasła).

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

### Popdis cyfrowy maszyny dostępowej hpc.icm.edu.pl

Podczas logowania komputer użytkownika upewnia się czy łączy się z autoryzowaną maszyną `hpc.icm.edu.pl`.
W tym celu sprawdzany jest [odcisk klucza kryptograficznego](https://en.wikipedia.org/wiki/Public_key_fingerprint) maszyny dostępowej.
Przy pierwszym połączeniu należy zgodzić się na dodanie `hpc.icm.edu.pl` do listy *znajomych*.

```.txt
ssh username@hpc.icm.edu.pl
The authenticity of host 'hpc.icm.edu.pl (2001:6a0:2001:2321::79)' can't be established.
ECDSA key fingerprint is SHA256:KGMfnzeNErKlS8J/MYOBsnFKFl95VJ+BFm4FAYwKV6A.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'hpc.icm.edu.pl' (ECDSA) to the list of known hosts.
OTP: 
```

Poniżej przedstawiona jest procedura usunięca starego odcisku klucza.

#### System Windows

Należy uruchomić program `regedit` (systemowa aplikacja w Windows). 
Następnie w panelu po lewej stronie wyszukać w drzewie wpis:

```.txt
HKEY_CURRENT_USER\Software\UserName\PuTTY\SshHostKeys
```

i w oknie po prawej stronie odszukać wiersz zawierający nazwę 'hpc.icm.edu.pl', a następnie go usunąć.

#### System Linux

Aby usunąć stary klucz wykonujemy w terminalu komendę:

```.sh
ssh-keygen -f $HOME/.ssh/known_hosts -R hpc.icm.edu.pl
```

## Manager haseł

Program [pass](https://www.passwordstore.org/) jest menadżerem haseł umożliwiającym użytkownikom linux'a bezpieczne przechowywanie haseł na lokalnym komputerze.
Przykładowo:

```.txt
$ pass zdalne_komputery/icm -c
Copied zdalne_komputery/icm to clipboard. Will clear in 45 seconds.
```

## Kończenie pracy

Po skończeniu pracy należy się wylogować poleceniem `exit` lub `logout`
lub kombinacją klawiszy `Ctrl+D`.

## Support

Wsparcie użytkowników i obsługa grantów obliczeniowych:

- E-mail: pomoc([monkey](https://en.wikipedia.org/wiki/At_sign#Names_in_other_languages))icm.edu.pl
- Telefonicznie: +48 22 8749 200
