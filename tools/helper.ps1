function Start-Ahk($ahkScript){
	$ahkFile = Join-Path $toolsDir $ahkScript
	$ahkEXE = Get-ChildItem "$env:ChocolateyInstall\lib\autohotkey.portable" -Recurse -filter autohotkey.exe
	$ahkProc = Start-Process -FilePath $ahkEXE.FullName -ArgumentList "$ahkFile" -PassThru
	Write-Debug "AutoHotKey start time:`t$($ahkProc.StartTime.ToShortTimeString())"
	Write-Debug "Process ID:`t$($ahkProc.Id)"

	return $ahkProc
}
