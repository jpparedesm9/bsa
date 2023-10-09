//Entity: DemographicData
    //DemographicData.dependents (TextInputBox) View: DemographicForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_8667DCPWKDXLAAQ_828794 = function(  entities, changedEventArgs ) {
        /*if(entities.DemographicData.dependents < 0 || entities.DemographicData.dependents > 10 ){
            entities.DemographicData.dependents = 0;
            alert("Las dependencias económicos deben estar entre el rango 0 - 10");
        }*/
        
        changedEventArgs.commons.execServer = false;
    
        
    };