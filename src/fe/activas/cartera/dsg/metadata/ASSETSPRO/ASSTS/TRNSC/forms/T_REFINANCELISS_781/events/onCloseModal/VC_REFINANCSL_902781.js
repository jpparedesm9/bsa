//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: RefinanceLoansFilter
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if(onCloseModalEventArgs.result.code !=null){
          entities.RefinanceLoanFilter.account = onCloseModalEventArgs.result.code.trim();
        }        
    };
    
    task.closeModalEvent.findCustomer = function (args) { 
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        var CustomerName=  args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;
        
        args.model.RefinanceLoanFilter.clientName  =  customerCode +"-"+ CustomerName;
        args.model.RefinanceLoanFilter.clientID  =  customerCode;
    };