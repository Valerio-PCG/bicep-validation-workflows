githubOrganizationName='Valerio-PCG'
githubRepositoryName='bicep-validation-workflows'

applicationRegistrationDetails=$(az ad app create --display-name 'bicep-validation-workflows')
applicationRegistrationObjectId=$(echo $applicationRegistrationDetails | jq -r '.id')
applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')

az ad app federated-credential create \
   --id $applicationRegistrationObjectId \
   --parameters "{\"name\":\"bicep-validation-workflows\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:environment:Website\",\"audiences\":[\"api://AzureADTokenExchange\"]}"

az ad app federated-credential create \
   --id $applicationRegistrationObjectId \
   --parameters "{\"name\":\"bicep-validation-workflows-branch\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:ref:refs/heads/main\",\"audiences\":[\"api://AzureADTokenExchange\"]}"