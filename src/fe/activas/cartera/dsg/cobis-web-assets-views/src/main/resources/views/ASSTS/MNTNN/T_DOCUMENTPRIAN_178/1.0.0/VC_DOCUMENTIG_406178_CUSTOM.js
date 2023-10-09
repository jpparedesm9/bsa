
/* variables locales de T_DOCUMENTPRIAN_178*/
var groupSummary;
var operationType;
var disbursementDate;
var processDateLocal;

/* variables locales de T_LOANHEADERNFI_316*/

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

    
        var task = designerEvents.api.documentprintingmain;
    

    //"TaskId": "T_DOCUMENTPRIAN_178"
	
	function Print () {
		this.codigo = "";
		this.documentos = "";
		this.item = "";
	}

task.isValidDate = function(processDate,initDate){
    var maxDays = 10;
    var processDateSplit = processDate.split('/');
    var processDateTime = new Date(processDateSplit[2],processDateSplit[0]-1,processDateSplit[1]).getTime();
    var initDateTime = initDate.getTime(); 
    var dif = processDateTime - initDateTime;
    var difDays = Math.round(dif/(1000*60*60*24));
    if(difDays > maxDays){
         cobis.showMessageWindow.alertInfo("No se admiten cancelaciones individuales de un cr\u00e9dito grupal fuera del plazo establecido","AVISO");
        return false;
    }
    return true;
    

}
	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeDialog();
        var subModuleId = "CMMNS",
          taskId = "T_LOANSEARCHSWA_959",
          vcId = "VC_LOANSEARHC_144959",
          parameters = '',
          label=executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_BSQUEDASS_55923');
      ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId,label, executeCommandEventArgs, parameters);
	  return true;
    };

