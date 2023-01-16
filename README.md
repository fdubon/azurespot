# azurespot


In this location you will find the code and scripts used in the video about Azure Spot Instances.
if you have any questions please feel free to ping me.


<b>Pricing - Linux Virtual Machines | Microsoft Azure</b>


<b>Query the Billing API for Spot Pricing:</b>

https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices

Query:

curl -X GET https://prices.azure.com/api/retail/prices\?meterName\=spot | jq '.Items[]|select (.meterName | contains("Spot"))| [.skuName, .retailPrice, .meterName, .location]'



Graph API:
az | Microsoft Learn


Eviction process:
How to build workloads on spot virtual machines - Azure Architecture Center | Microsoft Learn

Scheduled events notification:
Scheduled Events for Linux VMs in Azure - Azure Virtual Machines | Microsoft Learn


Capacity look up for region?

Reduce operational cost - slide add the use the API to find out per region

The idea of this query is to find the lowest spot price for a specific SKU in spot

armSkuName="Standard_D16ds_v5"

url='https://prices.azure.com/api/retail/prices?$filter=armSkuName%20eq%20%27'$armSkuName'%27'

minPrice=$(curl -s -XGET $url | jq -r ".Items[] | .unitPrice" | awk '{ $1=sprintf("%f", $1)}1'|sort --reverse|tail -1)

curl-s-XGET'https://prices.azure.com/api/retail/prices?$filter=armSkuName%20eq%20%27Standard_D16ds_v5%27'| jq -r".Items[] | select(.unitPrice == ($minPrice)) | .armRegionName"


How to Get VM Eviction rate Through REST API:
           

			spotresources
			| where type == 'microsoft.compute/skuspotevictionrate/location'
			| where location in ('westus3','westus')
			| project skuName=tostring(sku.name), location, evictionRate=properties.evictionRate
			| order by skuName
			
			


Simulate Eviction from CLI:

Az vm simulate-eviction --resource-group (resourceGroup) --name (Vmname)


AK NodePool:

	Az aks nodepool add \
		--resource-group RGNAME \
		--cluster-name CLUSTERNAME \
		--name spotnodepool \
		--priority spot \
		--eviction-policy Delete \
		--spot-max-price -1 \
		--enable-cluster-autoscaler \
		--min-count 1 \
		--max-count 3 \
		--no-wait
		
		
		
![image](https://user-images.githubusercontent.com/7008711/212583791-fb44daf5-5459-40bb-92aa-30a91e3eca0c.png)
