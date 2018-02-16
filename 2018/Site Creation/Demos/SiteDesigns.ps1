# Needs SharePoint Online Management Shell - https://www.microsoft.com/en-us/download/details.aspx?id=35588

Import-Module Microsoft.Online.SharePoint.PowerShell #-DisableNameChecking

$tenant = "sharepointgurus.co.za"
$orgName = "spgurus"
$userName = "hg@$tenant"
$siteUrl = "https://spgurus.sharepoint.com/sites/2016Test"
$userCredential = Get-Credential -UserName $userName -Message "Password for $userName"
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential

Connect-SPOService -Url $siteUrl -Credential $userCredential

Get-SPOSiteDesign
Get-SPOSiteScript

$scriptBody = @'
{
 "$schema": "schema.json",
     "actions": [
         {
             "verb": "createSPList",
             "listName": "Customer Tracking",
             "templateType": 100,
             "subactions": [
                 {
                     "verb": "SetDescription",
                     "description": "List of Customers and Orders"
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "Text",
                     "displayName": "Customer Name",
                     "isRequired": false,
                     "addToDefaultView": true
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "Number",
                     "displayName": "Requisition Total",
                     "addToDefaultView": true,
                     "isRequired": true
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "User",
                     "displayName": "Contact",
                     "addToDefaultView": true,
                     "isRequired": true
                 },
                 {
                     "verb": "addSPField",
                     "fieldType": "Note",
                     "displayName": "Meeting Notes",
                     "isRequired": false
                 }
             ]
         }
     ],
         "bindata": { },
 "version": 1
}
'@

$siteScript = Add-SPOSiteScript -Title "Create customer tracking list" -Content $scriptBody -Description "Creates list for tracking customer contact information"
$siteScript
#$siteScript = Get-SPOSiteScript "03bdabc3-a8b8-43ea-8ce3-0c75d1b5fc25"

Get-SPOSiteScript

$scriptsForDesign = @(
						$siteScript.Id
					)
$design1 = Add-SPOSiteDesign -Title "Contoso customer tracking" -WebTemplate "64" -SiteScripts $scriptsForDesign -Description "Tracks key customer data in a list"
$design1

Get-SPOSiteDesign


$scriptBody2 = @'
{
	"$schema": "schema.json",
	  "actions": 
	  [
		  {
			  "verb": "setSiteLogo",
			  "url": "https://s7storage.blob.core.windows.net/images/s7-logo-64.png"
		  }
	  ],
		  "bindata": { },
	  "version": 1
  };
'@

$siteScript2 = Add-SPOSiteScript -Title "Set Site Logo" -Content $scriptBody2 -Description "Sets our company logo"
$siteScript2
#$siteScript = Get-SPOSiteScript "03bdabc3-a8b8-43ea-8ce3-0c75d1b5fc25"

Get-SPOSiteScript

$scriptsForDesign = @(
						$siteScript.Id,
						$siteScript2.Id
					)
Add-SPOSiteDesign -Title "Contoso 2" -WebTemplate "64" -SiteScripts $scriptsForDesign -Description "Tracks key customer data in a list plus Desc"

Get-SPOSiteDesign

Remove-SPOSiteDesign -Identity $design1.Id

Get-SPOSiteDesign
