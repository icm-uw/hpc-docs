# SSH - login

!!! Tip
    ICM login: `ssh username@hpc.icm.edu.pl`.
    Logging in is done using a username (up to 8 letters, not an e-mail address).
    On some systems, an additional login step is possible/required from the hpc.icm.edu.pl computer, 
    e.g. `ssh rysy`, `ssh okeanos`.

!!! Info
    From December 2020, logging in using the ssh protocol requires two-factor authentication (2FA - 2 Factors Authentication) with the use of TOTP (Time-based One-time Password) tokens.

## Account name and password setting

When log in in for the first time, it is necessary to [change the password](./nazwa_konta_i_haslo.en.md).

## Two-factor authorization (2FA)

When logging in using ssh to the `hpc.icm.edu.pl` server, the user provides the data (password / key) and then an additional request for **OTP** (one time password) appears, i.e. a one-time code, individual for everyone, generated using a special application.

### 2FA - TOTP token registration

In order to register the token, please log in with your data at ICM UW to the website `https://mfa.hpc.icm.edu.pl`
and generate the token without changing the default settings (enroll token).
A QR code will appear, which should be scanned [into the application](./ssh.en.md#applications-to-handle-totp-tokens).
The system will expect to provide the current token value displayed in the application when logging in to `hpc.icm.edu.pl`, even if it has not been generated so far.

!!! Warning
    After removing the token from the application on the phone, it cannot be recovered (only reset by the administrator).

### Applications to handle TOTP tokens

In order to obtain the code, it is necessary to install an application that supports the **TOTP** (Time-based One-time Password) token mechanism, e.g. `FreeOTP` or `GoogleAuthenicator` on your phone.
The applications are available in either GooglePlay or AppStore, the are free and do not require internet access (they work offline).

The use of the phone application is preferred because:

- it is easier to handle
- another device is an additional safety factor

If this is not possible, you may install the application on your computer.
Details below.

#### GNU/Linux

TOTP token can be registered with a GUI application, like <https://keepassxc.org/>

Alternatively, the TOTP token can be registrated with "pass", which is a CLI (command line interface)) application. 
Instructions for GNU/Linux operating system:

1. Install the "pass" application. It is convenient to use the
official package repository for your distribution. Alternatively - you
can download it from: https://github.com/tadfisher/pass-otp

2. "Pass" stores the passwords in an encrypted form which requires the
"gnupg" package to be installed as well (use the package
repository). Once "gnupg" is installed, it is necessary to generate
the GPG key pair - this can be done with the command:

    `gpg --full-gen-key`

    Please follow the instructions and, if not sure, accept the
    default parameters.

    Initialize the "pass" database with:

    `pass init <gpg-id or e-mail used for GPG key>`

3. Start your Internet browser, navigate to https://mfa.hpc.icm.edu.pl
and log in with your credentials.

4. Choose "Enroll Token" option and confirm the default parameters by
"Enroll".

	!!!Note
		Be careful! If you run through the process quickly,
	        you might lose the newly created token.

	You are automatically redirected to a website containing a QR code
	corresponding to your token. There is also a link of the form:

	`otpauth://totp/?secret=AAABBBCCCDDDEEFFFGGGGHHH&algorithm=SHA1&digits=6&period=30`

	Copy the link's address into the clipboard or any text editor.

5. In the terminal, use the command:

   `pass otp insert icm`

   You will be asked to provide "otpauth://". Paste the link you
	have just copied.

   If you receive a message like `Error: otp is not in the password store.`,
   then the 'pass-otp' plugin for 'pass' application has been improperly installed.
   As a result, the 'otp' command is not recognized.
   Improper examples are listed below:

   ```.bash
   username@hostname:~$ pass blahblah
   Error: blahblah is not in the password store.

   username@hostname:~$ pass blahblah insert
   Error: blahblah is not in the password store.

   username@hostname:~$ pass blahblah insert icm
   Error: blahblah is not in the password store.
   ```

6. Done. You can now close the token registration website and discard the
link. To use the token, issue the command:

      `pass otp icm`

      You will be asked for password – NOTE: this is the GPG key
      password you have created in (1).

      You can make the process more convenient with the "-c" option:

      `pass otp -c icm`

      Then, the token will not be displayed, but copied into your
      clipboard instead - you can paste it directly into your SSH
      session.

      Optionally, to make the process even more convenient, you can create
      the following alias (and put it into your ~/.bashrc) - for Bash shell:

      ```
     alias sshicm='pass otp -c icm && ssh <USERNAME>@213.135.51.79'
      ```

      (replacing the <USERNAME> string accordingly).

	   To log into the ICM system, you can then use the command:

	   `sshicm`

	   It will generate a token (asking only for the GPG
	   password), place it in the clipboard, and connect you to
	   ICM where you can directly paste the OTP token from your
	   clipboard.

