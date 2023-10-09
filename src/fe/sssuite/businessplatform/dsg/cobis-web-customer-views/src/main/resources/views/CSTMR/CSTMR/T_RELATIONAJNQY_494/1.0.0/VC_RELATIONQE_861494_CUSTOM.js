/* variables locales de T_RELATIONAJNQY_494*/
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

    
        var task = designerEvents.api.relationform;
    

    //"TaskId": "T_RELATIONAJNQY_494"
//var tipoPersona;
var codigoCliente;
var banBorrado;
banBorrado = true;
var ban=true;
 var numsecuential=0;

task.closeModalEvent.findCustomer = function (args) {
   // var tipoPersona ;
    if (args.result.params.mode == "findCustomer"){
        var taskHeader = {};
        if (args.result.selectedData.customerType == "P"){
            LATFO.INBOX.addTaskHeader(taskHeader,'title',args.result.selectedData.name,0);
        }
        else if (args.result.selectedData.customerType == "C"){
            LATFO.INBOX.addTaskHeader(taskHeader,'title',args.result.selectedData.commercialName,0);
        }
        LATFO.INBOX.addTaskHeader(taskHeader,'No. de Identificaci\u00f3n',args.result.selectedData.documentId,1);
        LATFO.INBOX.addTaskHeader(taskHeader,'Tipo de Identificaci\u00f3n',args.result.selectedData.documentType,1);
        LATFO.INBOX.addTaskHeader(taskHeader,'C\u00f3digo del cliente',args.result.selectedData.code,2);
        LATFO.INBOX.updateTaskHeader(taskHeader, args, 'G_RELATIONNN_434954');        
        codigoCliente = args.result.selectedData.code;
        args.model.RelationContext.secuential= codigoCliente;
        //TRAER LAS RELACIONES
        args.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','Relation', undefined, true, false, 'VC_RELATIONQE_861494', false);
        
    }
    if (args.result.params.mode == "relation"){
        var api = args.commons.api;        
        var resp = args.commons.api.vc.dialogParameters;
        var selectedRow = api.vc.grids.QV_6114_93961.selectedRow;       
        selectedRow.set('namePersonRight', resp.name);
        selectedRow.set('secuentialPersonLeft', args.model.RelationContext.secuential);
		selectedRow.set('secuentialPersonRight', args.result.selectedData.code);
        //args.model.RelationPerson.data()[0].secuentialPersonLeft = codigoCliente;		
    }              
};

task.hideButtonGridMember = function(args,entidad,queryId){
	var ds = args.commons.api.vc.model[entidad];
	var dsData = ds.data();
	for (var i = 0; i < dsData.length; i ++) {
		var dsRow = dsData[i];
		args.commons.api.grid.hideGridRowCommand(queryId, dsRow, 'delete');
    }
};

    //Entity: Entity2
    //Entity2. (Button) View: RelationForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONAPPHYWK_615954 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;        
         if (entities.RelationContext.secuential==null){         
        entities.RelationContext.secuential = entities.NaturalPerson.personSecuential;        
       }
        //alert ("uno");
        //executeCommandEventArgs.commons.serverParameters.Entity2 = true;
        
        
    };

//Entity: Entity2
    //Entity2. (Button) View: RelationForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONAPPHYWK_615954 = function(  entities, executeCommandEventArgs ) {
    
        //Mensaje en caso de que el cliente tenga estado civil casado pero no tenga creada la relación
	var result = null;
	if(entities.NaturalPerson.maritalStatusCode == casado){
		if(entities.SpousePerson.personSecuential == null){
            result = 1;
			
		}
	}
	if(result == 1){ //ERROR: CREAR RELACION CON CONYUGE
		executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo('Crear relaci\u00f3n con Conyuge',true);
	}
	
    executeCommandEventArgs.commons.execServer = false;
    if(numsecuential!=0){
        task.hideButtonGridMember(executeCommandEventArgs, 'RelationPerson', 'QV_6114_93961');
    } 
    
        
    };

//RelationPersonQuery Entity: 
    task.executeQuery.Q_RELATION_6114 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//gridRowRendering QueryView: QV_6114_93961
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6114_93961 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    
    if (screenMode == 'Q'){
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_6114_93961', 'create'); 
        var dsRelation = entities.RelationPerson.data();
        for (var i = 0; i < dsRelation.length; i++) {   
            var dsRow = dsRelation[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6114_93961', dsRow, 'delete');            
        }
    
    }
            
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RelationForm
    task.initData.VC_RELATIONQE_861494 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        if(entities.RelationContext.secuential==null && initDataEventArgs.commons.api.parentVc==undefined)
		{
        var nav = initDataEventArgs.commons.api.navigation;        
        nav.label='B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer',
            url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                }];
        nav.customDialogParameters = {
            mode: "findCustomer"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');  
        }
        else{
             numsecuential=initDataEventArgs.commons.api.parentVc.customDialogParameters.codigoCli;
            entities.RelationContext.secuential=numsecuential;
            initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','Relation', undefined, true, false, 'VC_RELATIONQE_861494', false); 
        }
    };

