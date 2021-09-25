function Recursive {
    param (
        [Parameter(Mandatory=$true)]
        [System.IO.DirectoryInfo]
        $directory,
        [Parameter(Mandatory=$true)]
        [System.String]
        $filter,
        [Parameter(Mandatory=$true)]
        [System.String]
        $function_name

    )
    $child_files=Get-ChildItem -File -Filter $filter -Path $directory.FullName
    $child_dirs=Get-ChildItem -Directory -Path $directory.FullName
    foreach($file in $child_files ){
        & $function_name -file $file
    }
    foreach($new_dir in $child_dirs){
        Write-Output $new_dir
        Recursive -directory $new_dir
    }
    
}
function Operation {
    param (
        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]
        $file
    )
    Write-Output ("File "+$file.FullName )
    
    
}

Recursive -directory (Get-Item .) -function_name "Operation" -filter "*.ps1"