#### MS Windows

TOTP token registration with "OTP Manager" for MS Windows 10
(available from Windows Store):

1. Install OTP Manager for Windows.

2. Start the application and choose to manually add new token.

3. Start your Internet browser, navigate to https://mfa.hpc.icm.edu.pl
   and log in with your credentials.

4. Choose "Enroll Token" option and confirm the default parameters by
   "Enroll".

	*Note: Be careful! If you run through the process quickly, you might lose the newly created token.*

5. You are automatically redirected to a website containing a QR code
   corresponding to your token. There is also a link of the form:

      `otpauth://totp/?secret=AAABBBCCCDDDEEFFFGGGGHHH&algorithm=SHA1&digits=6&period=30`

      Copy the link's address into any text editor.

6. Copy the text starting after "secret=" and ending before "&" sign
   (e.g. AAABBBCCCDDDEEFFFGGGGHHH). It is the secret token key which
      should be protected or forgotten when the registration procedure is
         done.

7. Paste the secret key into the OPT Manager application ("Secret"
   field). Feel free to fill in the remaining fields according to your
      preferences. Save the token with the diskette icon on the
         application toolbar.

8. OTP Manager should generate a 6-digit OTP code which you can insert
   directly in your ICM SSH session upon login.

9. At this point, the token registration website can be closed and the
   secret key forgotten.


## Create SSH Keys

Logging in can be authenticated by entering a password or by using a cryptographic key.
The keys are more secure (and more convenient - you don't have to type a password every time).

``` .sh
# To generate SSH keys on the local computer use the command:
ssh-keygen
# Then copy the public key to the target server:
ssh-copy-id -i ~/.ssh/mykey.pub user@your.server.example.com
# Only you (and no other user) should be able to read the keys:
chmod 400 ~ /.ssh/mykey
# If you want to use an existing key, don't forget to add it to 'ssh agent' on the local machine
ssh-add ~/.ssh/mykey
# if `ssh-add` fails saying `Could not open a connection to your authentication agent.` you have to start the ssh-agent
eval `ssh-agent -s`

# logging in
ssh user@your.server.example.com
# logging in in with a specific key
ssh -o IdentitiesOnly = yes -i ~ / .ssh / example_rsa user@your.server.example.com
# logging in in using a password (instead of a key)
ssh -o PubkeyAuthentication = no user@your.server.example.com
```

### Digital popdis of the hpc.icm.edu.pl access machine

When logging in, the user's computer makes sure that it connects to the authorized `hpc.icm.edu.pl` machine.
For this purpose, the [cryptographic key imprint](https://en.wikipedia.org/wiki/Public_key_fingerprint) of the access machine is checked.
When connecting for the first time, you must agree to adding `hpc.icm.edu.pl` to your *friends* list.

```.txt
ssh username@hpc.icm.edu.pl
The authenticity of host 'hpc.icm.edu.pl (2001: 6a0: 2001: 2321 :: 79)' can't be established.
ECDSA key fingerprint is SHA256: KGMfnzeNErKlS8J / MYOBsnFKFl95VJ + BFm4FAYwKV6A.
Are you sure you want to continue connecting (yes / no / [fingerprint])? yes
Warning: Permanently added 'hpc.icm.edu.pl' (ECDSA) to the list of known hosts.
OTP:
```

The procedure for removing the old keyprint is shown below.

#### Windows

Run the `regedit` program (Windows system application).
Then, in the panel on the left, search for an entry in the tree:

```.txt
HKEY_CURRENT_USER \ Software \ UserName \ PuTTY \ SshHostKeys
```

and in the window on the right, find the line containing the name 'hpc.icm.edu.pl', and then delete it.

#### Linux

To delete the old key, run the following command in the terminal:

```.sh
ssh-keygen -f $ HOME/.ssh/known_hosts -R hpc.icm.edu.pl
```

## Password Manager

The [pass] program <https://www.passwordstore.org/> is a password manager that allows linux users to safely store their passwords on the local computer.
For example:

```.txt
$ pass remote_computers / icm -c
Copied zdalne_kompociąg / icm is a clipboard. Will clear in 45 seconds.
```

## Finishing work

When you are finished, log out with the command `exit` or` logout`
or with the key combination `Ctrl + D`.

## Support

User support and support for computational grants:

- E-mail: help ([monkey](https://en.wikipedia.org/wiki/At_sign#Names_in_other_languages)) icm.edu.pl
- By phone: +48 22 8749 200
