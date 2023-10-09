//"TaskId": "T_FLCRE_76_SDEEF25"
task.EtapaTramite = '';
task.Etapa = '';
var taskHeader = {};
var typeRequest = '';

task.hideModeQuery = function(args) {
		
		//Variables
		var api = args.commons.api;
		var detailLiquidateValuesDs = api.vc.model['DisbursementDetail'].data();

		//Deshabilito los botones
		args.commons.api.grid.hideToolBarButton('QV_TSRSE1342_26', 'CEQV_201_QV_TSRSE1342_26_253');
		BUSIN.API.GRID.hideCommandColumns('QV_TSRSE1342_26',detailLiquidateValuesDs,api,'delete');
		
		//Set del campo HiddenInCompleted para poder continuar la tarea
		args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			
	};

task.loadTaskHeader=function(entities,eventArgs){
		
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh = entities.LoanHeader;
        var contextAux = entities.Context;

		//Titulo de la cabecera (title)
		if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
			LATFO.INBOX.addTaskHeader(taskHeader,'title', client.clientId +" - "+ client.clientName);
		}else{
			LATFO.INBOX.addTaskHeader(taskHeader,'title', client.clientName);		
		}
    
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.Operation==null||originalh.Operation=='null' ? '--':originalh.Operation),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		
		if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
			LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((contextAux.amountRequested == null|| contextAux.amountRequested == 'null' ? 0 : contextAux.amountRequested), 2), 0);
		}else{
			LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null|| originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);  
		}
		LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', BUSIN.CONVERT.CURRENCY.Format((originalh.ProposedAmount == null|| originalh.ProposedAmount == 'null' ? 0 : originalh.ProposedAmount), 2), 0);
    	LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',entities.generalData.Term,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((entities.generalData.officerName!="--")?entities.generalData.officerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		

    	if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
           LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', contextAux.cycleNumber, 1);
        }
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};
