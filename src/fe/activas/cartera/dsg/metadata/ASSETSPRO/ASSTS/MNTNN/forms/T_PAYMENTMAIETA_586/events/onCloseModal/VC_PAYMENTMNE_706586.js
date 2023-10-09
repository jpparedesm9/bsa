//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: Payment maintenance
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
         onCloseModalEventArgs.commons.execServer = false;
		var isAccept;
		
		
		if (typeof onCloseModalEventArgs.result === "boolean") {
                isAccept = onCloseModalEventArgs.result;
            }
            if (isAccept) {
			
                onCloseModalEventArgs.commons.api.grid.refresh("QV_7546_25470",{param:{}});				
            }
        
    };