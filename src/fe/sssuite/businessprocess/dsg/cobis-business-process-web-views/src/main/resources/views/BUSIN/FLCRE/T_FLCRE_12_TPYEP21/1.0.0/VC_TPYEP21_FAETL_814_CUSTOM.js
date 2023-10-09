/* variables locales de T_FLCRE_12_TPYEP21*/

// varible de comparacion de fecha
var fechaValidacion;
var processDateTemp; // Req.194284 Dia de Pago

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

    
        var task = designerEvents.api.tpaymentplan;
    

    //"TaskId": "T_FLCRE_12_TPYEP21"
"use strict";
var task = designerEvents.api.tpaymentplan;
task.IsDisbursement = false;
task.TipoTramite = '';
task.Etapa = '';
var isFirstTime = true;
var grupos = null;
var taskHeader = {};
var wasInInitData = false;
var quotaHasChange = false;
var wasInExecuteCommandCallback = false;
var initQuota = 0;
var itemsHeader = [];
var passInitDataCallback = false;
task.creditType = undefined;
//**********************************************************
//  FUNCIONES DE UTILERIA
//**********************************************************
task.setTipoTabla = function (paymentPlan, args, entities) {
    var viewState = args.commons.api.viewState;
    var grupos = ['VA_VWPAYMENLA2605_PILO354', 'VA_VWPAYMENLA2605_IALR796'
						, 'VA_VWPAYMENLA2605_EREP542', 'VA_VWPAYMENLA2605_EACE223'
						, 'VA_VWPAYMENLA2605_ATTE607', //Fecha de Pago Fija
						'VA_VWPAYMENLA2617_OHOI726']; //Evitar Feriados
    //['GR_VWPAYMENLA26_05','GR_VWPAYMENLA26_08','VA_VWPAYMENLA2605_CTAL200','VA_VWPAYMENLA2605_QUOT436'];
    var ctrMan = ['GR_VWPAYMENLA26_05', 'GR_VWPAYMENLA26_08', 'GR_VWPAYMENLA26_17'];
    task.setFechaPagoFija(entities.PaymentPlan, args.commons.api.viewState);
    if (isFirstTime == false) {
        if (paymentPlan.tableType == 'ALEMANA') {
            BUSIN.API.show(viewState, ctrMan);
            BUSIN.API.show(viewState, ['VA_VWPAYMENLA2605_BLYE585', 'VA_VWPAYMENLA2605_NENT977']);
            viewState.show('VA_VWPAYMENLA2607_TERM808'); //Frecuencia de Pago
            viewState.hide('VA_VWPAYMENLA2607_QUOT918');
            viewState.show('VA_VWPAYMENLA2607_ATQC570'); //Plazo
            viewState.show('VA_VWPAYMENLA2617_GARR154'); //días de gracia mora
            viewState.show('VA_VWPAYMENLA2617_OHOI726'); // evitar feriados
            viewState.enable('VA_VWPAYMENLA2607_UATI478'); //Base de Cálculo Interés
            task.disableToolbarAmortizationTable(args, 'AmortizationTableItem', 'QV_QUYOI3312_16', false);
            BUSIN.API.enable(viewState, grupos);
            paymentPlan.quota = 0;
        }
        else if (paymentPlan.tableType == 'FRANCESA') {
            BUSIN.API.show(viewState, ctrMan);
            BUSIN.API.show(viewState, ['VA_VWPAYMENLA2607_QUOT918']);
            viewState.show('VA_VWPAYMENLA2607_TERM808'); //Frecuencia de Pago
            //viewState.hide('VA_VWPAYMENLA2605_BLYE585');
            viewState.show('VA_VWPAYMENLA2607_ATQC570'); //Plazo
            viewState.show('VA_VWPAYMENLA2617_GARR154'); //días de gracia mora
            viewState.show('VA_VWPAYMENLA2617_OHOI726'); // evitar feriados
            viewState.enable('VA_VWPAYMENLA2607_UATI478'); //Base de Cálculo Interés
            task.disableToolbarAmortizationTable(args, 'AmortizationTableItem', 'QV_QUYOI3312_16', false);
            BUSIN.API.enable(viewState, grupos);
            paymentPlan.capital = 0;
        }
        else if (paymentPlan.tableType == 'MANUAL') {
            BUSIN.API.hide(viewState, ctrMan);
            paymentPlan.basCalculationInterest = "R";
            viewState.hide('VA_VWPAYMENLA2605_NENT977');
            viewState.hide('VA_VWPAYMENLA2607_QUOT918'); //Cuota
            viewState.hide('VA_VWPAYMENLA2607_TERM808'); //Frecuencia de Pago
            viewState.hide('VA_VWPAYMENLA2607_ATQC570'); //Plazo
            viewState.hide('VA_VWPAYMENLA2617_GARR154'); //días de gracia mora
            viewState.disable('VA_VWPAYMENLA2607_UATI478'); //Base de Cálculo Interés
            task.disableToolbarAmortizationTable(args, 'AmortizationTableItem', 'QV_QUYOI3312_16', true);
            BUSIN.API.disable(viewState, grupos);
            /*paymentPlan.capital = "";
            paymentPlan.quota = 0;
            paymentPlan.capitalPeriod = 1;
            paymentPlan.capitalPeriodGrace = 0;
            paymentPlan.interestPeriod = 1;
            paymentPlan.interestPeriodGrace = 0;
            paymentPlan.term = 1;
            /*paymentPlan.paymentDay = "";
            paymentPlan.graceArrearsDays = "";
            paymentPlan.termType = "1";
            paymentPlan.quotaType = "M";
            paymentPlan.graceArrearsDays =1;*/
        }
    }
    else {
        if (paymentPlan.tableType == 'ALEMANA') {
            //viewState.show('VA_VWPAYMENLA2605_BLYE585');
            viewState.hide('VA_VWPAYMENLA2607_QUOT918');
            paymentPlan.quota = 0;
        }
        else if (paymentPlan.tableType == 'FRANCESA') {
            //BUSIN.API.show(viewState,['VA_VWPAYMENLA2615_FEEQ754','VA_VWPAYMENLA2607_QUOT918']);  //CPN ruteo
            paymentPlan.capital = 0;
        }
    }
};
task.setBaseCalculo = function (paymentPlan, viewState) {
    viewState.disable('VA_VWPAYMENLA2605_ETDY540');
    if (paymentPlan.calculationBased == 'E') { //Calendario
        viewState.enable('VA_VWPAYMENLA2605_BLYE585');
    }
    else {
        //viewState.disable('VA_VWPAYMENLA2605_BLYE585');
    }
};
task.setFechaPagoFija = function (paymentPlan, viewState) {
    if (paymentPlan.fixedpPaymentDate == 'S') {
        viewState.enable('VA_VWPAYMENLA2605_ETDY540');
    }
    else {
        paymentPlan.paymentDay = 0;
        viewState.disable('VA_VWPAYMENLA2605_ETDY540');
    }
};
task.aditionalPayment = function (GeneralParameterLoan, viewState) {
    viewState.disable('VA_VWPAYMENLA2613_METY312');
    viewState.disable('VA_VWPAYMENLA2613_OIAL525');
    viewState.disable('VA_VWPAYMENLA2613_YECY309');
    if (GeneralParameterLoan.acceptsAdditionalPayments == 'S') {
        viewState.enable('VA_VWPAYMENLA2613_METY312');
        GeneralParameterLoan.paymentType = 'N';
    }
    else {
        viewState.disable('VA_VWPAYMENLA2613_METY312');
        GeneralParameterLoan.applyOnlyCapital = false;
        GeneralParameterLoan.paymentType = undefined;
        GeneralParameterLoan.extraordinaryEffectPayment = undefined;
    }
};
task.setTipoPago = function (GeneralParameterLoan, viewState) {
    if (GeneralParameterLoan.paymentType == 'E') {
        GeneralParameterLoan.applyOnlyCapital = true;
        viewState.enable('VA_VWPAYMENLA2613_OIAL525');
        viewState.enable('VA_VWPAYMENLA2613_YECY309');
    }
    else {
        viewState.disable('VA_VWPAYMENLA2613_OIAL525');
        viewState.disable('VA_VWPAYMENLA2613_YECY309');
        GeneralParameterLoan.applyOnlyCapital = false;
        GeneralParameterLoan.extraordinaryEffectPayment = undefined;
    }
};
task.setExchangeRate = function (entities, viewState) {
    if (entities.GeneralParameterLoan.exchangeRate == 'F') {
        viewState.disable('VA_VWPAYMENLA2613_OITY628');
        //viewState.enable('VA_VWPAYMENLA2613_PERM620');
        viewState.enable('GR_VWPAYMENLA26_14');
        entities.GeneralParameterLoan.periodicity = 0;
    }
    else if (entities.GeneralParameterLoan.exchangeRate == 'N') {
        viewState.disable('VA_VWPAYMENLA2613_OIAL525');
        //viewState.disable('VA_VWPAYMENLA2613_PERM620');
        viewState.disable('VA_VWPAYMENLA2613_OITY628');
        viewState.disable('GR_VWPAYMENLA26_14');
        entities.GeneralParameterLoan.keepTerm = undefined
        entities.GeneralParameterLoan.periodicity = 0;
    }
    else {
        viewState.enable('VA_VWPAYMENLA2613_OITY628');
        //viewState.enable('VA_VWPAYMENLA2613_OIAL525');
        //viewState.enable('VA_VWPAYMENLA2613_PERM620');
        viewState.enable('GR_VWPAYMENLA26_14');
        entities.GeneralParameterLoan.periodicity = 0;
    }
    if (entities.OriginalHeader.Agreement === 'S') {
        viewState.disable('VA_VWPAYMENLA2613_HNGE724');
        viewState.disable('GR_VWPAYMENLA26_14');
    }
};
//Validacion primera pregunta
task.setChangeQuestionYesNoOneQ = function (ApprovalCriteriaQuestion, viewState) {
    if (ApprovalCriteriaQuestion.otherDebtCICQuestion == 'S') {
        viewState.enable('VA_PROVTRIUST5751_AEET295'); //Se habilita la preguta 1.1
        viewState.disable('VA_PROVTRIUST5751_AETE696'); //Se desabilita la preguta 1.2
        ApprovalCriteriaQuestion.currentRateFIE = ''; //Se borra el campo Calificación Actual FIE
        ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion = ''; //Se borra el valor de la pregunta 1.2
    }
    else if (ApprovalCriteriaQuestion.otherDebtCICQuestion == 'N') {
        viewState.disable('VA_PROVTRIUST5751_AEET295'); //Se desabilita la preguta 1.1
        viewState.disable('VA_PROVTRIUST5751_AETE696'); //Se desabilita la preguta 1.2
        ApprovalCriteriaQuestion.sharedEntityQuestion = ''; //Se borra el valor de la pregunta 1.1
        ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion = ''; //Se borra el valor de la pregunta 1.2
        ApprovalCriteriaQuestion.currentRateFIE = ApprovalCriteriaQuestion.previousRateFIE; //Se asigna el valor inicial de la calificacion
    }
};
//validacion segunda pregunta
task.setChangeQuestionYesNoTwoQ = function (ApprovalCriteriaQuestion, viewState) {
    if (ApprovalCriteriaQuestion.sharedEntityQuestion == 'S') {
        viewState.enable('VA_PROVTRIUST5751_AETE696'); //Se desabilita la preguta 1.2
    }
    else if (ApprovalCriteriaQuestion.sharedEntityQuestion == 'N') {
        viewState.enable('VA_PROVTRIUST5751_AETE696'); //Se desabilita la preguta 1.2
        ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion = ''; //Se borra el valor de la pregunta 1.2
    }
};
//validacion de la tercera pregunta
task.setChangeQuestionYesNoThreeQ = function (ApprovalCriteriaQuestion) {
    if (ApprovalCriteriaQuestion.comparedExplusiveCustomerQuestion == 'S') { //Se mantiene la calificacion del cliente
        ApprovalCriteriaQuestion.currentRateFIE = ApprovalCriteriaQuestion.previousRateFIE; //Se asigna la calificacion antigua
        ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
        ApprovalCriteriaQuestion.customerCPOPQuestion = '';
        task.setQuestionMaximumDiscoun(ApprovalCriteriaQuestion);
    }
};
//Validaciones para la pregunta 2
/*validacion Pregunta 4*/
task.setChangeQuestionFourV2 = function (entities, viewState) {
        //Se cuenta el total de deudores para habilitar las siguientes preguntas
        var debtors = entities.DebtorGeneral.data().length;
        entities.ApprovalCriteriaQuestion.recordsMatchingQuestion == ''
            //Pregunta igual a No
        if (entities.ApprovalCriteriaQuestion.customerCPOPQuestion == 'N') {
            entities.ApprovalCriteriaQuestion.applyRebateCROP = 'N';
            if (debtors > 1) { //Es mas de un solicitante se activa la siguiente pregunta 2.1
                viewState.disable('VA_PROVTRIUST5751_RORT690');
            }
            //if(debtors == 1){
            if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'C' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'X' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX') {
                entities.ApprovalCriteriaQuestion.currentRateFIE = 'B';
            }
            task.setQuestionMaximumDiscoun(entities.ApprovalCriteriaQuestion);
            //}else{
            //Se mantiene la calificacion de CCA
            //entities.ApprovalCriteriaQuestion.currentRateFIE = entities.ApprovalCriteriaQuestion.previousRateFIE; //calificacion anterior
            if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX') {
                entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
            }
            else if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'X') {
                entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
            }
            else if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'C') {
                entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
            }
        }
        //Pregunta igual a Si
        if (entities.ApprovalCriteriaQuestion.customerCPOPQuestion == 'S') {
            entities.ApprovalCriteriaQuestion.applyRebateCROP = 'S';
            //task.setCustomerRating(entities); //Valida el valor de la calificacion
            task.setQuestionMaximumDiscoun(entities.ApprovalCriteriaQuestion);
            if (debtors > 1) { //Es mas de un solicitante se activa la siguiente pregunta 2.1
                viewState.enable('VA_PROVTRIUST5751_RORT690');
            }
            if (debtors == 1) { //Es un solo solicitante Aplica condiciones preferentes
                viewState.disable('VA_PROVTRIUST5751_RORT690');
                if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'C' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'X' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX') {
                    entities.ApprovalCriteriaQuestion.currentRateFIE = 'B';
                }
                task.setQuestionMaximumDiscoun(entities.ApprovalCriteriaQuestion);
            }
        }
    }
    /* fin validacion pregunta 4*/
    //Validaciones para la pregunta 2.1
