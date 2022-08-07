#Capturando a datas
$data = Get-Date -Uformat "%Y_%m_%d_%H_%m"
#Removendo arquivos antigos
Move-Item -Path C:\temp\logFiles.txt -Destination C:\Knowbe4\temp\logFiles_$data.txt -PassThru
Move-Item -Path C:\temp\logAutomation.txt -Destination C:\v\backup\logAutomation_$data.txt -PassThru
Move-Item -Path C:\temp\report.csv -Destination C:\v\backup\logFiles_$data.txt -PassThru
Move-Item -Path C:\temp\licences.csv -Destination C:\temp\backup\logFiles_$data.txt -PassThru
#Removendo os arquivos
#Remove-Item C:\temp\logAutomation.txt
#Executando o getFiles.ps1
C:\temp\getFiles.ps1 > C:\temp\logFiles.txt
#Executando o Automation.ps1
C:\temp\automation.ps1 > C:\temp\logAutomation.txt
Write-Output "The End"