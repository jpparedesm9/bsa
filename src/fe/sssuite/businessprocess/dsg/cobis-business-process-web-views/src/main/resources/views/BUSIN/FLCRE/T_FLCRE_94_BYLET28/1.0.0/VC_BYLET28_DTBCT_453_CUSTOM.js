/*global designerEvents, console */
(function () {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola
    //  console.log("executeCommand");

    //  Para enviar mensaje use
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.plazoFijoPorCliente;	
	var rowIndexTerm=-1;
    var rowIndexAccount=-1;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de cabecera.
    //  task.changeWithError.allGroup = true;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de grilla.
    //  task.changeWithError.allGrid = true;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: CustomerSearch
    //CustomerSearch.Customer (ComboBox) View: fixedTermByClient_View
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_IEDMBENTEW9603_CSER816 = function(entities, changedEventArgs) {
		var data=changedEventArgs.commons.api.vc.customDialogParameters.customerSearch;
        var customerCode= changedEventArgs.newValue;
		for(var i =0; i<data.length;i++){
			if(data[i].Customer.trim()==customerCode.trim()){
				entities.CustomerSearch=data[i];
			}			
		}
		changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.serverParameters.CustomerSearch = true;
        changedEventArgs.commons.serverParameters.WarrantyGeneral = true;
    };
	
	task.changeCallback.VA_IEDMBENTEW9603_CSER816 = function(entities, changedEventArgs) {		
		changedEventArgs.commons.execServer = false;        
    };
    //Entity: CustomerSearch
    //CustomerSearch.Customer (ComboBox) View: fixedTermByClient_View
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
    task.loadCatalog.VA_IEDMBENTEW9603_CSER816 = function(loadCatalogDataEventArgs) {
        var data=loadCatalogDataEventArgs.commons.api.vc.customDialogParameters.customerSearch;
		var customerCatalog=[];
		for(var i =0; i<data.length;i++){
			customerCatalog[i]= {code:data[i].Customer, value:data[i].Customer};
		}		
		loadCatalogDataEventArgs.commons.execServer = false;
		return customerCatalog;
        //loadCatalogDataEventArgs.commons.serverParameters.CustomerSearch = true;
    };
	
	//**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Cancelar (Button) 
    task.executeCommand.CM_BYLET28CAE88 = function(entities, executeCommandEventArgs) {
        var rowFixedTerm;
		rowFixedTerm={code:"",value:""};
   		executeCommandEventArgs.commons.api.vc.closeModal(rowFixedTerm);
		executeCommandEventArgs.commons.execServer = false;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

    //Seleccionar (Button) 
    task.executeCommand.CM_BYLET28LEO66 = function(entities, executeCommandEventArgs) {
        var warrantyType=executeCommandEventArgs.commons.api.vc.customDialogParameters.warrantyType;
        var rowFixedTerm;
        var rowAccount;
        var gridFixedTerm=executeCommandEventArgs.commons.api.vc.grids.QV_FDMYL8126_98;
        var gridAccount=executeCommandEventArgs.commons.api.vc.grids.QV_6427_29743;

        if ("DPF" == warrantyType) {
            if(gridFixedTerm.selectedItem!=null||gridFixedTerm.selectedItem!=undefined){
                rowFixedTerm={code:gridFixedTerm.selectedItem.numBanco,
                        value:gridFixedTerm.selectedItem.numBanco+" - "+entities.CustomerSearch.Customer+" - "+((entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=undefined||entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=null)?entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible:0),
                        amount:((entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=undefined||entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=null)?entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible:0),
                        warrantyType:warrantyType};
                executeCommandEventArgs.commons.api.vc.closeModal(rowFixedTerm);
                executeCommandEventArgs.commons.execServer = false;//true;
            }else{
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_PFJOECARG_00138','',3000,true);
                //executeCommandEventArgs.commons.messageHandler.showMessagesError('Se requiere seleccionar un Plazo Fijo');
                executeCommandEventArgs.commons.execServer = false;
            }
        }
        if ("AHORRO" == warrantyType) {
            if(gridAccount.selectedItem!=null||gridAccount.selectedItem!=undefined){
                rowAccount={code:gridAccount.selectedItem.accountBank,
                        value:gridAccount.selectedItem.accountBank+" - "+entities.CustomerSearch.Customer+" - "+((entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=undefined||entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=null)?entities.AccountInfomation.data()[rowIndexAccount].availableBalance:0),
                        amount:((entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=undefined||entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=null)?entities.AccountInfomation.data()[rowIndexAccount].availableBalance:0),
                        warrantyType:warrantyType};
                executeCommandEventArgs.commons.api.vc.closeModal(rowAccount);
                executeCommandEventArgs.commons.execServer = false;//true;
            }else{
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_PFJOECARG_00138','',3000,true);
                //executeCommandEventArgs.commons.messageHandler.showMessagesError('Se requiere seleccionar una Cuenta de Ahorro');
                executeCommandEventArgs.commons.execServer = false;
            }
        }
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };
	
	task.executeCommandCallback.CM_BYLET28LEO66 = function(entities, args) {
		args.commons.execServer = false;		
	}
	
	 //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //seleccionPoliza QueryView: FixedTermByClient_Grd
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_FDMYL8126_98 = function(entities, gridRowSelectingEventArgs) {
		rowIndexTerm=gridRowSelectingEventArgs.rowIndex;
		console.log("rowIndexTerm"+rowIndexTerm);
        gridRowSelectingEventArgs.commons.execServer = false;
        gridRowSelectingEventArgs.commons.serverParameters.FixedTermOperation = true;
    };
	
	task.gridRowSelectingCallback.QV_FDMYL8126_98 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;	
		rowIndexTerm=gridRowSelectingEventArgs.rowIndex;
		console.log("rowIndexTerm"+rowIndexTerm);		
        // gridRowSelectingEventArgs.commons.serverParameters.FixedTermOperation = true;
    };

	 //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //seleccionCuentas QueryView: AccountByClient_Grd
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_6427_29743 = function(entities, gridRowSelectingEventArgs) {
		rowIndexAccount=gridRowSelectingEventArgs.rowIndex;
		console.log("rowIndexAccount"+rowIndexAccount);
        gridRowSelectingEventArgs.commons.execServer = false;
        gridRowSelectingEventArgs.commons.serverParameters.AccountInformation = true;
    };
	
	task.gridRowSelectingCallback.QV_6427_29743 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;	
		rowIndexAccount=gridRowSelectingEventArgs.rowIndex;
		console.log("rowIndexAccount"+rowIndexAccount);		
        // gridRowSelectingEventArgs.commons.serverParameters.FixedTermOperation = true;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: fixedTermCustVC 
    task.initData.VC_BYLET28_DTBCT_453 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
        // initDataEventArgs.commons.serverParameters.entityName = true;
        var warrantyType=initDataEventArgs.commons.api.vc.customDialogParameters.warrantyType;
        var viewState = initDataEventArgs.commons.api.viewState;
        entities.WarrantyGeneral.currency = initDataEventArgs.commons.api.vc.customDialogParameters.warrantyGeneral.currency;
        if ("AHORRO" == warrantyType) {            
            viewState.hide("GR_IEDMBENTEW96_04");
            viewState.disable("GR_IEDMBENTEW96_04");
            viewState.show("G_FIXEDTEYTE_555W96");
            viewState.enable("G_FIXEDTEYTE_555W96");
        }
        if ("DPF" == warrantyType) {
           viewState.hide("G_FIXEDTEYTE_555W96");
            viewState.disable("G_FIXEDTEYTE_555W96");
            viewState.show("GR_IEDMBENTEW96_04");
            viewState.enable("GR_IEDMBENTEW96_04");            
        }
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: fixedTermCustVC 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;		
    };

}());