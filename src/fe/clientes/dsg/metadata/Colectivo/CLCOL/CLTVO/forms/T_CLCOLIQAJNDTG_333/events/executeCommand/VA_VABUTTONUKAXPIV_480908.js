//Entity: CollectiveProcessProgress
//CollectiveProcessProgress. (Button) View: LoadCollectivePerson
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONUKAXPIV_480908 = function (entities, executeCommandEventArgs) {

    executeCommandEventArgs.commons.execServer = true;
    gridLength = entities.CollectivePersonRecord.data().length;
    var collectiveEntity = entities.CollectivePersonRecord.data()[gridPosition];
    var filtro = {
        position: gridPosition
    };

    executeCommandEventArgs.commons.api.vc.parentVc = {}
    executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    
    if(!executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_216908")
        && !executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_690908")){
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_216908');
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_690908');
    }
    
    
    
};