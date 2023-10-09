
/* variables locales de T_BMTRCXBFSYZSS_339*/

/* variables locales de T_BMTRCOSYUDTBD_833*/

/* variables locales de T_BMTRCBGWZRBNH_925*/
var localIp= null;
var taskHeader = {};

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

    
        var task = designerEvents.api.biovalidationcomposite;
    

    //"TaskId": "T_BMTRCXBFSYZSS_339"
task.validateResult = function(entities){
    var customerList = entities.Customer;
        var aproved = 0;
        var rejected = 0;
     
        for(var i=0; i< customerList.length;i++){
            switch(customerList[i].validationStatus){
                case 'APROBADO': 
                    aproved++;
                    break
                case 'RECHAZADO':
                    rejected++;
                    break;
                case 'LIMITADO':
                    aproved++;
            }            
        }
        if(rejected >0){
             entities.ValidationData.resultValidation='RECHAZADO'
         }else{
			 if(aproved ==customerList.length){
				 entities.ValidationData.resultValidation='APROBADO'
			 }else{
				 entities.ValidationData.resultValidation='PENDIENTE'
			 }
		 }
}

    	// (Button) 
    task.executeCommand.CM_TBMTRCXB_T69 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Start signature to Callback event to CM_TBMTRCXB_T69
task.executeCommandCallback.CM_TBMTRCXB_T69 = function(entities, executeCommandCallbackEventArgs) {
	if(executeCommandCallbackEventArgs.success)
	{
		executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted ="YES"
	}else{
		executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted ="NO"
	}
};

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BioValidationComposite
    task.initData.VC_BIOVALIDSA_412339 = function (entities, initDataEventArgs){
       initDataEventArgs.commons.execServer = true;
        var parentVc = initDataEventArgs.commons.api.vc.parentVc;
        var parentParameters = parentVc == undefined || parentVc == null ? {} : parentVc.model;
        var task = parentParameters.Task;
        if (task != null) {
            entities.ValidationData.customerId = task.clientId;
            entities.Credit.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
            entities.Credit.applicationNumber = task.processInstanceIdentifier;
            entities.Credit.productType = task.bussinessInformationStringTwo;
            entities.Credit.creditCode = task.bussinessInformationIntegerTwo;
            entities.ValidationData.processInstance = task.processInstanceIdentifier;
            
            if (entities.Credit.productType == 'REVOLVENTE'){
                initDataEventArgs.commons.api.viewState.hide('VA_RESULTVALIDAIOT_362515');
                initDataEventArgs.commons.api.viewState.hide('CM_TBMTRCXB_T69');
            }
        }
    };

	//Start signature to Callback event to VC_BIOVALIDSA_412339
task.initDataCallback.VC_BIOVALIDSA_412339 = function(entities, initDataCallbackEventArgs) {
    var estado = '';
    if (initDataCallbackEventArgs.success && entities.Credit.applicationNumber != 0 && entities.Credit.applicationNumber != null) {
        //CABECERA DE PANTALLA       
        initDataCallbackEventArgs.commons.api.viewState.enable('CM_TGROUPCO_IRO');
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.ValidationData.customerId + " - " + entities.ValidationData.customerName, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', entities.Credit.creditCode == null || entities.Credit.creditCode == '0' ? '--' : entities.Credit.creditCode, 1);
        
        if(entities.Credit.productType == 'GRUPAL'){
            LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BMTRC.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested == 'null' ? 0 : entities.Credit.amountRequested), 2), 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BMTRC.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount == 'null' ? 0 : entities.Credit.approvedAmount), 2), 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.Credit.term, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.Credit.paymentFrecuency == null ? '--' : entities.Credit.paymentFrecuency), 1);
        }
        

        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Credit.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Credit.officeName), 2);
        
        if(entities.Credit.productType == 'GRUPAL'){
            LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', entities.ValidationData.cycleNumber, 2);
        }
        
        if (entities.Credit.productType == 'REVOLVENTE'){
            LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.Credit.sector, 2);
            initDataCallbackEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted ="YES";                    
        }
        
        LATFO.INBOX.updateTaskHeader(taskHeader, initDataCallbackEventArgs, 'G_HEADERSYFS_536967');

        //task.validateResult(entities);
        //IP local
        BMTRC.SERVICES.BIOCHECK.getLocalIpAddress(function(ip) {
            localIp = ip;
        });

    }
};

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: BioValidationComposite
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;            
        var api = renderEventArgs.commons.api;
        
        if (entities.Credit.productType == 'REVOLVENTE'){
            api.grid.hideColumn ('QV_6806_82610', 'role');    
        }
        
    };

	task.executeCommand.VA_VABUTTONVNZFJKQ_704515 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //task.validateResult(entities);
    };

	task.executeQuery.Q_CUSTOMEE_6806 = function(entities, executeQueryEventArgs) {
    executeQueryEventArgs.commons.execServer = false;
};

	task.gridInitColumnTemplate.QV_6806_82610 = function (idColumn, gridInitColumnTemplateEventArgs) {
       if (idColumn === 'withoutFingerprint') {
            return "<span>#if(withoutFingerprintValue == 'S'){# <input type=\'checkbox\' disabled checked ng-model=\"dataItem.withoutFingerprint\" ng-click=\"vc.grids.QV_ITRIC1523_63.events.customRowClick($event, \'VA_TEXTINPUTBOXUSB_323559\', \'ValidationMemberQuery\', 'QV_6146_83140')\"/>#}#</span>";
        }
    
};

	task.gridInitEditColumnTemplate.QV_6806_82610 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

	//Entity: Customer
    //Customer. (Button) View: BiometricValidation
