<!-- Designer Generator v 5.0.0.1518 - release SPR 2015-16 18/09/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskdtomaintaining;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: VccProperties
    //VccProperties.style (ComboBox) View: PropertyMaintaining
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_OPRTMINNNG8804_PRTE227 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
		var filter = loadCatalogDataEventArgs.filters[0];		
		var resultado = new function(){
			function propertiesDTO() {
					this.code = "";
					this.value = "";
				}
				return propertiesDTO;
		}

		var valores = [];
		
		
		if (filter =="BUTTON"){//toma el code del padre para la condicion
			VA_OPRTMINNNG8804_PRTE227.disabled=true;

		}else if(filter=="LABEL"){//toma el code del padre para la condicion

			valores[0] = new resultado();
			valores[0].code = "text-align: left";
			valores[0].value = "ALINEADO A LA IZQUIERDA";

			valores[1] = new resultado();
			valores[1].code = "text-align: right";
			valores[1].value = "ALINEADO A LA DERECHA";
			
			valores[2] = new resultado();
			valores[2].code = "text-align: center";
			valores[2].value = "ALINEADO AL CENTRO";
		}

		return valores;
    };

    //Entity: VccProperties
    //VccProperties.type (ComboBox) View: PropertyMaintaining
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_OPRTMINNNG8804_RTYE931 = function(loadCatalogDataEventArgs) {
       loadCatalogDataEventArgs.commons.execServer = false;
			console.log("----------------entro");
		
		var resultado = new function(){
			function propertiesDTO() {
					this.code = "";
					this.value = "";
				}
				return propertiesDTO;
		}

		var valores = [];

		valores[0] = new resultado();
		valores[0].code = "BUTTON";
		valores[0].value = "BUTTON";

		valores[1] = new resultado();
		valores[1].code = "LABEL";
		valores[1].value = "LABEL";

		return valores;
    };

    //Entity: VccProperties
    //VccProperties.format (ComboBox) View: PropertyMaintaining
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_OPRTMINNNG8804_PORM136 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
		var filter = loadCatalogDataEventArgs.filters[0];
		console.log("filter pais: " + filter);
		var resultado = new function(){
			function ItemDTO() {
				this.code = "";
				this.value = "";
			}
			return ItemDTO;
		}
		var valores = [];
		if (filter =="BUTTON"){//toma el code del padre para la condicion
			valores[0] = new resultado();
			valores[0].code = "glyphicon glyphicon-search";
			valores[0].value = "IMAGEN";

		}else if(filter=="LABEL"){//toma el code del padre para la condicion
			valores[0] = new resultado();
			valores[0].code = "{0}";
			valores[0].value = "CADENA DE CARACTERES";

			valores[1] = new resultado();
			valores[1].code = "{0:n}";
			valores[1].value = "DECIMAL";

			valores[2] = new resultado();
			valores[2].code = "{0:dd-MMM-yyyy}";
			valores[2].value = "FECHA";

			valores[3] = new resultado();
			valores[3].code = "{0:c}";
			valores[3].value = "MONEDA";
			
			valores[4] = new resultado();
			valores[4].code = "{0:p}";
			valores[4].value = "PORCENTAJE";
		}
		return valores;
		    
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Aceptar (Button) 
    task.executeCommand.CM_MAMIE85CET66 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

    //Cancelar (Button) 
    task.executeCommand.CM_MAMIE85CLR24 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: PropertyMaintaining 
    task.initData.VC_MAMIE85_ETMAN_558 = function(entities, initDataEventArgs) {
        // initDataEventArgs.commons.execServer = false;
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: PropertyMaintaining 
    task.render = function(entities, renderEventArgs) {
        // renderEventArgs.commons.execServer = false;
    };

}());