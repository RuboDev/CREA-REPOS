@echo off

:: Pedimos usuario para ruta de add origin
set /p user= "Introduzca usuario de GitHub:"
:: Pedimos token PAT para autenticar en gitHub
set /p token= "Introduzca token de acceso personal(PAT):"

:: Pedimos y guardamos en la variable nomRepo el nombre del repositorio, y en la variable descripcion la descripcion del repositorio.
echo *** Creando Nuevo repositorio ***
set /p nomRepo= "Introduzca nombre para su repositorio:"
set /p descripcion= "Introduzca descripcion de su repositorio:"
:: Pedimos nombre de la rama para el primer commit, usualmente master, o main
set /p rama= "Introduzca rama inicial del flujo de trabajo(ej.: master):"

cd ..

:: Logueamos a GitHub y Creamos Nuevo Repositorio con nombre pasado anteriormente por consola
gh auth login --with-token %token%
gh repo create %nomRepo% --public --confirm -d "%descripcion%"

cd %nomRepo%

::Creamos .gitignore
type ..\CREA-REPOS-master\.gitignoresource.txt >> .gitignore 
::Comprobamos si el archivo .gitignore esta vacio, si es asi utilizamos otra ruta
For %%f In (.gitignore) Do If %%~zf==0 (type ..\CREA-REPOS\.gitignoresource.txt >> .gitignore)



:: Creamos README.md con el nombre pasado por consola como cabecera y el texto abajo escrito
echo # %nomRepo% >> README.md
echo @@@Codigo autogenerado@@@ >> README.md
echo Edite este archivo para adecuar su contenido al repositorio. >> README.md

:: Inicializamos, agregamos, commiteamos, elegimos como rama la rama master, agregamos remoto con mismo nombre que el introducido por consola y pusheamos.
git add *
git commit * -m "NEW: %nomRepo% 1st commit, .gitignore and README added"
git branch -M %rama%
git remote add origin https://github.com/%user%/%nomRepo%.git
git push -u origin %rama%
pause