task.gridRowCommand.VA_GRIDROWCOMMMDNN_192515 = function(entities, gridRowCommandEventArgs) {
    gridRowCommandEventArgs.commons.execServer = false;
	var rowData = gridRowCommandEventArgs.rowData
	var api = gridRowCommandEventArgs.commons.api;
    var dataSend = {};
    // BMTRC.SERVICES.BIOCHECK.validateBiocheck(gridRowCommandEventArgs,entities.AdditionalInformation.environment, localIp);

    if (rowData.withoutFingerprintValue !== 'S') {
        //Open Modal
        var nav = gridRowCommandEventArgs.commons.api.navigation;
        nav.label = "Captura de Huellas Dactilares";
        nav.address = {
            moduleId: "BMTRC",
            subModuleId: "TRNSC",
            taskId: "T_BMTRCZDWNNFMY_409",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BIOMETRINP_845409",
        };
        nav.queryParameters = {
            mode: 1,
        };
        nav.modalProperties = {
            size: "lg",
            height: 650,
            callFromGrid: false,
        };

        nav.customDialogParameters = {
            grid: gridRowCommandEventArgs,
            entities: entities,
        };
    
        //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
        nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, null);
        //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
        //nav.openModalWindow(id, gridRowCommandEventArgs.modelRow);

    } else {
        dataSend.response = null;
        dataSend.signature = null;
        dataSend.amount = rowData.amount;
        dataSend.sequential = null;        
        dataSend.instanceProcess = api.parentVc.model.Task.processInstanceIdentifier;

        if (rowData.withoutFingerprint) {
            dataSend.validateFingerPrint = 'S';
        }

        //servicio guardado
        BMTRC.SERVICES.BIOCHECK.saveBiometricInfo(dataSend, rowData, gridRowCommandEventArgs);
    }
        
    };

	//Entity: Customer
//Customer. (Button) View: BiometricValidation

task.gridRowCommand.VA_GRIDROWCOMMMNAN_197515 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = false;

    //Open Modal
    var nav = gridRowCommandEventArgs.commons.api.navigation;

    nav.label = cobis.translate('BMTRC.LBL_BMTRC_DOCUMENOO_55979');
    nav.address = {
        moduleId: 'BMTRC',
        subModuleId: 'TRNSC',
        taskId: 'T_BMTRCNYSSKGHD_541',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_DOCUMENTDD_249541'
    };
    nav.queryParameters = {
        mode: 8
    };
    nav.modalProperties = {
        size: 'md',
        callFromGrid: false
    };
    nav.customDialogParameters = {
        customerId: gridRowCommandEventArgs.rowData.idCustomer
    };
    nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, gridRowCommandEventArgs.modelRow);

};

	//gridRowRendering QueryView: QV_6806_82610
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6806_82610 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;

    if (gridRowRenderingEventArgs.rowData.withoutFingerprint == false) {
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6806_82610', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNAN_197515');
    } else {
        gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_6806_82610', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMNAN_197515');
    }
};



}));