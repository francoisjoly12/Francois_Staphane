param(
    	#nom du fichier passé en parametre
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

#prend le contenue du fichier | -skip 1 permet de laisser faire l'entete
$groupe = Get-Content .\$file | Select-Object -Skip 1

#cré des array vide pour les 2 variable nom et description
$nom = @()
$desc = @()

#split chaque ligne de $groupe sur la , puis les mets dans les array nom et desc
foreach ($line in $groupe){
    $n, $d = $line -split ','
    $nom += $n.Trim()
    $desc += $d.Trim()
}

#pour une boucle avec le .count de nom
for ($i = 0; $i -lt $nom.Count; $i++) {
    if (Test-ADGroupExistence($nom[$i])){
        Write-Host ("Le groupe $($nom[$i]) existe déjà, il n'a pas à être créé") -ForegroundColor Red
    }
    else{
        #cré le groupe de sécurité global pour chaqu'une des lignes.
        New-ADGroup -GroupCategory "Security" -GroupScope "Global" -Name $nom[$i] -Description $desc[$i]
        write-host ("Le groupe $($nom[$i]) à été créé")
    }
}
