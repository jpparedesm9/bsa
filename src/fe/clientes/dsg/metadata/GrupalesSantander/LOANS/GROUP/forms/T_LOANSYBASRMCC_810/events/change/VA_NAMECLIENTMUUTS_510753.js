//Entity: FilterSimulation
    //FilterSimulation.nameClient (TextInputBox) View: SimulationCreditRenovations
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_NAMECLIENTMUUTS_510753 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    changedEventArgs.commons.api.viewState.disable('CM_TLOANSYB_04A');
        
    };