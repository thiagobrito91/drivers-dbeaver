# Importar módulos necessários
Import-Module Microsoft.PowerShell.Utility
Import-Module Microsoft.PowerShell.Management

# Definir variáveis da API
$apiUrl = "https://exemplo.com/api/endpoint"   # Substitua pela URL da sua API
$headers = @{
    "Authorization" = "Bearer seu_token"      # Substitua "seu_token" pelo token de autenticação
    "Content-Type" = "application/json"       # O tipo de conteúdo depende da API; pode ser "application/json", "application/x-www-form-urlencoded", etc.
}

# Ler o arquivo CSV
$csvFilePath = "Caminho\para\seu\arquivo.csv"  # Substitua pelo caminho do seu arquivo CSV
$csvData = Import-Csv -Path $csvFilePath

# Percorrer os itens do CSV e fazer as requisições POST
foreach ($item in $csvData) {
    # Formatar os dados conforme necessário para a API (por exemplo, converter para JSON)
    $jsonData = $item | ConvertTo-Json

    # Fazer a requisição POST para a API usando Invoke-RestMethod
    $response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Post -Body $jsonData

    # Tratar a resposta (opcional)
    # Por exemplo, exibir a resposta para verificar se foi bem-sucedida
    Write-Host "Resposta da API:"
    Write-Host $response
}
