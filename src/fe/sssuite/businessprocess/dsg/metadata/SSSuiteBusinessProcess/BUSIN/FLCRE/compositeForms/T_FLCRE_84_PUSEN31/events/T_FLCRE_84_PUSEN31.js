//"TaskId": "T_FLCRE_84_PUSEN31"
    task.EtapaTramite = '';
	//task.ETAPA = '';
	task.MODE = '';
	var taskHeader = {};

/*EVENTOS MANUALES*/

//Funcion que habilita/deshabilita el campo "Descripción Imposibilidad de Pago"
    task.ValidateImpossibilityDescription = function(entities, args){
		if(entities.HeaderPunishment.Trouble == '4'){
		    args.commons.api.viewState.enable('VA_VIEANSHMET7203_EPTI020');
		}else{
		    args.commons.api.viewState.disable('VA_VIEANSHMET7203_EPTI020');
			entities.HeaderPunishment.ImpossibilityDescription = null;
		}
    };
	
	task.loadTaskHeader=function(entities,eventArgs){		
		var client = {};
		var parentParameters = eventArgs.commons.api.parentVc.customDialogParameters;
		if(eventArgs.commons.api.parentVc.model.Task==undefined){
			client.clientName = parentParameters.Task.clientName;
		}else{
			client = eventArgs.commons.api.parentVc.model.Task
		}
			
		var originalh=entities.OriginalHeader;
		
		//Titulo de la cabecera (title)
		BUSIN.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		BUSIN.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.IDRequested==null||originalh.IDRequested=='null' ? '--':originalh.IDRequested),0);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Monto Desembolsado',BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested ==null||originalh.AmountRequested =='null' ? 0:originalh.AmountRequested ),2),0);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Plazo',entities.OriginalHeader.Term,0);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Oficial',((entities.OfficerAnalysis.OfficierName!=null)?entities.OfficerAnalysis.OfficierName.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Fecha Desembolso',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		BUSIN.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		
		BUSIN.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		//Actualizo el grupo de designer
		BUSIN.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
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
				args.commons.api.vc.executeCommand('CM_PUSEN31SAV72','Save', undefined, true, false, 'VC_PUSEN31_TIMNT_481', false);
			}	
		
			args.commons.api.vc.parentVc.labelExecuteCommand2 = "Imprimir";
			args.commons.api.vc.parentVc.executeCommand2 = function(){
				args.commons.api.vc.executeCommand('CM_PUSEN31RIN94','Print', undefined, true, false, 'VC_PUSEN31_TIMNT_481', false);
			}			
		}		
	};
/*FIN EVENTOS MANUALES*/