task.setChangeQuestionFive = function (entities, viewState) {
        if (entities.ApprovalCriteriaQuestion.recordsMatchingQuestion == 'S') {
            entities.ApprovalCriteriaQuestion.applyRebateCROP = 'S';
            //task.setCustomerRating(entities);
            entities.ApprovalCriteriaQuestion.customerNoCPOPQuestion = '';
            viewState.disable('VA_PROVTRIUST5751_OQSO123'); //Se habilita la pregunta 2.1.1
            task.preferenceConditions(entities, viewState);
        }
        else if (entities.ApprovalCriteriaQuestion.recordsMatchingQuestion == 'N') {
            entities.ApprovalCriteriaQuestion.applyRebateCROP = ''; //Se mantiene en blanco el campo Rebaja CPOP
            viewState.enable('VA_PROVTRIUST5751_OQSO123'); //Se habilita la pregunta 2.1.1
            if (entities.ApprovalCriteriaQuestion.previousRateFIE == 'XX') {
                entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
            }
            else if (entities.ApprovalCriteriaQuestion.previousRateFIE == 'X') {
                entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
            }
            else if (entities.ApprovalCriteriaQuestion.previousRateFIE == 'C') {
                entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
            }
        }
    }
    //Validaciones para la pregunta 2.1.1
