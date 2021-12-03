Hyperion.Hyper-V.connect(){
	Enable-PSRemoting
	Set-Item WSMan:\localhost\Client\TrustedHosts -Value "homeserver"
	Enable-WSManCredSSP -Role client -DelegateComputer "homeserver"

# https://tweaks.com/windows/67216/remotely-manage-a-nondomain-hyperv-server-from-windows-10/
}

getNetwork(){
Get-NetConnectionProfile

#https://4sysops.com/archives/enabling-powershell-remoting-fails-due-to-public-network-connection-type/
}

fixNetwork(){
	Set-NetConnectionProfile -Name "$networkName" -NetworkCategory Private

	try(){
	$networkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}")) 
	$connections = $networkListManager.GetNetworkConnections() 

	# Set network location to Private for all networks 
	$connections | % {$_.GetNetwork().SetCategory(1)}
	}

#https://www.google.com/search?q=windows+10+Change+network+location
#- https://docs.microsoft.com/en-us/answers/questions/73866/how-to-change-network-settings-from-public-to-priv.html

#https://www.google.com/search?q=Enable-PSRemoting+public+private
#-http://www.hurryupandwait.io/blog/fixing-winrm-firewall-exception-rule-not-working-when-internet-connection-type-is-set-to-public
}