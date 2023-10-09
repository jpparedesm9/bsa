//"TaskId": "T_FLCRE_45_OTENA94"
    task.Type = '';
	task.CanEdit = 'NO';
	task.ApplicationNumber = 0;

/*EVENTOS MANUALES*/
    task.gridRowCommand.VA_VOSOLDTENI3504_REOE379 = function (entities, args) { //QueryView: GConsolidatePenalization - VA_VOSOLDTENI3504_REOE379
        var nav ='';
		args.commons.execServer = false;		
		if(entities.HeaderPunishment.Status != FLCRE.CONSTANTS.StatusPenalization.Processed){					
			args.rowData.Recommended = !args.rowData.Recommended;			
			if(args.rowData.Recommended ===true){				
				$('#VA_VOSOLDTENI3504_CTDT512_' + args.rowData.Operation).hide();
				//$('#VA_VOSOLDTENI3504_OBSE727_' + args.rowData.Operation).val('');
				args.rowData.Observation = '';
			}else{				
				$('#VA_VOSOLDTENI3504_CTDT512_' + args.rowData.Operation).show();
				nav= FLCRE.API.getApiNavigation(args,'T_FLCRE_03_TAONE32','VC_TAONE32_GEPLI_734');
				nav.label = cobis.translate('BUSIN.DLB_BUSIN_SERVACINS_39064');
				nav.modalProperties = { size: 'mg' };
				nav.queryParameters = { mode: args.commons.constants.mode.Insert };
				nav.customDialogParameters = { HeaderPunishmentRow:args.rowData};
				nav.openModalWindow(args.commons.controlId);
			}			
		}
	};

    task.gridRowCommand.VA_VOSOLDTENI3504_CTDT512 = function(entities, gridRowCommandEventArgs) {
        gridRowCommandEventArgs.commons.execServer = false;		
		var nav ='';		
		nav= FLCRE.API.getApiNavigation(gridRowCommandEventArgs,'T_FLCRE_03_TAONE32','VC_TAONE32_GEPLI_734');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_SERVACINS_39064');
		nav.modalProperties = { size: 'mg' };
		nav.queryParameters = { mode: gridRowCommandEventArgs.commons.constants.mode.Insert };
		nav.customDialogParameters = { HeaderPunishmentRow:gridRowCommandEventArgs.rowData};
		nav.openModalWindow(gridRowCommandEventArgs.commons.controlId);        
    };

    task.closeModalEvent.VC_VREDE97_EREMM_306 = function (args) { //RESULTADO ENVIO DE RECOMENDACION
		var result = args.result;
		if(result[0] === FLCRE.CONSTANTS.RequestName.Castigo && result[2] === 'YES'){
			task.ApplicationNumber = result[3];
			args.commons.api.vc.executeCommand('CM_OTENA94IDE41','Hide', undefined, false, false, 'VC_OTENA94_SELZT_306', false);
		}
	};
	// Evento para recuperar valores de una pantalla modal cuando se cierra
	task.closeModalEvent.VC_TAONE32_GEPLI_734 = function(args) {
		if (args.result != null && args.result != undefined){
			for (var i = 0; i< args.model.Punishment.data().length; i++){
			var row = args.model.Punishment.data()[i];
				if(row.uid===args.result.uid){
                    if (args.result.Observation !== null && args.result.Observation.trim() !== '') {
						row.Observation=args.result.Observation;
					}
				}
			}
		}
	};

    //**********************************************************
    //  FUNCIONES DE UTILERIA
    //**********************************************************
    task.setSecurity = function(entities, Args , Source) {
		var api=Args.commons.api;
		if(Args.success===true){
			var viewState = Args.commons.api.viewState;
			if(entities.HeaderPunishment.Status===FLCRE.CONSTANTS.StatusPenalization.Processed ||
			  (task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='NO') ){				
				BUSIN.API.disable(viewState,['CM_OTENA94AAI98','CM_OTENA94COM63','CM_OTENA94IDE41']);
				Args.commons.messageHandler.showTranslateMessagesInfo('BUSIN.DLB_BUSIN_RCESIADOM_93424',null);
				Args.commons.api.ext.timeout(function(){
					for (var i = 0; i< entities.Punishment.data().length; i++){
						var row = entities.Punishment.data()[i];
						if(row.Recommended ===false){
							/*$('#SPAN_VA_VOSOLDTENI3504_OBSE727_' + row.Operation).show();
							$('#DIV_VA_VOSOLDTENI3504_OBSE727_' + row.Operation).hide();*/
							$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).show();
							$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).attr("disabled",false);
						}
						if(task.Type!==FLCRE.CONSTANTS.OfficerType.Inbox){
							$('#VA_VOSOLDTENI3504_REOE379_' + row.Operation).prop( "disabled", true );
						}else{
							$('#VA_VOSOLDTENI3504_REOE379_' + row.Operation).prop( "disabled", false );
						}
						
					}
				},1000);			
			} else{
				if(Source==='CM_OTENA94GAD25'){
					BUSIN.API.enable(viewState,['CM_OTENA94GAD25','CM_OTENA94COM63']);
				}else if(Source==='INIT'){
					BUSIN.API.enable(viewState,['CM_OTENA94GAD25']);
				}			
			}
		}
		/*for (var i = 0; i< entities.Punishment.data().length; i++){
			var dsRow = entities.Punishment.data()[i];
			if(dsRow.Status === 'R'){
				api.grid.showGridRowCommand('QV_DTPEA0472_42', dsRow, 'VA_VOSOLDTENI3504_CTDT512');
			}
			else {						
				api.grid.hideGridRowCommand('QV_DTPEA0472_42', dsRow, 'VA_VOSOLDTENI3504_CTDT512');
				//viewState.disable('CM_OTENA94GAD25');
			}
		}*/
    };
	task.validateStatus = function(entities, args, showMessage) {
		if(entities.HeaderPunishment.Status === FLCRE.CONSTANTS.StatusPenalization.Processed){ //ESTADO PROCESADO
			if(showMessage===true){
				args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_STORIOEAA_96312',null,6000);
			}
			return false;
		}
		return true;
    };
	
	task.validateObservations = function(entities, args, showMessage) {
		
		for (var i = 0; i< entities.Punishment.data().length; i++){
		var row = entities.Punishment.data()[i];
			if(!row.Recommended){
				if (row.Observation === null || row.Observation.trim() === ''){
					args.commons.messageHandler.showTranslateMessagesError('Una o más Observaciones requeridas no se encuentran ingresadas',null,6000);
					return false;
				}
			}
		}
		return true;
    };

/*FIN EVENTOS MANUALES*/