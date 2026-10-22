folder_wejscia="./fol1"
folder_wyjscia="./fol2"
program="./program.cpp"
limit_czasu=1.5 # limit czasu w sekundach (limit z zadania podzielony na dwa (pamiętamy o liniowym spadku punktów od połowy czasu))
limit_ram=256 #limit ramu w kilobajtach (na OI limit jest podany w mebibajtach możesz to sobie przeliczać na kalkulatorze(kalkulator gnome ma tą konwersje))
rozszerzenie_wejscia="in"  # rozszerzenie plików wejściowych w pierwszym folderze
rozszerzenie_wyjscia="out"     # rozszerzenie pliku z odpowiedzia w drugim folderze

g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23 "$program"

echo "skrypt się uruchomił"

for plik1 in "$folder_wejscia"/*.$rozszerzenie_wejscia; do
    [ -e "$plik1" ] || continue

    if [ -f "$plik1" ]; then
        pelna_nazwa=$(basename -- "$plik1")
        nazwa_bez_rozszerzenia="${pelna_nazwa%.*}"
        
        plik2="$folder_wyjscia/$nazwa_bez_rozszerzenia.$rozszerzenie_wyjscia"
        
        if [ -f "$plik2" ]; then
            wynik_dzialania=$(mktemp)
            plik_statystyk=$(mktemp)
            /usr/bin/time -f "%e %M" -o "$plik_statystyk" "./${program%.*}" < "$plik1" > "$wynik_dzialania"
            read -r czas_wykonania max_ram_kb < "$plik_statystyk"
            max_ram_mb=$(awk "BEGIN {print $max_ram_kb / 1024}")

            if ! diff -b "$wynik_dzialania" "$plik2" > /dev/null; then
                echo "Różnica w pliku: $nazwa_bez_rozszerzenia"
                break
            fi

            przekroczono_czas=$(awk "BEGIN {print ($czas_wykonania > $limit_czasu) ? 1 : 0}")
            if [ "$przekroczono_czas" -eq 1 ]; then
                echo "  └─ [TLE] Przekroczono limit czasu (($czas_wykonania)s)! w $nazwa_bez_rozszerzenia"
            fi

            if [ "$max_ram_kb" -gt "$limit_ram" ]; then
                echo "  └─ [MLE] Przekroczono limit pamięci ($((max_ram / 1048)) MB)! w $nazwa_bez_rozszerzenia"
            fi
            rm -f "$wynik_dzialania"
        fi
    fi
done