task.setChangeQuestionYesNoSixQ = function (entities, args) {
    var viewState = args.commons.api.viewState
    if (entities.ApprovalCriteriaQuestion.customerNoCPOPQuestion == 'N') {
        entities.ApprovalCriteriaQuestion.applyRebateCROP = 'S';
        task.preferenceConditions(entities, viewState);
    }
    else if (entities.ApprovalCriteriaQuestion.customerNoCPOPQuestion == 'S') {
        entities.ApprovalCriteriaQuestion.applyRebateCROP = 'N';
        if (entities.ApprovalCriteriaQuestion.previousRateFIE == 'XX') {
            entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
        }
        else if (entities.ApprovalCriteriaQuestion.previousRateFIE == 'X') {
            entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
        }
        else if (entities.ApprovalCriteriaQuestion.previousRateFIE == 'C') {
            entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 0;
        }
    }
};
//funcion para validar la calificacion del cliente
task.setCustomerRating = function (entities) {
    if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'AA' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'A' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'B') {
        entities.ApprovalCriteriaQuestion.currentRateFIE = entities.ApprovalCriteriaQuestion.previousRateFIE;
    }
    else if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'C' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'X' || entities.ApprovalCriteriaQuestion.currentRateFIE == 'XX') {
        entities.ApprovalCriteriaQuestion.currentRateFIE = 'B';
    }
}
task.setQuestionMaximumDiscoun = function (ApprovalCriteriaQuestion) {
    if (ApprovalCriteriaQuestion.currentRateFIE == 'AA') {
        ApprovalCriteriaQuestion.maximumDiscountCustomerType = 3;
    }
    else if (ApprovalCriteriaQuestion.currentRateFIE == 'A') {
        ApprovalCriteriaQuestion.maximumDiscountCustomerType = 2;
    }
    else if (ApprovalCriteriaQuestion.currentRateFIE == 'B') {
        ApprovalCriteriaQuestion.maximumDiscountCustomerType = 1;
    }
};
task.validateExistsOperation = function (existsOperation, entities, args) {
    var viewState = args.commons.api.viewState;
    var ctrs = ['GR_VWPAYMENLA26_07', 'GR_VWPAYMENLA26_08', 'GR_VWPAYMENLA26_05', 'GR_VWPAYMENLA26_13'];
    if (existsOperation) {
        BUSIN.API.enable(viewState, ctrs);
        task.setTipoTabla(entities.PaymentPlan, args, entities);
        task.setBaseCalculo(entities.PaymentPlan, viewState);
        task.setFechaPagoFija(entities.PaymentPlan, viewState);
    }
    else {
        BUSIN.API.disable(viewState, ctrs);
    }
};
task.setValidateProposedRate = function (ApprovalCriteriaQuestion) {
    if (ApprovalCriteriaQuestion.rebateCustomerType < ApprovalCriteriaQuestion.tariffRate) {
        ApprovalCriteriaQuestion.proposedRate = ApprovalCriteriaQuestion.tariffRate - ApprovalCriteriaQuestion.rebateCustomerType;
        ApprovalCriteriaQuestion.proposedRate = ApprovalCriteriaQuestion.proposedRate.toFixed(2);
    }
};
task.setValidateTariffRate = function (ApprovalCriteriaQuestion, viewState) {
    if (ApprovalCriteriaQuestion.applyRebateCROP == 'S') {
        if (ApprovalCriteriaQuestion.tariffRate < 1 && ApprovalCriteriaQuestion.tariffRate > 0) {
            ApprovalCriteriaQuestion.proposedRate = 'entre';
        }
        else {
            viewState.translate('BUSIN.DLB_BUSIN_SDFIVNE0Y_61468');
        }
    }
};
task.setScrollAmortizationTable = function (sizeData, api) {
    api.viewState.addStyle('QV_QUYOI3312_16', 'tablaAmortizacion');
}
task.formatAmortizationTable = function (entities, api) {
    //TITULO EN COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
    var maxNumRubros = 13;
    if (entities.AmortizationTableHeader.length != undefined) {
        var count = entities.AmortizationTableHeader.length - 1;
        var categories = entities.Category.data();
        var category;
        if (count > maxNumRubros) count = maxNumRubros;
        for (var i = 1; i <= count; i++) {
            api.grid.title("QV_QUYOI3312_16", "Item" + i, entities.AmortizationTableHeader[i].Description, false);
            api.grid.format('QV_QUYOI3312_16', "Item" + i, '#,##0.00');
            api.grid.showColumn('QV_QUYOI3312_16', "Item" + i);
            itemsHeader.push({
                id: "Item" + i
                , title: entities.AmortizationTableHeader[i].Description
                , nemonic: entities.AmortizationTableHeader[i].Concept
            });
            //Habilitar los rubros que no son de tipo interés	
            for (var j = 0; j < categories.length; j++) {
                category = categories[j];
                if (entities.AmortizationTableHeader[i].Concept.trim() == category.Concept.trim()) {
                    if (category.ConceptType.trim() == 'I') {
                        api.grid.disabledColumn('QV_QUYOI3312_16', 'Item' + i);
                    }
                    else {
                        api.grid.enabledColumn('QV_QUYOI3312_16', 'Item' + i);
                    }
                    break;
                }
            };
        }
        api.grid.format('QV_QUYOI3312_16', "Balance", '#,##0.00');
        api.grid.format('QV_QUYOI3312_16', "Fee", '#,##0.00');
        //OCULTA COLUMNAS DEL GRID DE TABLA DE AMORTIZACION
        if (count < maxNumRubros) {
            for (var i = count + 1; i <= maxNumRubros; i++) {
                api.grid.hideColumn('QV_QUYOI3312_16', 'Item' + i);
            }
        }
    }
};
task.formatPaymentCapacityTable = function (entities, args) {
    return true;
};
task.updateRow = function (entities, api) {
    var listCat = entities.Category.data();
    for (var i = 0; i < listCat.length; i++) {
        if (listCat[i].Concept == 'INT') {
            var rowIndex = i;
            api.grid.updateRow('Category', rowIndex, {
                Percentage: entities.ApprovalCriteriaQuestion.proposedRate
            });
            break;
        }
    }
};
task.setMessage = function (args, message) {
    args.commons.api.viewState.label('VA_VWPAYMENLA2634_0000932', message);
};
task.disablePaymentPlanActivity = function (viewState) {
    var grps = ['GR_VWPAYMENLA26_07', 'GR_VWPAYMENLA26_05'
                        , 'GR_VWPAYMENLA26_08', 'GR_VWPAYMENLA26_13'
                        , 'GR_VWPAYMENLA26_14', 'VA_VWPAYMENLA2605_BLYE585'
                        , 'VA_VWPAYMENLA2605_BLYE585', 'VA_VWPAYMENLA2605_IALR796'
                        , 'VA_VWPAYMENLA2605_EACE223', 'VA_VWPAYMENLA2605_ATTE607'
    					, 'VA_VWPAYMENLA2605_PILO354', 'VA_VWPAYMENLA2605_EREP542'];
    BUSIN.API.disable(viewState, grps);
    //viewState.disableValidation('VA_VWPAYMENLA2621_RPPU224',VisualValidationTypeEnum.RangeValues);
    viewState.enable('VA_VWPAYMENLA2605_ETDY540');
    // viewState.enable('VA_VWPAYMENLA2606_SPRE385');
};
task.preferenceConditions = function (entities, args) {
    var api = args.commons.api;
    var rebate = 0;
    if (!entities.ApprovalCriteriaQuestion.rebateCustomerType) {
        entities.ApprovalCriteriaQuestion.rebateCustomerType = 0;
    }
    if (!entities.ApprovalCriteriaQuestion.rebate) {
        entities.ApprovalCriteriaQuestion.rebate = 0;
    }
    rebate = (entities.ApprovalCriteriaQuestion.rebateCustomerType + entities.ApprovalCriteriaQuestion.rebate)
    if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'AA') {
        entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 3;
        if (entities.ApprovalCriteriaQuestion.rebateCustomerType == 0 || entities.ApprovalCriteriaQuestion.rebateCustomerType == null || entities.ApprovalCriteriaQuestion.rebateCustomerType < 0) {
            args.commons.messageHandler.showMessagesError('Para la calificación AA es obligatorio bajar hasta un punto y opcional hasta 2 puntos');
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
            api.viewState.disable('VA_PROVTRIUST5706_TPPY859');
        }
        else if (entities.ApprovalCriteriaQuestion.rebateCustomerType == 3) {
            entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 3;
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - rebate;
            api.viewState.enable('VA_PROVTRIUST5706_TPPY859');
        }
        else if (entities.ApprovalCriteriaQuestion.rebateCustomerType > 3) {
            args.commons.messageHandler.showMessagesError('Para la calificación AA, maximo se puede rebajar 3 puntos');
            api.viewState.disable('VA_PROVTRIUST5706_TPPY859');
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
        }
        else {
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - rebate;
            api.viewState.enable('VA_PROVTRIUST5706_TPPY859');
        }
    }
    if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'A') {
        entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 2;
        if (entities.ApprovalCriteriaQuestion.rebateCustomerType == 0 || entities.ApprovalCriteriaQuestion.rebateCustomerType == null || entities.ApprovalCriteriaQuestion.rebateCustomerType < 0) {
            args.commons.messageHandler.showMessagesError('Para la calificación A es obligatorio bajar hasta un punto y opcional hasta 2 puntos');
            api.viewState.disable('VA_PROVTRIUST5706_TPPY859');
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
        }
        else if (entities.ApprovalCriteriaQuestion.rebateCustomerType == 2) {
            entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 2;
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - rebate;
            api.viewState.enable('VA_PROVTRIUST5706_TPPY859');
        }
        else if (entities.ApprovalCriteriaQuestion.rebateCustomerType > 2) {
            args.commons.messageHandler.showMessagesError('Para la calificación A, maximo se puede rebajar 2 puntos');
            api.viewState.disable('VA_PROVTRIUST5706_TPPY859');
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
        }
        else {
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - rebate;
            api.viewState.enable('VA_PROVTRIUST5706_TPPY859');
        }
    }
    if (entities.ApprovalCriteriaQuestion.currentRateFIE == 'B') {
        entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 1;
        if (entities.ApprovalCriteriaQuestion.rebateCustomerType == 0 || entities.ApprovalCriteriaQuestion.rebateCustomerType == null || entities.ApprovalCriteriaQuestion.rebateCustomerType < 0) {
            args.commons.messageHandler.showMessagesError('Cliente CPOP debe rebajar de 0 hasta 1 punto');
            api.viewState.disable('VA_PROVTRIUST5706_TPPY859');
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate
        }
        else if (entities.ApprovalCriteriaQuestion.rebateCustomerType == 1) {
            entities.ApprovalCriteriaQuestion.maximumDiscountCustomerType = 1;
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - rebate;
            api.viewState.enable('VA_PROVTRIUST5706_TPPY859');
        }
        else if (entities.ApprovalCriteriaQuestion.rebateCustomerType > 1) {
            args.commons.messageHandler.showMessagesError('Para la calificación B, maximo se puede rebajar 1 punto');
            api.viewState.disable('VA_PROVTRIUST5706_TPPY859');
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate;
        }
        else {
            entities.ApprovalCriteriaQuestion.proposedRate = entities.ApprovalCriteriaQuestion.tariffRate - rebate;
            api.viewState.enable('VA_PROVTRIUST5706_TPPY859');
        }
    }
}
task.disableToolbarAmortizationTable = function (eventArgs, entity, idGrid, show) {
    var ds = eventArgs.commons.api.vc.model[entity];
    var grid = eventArgs.commons.api.grid;
    var dsData = ds.data();
    if (show) {
        for (var i = 0; i < dsData.length; i++) {
            var dsRow = dsData[i];
            grid.showGridRowCommand(idGrid, dsRow, 'VA_VWPAYMENLA2611_0000301');
        }
        grid.showToolBarButton(idGrid, 'CEQV_201_QV_QUYOI3312_16_019');
        task.setScrollAmortizationTable(dsData.length, eventArgs.commons.api);
    }
    else {
        for (var i = 0; i < dsData.length; i++) {
            var dsRow = dsData[i];
            grid.hideGridRowCommand(idGrid, dsRow, 'VA_VWPAYMENLA2611_0000301');
        }
        grid.hideToolBarButton(idGrid, 'CEQV_201_QV_QUYOI3312_16_019');
        task.setScrollAmortizationTable(dsData.length, eventArgs.commons.api);
    }
};
task.disableRowGrid = function (eventArgs, entity, idGrid) {
    //DESHABILITA LAS FILAS DE LA GRILLA DE CATEGORY QUE SON HEREDADAS
    var ds = eventArgs.commons.api.vc.model[entity];
    var grid = eventArgs.commons.api.grid;
    var dsData = ds.data();
    for (var i = 0; i < dsData.length; i++) {
        var dsRow = dsData[i];
        if (dsRow.isHeritage === 'S') {
            grid.addRowStyle(idGrid, dsRow, 'Disable_CTR');
            //grid.hideGridRowCommand(idGrid, dsRow, 'delete');
        }
        else {
            grid.removeRowStyle(idGrid, dsRow, 'Disable_CTR');
            //grid.showGridRowCommand(idGrid, dsRow, 'delete');
        }
    }
    eventArgs.commons.api.viewState.refreshData(idGrid);
};
//close modal para retornar los datos de Category a la grilla de rubros
task.closeModalEvent.VC_CTORY86_CTEGO_587 = function (args) {
    var response = args.result;
    if (response != null && response != undefined) {
        if (response.isNew) {
            var category = {};
            category.Concept = response.Concept;
            category.ConceptDescription = response.ConceptDescription;
            category.ConceptType = response.ConceptType;
            category.ConceptTypeDescription = response.ConceptTypeDescription;
            category.MethodOfPayment = response.MethodOfPayment;
            category.PaymentFormDescription = response.PaymentFormDescription;
            category.Sign = response.Sign;
            category.Factor = response.Spread;
            category.Reference = response.Reference;
            if (category.ConceptType == 'I' || category.ConceptType == 'M' || category.ConceptType == 'O' || category.ConceptType == 'B') {
                category.Percentage = response.Value;
                category.Value = 0.00;
            }
            else {
                category.Percentage = 0.00;
                category.Value = response.Value;
            }
            args.commons.api.grid.addRow('Category', category);
            //Se configura los rubros editables
            task.setEditableCategory(args);
        }
        else {
            var categories = args.commons.api.vc.model.Category == undefined ? [] : args.commons.api.vc.model.Category.data();
            categories.forEach(function (categoryItem) {
                if (categoryItem.Concept.trim() == response.Concept) {
                    categoryItem.Factor = response.Spread;
                    categoryItem.MethodOfPayment = response.MethodOfPayment;
                    categoryItem.PaymentFormDescription = response.PaymentFormDescription;
                    categoryItem.Sign = response.Sign;
                    if (categoryItem.ConceptType == 'I' || categoryItem.ConceptType == 'M' || categoryItem.ConceptType == 'O' || categoryItem.ConceptType == 'B') {
                        categoryItem.Percentage = response.Value;
                        categoryItem.Value = 0.00;
                    }
                    else {
                        categoryItem.Percentage = 0.00;
                        categoryItem.Value = response.Value;
                    }
                }
            })
            args.commons.api.vc.model.Category.data(categories);
            //executeCommandCallbackEventArgs.commons.api.parentVc.model.Category.sync();
        }
        //var grid = args.commons.api.grid;
        //grid.refresh('QV_UYCTE6570_70');
    }
};
//******************************************************************************
// Eventos Tabla de Amortizacion Manual
//******************************************************************************
task.changeManualAmortizationTable = function (entities, eventArgs) {
    var PaymentPlan = entities.PaymentPlan;
    var PaymentPlanHeader = entities.PaymentPlanHeader;
    var categories = entities.Category.data();
    var data = angular.copy(entities.AmortizationTableItem.data());
    task.reCalculateAmortizationTable(PaymentPlanHeader.daysPerYear, PaymentPlanHeader.classOperation, PaymentPlanHeader.initialDate, categories, eventArgs, data);
    // Sincroniza y actualiza la grilla con los nuevos datos colocados
    eventArgs.commons.api.grid.addAllRows('AmortizationTableItem', data, true);
    //Calcular el Total del Saldo de Capital
    setTimeout(function () {
        task.setTotalLabel(eventArgs.commons.api.viewState);
        task.calculateTotalCapitalBalance(entities.AmortizationTableItem.data());
    });
};
task.reCalculateAmortizationTable = function (daysPerYear, classOperation, initialDate, categories, eventArgs, data) {
    //console.time('reCalculateAmortizationTable');
    var row = eventArgs.rowData;
    var dataSize = data.length;
    var subtotalCapital = 0;
    var count = 1;
    // Días según la base de cálculo
    //var daysPerYear = task.getDayPerYear(eventArgs, PaymentPlan.basCalculationInterest);  
    var completeData = true;
    // Días año registrados en la operación
    if (daysPerYear == null || daysPerYear == undefined) {
        eventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_MSGDASYER_19422');
        completeData = false;
    }
    if (classOperation == null || classOperation == undefined || classOperation.trim() == "") {
        eventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SSOPERAIN_71783');
        completeData = false;
    }
    var beforeExpirationDate;
    var balance;
    for (var i = 0; i < dataSize; i++) {
        if (i > 0) {
            balance = parseFloat(Math.round((data[i - 1].Balance - data[i - 1].Item1) * 100) / 100).toFixed(2);
            data[i]['Dividend'] = count;
            data[i]['Balance'] = balance;
            beforeExpirationDate = data[i - 1].ExpirationDate;
        }
        if (completeData) {
            task.calculateSimpleInterest(initialDate, classOperation, beforeExpirationDate, data[i], categories, daysPerYear);
        }
        count++;
    }
    //console.timeEnd('reCalculateAmortizationTable');  
};
task.calculateSimpleInterest = function (initialDate, classOperation, beforeExpirationDate, row, categories, daysPerYear) {
    //console.time('calculateSimpleInterest');	    
    var datesDiff = task.calculateFeeDays(beforeExpirationDate, initialDate, row);
    //row.set('Item2', ((row.Item1 * datesDiff * (PaymentPlanHeader.rate/100))/PaymentPlan.daysPerYear));
    /*var res = ((row.Balance * datesDiff * (PaymentPlanHeader.rate/100))/PaymentPlan.daysPerYear);
    row.set('Item2', res);*/
    var item;
    var category;
    var interestValue;
    //itemsHeader.forEach(function (item){
    for (var i = 0; i < itemsHeader.length; i++) {
        item = itemsHeader[i];
        for (var j = 0; j < categories.length; j++) {
            //categories.forEach(function (category){
            category = categories[j];
            if (item.nemonic.trim() == category.Concept.trim()) {
                if (category.ConceptType.trim() == 'I') {
                    if (classOperation != "D") {
                        interestValue = (row.Balance * datesDiff * (category.Percentage / 100)) / daysPerYear;
                    }
                    else {
                        interestValue = (row.Item1 * datesDiff * (category.Percentage / 100)) / daysPerYear;
                    }
                    row[item.id] = interestValue;
                    break;
                }
                break;
            }
        };
    };
    var feeValue = row.Item1 + row.Item2 + row.Item3 + row.Item4 + row.Item5 + row.Item6 + row.Item7 + row.Item8 + row.Item9 + row.Item10 + row.Item11 + row.Item12 + row.Item13;
    row['Fee'] = feeValue;
    //console.timeEnd('calculateSimpleInterest');
};
task.calculateFeeDays = function (beforeExpirationDate, initialDate, row) {
    var datesDiff = 0;
    if (row.Dividend == 1) {
        datesDiff = row.ExpirationDate - initialDate
    }
    else {
        datesDiff = row.ExpirationDate - beforeExpirationDate;
    }
    //Diferencia de fechas en días
    return (((datesDiff / 1000) / 60) / 60) / 24;
};
task.setTotalLabel = function (viewState) {
    $('tr.k-footer-template').contents().each(function () {
        if (this.cellIndex == 1) {
            var div = document.createElement("div");
            div.className = "text-left";
            div.innerHTML = viewState.translate('BUSIN.DLB_BUSIN_TOTALKMZX_17454');
            if (this.childNodes[0] != null && this.childNodes[0] != undefined) {
                this.removeChild(this.childNodes[0]);
            }
            this.appendChild(div);
        }
    });
};
task.calculateTotalCapitalBalance = function (data) {
    $('tr.k-footer-template').contents().each(function () {
        //Calcular Total Saldo Capital: Se resta Saldo Capital - Capital del último registro de la tabla de amortización
        if (this.cellIndex == 2) {
            var div = document.createElement("div");
            div.className = "text-right";
            div.title = "TotalCapital";
            //div.innerHTML = kendo.toString(data[data.length - 1].Balance - data[data.length - 1].Item1, "n");
            div.innerHTML = parseFloat(Math.round((data[data.length - 1].Balance - data[data.length - 1].Item1) * 100) / 100).toFixed(2);
            //parseFloat(Math.round(num3 * 100) / 100).toFixed(2);
            this.removeChild(this.childNodes[0]);
            this.appendChild(div);
        }
    });
}
task.validateTotalCapitalBalance = function (data) {
    if (data != undefined && data.length > 0) {
        var size = data.length - 1;
        var totalSaldoCapital = data[size].Balance - data[size].Item1;
        if (totalSaldoCapital < 0) {
            return -1;
        }
        else if (totalSaldoCapital > 0) {
            return 1;
        }
        else if (totalSaldoCapital == 0) {
            return 0;
        }
    }
    return 0;
}
task.validateDates = function (initialDate, finalDate, validateEqual) {
    if (initialDate != null && finalDate != null) {
        var fechaInicio = new Date(initialDate.getFullYear() + "/" + (initialDate.getMonth() + 1) + "/" + initialDate.getDate());
        var fechaFinal = new Date(finalDate.getFullYear() + "/" + (finalDate.getMonth() + 1) + "/" + finalDate.getDate());
        var fechaResta = fechaFinal - fechaInicio;
        //Transformamos el tiempo de diferencia en dias.
        fechaResta = (((fechaResta / 1000) / 60) / 60) / 24;
        if (validateEqual && fechaResta == 0) {
            return false;
        }
        if (fechaResta < 0) {
            return false;
        }
        else {
            return true;
        }
    }
    return true;
};
task.validateHolidayDate = function (entities, expirationDate, changedEventArgs) {
    var holidays = entities.Holiday;
    var dateRow = new Date(expirationDate);
    holidays.forEach(function (holiday) {
        var expirationDate = new Date(dateRow.getFullYear() + "/" + (dateRow.getMonth() + 1) + "/" + dateRow.getDate());
        if (holiday.holidayDate != undefined) {
            var holidayDate = new Date(holiday.holidayDate.getFullYear() + "/" + (holiday.holidayDate.getMonth() + 1) + "/" + holiday.holidayDate.getDate());
            if (expirationDate.valueOf() === holidayDate.valueOf()) {
                changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_MHOLIDYTE_53423');
            }
        }
    });
};
task.loadTaskHeader = function (entities, eventArgs) {
    var client = eventArgs.commons.api.parentVc.model.Task;
    var plazo = entities.OriginalHeader.Term;
    var originalh = entities.OriginalHeader;
    var contextAux = entities.Context;
    //Titulo de la cabecera (title)
    if (task.creditType === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', contextAux.CustomerId + " - " + entities.PaymentPlanHeader.customerName);
    }
    else {
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.PaymentPlanHeader.customerName);
    }
    //Subtitulos de la cabecera	
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', entities.PaymentPlanHeader.idRequested), 0;
    //LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);		
    if (task.creditType === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((contextAux.amountRequested == null || contextAux.amountRequested == 'null' ? 0 : contextAux.amountRequested), 2), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountAprobed == null || originalh.AmountAprobed == 'null' ? 0 : originalh.AmountAprobed), 2), 0);
    }
    else {
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountAprobed == null || originalh.AmountAprobed == 'null' ? 0 : originalh.AmountAprobed), 2), 0);
    }
    //LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.symbolCurrency, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', plazo, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.generalData.paymentFrecuencyName, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
    //LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((entities.OriginalHeader.OfficerName!=null)?entities.OriginalHeader.OfficerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
    /*if(entities.PaymentPlanHeader.initialDate ==null){
    	entities.PaymentPlanHeader.initialDate = new Date();
    }else{
    	LATFO.INBOX.addTaskHeader(taskHeader,'Fecha de inicio',BUSIN.CONVERT.NUMBER.Format(entities.PaymentPlanHeader.initialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((entities.PaymentPlanHeader.initialDate.getMonth()+1),"0",2)+"/"+entities.PaymentPlanHeader.initialDate.getFullYear(),1);
    }
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo cartera', entities.generalData.loanType, 1);*/
    //LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.generalData.vinculado, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);
	LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', contextAux.cycleNumber, 1);
    if (task.creditType === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', contextAux.cycleNumber, 1);
    }
    //Actualizo el grupo de designer
    LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_VWPAYMENLA26_16');
};
task.showButtons = function (args) {
    var api = args.commons.api;
    var parentParameters = args.commons.api.parentVc.customDialogParameters;
    if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.Query) {
        args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    }
    else {
        args.commons.api.vc.parentVc.labelExecuteCommand1 = "Calcular";
        args.commons.api.vc.parentVc.executeCommand1 = function () {
            args.commons.api.vc.executeCommand('CM_TPYEP21MTE89', 'Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
        }
    }
    args.commons.api.vc.parentVc.loadCommand = function (task) {
        if (task === "T_FLCRE_12_TPYEP21") {
            console.log("en loadcommand12-21");
            args.commons.api.vc.executeCommand('VA_VWPAYMENLA2621_0000251', 'saveSession', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
        }
    }
};
task.changePaymentFrecuency = function (entities, args) {
    var value = '';
    var vs = args.commons.api.viewState;
    switch (entities.PaymentPlan.quotaType) {
    case 'A':
        value = cobis.translate('BUSIN.DLB_BUSIN_AOSLAEMHK_69194');
        break;
    case 'B':
        value = cobis.translate('BUSIN.DLB_BUSIN_BIMENSUAL_77512');
        break;
    case 'D':
        value = cobis.translate('BUSIN.DLB_BUSIN_DASDCZCGX_89167');
        break;
    case 'M':
        value = cobis.translate('BUSIN.DLB_BUSIN_MESESIUAX_34557');
        break;
    case 'Q':
        value = cobis.translate('BUSIN.DLB_BUSIN_QUINCENAL_58788');
        break;
    case 'R':
        value = cobis.translate('BUSIN.DLB_BUSIN_SEMANAFFR_07381');
        break;
    case 'S':
        value = cobis.translate('BUSIN.DLB_BUSIN_SEMESTREG_08300');
        break;
    case 'T':
        value = cobis.translate('BUSIN.DLB_BUSIN_TRIMETRAL_59955');
        break;
    case 'BW':
        value = cobis.translate('BUSIN.LBL_BUSIN_CATORCEAN_88481');
        break;
    }
    vs.suffix('VA_VWPAYMENLA2605_PILO354', value);
    vs.suffix('VA_VWPAYMENLA2605_EREP542', value);
    vs.suffix('VA_VWPAYMENLA2605_IALR796', value);
    vs.suffix('VA_VWPAYMENLA2605_EACE223', value);
};
task.enableDisabledByAcceptsAdditionalPayments = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
    if (!wasInInitData && !wasInExecuteCommandCallback) {
        entities.GeneralParameterLoan.paymentType = null;
        entities.GeneralParameterLoan.extraordinaryEffectPayment = null;
    }
    if (entities.GeneralParameterLoan.acceptsAdditionalPayments == 'S') {
        viewState.enable('VA_VWPAYMENLA2630_METY849');
    }
    else if (entities.GeneralParameterLoan.acceptsAdditionalPayments == 'N' || entities.GeneralParameterLoan.acceptsAdditionalPayments == undefined || entities.GeneralParameterLoan.acceptsAdditionalPayments == null) {
        entities.GeneralParameterLoan.acceptsAdditionalPayments = 'N';
        viewState.disable('VA_VWPAYMENLA2630_METY849');
    }
};
task.enableDisabledByExchangeRate = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
    if (!wasInInitData && !wasInExecuteCommandCallback) {
        entities.GeneralParameterLoan.periodicity = '';
        entities.GeneralParameterLoan.especialReadjustment = null;
        entities.GeneralParameterLoan.readjustmentPeriodicity = null;
    }
    if (entities.GeneralParameterLoan.exchangeRate == 'S') {
        viewState.enable('VA_VWPAYMENLA2631_OITY034');
        viewState.enable('VA_VWPAYMENLA2632_ERSE615');
        viewState.enable('VA_VWPAYMENLA2633_RIOI469');
    }
    else if (entities.GeneralParameterLoan.exchangeRate == 'N') {
        viewState.disable('VA_VWPAYMENLA2631_OITY034');
        viewState.disable('VA_VWPAYMENLA2632_ERSE615');
        viewState.disable('VA_VWPAYMENLA2633_RIOI469');
    }
};
task.enableDisabledByPaymentType = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
    if (wasInInitData) {
        wasInInitData = false;
    }
    else if (!wasInInitData && !wasInExecuteCommandCallback) {
        entities.GeneralParameterLoan.extraordinaryEffectPayment = null;
    }
    if (entities.GeneralParameterLoan.paymentType == 'N' || entities.GeneralParameterLoan.paymentType == null) {
        viewState.disable('VA_VWPAYMENLA2630_YECY081');
    }
    else if (entities.GeneralParameterLoan.paymentType == 'E') {
        viewState.enable('VA_VWPAYMENLA2630_YECY081');
    }
};
task.enableDiableQuotaInterest = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
    if (entities.PaymentPlan.interestPeriodGrace > 0) {
        viewState.enable('VA_VWPAYMENLA2605_QAIT788');
    }
    else if (entities.PaymentPlan.interestPeriodGrace == 0) {
        entities.PaymentPlan.quotaInterest = " ";
        viewState.disable('VA_VWPAYMENLA2605_QAIT788');
    }
};
task.setMessageInterestPayment = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
    if (entities.GeneralParameterLoan.interestPayment == 'A') {
        task.setMessage(eventArgs, 'BUSIN.DLB_BUSIN_YDPAGESCA_33908');
    }
    else if (entities.GeneralParameterLoan.interestPayment == 'P') {
        task.setMessage(eventArgs, 'BUSIN.DLB_BUSIN_YUASOECDO_90545');
    }
};
task.setMessagePayment = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
    if (entities.GeneralParameterLoan.payment == 'D') {
        task.setMessage(eventArgs, 'BUSIN.DLB_BUSIN_AYUDAOORA_30843');
    }
    else if (entities.GeneralParameterLoan.payment == 'C') {
        task.setMessage(eventArgs, 'BUSIN.DLB_BUSIN_AUDAPAPOU_39811');
    }
};
task.setMessageExtraordinaryEffectPayment = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
    if (entities.GeneralParameterLoan.extraordinaryEffectPayment == 'C') {
        task.setMessage(eventArgs, 'BUSIN.DLB_BUSIN_AYUUCINOA_93923');
    }
    else if (entities.GeneralParameterLoan.extraordinaryEffectPayment == 'T') {
        task.setMessage(eventArgs, 'BUSIN.DLB_BUSIN_AYUDECNTM_56333');
    }
};
task.disablePaymentCondition = function (eventArguments) {
    //FORMAS DE PAGO
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_18'); //Formas de pago y Cuenta 
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_25'); //Permite renovación, permite precancelar etc..
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_28'); //Pagos por cuota, por rubro
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_29'); //Se aceptan pagos adicionales
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_30'); //Tipos de pago
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_31'); //Cambios de Tasa
    eventArguments.commons.api.viewState.hide('VA_VWPAYMENLA2621_0000855'); // Guarda parámetros
    //TABLA DE AMORTIZACIÓN
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_15'); //Monto Desmbolso y otros
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_07'); //Tipo de tabla y otros
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_08'); //Fecha fija y otros
    //eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_05'); //Dias de mora gracia y otros
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_20');
    eventArguments.commons.api.viewState.disable('GR_VWPAYMENLA26_11'); // Tabla de amortización
};
task.setValuePercentage = function (response, category) {
    if (category.ConceptType == 'I' || category.ConceptType == 'M' || category.ConceptType == 'O' || category.ConceptType == 'B') {
        category.Percentage = response.Value;
        category.Value = 0.00;
    }
    else {
        category.Percentage = 0.00;
        category.Value = response.Value;
    }
};
task.getDayPerYear = function (args, basCalculation) {
    var basCalculationArray = args.commons.api.vc.catalogs.VA_VWPAYMENLA2607_UATI478.data();
    for (var i = 0; i < basCalculationArray.length; i++) {
        if (basCalculationArray[i].code == basCalculation) {
            if (basCalculation == 'R') {
                return 365;
            }
            else if (basCalculation == 'E') {
                return 360;
            }
        }
    }
};
task.setNullValuesFE = function (entities, args) {
    if (null == entities.GeneralParameterLoan.acceptsAdditionalPayments || undefined == entities.GeneralParameterLoan.acceptsAdditionalPayments || '' == entities.GeneralParameterLoan.acceptsAdditionalPayments.trim()) {
        entities.GeneralParameterLoan.acceptsAdditionalPayments = 'N';
    }
    if (null == entities.GeneralParameterLoan.paymentType || undefined == entities.GeneralParameterLoan.paymentType || '' == entities.GeneralParameterLoan.paymentType.trim()) {
        entities.GeneralParameterLoan.paymentType = null;
    }
    if (null == entities.GeneralParameterLoan.extraordinaryEffectPayment || undefined == entities.GeneralParameterLoan.extraordinaryEffectPayment || '' == entities.GeneralParameterLoan.extraordinaryEffectPayment.trim()) {
        entities.GeneralParameterLoan.extraordinaryEffectPayment = null;
    }
    if (null == entities.GeneralParameterLoan.exchangeRate || undefined == entities.GeneralParameterLoan.exchangeRate || '' == entities.GeneralParameterLoan.exchangeRate.trim()) {
        entities.GeneralParameterLoan.exchangeRate = null;
    }
    if (entities.GeneralParameterLoan.especialReadjustment == null || undefined == entities.GeneralParameterLoan.especialReadjustment || '' == entities.GeneralParameterLoan.especialReadjustment.trim()) {
        entities.GeneralParameterLoan.especialReadjustment = null;
    }
    if (null == entities.GeneralParameterLoan.readjustmentPeriodicity || undefined == entities.GeneralParameterLoan.readjustmentPeriodicity || '' == entities.GeneralParameterLoan.readjustmentPeriodicity.trim()) {
        entities.GeneralParameterLoan.readjustmentPeriodicity = null;
    }
};
task.setEditableCategory = function (eventArgs) {
    var ds = eventArgs.commons.api.vc.model['Category'];
    var dsData = ds.data();
    for (var i = 0; i < dsData.length; i++) {
        var dsRow = dsData[i];
        task.setEditableItem(dsRow.Concept.trim(), dsRow, eventArgs);
    }
};
task.setEditableItem = function (concept, row, eventArgs) {
    var ds = eventArgs.commons.api.vc.model['EditableItems'];
    //var dsData = ds.data();
    for (var i = 1; i < ds.length; i++) {
        if (ds[i].item.trim() == concept) {
            if (ds[i].editable.trim() == 'N') { //condicion a cumplirse
                eventArgs.commons.api.grid.hideGridRowCommand('QV_UYCTE6570_70', row, 'edit');
                eventArgs.commons.api.grid.hideGridRowCommand('QV_UYCTE6570_70', row, 'delete');
            }
            break;
        }
    }
};
task.enableDisabledByTypePayment = function (entities, eventArgs) {
    var viewState = eventArgs.commons.api.viewState;
	eventArgs.newValue = entities.PaymentPlanHeader.typePayment;
    if (eventArgs.newValue == 'G') {
        //task.setMessage(eventArgs, 'LBL_BUSIN_PAGOSCONT_16144');            
        viewState.hide('G_VWPAYMELNP_969A26');
    }
    else if (eventArgs.newValue == 'I') {
        //task.setMessage(eventArgs, 'LBL_BUSIN_PAGOSCOIE_98890');
        viewState.show('G_VWPAYMELNP_969A26');
        eventArgs.commons.api.viewState.disable('VA_ACCOUNTQXYRZIXM_963A26');
    }
};

    //gridBeforeEnterInLineRow QueryView: GridAmortizationTable
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_QUYOI3312_16 = function (entities, gridBeforeEnterInLineRowEventArgs) {
            if(entities.PaymentPlan.tableType !='MANUAL'){
                gridABeforeEnterInLineRowEventArgs.cancel=true;
            }else{
                gridABeforeEnterInLineRowEventArgs.cancel=false;
            }
             gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
            
        };

