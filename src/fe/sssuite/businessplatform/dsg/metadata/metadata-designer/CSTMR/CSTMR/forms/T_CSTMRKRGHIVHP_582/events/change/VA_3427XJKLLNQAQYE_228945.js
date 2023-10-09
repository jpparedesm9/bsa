//Entity: ReferenceReq
    //ReferenceReq.purchaseAmount (TextInputBox) View: ValidateReferenceForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_3427XJKLLNQAQYE_228945 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
        var controls = ['CM_TCSTMRKR_SMT'];
     LATFO.UTILS.disableFields(changedEventArgs, controls, true);
        
    };