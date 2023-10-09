//Entity: WarrantySituation
    //WarrantySituation.classWarranty (RadioButtonList) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    //Radio button Clase
    task.loadCatalog.VA_ARANSCATIO0714_CLAS015 = function(loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
        return [{
            code: 'A',
            value: "Abierta"
        }, {
            code: 'C',
            value: "Cerrada"
        }];
    };