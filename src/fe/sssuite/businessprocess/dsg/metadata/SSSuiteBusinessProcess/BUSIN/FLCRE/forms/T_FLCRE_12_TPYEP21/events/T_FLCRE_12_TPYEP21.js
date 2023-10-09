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