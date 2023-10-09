<!-- Designer Generator v 5.0.0.1513 - release SPR 2015-13 11/07/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.arrears;
    task.EtapaTramite = '';
    task.Etapa = '';
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //ArrearsDetail.applicationType (ComboBox) View: ArrearsView 
    task.change.VA_AREARSVIEW3904_IOYP979 = function(entities, changedEventArgs) { 
		var viewState = changedEventArgs.commons.api.viewState; 
        var tipo = entities.ArrearsDetail.applicationType;
        if(tipo === 'I'){
            if(entities.ArrearsInfo.overdueDays < 90){ //validacion ok
			    changedEventArgs.commons.execServer = false;
                changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MESSAGEDA_12755'); 
                entities.ArrearsDetail.rateAmortization = '0';
		        entities.ArrearsDetail.capitalAmortization = '100'; 
                var ctrs1 = ['VA_AREARSVIEW3904_TTII027','VA_AREARSVIEW3904_MORT127','VA_AREARSVIEW3904_RARR148'];                
                BUSIN.API.disable(viewState,ctrs1);				
            }else{
				changedEventArgs.commons.execServer = true;
                var ctrs1 = ['VA_AREARSVIEW3904_TTII027','VA_AREARSVIEW3904_MORT127','VA_AREARSVIEW3904_RARR148'];
                BUSIN.API.show(viewState,ctrs1);
                BUSIN.API.disable(viewState,ctrs1);
			}
        }else{
           changedEventArgs.commons.execServer = false;
           entities.ArrearsDetail.rangeArrears = '';
           entities.ArrearsDetail.rateAmortization = '0';
		   entities.ArrearsDetail.capitalAmortization = '100';           
           var ctrs1 = ['VA_AREARSVIEW3904_TTII027','VA_AREARSVIEW3904_MORT127'];
           var viewState = changedEventArgs.commons.api.viewState;
           BUSIN.API.show(changedEventArgs.commons.api.viewState,ctrs1);
           BUSIN.API.enable(viewState,ctrs1);
        }
    };

    //DebtorGeneral.TypeDocumentId (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //DebtorGeneral.Role (ComboBox) View: BorrowerView 
    task.change.VA_BORRWRVIEW2783_ROLE954 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };

    //ArrearsInfo.city (ComboBox) View: ArrearsView 
    task.loadCatalog.VA_AREARSVIEW3985_CITY589 = function(loadCatalogDataEventArgs) {        
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
                serverParameters.ArrearsInfo = true;
				serverParameters.OfficerAnalysis = true;
		loadCatalogDataEventArgs.commons.execServer = true;
		
    };
    //ArrearsDetail.capitalAmortization (TextInputBox) View: ArrearsView 
    task.change.VA_AREARSVIEW3904_MORT127 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;		
		entities.ArrearsDetail.rateAmortization = 100 - entities.ArrearsDetail.capitalAmortization
    };

    //ArrearsDetail.rateAmortization (TextInputBox) View: ArrearsView 
    task.change.VA_AREARSVIEW3904_TTII027 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;		
		entities.ArrearsDetail.capitalAmortization = 100 - entities.ArrearsDetail.rateAmortization
    };
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //btnSave (Button) 
    task.executeCommand.CM_RREAR10BNE86 = function(entities, executeCommandEventArgs) {        
        if(entities.ArrearsDetail.applicationType === 'E'){        
			if((entities.ArrearsDetail.rateAmortization + entities.ArrearsDetail.capitalAmortization) ==100){
				
                var parentApi = executeCommandEventArgs.commons.api.parentApi();
                if(parentApi != undefined){
                var parentVc = parentApi.vc;
                parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
                }
                executeCommandEventArgs.commons.execServer = true;				
			}else{
					//executeCommandEventArgs.commons.messageHandler.showMessagesError('Suma de Interes y Capital debe ser 100%');
					executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_UMOITERET_30347');	
                    var parentApi = executeCommandEventArgs.commons.api.parentApi();
                    if(parentApi != undefined){
                    var parentVc = parentApi.vc;
                    parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
                    }
                    executeCommandEventArgs.commons.execServer = false;            
            }
        }
         if(entities.ArrearsDetail.applicationType === 'I'){        
            if(entities.ArrearsInfo.overdueDays > 90){ //validacion ok
                var parentApi = executeCommandEventArgs.commons.api.parentApi();
                if(parentApi != undefined){
                var parentVc = parentApi.vc;
                parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
                }
                executeCommandEventArgs.commons.execServer = true;              
            }else{ // no aplica cuando.. es menor de 90
                    var parentApi = executeCommandEventArgs.commons.api.parentApi();
                    if(parentApi != undefined){
                    var parentVc = parentApi.vc;
                    parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
                    }
                    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MESSAGEDA_12755');       
                    executeCommandEventArgs.commons.execServer = false;            
            }
        }
        // executeCommandEventArgs.commons.execServer = false;
    };

	task.executeCommandCallback.CM_RREAR10BNE86 = function(entities, executeCommandCallbackEventArgs) {		
		executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_RREAR10CMN40');
		var viewState = executeCommandCallbackEventArgs.commons.api.viewState;	
		if(!executeCommandCallbackEventArgs.success){
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_UEORLRORN_22012'); 
		}else{
			BUSIN.INBOX.STATUS.nextStep(false,executeCommandCallbackEventArgs.commons.api);		
		}
		if(task.Etapa === FLCRE.CONSTANTS.Stage.RevisedRecommendation || task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion){
		   	BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		}

        
	};
	
	//btnPrint (Button) 
    task.executeCommand.CM_RREAR10CMN40 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
		 var debtors = entities.DebtorGeneral.data();
		 for (var i = 0; i < debtors.length; i++) {
		    if(debtors[i].Role == 'C'){					
				var debtorC = debtors[i].CustomerCode;
				break;
			}else{
				var debtorC = 0;
			}
		 }
		var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.RequestMoratorium],['idTramit',entities.ArrearsInfo.creditNumber],['opBank', entities.ArrearsInfo.operationBank],['cstDebtor',debtorC]];

		BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.RequestMoratorium,args);
		BUSIN.INBOX.STATUS.nextStep(true,executeCommandEventArgs.commons.api);
    };
	
	
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //RowInserting QueryView: Borrowers 
    task.gridRowInserting.QV_BOREG0798_55 = function(entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
    };
    //BeforeViewCreationCl QueryView: Borrowers 
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) {
        // beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

    //fileDeleting QueryView: GridPersonalGuarantor 
    task.gridRowDeleting.QV_PESAU2317_81 = function(entities, gridRowDeletingEventArgs) {
        // gridRowDeletingEventArgs.commons.execServer = false;
    };

    //BeforeEnterLine QueryView: Borrowers 
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        // gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
    };

    //Selecting Personal QueryView: GridPersonalGuarantor 
    task.gridRowSelecting.QV_PESAU2317_81 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //GridCommand (Button) QueryView: Borrowers 
    task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) {
        // gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: ArrearsForm 
    task.initData.VC_RREAR10_ARRRM_816 = function(entities, initDataEventArgs) {        
		var viewState = initDataEventArgs.commons.api.viewState;
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;	
		entities.ArrearsInfo.processedNumber = parentParameters.Task.processInstanceIdentifier;	
		entities.ArrearsInfo.officeId = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.ArrearsInfo.userL=cobis.userContext.getValue(cobis.constant.USER_NAME);	    
          
		if(parentParameters.Task.bussinessInformationStringOne !== undefined &&parentParameters.Task.bussinessInformationStringOne !== '' && parentParameters.Task.bussinessInformationStringOne !== null){					
			entities.ArrearsInfo.operationBank = parentParameters.Task.bussinessInformationStringOne;			
		}
		
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        task.EtapaTramite = parentParameters.Task.urlParams.Tramite;
        task.Etapa        = parentParameters.Task.urlParams.Etapa;      
    
       //@LGU No Borrar -> Historias ORI-H00143-5, ORI-H00144, ORI-H00145 	                
		initDataEventArgs.commons.execServer = true;       
    };
	
	task.initDataCallback.VC_RREAR10_ARRRM_816 = function(entities, initDataEventArgs) {   
		task.formatAmortizationTable(entities, initDataEventArgs.commons.api);
		initDataEventArgs.commons.api.viewState.addStyle('QV_PESAU2317_81', 'grupo-lectura');	
        initDataEventArgs.commons.api.grid.title("QV_IFOPA9055_49", "titleColumn", "");  

		  var rowsIP = entities.InfoPayment.data();
             for (var i = 0; i < rowsIP.length; i ++) {
                 rowsIP[i].titleColumn = cobis.translate(rowsIP[i].titleColumn);
             }
		
	};

    //ViewContainer: ArrearsForm 
    task.render = function(entities, renderEventArgs) {
		var viewState = renderEventArgs.commons.api.viewState;
		//CAMPOS PROVINCIA Y CIUDAD
		//var ctrs = ['VA_AREARSVIEW3985_PVIE179', 'VA_AREARSVIEW3985_CITY589'];      
		//BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs);
		viewState.mask('VA_AREARSVIEW3904_MORT127', '###.##');
		viewState.mask('VA_AREARSVIEW3904_TTII027', '###');
	
        /*Deshabilitar el campo rango siempre*/
        var ctrs1a = ['VA_AREARSVIEW3904_RARR148', 'VA_AREARSVIEW3985_OCAI738', 'CM_RREAR10CMN40'];        
        BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs1a);
        BUSIN.API.disable(viewState,ctrs1a);
		var ctrs = ['VA_AREARSVIEW3985_TERM661'];        
        BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs);
		BUSIN.API.enable(viewState,ctrs);
		var grid = renderEventArgs.commons.api.grid;
		grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');
		grid.hideToolBarButton('QV_BOREG0798_55', 'create');
        
        var  vs = renderEventArgs.commons.api.viewState;
        vs.suffix('VA_AREARSVIEW3904_TTII027', '%');
        vs.suffix('VA_AREARSVIEW3904_MORT127', '%');

