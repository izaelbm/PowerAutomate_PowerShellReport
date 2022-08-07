cls
Write-Output "######################################################"
Write-Output "Atribuição de Licenças Exchange/Teams O365 PowerShell"
Write-Output "Autor: Izael Magalhaes - 07/08/2022"
Write-Output "######################################################"
Write-Output " "
Write-Output "-> Iniciando Script"
Write-Output " "
#
$origem = "\\host\c$\temp\"
#Copiando os arquivos
Write-Output "-> Baixando Arquivos"
Write-Output " "
Copy-Item $origem'report.csv' 'C:\temp\report.csv'
$r1 = Test-Path C:\temp\report.csv
if($r1 -eq "true"){    
    Write-Output "[OK] report.csv"
}else{
    Write-Output "[NOK] report.csv"
}
Copy-Item $origem'licences.csv' 'C:\temp\licences.csv'
$r2 = Test-Path C:\temp\licences.csv
if($r2 -eq "true"){    
    Write-Output "[OK] licences.csv"
}else{
    Write-Output "[NOK] licences.csv"
}
#
Write-Output " "
Write-Output "-> Verificando a Integridade dos Arquivos"
Write-Output " "
#
$resp1 = Test-Path C:\temp\report.csv
$resp2 = Test-Path C:\temp\licences.csv
#verificando o Report.csv
if($resp1 -eq "true"){
    Write-Output "[OK] report.csv"
}else{
    Write-Output "[NOK] report.csv"
}
#verificando o Licences.csv
if($resp2 -eq "true"){
    Write-Output "[OK] licences.csv"
}else{
    Write-Output "[NOK] licences.csv"
}
Write-Output " "
Write-Output "The End"