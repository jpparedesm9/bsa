//Entity: VirtualAddress
    //VirtualAddress.addressDescription (TextInputBox) View: AddressForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXILB_303566 = function(  entities, changedEventArgs ) {
     changedEventArgs.commons.execServer = false;
        if(!LATFO.UTILS.validarEmail(changedEventArgs.rowData.addressDescription)){
         changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
        }        
    };