
# Wstęp

Po zapoznaniu się z ideą działania [Systemu Alokacji Zasobów i podstawowymi definicjami](./wstep_i_definicje.pl.md) możemy przystąpić zakładania konta.

## Zakładanie konta

Na górze strony <https://granty.icm.edu.pl/> należy kliknąć w `Wniosek o nowe konto` i postępować zgodnie z instrukcją.

Wniosek o uruchomienie konta ma następujące statusy:

1. Nowy - użytkownik wysłał wniosek. Serwis wysyła wiadomość z prośbą o potwierdzenie adresu e-mail.
2. Potwierdzony - użytkownik potwierdził adres e-mail podany przy rejestracji.
3. Zaakceptowany - administratorzy zaakceptowali dane zawarte we wniosku.
4. Aktywowany - konto zostało uruchomione systemie.

!!! success "Kierownik Projektu (PI)"
    Tylko Kierownik Projektu (PI) może tworzyć projekty i występować o alokacje zasobów obliczeniowych.

    Uprawnienia Kierownika Projektu (PI) przyznajemy osobom, które:

      * pracują w polskiej jednostce naukowej
      * posiadają stopień naukowy doktora   

### Utworzenie projektu

Po zalogowaniu, na górze strony <https://granty.icm.edu.pl/> należy kliknąć w `Projekt --> Dodaj projekt`.
Należy podać tytuł, opis (wystarczy pół strony A4) i wybrać dyscyplinę.
Opis projektu powinien być skoncetrowany na **naukowym** aspekcie badań.

### Utworzenie alokacji

Na stronie projektu należy kliknąć w `Wystąp o nową alokację`.
Należy wybrać superkomputer z którego chcemy korzystać. 
We wniosku należy podać ilość zasobów obliczeniowych (CPUh - rdzeniogodziny).
Opis powinien być skoncetrowany na **obliczeniowym** aspekcie badań. 

Informacje o zadobach udostępnianych przez ICM:

* [Dostępne superkomputery - Okeanos, Topola, Rysy](../O_zasobach_ICM/Zasoby/komputery_w_icm.md)
* [Rodzaje alokacji](./rodzaje_alokacji.pl.md)

## Obowiązki Kierownika Projektu (PI)

Po uruchomieniu projektu, kierownicy powinni:

* Weryfikować informacje o współwykonawcach swojego projektu np.
zgłaszać do zamknięcia konta osób z którymi zakończyli współpracę, poprawiać dane kontaktowe.
* Aktualizować streszczenie projektu w miarę rozwoju obliczeń naukowych.
* Aktualizować dane o instytucji naukowej, w przypadku jej zmiany przez kierownika lub współwykonawców projektu.
* Rrzestrzegać zasad dotyczących licencji.
* Zamieszczać w publikacje naukowe dotyczące projektu.
* Zamieszczać w publikacjach informację [o korzystaniu z zasobów obliczeniowych ICM](./rozliczanie_projektu.pl.md)
* Raz w roku dokonywać [rozliczenia projektu](./rozliczanie_projektu.pl.md).
* Raz w roku uczestniczyć w Sesji Sprawozdawczej Użytkowników KDM w ICM, o której informacje rozsyłane są drogą mailową.

### Jak dodać współwykonawców do projektu

Kierownik projektu (PI), po wejściu w zakładkę `Projekty` i wybraniu
właściwego projektu z listy, może dodać kolejnych współwykonawców.
Klikamy w guzik `Dodaj użytkowników`.

Jeżeli współwykonawca nie posiada konta w ICM:

* kierownik projektu wysyła zaproszenie współwykonawca - zdecydowanie przyśpiesza to proces otwarcia konta

* alterntatywnie, współwykonawca wnioskuje samodzielnie o otwarcie konta
  
Jeżeli wspólwykonawca posiada już konto w ICM, 
to korzystamy z opcji wyszukiwania użytkownika.

Należy pamiętać, że tylko użytkownicy, którzy wyrazili zgodę na wyszukiwanie (`Profil użytkownika> Edytuj profil> Inni użytkownicy mogą znajdować mój profil`) będą widoczni.

### Kilka projektów obliczeniowych

Można posiadać kilka projektów obliczeniowych w ICM.
Nowe projekty powinno się otwierać w sytuacjach gdy planujemy prowadzić nowe obliczenia, niezwiązane z dotychczasową tematyką.

## Mam już konto, projekt i alokacje, co dalej?

Aby uruchomić obliczenia na superkomputerze, należy:

* Zalogować się z systemu [Windows](../Tutorials/Logowanie/ssh_windows.pl.md) lub [UNIX/Linux](../Tutorials/Logowanie/ssh.pl.md).

* Użytkownik możne uzyskać podstawowe dane o swoim grancie i koncie z [linii poleceń](../Tutorials/HPC-intro/status_grantu_i_konta.md) lub korzystając z serwisu <https://granty.icm.edu.pl/>.

* [Zlecić zadanie](../Tutorials/HPC-intro/slurm_intro.md).
