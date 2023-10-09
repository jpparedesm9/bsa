//Entity: OtherCharges
    //OtherCharges.value (TextInputBox) View: ProjectOtherCharges
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_2011UKZSBSFRWRA_245872 = function(  entities, changedEventArgs ) {
        var value = entities.OtherCharges.value;  
        var valueMax = entities.OtherCharges.valueMax;  
        var valueMin = entities.OtherCharges.valueMin;  
        var reference = entities.OtherCharges.reference;  
        if (value.length > 20) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11975",true);
            return;
        }
        if (reference != null){
            if (value > valueMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11973",true);
            return;
            }
            if (value < valueMin) {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBERZE_11974",true);
                return;
            }            
        }                
        changeEventArgs.commons.execServer = false;
    };