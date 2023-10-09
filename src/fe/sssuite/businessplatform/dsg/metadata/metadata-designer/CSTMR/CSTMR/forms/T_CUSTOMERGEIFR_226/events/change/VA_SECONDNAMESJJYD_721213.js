//Entity: NaturalPerson
//NaturalPerson.secondName (TextInputBox) View: CustomerGeneralInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_SECONDNAMESJJYD_721213 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;

    var text = entities.NaturalPerson.secondName;
    var splitText = text == null ? null : text.split(" ");
    var countWhitespaces = splitText == null? 0 : splitText.length-1;
    if (countWhitespaces > 3) {
        changedEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_NOSEPERIE_23207', true);
        entities.NaturalPerson.secondName = null;
    } 
    
        
};