//Entity: PaymentPlanHeader
    //PaymentPlanHeader.typePayment (RadioButtonList) View: TPaymentPlan
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_8375LIFACAQCGJL_261A26 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    task.enableDisabledByTypePayment(entities, changedEventArgs);
        
    };

//Entity: PaymentPlanHeader
//PaymentPlanHeader.dispersionDate (DateField) View: TPaymentPlan
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_DISPERSIONDATTT_417A26 = function (entities, changedEventArgs) {

    changedEventArgs.commons.execServer = false;

    entities.PaymentPlanHeader.initialDate = entities.PaymentPlanHeader.dispersionDate

    var fechaProceso = entities.PaymentPlanHeader.initialDate;
    var fechaDispersionR = entities.PaymentPlanHeader.dispersionDate;


    if (passInitDataCallback) {
        console.log("Fecha dispercion: " + fechaDispersionR);
        console.log("Fecha validacion: " + fechaValidacion);
        console.log("Fecha proceso: " + fechaProceso);


        if (fechaDispersionR !== undefined) {
            fechaDispersionR.setHours(0, 0, 0, 0);
        }
        if (fechaProceso !== undefined) {
            fechaProceso.setHours(0, 0, 0, 0);
        }
        if (fechaValidacion !== undefined) {
            fechaValidacion.setHours(0, 0, 0, 0);
        }

        if (fechaDispersionR > fechaValidacion) {

            changedEventArgs.commons.messageHandler.showTranslateMessagesError("La fecha de dispersi&oacuten sobrepasa el l&iacutemite establecido", null, 4000, false);


        } else {
            if (fechaDispersionR < fechaProceso) {

                changedEventArgs.commons.messageHandler.showTranslateMessagesError("La fecha de dispersi&oacuten es menor que la fecha de proceso", null, 4000, false);


            } else if (fechaDispersionR === null || fechaDispersionR === undefined) {
                changedEventArgs.commons.messageHandler.showTranslateMessagesError("Fecha de dispersi&oacuten requerida", null, 4000, false);

            } else {
                entities.PaymentPlanHeader.dispersionDate = fechaDispersionR;
            }
        }
        passInitDataCallback = false;

    }

};

