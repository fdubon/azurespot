armSkuName="Standard_D16ds_v5"

url='https://prices.azure.com/api/retail/prices?$filter=armSkuName%20eq%20%27'$armSkuName'%27'

minPrice=$(curl -s -XGET $url | jq -r ".Items[] | .unitPrice" | awk '{ $1=sprintf("%f", $1)}1'|sort --reverse|tail -1)

curl -s -X GET'https://prices.azure.com/api/retail/prices?$filter=armSkuName%20eq%20%27Standard_D16ds_v5%27'| jq -r".Items[] | select(.unitPrice == ($minPrice)) | .armRegionName"
