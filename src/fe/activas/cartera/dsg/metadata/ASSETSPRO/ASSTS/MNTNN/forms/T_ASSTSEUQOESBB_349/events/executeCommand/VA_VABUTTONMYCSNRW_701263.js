//Entity: MassivePaymentFile
    //MassivePaymentFile. (Button) View: MassivePayment
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONMYCSNRW_701263 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        var buttons = ['SI', 'NO']
            
              
        if (entities.MassivePaymentFile.fileName == undefined || entities.MassivePaymentFile.fileName == null || entities.MassivePaymentFile.fileName == ""){
            executeCommandEventArgs.commons.messageHandler.showMessagesError("Debe elegir un archivo");
              
             executeCommandEventArgs.commons.api.vc.executeCommand('VA_VABUTTONVBEQBSD_442263','Compute', undefined, true, false, 'VC_MASSIVEPTY_109349', false);
            
        }else{
            var promise = cobis.showMessageWindow.confirm('\u00BFConfirma el proceso de Pagos Masivos\u003F', 'Pagos Masivos',  buttons);
            promise.then(function (response) {
                if(response.buttonIndex == 0){
            	   executeCommandEventArgs.commons.api.vc.executeCommand('VA_VABUTTONGTRMBBC_889263','Compute', undefined, true, false, 'VC_MASSIVEPTY_109349', false);
                }
        
        
            });
        }
    };