//Entity: RelationPerson
    //RelationPerson.relationId (ComboBox) View: RelationForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXCLW_566954 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: RelationForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){       
        onCloseModalEventArgs.commons.execServer = false;     
  
    var isAccept;

    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ECONOMICOU_167751') {
        if (typeof onCloseModalEventArgs.result === "boolean") {
            isAccept = onCloseModalEventArgs.result;
        }
        if (isAccept) {
            //Refrescar el grid 
            if (entities.Entity1.refreshGrid == null || entities.Entity1.refreshGrid == false) {
                entities.Entity1.refreshGrid = true;
            } else {
                entities.Entity1.refreshGrid = false;
            }
        }
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ADDRESSITS_306302') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                    onCloseModalEventArgs.commons.api.grid.addRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.data);
                }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
        onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    }
if (onCloseModalEventArgs.closedViewContainerId == 'VC_BUSINESSPP_740722') {
    if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('Business', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Business', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
      }
	  onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);//Para que recuper la info de la base a pesar de que dio error
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_REFERENCPP_688957') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('References', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('References', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
    }
    }
        if (onCloseModalEventArgs.closedViewContainerId == 'VC_REPLACEAII_570116') {
            if(onCloseModalEventArgs.result.resultArgs!=null){
                if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                    if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                        entities.NaturalPerson.accountIndividual = onCloseModalEventArgs.result.resultArgs.accountIndividual; 
                    }
                }
            }
        }
        
    };

//Entity: RelationPerson
    //RelationPerson.namePersonRight (TextInputButton) View: RelationForm
    
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXJMD_724954 = function( textInputButtonEventGridEventArgs ) {
        textInputButtonEventGridEventArgs.commons.execServer = false;
        var nav = textInputButtonEventGridEventArgs.commons.api.navigation;        
        nav.label='B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer',
            url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                }];
        nav.customDialogParameters = {
            mode: "relation"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        //nav.openCustomModalWindow('findCustomer');
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: RelationForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
    };

//gridRowDeleting QueryView: QV_6114_93961
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_6114_93961 = function (entities, gridRowDeletingEventArgs) {
        if (banBorrado==true ){
            if (gridRowDeletingEventArgs.rowData.secuentialPersonLeft ==0 ||        gridRowDeletingEventArgs.rowData.secuentialPersonRight == 0 ){
				gridRowDeletingEventArgs.commons.execServer = false;
				gridRowDeletingEventArgs.commons.messageHandler.showMessagesError('Error, datos inconsistentes',true);
			}
			else{
				gridRowDeletingEventArgs.commons.execServer = true;
				gridRowDeletingEventArgs.commons.serverParameters.RelationPerson = true;
				gridRowDeletingEventArgs.commons.serverParameters.RelationContext = true;
			}
            //banBorrado=false;            
        }
        else{
            gridRowDeletingEventArgs.commons.execServer = false;
        }
        };

//Start signature to callBack event to QV_6114_93961
task.gridRowDeletingCallback.QV_6114_93961 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
    if (banBorrado == true){        
        if(gridRowDeletingCallbackEventArgs.success){	        gridRowDeletingCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTROM_33731',true);
            gridRowDeletingCallbackEventArgs.commons.execServer = false;
            //banBorrado=false;
        }
    }
};

//gridRowInserting QueryView: QV_6114_93961
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_6114_93961 = function (entities, gridRowInsertingEventArgs) {            
            var grid = gridRowInsertingEventArgs.commons.api.grid;
            if (gridRowInsertingEventArgs.rowData.secuentialPersonLeft ==0 || gridRowInsertingEventArgs.rowData.secuentialPersonRight == 0){                
                gridRowInsertingEventArgs.commons.execServer = false;
                gridRowInsertingEventArgs.commons.messageHandler.showMessagesError('Error en la creación del registro',true); 
                banBorrado = false;
                grid.removeRow('RelationPerson', 0); 
                //grid.refresh('QV_6114_93961');
                
            }
            else{
                gridRowInsertingEventArgs.commons.execServer = true;
                gridRowInsertingEventArgs.commons.serverParameters.RelationPerson = true;
                banBorrado= true;
            }
            
        };

//Start signature to Callback event to QV_6114_93961
task.gridRowInsertingCallback.QV_6114_93961 = function(entities, gridRowInsertingCallbackEventArgs) {
//here your code
};



}));