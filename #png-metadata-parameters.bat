@REM v0.3

@ECHO OFF
ECHO.

ECHO>NUL|clip

IF '%1'=='' GOTO end
SET _ARGS='%~1'

:loop
SHIFT
IF '%1'=='' GOTO do
SET _ARGS=%_ARGS%,'%~1'
GOTO loop

:do
powershell -Command "$c=52;$b=@(0x70,0x61,0x72,0x61,0x6D,0x65,0x74,0x65,0x72,0x73,0x00);$args=@(%_ARGS%);$q=0;$r=0;for($g=0;$g -lt $args.Length;++$g){$a=$args[$g];Write-Host $a -ForeGroundColor Yellow;Function Get-Bytes($f,$n){if($PSVersionTable.PSVersion.Major -lt 7){return Get-Content $f -Encoding Byte -TotalCount $n;}else{return Get-Content $f -AsByteStream -TotalCount $n;}}$d=@();$d=Get-Bytes $a $c;$k=-1;$e=$c-$b.Length+1;:outer for($i=0;$i -lt $e;++$i){if($d[$i] -ne $b[0]){continue}for($j=1;$j -lt $b.Length;++$j){if($d[$i+$j] -ne $b[$j]){$k=-1;continue outer;}}$k=$i-4;break;}if($k -ge 0){$t=[Text.Encoding]::ASCII.GetString($d[($k)..($k+3)]);$l=[BitConverter]::ToUInt32($d[($k-1)..($k-4)],0);Write-Host -NoNewLine \"Offset: $k Chunk type: $t Length: $l \";$c=$k+$l+8;$d=Get-Bytes $a $c;$s=[Text.Encoding]::UTF8.GetString($d[($k+$b.Length+4)..($k+$l+3)]).Trim(0);$h=[BitConverter]::ToUInt32($d[($k+$l+7)..($k+$l+4)],0);Write-Host CRC32: ('{0:X8}' -f $h);if($args.Length -eq 1){Set-Clipboard $s`n}else{Set-Clipboard -Append $a`n$s`n};if($s -match '((.|\n)*\n)(Negative prompt: (.|\n)*\n)(Steps: (.|\n)*)'){Write-Host $Matches[1].Trim() -ForegroundColor Green;Write-Host $Matches[3].Trim() -ForegroundColor Red;Write-Host $Matches[5] -ForeGround Cyan;}$q++;}else{$r++;Write-Host parameter cannot be found in $c bytes of file}Write-Host;if($args.Length -gt 1){Write-Host -NoNewLine ($args.Length) / $q / $r`n}}"

:end
PAUSE
