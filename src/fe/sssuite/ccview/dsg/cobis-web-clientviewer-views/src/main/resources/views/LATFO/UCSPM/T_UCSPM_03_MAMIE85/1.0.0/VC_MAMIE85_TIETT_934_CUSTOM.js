<!-- Designer Generator v 5.0.0.1517 - release SPR 2015-16 04/09/2015 -->
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
	var params = null;
	var findProgramType = "";

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: DTOS
    //DTOS.serviceId (TextInputButton) View: DTOMaintaining
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_PROPIDADES7905_IDFK413 = function(textInputButtonEventArgs) {
		textInputButtonEventArgs.commons.execServer = false;
		findProgramType = "service";
		openFindProgram(textInputButtonEventArgs, "pseudoCatalogo", null,"sp_seudo_catalogo_services","LATFO.DLB_LATFO_SERVICIOS_69111");
		
    };

    //Entity: DTOS
    //DTOS.parent (TextInputButton) View: DTOMaintaining
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_PROPIDADES7905_DAET661 = function(textInputButtonEventArgs) {
		textInputButtonEventArgs.commons.execServer = false;
		findProgramType = "dto";
		openFindProgram(textInputButtonEventArgs, "pseudoCatalogo", null,"sp_seudo_catalogo_parent_name","LATFO.DLB_LATFO_PADREIJPJ_49941");
        
		
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Aceptar (Button) 
    task.executeCommand.CM_MAMIE85CET66 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };

    //Cancelar (Button) 
    task.executeCommand.CM_MAMIE85CLR24 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos de QUERY
    //**********************************************************    
    //Detalle de Propiedades  Entity: VccProperties 
    task.executeQuery.Q_CPROPRES_6239 = function(executeQueryEventArgs) {
        executeQueryEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //Eliminar QueryView: Detalle de Propiedades
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos. 
    task.gridRowDeleting.QV_CPROP6239_58 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = true;
    };

    //Seleccionar QueryView: Detalle de Propiedades
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_CPROP6239_58 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: DTO Maintaining 
    task.initData.VC_MAMIE85_TIETT_934 = function(entities, initDataEventArgs) {
		 params = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();		
		 entities.DTOS.dtoId = params.idDTO;
         initDataEventArgs.commons.execServer = true;
    };
	
	task.initDataCallback.VC_MAMIE85_TIETT_934 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.execServer = false;
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: DTO Maintaining 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
    };
	
	//task.beforeOpenGridDialog.VC_MAMIE85_TIETT_934 = function(entities, initDataEventArgs) {
		//initDataEventArgs.commons.execServer = false;
    //};

	//Función para llamar al Programa (SP)
	function openFindProgram(args, typeTextButton, tableParameter,storeProcedureParameter, labelTitle) {
		
		args.commons.api.vc.removeChildVc('findProgram');
		
		var nav = args.commons.api.navigation;
		nav.label = cobis.translate(labelTitle);
		
		nav.customAddress = {
			id : "findProgram",
			url : "businessrules/templates/find-program-tpl.html"
		};
		
		nav.modalProperties = {
			size : 'md'
    };

		nav.scripts = [ {
			module : cobis.modules.BUSINESSRULES,
			files : [ "/businessrules/services/business-rules-viewer-srv.js",
					"/businessrules/services/find-program-srv.js",
					"/businessrules/controllers/find-program-ctrl.js" ]
		} ];
		
		if (tableParameter == null) {
            if(typeTextButton === "catalogRule"){
                nav.customDialogParameters = {
                    callId : typeTextButton,
                    table : tableParameter,
                    storeProcedure : storeProcedureParameter,
                    subTypeRule : null,
                    productProcess: productProcessRules
                };
            }else{
                nav.customDialogParameters = {
                    callId : typeTextButton,
                    table : tableParameter,
                    storeProcedure : storeProcedureParameter,
                    subTypeRule : null
    };
            }
		} else {
			nav.customDialogParameters = {
				callId : typeTextButton,
				mode : 1,
				businessId : 1
    };
		}

	};
	
	task.closeModalEvent.findProgram = function(args) {
		var resp = args.commons.api.vc.customDialogResponse;
		if (findProgramType == "dto" ){
			args.model.DTOS.parent = resp.code;
			args.model.DTOS.parentName = resp.value;
		} else if (findProgramType == "service"){
			args.model.DTOS.serIdFk = resp.code;
		}
	};
	

}());