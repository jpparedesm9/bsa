//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: QueryGeneralInformationMain
    task.render = function (entities, renderEventArgs){
        ASSETS.Header.setDataStyle("VC_GENERALITN_743443", "VC_PBXJORPCKR_929443", entities, renderEventArgs);	
        if(entities.ColumnsDataValue.col56 == 'S'){
              api.viewState.label(loan.operationType+"-PROMOCION");
        }				
		
		ASSETS.Amortization.showTableAmortization(entities, renderEventArgs);  
		ASSETS.Amortization.CapitalBalance(entities.Amortization.data());
		ASSETS.Amortization.resizeGrid("QV_8237_80795");
		// STYLES CHART
		renderEventArgs.commons.api.grid.title("QV_6100_21620", "statusAmortization", "", null, null);
        $("#QV_6100_21620 tbody .ng-scope:nth-child(3)").css("font-weight", "bold");
        $("#QV_6100_21620 tbody .ng-scope:nth-child(5)").css("font-weight", "bold");
        
        
        renderEventArgs.commons.api.grid.hideColumn('QV_1439_82210', 'sequentialQuery');
        renderEventArgs.commons.api.grid.hideColumn('QV_1439_82210', 'sequentialIdentity');
        
    };