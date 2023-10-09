<!-- Designer Generator v 5.0.0.1517 - release SPR 2015-16 04/09/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskdtolist;
	var idDTO = 0;
	var indexDTO = 0;


    //Seleccionar QueryView: GrillaDTOList
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_DETAL2498_88 = function(entities, gridRowSelectingEventArgs) {
		idDTO = gridRowSelectingEventArgs.rowData.dtoId;
		indexDTO = gridRowSelectingEventArgs.rowIndex;
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //Editar (ImageButton) QueryView: GrillaDTOList
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla. 
    task.gridCommand.CEQV_201_QV_DETAL2498_88_392 = function(entities, gridExecuteCommandEventArgs) {
		if(idDTO==0){
			 executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo("LATFO.DLB_LATFO_STELTAVLE_42758", null, null, false);
		}else{
			openCrudDTO(entities,gridExecuteCommandEventArgs);
		}
        gridExecuteCommandEventArgs.commons.execServer = false;
    };
	
	//Eliminar (ImageButton) QueryView: GrillaDTOList
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla. 
    task.gridCommand.CEQV_201_QV_DETAL2498_88_349 = function(entities, gridExecuteCommandEventArgs) {
		if(idDTO==0){
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo("SELECCIONE UN REGISTRO", null, null, false);
			gridExecuteCommandEventArgs.commons.execServer = false;
		}else{
				var r = confirm("Est\u00E1 Seguro de que desea eliminar el registro?");
			if (r == true) {
				entities.DtoTmp ={idDTO : idDTO, indexDTO : indexDTO} ;
					gridExecuteCommandEventArgs.commons.execServer = true;
				}else
				{
					gridExecuteCommandEventArgs.commons.execServer = false;
				}
				
			}
				
		
    };
	

		
		
	
	/*.gridCommandCallback.CEQV_201_QV_DETAL2498_88_349 = function(entities, gridExecuteCommandEventArgs) {
		gridExecuteCommandEventArgs.commons.execServer = false;*/
    

    //Nuevo (ImageButton) QueryView: GrillaDTOList
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla. 
    task.gridCommand.CEQV_201_QV_DETAL2498_88_068 = function(entities, gridExecuteCommandEventArgs) {
		idDTO = 0;
		openCrudDTO(entities,gridExecuteCommandEventArgs);
		gridExecuteCommandEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: DTOSList 
    task.initData.VC_KTOIT54_DOLST_848 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = true;
    };
	
	//Función para llamar al pantalla del CRUD para editar el DTO
	function openCrudDTO(entities, args) {
		
		var nav = args.commons.api.navigation;

        nav.address = {
            moduleId: 'LATFO',
            subModuleId: 'UCSPM',
            taskId: 'T_UCSPM_03_MAMIE85',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_MAMIE85_TIETT_934'
		}

        nav.customDialogParameters = {
            idDTO: idDTO
        };
        
		nav.navigate(args.commons.controlId);
		
	}

}());