//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: RegularizeDispersionsRejectedForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        var resp = onCloseModalEventArgs.commons.api.vc.dialogParameters;
        var customerCode = resp.CodeReceive;
        var CustomerName = resp.name;
		var customerType = resp.customerType;	
		var title = '';
		switch (customerType) {
		case 'P':
			title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
			isGroup = 'N';
			break;
		case 'C':
			title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
			isGroup = 'N';
			break;
		case 'S':
			title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
			isGroup = 'S';
			break;
		case 'G':
			title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
			isGroup = 'S';
			break;
		}
		
        entities.SearchRejectedDispersions.customerCode = customerCode;
		onCloseModalEventArgs.commons.api.viewState.label("VA_CUSTOMERCODEOES_830759",title);
    };