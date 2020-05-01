---
title: ""
date: 2020-04-28
draft: false
--- 

Często pojawia się pytanie czy użytkownik ma dostęp do XXX?

Aby sprawdzić status grantu / konta / qos należy użyć polecenia `sacctmgr`, udostępnionego przez system *Slurm*.

```.slurm
sacctmgr show user $USER # pokaż informacje o użytkowniku
sacctmgr show assoc where account=<grant_id> format=Cluster,Account%25,Partition%20,user,QOS,DefaultQOS,GrpTRESMins%50 # pokaż informację o grancie
sacctmgr show assoc format=account%25,cluster,user,QOS | grep $USER # pokaż w jakich jestem grupach i do których qos mam dostęp
sacctmgr show qos format=name,MaxWall,Priority,MaxTRESPU%50 # pokaż limit czasu obliczen dla poszczególnych qos
```

Inne przydatne komendy:

```.slurm
finger $USER # udostępnia podstawowe dane o użytkowniku
groups $USER # udostępnia listę grup, do których należy użytkownik
getent group NAZWA_GRUPY # wypisuje użytkowników należących do danej grupy  
limit # limity nałożone na procesy użytkownika
```

**Jak policzyć ile grantu jeszcze zostało?**

```.slurm
/apps/bin/chkgrantusage <grant_id> [yyyy-mm-dd yyyy-mm-dd] # aktualnie zużycie
sacctmgr show assoc where account=<grant_id> format=user,GrpTRESMins%50  # limit cpu w grancie
```
