//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: LoanDisbursementMain
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
         try{
         var isCancel =  false; 
        var dataResult ;
        if (onCloseModalEventArgs.closedViewContainerId == "VC_PAYMENTMDE_245368") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                isCancel = onCloseModalEventArgs.result;
            }
            if (!isCancel && typeof onCloseModalEventArgs.result.data !== "undefined") {
               dataResult = onCloseModalEventArgs.result.data;
               onCloseModalEventArgs.commons.execServer = true;
            }
        }
      }catch(err) {
         console.log('Error='+err);
         onCloseModalEventArgs.commons.execServer = true;
      }
        
    };