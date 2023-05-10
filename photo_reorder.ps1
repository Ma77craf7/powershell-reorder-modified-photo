param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'Container'})]
    [string]$cartellaOrigine,
    
    [Parameter(Mandatory=$true)]
    [string]$cartellaDestinazione
)

# Seleziona solo i file con estensione ".xmp" nella cartella di origine
$filesXMP = Get-ChildItem $cartellaOrigine | Where-Object {$_.Extension -eq ".xmp"}

# Itera sui file .xmp trovati
foreach ($fileXMP in $filesXMP) {
    $nomeFileBase = $fileXMP.BaseName
    
    # Seleziona tutti i file con lo stesso nome di base del file .xmp nella cartella di origine
    $filesDaSpostare = Get-ChildItem $cartellaOrigine | Where-Object {$_.BaseName -eq $nomeFileBase}
    
    # Sposta tutti i file con lo stesso nome nella cartella di destinazione
    foreach ($file in $filesDaSpostare) {
        Move-Item $file.FullName $cartellaDestinazione
    }
}