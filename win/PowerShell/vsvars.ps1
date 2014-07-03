function Get-Batchfile ($file) {
    $cmd = "`"$file`" & set"
    cmd /c "$cmd" | Foreach-Object {
        $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}
  
function VsVars32([int]$version = 10)
{
    $versionkey = $version.ToString("00.0")

    $batfilename = "vcvarsall.bat" 

    $key = "HKCU:SOFTWARE\Microsoft\VisualStudio\" + $versionkey + "_Config"

    write-host $key

    $VsKey = get-ItemProperty $key
    $VsInstallPath = [System.IO.Path]::GetDirectoryName($VsKey.ShellFolder)
    write-host $VsInstallPath
    $VsToolsDir = [System.IO.Path]::Combine($VsInstallPath, "VC")
    $BatchPath = join-path $VsToolsDir $batfilename
    
    write-host $BatchPath

    Get-Batchfile( $BatchPath )

    write-host "All done"

    [System.Console]::Title = "PS MSVS" + $versionkey
}