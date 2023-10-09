//Entity: WarrantySituation
    //WarrantySituation.sharedType (CheckBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    //Campo Compartida
    task.change.VA_ARANSCATIO0715_TYPE600 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
        var api = changedEventArgs.commons.api;
        //if(changedEventArgs.newValue){                  
        if (entities.WarrantySituation.sharedType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NTLL256']);
            api.viewState.enableValidation('VA_ARANSCATIO0715_NTLL256', VisualValidationTypeEnum.Required);
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NTLL256']);
            entities.WarrantySituation.totalInitialValue = 0;
            api.viewState.disableValidation('VA_ARANSCATIO0715_NTLL256', VisualValidationTypeEnum.Required);
        }
    };