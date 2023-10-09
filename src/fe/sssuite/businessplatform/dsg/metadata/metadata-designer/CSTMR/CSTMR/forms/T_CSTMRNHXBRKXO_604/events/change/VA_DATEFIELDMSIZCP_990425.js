//Entity: SpousePerson
    //SpousePerson.birthDate (DateField) View: CustomerSpouseForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DATEFIELDMSIZCP_990425 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
		//Por caso #154979
        //if (task.FechaNacimiento(entities.SpousePerson.birthDate, edadMin, edadMax) == false) {
        //    changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
        //}
        
    };