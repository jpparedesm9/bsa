//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: TConsolidatePenalization
    task.render = function (entities, renderEventArgs){
       var viewState = renderEventArgs.commons.api.viewState;
		BUSIN.API.hide(viewState,['CM_OTENA94AAI98']);
		var ctr = ['Office','Bank','bankclient','OperationStatus','Currency','Recommended','Amount','CapitalBalance','CapitalBalanceToDate','InterestBalance','InterestBalanceToDate','OtherBalance'];
		BUSIN.API.GRID.addColumnsStyle('QV_DTPEA0472_42', 'Grid-Column-Header',renderEventArgs.commons.api,ctr);
		//BUSIN.API.GRID.addColumnsStyle('QV_DTPEA0472_42', 'Grid-Column-Vertical-Align-Middle',renderEventArgs.commons.api,['Office','Bank','DescriptionClient','OperationStatus','Currency','Recommended']);
		//BUSIN.API.GRID.addColumnsStyle('QV_DTPEA0472_42', 'Grid-Column-White-Space-Normal',renderEventArgs.commons.api,['Amount','CapitalBalance','CapitalBalanceToDate','InterestBalance','InterestBalanceToDate','OtherBalance']);
		renderEventArgs.commons.api.grid.addColumnStyle('QV_DTPEA0472_42', 'Recommended', 'Grid-Column-Text-Align-Center');
		//renderEventArgs.commons.api.grid.addColumnStyle('QV_DTPEA0472_42','VA_VOSOLDTENI3504_CTDT512','cb-icon-ok');		
		
		var ctrToHide = ['Office','OperationStatus','Amount','OtherBalance','Bank'];
		BUSIN.API.GRID.hideColumns('QV_DTPEA0472_42', ctrToHide,renderEventArgs.commons.api);
		
		renderEventArgs.commons.api.grid.addColumnStyle('QV_UMMAY4215_41','Office','Grid-Column-Vertical-Align-Middle');
		renderEventArgs.commons.api.grid.addColumnStyle('QV_UMMAY4215_41','Currency','Grid-Column-Vertical-Align-Middle');		
		
		BUSIN.API.GRID.addColumnsStyle('QV_UMMAY4215_41', 'Grid-Column-White-Space-Normal',renderEventArgs.commons.api,['CapitalBalance','CapitalBalanceToDate']);				
		
		if(task.Type !== FLCRE.CONSTANTS.OfficerType.ChiefAgency){
			renderEventArgs.commons.api.grid.addColumnStyle('QV_UMMAY4215_41','Office','Grid-Column-Vertical-Align-Middle');
		}
		
		var parametroReporte='N'
		if (parametroReporte==='S'){
			viewState.show('CM_OTENA94AAI98');
		}else{
			viewState.hide('CM_OTENA94AAI98');
		}

			
		//seteo de boton 
		if(entities.Punishment!=null){
			for (var i = 0; i< entities.Punishment.data().length; i++){
			var row = entities.Punishment.data()[i];
				if(row.Recommended ===false){
					$('#VA_VOSOLDTENI3504_CTDT512_' + row.Operation).show();
				}
				if(row.Status=='R'){
					$('#VA_CHECK01_' + row.Operation).show();
				}else{
					//smo para que al exportar recommended sea false
					row.Recommended=false;
					$('#VA_CHECK01_' + row.Operation).hide();
				}
			}
		}	
    };