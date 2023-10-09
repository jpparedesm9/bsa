//Entity: CustomerTmp
    //CustomerTmp. (Button) View: AddressForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONYDIJDRL_132566 = function(  entities, executeCommandCallbackEventArgs ) {
        
        //here your code
        if (executeCommandCallbackEventArgs.success) {
            
            if (ban){
              if (showHeader && typeof taskHeader !== 'undefined' && taskHeader!=undefined &&  taskHeader!=null ) {

                    if(entities.CustomerTmp.customerType == 'P'){
                        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmp.name, 0);
                    }else{
                        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmp.businessName, 0);
                    }
                    LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.CustomerTmp.documentNumber, 1);
                    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.CustomerTmp.documentType, 1);
                    LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.CustomerTmp.code, 2);
                    //LATFO.INBOX.addTaskHeader(taskHeader,'RAZON SOCIAL',entities.LegalPerson.tradename,0);
                    LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_ADDRESSXDI_956566');
                    executeCommandCallbackEventArgs.commons.api.viewState.show('G_ADDRESSXDI_956566');
                } else {
                    //Para VCC
                    executeCommandCallbackEventArgs.commons.api.viewState.hide('G_ADDRESSXDI_956566');
                }
            }
            if(entities.PhysicalAddress.data().length != 0){
				for(var i = 0; i <= entities.PhysicalAddress.data().length - 1; i++){
					if(entities.PhysicalAddress.data()[i].businessCode == 0){
						entities.PhysicalAddress.data()[i].businessCode = null;
					}
				}
        }
        }
    };