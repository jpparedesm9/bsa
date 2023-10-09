//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanStatusChangeMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        /*var header=$("#VC_VUYOJBQTYU_229120");
		var pageContent=$("#VC_LOANSTATCE_588120");
		header.insertBefore(pageContent);
		renderEventArgs.commons.api.viewState.addStyle('VC_VUYOJBQTYU_229120', 'container-header');
		renderEventArgs.commons.api.viewState.addStyle('VA_VASIMPLELABELLL_867612', 'secondary-label');
		renderEventArgs.commons.api.viewState.addStyle('VA_VASIMPLELABELLL_143612', 'label-header-principal');
		$(VA_VASIMPLELABELLL_143612).append('<span class="glyphicon glyphicon-info-sign"></span>')*/
        ASSETS.Header.setDataStyle("VC_LOANSTATCE_588120","VC_VUYOJBQTYU_229120",entities, renderEventArgs); 
                 
        ASSETS.Amortization.showTableAmortization(entities, renderEventArgs);
		ASSETS.Amortization.CapitalBalance(entities.Amortization.data());
        ASSETS.Amortization.resizeGrid("QV_8237_80795");
    };