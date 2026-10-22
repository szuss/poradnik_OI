By odpalić terminal naciśnij ctrl + alt + t na linuxie lub win + r i wpisz cmd na (tfu) windowsie (pamiętaj, że skrypty odpalasz w Powershellu by go odpalić naciśnij win i wyszukaj powershell). Wszędzie gdzie się da zakładam, że jesteśmy w folderze z plikiem
## część dla wszystkich
1. cd - przechodzenie do folderów
- by przejść do folderu domowego wpisz cd
- by przejść do jakiegoś folderu wpisz cd *ścieżka do folderu* (dajemy ścieżke pomijając jej fragment do aktualnego folderu)
- by się cofnąć o jeden folder wpisz cd ..
2. kompilacja 
- najpierw dajemy g++
- potem flagi kompilacji, osobiście daje -O2 -Wall -Wextra -fsanitize=address -std=c++23 
- następnie rozw.cpp
- jeżeli plik wykonywalny ma się nazywać inaczej niż rozw (lub rozw.exe) na windowsie to dajesz -o *twoja nazwa skompilowanego rozwiązania*
3. Wyświetlanie zawartości folderu
- wpisz ls
4. Poznanie ścieżki do aktualnego programu
- wpisz pwd
5. By zobaczyć listę instrukcji 
- wpisz help
6. Zakończenie aktualnego procesu
- ctrl + c
- ctrl + z

# tylko na Linuxie
możliwe, że niektóre poniższe komendy działają na windowsie ale nie jestem tego pewien
1. otwieranie plików
- masz plik tekstowy (niektóre formaty jak .doc nie zadziałają), który chcesz zedytować wpisz nano plik.rozszerzenie
- masz inny plik wpisz open plik.rozszerzenie
- do przeglądania less *plik*
2. wypisanie czegoś na terminal
- wpisz echo "*co chcesz wypisać*"
3. Przekierowanie danych z programu do pliku (lub programu)
- wyczyszczenie pliku lub jego utworzenie > np. echo "Wojtek Furas" > plik (istotne **nie możesz odwracać *>*** komenda echo "Wojtek Furas" < plik jest czymś zupełnie innym)
- doklejenie na koniec pliku >> np zad >> plik
4. Przekierowanie danych z pliku (bądź programu) do programu
- wpisz szachy < ruch.txt
5. Wyłączenie terminala
- wpisz exit
- naciśnij ctrl + d
6. [więcej](https://www.astrouw.edu.pl/~jskowron/pracownia/komendy/)