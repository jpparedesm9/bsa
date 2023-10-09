//Entity: Alicuota
    //Alicuota.AlicuotaCertificada (ComboBox) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_CCAA829 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;//SMO no se usa en grupales
       /* loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.Alicuota = true;*/
    };