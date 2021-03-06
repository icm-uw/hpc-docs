# Introduction

After getting acquainted with the idea of ​​the [Resource Allocation System and definitions](./wstep_i_definicje.en.md), we can start setting up an account.

## Create the user's account

At the top of the <https://granty.icm.edu.pl/> page, click on `Account application` and follow the instructions.

The account activation has the following stages:

1. New - the user has submited an application. The website sends a message in order to confirm user's e-mail address.
2. Confirmed - the user has confirmed the e-mail address provided during registration.
3. Accepted - the administrators accepted the data given in the application.
4. Activated - the account has been launched in the system.

### Principal Investigator

!!! success "Principal Investigator (PI)"
    Only the Principal Investigator (PI) can create projects and apply for computational resources (allocations).

    We grant Principal Investigator (PI) rights to users who:

      * works in a Polish research instituition/university
      * holds a doctoral degree

#### Principal Investigator (PI) - obligations

Once the project is launched, the Principal Investigator is obliged to:

* Verify information about users of his/her project, e.g.
report people with whom they have terminated their cooperation until the account is closed, correct their contact details.
* Update the grant summary as scientific calculations develop.
* Update data on the research institution in the event of its change by the grant manager or user.
* Follow the licensing rules.
* Publish in scientific publications about the project.
* The publications shall indicate that the computations have been carried out [using ICM infrastructure](./sprawozdanie_z_projektu.en.md#publications).
* Submit [report from project](./sprawozdanie_z_projektu.en.md), annualy.
* Once a year participate in the KDM Users' Reporting Session at ICM, information about which is sent by e-mail.

### Create a project

After logging in, at the top of the <https://granty.icm.edu.pl/> page, click on `Project -> Add project`.
Provide a title, description (half an A4 page is enough) and choose a scientific discipline.
The description of the project should focus on the **scientific** aspect of the research.

### Create an allocation

On the project's page, click on `Request Resource Allocation`.
Select the supercomputer you want to use.
The application must specify the amount of computing resources (CPUh - core hours).
The description should focus on the **computational** aspect of the research.

Details regarding the resources provided by ICM:

* [Avalaible supercomputers - Okeanos, Topola, Rysy](../O_zasobach_ICM/Zasoby/komputery_w_icm.en.md)
* [Types of allocations](./rodzaje_alokacji.en.md)


### How to add users to a project

Principal Investigator (PI), after entering the `Projects` tab and selecting
appropriate project from the list, may add additional users.
Click on the `Add users` button.

If the user does not have an account in ICM, then

* PI sends an invitation code to the user - it definitely speeds up the account opening process.

* Alternatively, the user may apply for the opening of an account without the invitation code.
  
If the user already has an account in ICM,
then the user search option shall be used.

Please note that only users who have granted the consented (`User profile> Edit profile> Other users can find my profile`) will be visible.

<center> ![](screen_shots/edytuj_profil_uzytkownika_en.png) </center>

### Several computing projects

It is possible to have several computational projects in ICM.
New projects should be opened in situations where you plan to conduct new calculations, unrelated to the current project.

## I already have an account, project and allocations, what next?

To run calculations on a supercomputer:

* Log in from [Windows](../Tutorials/Logowanie/ssh_windows.en.md) or [UNIX/Linux](../Tutorials/Logowanie/ssh.en.md).

* The user can obtain basic data about his grant and account from [command line](../Tutorials/HPC-intro/status_grantu_i_konta.md) or by using the website <https://granty.icm.edu.pl/>.

* [Submit a computational task](../Tutorials/HPC-intro/slurm_intro.md).
