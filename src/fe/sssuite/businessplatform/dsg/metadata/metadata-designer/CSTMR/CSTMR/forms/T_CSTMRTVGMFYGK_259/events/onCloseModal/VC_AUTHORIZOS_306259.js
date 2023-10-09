//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: AuthorizationTransferForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
        
        if(onCloseModalEventArgs.result.resultArgs!=null && onCloseModalEventArgs.result.resultArgs!=undefined){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                
                if(entities.AuthorizationTransferRequest.data().length != 0){
                    for(var i=0 ; i <= entities.AuthorizationTransferRequest.data().length -1 ; i++ ){
                        if(entities.AuthorizationTransferRequest.data()[i].isChecked === true){
                            entities.AuthorizationTransferRequest.data()[i].rejectionReason = onCloseModalEventArgs.result.resultArgs.rejectionReason;
                            onCloseModalEventArgs.commons.execServer = true;
                            break;
                        }
                    }
                }
                
            }
        }
        
    };