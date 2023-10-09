//Entity: SpousePerson
//SpousePerson.firstName (TextInputBox) View: CustomerSpouseForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXTLP_404425 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    var text = entities.SpousePerson.firstName;
    var indexs = text.indexOf(".");
    if(indexs != -1){
        var sub = text.substring(0, indexs.length);
        if(sub != 'MA.'){
                changedEventArgs.commons.messageHandler.showTranslateMessagesError('El punto solo se permite en MA.',true);
                entities.SpousePerson.firstName = null;
        }
        indexs = 0;
    }    
    
        
};