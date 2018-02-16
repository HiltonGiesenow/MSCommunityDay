import-module SharePointPnPPowerShellOnline

$tenant = "sharepointgurus.co.za"
$orgName = "spgurus"
$userName = "hg@$tenant"

$cred = Get-Credential -UserName $userName -Message "Password for $userName"

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

import-module Microsoft.Online.SharePoint.PowerShell

Connect-SPOService -Url https://spgurus-admin.sharepoint.com -Credential $cred
Remove-SPOSite https://spgurus.sharepoint.com/sites/BrandedSiteFromSiteTemplate

Connect-PnPOnline https://spgurus.sharepoint.com/sites/ThemeTemplate -Credentials $cred
Get-PnPProvisioningTemplate -Out c:\temp\TemplateWithMyBranding.pnp -PersistBrandingFiles -PersistPublishingFiles

Connect-PnPOnline https://spgurus.sharepoint.com/sites/BrandedSiteFromSiteTemplate -Credentials $cred
Set-PnPTraceLog -On -LogFile C:\temp\pnpoutput2.txt -Level Debug
Apply-PnPProvisioningTemplate -path c:\temp\TemplateWithMyBranding.pnp
