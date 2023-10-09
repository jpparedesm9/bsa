//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: [object Object]
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
    var ctr = ['Dividend', 'ExpirationDate', 'Balance', 'Item1', 'Item2'
		, 'Item3', 'Item4', 'Item5', 'Item6', 'Item7', 'Item8', 'Item9', 'Item10'
		, 'Item11', 'Item12', 'Item13', 'Fee'];
		BUSIN.API.GRID.addColumnsStyle('QV_QUYOI3312_16', 'Grid-Column-Header',renderEventArgs.commons.api,ctr);
    var viewState = renderEventArgs.commons.api.viewState
        , template;
    template = '<span><h3>#: code#</h3></span>' + '<span>#: attributes[0] #</span>';
		viewState.template('VA_VWPAYMENLA2618_BTCO941', template);
		//Calcular el Total del Saldo de Capital
		setTimeout(function() {
			task.setTotalLabel(viewState);
            task.calculateTotalCapitalBalance(entities.AmortizationTableItem.data());
        });
    var parameter = renderEventArgs.commons.api.parentVc.customDialogParameters;
    var ds = renderEventArgs.commons.api.vc.model['Category'];
    var dsData = ds.data();
    if (parameter.Task.urlParams.SOLICITUD == 'GRUPAL') {
        for (var i = 0; i < dsData.length; i++) {
            var dsRow = dsData[i];
            renderEventArgs.commons.api.grid.hideGridRowCommand('QV_UYCTE6570_70', dsRow, 'delete');
        }
    }
    };