//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: GenericApplication
    task.onCloseModalEvent = function(entities, onCloseModalEventArgs) {
        onCloseModalEventArgs.commons.execServer = false;
		/*var parentParameters = onCloseModalEventArgs.commons.api.parentVc.customDialogParameters;
        if(onCloseModalEventArgs.closedViewContainerId=='VC_OSRCH32_AOEAR_233'
			&&onCloseModalEventArgs.dialogCloseType!=1//envia a cerrar por X
			){
			console.log("cerrado el evento VC_OSRCH32_AOEAR_233");
			var debtors = angular.copy(onCloseModalEventArgs.commons.api.vc.model.DebtorGeneral.data());
			var band=false;
			// Recupero el resultado
			var result =  onCloseModalEventArgs.result;
			
			// Añado los registros a la grilla de deudores
			if(result.debtors!=null&&result.debtors!=undefined){
				for (var i = 0; i < result.debtors.length; i++) {
				for (var j = 0; j < debtors.length; j++) {
					if (debtors[j].CustomerCode == result.debtors[i].CustomerCode) {
						band=true;			        
						break;
					}else{
						band=false;
					}
				}
				if(!band){
                        result.debtors[i].Role = 'C';
						onCloseModalEventArgs.commons.api.grid.addRow('DebtorGeneral', result.debtors[i], false);
					}
				}	
			}
			
			if(result.operations!=null&&result.operations!=undefined){
				onCloseModalEventArgs.commons.api.grid.addAllRows('RefinancingOperations', result.operations, false);
			}
			if(parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Reestructuration){
				onCloseModalEventArgs.commons.execServer = true;
			}else{
				onCloseModalEventArgs.commons.execServer = false;
			}
			
		}else{
			onCloseModalEventArgs.commons.execServer = false;
		}
		//envio de entidades
		onCloseModalEventArgs.commons.serverParameters.OriginalHeader = true;
        onCloseModalEventArgs.commons.serverParameters.RefinancingOperations = true;*/
        //SMO no existe el método completo en Grupales
    };