task.gridRowCommand.VA_VDATOSALUD3211_SEOA837 = function (rowData, gridRowCommandEventArgs) {
    var viewState = gridRowCommandEventArgs.commons.api.viewState;
    var anterior = true;
    gridRowCommandEventArgs.commons.execServer = false;
    gridRowCommandEventArgs.stopPropagation = true;
    anterior = gridRowCommandEventArgs.rowData.item;
    if (anterior == false) {
        gridRowCommandEventArgs.rowData.item = true;
    } else {
        gridRowCommandEventArgs.rowData.item = false;
    }
};

    	// (Button) 
    task.executeCommand.CM_DOCUMENT_CRT = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;   

		var dataGrid = entities.PrintingDocuments.data();
		var code = "";
		var itemReporte = "";
		var reportTitle = "";
		var args = [];
    
		for (var i=0; i<dataGrid.length; i++)
		{
			if (dataGrid[i].item == true){
				
				code = dataGrid[i].codigo
				itemReporte = "";
				args = [];
			
				switch (code)
				{
					case 1:
						itemReporte = "Liquidation";
						reportTitle = "LIQUIDACI\u00d3N - DESEMBOLSO PARCIAL";
						var args = [['numOperation', entities.Loan.loanBankID.trim()],
									['secLiquidation', 4],
									['currencyLiquidation', 0]]
						break;
					case 2:
						//Open Modal
						var nav = executeCommandEventArgs.commons.api.navigation;
						reportTitle = "RECIBO DE PAGO";
						nav.label = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_LISTADOGC_53251');
						nav.address = {
							moduleId: 'ASSTS',
							subModuleId: 'MNTNN',
							taskId: 'T_BEFOREPRINNAA_172',
							taskVersion: '1.0.0',
							viewContainerId: 'VC_BEFOREPRAN_111172'
						};
						nav.queryParameters = {
							mode: 8
						};
						nav.modalProperties = {
							size: 'md',
							height: null,
							callFromGrid: false
						};
						nav.customDialogParameters = {
							loanInstancia:entities.LoanInstancia
						};
						nav.openModalWindow("CM_DOCUMENT_CRT", executeCommandEventArgs.modelRow);
						break;
					case 3: 
						itemReporte = "PaymentTable";
						reportTitle = "TABLA DE AMORTIZACI\u00d3N";
						var args = [['numOperation', entities.Loan.loanBankID.trim()],
							['paymentTableHis', "N"]];
						break;
					case 4:
						itemReporte = "PromissoryNote";
						reportTitle = "PAGAR\u00c9 A LA ORDEN";
						var args = [['numOperation', entities.Loan.loanBankID.trim()]];
						break;
					case 5:
						itemReporte = "CreditAgreement";
						reportTitle = "CONTRATO DE APERTURA DE CR\u00c9DITO";
						var args = [['numOperation', entities.Loan.loanBankID.trim()]];
						break;
                    case 6:
                        var loan = entities.Loan;
                        
                        if(operationType!='REVOLVENTE'){
                            cobis.showMessageWindow.alertInfo("No se admiten pagos Individuales para este tipo de Cr\u00e9dito","AVISO");   
                        }else{
                            
                            if (loan.statusID==3){
                                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
                                cobis.showMessageWindow.alert(message, 'FICHA DE PAGO CR\u00c9DITO INDIVIDUAL', buttons)
                            }else{
						      executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ="1"; //PDF
                                var buttons = ['NO', 'SI'];
                                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');
                                cobis.showMessageWindow.confirm(message, 'AVISO', buttons).then(function (resp)     {
                                switch (resp.buttonIndex) {
                                    case 1: //accept
                                        executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2";// ENVIO CORREO
                                   break;
                                    } 
                                    executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  
                                });
                            }
                        }
                        break;
                        
                        case 7:
                         executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_MPN', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false); 
                        
                        break;
                        
                        case 8:
                        executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_1RO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  
                        break;

                case 9:
				
                    //FICHA DE PAGO GENÉRICA
					if (entities.Loan.statusID == 1 || entities.Loan.statusID == 2 || entities.Loan.statusID == 4 || entities.Loan.statusID == 12) {
                        itemReporte = "GenericPaymentSlip";
                        reportTitle = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_FICHADEOO_52167');
                        var args = [
                        ['bank', entities.Loan.loanBankID.trim()],
                        ['clientID', entities.Loan.clientID]
                        ];
                        ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
                    } else {
                        var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_ESTADODIA_28122');
                        cobis.showMessageWindow.alertInfo(message, "AVISO");
                    }
                    break;

					default: 
						break;				
				}		
            if (code != 2 && code != 6 && code != 7 && code != 8 && code != 9) {
					ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
				}
			}		
		}
    };

	// (Button) 
    task.executeCommand.CM_TDOCUMEN_1RO = function(entities, executeCommandEventArgs) {
         var itemReporte;
        var reportTitle = "FICHA DE PRE CANCELACI\u00d3N";
        var sendMail =  executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ;//SOLO PDF
        var args ;
        var crearReporte = true;
        var loan = entities.Loan;
        
        executeCommandEventArgs.commons.execServer = false;
     
          //Operacion Padre
        if(operationType=='GRUPAL' && groupSummary=="S"){
             itemReporte = "PreCancellation";
            args = [['bank', entities.Loan.loanBankID],['amountPRE', 0],['sendMail', sendMail]]
            
        }else if(operationType=='GRUPAL' && groupSummary=="N"){
          itemReporte = "PreCancellation";
               args = [['clientID', entities.Loan.clientID],['amountPRE', 0],['sendMail', sendMail]]
              if(!task.isValidDate(processDateLocal,disbursementDate)){
                crearReporte=false;
              }
               
        }else if(operationType=='REVOLVENTE'){
           /* executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  */
            console.log("revolvente");
          
        }else {
            cobis.showMessageWindow.alertError("Formato no desarrollado","ERROR");
            crearReporte=false;
        }
     
        if(crearReporte){
            if (loan.statusID==3){
                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
                cobis.showMessageWindow.alert(message, 'FICHA DE PRE CANCELACI\u00d3N', buttons)
            }else{
                executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ="1"; //PDF
                if(args !== undefined){
                    args[2]=['sendMail','1']
                }
                var buttons = ['NO', 'SI'];
                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');
                cobis.showMessageWindow.confirm('\u00bfDesea enviar la Ficha de Pre Cancelacion al Correo\u003f', 'AVISO', buttons).then(function (resp) {
                    switch (resp.buttonIndex) {
                        case 1: //accept
                            executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2";// ENVIO CORREO
                            if(args !== undefined){
                                args[2]=['sendMail','2']
                            }
                            break;
                    }
                  
                    if(operationType=='REVOLVENTE'){
            executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  
                    }
                    else{ 
                        ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
                    }
                });
                
             
        
            }  
        }
    };

	// (Button) 
    task.executeCommand.CM_TDOCUMEN_5CO = function(entities, executeCommandEventArgs, option) {
       executeCommandEventArgs.commons.execServer = false;
        var itemReporte = "paymentCard";
        var reportTitle = "FICHA DE PAGO CR\u00c9DITO INDIVIDUAL";
        var sendMail =  executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ;//SOLO PDF
        var args = [['numOperation', entities.Loan.loanBankID.trim()],['sendMail', sendMail]];
    
        ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
        
    };

	// FICHA DE PAGO
    task.executeCommand.CM_TDOCUMEN_MPN = function(entities, executeCommandEventArgs) {
        var itemReporte;
        var reportTitle = "FICHA DE PAGO";
        var sendMail =  executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ;//SOLO PDF
        var args ;
        var crearReporte = true;
        var loan = entities.Loan;
        
        executeCommandEventArgs.commons.execServer = false;
        if(operationType=='GRUPAL' && groupSummary=="S"){
             itemReporte = "CorresponsalPayment";
            args = [['bank', entities.Loan.loanBankID.trim()],['sendMail', sendMail]]
            
        }else if(operationType=='GRUPAL' && groupSummary=="N"){
            cobis.showMessageWindow.alertInfo("No se admiten pagos individuales a un Cr\u00e9dito Grupal","AVISO");
            crearReporte=false;
        }else if(operationType=='REVOLVENTE'){
            itemReporte = "paymentCard";
            args = [['numOperation', entities.Loan.loanBankID.trim()],['sendMail', sendMail]]

    } else if (operationType == 'INDIVIDUAL' && groupSummary == "N") {
        itemReporte = "CorresponsalPayment";
        args = [['bank', entities.Loan.loanBankID.trim()], ['sendMail', sendMail], ['operationType', operationType]]

        }else {
            cobis.showMessageWindow.alertError("Formato a\u00fan no desarrollado","ERROR");
            crearReporte=false;
        }
     
        if(crearReporte){
            if (loan.statusID==3){
                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
                cobis.showMessageWindow.alert(message, 'FICHA DE PAGO', buttons)
            }else{
                executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ="1"; //PDF
                 args[1]=['sendMail', '1']
                var buttons = ['NO', 'SI'];
                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');

            if (operationType == 'INDIVIDUAL') {
                ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
                
            } else {
                cobis.showMessageWindow.confirm('\u00bfDesea enviar la Ficha de Pago al Correo\u003f', 'AVISO', buttons).then(function (resp) {
                    switch (resp.buttonIndex) {
                        case 1: //accept
                            executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2";// ENVIO CORREO
                            args[1]=['sendMail', '2']
                            break;
                    } 
                      if(operationType=='REVOLVENTE'){
                        
                            executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  
                        
                    }else{
                    ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
                    }
                });
            }
                
            
        
            }  
        }
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DocumentPrintingMain
    task.initData.VC_DOCUMENTIG_406178 = function (entities, initDataEventArgs){
        
        initDataEventArgs.commons.execServer = true;
		var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;	
        groupSummary=parameters.parameters.groupSummary;
        operationType=parameters.parameters.operationType;
        disbursementDate=parameters.parameters.disbursementDate;
		
        var Documents = [];
		
    /*  Documents[0] = new Print();
		Documents[0].codigo = 1;
		Documents[0].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_LIQUIDAOA_52380');
		Documents[0].item = false;*/

/*		Documents[1] = new Print();
		Documents[1].codigo = 2;
		Documents[1].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_RECIBOPAG_89342');
		Documents[1].item = false;*/

		Documents[0] = new Print();
		Documents[0].codigo = 3;
		Documents[0].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_TABLAAMIA_39175');
		Documents[0].item = false;

	/*	Documents[3] = new Print();
		Documents[3].codigo = 4;
		Documents[3].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PAGAREAER_20693');
		Documents[3].item = false;

		Documents[4] = new Print();
		Documents[4].codigo = 5;
		Documents[4].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_CONTRATUR_52943');
		Documents[4].item = false;*/
        
        Documents[1] = new Print();
        Documents[1].codigo = 6;
        Documents[1].documentos = 'FICHA DE PAGO CR\u00c9DITO LCR';
        Documents[1].item = false;
        
        Documents[2] = new Print();
        Documents[2].codigo = 7;
        Documents[2].documentos = 'FICHA DE PAGO';
        Documents[2].item = false;
        
        Documents[3] = new Print();
        Documents[3].codigo = 8;
        Documents[3].documentos = 'FICHA DE PRE CANCELACI\u00d3N';
        Documents[3].item = false;
        
        //FICHA DE PAGO GENÉRICA
        if (cobis.containerScope.userInfo.roleName == 'MESA DE OPERACIONES' || cobis.containerScope.userInfo.roleName == 'COBRANZA') {
		    Documents[4] = new Print();
            Documents[4].codigo = 9;
            Documents[4].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_FICHADEOO_52167');
            Documents[4].item = false;
        }

	   initDataEventArgs.commons.api.grid.addAllRows('PrintingDocuments',Documents);
        
       initDataEventArgs.commons.api.viewState.hide('CM_TDOCUMEN_5CO');
        initDataEventArgs.commons.api.viewState.hide('CM_TDOCUMEN_MPN');
        initDataEventArgs.commons.api.viewState.hide('CM_TDOCUMEN_1RO');
        
        angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function(processDate)         {
            console.log(processDate);
            processDateLocal = processDate;
        }
        )
    };

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: DocumentPrintingMain
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: DocumentPrintingMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_DOCUMENTIG_406178","VC_IYLYXGBWSN_401178",entities, renderEventArgs); 
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
     try{
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.api.vc.closeDialog();
            var subModuleId = "CMMNS",
            taskId = "T_LOANSEARCHSWA_959",
            vcId = "VC_LOANSEARHC_144959",
            parameters = '', 
            label = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_BSQUEDASS_55923');
            ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);
     }
    catch(err){
        ASSETS.Utils.managerException(err);
    }
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONWVITZRQ_108612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
         ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
         return true;
    };

	// (Button) 
    task.executeCommand.CM_TDOCUMEN_5_6 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        
    };

	// (Button) 
    task.executeCommand.CM_TDOCUMEN_OTS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
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
            case 6:
                    var loan = entities.Loan;
                    if (loan.statusID==3){
                         var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
                         cobis.showMessageWindow.alert(message, 'MENSAJE', buttons)
                    }else{
                       executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ="1"; //PDF
                       var buttons = ['NO', 'SI'];
                       var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');
                       cobis.showMessageWindow.confirm(message, 'MENSAJE', buttons).then(function (resp) {
                       switch (resp.buttonIndex) {
                          case 1: //accept
                          executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2";// ENVIO CORREO
                          break;
                       }
                       executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5_6', 'DocumentPrinting', undefined, true, false, 'VC_DOCUMENTPP_352678', false);  
                       });
                    }
				break;
			default: 
				break;
				//alert('Default case');
			}
		
		var args = [['numOperation', entities.LoanPrinting.loanPrinting]];
		//var itemReporte = 'ReciboDePago';
        
        if (code != 6){
           ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
        }
		
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

	//gridRowSelecting QueryView: QV_3105_20065
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_3105_20065 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };



}));