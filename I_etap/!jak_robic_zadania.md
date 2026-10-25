Poradnik do pierwszego etapu OI, zarówno części zdalnej jak i szkolnej. 
Pliki ze skryptami i przykładowym programem generującym liczby są dostępne jako osobne pliki. **Proszę, jeżeli uruchomicie mój skrypt to napiszcie mi, że zadziałało lub nie podając, który skrypt uruchomiliście**

# Najważniejsza rzecz w robieniu zadań to ich robienie.

Może się zdawać, że jest dużo czasu i jak nie będę robił dziś zadań to się nic nie stanie. I rzeczywiście jeżeli to będzie jeden dzień czy dwa to nic się nie stanie ale **radzę nie zwlekać z robieniem zadań na ostatni tydzień czy dwa** gdyż można łatwo się nie wyrobić lub mieć dużo dni z rzędu małą liczbę snu i dodatkowo pracować mniej efektywnie bo myśląc długo, wiele godzin pod rząd, spada skupienie. Za to gdy myślimy od początku pierwszego etapu to możemy myśleć nad zadaniem na chemii czy innej nudnej lekcji, często jest też tak, że jak spojrzysz na kod następnego dnia to od razu widzisz błąd którego wczoraj szukałeś przez pół godziny. Sam zwlekałem z robieniem zadań na OIJ (OI juniorów) co odbiło się stratą punktów przypuszczam, że równą około 75.

# Szczegóły techniczne przydatne potem

