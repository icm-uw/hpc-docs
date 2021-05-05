# Introduction

After getting acquainted with the idea of ​​the [Resource Allocation System and definitions](./wstep_i_definicje.en.md), we can start setting up an account.

## Create the user's account

At the top of the <https://granty.icm.edu.pl/> page, click on `Account application` and follow the instructions.

The account activation has the following stages:

1. New - the user has submited an application. The website sends a message in order to confirm user's e-mail address.
2. Confirmed - the user has confirmed the e-mail address provided during registration.
3. Accepted - the administrators accepted the data given in the application.
4. Activated - the account has been launched in the system.

!!! success "Principal Investigator (PI)"
    Only the Project Investigator (PI) can create projects and apply for computational resources (allocations).

    We grant Project Investigator (PI) rights to users who:

      * works in a Polish research instituition/university
      * holds a doctoral degree

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

* [Avalaible supercomputers - Okeanos, Topola, Rysy](../O_zasobach_ICM/Zasoby/komputery_w_icm.md)
* [Types of allocations](./rodzaje_alokacji.en.md)

## Principal Investigator (PI) - obligations

Once the project is launched, the Principal Investigator is obliged to:

* verify information about co-contractors of his/her project, e.g.
report people with whom they have terminated their cooperation until the account is closed, correct their contact details.
* update the grant summary as scientific calculations develop
* update data on the research institution in the event of its change by the grant manager or co-contractors
* follow the licensing rules
* publish in scientific publications about the project,
* the publications shall indicate that the computations have been carried out [using ICM infrastructure](./rozliczanie_projektu.en.md)
* submit [report from project](./rozliczanie_projektu.en.md), annualy.
* once a year participate in the KDM Users' Reporting Session at ICM, information about which is sent by e-mail.

### How to add contractors to a project

Project manager (PI), after entering the `Projects` tab and selecting
appropriate project from the list, may add additional co-contractors.
Click on the `Add users` button.

If the contractor does not have an account in ICM, then

* it is worth sending him/her an invitation - it will definitely speed up the account opening process

* he/she may applies for the opening of an account by himself
  
If the contractor already has an account in ICM,
then the user search option shall be used.

Please note that only users who have granted the consented (`User profile> Edit profile> Other users can find my profile`) will be visible.

### Several computing projects

It is possible to have several computational projects in ICM.
New projects should be opened in situations where you plan to conduct new calculations, unrelated to the current project.

## I already have an account, project and allocations, what next?

To run calculations on a supercomputer:

* Log in from [Windows](../Tutorials/Logowanie/ssh_windows.en.md) or [UNIX/Linux](../Tutorials/Logowanie/ssh.en.md).

* The user can obtain basic data about his grant and account from [command line](../Tutorials/HPC-intro/status_grantu_i_konta.md) or by using the website <https://granty.icm.edu.pl/>.

* [Submit a computational task](../Tutorials/HPC-intro/slurm_intro.md).
