RG="009"
APPNAME="009-elixir"
LOCATION="West US"
SKU=F1
PLAN="plan-009"

echo "Creating Resource Group"
az group create -n $RG --location $LOCATION


echo "Creating AppService Plan for Linux."
az appservice plan create --name $PLAN \
                          --resource-group $RG \
                          --sku $SKU \
                          --is-linux

echo "Creating Web app"
az webapp create --resource-group $RG \
                  --plan $APPNAME \
                  --name $APPNAME \
                  --multicontainer-config-type compose \
                  --multicontainer-config-file docker-compose-azure.yml

echo "Setting up logging"
az webapp log config --application-logging true \
                    --detailed-error-messages true \
                    --docker-container-logging filesystem \
                    --web-server-logging filesystem \
                    --level information \
                    --name $APPNAME \
                    --resource-group $RG

echo "Opening site and viewing logs"
open https://$APPNAME.azurewebsites.net

az webapp log tail -n $APPNAME -g $RG
