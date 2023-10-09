//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RatesModal
    task.initData.VC_RATESMODAL_789953 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        mode = initDataEventArgs.commons.api.vc.mode;
        closeModal = false;
        
        if (entities.Rates.valueDeafult == null) 
            entities.Rates.valueDeafult = 0;
        if (entities.Rates.valueMin == null) 
            entities.Rates.valueMin = 0;
        if (entities.Rates.valueMax == null) 
            entities.Rates.valueMax = 0;
        if (entities.Rates.lockedDefault == null) 
            entities.Rates.lockedDefault = 0;
        if (entities.Rates.lockedMin == null) 
            entities.Rates.lockedMin = 0;
        if (entities.Rates.lockedMax == null) 
            entities.Rates.lockedMax = 0;
        if (entities.Rates.value == null) 
            entities.Rates.value = 0;
        
        if (mode == 1) {
            //Valida que haya seleccionado una tasa en el grid de tasas
            var selectedTypeRate = initDataEventArgs.commons.api.parentVc.grids.QV_1722_99596.selectedItem;
            if (typeof(selectedTypeRate) === 'undefined') {
                closeModal = true;
                return;
            }
            entities.Rates.clase = selectedTypeRate.clase;
            entities.Rates.rateType = selectedTypeRate.identifier;
        }
        portfolioClassAux = '';
        if (entities.Rates.portfolioClass != null && entities.Rates.portfolioClass != '') {
            entities.Rates.portfolioClass = entities.Rates.portfolioClass.trim();
            portfolioClassAux = entities.Rates.portfolioClass;
        }
        
        if (entities.Rates.clase == 'F') {
            initDataEventArgs.commons.api.viewState.enable("VA_REFERENCEVALEEE_875778");
            initDataEventArgs.commons.api.viewState.enable("VA_TYPEPOINTSQGJRC_416778");
            initDataEventArgs.commons.api.viewState.enable("VA_NUMBERDECIMALSL_248778");
            initDataEventArgs.commons.api.viewState.enable("VA_SIGNMINPDDMQZST_831778");
            initDataEventArgs.commons.api.viewState.enable("VA_SIGNMINKUSGFZGN_277778");
            initDataEventArgs.commons.api.viewState.enable("VA_VALUEMINGCHKTLJ_996778");
            initDataEventArgs.commons.api.viewState.enable("VA_SIGNMAXCQWMGYQB_195778");
            initDataEventArgs.commons.api.viewState.enable("VA_VALUEMAXAXNIZZF_909778");
            initDataEventArgs.commons.api.viewState.focus("VA_PORTFOLIOCLASSS_404778");
        } else {
            initDataEventArgs.commons.api.viewState.focus("VA_REFERENCEVALEEE_875778");
        }
    };