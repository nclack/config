# Powershell Prompt

Put these in <My Documents>/WindowsPowerShell

## Features

* Git status line on prompt
* Powershell functions for switching between visual studio environments.
  * status line on prompt
  * convenience functions
    * withvs11
    * withvs12

## Requires

* [posh-git](https://github.com/dahlbyk/posh-git)

## Setup

1. new-item -type file -force $profile
2. Copy files over and clone [posh-git].
3. Set-ExecutionPolicy Unrestricted
