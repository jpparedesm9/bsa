//Entity: FilterSimulation
    //FilterSimulation.term (ComboBox) View: SimulationCreditRenovations
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TERMFQAXXSBCLOQ_177753 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.viewState.disable('CM_TLOANSYB_04A');
        
    };