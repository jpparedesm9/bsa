//Start signature to Callback event to VC_GENERALBSI_401479
task.initDataCallback.VC_GENERALBSI_401479 = function(entities, initDataCallbackEventArgs) {
    if(initDataCallbackEventArgs.success && angular.isDefined(entities.Customer) && entities.Customer!==null){
       //Cabecera
        var firstName = entities.Customer.customerName;
        var secondName = entities.Customer.customerSecondName;
        var lastName = entities.Customer.customerLastName;
        var secondLastName = entities.Customer.customerSecondLastName;
        var fullName = entities.Customer.customerFullName;
        var customerCompleteName = null;
        
        if(fullName!==null){
           customerCompleteName = fullName;
           }else{
               if(firstName!==null){
                  customerCompleteName = firstName;
                  }
               if (secondName!==null){
                   customerCompleteName += " " + secondName;
               }
               if (lastName!==null){
                   customerCompleteName += " " + lastName;
               }
               if (secondLastName!==null){
                   customerCompleteName += " " + secondLastName;
               }
           }
        
        
        BSSNS.INBOX.addTaskHeader(taskHeader, 'title', customerCompleteName.toUpperCase(), 0);
        BSSNS.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.Customer.identificationType!==null ? entities.Customer.identificationType : "", 1);
        BSSNS.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.Customer.customerIdentification!==null ? entities.Customer.customerIdentification : "", 1);
        BSSNS.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.Customer.customerId!==null ? entities.Customer.customerId : "", 2);
        			
        BSSNS.INBOX.updateTaskHeader(taskHeader, initDataCallbackEventArgs, 'G_GENERALSSA_700568'); 
        
        
        //Invocacion pantalla manual
        callManualForm(initDataCallbackEventArgs,entities.Customer.customerId,'G_GENERALUSS_474568');
    }
    
   
     
};