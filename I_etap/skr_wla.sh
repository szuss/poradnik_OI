gen="./gen.cpp" # plik z generatorką testów
wzor="./wzor.cpp" # plik z rozwiązaniem wzorcowym
brut="./brut.cpp" ## plik z naszym wolnym rozwiązaniem
limit_czasu=1.5 # limit czasu w sekundach (limit z zadania podzielony na dwa (pamiętamy o liniowym spadku punktów od połowy czasu))
limit_ram=256 #limir ramu w kilobajtach (na OI limit jest podany w mebibajtach możesz to sobie przeliczać na kalkulatorze(kalkulator gnome ma tą konwersje))

g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23 "$gen" 

g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23 "$wzor" 

g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23  "$brut" 

echo "skrypt się uruchomił"

#nieskończona pętla by przerwać wykonywanie naciśnij ctrl + c 
i=1
while true
do
    ./${gen%.*} > test
    plik_statystyk=$(mktemp)
    /usr/bin/time -f "%e %M" -o "$plik_statystyk" ./${wzor%.*} < test > x
    read -r czas_wykonania max_ram_kb < "$plik_statystyk"
    max_ram_mb=$(awk "BEGIN {print $max_ram_kb / 1024}")
    ./${brut%.*} < test > y
    if ! diff -b x y > /dev/null
    then
        echo "test $i zle"
        more test
        echo "brut"
        more y
        break
    fi

    przekroczono_czas=$(awk "BEGIN {print ($czas_wykonania > $limit_czasu) ? 1 : 0}")
    if [ "$przekroczono_czas" -eq 1 ]; then
        echo "  └─ [TLE] Przekroczono limit czasu (($czas_wykonania)s)! w $nazwa_bez_rozszerzenia"
        echo "test $i zle"
        more test
        echo "brut"
        more y
        break
    fi

    if [ "$max_ram_kb" -gt "$limit_ram" ]; then
        echo "  └─ [MLE] Przekroczono limit pamięci ($((max_ram / 1048)) MB)! w $nazwa_bez_rozszerzenia"
        echo "test $i zle"
        more test
        echo "brut"
        more y
        break
    fi
    ((i++))
done
