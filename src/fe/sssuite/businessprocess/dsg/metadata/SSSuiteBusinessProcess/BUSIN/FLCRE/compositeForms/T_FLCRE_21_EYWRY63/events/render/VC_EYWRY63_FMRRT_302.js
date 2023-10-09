//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: EntryWarranty
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
          	
    	var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
    	
    	if (parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == 'Q') {
    		task.hideModeQuery(renderEventArgs);
    	} else {
    		
			//Boton Secundario 1 (Wizard)
			//(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
			//(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
			//(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
			//(Tiene una limitacion de 5 axecute commands)
    		renderEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 = "Asociar";
    		renderEventArgs.commons.api.vc.parentVc.executeCommand1 = function() {
    			renderEventArgs.commons.api.vc.executeCommand('CM_EYWRY63SOA19','Associate', undefined, true, false, 'VC_EYWRY63_FMRRT_302', false);
			}
			//Set del campo HiddenInCompleted para poder continuar la tarea
			renderEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
    	}
    	
    	var columns1 = ['CodeWarranty','Type','Description','GuarantorPrimarySecondary','ClassOpen','IdCustomer','State','CurrentValue',
        	            'Currency'];
        BUSIN.API.GRID.addColumnsStyle('QV_PESAU2317_81', 'Grid-Column-Header',renderEventArgs.commons.api,columns1);
        
        var columns2 = ['CodeWarranty','Type','Description','InitialValue','DateAppraisedValue','ValueApportionment','ClassOpen','ValueAvailable',
       	            'IdCustomer','NameGar','State','ValueVNR','RelationshipGuarantees'];
        BUSIN.API.GRID.addColumnsStyle('QV_URYTH5890_66', 'Grid-Column-Header',renderEventArgs.commons.api,columns2);
        
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'CodeWarranty', 150);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'Description', 110);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'DateAppraisedValue', 90);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'InitialValue', 90);
        renderEventArgs.commons.api.grid.resizeGridColumn('QV_URYTH5890_66', 'State', 110);
       
	   task.showButtons(renderEventArgs);
	   if(entities.OriginalHeader.TypeRequest == 'L'){
			renderEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}
	   
	
        
    };