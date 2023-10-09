//Entity: WarrantySituation
    //WarrantySituation.inspectType (CheckBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0715_IPTE389 = function( entities, changeEventArgs ) {
        changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
        if (entities.WarrantySituation.inspectType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_RDII635']);
            entities.WarrantySituation.inspectReason = null;
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        } else {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NSPC524']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_RDII635']);
        }
        // changedEventArgs.commons.serverParameters.WarrantySituation = true;
        
    };