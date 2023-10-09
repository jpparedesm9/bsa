//Start signature to callBack event to VC_EYWRY63_FMRRT_302
    task.initDataCallback.VC_EYWRY63_FMRRT_302 = function(entities, initDataEventArgs) {
        if(entities.OriginalHeader.TypeRequest == FLCRE.CONSTANTS.Tramite.Refinanciamiento){ //CUANDO ES REFINANCIAMIENTO
			BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
		}		
		task.loadTaskHeader(entities,initDataEventArgs);
    };

task.loadTaskHeader=function(entities,eventArgs){
		
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.OriginalHeader;
		
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.IDRequested==null||originalh.IDRequested=='null' ? '--':originalh.IDRequested),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested ==null||originalh.AmountRequested =='null' ? 0:originalh.AmountRequested ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda','USD',0);//tomar el campo de moneda(codigo??)
		LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',originalh.Term,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((originalh.OfficerName!=null)?originalh.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);
		
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};