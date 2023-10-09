<!-- Designer Generator v 5.0.0.1515 - release SPR 2015-15 07/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validaciÃ³n a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.tasksectionsmaintaining;
	var sons = [];
    var parameters =null;
	var order = null;
	var parentTree = null;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: SectionsMaintaining
    //SectionsMaintaining.prdTypeClient (ComboBox) View: SectionsMaintaining
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catÃ¡logo. 
    task.loadCatalog.VA_CTNSMATINN6904_DPLT912 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
		var catalog = [];
		catalog.push({code : null, value:"Productos"});
		catalog.push({code :"P", value:"Persona Natural"});
		catalog.push({code :"C", value:"Persona Jur\u00eddica"});
		catalog.push({code :"G", value:"Grupo Econ\u00f3mico"});
		return catalog;
    };

    //Entity: SectionsMaintaining
    //SectionsMaintaining.prdParent (TextInputButton) View: SectionsMaintaining
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_CTNSMATINN6904_RARE854 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
    };

    //Entity: SectionsMaintaining
    //SectionsMaintaining.dtoIdFk (TextInputButton) View: SectionsMaintaining
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_CTNSMATINN6904_DOIF418 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
		openFindProgram(textInputButtonEventArgs, "pseudoCatalogo", null,"sp_seudo_catalogo_dtos","LATFO.DLB_LATFO_DTOKSHLDQ_70777");
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //BtnAccept (Button) 
    task.executeCommand.CM_RMOCN27BTA76 = function(entities, executeCommandEventArgs) {
		var execute = true;
		var validate = true;
		
		if(order==null){
			validate =true;
		}
		else{
			if(order == entities.SectionsMaintaining.prdOrder){
				validate = false;
			}
			else{
				validate = true;
			}
		}
		for(var i = 0; i<sons.length; i++){
			
			if(sons[i].order == entities.SectionsMaintaining.prdOrder && validate){
				execute = false;
				executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError("COMMONS.MESSAGES.MSG_ORDER_SECTION_ERROR");
			}
		}
        
		executeCommandEventArgs.commons.execServer = execute;
    };
    
    task.executeCommandCallback.CM_RMOCN27BTA76 = function(entities, executeCommandEventArgs) {
    	order = entities.SectionsMaintaining.prdOrder;		
		var item = {
                    id: entities.SectionsMaintaining.prdId,
                    idparent: entities.SectionsMaintaining.prdParent,
                    nameParent: entities.SectionsMaintaining.prdParentDesc,
                    name: entities.SectionsMaintaining.prdName,
                    text: entities.SectionsMaintaining.prdName,
                    type: entities.SectionsMaintaining.prdTypeClient,
					order: entities.SectionsMaintaining.prdOrder,
                    menuType: parentTree,//'itemCustomerType',//se toma el dato del primer hijo, ya que seria el mismo dato para la opcion seleccionada
                    spriteCssClass: "fa fa-calendar-o nodecalendar"
            };
    	if (parameters.action!="updateSection") {
            parameters.addNode(item);
		}else {
			parameters.updateNode(item);
		}
		
		for(var i = 0; i<sons.length; i++){
			if(sons.id==item.id){
				sons[i]= item;
			}
		}
		
        executeCommandEventArgs.commons.execServer = false;
    };
	
	//BtnDecline (Button) 
    task.executeCommand.CM_RMOCN27TCL40 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: InicializaciÃ³n de datos del formulario, despuÃ©s de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: FormTaskSectionsMaintaining 
    task.initData.VC_RMOCN27_NECIN_829 = function(entities, initDataEventArgs) {
		order = null;
	    parameters  = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();	
		sons = parameters.sons;
		if(sons[0] != null && sons[0]!= undefined){
			parentTree = sons[0].menuType;
		}
		initDataEventArgs.commons.api.viewState.disable('VA_CTNSMATINN6904_RARE854');
		initDataEventArgs.commons.api.viewState.disable('VA_CTNSMATINN6904_DPLT912');

		if(parameters.action=="newParentSection"){	
			entities.SectionsMaintaining.prdId=0;		
			entities.SectionsMaintaining.prdParent=parameters.idSection;
			entities.SectionsMaintaining.prdParentDesc=parameters.name;
			entities.SectionsMaintaining.prdTypeClient=parameters.type=="P"?"P":parameters.type=="G"?"G":parameters.type=="C"?"C":null;
			initDataEventArgs.commons.execServer = false;
			
		}
		else if(parameters.action=="newSection") {
			entities.SectionsMaintaining.prdId=0;	
			entities.SectionsMaintaining.prdParent=parameters.idSection;
			entities.SectionsMaintaining.prdParentDesc=parameters.nameParent;
			entities.SectionsMaintaining.prdTypeClient=parameters.type=="P"?"P":parameters.type=="G"?"G":parameters.type=="C"?"C":null;
			initDataEventArgs.commons.execServer = false;
			
		} else if(parameters.action=="updateSection") {
			entities.SectionsMaintaining.prdId=parameters.idSection;
			initDataEventArgs.commons.execServer = true;
		}
    };
    
    task.initDataCallback.VC_RMOCN27_NECIN_829 = function(entities, initDataEventArgs) {
    	if(parameters.action=="updateSection") {
			entities.SectionsMaintaining.prdParentDesc=parameters.nameParent;
			order = entities.SectionsMaintaining.prdOrder;
		}
    	initDataEventArgs.commons.execServer = false;
    }
	
	//FunciÃ³n para llamar al Programa (SP)
	function openFindProgram(args, typeTextButton, tableParameter,storeProcedureParameter, labelTitle) {
		
		args.commons.api.vc.removeChildVc('findProgram');
		
		var nav = args.commons.api.navigation;
		nav.label = cobis.translate(labelTitle);
		
		nav.customAddress = {
			id : "findProgram",
			url : "businessrules/templates/find-program-tpl.html",
			useMinification: false
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
		args.commons.api.vc.removeChildVc('findProgram');

	};
	
	task.closeModalEvent.findProgram = function(args) {
		var resp = args.commons.api.vc.customDialogResponse;
		args.model.SectionsMaintaining.dtoIdFk=resp.code;
		args.model.SectionsMaintaining.dtoIdFkDesc=resp.value;
	};
	
}());