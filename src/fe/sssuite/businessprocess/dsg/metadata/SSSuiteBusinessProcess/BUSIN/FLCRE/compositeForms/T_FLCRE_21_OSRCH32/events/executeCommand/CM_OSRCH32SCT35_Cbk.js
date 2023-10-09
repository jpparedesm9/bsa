//Start signature to callBack event to CM_OSRCH32SCT35
     //select Callback (Button)
     task.executeCommandCallback.CM_OSRCH32SCT35 = function(entities, executeCommandCallbackEventArgs) {
    	 
    	 //Declaro las variables para enviar a la vista padre
    	 var operations = [];
    	 var debtors = [];
    	 
    	 //Almaceno en arreglo operations las operaciones que cumplieron y excepcionaron
    	 for (var i = 0; i < entities.SelectedOperations.length; i++) {
			if (entities.SelectedOperations[i].checkRule) {
				operations.push(entities.SelectedOperations[i]);
			}
    	 }
    	 
    	//Almaceno en arreglo debtors los deudores que el CustomerCode sea diferente de null
    	 for (var i = 0; i < entities.Debtors.length; i++) {
 			if (entities.Debtors[i].CustomerCode != null) {
 				entities.Debtors[i].TypeDocumentId = "03";
 				if (entities.Debtors[i].Identification.length==10) {
 					entities.Debtors[i].TypeDocumentId = "01";
				}else if (entities.Debtors[i].Identification.length==13) {
					entities.Debtors[i].TypeDocumentId = "02";
				}
 				debtors.push(entities.Debtors[i]);
 			}
     	 }
    	 
    	 //Creo el objeto que se va enviar  como respuesta
    	 var result ={operations : operations,
    			 	  debtors : debtors	}
    	 
		 executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);
    	 
     };