//Entity: PaymentPlan
    //PaymentPlan.fixedpPaymentDate (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_ATTE607 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.setFechaPagoFija(entities.PaymentPlan, changedEventArgs.commons.api.viewState);
        
    };

//Entity: PaymentPlan
    //PaymentPlan.tableType (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_BLYE585 = function( entities, changedEventArgs ) {
		isFirstTime = false;
		changedEventArgs.commons.execServer = false;
		task.setTipoTabla(entities.PaymentPlan, changedEventArgs, entities);
        
    };

//Entity: PaymentPlan
    //PaymentPlan.interestPeriodGrace (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_EACE223 = function( entities, changedEventArgs ) {
        var api = changedEventArgs.commons.api;
        changedEventArgs.commons.execServer = false;
        task.enableDiableQuotaInterest(entities, changedEventArgs);
        
    };

//Entity: PaymentPlan
    //PaymentPlan.quotaType (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_TATY621 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.changePaymentFrecuency(entities, changedEventArgs);	
        
    };

//Entity: PaymentPlan
    //PaymentPlan.quota (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2607_QUOT918 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        
    };

//Entity: PaymentPlan
    //PaymentPlan.term (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2607_TERM808 = function( entities, changedEventArgs ) {
		if(wasInInitData){
			changedEventArgs.commons.execServer = false;
			wasInInitData = false;
		}
		
		if(quotaHasChange){
			changedEventArgs.commons.execServer = false;
			quotaHasChange = false;
		}
		else{
			entities.PaymentPlan.quota = 0;
			changedEventArgs.commons.execServer = true;
			changedEventArgs.commons.serverParameters.PaymentPlan = true;
			changedEventArgs.commons.serverParameters.PaymentPlanHeader = true;
		}
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.ExpirationDate (DateField) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_EPTI184 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;    
		var data = entities.AmortizationTableItem.data();
		var row = changedEventArgs.rowData;
		//la fecha de expiración debe ser mayor a la fecha de inicio de la operación
		var validateDateOperation = task.validateDates(entities.PaymentPlanHeader.initialDate,row.ExpirationDate,true)
		if(!validateDateOperation){
			row.set('ExpirationDate', changedEventArgs.oldValue);
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_ROMOPNDTE_93346');
		}
		var validateDates = true; 
		if (row.Dividend > 1){
			validateDates = task.validateDates(data[row.Dividend - 2].ExpirationDate, row.ExpirationDate,false)
		}
		if(validateDates){
			task.validateHolidayDate(entities, row.ExpirationDate,changedEventArgs );
			task.changeManualAmortizationTable(entities, changedEventArgs);

		}else{
			row.set('ExpirationDate', changedEventArgs.oldValue);
			changedEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_RROMSGATE_87972');
		}
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item4 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_IEM4759 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item6 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_IEM6601 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item2 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_ITE2959 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item7 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_ITE7198 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item3 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_ITEM212 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item5 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_ITEM747 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item11 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_ITM1595 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item13 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_ITM1742 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item10 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_TE10172 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item1 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_TEM1405 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);	
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item12 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_TEM1824 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item8 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_TEM8856 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem.Item9 (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2611_TEM9148 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, changedEventArgs);
        
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.interestPayment (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2628_ETME049 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;		
		task.setMessageInterestPayment(entities, changedEventArgs);
        
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.payment (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2628_PAME177 = function( entities, changedEventArgs ) {
       changedEventArgs.commons.execServer = false;
       task.setMessagePayment(entities, changedEventArgs);
        
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.acceptsAdditionalPayments (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2629_ANPN062 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.enableDisabledByAcceptsAdditionalPayments(entities, changedEventArgs);
        
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.paymentType (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2630_METY849 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.enableDisabledByPaymentType(entities, changedEventArgs);
        
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.extraordinaryEffectPayment (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2630_YECY081 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.setMessageExtraordinaryEffectPayment(entities, changedEventArgs);
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.exchangeRate (RadioButtonList) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2631_HNGE222 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.enableDisabledByExchangeRate(entities, changedEventArgs);
    };

// () View: View of [object Object]
  //Evento changeGroup : Evento change para pestañas, collapsible y accordion.
  task.changeGroup.GR_VWPAYMENLA26_10 = function (entities, changedGroupEventArgs){
		var viewState = changedGroupEventArgs.commons.api.vc.viewState;
        changedGroupEventArgs.commons.execServer = false;
        // changedGroupEventArgs.commons.serverParameters.entityName = true;
        if((changedGroupEventArgs.commons.item.id === 'GR_VWPAYMENLA26_13') && (changedGroupEventArgs.commons.item.isOpen === true)){
			viewState.CM_TPYEP21MTE89.visible = false;
        }else if((changedGroupEventArgs.commons.item.id === 'GR_VWPAYMENLA26_12') && (changedGroupEventArgs.commons.item.isOpen === true)){
			viewState.CM_TPYEP21MTE89.visible = true;
		}else if((changedGroupEventArgs.commons.item.id === 'GR_VWPAYMENLA26_20') && (changedGroupEventArgs.commons.item.isOpen === true)){
			viewState.CM_TPYEP21MTE89.visible = true;
			var numberItems = entities.AmortizationTableItem.data().length;
			task.setScrollAmortizationTable(numberItems, changedGroupEventArgs.commons.api);			
		}
  };

//Entity: PaymentPlanHeader
//PaymentPlanHeader.paymentDay (DateField) View: TPaymentPlan
//Req.194284 Dia de Pago
task.customValidate.VA_PAYMENTDAYSQXGZ_884A26 = function (entities, customValidateEventArgs) {
    customValidateEventArgs.commons.execServer = false;
    customValidateEventArgs.isValid = true

    if (entities.PaymentPlanHeader.paymentDay < processDateTemp) {
        customValidateEventArgs.errorMessage = 'BUSIN.MSG_BUSIN_VERIFICET_47837';
        customValidateEventArgs.isValid = false;
    }
};

//Entity: PaymentPlan
    //PaymentPlan.interestPeriod (TextInputBox) View: [object Object]
    
    task.customValidate.VA_VWPAYMENLA2605_EREP542 = function( entities, customValidateEventArgs ) {
        customValidateEventArgs.isValid = true 
		if(entities.PaymentPlan.interestPeriod == 0 ){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_SGPOIRESR_03363';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.interestPeriod > entities.PaymentPlan.capitalPeriod){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_GEOOITERS_08569';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.interestPeriod > entities.PaymentPlan.term){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_SERIDNTSO_70851';
			customValidateEventArgs.isValid = false;
		}   
    };

//Entity: PaymentPlan
    //PaymentPlan.capitalPeriod (TextInputBox) View: [object Object]
    
    task.customValidate.VA_VWPAYMENLA2605_PILO354 = function( entities, customValidateEventArgs ) {
        customValidateEventArgs.isValid = true 
		if(entities.PaymentPlan.capitalPeriod == 0 ){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_PODITALMR_32371';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.capitalPeriod < entities.PaymentPlan.interestPeriod){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_SGPECPIAL_40032';
			customValidateEventArgs.isValid = false;
		}
		if(entities.PaymentPlan.capitalPeriod > entities.PaymentPlan.term){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_GRREDAPLZ_88107';
			customValidateEventArgs.isValid = false;
		}   
    };

//Entity: PaymentPlan
    //PaymentPlan.term (TextInputBox) View: [object Object]
    
    task.customValidate.VA_VWPAYMENLA2607_TERM808 = function( entities, customValidateEventArgs ) {
		customValidateEventArgs.isValid = true 
		
		if(entities.PaymentPlan.term == 0 ){
			customValidateEventArgs.errorMessage='BUSIN.DLB_BUSIN_MSGROPOMA_02416';
			customValidateEventArgs.isValid = false;
		}  
    };

// (Button) 
    task.executeCommand.CM_TPYEP21MTE89 = function(entities, executeCommandEventArgs) {
		executeCommandEventArgs.commons.api.viewState.lockScreen('VC_TPYEP21_FAETL_814', null);
		var serverParameters = executeCommandEventArgs.commons.serverParameters;
        //Se valida que el Monto Primer Desembolso y el Monto Propuesto sean iaguales solo para Refinanciamiento
		var validate = task.validateTotalCapitalBalance(entities.AmortizationTableItem.data());
		if(validate == -1){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSRRRIANT_59731',null,10000);
		}
		else if(validate == 1){
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSAMTIOTE_78401',null,10000);
		}
		else if(validate == 0){
        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento && entities.OriginalHeader.Expromission===undefined){
            if(entities.PaymentPlanHeader.amount!=entities.PaymentPlanHeader.approvedAmount ){
                executeCommandEventArgs.commons.execServer = false;
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OPOMEEMBL_33336',null,10000);
            }
        }else{
            if(entities.PaymentPlanHeader.amount>entities.PaymentPlanHeader.approvedAmount ){
                executeCommandEventArgs.commons.execServer = false;
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_TOOEOARAO_58574',null,10000);
            }
        }

		}
		if(executeCommandEventArgs.commons.execServer === false){
			return;
		}
    };

//Start signature to callBack event to CM_TPYEP21MTE89
    task.executeCommandCallback.CM_TPYEP21MTE89 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		//isCalculated = true;
		var viewState = executeCommandCallbackEventArgs.commons.api.viewState,        
        api = executeCommandCallbackEventArgs.commons.api,
        enableContinuebutton =false;
		wasInExecuteCommandCallback = true;
		
		viewState.lockScreen('VC_TPYEP21_FAETL_814', null);
		//task.disableRowGrid(executeCommandCallbackEventArgs, 'Category' , 'QV_UYCTE6570_70'); //funcion para deshabilitar los registros heredados
		/*if(grupos != null){
			BUSIN.API.enable(viewState,grupos);
		}*/
        //Se valida que El Monto no puede ser menor a la suma del Saldo de las Operaciones pero solo para Refinanciamiento

		
        if(entities.OriginalHeader.TypeRequest === FLCRE.CONSTANTS.Tramite.Refinanciamiento && entities.OriginalHeader.Expromission===undefined){
            if(entities.PaymentPlanHeader.amount >=entities.PaymentPlanHeader.sumAmount && entities.PaymentPlanHeader.approvedAmount>=entities.PaymentPlanHeader.sumAmount){
                if(executeCommandCallbackEventArgs.success){
                    task.validateExistsOperation(true, entities, executeCommandCallbackEventArgs);
                    if(entities.OriginalHeader.StatusRequested != 'A'){
                        BUSIN.API.enableCTR(executeCommandCallbackEventArgs.commons.api,['GR_VWPAYMENLA26_10']);
                        BUSIN.API.enable(viewState,['GR_VWPAYMENLA26_13'
						//,'VA_VWPAYMENLA2613_PAME294'
						//,'VA_VWPAYMENLA2613_REPE081'
						//,'VA_VWPAYMENLA2613_PERM620'
						]);
                    }
					task.setScrollAmortizationTable(entities.AmortizationTableItem.data().length, executeCommandCallbackEventArgs.commons.api);
                    task.formatAmortizationTable(entities, executeCommandCallbackEventArgs.commons.api);
					//Calcular el Total del Saldo de Capital
					setTimeout(function() {
						task.setTotalLabel(api.viewState);
						task.calculateTotalCapitalBalance(entities.AmortizationTableItem.data());
					});	
					api.viewState.enable('GR_VWPAYMENLA26_07');
					api.viewState.enable('GR_VWPAYMENLA26_08');
					api.viewState.enable('GR_VWPAYMENLA26_05');
					api.viewState.enable('GR_VWPAYMENLA26_13');
                    enableContinuebutton = task.formatPaymentCapacityTable(entities, executeCommandCallbackEventArgs);
                } else {
                    enableContinuebutton = false;
                }
                if (task.Etapa === FLCRE.CONSTANTS.Stage.Recalculation){
                    task.disablePaymentPlanActivity(viewState);
                }
                //Logica para habilitar el boton continuar del wf
                if(enableContinuebutton){
                    BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,api);
                    executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitPaymentPlan.commitPaymentPlan';
                }else{
                    BUSIN.INBOX.STATUS.nextStep(false,api);
                }
            }
        }else{
            if(executeCommandCallbackEventArgs.success){
                task.validateExistsOperation(true, entities, executeCommandCallbackEventArgs);
                if(entities.OriginalHeader.StatusRequested != 'A'){
                    BUSIN.API.enableCTR(executeCommandCallbackEventArgs.commons.api,['GR_VWPAYMENLA26_10']);
                }
				task.setScrollAmortizationTable(entities.AmortizationTableItem.data().length, executeCommandCallbackEventArgs.commons.api);				
                task.formatAmortizationTable(entities, executeCommandCallbackEventArgs.commons.api);
				//Calcular el Total del Saldo de Capital
				setTimeout(function() {
					task.setTotalLabel(api.viewState);
					task.calculateTotalCapitalBalance(entities.AmortizationTableItem.data());
				});				
                enableContinuebutton = task.formatPaymentCapacityTable(entities, executeCommandCallbackEventArgs);
				api.viewState.enable('GR_VWPAYMENLA26_07');
				api.viewState.enable('GR_VWPAYMENLA26_08');
				api.viewState.enable('GR_VWPAYMENLA26_05');
				api.viewState.enable('GR_VWPAYMENLA26_13');
            } else {
                enableContinuebutton = false;
            }

            if (task.Etapa === FLCRE.CONSTANTS.Stage.Recalculation){
                task.disablePaymentPlanActivity(viewState);
				BUSIN.API.GRID.disableEnableToolbar(executeCommandCallbackEventArgs,'Category','QV_UYCTE6570_70',false,'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para edición en modo CONSULTA
            }

            //Logica para habilitar el boton continuar del wf
            if(enableContinuebutton){
                BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,api);
                executeCommandCallbackEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitPaymentPlan.commitPaymentPlan';
            }else{
                BUSIN.INBOX.STATUS.nextStep(false,api);
            }
          
        }
		// Credito con Convenio - Aplica todos los Flujos.
		if(entities.OriginalHeader.Agreement === 'S'){
			viewState.disable('VA_VWPAYMENLA2613_HNGE724');
			viewState.disable('GR_VWPAYMENLA26_14');
		}
		if(entities.PaymentPlan.tableType=='MANUAL'){
			task.disableToolbarAmortizationTable(executeCommandCallbackEventArgs,'AmortizationTableItem','QV_QUYOI3312_16',true);
		}else{
			task.disableToolbarAmortizationTable(executeCommandCallbackEventArgs,'AmortizationTableItem','QV_QUYOI3312_16',false);
		}
		task.loadTaskHeader(entities, executeCommandCallbackEventArgs);		
		task.enableDisabledByAcceptsAdditionalPayments(entities, executeCommandCallbackEventArgs);
		task.enableDisabledByExchangeRate(entities, executeCommandCallbackEventArgs);
		task.enableDisabledByPaymentType(entities, executeCommandCallbackEventArgs);
		task.enableDiableQuotaInterest(entities, executeCommandCallbackEventArgs);
		wasInExecuteCommandCallback = false;
		
		if(entities.PaymentPlan.quota!=0){
			quotaHasChange = true;
		}

        //Se configura los rubros editables
		task.setEditableCategory(executeCommandCallbackEventArgs);

		//Se mapea en cero para CPN que no tiene bien calculado el valor en ca_operacion_tmp (opt_cuota)
		entities.PaymentPlan.quota = 0;
		viewState.unlockScreen('VC_TPYEP21_FAETL_814');
        
        // Se actualiza la fecha del primer desembolso
        entities.PaymentPlanHeader.firstExpirationFeeDate = entities.AmortizationTableItem.data()[0].ExpirationDate


		      BUSIN.API.GRID.disableEnableToolbar(executeCommandCallbackEventArgs,'Category','QV_UYCTE6570_70',false,'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para ediciÃ³n en modo CONSULTA
		task.disablePaymentCondition(executeCommandCallbackEventArgs); 
		executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_DISPERSIONDATTT_417A26')

        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_PAYMENTDAYSQXGZ_884A26'); //Req.194284 Dia de Pago

    };

//Entity: PaymentPlanHeader
    //PaymentPlanHeader. (Button) View: TPaymentPlan
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONPSZFMGQ_712A26 = function(  entities, executeCommandEventArgs ) {

   executeCommandEventArgs.commons.execServer = true;
    entities.PaymentSelection.groupId=executeCommandEventArgs.commons.api.parentVc.model.Task.bussinessInformationIntegerOne;
        entities.PaymentSelection.transactionNumber=executeCommandEventArgs.commons.api.parentVc.model.Task.bussinessInformationIntegerTwo;
         entities.PaymentSelection.creditType=task.creditType;
    
        
    };

// (Button) 
 //.saveSession (Button) View: VWPaymentPlan
    task.executeCommand.VA_VWPAYMENLA2621_0000251 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
		entities.generalData.BUSSINESSINFORMATIONSTRINGONE = null;
		entities.generalData.OWNERIDENTIFIER = entities.PaymentPlanHeader.idRequested;
		
        executeCommandEventArgs.commons.serverParameters.generalData = true;
		executeCommandEventArgs.commons.serverParameters.OriginalHeader = true;
		executeCommandEventArgs.commons.serverParameters.PaymentPlanHeader = true;
    };

// (Button) 
    task.executeCommand.VA_VWPAYMENLA2621_0000855 = function( entities, executeCommandEventArgs ) {
		var numErrors1 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_25', true);
		var numErrors2 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_28', true);
		var numErrors3 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_29', true);
		var numErrors4 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_30', true);
		var numErrors5 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_31', true);
		var numErrors6 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_32', true);
		var numErrors7 = executeCommandEventArgs.commons.api.errors.getErrorsGroup('GR_VWPAYMENLA26_33', true);
		
		
		if(entities.GeneralParameterLoan.exchangeRate == 'N'){
			numErrors6 = 0;
		}		
		if(numErrors1==0 && numErrors2==0 && numErrors3==0 && numErrors4==0 && numErrors5==0 && numErrors6==0&& numErrors7==0){
			executeCommandEventArgs.commons.execServer = true;
			executeCommandEventArgs.commons.serverParameters.GeneralParameterLoan = true;
			executeCommandEventArgs.commons.serverParameters.PaymentPlanHeader = true;
		}else{
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ESICINSPG_05163',null,10000);
		}
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.acceptsAdditionalPayments (RadioButtonList) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control.
    task.executeLabelCommand.VA_VWPAYMENLA2629_ANPN062 = function( entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
        task.setMessage(executeLabelCommandEventArgs, 'BUSIN.DLB_BUSIN_UAGSDINAS_79800');
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.exchangeRate (RadioButtonList) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acciÃ³n a ejecutar de un label de un input control. 
    task.executeLabelCommand.VA_VWPAYMENLA2631_HNGE222 = function( entities, executeLabelCommandEventArgs ) {
       executeLabelCommandEventArgs.commons.execServer = false;
        task.setMessage(executeLabelCommandEventArgs,'BUSIN.DLB_BUSIN_DARJUSTEA_98748');
        
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.periodicity (TextInputBox) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control.
    task.executeLabelCommand.VA_VWPAYMENLA2631_OITY034 = function( entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
		task.setMessage(executeLabelCommandEventArgs,'BUSIN.DLB_BUSIN_ADAEICDAD_95321');
    };

//Entity: GeneralParameterLoan
    //GeneralParameterLoan.especialReadjustment (RadioButtonList) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control. 
    task.executeLabelCommand.VA_VWPAYMENLA2632_ERSE615 = function( entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
        task.setMessage(executeLabelCommandEventArgs,'BUSIN.DLB_BUSIN_DARJUSTEA_98748');
        
    };

//gridCommand (Button) QueryView: GridCategoryItemsNew
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_QERYI6962_42_736 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        gridExecuteCommandEventArgs.commons.serverParameters.CategoryNew = true;

		var nav = gridExecuteCommandEventArgs.commons.api.navigation;
			nav.label = gridExecuteCommandEventArgs.commons.api.viewState.translate('BUSIN.DLB_BUSIN_RUBROSNVO_58071');
			nav.modalProperties = {
				size: 'lg',
				callFromGrid: false
			};
			nav.queryParameters = {mode: 2};
			nav.address = {
					moduleId: 'BUSIN',
					subModuleId: 'FLCRE',
					taskId: 'T_FLCRE_24_CTORY86',
					taskVersion: '1.0.0',
					viewContainerId: 'VC_CTORY86_CTEGO_587'
			};
			nav.customDialogParameters = {
					idRequested:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.idRequested,
					currency:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.currency,
					productType:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.productType
			};
			nav.openModalWindow(gridExecuteCommandEventArgs.commons.controlId, gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader);
    };

//gridCommand (ImageButton) QueryView: GridAmortizationTable
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_QUYOI3312_16_019 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
		var data = entities.AmortizationTableItem.data();
		var newDividend = data.length + 1;
		var lastIndex
		if(entities.PaymentPlan.selectingQuotaIndex != undefined && entities.PaymentPlan.selectingQuotaIndex != null) {
		   lastIndex = entities.PaymentPlan.selectingQuotaIndex
		} else {
		   lastIndex = data.length - 1
		}
		var lastExpirationDate = data[lastIndex].ExpirationDate;
		var newDate = new Date(lastExpirationDate.getFullYear(), lastExpirationDate.getMonth() + 1, lastExpirationDate.getDate(), 0, 0, 0, 0);
			
		var amortizationTableItem ={Balance:0,
									Dividend: newDividend,
									ExpirationDate: newDate,
									Fee:0,
									Item1:0,
									Item2:0,
									Item3:0,
									Item4:0,
									Item5:0,
									Item6:0,
									Item7:0,
									Item8:0,
									Item9:0,
									Item10:0,
									Item11:0,
									Item12:0,
									Item13:0};		
		entities.AmortizationTableItem.insert(lastIndex + 1,amortizationTableItem);					
		task.changeManualAmortizationTable(entities, gridExecuteCommandEventArgs);
		newDividend = lastIndex + 2;
		var criteria = { field: "Dividend", operator:"eq" ,value: newDividend} ;
        var selectedRow =  gridExecuteCommandEventArgs.commons.api.grid.selectRow("QV_QUYOI3312_16",criteria);
		task.setScrollAmortizationTable(data.length, gridExecuteCommandEventArgs.commons.api);
    };

//gridCommand (Button) QueryView: GridCategoryPlan
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_UYCTE6570_70_368 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        gridExecuteCommandEventArgs.commons.serverParameters.CategoryNew = true;
		
		var nav = gridExecuteCommandEventArgs.commons.api.navigation;
			nav.label = gridExecuteCommandEventArgs.commons.api.viewState.translate('BUSIN.DLB_BUSIN_RUBROSNVO_58071');
			nav.modalProperties = {
				size: 'lg',
				callFromGrid: false
			};
			nav.queryParameters = {mode: 2};
			nav.address = {
					moduleId: 'BUSIN',
					subModuleId: 'FLCRE',
					taskId: 'T_FLCRE_24_CTORY86',
					taskVersion: '1.0.0',
					viewContainerId: 'VC_CTORY86_CTEGO_587'
			};
			nav.customDialogParameters = {
					idRequested:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.idRequested,
					currency:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.currency,
					productType:gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader.productType,
					isNew: true
			};
			nav.openModalWindow(gridExecuteCommandEventArgs.commons.controlId, gridExecuteCommandEventArgs.commons.api.vc.model.PaymentPlanHeader);
    };

//Entity: AmortizationTableItem
    //AmortizationTableItem. (ImageButton) View: [object Object]
    
    task.gridRowCommand.VA_VWPAYMENLA2611_0000301 = function( entities, gridRowCommandEventArgs ) {
		cobis.showMessageWindow.loading(true);
		gridRowCommandEventArgs.commons.execServer = false;
		task.changeManualAmortizationTable(entities, gridRowCommandEventArgs);
		gridRowCommandEventArgs.commons.api.grid.removeRow('AmortizationTableItem',gridRowCommandEventArgs.rowIndex);
		cobis.showMessageWindow.loading(false);
        
    };

//gridRowRendering QueryView: GridAmortizationTable
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_QUYOI3312_16 = function (entities, gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            
        };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_TPYEP21_FAETL_814 = function (entities, initDataEventArgs){
        passInitDataCallback = false;
		entities.Context = {};
		entities.OfficerAnalysis = {};
		entities.CreditOtherData = {};
		entities.PaymentPlanHeader = {};
		entities.OriginalHeader = {};
		entities.PaymentCapacity = [];
		entities.PaymentCapacityHeader = {};
		entities.AmortizationTableHeader = {};	
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";		
		entities.generalData.paymentFrecuencyName = "";		
        var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;
		//GRUPALES
        task.creditType = customDialogParameters.Task.urlParams.SOLICITUD;
        
		//Se elimina el requerido  para el atributo -- Fecha vencimiento primera cuota
		initDataEventArgs.commons.api.viewState.disableValidation('VA_VWPAYMENLA2615_SPRE849', VisualValidationTypeEnum.Required);
		
		FLCRE.UTILS.APPLICATION.setContext(entities, initDataEventArgs, false, false);
        var viewState = initDataEventArgs.commons.api.viewState;
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		
        //Oculta Menu de Cabecera en Tabla de amortizacion
        BUSIN.API.GRID.hideFilter('QV_QUYOI3312_16', initDataEventArgs.commons.api);
        BUSIN.API.disable(viewState,['VA_VWPAYMENLA2615_AOUN065']);
		
        //Set Por Requerimiento
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
        entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;			
		
		entities.PaymentPlanHeader.applicationNumber = parentParameters.Task.processInstanceIdentifier;
        entities.PaymentPlanHeader.debit = 'N';        
		entities.PaymentPlanHeader.customerCode = client.clientId;
		entities.PaymentPlanHeader.customerName = client.clientName;
        //entities.PaymentPlan.daysPerYear = 365;
        entities.PaymentPlan.calculationBased = 'E'; //Calendario
		
        //Set Por Defaults
        //entities.PaymentPlan.tableType = 'ALEMANA';
        entities.PaymentPlan.quota = 0;
        entities.PaymentPlan.capital = 0;
        entities.PaymentPlan.paymentDay = 0;
        entities.GeneralParameterLoan.periodicity = 0;
	
        if(!BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.TRAMITE)){
            task.TipoTramite = parentParameters.Task.urlParams.TRAMITE;
        }
        if(!BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.ETAPA)){
            task.Etapa = parentParameters.Task.urlParams.ETAPA;
        }
        
        if(task.creditType != 'GRUPAL'){
            initDataEventArgs.commons.api.viewState.hide('VA_DISPERSIONDATTT_417A26');
        }
        
		//Boton Principal (Wizard)
		initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
			initDataEventArgs.commons.api.vc.executeCommand('CM_TPYEP21MTE89','Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
		}
       
    //Inicio Req.194284 Dia de Pago
    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function (processDate) {        
        processDateTemp = new Date(processDate);
        console.log('Fecha proceso: '+ processDateTemp);
    })
    
    if (task.creditType == 'REVOLVENTE') {
        initDataEventArgs.commons.api.viewState.hide('VA_PAYMENTDAYSQXGZ_884A26');
    }
    //Fin Req.194284 Dia de Pago
        
    };