* Infoslajd. Na olimpiadzie za każde zadanie można zdobyć tyle samo punktów czyli 100. Jest to jednak maksymalna liczba punktów i można uzyskać jakąś część tych punktów robiąc podzadania. Podzadania na siebie nie nachodzą to znaczy, że jeżeli mamy podzadanie, że $`n \le 100`$ daje 15 pkt oraz podzadanie $`n \le 1'000`$ daje 20 pkt to znaczy że kod działający dla $`n \le 1'000`$ dostaje 35 pkt, innymi słowy punkty za podzadania sumują się do 100. Każde zadanie ma tabelkę informującą o podzadaniach i ile punktów jest za nie. Część z nich to machinalne $`n \le 1'000`$ czy tam 10'000. Część z nich natomiast modyfikuje sam problem np. liczby to tylko zera i jedynki lub jakiś typ zapytań nie występuje.
* optymalne rozwiązanie to takie które na jedną sekundę dostępnego czasu wykona co najwyżej 1e8 (100'000'000) operacji, jest to wartość orientacyjna i może to się różnić przed końcem zawodów ~~skonsultuj się z lekarzem lub farmaceutą~~ przetestuj swoje rozwiązanie, o tym jak testować będzie później. Limity czasowe będą dostępne w sekcji *pliki i testy* na SIO2. Należy pamiętać że od połowy limitu czasu punkty spadają liniowo, a więc "prawdziwy" limit jest o połowe mniejszy, więcej [tutaj](https://oi.edu.pl/l/82/).
* limit pamięci w zadaniach jest podany w mebibajtach.

# A jak robić zadania?

1. Przeczytaj 2-3 razy treść zadania by nie myśleć dwie godziny nad innym problemem niż jest w zadaniu.

2. Zrób tak z treścią każdego zadania na początku konkursu by twój mózg gdzieś tam z tyłu głowy myślał o tym zadaniu i żebyś mógł zadać pytanie do treści jeżeli coś jest nie jasne (nie wstydźcie się zadawać pytań bo to autor powinien się wstydzić, że treść jego zadania jest na tyle nieścisła, że można mieć do niej wątpliwości, a jeżeli myślicie, że może być głupie to najwyżej dostaniecie odpowiedź *brak odpowiedzi* albo *pomidor*).

3. Na początek najlepiej wymyślić jakiekolwiek rozwiązanie nie patrząc na złożoność (byle była lepsza niż O($`2^n`$) lub O(n!)), złożoność tę często sugeruje tabela z podzadaniami o której jest niżej. 
- W dziewięćdziesięciu pięciu procentach zadań jest tak, że rozwiązanie wzorcowe (na 100 pkt) bazuje na wolniejszym rozwiązaniu o złożoności O($`n^2`$) lub O($`n^3`$). Dlatego jak mamy te wolne rozwiązanie to należy się zastanowić co możemy ulepszyć w naszym rozwiązaniu. Zazwyczaj jest tak że dla każdego elementu ciągu sprawdzamy czy jest wynikiem zadania lub dla każdego wyniku sprawdzamy czy jest on dobry, wtedy naszym zadaniem jest zastanowić się jak ograniczyć liczbę elementów dla których to robimy np. jeżeli poprawność wyniku jest monotoniczna czyli dla przedziału $`[0, k]`$ wynik jest poprawny a dla $`(k, największy możliwy wynik]`$ niepoprawny lub na odwrót to możemy się bin searchować po wyniku (technika ta nazywa się bin search po wyniku). Możemy też znaleźć szybszy sposób na sprawdzanie poprawności wyniku np. mamy znaleźć najdłuższy przedział który coś tam to często można skorzystać z tego że przedziały na siebie na chodzą więc nie trzeba przechodzić po całym aktualnie sprawdzanym przedziale i liczyć liczby elementów które są dobre tylko wystarczy skorzystać z wyniku poprzedniego przedziału. Dobrze jest też się zastanowić co nas interesuje by stwierdzić czy potencjalny wynik jest poprawny np. możemy zastanowić się czy interesuje nas dokładna wartość elementu czy tylko czy jest $`\ge k`$, jeżeli to drugie to może nasunie się nam jakaś optymalizacja
- Jeżeli masz problem z efektywnym robieniem czegoś np. wyszukiwaniem najdłuższego wspólnego podciągu, albo najdłuższego przedziału u sumie $`\le k`$ to możesz poszukać algorytmu który to robi na [cp algo](https://cp-algorithms.com/index.html) albo wyszukać w google'u.
- A co jeżeli nie potrafię zrobić któreś z powyższych rzeczy. Wtedy warto zajrzeć do tabelki z podzadaniami. Przykładowa tabela (z zadania przeglądarka internetowa z poprzedniego pierwszego etapu):

    | Podzadanie | Ograniczenia | Punkty |
    | :--- | :---: | ---: |
    | 1 | $`n \le 8`$ oraz $`s_i \le 10`$ dla $`i \in [1..n]`$ | 17 |
    | 2 | wszystkie $`s_i`$ mają tę samą długość | 12 |
    | 3 | $`S \le 1 000`$ | 32 |
    | 4 | $`s_i`$ składają się tylko z liter a oraz b | 18 |
    | 5 | brak dodatkowych ograniczeń | 21 |

    Robiąc podzadania być może wymyślimy algorytm, który wystarczy delikatnie (a może i w ogóle) zmodyfikować by otrzymać rozwiązanie wzorcowe. W zeszłym roku na części szkolnej pierwszego etapu było zadanie z podzadaniem, takim że rozwiązanie tego podzadania było rozwiązaniem wzorcowym i chyba większość osób, która zrobiła te zadanie, zrobiła je robiąc to podzadanie. Dlatego właśnie nie należy pomijać podzadań, skupiając się na wymyśleniu wzorcówki.

- Najlepiej zająć się podzadaniami w takiej kolejności jaką czujesz, że jest najłatwiejsza. **Pamiętaj!!! Możesz w jednym kodzie zrobić parę podzadań**, jednakże podzadania strukturalne nie mogą się wykluczać i kolejność if'ów ma znaczenie, najpierw dajesz podzadanie z rozwiązaniem wolnym potem  strukturalne.

- Przed napisaniem kodu zastanów się czy i dlaczego moje rozwiązanie jest poprawne jeżeli nadal jesteś nieprzekonany najlepiej przeprowadź dowód. Jeżeli jest to część zdalna lub masz zrobione wszystkie zadania na części szkolnej to i tak warto zrobić ten dowód w zadaniach z zamkniętym sprawdzaniem. O sposobach dowodzenia [tutaj](https://drive.google.com/drive/folders/1MkA2UHylb3dzTqt4t98e6hK5NDaVGStY?hl=PL). W prezentacji jest zasada ekstremum, której nie ma w skrypcie. Jest to o dowodach matematycznych ale ogólne zasady są te same, zachęcam też do chodzenia na koła informatyczne (lub fizyczne, matematyczne lub AI) na [MIKO](https://mikomath.org/).

- Co z tym 5% zadań w których rozwiązanie wzorcowe nie bazuje na rozwiązaniu podzadania? Na całe szczęście są to zadania sprzed 10 lat (albo absolutne triwy (obiektywnie triwy)) (chyba, że jeszcze po prostu na takie nie natrafiłem) więc wątpie, że takie zadanie sie pojawi bo mamy podzadania, których wtedy nie było. Jednak jeżeli się takie pojawi to myśląc o tym brucie pewnie wpadniesz na wzorcówke jeżeli zadanie jest na twoim poziomie.

5. Jeżeli utknąłeś na jednym zadaniu i nie masz postępu przejdź do kolejnego zadania.

## testowanie
W gruncie rzeczy jest to szósty punkt rozwiązywania zadań ale jest niedoceniany przez początkujących, a do tego nie taki prosty do zrealizowania, że zasługuje na oddzielenie go od reszty.
Nie zadowalaj się *wstępne sprawdzanie: OK* gdyż [tak](https://drive.google.com/file/d/11gb8ThHepxl_4c5Gka7SLJGQHrdHlppE/view?usp=sharing) to wygląda. Testy przykładowe czasami co najwyżej sprawdzają czy rozwiązanie jest wystarczająco szybkie ale na pewno nie sprawdzają poprawności. 
Wszystkie skrypty są w tym samym folderze co plik, który czytasz.
### Testowanie na testach z forum
testy z forum potrafią czasami być lepsze nawet od oficjalnych testów więc polecam je odpalać bo może jakiś błąd się wyłapie. Testy z forum są w 99% poprawne, a w tym jednym procencie ktoś zawsze wyłapuje błąd i następnego dnia są dobre testy.
- Na linux'ie i mac'u 
- co zrobić by działało
1. pobierz plik skr_for.sh (nazwe możesz oczywiście dowolnie zmieniać)
2. uzupełnij odpowiednio zmienne pierwszych linii 
3. zapisz go w tym samym folderze w którym masz rozwiązanie 
4. następnie nadaj skryptowi uprawnienia do wykonania (otwórz terminal, wejdź do folderu z plikiem i wpisz chmod +x skr_for.sh)
5. by uruchomić skrypt wejdź do folderu ze skryptem i wpisz ./skr_for.sh
6. skrypt kompiluje twoje rozwiązania
- jeżeli skrypt nie działa to 
1. uzupełnij zmienne 
2. usuń polskie znaki ze skryptu
3. spytaj się mnie 

- (tfu) windows 
- co zrobić by dopalić:
1. pobierz plik skr_for.ps1
2. uzupełnij zmienne na początku pliku
3. zapisz plik w tym samym folderze w którym jest rozwiązanie
4. uruchom PowerShell
5. wejdź do folderu ze skryptem wpisz najpierw cd, enter potem cd *ścieżka do pliku* 
6. uruchom możliwość odpalania skryptów wpisująć Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process (musisz to zrobić zawsze po otwarciu powershella) i zatwierdź to
7. uruchom skrypt .\nazwa_skryptu.ps1

- Co jeżeli nie działa:
1. upewnij się że wykonałeś wszystkie kroki z listy
2. usuń polskie znaki ze skryptu
3. napisz do mnie 

### testowanie na własnych testach
Do testowania na własnych testach oprócz wzorcówki potrzebujesz rozwiązania brutalnego np. w O($`n^2`$) chociaż O($`2^n`$) powinno wystarczyć i programu generującego wejście dla programów. Z wyjątkiem zadań z teorii liczb małe testy nawet dla $`n \le 20`$ powinny wykryć wszystkie błedy. Rozwiązanie wolne nie powinno korzystać z obserwacji (chyba, że innego nie ma), gdyż obserwacja ta może być błędna i wtedy testowanie jest bez sensu. O ile generowanie ciągów liczb czy znaków jest banalne to do generowania większości grafów potrzebujesz znać algorytm [DSU](https://www.youtube.com/watch?v=_cvplcXTUdE). Jeżeli poznasz ten algorytm to generowanie grafów nie powinno być większym problemem. Jednak jeżeli poznasz ten algorytm i dalej nie będziesz umiał to mogę ci to wytłumaczyć.

Pamiętaj, że generatorka powinna generować wejście dla którego brut działa wystarczająco szybko (czyli jak mamy kwadratowego bruta to n będzie zapewne do tysiąca).

#### co jest potrzebne do generowania liczb w cpp?
``` cpp
// na poczatku main'a umiesc
random_device rd;
mt19937 gen(rd());
// gdy zmienia sie zakres na [a, b] daj
uniform_int_distribution<int> distrib(a, b); // w nawiasie <> dajemy jaki typ liczb całkowitych ma to być np int lub long long (można to wykorzystać do generowania znaków wtedy dajem zakres [0, 27] i będziemy dodawać do 'a')
// wtedy by wygenerować piszemy
distrib(gen);
 // lub dla przedziału [a. b) (zmieniły się nawiasy w przedziale)
uniform_real_distribution<long double> dis(a, b); // w <> dajemy typ danych zmiennoprzecinkowych np dubble lub long dubble
// gdy chcemy mieć liczbe rzeczywista
// teraz by wygenerowac liczbe z ustawionego wczesniej zakresu dajemy
dis(gen);
```
Dłuższy przykład w pliku generowanie.cpp
#### sekcje co zrobić by działało i co zrobić gdy nie działa są takie same jak poprzednio
- linux i mac
pobierz plik skr_wla_lin.sh
by zakończyć generowanie nacićnij ctrl + c

- (a tfu) windows
pobierz plik skr_wla_win.ps1
naciśnij ctrl + c by zakończyć generowanie

#### testowanie wydajności czasowej
skrypty testują też czas wykonywania programu i zużycie RAMu. Należy pamiętać, że olimpiada nie liczy czasu a liczbę operacji assemblera, więcej [tu](https://oi.edu.pl/l/srodowisko/).

# Przyspieszanie wypisywania i wczytywania

Przypuszczam, że znasz
## linijki przyspieszające
``` cpp
ios_base::sync_with_stdio(false);
cin.tie(nullptr);
```
Jest pewien typ zadań w których nie możesz pisać
``` cpp
cin.tie(nullptr);
```
są to zadania interaktywne, więc jak w zadaniu będzie napisane, że takie jest to daj tylko pierwszą linijkę przyspieszającą. Chociaż czasami nie możesz też korzystać z pierwszej linijki dlatego najlepiej wysłać wersje z pierwszą i bez pierwszej linijki.

Jeżeli mamy milion liczb na wejściu to wtedy możemy skorzystać z
## getchar_unlocked()
Przy takim wejściu daje to oszczędność czasu rzędu 0.4 sekundy a to dużo, niekiedy może to sprawić wzrost liczny punktów o 50.

**nie wolno mieszać cin oraz getchar_unlocked()**

### wczytywanie liczb przy uzyciu getchar_unlocked()

```cpp
// jeżeli chemy long long'a czyli liczby >= 2'000'000'000 to oczywiście dajemy long long &a
inline void wczy(int &a) {
    a = 0;
    char c = getchar_unlocked();
    bool ujemne = false;
    while (c <= ' ' && c != '-') { // jeżeli mamy liczby nieujemną to pomijamy drugi warunek i
        c = getchar_unlocked();
    }
    if (c == '-') {  // tego if'a
        ujemne = true;
        c = getchar_unlocked();
    } 
    while ( c > '9' && c < '0' ) {
        a = a * 10 + c - '0';
        c = getchar_unlocked();
    }
    return ujemne ? -a : a; // jezeli ujemna to zwroc -a, w przeciwnym wypadku zwróć a
}

// wtedy by wczytać zmienną k dajemy
wczy(k);
```
### wczytywanie string'a 
``` cpp
    for (int i = 0; i < b.size(); i++)
        b[i] = getchar_unlocked();
```

# inne rady programistyczne
- Jak tworzycie tablice to zamiast wpisywać wszędzie maksmalne n to możecie utworzyć zmienną typu constexpr (stała znana w czasie kompilacji(może być zwykłe const)). 
- Co więcej jak macie jakąś dużą liczbę na wejściu to możecie ją zapisać w notacji naukowej czyli AeB co znaczy $A * 10^B$ czyli 200'000 to 2e5.
- Poniższe rady połączone dla maxN = 300'000
``` cpp
constexpr int maxN = 3e5 + 10 // + 10 na wrazie czego
int t[maxN];
vector<int> g[maxN]
```
- Czasami jest tak, że musicie posortować coś patrząc na różne dane np. wzrost, wiek i karnacje do tego służy struct jest to mega przydatna rzecz jak to robić i poniższy punkt [tutaj](https://www.youtube.com/watch?v=b48rnKm2Hu8&list=PL9BlBU4U-rDNfkni9dsMO5n2XMSrMlXRT&index=30&t=600s).
- Jak macie sort() to możecie sortować w dowolnej kolejności wystarczy napisać odpowiednią dwu linijkową funkcję.
