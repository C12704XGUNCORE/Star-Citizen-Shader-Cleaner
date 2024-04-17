::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBFbQgWWAE+/Fb4I5/jH3P6GsA0+XfY2YorVmoeGIeQW+AXHeZMs2H9IpOgNHA9NbBfmajCXYG1Qt2rIZZfO50KxHgXYtgZhTDQi1jCehSg0AA==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFBFbQgWWAE+/Fb4I5/jH+vqDo1kYGucnfe8=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
cls
color 0B
echo.
echo   Chargement...
SETLOCAL enableextensions

:: Definition des chemins d'installation
set "installDir=C:\Program Files\Roberts Space Industries\StarCitizen"
set "userFolder=%installDir%\LIVE\USER"
set "userBackups=C:\StarCitizen\Backups\USER"
set "userKeybinds=%userFolder%\Client\0\Profiles\default"
set "userMappings=%userFolder%\Client\0\Controls\Mappings"
set "keybindBackups=%userBackups%\Keybinds"
set "mappingBackups=%userBackups%\Mappings"
set "backups=C:\StarCitizen\Backups"
set "userShaders=%LocalAppData%\Star Citizen"
set "shadersAMD=%LocalAppData%\AMD"
set "shadersNV=%LocalAppData%\NVIDIA\DXCache"

:: Definition des informations de l'outil de reset du cache
set "SCRT_VERSION=1.2.0"
set "SCRT_DATE=17.04.2024"
set "SCRT_AUTHOR=C12704XGUNCORE"

:: Affichage du titre de la fenetre
title Star Citizen Shader Cleaner (SCRT) v%SCRT_VERSION% (%SCRT_DATE%)

:: Affichage de l'ecran de bienvenue
cls
echo  **************************************************************************************************************
echo  *                                Star Citizen Shader Cleaner // v%SCRT_VERSION% (%SCRT_DATE%)                *
echo  *                                      mis a jour By: %SCRT_AUTHOR%                                           *
echo  *                                                                                                            *
echo  * Script pour automatiser l'effacement de votre cache de shader Star Citizen, de votre dossier utilisateur   *
echo  * et d'AMD + NVIDIA caches de shaders. Le script sauvegardera egalement vos raccourcis clavier personnels    *
echo  * et vos mappages de boutons personnalises.                                                                  *
echo  *                                                                                                            *
echo  * Il est fortement recommande aux joueurs de supprimer leurs dossiers Shader pour le client Public. Apres    *
echo  * l'application du correctif, en particulier si vous commencez a rencontrer des problemes graphiques ou un   *
echo  * crash de personnage etrange au chargement ou une chute de FPS anormal.                                      *
echo  **************************************************************************************************************

:: etape 1 : Star Citizen
echo.
echo ============================================================================================================
echo -------- ETAPE 1 : Star Citizen ----------
echo ============================================================================================================
echo.

