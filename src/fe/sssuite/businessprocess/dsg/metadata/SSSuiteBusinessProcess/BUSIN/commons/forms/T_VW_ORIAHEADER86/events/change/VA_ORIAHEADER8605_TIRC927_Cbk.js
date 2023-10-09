	//Start signature to callBack event to VA_ORIAHEADER8605_TIRC927
	task.changeCallback.VA_ORIAHEADER8605_TIRC927 = function(entities, changedEventArgs) {	
		$("#VA_ORIAHEADER8605_SETO998").data("kendoExtComboBox").dataSource.read(); // Sector
																					// del
																					// credito
		$("#VA_ORIAHEADER8605_OCRI261").data("kendoExtComboBox").dataSource.read(); // Destino
																					// Financiero
		$("#VA_ORIAHEADER8602_URQT595").data("kendoExtComboBox").dataSource.read(); // Moneda
																					// Solicitada
		
		// Actrulizo la cabecera con los nuevos campos
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.updateTaskHeader(taskHeader, changedEventArgs, 'GR_WTTTEPRCES08_02');
    };