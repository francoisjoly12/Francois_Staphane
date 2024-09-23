param(
    [string]$file
)

function Test-ADGroupExistence([string]$nom) {
    try {
        Get-ADGroup -Identity $nom -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

function Test-ADUserExistence([string]$nom) {
    try {
        Get-ADUser -Identity $nom -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}


#prend le contenue du fichier | -skip 1 permet de laisser faire l'entete
$user = Get-Content .\$file | Select-Object -Skip 1

#cré des array vide pour les 2 variable nom et description
$Username = @()
$Password = @()
$Prenom = @()
$NomFamille = @()
$ModifierMdP= @()
$Active = @()
$Groupe = @()

#split chaque ligne de $groupe
foreach ($line in $user){
    $user, $pass, $preN, $nomF, $mMdp, $act, $grp = $line -split ','
    $Username += $user.Trim()
    $Password += $pass.Trim()
    $Prenom += $preN.Trim()
    $NomFamille += $nomF.Trim()
    $ModifierMdP += $mMdp.Trim()
    $Active += $act.Trim()
    $Groupe += $grp.Trim()
}

for ($i = 0; $i -lt $Username.Count; $i++) {
    if (Test-ADUserExistence($Username[$i])){
        Write-Host ("L'utilisateur' $($Username[$i]) existe déjà, il n'a pas à être créé") -ForegroundColor Red
    }
    else {
        if ($ModifierMdP -eq "oui"){
            $ModifierMdP = 1
        }
        else {
            $ModifierMdP = 0
        }
	
	if ($Active -eq "oui"){
		$Active = 1
	}
        else {
            $Active = 0
        }
	#$securePassword[$i] = ConvertTo-SecureString -String "$Password[$i]" -AsPlainText -Force
        New-ADUser -Name $Username[$i] -Surname $Prenom[$i] -GivenName $NomFamille[$i] -ChangePasswordAtLogon $ModifierMdP[$i] -SamAccountName $Username[$i] 
    }
}