<!-- Designer Generator v 5.0.0.1507 - release SPR 2015-06 17/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.taskmaintenancecatalog;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //MaintenanceCatalog.Catalog (ComboBox) View: ViewActivitiesList 
    task.change.VA_VEACITESIT4281_CTAG467 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = true;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //InsertEmer QueryView: GridActivitiesList 
    task.gridRowInserting.QV_CIVII5836_15 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = false;
         var ds = gridRowInsertingEventArgs.commons.api.vc.model['ActivitiesList'];
			var dsData = ds.data();
			for (var i = 0; i < dsData.length; i ++) {
						var dsRow = dsData[i];
						if((dsRow.CodActivities === "")){
							gridRowInsertingEventArgs.commons.api.grid.removeRow('ActivitiesList', i );
						}

					 }
       /*  var nav = gridRowInsertingEventArgs.commons.api.navigation;
		
			nav.address = {
				moduleId: "BUSIN",
				subModuleId: "FLCRE",
				taskId: 'T_FLCRE_26_KMRCT63', 
				taskVersion: '1.0.0',
				viewContainerId: 'VC_KMRCT63_FGTOG_508' 	
			};		
			nav.label = cobis.translate('Emergente');		
			nav.modalProperties = {
			size: 'lg'
			};		
			nav.queryParameters = {
				mode: gridRowInsertingEventArgs.commons.constants.mode.Update
			 };
			
			nav.customDialogParameters = {			
			};
			
			nav.openModalWindow(gridRowInsertingEventArgs.commons.controlId);*/
        
    };
    
	 //DeleteRow QueryView: GridActivitiesList 
    task.gridRowDeleting.QV_CIVII5836_15 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
    };
	
    //newDialog QueryView: GridActivitiesList 
    task.gridBeforeEnterInLineRow.QV_CIVII5836_15 = function(entities, gridABeforeEnterInLineRowEventArgs) {
         gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
		 
		   var nav = gridABeforeEnterInLineRowEventArgs.commons.api.navigation;
		
			nav.address = {
				moduleId: "BUSIN",
				subModuleId: "FLCRE",
				taskId: 'T_FLCRE_26_KMRCT63', 
				taskVersion: '1.0.0',
				viewContainerId: 'VC_KMRCT63_FGTOG_508' 	
			};		
			nav.label = cobis.translate('Búsqueda por Descripción');		
			nav.modalProperties = {
			size: 'lg'
			};		
			nav.queryParameters = {
				mode: gridABeforeEnterInLineRowEventArgs.commons.constants.mode.Update
			 };
			
			nav.customDialogParameters = {			
			};
			
			nav.openModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId);
		 
    };
    
    task.closeModalEvent.VC_KMRCT63_FGTOG_508 = function(entities, executeCommandEventArgs){
          
		  if (entities.result!= undefined){
		   
		   var newActicities = entities.result.parameterEmergent;
		   var ds = entities.commons.api.vc.model['ActivitiesList'];
			var dsData = ds.data();
			if(newActicities != undefined){
			 if(newActicities.length > 0){
		      for (var i = 0; i < newActicities.length; i ++) {
					var activityL = newActicities[i];
					var flagValue=0;
					  for (var j = 0; j < dsData.length; j ++) {
						var dsRow = dsData[j];
						if((dsRow.CodActivities === activityL.CodActivitiesEm)){
							flagValue=1;
							break;
						}

					 }
					 if(flagValue===0){
					 var newActivitiesList={
								CodActivities: activityL.CodActivitiesEm,
								Description : activityL.DescriptionEm                 
							};				
							entities.commons.api.grid.addRow('ActivitiesList', newActivitiesList);
					}
			  }
			  
			    var ds = entities.commons.api.vc.model['ActivitiesList'];
	              var dsData = ds.data();
			      for (var i = 0; i < dsData.length; i ++) {
						var dsRow = dsData[i];
						if((dsRow.CodActivities === "")){
							entities.commons.api.grid.removeRow('ActivitiesList', i );
						}

					 }
			  }
			  else {
			        

			      var ds = entities.commons.api.vc.model['ActivitiesList'];
	              var dsData = ds.data();
			      for (var i = 0; i < dsData.length; i ++) {
						var dsRow = dsData[i];
						if((dsRow.CodActivities === "")){
							entities.commons.api.grid.removeRow('ActivitiesList', i );
						}

					 }
			  }
			  }
		   
		   } else {
		            

			      var ds = entities.commons.api.vc.model['ActivitiesList'];
	              var dsData = ds.data();
			      for (var i = 0; i < dsData.length; i ++) {
						var dsRow = dsData[i];
						if((dsRow.CodActivities === "")){
							entities.commons.api.grid.removeRow('ActivitiesList', i );
						}

					 }
			  }
		  
         
    
    };
    
    
    

    //SelectingActivities QueryView: GridActivitiesList 
    task.gridRowSelecting.QV_CIVII5836_15 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormMaintenanceCatalog 
    task.initData.VC_TENAO99_ANEAO_134 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
    };

}());