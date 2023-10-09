//Entity: OtherCharges
    //OtherCharges.divUp (TextInputBox) View: ProjectOtherCharges
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DIVUPQPVWWEQDNI_233872 = function(  entities, changedEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var iniDiv = entities.OtherCharges.iniDiv   
        var divUp = entities.OtherCharges.divUp
        if (divUp < 0){
            changeEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11972",true); 
               return;
        }        
        if (iniDiv < 0){
             changeEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11977",true); 
               return;
        }
        if (iniDiv > divUp){
           changeEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11969",true); 
           return;
        }
    };