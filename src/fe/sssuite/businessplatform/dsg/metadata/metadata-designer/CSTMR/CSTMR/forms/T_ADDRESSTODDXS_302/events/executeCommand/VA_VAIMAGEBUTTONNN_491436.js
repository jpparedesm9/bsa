//Abre un modal con una página personalizada para pintar un mapa de google
    task.executeCommand.VA_VAIMAGEBUTTONNN_491436 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        var nav = executeCommandEventArgs.commons.api.navigation;
        var catalogs=executeCommandEventArgs.commons.api.vc.catalogs;
        
        //TODO: activar este botón solo cuando se haya seleccionado los obligatorios
        entities.PhysicalAddress.countryDescription=task.findValueInCatalog(entities.PhysicalAddress.countryCode,
                            catalogs.VA_TEXTINPUTBOXOJR_474436.data());
        entities.PhysicalAddress.provinceDescription=task.findValueInCatalog(entities.PhysicalAddress.provinceCode,
                            catalogs.VA_TEXTINPUTBOXTCU_205436.data());
        entities.PhysicalAddress.cityDescription=task.findValueInCatalog(entities.PhysicalAddress.cityCode,
                            catalogs.VA_TEXTINPUTBOXQVZ_987436.data());
        entities.PhysicalAddress.parishDescription=task.findValueInCatalog(entities.PhysicalAddress.parishCode,
                            catalogs.VA_TEXTINPUTBOXPPK_701436.data());
        entities.PhysicalAddress.addressTypeDescription=task.findValueInCatalog(entities.PhysicalAddress.addressTypeDescription,
                            catalogs.VA_TEXTINPUTBOXHGW_672436.data());
        
        //TODO: internacionalizacion
        nav.label = 'UBICACI&OacuteN';
        nav.customAddress = {
            //ESTE ID ES IMPORTANTE PARA PODER ACCEDER AL OBJETO nav DESDE LA PAGINA PERSONALIZADA
            id: "MapView",
            url: "maps/map.html",
            controller: "MapsController"
        };
        //TODO: ubicacion del archivo
        nav.scripts = [{module:"MapModule",files:["maps/map.js"]}];
        nav.modalProperties = {
         height: 500,
         callFromGrid: false
        };
        nav.queryParameters = {
            mode: 2
        };
        //PASO DE PARAMETROS A LA PAGINA PERSONALIZADA
        nav.customDialogParameters = {
            searchData:{
                country: entities.PhysicalAddress.countryDescription!=null?entities.PhysicalAddress.countryDescription:"",
                province: entities.PhysicalAddress.provinceDescription!=null?entities.PhysicalAddress.provinceDescription:"",
                city: entities.PhysicalAddress.cityDescription!=null?entities.PhysicalAddress.cityDescription:"",
				neighborhood:entities.PhysicalAddress.neighborhood!=null?entities.PhysicalAddress.neighborhood:"",
                street:entities.PhysicalAddress.street!=null?entities.PhysicalAddress.street:"",
                reference:entities.PhysicalAddress.reference!=null?entities.PhysicalAddress.reference:"",
                latitude:entities.PhysicalAddress.latitude!=null?entities.PhysicalAddress.latitude:"",
				longitude:entities.PhysicalAddress.longitude!=null?entities.PhysicalAddress.longitude:""
            }
        };
		executeCommandEventArgs.commons.api.vc.closeDialog("MapView");
        executeCommandEventArgs.commons.api.navigation.openCustomModalWindow(executeCommandEventArgs.commons.controlId, null);  
    };