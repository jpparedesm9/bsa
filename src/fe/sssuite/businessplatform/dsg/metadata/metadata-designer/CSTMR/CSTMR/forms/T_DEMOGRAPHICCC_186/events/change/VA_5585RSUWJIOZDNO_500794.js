//Entity: DemographicData
    //DemographicData.profession (ComboBox) View: DemographicForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_5585RSUWJIOZDNO_500794 = function(  entities, changedEventArgs ) {
        if(changedEventArgs.newValue == '007'){
            changedEventArgs.commons.api.viewState.enable('VA_WHICHPROFESSINI_582794');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_WHICHPROFESSINI_582794');
            entities.DemographicData.whichProfession = null;
        }
        changedEventArgs.commons.execServer = false;
        
    };