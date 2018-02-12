import-module SharePointPnPPowerShellOnline

$cred = Get-Credential

Connect-PnPOnline https://spgurus.sharepoint.com/teams/2013test/TemplateSubSite -Credentials $cred

Apply-PnPProvisioningTemplate -Path C:\Development\Sandbox\DL\PnP\scripts\PnP-Partner-Pack-Overrides.xml

Set-PnPPropertyBagValue -Key "_PnP_PartnerPack_Overrides_Enabled" -Value "true"


Connect-PnPOnline https://spgurus.sharepoint.com/teams/2013test/TemplateSubSite -Credentials $cred

Enable-PnPResponsiveUI -InfrastructureSiteUrl https://spgurus.sharepoint.com/sites/PnP-Partner-Pack-Infrastructure

Connect-PnPOnline https://spgurus.sharepoint.com/teams/2013test/UsingTemplate -Credentials $cred


PropertyBag_TemplateInfo


Connect-PnPOnline https://spgurus.sharepoint.com/sites/ModernTeamSite1 -Credentials $cred

Get-PnPProvisioningTemplate -Out c:\temp\modernSite.pnp

Connect-PnPOnline https://spgurus.sharepoint.com/sites/ModernTeamSite2 -Credentials $cred

Apply-PnPProvisioningTemplate -path c:\temp\modernSite.pnp
