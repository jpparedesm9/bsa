//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: QueryDocuments
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if(onCloseModalEventArgs.result.params != undefined){
            if(onCloseModalEventArgs.result.params.controlName == "cliente"){
		    	entities.HeaderQueryDocuments.clientName = onCloseModalEventArgs.result.selectedData.name;
		    	entities.HeaderQueryDocuments.clientId=onCloseModalEventArgs.result.selectedData.code;
		    }
            if(onCloseModalEventArgs.result.params.controlName == "grupo"){
		    	entities.HeaderQueryDocuments.groupName = onCloseModalEventArgs.result.selectedData.name;
		    	entities.HeaderQueryDocuments.groupId = onCloseModalEventArgs.result.selectedData.code;
		    }
		}
    };