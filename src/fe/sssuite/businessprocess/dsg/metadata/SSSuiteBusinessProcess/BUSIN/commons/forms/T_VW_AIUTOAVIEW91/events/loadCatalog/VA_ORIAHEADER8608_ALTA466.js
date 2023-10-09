//Entity: Alicuota
    //Alicuota.Alicuota (RadioButtonList) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_ALTA466 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;        
		return [{code:'N-A',value:"No Aplica"},{code:'S',value:"Si"},{code:'N',value:"No"}];
    };