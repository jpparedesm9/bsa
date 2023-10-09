//Entity: WarrantySituation
    //WarrantySituation.legalSufficiency (RadioButtonList) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    //Radio button SuficienciaLegal
    task.loadCatalog.VA_ARANSCATIO0714_ELCY714 = function(loadCatalogDataEventArgs ) {
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
    };