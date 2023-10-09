//Entity: CollectiveProcessProgress
    //CollectiveProcessProgress. (Button) View: LoadExternalAdvisor
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONXICAMDT_820757 = function(  entities, executeCommandEventArgs ) {


    
    executeCommandEventArgs.commons.execServer = true;
    gridLength = entities.CollectiveAdvisor.data().length;
    var asesorEntity = entities.CollectiveAdvisor.data()[gridPosition];
    var filtro = {
        position: gridPosition
    };

    executeCommandEventArgs.commons.api.vc.parentVc = {}
    executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    
    if(!executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_604757")
        && !executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_164757")){
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_604757');
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_164757');
    }
    };