//Start signature to callBack event to VC_TPYEP21_FAETL_814
task.initDataCallback.VC_TPYEP21_FAETL_814 = function (entities, initDataEventArgs) {
    passInitDataCallback = true;
    // Validacion para fechas
    if (entities.PaymentPlanHeader.dispersionDate == null) {
        entities.PaymentPlanHeader.dispersionDate = entities.PaymentPlanHeader.initialDate
    }
    //initData
    var api = initDataEventArgs.commons.api;
    var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
    if (initDataEventArgs.success) {
        initDataEventArgs.commons.api.viewState.enable('CM_TPYEP21MTE89');
        wasInInitData = true;
    }
    //Cargar las fechas en variables

    fechaValidacion = entities.PaymentPlanHeader.dispersionDateValidate;
    console.log("FECHA VALIDACION");
    console.log(fechaValidacion);

    //Si no es una renovación se inicializa la línea de crédito 
    if ('R' != entities.OriginalHeader.TypeRequest && FLCRE.UTILS.APPLICATION.isDisbursement(initDataEventArgs.commons.api)) {
        var client = initDataEventArgs.commons.api.parentVc.model.Task;
        entities.OriginalHeader.NumberLine = client.bussinessInformationStringOne;
        task.IsDisbursement = true;
        //viewState.show('VA_ORIAHEADER8602_NMLN737');
    }

    //Se coloca para fines de presentación -- borrar
    entities.PaymentPlanHeader.productType = entities.OriginalHeader.ProductType;
    entities.PaymentPlanHeader.auxApprovedAmount = entities.OriginalHeader.AmountRequested;

    api.viewState.disable('VA_VWPAYMENLA2615_APRE101');
    api.viewState.disable('VA_VWPAYMENLA2615_TIRP175');
    api.viewState.disable('VA_VWPAYMENLA2615_RATE787');

    //Grid Rubros Nuevos
    api.vc.viewState.GR_VWPAYMENLA26_27.visible = false;

    if (entities.PaymentPlan.interestPeriodGrace > 0) {
        api.viewState.enable('VA_VWPAYMENLA2605_QAIT788');
    } else if (entities.PaymentPlan.interestPeriodGrace == 0) {
        entities.PaymentPlan.quotaInterest = " ";
        api.viewState.disable('VA_VWPAYMENLA2605_QAIT788');
    }
    task.setNullValuesFE(entities, initDataEventArgs);

    task.loadTaskHeader(entities, initDataEventArgs);
    task.changePaymentFrecuency(entities, initDataEventArgs);
    task.enableDisabledByAcceptsAdditionalPayments(entities, initDataEventArgs);
    task.enableDisabledByExchangeRate(entities, initDataEventArgs);
    task.enableDisabledByPaymentType(entities, initDataEventArgs);

    task.formatAmortizationTable(entities, initDataEventArgs.commons.api);
    if (entities.PaymentPlan.tableType == 'MANUAL') {
        task.disableToolbarAmortizationTable(initDataEventArgs, 'AmortizationTableItem', 'QV_QUYOI3312_16', true);
    } else {
        task.disableToolbarAmortizationTable(initDataEventArgs, 'AmortizationTableItem', 'QV_QUYOI3312_16', false);
    }
    task.enableDiableQuotaInterest(entities, initDataEventArgs);
    initQuota = angular.copy(entities.PaymentPlan.quota);

    //Validación Día de Pago
    if (entities.PaymentPlan.fixedpPaymentDate == 'S') {
        initDataEventArgs.commons.api.viewState.enable('VA_VWPAYMENLA2605_ETDY540');
    } else {
        entities.PaymentPlan.paymentDay = 0;
        initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_ETDY540');
    }

    //Validación cuando la tabla de amortización es de tipo consulta
    if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null &&
        parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.Query) {
        BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success, api); //Habilita el continuar cuando sea modo consulta
        BUSIN.API.GRID.disableEnableToolbar(initDataEventArgs, 'Category', 'QV_UYCTE6570_70', false, 'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para edición en modo CONSULTA
        task.disablePaymentCondition(initDataEventArgs); // Deshabilita condiciones de pago si es etapa de CONSULTA
        if (entities.PaymentPlan.tableType == 'MANUAL') {
            task.disableToolbarAmortizationTable(initDataEventArgs, 'AmortizationTableItem', 'QV_QUYOI3312_16', false);
        }
    }
    //Etapa de Recálculo en la tabla de amortización
    if (task.Etapa === FLCRE.CONSTANTS.Stage.Recalculation) {
        BUSIN.API.GRID.disableEnableToolbar(initDataEventArgs, 'Category', 'QV_UYCTE6570_70', false, 'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para edición en modo CONSULTA
        task.disablePaymentCondition(initDataEventArgs);
        initDataEventArgs.commons.api.viewState.enable('VA_VWPAYMENLA2615_IATE307') //Fecha de Inicio
        initDataEventArgs.commons.api.viewState.enable('VA_VWPAYMENLA2615_SPRE849') //Fecha de primera cuota
    }

    task.showButtons(initDataEventArgs);

    //Se mapea en cero para CPN que no tiene bien calculado el valor en ca_operacion_tmp (opt_cuota)
    entities.PaymentPlan.quota = 0;


    if (entities.AmortizationTableItem.data() != undefined && entities.AmortizationTableItem.data().length > 0 &&
        entities.OriginalHeader.Term != entities.AmortizationTableItem.data().length) {
        initDataEventArgs.commons.api.viewState.lockScreen('VC_TPYEP21_FAETL_814', null);
        initDataEventArgs.commons.api.vc.executeCommand('CM_TPYEP21MTE89', 'Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
    }

    //Se configura los rubros editables
    task.setEditableCategory(initDataEventArgs);

    //GRUPALES
    task.creditType = parentParameters.Task.urlParams.SOLICITUD;
    //CARGAR EL RADIO BUTTON LISTA DE MIEMBROS DEL GRUPO DEPENDIENDO DEL FLUJO DEL CUAL SE ESTA CARGANDO
    if (parentParameters.Task.urlParams.SOLICITUD == 'GRUPAL') {

        entities.PaymentPlanHeader.typePayment = 'I'; //Se requiere que este por defecto = I         
        //entities.PaymentPlanHeader.wayToPay = 'NDAH';
        //initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2618_MEOE230');
        initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.hide('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.show('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.viewState.disable('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPSZFMGQ_712A26', 'Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
        initDataEventArgs.commons.api.viewState.hide('G_VWPAYMELNP_969A26');
        initDataEventArgs.commons.api.grid.hideToolBarButton('QV_UYCTE6570_70', 'CEQV_201_QV_UYCTE6570_70_368')
        task.change.VA_8375LIFACAQCGJL_261A26(entities, initDataEventArgs);
    } else if (parentParameters.Task.urlParams.SOLICITUD == 'INTERCICLO') {
        entities.PaymentPlanHeader.paymentType = undefined;
        initDataEventArgs.commons.api.viewState.hide('G_VWPAYMELNP_969A26');
        initDataEventArgs.commons.api.viewState.hide('VA_8375LIFACAQCGJL_261A26');
        initDataEventArgs.commons.api.viewState.show('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.viewState.disable('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.hide('VA_VWPAYMENLA2618_BTCO941');
        //entities.PaymentPlanHeader.wayToPay = 'NDAH';
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPSZFMGQ_712A26', 'Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);


    } else if (parentParameters.Task.urlParams.SOLICITUD == 'NORMAL') {
        initDataEventArgs.commons.api.viewState.hide('G_VWPAYMELNP_969A26');
        //entities.PaymentPlanHeader.wayToPay = 'NDAH';
        initDataEventArgs.commons.api.viewState.show('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.hide('VA_8375LIFACAQCGJL_261A26');
        entities.PaymentPlanHeader.paymentType = undefined;
    }

    //Caso 98119 mejoras de originación solo deja habilitada la fecha de dispersión y permite recalcular
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2615_IATE307')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2615_SPRE849')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_BLYE585')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_QUOT918')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_TERM808')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_ATQC570')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_UATI478')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_ATTE607')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_NENT977')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_TATY621')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_PILO354')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_EREP542')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_IALR796')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_EACE223')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2617_GARR154')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2617_OHOI726')

    BUSIN.API.GRID.disableEnableToolbar(initDataEventArgs, 'Category', 'QV_UYCTE6570_70', false, 'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para ediciÃ³n en modo CONSULTA
    task.disablePaymentCondition(initDataEventArgs);
    initDataEventArgs.commons.api.viewState.enable('VA_DISPERSIONDATTT_417A26')

    //Inicio Req.194284 Dia de Pago
    if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null &&
        parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.Query) {
		initDataEventArgs.commons.api.viewState.hide('VA_PAYMENTDAYSQXGZ_884A26');
		initDataEventArgs.commons.api.viewState.disable('VA_DISPERSIONDATTT_417A26');
    } else {
		initDataEventArgs.commons.api.viewState.enable('VA_PAYMENTDAYSQXGZ_884A26');
	}
    entities.PaymentPlanHeader.paymentDay = processDateTemp;
    //Fin Req.194284 Dia de Pago

};


