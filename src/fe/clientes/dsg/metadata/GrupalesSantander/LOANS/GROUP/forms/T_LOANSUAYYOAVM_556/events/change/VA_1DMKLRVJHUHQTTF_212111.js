//Entity: CustomerExclusionList
    //CustomerExclusionList.customerName (TextInputButton) View: ExclusionList
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_1DMKLRVJHUHQTTF_212111 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
                

    if(changedEventArgs.newValue == ""){
       entities.CustomerExclusionList.customerId =null;
       }
        
    };