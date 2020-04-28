---
title: ""
date: 2020-04-28
draft: false
---

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