//Entity: PaymentPlan
    //PaymentPlan.tableType (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2605_BLYE585 = function(loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
        //loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		
		var resultado = new function () {
            function ItemDTO() {
                this.code = "";
                this.value = "";
            }
            return ItemDTO;
        }
        var valores = [];
        valores[0] = new resultado();
        valores[0].code = 'ALEMANA';
        valores[0].value = cobis.translate("BUSIN.DLB_BUSIN_CAPITAIJO_52111");
        valores[1] = new resultado();
        valores[1].code = 'FRANCESA';
        valores[1].value = cobis.translate("BUSIN.DLB_BUSIN_CUOTAFIJA_27408");
        valores[2] = new resultado();
        valores[2].code = 'MANUAL';
        valores[2].value = cobis.translate("BUSIN.DLB_BUSIN_MANUALFEE_56430");

        return valores;
        
    };

//Entity: PaymentPlan
    //PaymentPlan.quotaInterest (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2605_QAIT788 = function(loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
       		
		var resultado = new function () {
            function ItemDTO() {
                this.code = "";
                this.value = "";
            }
            return ItemDTO;
        }
        var valores = [];
        valores[0] = new resultado();
        valores[0].code = 'N';
        valores[0].value = cobis.translate("BUSIN.DLB_BUSIN_NIMERAUOA_05652");
        valores[1] = new resultado();
        valores[1].code = 'S';
        valores[1].value = cobis.translate("BUSIN.DLB_BUSIN_ENCTASRTE_23124");
        valores[2] = new resultado();
        valores[2].code = 'M';
        valores[2].value = cobis.translate("BUSIN.DLB_BUSIN_NOPAGARWI_44730");

        return valores;
        
    };

