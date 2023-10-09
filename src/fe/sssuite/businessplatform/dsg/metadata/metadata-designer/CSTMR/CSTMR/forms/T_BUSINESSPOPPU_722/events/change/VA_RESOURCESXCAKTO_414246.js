//Entity: Business
    //Business.resources (ComboBox) View: BusinessPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_RESOURCESXCAKTO_414246 = function(  entities, changedEventArgs ) {
        if(changedEventArgs.newValue == 'OT'){
            changedEventArgs.commons.api.viewState.enable('VA_WHICHRESOURCEEE_338246');
        } else {
            changedEventArgs.commons.api.viewState.disable('VA_WHICHRESOURCEEE_338246');
            entities.Business.whichResource = null;
        }
        changedEventArgs.commons.execServer = false;
    
        
    };