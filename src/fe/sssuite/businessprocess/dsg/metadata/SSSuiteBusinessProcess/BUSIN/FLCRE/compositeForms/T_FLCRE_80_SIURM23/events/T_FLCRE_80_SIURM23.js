//"TaskId": "T_FLCRE_80_SIURM23"
	var taskHeader = {};

task.loadTaskHeader=function(entities,eventArgs){
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.LoanHeader;
		var plazo='';	
						
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.Operation==null||originalh.Operation=='null' ? '--':originalh.Operation),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((originalh.ProposedAmount ==null||originalh.ProposedAmount =='null' ? 0:originalh.ProposedAmount ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',plazo,0);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);no existe este campo
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((entities.generalData.officerName!="--")?entities.generalData.officerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);		
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};