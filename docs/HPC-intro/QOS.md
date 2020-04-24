---
title: "6 QOS"
date: 2020-03-16
draft: false
---

## QOS na poszczególnych systemach

QOS - Quality of Service

### Topola - qos

```.sh
[username@hpc ~]$ sacctmgr show qos format=name,MaxWall,Priority,MaxTRESPU%50


      Name     MaxWall   Priority                                     MaxTRESPU
---------- ----------- ---------- ---------------------------------------------
    normal                      0
       hpc  7-00:00:00        750
    plgrid  7-00:00:00        750
       egi  7-00:00:00        500
     meteo                   1500  
```

### Okeanos - qos

```.sh
okeanos-login1 /home/username> sacctmgr show qos format=name,MaxWall,Priority,MaxTRESPU%50


      Name     MaxWall   Priority                                     MaxTRESPU
---------- ----------- ---------- ---------------------------------------------
    normal                      0
       hpc  2-00:00:00        750
     ocean  4-00:00:00       1000                                     node=1024
ocean-long  7-00:00:00        750                                      node=256
```

### RYSY - qos

```.sh
username@rysy ~ $ sacctmgr show qos format=name,MaxWall,Priority,MaxTRESPU%50


      Name     MaxWall   Priority                                     MaxTRESPU
---------- ----------- ---------- ---------------------------------------------
    normal  2-00:00:00        100                                        node=2
     limit    06:00:00        100            cpu=8,gres/gpu=1,gres/ve=1,mem=90G
     short    00:15:00      10000
      prio  2-00:00:00      10000
      long  7-00:00:00          1     cpu=8,gres/gpu=1,gres/ve=1,mem=90G,node=1
      none                      0                                         cpu=0
```

Skróty:

- *TRES* - Trackable RESources. A TRES is a resource that can be tracked for usage or used to enforce limits against

- *PU* - Processing Unit.