//@LGU No Borrar -> Historias ORI-H00143-5, ORI-H00144, ORI-H00145 
    if(task.EtapaTramite != null && task.EtapaTramite !== undefined){
			if(task.EtapaTramite === FLCRE.CONSTANTS.RequestName.Moratorium){
				if((task.Etapa === FLCRE.CONSTANTS.Stage.Exception) || 
				(task.Etapa === FLCRE.CONSTANTS.Stage.VerificationDocuments) || 
				(task.Etapa === FLCRE.CONSTANTS.Stage.LegalApproval)){
					var ctrs1 = ['VA_AREARSVIEW3985_PVIE179', 'VA_AREARSVIEW3985_CITY589', 
								 'VA_AREARSVIEW3985_ESDT632', 'VA_AREARSVIEW3985_QSUN970', 
								 'VA_AREARSVIEW3985_ETUS014', 'VA_AREARSVIEW3985_CDNT571', 
								 'VA_AREARSVIEW3985_TQNC755', 'VA_AREARSVIEW3904_IOYP979', 
								 'VA_AREARSVIEW3904_RARR148', 'VA_AREARSVIEW3904_TTII027', 
								 'VA_AREARSVIEW3904_MORT127', 'VA_AREARSVIEW3904_RNAS727', 
								 'VA_AREARSVIEW3904_ESAT040', 'CM_RREAR10CMN40','VA_AREARSVIEW3985_TERM661'];
					var viewState = renderEventArgs.commons.api.viewState;
					BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs1);
					BUSIN.API.disable(viewState,ctrs1);
					
					BUSIN.API.readOnlyAsync(renderEventArgs,['VA_AREARSVIEW3985_CITY589'],true,3000); 
					
					//renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_ITRIC1523_63_992'); //Boton Nuevo Operaciones
					renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); //Boton Eliminar Operaciones
					renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); 
					//if((task.Etapa === FLCRE.CONSTANTS.Stage.Exception)){
					var ctrs1 = ['VA_AREARSVIEW3985_CDNT571', 'VA_AREARSVIEW3904_RARR148', 'VA_AREARSVIEW3904_TTII027', 'VA_AREARSVIEW3904_MORT127', 'VA_AREARSVIEW3904_RNAS727', 'VA_AREARSVIEW3904_ESAT040','VA_AREARSVIEW3904_IOYP979',
					              'CM_RREAR10BNE86', 'VA_AREARSVIEW3904_OTCE850', 'CM_RREAR10CMN40','VA_AREARSVIEW3985_TERM661'];
					var viewState = renderEventArgs.commons.api.viewState;
					BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrs1);
					//}
					var parentApi = renderEventArgs.commons.api.parentApi();
						if(parentApi != undefined){
							var parentVc = parentApi.vc;
							parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
						}
				}
				//RLA
				if(task.Etapa === FLCRE.CONSTANTS.Stage.RevisedRecommendation){
					var ctrs1a = ['VA_AREARSVIEW3985_PVIE179', 'VA_AREARSVIEW3985_CITY589', 'VA_AREARSVIEW3985_ESDT632', 'VA_AREARSVIEW3985_QSUN970', 'VA_AREARSVIEW3985_ETUS014', 'VA_AREARSVIEW3985_CDNT571', 'VA_AREARSVIEW3985_TQNC755',  'VA_AREARSVIEW3904_ESAT040','VA_AREARSVIEW3904_RNAS727', 'VA_AREARSVIEW3904_OTCE850'];
					var viewState = renderEventArgs.commons.api.viewState;
					BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs1a);
					BUSIN.API.disable(viewState,ctrs1a);
					BUSIN.API.readOnlyAsync(renderEventArgs,['VA_AREARSVIEW3985_CITY589'],true,2000); 
					var ctrls = ['CM_RREAR10CMN40', 'VA_AREARSVIEW3985_TERM661']
					BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrls);
					viewState.enable('CM_RREAR10BNE86');
				}//RLA
				
			    if(task.Etapa === FLCRE.CONSTANTS.Stage.Aprobacion){
					var ctrs1a = ['VA_AREARSVIEW3985_PVIE179', 'VA_AREARSVIEW3985_CITY589', 'VA_AREARSVIEW3985_ESDT632', 'VA_AREARSVIEW3985_QSUN970', 'VA_AREARSVIEW3985_ETUS014', 'VA_AREARSVIEW3985_CDNT571', 'VA_AREARSVIEW3985_TQNC755',  'VA_AREARSVIEW3904_ESAT040','VA_AREARSVIEW3904_RNAS727', 'VA_AREARSVIEW3904_OTCE850'];
					var viewState = renderEventArgs.commons.api.viewState;
					BUSIN.API.show(renderEventArgs.commons.api.viewState,ctrs1a);
					BUSIN.API.disable(viewState,ctrs1a);
					BUSIN.API.readOnlyAsync(renderEventArgs,['VA_AREARSVIEW3985_CITY589'],true,2000); 
					var ctrls = ['CM_RREAR10CMN40','VA_AREARSVIEW3985_TERM661']
					BUSIN.API.hide(renderEventArgs.commons.api.viewState,ctrls);
					viewState.enable('CM_RREAR10BNE86');					
					var tipo = entities.ArrearsDetail.applicationType;
					var ctrs1 = ['VA_AREARSVIEW3904_IOYP979','VA_AREARSVIEW3904_MORT127','VA_AREARSVIEW3904_TTII027'];                
                    if(tipo === 'I'){
                        BUSIN.API.disable(viewState,ctrs1);					            	
                    }else{
                        BUSIN.API.enable(viewState,ctrs1);	
                    }
				}
				
			}
		} 		
 };
 	
	task.formatAmortizationTable = function(entities, api){
		//TITULO EN COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
		var maxNumRubros = 13;
		var count = entities.AmortizationTableHeader.data().length-1;
		if(count>maxNumRubros) count=maxNumRubros;
		var header =entities.AmortizationTableHeader.data();
		for (var i=1; i<=count; i++){
			api.grid.title("QV_QUYOI3312_16", "Item"+i, header[i].Description, false);
			api.grid.format('QV_QUYOI3312_16',"Item"+(i), '#,##0.00');
			api.grid.format('QV_QUYOI3312_16',"Item"+(i+1), '#,##0.00');
			api.grid.format('QV_QUYOI3312_16',"Balance", '#,##0.00');
			api.grid.format('QV_QUYOI3312_16',"Fee", '#,##0.00');			
		}
		//OCULTA COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
		if(count<maxNumRubros) {
			for (var i=count+1; i<=maxNumRubros; i++){
				api.grid.hideColumn ('QV_QUYOI3312_16', 'Item'+i);
				//api.grid.disabledColumn ('QV_QUYOI3312_16', 'Item'+i);
			}
		}
	};

}());

