$scriptRoot = Split-Path (Resolve-Path $myInvocation.MyCommand.Path)

# Load posh-git example profile
. (join-path $scriptRoot '/posh-git/profile.example.ps1')

# Visual Studio VsVars include (run vsvars32
. (join-path $scriptRoot "/vsvars.ps1")
set-content Function:\withvs11 "vsvars32 11"
set-content Function:\withvs12 "vsvars32 12"


# write our own prompt function
function prompt { 
   # our theme 
   $cdelim = [ConsoleColor]::DarkCyan 
   $chost = [ConsoleColor]::Green 
   $cloc = [ConsoleColor]::Cyan 

   write-host "$([char]0x0A7) " -n -f $cloc 
   write-host ([net.dns]::GetHostName()) -n -f $chost 
   write-vcsstatus

   write-host ' [' -n -f $cdelim 
   write-host "VS"$env:visualstudioversion -n -f $cloc 
   write-host ']' -n -f $cdelim 

   write-host ' {' -n -f $cdelim 
   write-host (shorten-path (pwd).Path) -n -f $cloc 
   write-host '}' -n -f $cdelim 

   return ' ' 
}

function shorten-path([string] $path) { 
   $loc = $path.Replace($HOME, '~') 
   # remove prefix for UNC paths 
   $loc = $loc -replace '^[^:]+::', '' 
   # make path shorter like tabs in Vim, 
   # handle paths starting with \\ and . correctly 
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2') 
}



