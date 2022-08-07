cls
Write-Output "######################################################"
Write-Output "Atribuição de Licenças Exchange/Teams O365 PowerShell"
Write-Output "Autor: Izael Magalhaes - 07/08/2022"
Write-Output "######################################################"
Write-Output ""
#Credenciais
$username = 'email@ticorp.onmicrosoft.com'
$pwd = ConvertTo-SecureString 'realpassword' -asplaintext -force;
$cred = New-Object -TypeName PSCredential -argumentlist $username, $pwd
#
#
Write-Output "-> Iniciando Configurações"
Write-Output " "
Write-Output "-> Conectando ao MsolService"
Write-Output " "
#Conectar ao MsolService
try{
    Connect-MsolService -Credential $cred
    Write-Output "[OK] MsolService Conectou"
}
catch{
    Write-Output "[Erro] MsolService Nao Conectou"
}
#----x--------
Write-Output " "
Write-Output "-> Conectando ao Azuread"
Write-Output " "
#Conectar ao Azuread
try{
    Connect-azuread -Credential $cred
    Write-Output "[OK] Azuread Conectou"
}
catch{
    Write-Output "[NOK] Azuread Nao Conectou"
}
#----x--------
Write-Output " "
Write-Output "-> Conectando ao ExchangeOnline"
Write-Output " "
#Conectar ao ExchangeOnline
try{
    Connect-ExchangeOnline -Credential $cred
    Write-Output "[OK] ExchangeOnline Conectou"
}
catch{
    Write-Output "[NOK] ExchangeOnline Nao Conectou"
}
#----x--------
#
Write-Output " "
#Report 
$url_report = "C:\temp\report.csv"
$url_licences = "C:\temp\licences.csv"
#
Write-Output "Importanto Arquivos"
$file_report = Import-Csv $url_report
$file_licences = Import-Csv $url_licences
#
Write-Output $url_report
Write-Output $url_licences
Write-Output " "
Write-Output "-> Iniciando Processo de Validacao/Desbloqueio"
Write-Output " "
Write-Output "--------------------------"
#
$cont = 1
$passed = 0
$pending = 0
foreach($line_report in $file_report)
{
    # Caputurando o email e o status do treinamento
    $email_report = $($line_report.Email)
    $status_report = $($line_report.Status)
    
    Write-Output "Verificando o Usuario: $email_report [$cont]"    
    # Caputrando a licença do usuario O365
    foreach($line_licences in $file_licences)
    {
        #Capturando a licença
        $email_licence = $($line_licences.Email)

        #Validar se o usuario possui licença
        if ( $email_report -eq $email_licence )
        { 
            $licence = $($line_licences.Licença)
            Write-Output "Licenca: $licence"    

            if ($status_report -eq "passed")
            {
                $passed = $passed + 1 
                Write-Output "Treinamento Concluido"    
                #Verificando o Tipo da Licença O365
                Switch ($licence)
                {
                    "E1" {
                        $o365_licence = "STANDARDPACK"
                    }
                    "E2" {
                        $o365_licence = "STANDARDWOFFPACK"
                    }
                    "E3" {
                        $o365_licence = "ENTERPRISEPACK"
                    }
                    "Plan1" {
                        $o365_licence = "null"
                    }
                    "Kiosk" {
                        $o365_licence = "null"
                    }
                }

                #Desbloqueio Email O365
                 try{
                    #Set-CASMailbox $email_report -OWAEnabled $true -PopEnabled $true -SmtpClientAuthenticationDisabled $false -OutlookMobileEnabled $true;
                    Write-Output "[OK] Email"
                    }
                catch{
                        Write-Output "[NOK] Email"
                    }

                #Desbloqueio Teams
                if($o365_licence -ne "null"){
                    try{
                        #$LE = New-MsolLicenseOptions -AccountSkuId "reseller-account:"$o365_licence
                        #Set-MsolUserLicense -UserPrincipalName $email_report -LicenseOptions $LE
                        Write-Output "[OK] Teams"
                    }catch{
                        Write-Output "[NOK] Teams"
                    }
                    
                }else{
                    $pending = $pending + 1              
                }
            }else{
                Write-Output "Treinamento Pendente"
            }
    
        }else{
            
        }
    }
    Write-Output "-------------------"       
    $cont = $cont + 1    
}
Write-Output " "   
Write-Output "The End"   
Write-Output "Total Users: $cont"
Write-Output "Passed Users: $passed"   
Write-Output "Pending Users: $pending"   