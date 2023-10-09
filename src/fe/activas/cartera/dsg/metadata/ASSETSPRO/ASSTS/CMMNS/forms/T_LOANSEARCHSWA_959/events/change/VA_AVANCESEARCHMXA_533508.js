//Entity: LoanSearchFilter
    //LoanSearchFilter.avanceSearch (CheckBox) View: LoanSearchForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AVANCESEARCHMXA_533508 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var api = changeEventArgs.commons.api;
    api.vc.viewState.VA_CODCURRENCYKYKA_122508.visible = changeEventArgs.newValue;
    api.vc.viewState.VA_DISBURSEMENTDTD_602508.visible = changeEventArgs.newValue;
    api.vc.viewState.VA_STATUSRUGGOTSMF_965508.visible = changeEventArgs.newValue;
    api.vc.viewState.VA_MIGRATEDOPERFRB_417508.visible = changeEventArgs.newValue;
        
    };