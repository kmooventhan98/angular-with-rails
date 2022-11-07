app = angular.module("HomeAdminSerivce", [])

app.factory "$Home", ["$resource", ($resource) ->
	

	#home
	savePharmacy: $resource("/save_pharmacy", null,
	    update:
	      	method: "PUT")

]