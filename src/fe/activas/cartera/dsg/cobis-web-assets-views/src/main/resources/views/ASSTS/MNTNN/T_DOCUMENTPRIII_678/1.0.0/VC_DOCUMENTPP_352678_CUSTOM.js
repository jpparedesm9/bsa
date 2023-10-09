/* variables locales de T_DOCUMENTPRIII_678*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

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

    
        var task = designerEvents.api.documentprinting;
    

    //"TaskId": "T_DOCUMENTPRIII_678"



    // (Button) 
    task.executeCommand.CM_TDOCUMEN_OTS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
		
		var dataGrid = entities.PrintingDocuments.data();
		var code = "";
		var itemReporte = "";
		var reportTitle = "";
		for (var i=0; i<dataGrid.length; i++)
		{
		if (dataGrid[i].item === true)
			code = dataGrid[i].codigo
		}
		
		switch (code)
			{
			case 1:
				itemReporte = "Liquidation";
				reportTitle = "LIQUIDACI\u00d3N - DESEMBOLSO PARCIAL";
				break;
			case 2:
				itemReporte = "ReceiptPayment";
				reportTitle = "RECIBO DE PAGO";
				break;
			case 3: 
				itemReporte = "PaymentTable";
				reportTitle = "TABLA DE AMORTIZACI\u00d3N";
				break;
			case 4:
				itemReporte = "PromissoryNote";
				reportTitle = "PAGAR\u00c9 A LA ORDEN";
				break;
			case 5:
				itemReporte = "CreditAgreement";
				reportTitle = "CONTRATO DE APERTURA DE CR\u00c9DITO";
				break;
			default: 
				break;
				//alert('Default case');
			}
		
		var args = [['numOperation', entities.LoanPrinting.loanPrinting]];
		//var itemReporte = 'ReciboDePago';
		ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
    };

task.gridInitColumnTemplate.QV_3105_20065 = function (idColumn) {
    if (idColumn === 'item') {
        return "<span><input type=\'checkbox\' #if (item === true) {# checked #}# ng-click=\"vc.grids.QV_3105_20065.events.customRowClick($event, \'VA_VDATOSALUD3211_SEOA837\', \'PrintingDocuments\', \'QV_3105_20065\')\"/></span>";
    }
};

task.gridInitEditColumnTemplate.QV_3105_20065 = function (idColumn) {
    if (idColumn === 'item') {
        return "<span><input type=\'checkbox\' #if (item === true) {# checked #}# ng-click=\"vc.grids.QV_3105_20065.events.customRowClick($event, \'VA_VDATOSALUD3211_SEOA837\', \'PrintingDocuments\', \'QV_3105_20065\')\"/></span>";
    }
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DocumentPrinting
    task.initData.VC_DOCUMENTPP_352678 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var commons = initDataEventArgs.commons;
        var api=initDataEventArgs.commons.api;
        var parameters=api.navigation.getCustomDialogParameters();        
        entities.LoanInstancia = parameters.parameters.loanInstancia;
        commons.execServer = true;
		//entities.LoanPrinting.loanPrinting = "100010000022";
        var Documents = [];
        Documents[0] = new Print();
           Documents[0].codigo = 1;
           Documents[0].documentos = 'LIQUIDACION - DESEMBOLSO PARCIAL';
           Documents[0].item = false;

           Documents[1] = new Print();
           Documents[1].codigo = 2;
           Documents[1].documentos = 'RECIBO DE PAGO';
           Documents[1].item = false;

           Documents[2] = new Print();
           Documents[2].codigo = 3;
           Documents[2].documentos = 'TABLA DE AMORTIZACION';
           Documents[2].item = false;
		   
		   Documents[3] = new Print();
           Documents[3].codigo = 4;
           Documents[3].documentos = 'PAGARE';
           Documents[3].item = false;
		   
		   Documents[4] = new Print();
           Documents[4].codigo = 5;
           Documents[4].documentos = 'CONTRATO DE APERTURA DE CREDITO';
           Documents[4].item = false;

           initDataEventArgs.commons.api.grid.addAllRows('PrintingDocuments',Documents);
    };

//gridRowSelecting QueryView: QV_3105_20065
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_3105_20065 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };



}));