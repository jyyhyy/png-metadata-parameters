@echo off
echo.

echo>NUL|clip

:do
powershell -Command "$a=\"%~1\";Write-Host $a -ForeGroundColor Yellow;Function Get-Bytes($f,$n){if($PSVersionTable.PSVersion.Major -lt 7){return Get-Content $f -Encoding Byte -TotalCount $n;}else{	return Get-Content $f -AsByteStream -TotalCount $n;}}$b=@(0x74,0x45,0x58,0x74,0x70,0x61,0x72,0x61,0x6D,0x65,0x74,0x65,0x72,0x73,0x00);$c=52;$d=@();$d=Get-Bytes $a $c;$k=-1;$e=$c-$b.Length+1;:outer for($i=0;$i -lt $e;++$i){if($d[$i] -ne $b[0]){continue}for($j=1;$j -lt $b.Length;++$j){if($d[$i+$j] -ne $b[$j]){	$k=-1;continue outer;}}$k=$i;break;}Write-Host Offset: $k;if($k -ge 0){$l=[BitConverter]::ToUInt32($d[($k-1)..($k-4)],0);$c=$k+$l+8;$d=Get-Bytes $a $c;$s=[Text.Encoding]::ASCII.GetString($d[($k+$b.Length)..($k+$l+3)]);$h=[BitConverter]::ToUInt32($d[($k+$l+7)..($k+$l+4)],0);Write-Host Length: $l;Set-Clipboard -Append \"$a`n$s`n\";if($s -match '((.|\n)*\n)(Negative prompt: (.|\n)*\n)(Steps: (.|\n)*)'){Write-Host $Matches[1].Trim() -ForegroundColor Green;Write-Host $Matches[3].Trim() -ForegroundColor Red;Write-Host $Matches[5] -ForeGround Cyan;}}"

echo.
shift
if "%~1"=="" goto end
goto do

:end
pause
