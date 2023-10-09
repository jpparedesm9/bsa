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
        
           Documents[5] = new Print();
           Documents[5].codigo = 6;
           Documents[5].documentos = 'FICHA DE PAGO LCR';
           Documents[5].item = false;

           initDataEventArgs.commons.api.grid.addAllRows('PrintingDocuments',Documents);
        
           initDataEventArgs.commons.api.viewState.hide('CM_TDOCUMEN_5_6');
   
        
    };