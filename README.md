## Bakalárska práca
# Využitie strojového učenie pri získavaní dát zo softvérových repozitárov

Cieľom tejto bakalárskej práce bolo klasifikovať zdrojové kódy (programovacieho jazyka lua) do určitých tried.

## Obsah repozitára
- `modules` adresár obsahuje lua moduly, z ktorých boli extrahované grafy
- `data` adresár obsahuje už extrahované (a spracované) grafy vo formáte JSON
- `extraction` adresár obsahuje zdrojové kódy použité k extrakcii grafov (extrahované grafy sa už nachádzajú v adresári `data`)
- `classification` adresár obsahuje jupyter notebooks k vytvoreniu modelu (klasifikátoru) a jeho následnému použitiu na extrahovaných grafoch


## Extrakcia grafov zo zdrojových kódov.
Pri tomto kroku som nadviazal na doterajšie práce a použil extraktor z existujúceho projektu http://labss2.fiit.stuba.sk/TeamProject/2020/team03/.
Tento extraktor vytvorí veľký graf nad celým repozitárom, preto bolo nutné tento graf ďalej spracovať. Moje zdrojové kódy k tomuto kroku sa nachádzajú v zložke `extraction`

## Vytovrenie klasifikátora
Extrahované grafy som načítal v prostredí Jupyter Notebook a následne som ich ďalej spracúval a "čistil". Po získaní finálneho datasetu z grafov som vytvoril a natrénoval model neurónovej siete. Zdrojové kódy k týmto krokom sa nachádzajú v zložke `classification`
