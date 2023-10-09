// (Button) 
    task.executeCommand.CM_TCUSTOME_T6S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //api.viewState.disable('VA_EMAILPFXEWBQUQH_770213');
        //executeCommandEventArgs.commons.api.viewState.show('VA_EMAILPFXEWBQUQH_770213');
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
        var physicalAddresses = entities.PhysicalAddress.data();
        var virtualAddresses = entities.VirtualAddress.data();
        var scannedDocumentsDetail = entities.ScannedDocumentsDetail.data();
        var hasMainPhisicalAddress = false;
        var hasMainDocuments = true; //Caso153311
        entities.Context.channel = channel; // caso203112
		
        for(var i = 0; i < physicalAddresses.length; i++){
             if(physicalAddresses[i].isMainAddress)
             {
               hasMainPhisicalAddress = true;
             }
         }

		//Inicio Caso153311
		if(scannedDocumentsDetail.length != 0){
            for(var i = 0; i < scannedDocumentsDetail.length; i++){
			     if((scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '007') && 
				    (scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '006') &&
                    (scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '010') &&
                    (scannedDocumentsDetail[i].uploaded === 'N' && scannedDocumentsDetail[i].documentId != '011')){ //--caso#194473
					 hasMainDocuments = false;
                     break;
				 }else{
					 hasMainDocuments = true;
				 }
			}
        }
		//Fin Caso153311		
        if(hasMainPhisicalAddress && virtualAddresses.length > 0){
			if (hasMainDocuments === false){
				executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_DEBECUMNE_39597',false);
				executeCommandEventArgs.commons.execServer = false; 		
			}else{
				executeCommandEventArgs.commons.execServer = true;
			}
        }else{
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELPROSPIU_85243',false);
            executeCommandEventArgs.commons.execServer = false;          
        }
    };