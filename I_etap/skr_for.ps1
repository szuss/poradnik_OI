#podziekowania dla Krzysia za przygotowanie skryptu
# Konfiguracja ścieżek i rozszerzeń
# pamietaj by dac Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process 
# wpisz powyzsza linie w terminal powershella (bez #)
$folder_wejscia = ".\fol1" # folder z plikami wejsciowymi
$folder_wyjscia = ".\fol2" # folder z plikami wyjsciowymi
$plik_zrodlowy = ".\zad.cpp" # plik zrodlowy C++
$rozwiazanie = ".\zad.exe" # plik wykonywalny po kompilacji
$limit_czasu = 10.0     # limit czasu w sekundach (np. 1 sekunda)
 
$rozszerzenie_wejscia = "in"
$rozszerzenie_wyjscia = "out"
 
 
# Kompilacja za pomoca g++ (wymaga zainstalowanego MinGW/GCC w systemie)
g++ -O2 -Wall -Wextra -std=c++23 $plik_zrodlowy -o $rozwiazanie
 
# Sprawdzenie, czy kompilacja sie powiodla
if ($LASTEXITCODE -ne 0) {
    Write-Host "Blad: Kompilacja programu C++ nie powiodla sie." -ForegroundColor Red
    exit 1
}

$i = 0
$j = 0
$ile = 1
$suma = 0
$srednia = 0
# Petla po plikach w pierwszym folderze z danym rozszerzeniem
Get-ChildItem -Path $folder_wejscia -Filter "*.$rozszerzenie_wejscia" | ForEach-Object {
    $baseName = $_.BaseName
    $outFile = Join-Path $folder_wyjscia "$baseName.$rozszerzenie_wyjscia"
 
    # Sprawdzenie czy odpowiadajacy plik wzorcowy istnieje w drugim folderze
    if (Test-Path $outFile) {
        # Utworzenie pliku tymczasowego na wynik programu
        $tempOut = [System.IO.Path]::GetTempFileName()
 
        # Uruchomienie programu C++ z przekazaniem zawartości pliku wejściowego
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        Get-Content $_.FullName | & $rozwiazanie | Set-Content $tempOut
        $stopwatch.Stop()
 
        # Porownanie wyjscia programu z plikiem wzorcowym
        $first = (Get-Content $tempOut)
        $second = (Get-Content $outFile)
        $diff = Compare-Object ($first) ($second)
 
        # Usuniecie pliku tymczasowego
        Remove-Item $tempOut

        # Obliczenie czasu w sekundach (z ulamkiem dziesietnym)
        $czas = $stopwatch.Elapsed.TotalSeconds
        $suma = $suma + $czas
    
        # Jesli są roznice, wypisz nazwe pliku
        if ($diff) 
        {
            Write-Host "Roznica w pliku: $baseName, [$first] zamiast [$second]" -ForegroundColor Yellow
            $j++
        } 
        else 
        {
            if ($czas -ge $limit_czasu) 
            {
                Write-Host "test $baseName | czas: ${czas} s" -ForegroundColor Yellow
                $i++
            }
        }
        
        $srednia = $suma / $ile
        Write-Host -NoNewline "test $baseName | czas: ${czas} s (srednio: ${srednia} )    `r" -ForegroundColor Green
        
        $ile++
    }
}

Write-Host "Bledne odpowiedzi: $j, przekroczenia czasu: $i"
