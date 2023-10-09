//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: EntryWarranty
    task.render = function (entities, renderEventArgs){
       var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
    	
    	if (parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == 'Q') {
    		task.hideModeQuery(renderEventArgs);    	
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
        
    };

task.hideModeQuery = function(args) {
		
		//Variables
		var api = args.commons.api;
		var personalGuarantorDs = api.vc.model['PersonalGuarantor'].data();
		var otherWarrantyDs = api.vc.model['OtherWarranty'].data();

		//Deshabilito los botones
		args.commons.api.vc.viewState.CM_EYWRY63SOA19.visible = false;
		args.commons.api.vc.viewState.VA_UARNTEESEW9610_HBTN418.visible = false;
		args.commons.api.vc.viewState.VA_UARNTEESEW9610_0000924.visible = false;
		BUSIN.API.GRID.hideCommandColumns('QV_PESAU2317_81',personalGuarantorDs,api,'edit');
		BUSIN.API.GRID.hideCommandColumns('QV_PESAU2317_81',personalGuarantorDs,api,'delete');				
		BUSIN.API.GRID.hideCommandColumns('QV_URYTH5890_66',otherWarrantyDs,api,'edit');
		BUSIN.API.GRID.hideCommandColumns('QV_URYTH5890_66',otherWarrantyDs,api,'delete');		
		
		//Set del campo HiddenInCompleted para poder continuar la tarea
		args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			
	};

task.showButtons = function(args){
		var api = args.commons.api;
		var parentParameters = args.commons.api.parentVc.customDialogParameters;

		if(parentParameters.Task.urlParams.MODE!= undefined&&parentParameters.Task.urlParams.MODE!=null
		&&parentParameters.Task.urlParams.MODE=="Q"){
			args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}else {
		
		// Boton Secundario 1 (Wizard)
			//(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
			//(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
			//(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
		// (Tiene una limitacion de 5 axecute commands)			
		args.commons.api.vc.parentVc.labelExecuteCommand1 = "Asociar";
		args.commons.api.vc.parentVc.executeCommand1 = function(){
			args.commons.api.vc.executeCommand('CM_EYWRY63SOA19','Associate', undefined, true, false, 'VC_EYWRY63_FMRRT_302', false);
		}					
			//Set del campo HiddenInCompleted para poder continuar la tarea
			args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";			
			
		
		}

		
			
	};