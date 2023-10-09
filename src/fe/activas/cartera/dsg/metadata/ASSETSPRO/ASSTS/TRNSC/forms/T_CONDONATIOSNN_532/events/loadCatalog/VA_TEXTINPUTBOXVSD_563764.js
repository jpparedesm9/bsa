//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: CondonationDetailForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXVSD_563764 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        var model=loadCatalogEventArgs.commons.api.vc.model;
        model.ServerParameter.loanBankID = loadCatalogEventArgs.commons.api.navigation.getCustomDialogParameters().bankNum;
        loadCatalogEventArgs.commons.serverParameters.ServerParameter = true;
        //loadCatalogEventArgs.commons.serverParameters.CondonationDetail = true;
    };