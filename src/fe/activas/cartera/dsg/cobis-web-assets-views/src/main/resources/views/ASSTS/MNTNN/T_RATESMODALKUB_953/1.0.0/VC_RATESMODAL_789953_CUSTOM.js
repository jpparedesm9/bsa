/* variables locales de T_RATESMODALKUB_953*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.ratesmodal;
    

    var portfolioClassAux = "";
    var mode;
    var closeModal = false;
//"TaskId": "T_RATESMODALKUB_953"

task.calculateTotal = function (indicator, rate, eventArgs) {
        //indicator especifica campos a calcular
        
        if (rate.valueDeafult == null) 
            rate.valueDeafult = 0;
        if (rate.valueMin == null)
            rate.valueMin = 0;
        if (rate.valueMax == null) 
            rate.valueMax = 0;
        if (rate.lockedDefault == null) 
            rate.lockedDefault = 0;
        if (rate.lockedMin == null) 
            rate.lockedMin = 0;
        if (rate.lockedMax == null) 
            rate.lockedMax = 0;
        if (rate.value == null) 
            rate.value = 0;
        
        if (indicator == 0 || indicator == 1) {
            switch (rate.signDefault)  {
                case "+":
                    rate.lockedDefault = rate.value + rate.valueDeafult;
                    break;
                case "-":
                    rate.lockedDefault = rate.value - rate.valueDeafult;
                    break;
                case "*" :
                    rate.lockedDefault = rate.value * rate.valueDeafult;
                    break;
                case "/":
                    rate.lockedDefault = rate.value / rate.valueDeafult;
                    break;
            }
        }
    
        if (indicator == 0 || indicator == 2) {
            switch (rate.signMin) {
                case "+":
                    rate.lockedMin = rate.value  + rate.valueMin;
                    break;
                case "-":
                    if (rate.value - rate.valueMin < rate.lockedDefault) {
                       eventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_PUNTOSNAT_99220",true);
                       rate.valueMin = 0;
                       rate.valueMin = rate.lockedDefault;
                    } else {
                       rate.lockedMin = rate.value - rate.valueMin;
                    }
                    break;
                case "*":
                    rate.lockedMin = rate.value  * rate.valueMin;
                    break;
                case "/":
                    rate.lockedMin = rate.value  / rate.valueMin;
                    break;
            }
        }

        if (indicator == 0 || indicator == 3) {
            switch (rate.signMax) {
                case "+":
                    rate.lockedMax = rate.value + rate.valueMax;
                    break;
                case "-":
                    if (rate.value - rate.valueMax  < rate.lockedDefault) {
                       eventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_PUNTOSNAT_99220",true);
                       rate.valueMax = 0;
                       rate.lockedMax = rate.lockedDefault;
                    } else {
                       rate.lockedMax= rate.value - rate.valueMax;
                    }
                    break;
                case "*":
                    rate.lockedMax = rate.value * rate.valueMax;
                    break;
                case "/":
                    rate.lockedMax = rate.value / rate.valueMax;
                    break;
            }
        }
    }

    //Entity: Rates
    //Rates.referenceValue (ComboBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFERENCEVALEEE_875778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.Rates = true;
    };

//Entity: ServerParameter
    //ServerParameter.refresGridFlag (CheckBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_REFRESGRIDFLGAG_672778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.ServerParameter = true;
    };

//Start signature to callBack event to VA_REFRESGRIDFLGAG_672778
    task.changeCallback.VA_REFRESGRIDFLGAG_672778 = function(entities, changeEventArgs) {
        //here your code
        if (mode == 2 && entities.Rates.clase == 'F')
            task.calculateTotal(0, entities.Rates, changeEventArgs)
    };

//Entity: Rates
    //Rates.signMax (ComboBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SIGNMAXCQWMGYQB_195778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(3, entities.Rates, changeEventArgs);
        
    };

//Entity: Rates
    //Rates.signMin (ComboBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SIGNMINKUSGFZGN_277778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(2, entities.Rates, changeEventArgs);
        
    };

//Entity: Rates
    //Rates.signDefault (ComboBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SIGNMINPDDMQZST_831778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(1, entities.Rates, changeEventArgs);
        
    };

//Entity: Rates
    //Rates.valueDeafult (TextInputBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VALUEDEAFULTCGE_547778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(1, entities.Rates, changeEventArgs);
        
    };

//Entity: Rates
    //Rates.valueMax (TextInputBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VALUEMAXAXNIZZF_909778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(3, entities.Rates, changeEventArgs);
        
    };

//Entity: Rates
    //Rates.valueMin (TextInputBox) View: RatesModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VALUEMINGCHKTLJ_996778 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        task.calculateTotal(2, entities.Rates, changeEventArgs);
        
    };

// (Button) 
    task.executeCommand.CM_TRATESMO_AUS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var cancelButton = false;
        executeCommandEventArgs.commons.api.navigation.closeModal(cancelButton);
        
    };

// (Button) 
    task.executeCommand.CM_TRATESMO_TU_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        if (entities.Rates.clase == 'F') {
            if (entities.Rates.referenceValue == '') {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBEIEI_21995",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
            if (entities.Rates.typePoints == '') {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_DEBESELNT_56184",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
            if (entities.Rates.numberDecimals == 0 || entities.Rates.numberDecimals == null) {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBEDVE_50014",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
            if (entities.Rates.signDefault == '' || entities.Rates.signMin == '' || entities.Rates.signMax == '') {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBENST_55237",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
        }
        if (entities.Rates.portfolioClass == '') {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_LACLASESE_58190",true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        if (entities.Rates.lockedMin > entities.Rates.lockedMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_VALORMNIA_88442",true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        if (entities.Rates.lockedDefault < entities.Rates.lockedMin || entities.Rates.lockedDefault > entities.Rates.lockedMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_VALORESDA_30202",true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to callBack event to CM_TRATESMO_TU_
    task.executeCommandCallback.CM_TRATESMO_TU_ = function(entities, executeCommandEventArgs) {
        //here your code
        var aceptButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(aceptButton);
    };

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

//Entity: Rates
    //Rates.referenceValue (ComboBox) View: RatesModal
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_REFERENCEVALEEE_875778 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
        //loadCatalogEventArgs.commons.serverParameters.Rates = true;
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: RatesModal
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        if (closeModal) {
            var cancelButton = false;
            renderEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_DEBESELRN_17291",true);
            renderEventArgs.commons.api.navigation.closeModal(cancelButton);
            return;
        }
        
        if (mode == 2) {
            entities.Rates.portfolioClass = portfolioClassAux;
            
            //Traer el valor referencial
            if (entities.Rates.clase == 'F') {
                if (entities.ServerParameter.refresGridFlag == false || entities.ServerParameter.refresGridFlag == null) {
                    entities.ServerParameter.refresGridFlag = true;
                } else {
                    entities.ServerParameter.refresGridFlag = false;
                }
            }
        }
        
    };



}));