//Entity: PaymentPlan
    //PaymentPlan.quotaType (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2605_TATY621 = function(loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
        
    };

//Entity: PaymentPlan
    //PaymentPlan.termType (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2607_ATQC570 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
    };

//Entity: PaymentPlan
    //PaymentPlan.basCalculationInterest (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2607_UATI478 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        //loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		
		var resultado = new function () {
            function ItemDTO() {
                this.code = "";
                this.value = "";
				this.attributes = {};
            }
            return ItemDTO;
        }
        var valores = [];
        valores[0] = new resultado();
        valores[0].code = 'E';
		valores[0].attributes = [{days: 360}];
        valores[0].value = cobis.translate("BUSIN.DLB_BUSIN_COMERCIAL_01521");
        valores[1] = new resultado();
        valores[1].code = 'R';
        valores[1].value = cobis.translate("BUSIN.DLB_BUSIN_REALNYEZK_63415");
		valores[1].attributes = [{days: 365}];
        return valores;
        
    };

//Entity: PaymentPlanHeader
    //PaymentPlanHeader.debitAccount (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2618_BTCO941 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
        
    };

//Entity: PaymentPlanHeader
    //PaymentPlanHeader.wayToPay (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2618_MEOE230 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
        
    };

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

//gridRowDeleting QueryView: GridCategoryItemsNew
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_QERYI6962_42 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            gridRowDeletingEventArgs.commons.serverParameters.CategoryNew = true;
        };

//gridRowDeleting QueryView: GridAmortizationTable
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_QUYOI3312_16 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
            task.changeManualAmortizationTable(entities, gridRowDeletingEventArgs);
        };

//gridRowDeleting QueryView: GridCategoryPlan
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_UYCTE6570_70 = function (entities, gridRowDeletingEventArgs) {
		var categories = angular.copy(entities.Category.data());
		categories.push(gridRowDeletingEventArgs.rowData);
		var num_cap= 0, num_int= 0, num_mora = 0;
		var execute = false;
		categories.forEach(function (item){
			switch(item.ConceptType){
				case 'C':
					num_cap++;
				break;
				case 'I':
					num_int++;
				break;
				case 'M':
					num_mora++;
				break;
				default:
				break;
			}
		});
		
		if(num_cap > 1 && gridRowDeletingEventArgs.rowData.ConceptType == 'C'){
			execute = true;			
		}else if(num_int > 1 && gridRowDeletingEventArgs.rowData.ConceptType =='I'){
			execute = true;
		}else if(num_mora > 1 && gridRowDeletingEventArgs.rowData.ConceptType =='M'){
			execute = true;
		}else if(gridRowDeletingEventArgs.rowData.ConceptType!='C' && gridRowDeletingEventArgs.rowData.ConceptType !='I' && gridRowDeletingEventArgs.rowData.ConceptType !='M'){
			execute = true;
		}
		else{
			//entities.Category.data(categories);		
			gridRowDeletingEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_MGERRCAPA_66886');
			gridRowDeletingEventArgs.commons.execServer = false;
			gridRowDeletingEventArgs.cancel = true;
			return false;
		}
		
		if(execute){
			gridRowDeletingEventArgs.commons.execServer = true;
			gridRowDeletingEventArgs.commons.serverParameters.Category = true;
			gridRowDeletingEventArgs.commons.serverParameters.PaymentPlanHeader = true;
			//gridRowDeletingEventArgs.cancel = true;
			return false;
		}
    };

//Start signature to callBack event to QV_UYCTE6570_70
    task.gridRowDeletingCallback.QV_UYCTE6570_70 = function(entities, gridRowDeletingEventArgsCallback) {
		if(gridRowDeletingEventArgsCallback.success){
			gridRowDeletingEventArgsCallback.commons.messageHandler.showMessagesSuccess('BUSIN.DLB_BUSIN_EIMACIEOA_99670');
			gridRowDeletingEventArgsCallback.commons.api.vc.executeCommand('CM_TPYEP21MTE89',
				'Compute', '', true, false, 'VC_TPYEP21_FAETL_814', false);
		}
    };

//gridRowSelecting QueryView: GridCategoryItemsNew
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_QERYI6962_42 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            gridRowSelectingEventArgs.commons.serverParameters.CategoryNew = true;
        };

//gridRowSelecting QueryView: GridAmortizationTable
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_QUYOI3312_16 = function (entities, gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            entities.PaymentPlan.selectingQuotaIndex = gridRowSelectingEventArgs.rowIndex;
        };



}));