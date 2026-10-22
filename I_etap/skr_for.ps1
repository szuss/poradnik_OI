#podziekowania dla Krzysia za przygotowanie skryptu
# Konfiguracja ścieżek i rozszerzeń
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process 
# wpisz powyższą linię w terminal powershella (bez #)
$folder_wejscia = ".\fol1" # folder z plikami wejściowymi szt\testy\dziesiec\in
$folder_wyjscia = ".\fol2" # folder z plikami wyjściowymi
$plik_zrodlowy = ".\zad.cpp" # plik źródłowy C++
$rozwiazanie = ".\zad.exe" # plik wykonywalny po kompilacji
$limit_czasu = 10.0     # limit czasu w sekundach (np. 1 sekunda)
 
$rozszerzenie_wejscia = "in"
$rozszerzenie_wyjscia = "out"
 
 
# Kompilacja za pomocą g++ (wymaga zainstalowanego MinGW/GCC w systemie)
g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23 $plik_zrodlowy -o $rozwiazanie
 
# Sprawdzenie, czy kompilacja się powiodła
if ($LASTEXITCODE -ne 0) {
    Write-Host "Błąd: Kompilacja programu C++ nie powiodła się." -ForegroundColor Red
    exit 1
}

$i = 0
$j = 0
$ile = 1
$suma = 0
$srednia = 0
# Pętla po plikach w pierwszym folderze z danym rozszerzeniem
Get-ChildItem -Path $folder_wejscia -Filter "*.$rozszerzenie_wejscia" | ForEach-Object {
    $baseName = $_.BaseName
    $outFile = Join-Path $folder_wyjscia "$baseName.$rozszerzenie_wyjscia"
 
    # Sprawdzenie czy odpowiadający plik wzorcowy istnieje w drugim folderze
    if (Test-Path $outFile) {
        # Utworzenie pliku tymczasowego na wynik programu
        $tempOut = [System.IO.Path]::GetTempFileName()
 
        # Uruchomienie programu C++ z przekazaniem zawartości pliku wejściowego
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        Get-Content $_.FullName | & $rozwiazanie | Set-Content $tempOut
        $stopwatch.Stop()
 
        # Porównanie wyjścia programu z plikiem wzorcowym
        $first = (Get-Content $tempOut)
        $second = (Get-Content $outFile)
        $diff = Compare-Object ($first) ($second)
 
        # Usunięcie pliku tymczasowego
        Remove-Item $tempOut

        # Obliczenie czasu w sekundach (z ułamkiem dziesiętnym)
        $czas = $stopwatch.Elapsed.TotalSeconds
        $suma = $suma + $czas
    
        # Jeśli są różnice, wypisz nazwę pliku
        if ($diff) 
        {
            Write-Host "Różnica w pliku: $baseName, [$first] zamiast [$second]" -ForegroundColor Yellow
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