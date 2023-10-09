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

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************

    var task = designerEvents.api.rejectedapplication;

//"TaskId": "T_FLCRE_01_EJTDI03"
    var taskHeader = {};

    task.loadTaskHeader=function(entities,eventArgs){
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.OriginalHeader;
		var plazo='0';		

		if(originalh.Term==null||originalh.Term==undefined){
			entities.OriginalHeader.Term=0;
			plazo='0';
		}else{
			//entities.OriginalHeader.Term=entities.OfficerAnalysis.Term;
			plazo=entities.OriginalHeader.Term;
		}

		
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.IDRequested==null||originalh.IDRequested=='null' ? '--':originalh.IDRequested),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested ==null||originalh.AmountRequested =='null' ? 0:originalh.AmountRequested ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',plazo+' '+entities.generalData.paymentFrecuencyName,0);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((originalh.OfficierName!=null)?originalh.OfficierName.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};
	
		task.showButtons = function(args){
		var api = args.commons.api;
		var parentParameters = args.commons.api.parentVc.customDialogParameters;
		//Boton Principal (Wizard)
		//initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
		//	initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
		//}
		
		//Boton Secundario 1 (Wizard)
		//(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
		//(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
		//(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
		//(Tiene una limitacion de 5 axecute commands)
		
		if(parentParameters.Task.urlParams.Modo!= undefined&&parentParameters.Task.urlParams.Modo!=null
		&&parentParameters.Task.urlParams.Modo==FLCRE.CONSTANTS.Mode.Query){
			args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}else{
			args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar";
			args.commons.api.vc.parentVc.executeCommand1 = function(){
				args.commons.api.vc.executeCommand('CM_EJTDI03AVE03','Save', undefined, true, false, 'VC_EJTDI03_RCTER_783', false);
			}	
		}		
	};

	// (Button) 
    task.executeCommand.CM_EJTDI03AVE03 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
    };

	//Start signature to callBack event to CM_EJTDI03AVE03
    task.executeCommandCallback.CM_EJTDI03AVE03 = function(entities, executeCommandCallbackEventArgs) {
        //here your code
		
		//Habilito el boton de acciones del contenedor inbox
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		
		executeCommandCallbackEventArgs.commons.execServer = false;     
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RejectedApplication
    task.initData.VC_EJTDI03_RCTER_783 = function (entities, initDataEventArgs){
		FLCRE.UTILS.APPLICATION.setContext(entities,initDataEventArgs,true,false);
		
		var viewState = initDataEventArgs.commons.api.viewState;
		var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		var parentParameters = initDataEventArgs.commons.api.parentVc.model; //OGU
		entities.OriginalHeader.UserL=userL;
		
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.paymentFrecuencyName = "";
		entities.generalData.sector	= "";
		entities.generalData.destinoFinanciero = "";
		entities.generalData.destinoEconomico = "";
		entities.generalData.oficina = "";
		
		
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;	
		entities.OriginalHeader.ActivityNumber = parentParameters.Task.taskInstanceIdentifier;
		var client = initDataEventArgs.commons.api.parentVc.model.Task;		
	
	
	
        initDataEventArgs.commons.execServer = true;
        // initDataEventArgs.commons.serverParameters.entityName = true;
		//task.loadTaskHeader(entities,initDataEventArgs);
        
    };

	//Start signature to callBack event to VC_EJTDI03_RCTER_783
    task.initDataCallback.VC_EJTDI03_RCTER_783 = function(entities, initDataEventArgs) {
        //here your code
        initDataEventArgs.commons.execServer = false;   		
   	    task.loadTaskHeader(entities,initDataEventArgs);            
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: RejectedApplication

    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        task.showButtons(renderEventArgs);
    };

	//gridBeforeEnterInLineRow QueryView: Borrowers
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function (entities, gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            
        };

	//beforeOpenGridDialog QueryView: Borrowers
        //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente.
        task.beforeOpenGridDialog.QV_BOREG0798_55 = function (entities, beforeOpenGridDialogEventArgs) {
            beforeOpenGridDialogEventArgs.commons.execServer = false;
            
        };

	//gridCommand (Button) QueryView: Borrowers
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DebtorGeneral = true;
    };

	//gridRowInserting QueryView: Borrowers
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_BOREG0798_55 = function (entities, gridRowInsertingEventArgs) {
            gridRowInsertingEventArgs.commons.execServer = false;
            
        };

	//gridRowSelecting QueryView: Borrowers
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_BOREG0798_55 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };


}());