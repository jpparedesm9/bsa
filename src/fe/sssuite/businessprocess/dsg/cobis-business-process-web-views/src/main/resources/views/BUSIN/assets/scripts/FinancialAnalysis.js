var FINANCIALANALYSIS = {
	formatPaymentCapacityTable : function(entities, args, comandId){
        var returnValue = false;
        var validationOk = true;
        var grid = args.commons.api.grid;
        var viewState = args.commons.api.viewState;
		var maxCols = 12;//NUMERO DE CUOTAS DISPONIBLE PARA PODER VALIDAR - por ahora es 12

		//OCULTA COLUMNA CON BOTON EDITAR
		BUSIN.API.GRID.hideCommandColumns('QV_PATPC8937_50', entities.PaymentCapacity.data(),args.commons.api,'edit');

		// ERROR = UN ERROR AL BUSCAR LA DATA (se oculta el grid y se des-activa botones)
		if( BUSIN.VALIDATE.IsNullOrEmpty(entities.PaymentCapacityHeader.Status) || entities.PaymentCapacityHeader.Status==='ERROR'){
            viewState.hide('GR_RIOTRDTAVI49_15');
			return FINANCIALANALYSIS.validationNotSuccess(args, comandId);
        }

		//OBTENER VARIABLES
		var mesInicio = entities.PaymentCapacityHeader.StartMonth;
        var payCapList = entities.PaymentCapacity.data();
		//HABILITAR CONTROLES
        viewState.show('GR_RIOTRDTAVI49_15');
		viewState.enable('VA_RIOTRDTAVI4912_MAMU147');

		//FORMATEAR EL TITULO DE LAS COLUMNAS, OCULTARLES Y MOSTRARLES DEPENDIENDO DEL NUMERO DE CUOTAS DISPONIBLES
		var monthList = viewState.translate('BUSIN.DLB_BUSIN_ERAYOTEMI_74588').split(";");
		var yearDate = '';
		if(!BUSIN.VALIDATE.IsNull(entities.LineHeader.EntryDate)){
			yearDate = '-' + entities.LineHeader.EntryDate.getFullYear();
			yearDate = '-' + yearDate.substring(3, 5);
		}
		var startMonth = entities.PaymentCapacityHeader.StartMonth;
		for (var i=1; i<=maxCols; i++){
			if(startMonth==0){ startMonth = 1; }
			var titleColumn = '(' + i + ') / ' + monthList[startMonth-1].substring(0, 3) + yearDate;
			startMonth = startMonth + 1;
			startMonth = startMonth % 13;
			grid.title('QV_PATPC8937_50', 'Balance'+i, titleColumn, false);
		}

		//PONER TEXTO EN LA 1° COLUMNA (SOLO PARA FILAS DE TOTALES)
		if( FINANCIALANALYSIS.hasValidItems(entities) ){
			//SE APLICA ESTE ARTILUJIO YA QUE AL EDITAR SE PERDIA CIERTA DATA CARGADA MEDIANTE js
			//TRUCO - SE CLONA LAS FILAS DE TOTALES
			var rowGrid = payCapList[payCapList.length-5]; //TOTAL SALDO DISPONIBLE MENSUAL
			var rowTSDM = new FINANCIALANALYSIS.getCustomPaymentCapacity(viewState.translate('BUSIN.DLB_BUSIN_TTLODIOBN_38503'),rowGrid);

			rowGrid = payCapList[payCapList.length-4]; //FLUJO DE CAJA ACUMULADO
			var rowFCA = new FINANCIALANALYSIS.getCustomPaymentCapacity(viewState.translate('BUSIN.DLB_BUSIN_UECAJACML_35936'),rowGrid);

			rowGrid = payCapList[payCapList.length-3]; //CUOTA MAXIMA
			var rowCM = new FINANCIALANALYSIS.getCustomPaymentCapacity(viewState.translate('BUSIN.DLB_BUSIN_MAXIMUMQA_70875').toUpperCase(),rowGrid);

			rowGrid = payCapList[payCapList.length-2]; //CUOTA MAXIMA LINEA
			var rowCML = new FINANCIALANALYSIS.getCustomPaymentCapacity(viewState.translate('BUSIN.DLB_BUSIN_MAXUTALNE_73481').toUpperCase(),rowGrid);

			rowGrid = payCapList[payCapList.length-1]; //MARGEN DE AHORRO
			var rowMA = new FINANCIALANALYSIS.getCustomPaymentCapacity(viewState.translate('BUSIN.DLB_BUSIN_ARGENAORR_91629'),rowGrid);

			//TRUCO - SE ELIMINA LAS FILAS DE TOTALES
			for (var i=1; i<=5; i++){
				grid.removeRow('PaymentCapacity', payCapList.length-1);
			}

			//TRUCO - SE INSERTA LAS FILAS CLONADAS DE TOTALES
			grid.addRow('PaymentCapacity', rowTSDM, true);
			grid.addRow('PaymentCapacity', rowFCA, true);
			grid.addRow('PaymentCapacity', rowCM, true);
			grid.addRow('PaymentCapacity', rowCML, true);
			grid.addRow('PaymentCapacity', rowMA, true);
		}
		//OCULTA COLUMNA CON BOTON EDITAR
		BUSIN.API.GRID.hideCommandColumns('QV_PATPC8937_50', entities.PaymentCapacity.data(),args.commons.api,'edit');

		//REALIZA LA VALIDACION DE MONTOS (menores que cero)
		if( FINANCIALANALYSIS.hasValidItems(entities) ){
			var payCapList = entities.PaymentCapacity.data();
			for (var i=1; i<=5; i++){
				grid.addRowStyle('QV_PATPC8937_50',payCapList[payCapList.length-i],'row-mark-style4');
			}
			grid.showGridRowCommand('QV_PATPC8937_50', payCapList[payCapList.length-3], 'edit');//CUOTA MAXIMA
			grid.showGridRowCommand('QV_PATPC8937_50', payCapList[payCapList.length-2], 'edit');//CUOTA MAXIMA LINEA

			var rowGrid = payCapList[payCapList.length-1];
			for (var i=1; i<=maxCols; i++){
				if( BUSIN.VALIDATE.IsNull(rowGrid['Balance'+i]) || (rowGrid['Balance'+i]<0) ){
					grid.addCellStyle('QV_PATPC8937_50', rowGrid, 'Balance'+i, 'row-mark-style5');
					validationOk = false;
				} else {
					grid.removeCellStyle('QV_PATPC8937_50', rowGrid, 'Balance'+i, 'row-mark-style5');
				}
			}
		}

		//LA VALIDACION 'NO' FUE EXITOSA
		if(!validationOk || (entities.PaymentCapacityHeader.ValidationSuccess!==true)){
			return FINANCIALANALYSIS.validationNotSuccess(args, comandId);
		}

        return true;
    },
	validationNotSuccess : function(args, comandId){
		BUSIN.INBOX.STATUS.nextStep(false,args.commons.api);
		if(!BUSIN.VALIDATE.IsNullOrEmpty(comandId)){
			args.commons.api.viewState.disable(comandId);
		}
		return false;
	},
	hasValidItems : function(entities){
		var payCapList = entities.PaymentCapacity.data();
		return ( (payCapList.length>5) && (payCapList[payCapList.length-1].CustomerID===-5) );
	},
	isItemsFull : function(entities,args,showMessage){
		if( FINANCIALANALYSIS.hasValidItems(entities) ){
			var payCapList = entities.PaymentCapacity.data();
			var rgCM = payCapList[payCapList.length-3]; //CUOTA MAXIMA
			if( !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance1,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance2,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance3,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance4,args,false,false) ||
				!BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance5,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance6,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance7,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance8,args,false,false) ||
				!BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance9,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance10,args,false,false)|| !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance11,args,false,false)|| !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCM.Balance12,args,false,false)
			){
				args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_DGLAEPASL_46520');
				return false;
			}
			var rgCML = payCapList[payCapList.length-2]; //CUOTA MAXIMA LINEA
			if( !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance1,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance2,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance3,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance4,args,false,false) ||
				!BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance5,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance6,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance7,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance8,args,false,false) ||
				!BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance9,args,false,false) || !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance10,args,false,false)|| !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance11,args,false,false)|| !BUSIN.VALIDATE.IsGreaterOrEqualThanZero(rgCML.Balance12,args,false,false)
			){
				args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_INRSTOMEA_69572');
				return false;
			}
			return true;
		}
		return false;
	},
	getCustomPaymentCapacity : function(customerName, row){
		this.CustomerID =   row.CustomerID;
		this.CustomerName = customerName;
		this.MonthAverage = row.MonthAverage;
		this.TotalAnnual =  row.TotalAnnual;
		this.Balance1 =  row.Balance1;
		this.Balance2 =  row.Balance2;
		this.Balance3 =  row.Balance3;
		this.Balance4 =  row.Balance4;
		this.Balance5 =  row.Balance5;
		this.Balance6 =  row.Balance6;
		this.Balance7 =  row.Balance7;
		this.Balance8 =  row.Balance8;
		this.Balance9 =  row.Balance9;
		this.Balance10 = row.Balance10;
		this.Balance11 = row.Balance11;
		this.Balance12 = row.Balance12;
	}

};

document.write('<script src="${contextPath}/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');