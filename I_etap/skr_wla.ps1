# pamietaj by dac Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
# Konfiguracja 
$gen = "gen.cpp"
$wzor = "wzor.cpp"
$brut = "brut.cpp"

$genName = [System.IO.Path]::GetFileNameWithoutExtension($gen)
$wzorName = [System.IO.Path]::GetFileNameWithoutExtension($wzor)
$brutName = [System.IO.Path]::GetFileNameWithoutExtension($brut)

$genPath = Join-Path $PSScriptRoot "$genName.exe"
$wzorPath = Join-Path $PSScriptRoot "$wzorName.exe"
$brutPath = Join-Path $PSScriptRoot "$brutName.exe"

Write-Host "Kompilowanie programow..." -ForegroundColor Cyan

# Kompilacja z przechwytywaniem błędów
g++ -O2 -Wall -Wextra -std=c++23 (Join-Path $PSScriptRoot $gen) -o $genPath
g++ -O2 -Wall -Wextra -std=c++23 (Join-Path $PSScriptRoot $wzor) -o $wzorPath
g++ -O2 -Wall -Wextra -std=c++23 (Join-Path $PSScriptRoot $brut) -o $brutPath

if (-not (Test-Path $genPath) -or -not (Test-Path $wzorPath) -or -not (Test-Path $brutPath)) {
    Write-Host "BLAD kompilacja nie powiodla sie! Sprawdz bledy kompilatora powyzej." -ForegroundColor Red
    exit
}

Write-Host "Skrypt sie uruchomil. Nacisnij Ctrl + C, aby przerwac." -ForegroundColor Green

$i = 1
while ($true) {
    # Generowanie testu
    & $genPath > test.txt

    Get-Content test.txt | & $wzorPath > x.txt
    Get-Content test.txt | & $brutPath > y.txt

    $diff = Compare-Object (Get-Content x.txt) (Get-Content y.txt)

    if ($diff) {
        Write-Host "Test $i zle!" -ForegroundColor Red
        Write-Host "--- ZAWARTOSC TESTU ---" -ForegroundColor Yellow
        Get-Content test.txt
        Write-Host "--- WYNIK WZORCA ---" -ForegroundColor Yellow
        Get-Content x.txt
        Write-Host "--- WYNIK BRUTA ---" -ForegroundColor Yellow
        Get-Content y.txt
        break
    }

    Write-Host "Test $i OK" -ForegroundColor DarkGray
    $i++
}
