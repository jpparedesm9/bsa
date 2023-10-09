//Entity: TerminalFiltro
    //TerminalFiltro.filterName (ComboBox) View: TerminalManagementForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_FILTERNAMECVENW_287748 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        var item = changedEventArgs.commons.api.vc.catalogs.VA_FILTERNAMECVENW_287748.data()
            .filter(function(i){ return i.code === changedEventArgs.newValue })[0];
                
        
        changedEventArgs.commons.api.viewState.label("VA_FILTERVALUEKKSF_591748", item.value);
        
    };