//Entity: WarrantySituation
    //WarrantySituation.suitable (RadioButtonList) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0714_SUIE758 = function(loadCatalogEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
        return [{
            code: 'S',
            value: "Si"
        }, {
            code: 'N',
            value: "No"
        }, {
            code: 'O',
            value: "No Aplica"
        }];
        //loadCatalogEventArgs.commons.execServer = false;
    };