
Pliki php należy umieścić w folderze `public_html`, który jest automatycznie kopiowany w odpowiednie miejsce kontenera przy jego budowaniu. Bazę danych MySQL należy wyeksportować do pliku sql i umieścić jako `database.sql`. Wtedy przy pierwszym zbudowaniu zostaną wykonane polecenia z pliku. Plik `project.conf` zawiera podstawową konfigurację serwera, którą można zmodyfikować. Jest ona automatycznie kopiowana w odpowiednie miejsce kontenera.

Do uruchomienia projektu lokalnie należy sklonować repozytorium poleceniem `git clone` a następnie wywołać `docker-compose up`. 

