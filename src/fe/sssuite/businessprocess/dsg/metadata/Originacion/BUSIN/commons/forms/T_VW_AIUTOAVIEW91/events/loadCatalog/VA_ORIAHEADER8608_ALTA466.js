//Entity: Alicuota
    //Alicuota.Alicuota (RadioButtonList) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_ALTA466 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = false;        
		return [{code:'N-A',value:"No Aplica"},{code:'S',value:"Si"},{code:'N',value:"No"}];
        
    };