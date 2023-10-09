//Entity: References
    //References. (Button) View: ReferencesPopupForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONLYUTEBY_858331 = function(  entities, executeCommandEventArgs ) {
    
    if(entities.References.homePhone.length!=10){
			executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELNMEROND_10800',true);
          executeCommandEventArgs.commons.execServer = false;
		} 
    else{

    executeCommandEventArgs.commons.execServer = true;
    
    executeCommandEventArgs.commons.serverParameters.References = true;
    executeCommandEventArgs.commons.serverParameters.CustomerTmpReferences = true;
    entities.References.relationship='AB';
    if(entities.References.numberOfReferences == null){
        entities.References.numberOfReferences = 0;
    }
    if(entities.References.knownTime == null){
        entities.References.knownTime = 0;
    }
    }
};