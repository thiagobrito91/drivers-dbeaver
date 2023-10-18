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


-- Crie uma tabela temporária para armazenar as datas de entrada
CREATE TABLE #DateInput (StartDate DATE, EndDate DATE);

-- Insira os valores de data de entrada na tabela temporária
INSERT INTO #DateInput (StartDate, EndDate)
VALUES 
    ('2023-01-01', '2023-01-05'),
    ('2023-02-01', '2023-02-03');

-- Crie uma tabela temporária para armazenar as datas
CREATE TABLE #DateTable (DateValue DATE);

-- Insira todas as datas entre os intervalos das datas de entrada na tabela temporária
INSERT INTO #DateTable (DateValue)
SELECT DATEADD(day, Number, StartDate) AS Date
FROM #DateInput
JOIN master.dbo.spt_values ON type = 'P' 
    AND number BETWEEN 0 AND DATEDIFF(day, StartDate, EndDate)
ORDER BY Date;

-- Selecione todas as datas da tabela temporária
SELECT * FROM #DateTable;

-- Limpe as tabelas temporárias
DROP TABLE #DateInput;
DROP TABLE #DateTable;

