---
title: ""
date: 2020-04-28
draft: false
--- 

Często pojawia się pytanie czy użytkownik ma dostęp do XXX?
Aby sprawdzić status grantu / konta należy:

```.slurm
sacctmgr show user $USER # pokaż informacje o użytkowniku
id $USER # pokaż informacje o użytkowniku i jego grupach dostępu
finger $USER # udostępnia podstawowe dane o użytkowniku
groups # udostępnia listę grup, do których należy użytkownik
limit # limity nałożone na procesy użytkownika

sacctmgr show assoc format=account,cluster,user,qos | grep $USER # pokaż w jakich jestem grupach i do których qos mam dostęp
sacctmgr show qos format=name,MaxWall # pokaż limit czasu obliczen dla qos
```

**Jak policzyć ile grantu jeszcze zostało?**

```.slurm
/apps/bin/chkgrantusage <grant_id> [yyyy-mm-dd yyyy-mm-dd] # aktualnie zużycie
sacctmgr show assoc where account=<grant_id> format=user,GrpTRESMins%50  # limit cpu w grancie
```
