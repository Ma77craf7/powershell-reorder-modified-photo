param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'Container'})]
    [string]$source_directory,
    
    [Parameter(Mandatory=$true)]
    [string]$destination_directory
)

# Select only files with extension ".xmp" in source_directory
$filesXMP = Get-ChildItem $source_directory | Where-Object {$_.Extension -eq ".xmp"}

# work on .xmp files
foreach ($fileXMP in $filesXMP) {
    $base_file_name = $fileXMP.BaseName
    
    # Select all files with the same name as the .xmp file
    $files_to_move = Get-ChildItem $source_directory | Where-Object {$_.BaseName -eq $base_file_name}
    
    # move all file with the same name in the destination_directory
    foreach ($file in $files_to_move) {
        Move-Item $file.FullName $destination_directory
    }
}