:: Question 1 (Reinitialiser le dossier utilisateur?)
color 0A
:resetSC1Q1
set /p "choice=1. Souhaitez-vous nettoyer votre dossier UTILISATEUR ? (RECOMMANDE) [o/n] "
color 0B
if /I "%choice%"=="o" goto :resetSC1Q2
if /I "%choice%"=="n" goto :resetSC1noChange
echo *** SELECTION INVALIDE ! (Vous devez taper "o" (oui) ou "n" (non) en minuscules ***
goto :resetSC1Q1

:: L'utilisateur a dit "non" a la question 1 (Reinitialiser le dossier utilisateur?)
:resetSC1noChange
echo ...... IGNORE !
goto :resetSC2Q1

:: Question 2 (Sauvegarder les raccourcis clavier et les mappages de boutons?)
color 0A
:resetSC1Q2
set /p "choice=2. Voulez-vous sauvegarder vos RACCOURCIS Clavier et vos MAPPAGES de boutons, en premier ? (RECOMMANDE) [o/n] "
color 0B
if /I "%choice%"=="o" goto :resetSC1backup1
if /I "%choice%"=="n" goto :resetSC1
echo *** SELECTION INVALIDE ! (Vous devez taper "o" (oui) ou "n" (non) en minuscules ***
goto :resetSC1Q2

:: L'utilisateur a dit "oui" a la question 2 (Sauvegarder les raccourcis clavier et les mappages de boutons?)
:resetSC1backup1
echo.
if not exist "%keybindBackups%" mkdir "%keybindBackups%"
echo Creation du repertoire de sauvegarde pour les raccourcis clavier...
xcopy /E /I /H /Y "%userKeybinds%" "%keybindBackups%"
echo Repertoire de sauvegarde cree a : "%keybindBackups%"

:: Reinitialiser les mappages de boutons
if not exist "%mappingBackups%" mkdir "%mappingBackups%"
echo Creation du repertoire de sauvegarde pour les mappages de boutons...
xcopy /E /I /H /Y "%userMappings%" "%mappingBackups%"
echo Repertoire de sauvegarde cree a : "%mappingBackups%"

:: Supprimer le contenu du dossier utilisateur de Star Citizen
echo Suppression du contenu du repertoire utilisateur...
if exist "%userFolder%" (
    rd /S /Q "%userFolder%"
    echo Contenu du repertoire utilisateur supprime.
) else (
    echo Le repertoire utilisateur n'existe pas.
)

:: Suite du script...

:: etape 1 : Star Citizen (suite)
echo.
echo.

:: Question 3 (Reinitialiser le cache de shaders de Star Citizen?)
color 0A
:resetSC2Q1
set /p "choice=3. Voulez-vous reinitialiser votre cache de SHADERS (Star Citizen) ? (RECOMMANDE) [o/n] "
color 0B
if /I "%choice%"=="o" goto :resetSC2
if /I "%choice%"=="n" goto :resetSC2noChange
echo *** SELECTION INVALIDE ! (Vous devez taper "o" (oui) ou "n" (non) en minuscules ***
goto :resetSC2Q1

:: L'utilisateur a dit "oui" a la question 3 (Reinitialiser le cache de shaders de Star Citizen?)
:resetSC2
echo.
echo Suppression du cache de shaders de Star Citizen...
if exist "%userShaders%" (
    rd /S /Q "%userShaders%"
    echo Cache de shaders de Star Citizen supprime.
) else (
    echo Le cache de shaders de Star Citizen n'existe pas.
)
goto :Stage2Header

:: L'utilisateur a dit "non" a la question 3 (Reinitialiser le cache de shaders de Star Citizen?)
:resetSC2noChange
echo ...... IGNORE !
goto :Stage2Header

:: En-tete pour passer aux shaders systeme
:Stage2Header
echo.
echo ============================================================================================================
echo ---------- ETAPE 2 : Shaders Systeme --------
echo ============================================================================================================

:: Question 4 (Reinitialiser le cache de shaders AMD/NVIDIA)
color 0A
:resetCacheQ1
echo.
echo.
echo ------------------------------------------------------------------------------------------------------------
set /p "choice=4. Voulez-vous reinitialiser votre cache de SHADERS (AMD/Nvidia) ? (OPTIONNEL) (UTILE DANS CERTAINS CAS) [o/n] "
color 0B
if /I "%choice%"=="o" goto :resetCacheAMD
if /I "%choice%"=="n" goto :resetCacheNoChange
echo *** SELECTION INVALIDE ! (Vous devez taper "o" (oui) ou "n" (non) en minuscules ***
goto :resetCacheQ1

:: L'utilisateur a dit "non" a la question 4 (Reinitialiser le cache de shaders AMD/NVIDIA)
:resetCacheNoChange
echo ...... IGNORE !
goto :endofScript

:: Reinitialisation du cache de shaders AMD
:resetCacheAMD
echo.
echo Suppression du cache de shaders AMD Radeon...
if exist "%shadersAMD%" (
    rd /S /Q "%shadersAMD%"
    echo Cache de shaders AMD Radeon supprime.
) else (
    echo Le cache de shaders AMD Radeon n'existe pas ou est introuvable.
)
goto :resetCacheNV

:: Reinitialisation du cache de shaders NVIDIA
:resetCacheNV
echo.
echo Suppression du cache de shaders Nvidia DirectX...
if exist "%shadersNV%" (
    rd /S /Q "%shadersNV%"
    echo Cache de shaders Nvidia DirectX supprime.
) else (
    echo Le cache de shaders Nvidia DirectX n'existe pas ou est introuvable.
)
goto :resetTempQ1

:: Question 5 (Supprimer les fichiers temporaires)
color 0A
:resetTempQ1
echo.
echo.
echo ------------------------------------------------------------------------------------------------------------
@echo off
setlocal

set tempFolder=C:\Users\%username%\AppData\Local\Temp

echo.
echo.
echo ------------------------------------------------------------------------------------------------------------
set /p "choice=5. Voulez-vous supprimer les fichiers temporaires dans le repertoire '%tempFolder%' ? (RECOMMANDE) [o/n] "
color 0B
if /I "%choice%"=="o" goto :resetTemp
if /I "%choice%"=="n" goto :endofScript
echo *** SELECTION INVALIDE ! (Vous devez taper "o" (oui) ou "n" (non) en minuscules ***
goto :resetTempQ1

:: L'utilisateur a dit "oui" a la question 5 (Supprimer les fichiers temporaires)
:resetTemp
echo.
echo Suppression des fichiers temporaires...
if exist "%tempFolder%" (
    cd /d "%tempFolder%"

    for /f "delims=" %%i in ('dir /s /b /a-d') do (
        del "%%i" 2>nul
    )

    for /d %%d in ("*") do (
        rmdir "%%d" /s /q 2>nul
    )

    echo Fichiers temporaires supprimes.
) else (
    echo Le repertoire temporaire n'existe pas ou est introuvable.
)

echo ============================================================================================================
echo ---------- ETAPE 4 : Nouvelle etape automatique pour la gestion de l'alimentation maximale --------
echo ============================================================================================================
echo.
echo Definir le plan d'alimentation sur Haute Performance
echo --------
echo Definition du plan d'alimentation sur Haute Performance...
echo --------
powercfg -s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo Plan d'alimentation defini sur Haute Performance. !!

@echo off
echo ============================================================================================================
echo ---------- ETAPE 5 : Nettoyage des disques --------
echo ============================================================================================================
echo Nettoyage des disques en cours...

:: Nettoyage de tous les disques
for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%D:\NUL (
        echo Nettoyage du disque %%D...
        cleanmgr /d %%D: /sagerun:1
    )
)

echo Nettoyage des disques terminer.
echo.
echo.
echo ============================================================================================================
echo :: SCRIPT TERMINE ! ::
echo ============================================================================================================
echo.
echo "Appuyez sur n'importe quelle touche pour QUITTER. . . . . . . "
pause >nul