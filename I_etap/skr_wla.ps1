$gen = "./gen.cpp"
$wzor = "./wzor.cpp"
$brut = "./brut.cpp"
$limit_czasu = 1.5      # limit czasu w sekundach
$limit_ram_kb = 256     # limit RAMu w kilobajtach (Uwaga: jeśli w zadaniu masz np. 256 MB, wpisz tutaj 262144)

# Ścieżki do plików wykonywalnych
$gen_exe = [System.IO.Path]::ChangeExtension($gen, ".exe")
$wzor_exe = [System.IO.Path]::ChangeExtension($wzor, ".exe")
$brut_exe = [System.IO.Path]::ChangeExtension($brut, ".exe")

# Kompilacja programów
& g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23 $gen -o $gen_exe

& g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23 $wzor -o $wzor_exe

& g++ -O2 -Wall -Wextra -fsanitize=address -std=c++23 $brut -o $brut_exe

Write-Host "skrypt się uruchomił" -ForegroundColor Green

# Funkcja pomocnicza do porównywania plików z pominięciem białych znaków (odpowiednik diff -b)
function Compare-FilesIgnoreWhitespace($file1, $file2) {
    $lines1 = Get-Content -Path $file1 -ErrorAction SilentlyContinue | ForEach-Object { $_.Trim() -replace '\s+', ' ' }
    $lines2 = Get-Content -Path $file2 -ErrorAction SilentlyContinue | ForEach-Object { $_.Trim() -replace '\s+', ' ' }
    
    if ($lines1.Count -ne $lines2.Count) { return $false }
    for ($k = 0; $k -lt $lines1.Count; $k++) {
        if ($lines1[$k] -ne $lines2[$k]) { return $false }
    }
    return $true
}

# Funkcja do uruchamiania procesu z pomiarem czasu i pamięci
function Run-Progra($exePath, $inputPath, $outputPath) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = (Resolve-Path $exePath).Path
    $psi.RedirectStandardInput = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.UseShellExecute = $false

    $proc = [System.Diagnostics.Process]::Start($psi)
    
    # Przekazanie zawartości wejściowej
    $inputContent = Get-Content -Path $inputPath -Raw
    $proc.StandardInput.Write($inputContent)
    $proc.StandardInput.Close()

    # Odczytanie wyjścia
    $outputContent = $proc.StandardOutput.ReadToEnd()
    Set-Content -Path $outputPath -Value $outputContent -NoNewline
    
    $proc.WaitForExit()
    $sw.Stop()

    return [PSCustomObject]@{
        TimeSeconds   = $sw.Elapsed.TotalSeconds
        PeakMemoryKb  = [math]::Round($proc.PeakWorkingSet64 / 1024)
    }
}

# Nazwy plików tymczasowych dla testów
$testFile = "test.txt"
$xFile = "x.txt"
$yFile = "y.txt"

$i = 1
while ($true) {
    # Generowanie nowego testu
    & (Resolve-Path $gen_exe).Path > $testFile

    # Uruchomienie programu wzorcowego z pomiarem czasu i pamięci
    $wzorResult = Run-Progra $wzor_exe $testFile $xFile

    # Uruchomienie rozwiązania powolnego (brut)
    Run-Progra $brut_exe $testFile $yFile | Out-Null

    # Porównanie wyników (z pominięciem białych znaków - diff -b)
    $areEqual = Compare-FilesIgnoreWhitespace $xFile $yFile
    if (-not $areEqual) {
        Write-Host "test $i zle (Niezgodność wyników)" -ForegroundColor Red
        Write-Host "=== TEST ===" -ForegroundColor Yellow
        Get-Content $testFile
        Write-Host "=== BRUT (Wynik) ===" -ForegroundColor Yellow
        Get-Content $yFile
        break
    }

    # Sprawdzenie limitu czasu (TLE)
    if ($wzorResult.TimeSeconds -gt $limit_czasu) {
        $czas_zaokraglony = [math]::Round($wzorResult.TimeSeconds, 3)
        Write-Host "  └─ [TLE] Przekroczono limit czasu (${czas_zaokraglony}s)! w teście $i" -ForegroundColor Red
        Write-Host "test $i zle" -ForegroundColor Red
        Write-Host "=== TEST ===" -ForegroundColor Yellow
        Get-Content $testFile
        Write-Host "=== BRUT (Wynik) ===" -ForegroundColor Yellow
        Get-Content $yFile
        break
    }

    # Sprawdzenie limitu pamięci (MLE)
    if ($wzorResult.PeakMemoryKb -gt $limit_ram_kb) {
        $max_ram_mb = [math]::Round($wzorResult.PeakMemoryKb / 1024, 2)
        Write-Host "  └─ [MLE] Przekroczono limit pamięci ($max_ram_mb MB / $($wzorResult.PeakMemoryKb) KB)! w teście $i" -ForegroundColor Red
        Write-Host "test $i zle" -ForegroundColor Red
        Write-Host "=== TEST ===" -ForegroundColor Yellow
        Get-Content $testFile
        Write-Host "=== BRUT (Wynik) ===" -ForegroundColor Yellow
        Get-Content $yFile
        break
    }

    Write-Host "Test $i OK (Czas: $([math]::Round($wzorResult.TimeSeconds, 3))s, RAM: $($wzorResult.PeakMemoryKb) KB)" -ForegroundColor DarkGray
    $i++
}

# Sprzątanie plików tymczasowych przy wyjściu
Remove-Item $testFile, $xFile, $yFile -ErrorAction SilentlyContinue