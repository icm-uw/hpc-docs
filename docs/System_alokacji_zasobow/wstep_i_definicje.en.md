# Resource allocation system in ICM

The system is available at <https://granty.icm.edu.pl/>.
It allows you to:

* submit an application for a new user account in ICM
* submit project application
* submit applications for allocation of computing resources under the project
* adding co-contractors to the project
* submission of reports and publications obtained under the project
* checking resource consumption

!!! info "DEFINITIONS"
    **Project** - describes the scientific activity.
    Within the project, we distinguish:

    * **Project manager (PI - Principal Investigator)** - defines the person responsible for the project.
    * **Allocation - (equivalent to 'account' in SLURM)** - describe the allocated computing resources (amount, duration).
    * **Grants (NCN, NCBiR, etc.)** - describe the source of funding.
    * **Reports** - describe the calculation results, reported once a year.

## Access to resources

Access to the supercomputer can be divided into two parts:

1. Account activation - possibility to log in
2. Granting allocation - possibility to perform calculations

Why such a division?

After the allocation is consumed, the user can still log in and download the results of his/her the calculations.
