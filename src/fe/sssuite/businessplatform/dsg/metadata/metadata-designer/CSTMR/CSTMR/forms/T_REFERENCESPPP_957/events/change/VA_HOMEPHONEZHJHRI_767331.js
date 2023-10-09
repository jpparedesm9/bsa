//Entity: References
    //References.homePhone (TextInputBox) View: ReferencesPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_HOMEPHONEZHJHRI_767331 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
		if(/^[0-9]*$/.test(entities.References.homePhone)==false){
			entities.References.homePhone = '';
			changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_SOLOSEPEM_70414',true);
		} 
          
         if(entities.References.homePhone.length!=10){
			changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELNMEROND_10800',true);
		} 
          
        
    };