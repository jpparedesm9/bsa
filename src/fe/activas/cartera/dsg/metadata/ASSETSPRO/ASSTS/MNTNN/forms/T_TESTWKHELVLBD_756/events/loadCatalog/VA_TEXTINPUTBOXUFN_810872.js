//Entity: OtherCharges
    //OtherCharges.concept (ComboBox) View: ProjectOtherCharges
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXUFN_810872 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.api.vc.parentVc.customDialogParameters.entity = loadCatalogEventArgs.commons.api.vc.parentVc.model.Loan;
        loadCatalogEventArgs.commons.execServer = true;        
        //loadCatalogEventArgs.commons.serverParameters.OtherCharges = true;
    };