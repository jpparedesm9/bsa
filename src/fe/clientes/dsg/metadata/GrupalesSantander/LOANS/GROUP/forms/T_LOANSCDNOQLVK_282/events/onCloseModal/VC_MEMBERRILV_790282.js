//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: MemberRiskLevelForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = true;    
        var customerData = onCloseModalEventArgs.result.selectedData;
        entities.Member.customerId = customerData.code;        
        setHeaderForm(customerData, onCloseModalEventArgs);       
    };