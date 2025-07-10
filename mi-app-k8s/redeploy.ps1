# Configuración
$acrName = "miacrlucia"
$imageName = "mi-app"
$tag = "latest"
$deploymentName = "mi-app-deployment"
$containerName = "mi-app"

$acrLoginServer = "$acrName.azurecr.io"
$fullImageName = "${acrLoginServer}/${imageName}:${tag}"

function Check-LastExitCode {
    param($stepName)
    if ($LASTEXITCODE -ne 0) {
        Write-Error "❌ Error en paso: $stepName. Saliendo del script."
        exit 1
    }
}

Write-Host "🔨 1. Construyendo la imagen Docker con etiqueta $fullImageName..."
docker build --no-cache -t $fullImageName .
Check-LastExitCode "Construcción Docker"

Write-Host "🔐 2. Iniciando sesión en Azure Container Registry ($acrName)..."
az acr login --name $acrName
Check-LastExitCode "Login ACR"

Write-Host "🚀 3. Subiendo la imagen al ACR..."
docker push $fullImageName
Check-LastExitCode "Push Docker"

Write-Host "♻️ 4. Actualizando la imagen del deployment en AKS..."

# Verificamos que el deployment exista
$deploymentExists = kubectl get deployment $deploymentName -o json 2>$null
if (-not $deploymentExists) {
    Write-Error "❌ No se encontró el deployment '$deploymentName' en AKS. Por favor, crea el deployment antes de continuar."
    exit 1
}

kubectl set image deployment/$deploymentName $containerName=$fullImageName
Check-LastExitCode "Actualizar imagen en deployment"

Write-Host "⌛ 5. Esperando a que el deployment se actualice..."
kubectl rollout status deployment/$deploymentName
Check-LastExitCode "Rollout deployment"

Write-Host "✅ ¡Listo! La app fue redeplegada con la nueva imagen: $fullImageName"
