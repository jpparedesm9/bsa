//Designer Generator v 6.8.0 - SPR 2018-01 18/01/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.paymentsmain = designerEvents.api.paymentsmain || designer.dsgEvents();

function VC_PAYMENTSAN_916157(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PAYMENTSAN_916157_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PAYMENTSAN_916157_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout, $translate) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL);
        }
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT)) {
            $scope.dateFormat = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT);
        } else {
            $scope.dateFormat = 'yyyy/MM/dd';
        }
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT_PLACEHOLDER)) {
            $scope.dateFormatPlaceholder = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT_PLACEHOLDER);
        } else {
            $scope.dateFormatPlaceholder = $scope.dateFormat;
        }
        $scope.designer = designer;
        $scope.validatorOptions = validatorOptions;
        $scope.vc = designer.initViewContainer({
            moduleId: "ASSTS",
            subModuleId: "TRNSC",
            taskId: "T_PAYMENTSMANII_157",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PAYMENTSAN_916157",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_PAYMENTSMANII_157",
        designerEvents.api.paymentsmain,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: true,
                hasChangeInitDataSupport: false,
                hasSearchRenderEvent: true,
                ejecTemporaryData: false,
                ejecInitData: false,
                ejecChangeInitData: false,
                ejecSearchRenderEvent: false,
                hasTemporaryData: false,
                hasInitData: false,
                hasChangeInitData: false,
                hasCRUDSupport: false,
                vcName: 'VC_PAYMENTSAN_916157'
            };
            if (($scope.vc.isModal($scope) || $scope.isDesignerInclude || $scope.isDesignerDetail) && angular.isDefined($scope.queryParameters)) {
                $scope.vc.pk = $scope.queryParameters.pk;
                $scope.vc.mode = parseInt($scope.queryParameters.mode || designer.constants.mode.Insert);
            } else {
                $scope.vc.pk = $location.search().pk;
                $scope.vc.mode = parseInt($location.search().mode || designer.constants.mode.Insert);
            }
            $scope.vc.args.pk = $scope.vc.pk;
            $scope.vc.args.mode = $scope.vc.mode;
            if (cobis.userContext.getValue(cobis.constant.USER_NAME)) {
                $scope.vc.args.user = cobis.userContext.getValue(cobis.constant.USER_NAME);
            } else {
                $scope.vc.args.user = "UserOutContainer";
            }
            $scope.vc.customDialogParameters = $scope.customDialogParameters;
            $scope.vc.args.channel = $location.search().channel;
            $scope.vc.metadata = {
                taskPk: {
                    moduleId: 'ASSTS',
                    subModuleId: 'TRNSC',
                    taskId: 'T_PAYMENTSMANII_157',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Payment: "Payment",
                    QuoteDetails: "QuoteDetails",
                    Priorities: "Priorities",
                    CondonationDetail: "CondonationDetail",
                    QuotationCurrency: "QuotationCurrency",
                    Loan: "Loan",
                    Negotiation: "Negotiation",
                    PaymentMethod: "PaymentMethod",
                    LeftOverPayment: "LeftOverPayment"
                },
                entities: {
                    Payment: {
                        amount: 'AT10_AMOUNTQX669',
                        referencedAccount: 'AT11_REFERECA669',
                        retention: 'AT18_RETENTNN669',
                        customerID: 'AT19_CUSTOMED669',
                        reductionType: 'AT21_REDUCTIP669',
                        user: 'AT31_USERGUMY669',
                        paymentType: 'AT32_PAYMENTS669',
                        category: 'AT35_CLASSCHA669',
                        date: 'AT37_DATEIISZ669',
                        collectionType: 'AT39_COLLECOT669',
                        entireFee: 'AT44_ENTIREEE669',
                        quotationValue: 'AT45_QUOTATOI669',
                        payQuotationValue: 'AT46_LEFTOVTT669',
                        reference: 'AT46_REFERECN669',
                        currencyType: 'AT53_CURRENCY669',
                        numCheck: 'AT54_NUMCHEKC669',
                        continuePayment: 'AT60_CONTINUU669',
                        finePrepayment: 'AT60_FINEPRAN669',
                        operationCurrencyType: 'AT61_OPERATRE669',
                        value: 'AT62_VALUEGQO669',
                        datePay: 'AT68_DATEPAYY669',
                        querySequential: 'AT68_SEQUENAT669',
                        advance: 'AT70_ADVANCEE669',
                        quotation: 'AT73_QUOTATIN669',
                        sequential: 'AT74_SEQUENIT669',
                        customer: 'AT77_CUSTOMEE669',
                        amountPrepayment: 'AT83_AMOUNTER669',
                        bank: 'AT86_BANKCZUQ669',
                        onLine: 'AT87_ONLINEZV669',
                        unappliedPayments: 'AT88_UNAPPLTP669',
                        sequentialPay: 'AT89_SEQUENPI669',
                        status: 'AT89_STATUSVP669',
                        regional: 'AT95_REGIONLL669',
                        billTo: 'AT96_BILLTOST669',
                        unappliedAmount: 'AT97_UNAPPLIN669',
                        note: 'AT99_NOTESOKT669',
                        prepayRate: 'AT99_PREPAYEE669',
                        _pks: [],
                        _entityId: 'EN_PAYMENTZY_669',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QuoteDetails: {
                        description: 'AT65_DESCRIOP803',
                        expired: 'AT97_EXPIREDD803',
                        active: 'AT24_ACTIVEQS803',
                        inactive: 'AT11_INACTIVE803',
                        total: 'AT62_TOTALUTI803',
                        _pks: [],
                        _entityId: 'EN_QUOTEDETA_803',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Priorities: {
                        item: 'AT77_ITEMFUQE152',
                        priority: 'AT30_PRIORITT152',
                        _pks: [],
                        _entityId: 'EN_PRIORITII_152',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CondonationDetail: {
                        concept: 'AT98_CONCEPTT795',
                        percentage: 'AT91_PERCENAT795',
                        observation: 'AT89_OBSERVNT795',
                        maximumPercentage: 'AT66_MAXIMUEG795',
                        totalValue: 'AT91_TOTALVAE795',
                        valueToCondone: 'AT14_VALUETOO795',
                        description: 'AT92_DESCRIPN795',
                        loanBankID: 'AT91_LOANBAKI795',
                        _pks: [],
                        _entityId: 'EN_CONDONAII_795',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QuotationCurrency: {
                        currencyType: 'AT62_CURRENCT860',
                        date: 'AT30_DATERVCF860',
                        value: 'AT41_VALUEKRT860',
                        result: 'AT74_RESULTRD860',
                        _pks: [],
                        _entityId: 'EN_QUOTATIUO_860',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Loan: {
                        numProcedure: 'AT10_NUMPROUE882',
                        quotaCredit: 'AT12_QUOTACEE882',
                        statusID: 'AT12_STATUSID882',
                        lastProcessDate: 'AT19_LASTPRED882',
                        balanceDue: 'AT21_BALANCDD882',
                        category: 'AT23_CATEGOYR882',
                        operationTypeID: 'AT23_OPERATDP882',
                        codCurrency: 'AT24_CODMONDD882',
                        newStatusID: 'AT25_NEWSTATT882',
                        isDisbursment: 'AT26_ISDISBTU882',
                        migratedOper: 'AT33_MIGRATEO882',
                        loanID: 'AT37_LOANIDFI882',
                        officeID: 'AT37_OFFICEID882',
                        currencyName: 'AT39_CURRENYY882',
                        startDate: 'AT39_STARTDEE882',
                        loanBankID: 'AT42_LOANBADK882',
                        idType: 'AT48_IDTYPEBH882',
                        endDate: 'AT50_ENDDATEE882',
                        identityCardNumber: 'AT56_IDCARDUU882',
                        desOperationType: 'AT57_DESOPETI882',
                        redesCont: 'AT58_REDESCTN882',
                        newStatus: 'AT59_NEWSTASS882',
                        group: 'AT62_GROUPTNG882',
                        previousOper: 'AT65_PREVIOPU882',
                        status: 'AT66_STATUSOB882',
                        clientID: 'AT68_CLIENTII882',
                        operationType: 'AT70_OPERATPP882',
                        clientName: 'AT71_CLIENTNA882',
                        disbursementDate: 'AT76_DISBURTS882',
                        expirationDate: 'AT76_EXPIRAEE882',
                        officer: 'AT77_OFFICERR882',
                        nextPayment: 'AT85_NEXTPAMT882',
                        effectiveAnualRate: 'AT90_EFFECTAU882',
                        amount: 'AT91_AMOUNTMO882',
                        adjustment: 'AT94_ADJUSTNT882',
                        officerID: 'AT95_OFFICEID882',
                        office: 'AT96_OFFICEPU882',
                        feeEndDate: 'AT99_FEEENDED882',
                        _pks: [],
                        _entityId: 'EN_LOANKYMRI_882',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Negotiation: {
                        paymentType: 'AT11_PAYMENPT654',
                        interestType: 'AT29_INTEREAA654',
                        fullFee: 'AT83_FULLFEEE654',
                        additionalPayments: 'AT31_ADDITINN654',
                        calculateReturn: 'AT82_CALCULET654',
                        reductionType: 'AT82_REDUCTEE654',
                        _pks: [],
                        _entityId: 'EN_NEGOTIATI_654',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentMethod: {
                        product: 'AT13_PRODUCTT664',
                        description: 'AT99_DESCRITT664',
                        category: 'AT80_CATEGOYY664',
                        retention: 'AT64_RETENTON664',
                        cobisProduct: 'AT31_COBISPCO664',
                        _pks: [],
                        _entityId: 'EN_PAYMENTOT_664',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LeftOverPayment: {
                        currencyType: 'AT39_CURRENYY480',
                        paymentType: 'AT76_PAYMENYY480',
                        reference: 'AT71_REFERENE480',
                        note: 'AT50_NOTEXHBJ480',
                        numCheck: 'AT54_NUMCHECC480',
                        bank: 'AT58_BANKJOXU480',
                        value: 'AT74_VALUEXWT480',
                        leftoverQuotationValue: 'AT27_LEFTOVEA480',
                        _pks: [],
                        _entityId: 'EN_LEFTOVEAR_480',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QUOTEDLA_2540 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUOTEDLA_2540 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUOTEDLA_2540_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUOTEDLA_2540_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_QUOTEDETA_803',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUOTEDLA_2540',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QUOTEDLA_2540_filters = {};
            $scope.vc.queryProperties.Q_CONDONDE_7324 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_CONDONDE_7324 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CONDONDE_7324_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CONDONDE_7324_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CONDONAII_795',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CONDONDE_7324',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_CONDONDE_7324_filters = {};
            $scope.vc.queryProperties.Q_PRIORIIT_3510 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_PRIORIIT_3510 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PRIORIIT_3510_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PRIORIIT_3510_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PRIORITII_152',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PRIORIIT_3510',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_PRIORIIT_3510_filters = {};
            $scope.vc.queryProperties.Q_QUOTATNU_1156 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUOTATNU_1156 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUOTATNU_1156_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUOTATNU_1156_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_QUOTATIUO_860',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUOTATNU_1156',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QUOTATNU_1156_filters = {};
            var defaultValues = {
                Payment: {},
                QuoteDetails: {},
                Priorities: {},
                CondonationDetail: {},
                QuotationCurrency: {},
                Loan: {},
                Negotiation: {},
                PaymentMethod: {},
                LeftOverPayment: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (var en in defaultValues) {
                    if (defaultValues.hasOwnProperty(en) && en === entityName) {
                        for (var att in defaultValues[en]) {
                            if (defaultValues[en].hasOwnProperty(att) && att === attributeName) {
                                for (var ch in defaultValues[en][att]) {
                                    if (defaultValues[en][att].hasOwnProperty(ch) && ch === channel) {
                                        return defaultValues[en][att][ch];
                                    }
                                }
                            }
                        }
                    }
                }
                if (typeof valueIfNotExist !== "undefined") {
                    return valueIfNotExist;
                } else {
                    return null;
                }
            };
            $scope.vc.temporarySave = function() {
                console.log("temporarySave");
                var modelo = $scope.vc.cleanData($scope.vc.model);
                var data = {
                    model: modelo,
                    trackers: $scope.vc.trackers,
                    temporaryStorePK: $scope.vc.metadata.taskPk
                };
                $scope.vc.execute("temporarySave", VC_PAYMENTSAN_916157, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_PAYMENTSAN_916157, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_PAYMENTSAN_916157, data, function() {});
                            $scope.vc.crud.addTrackers($scope.vc.model);
                        }
                        page.hasTemporaryData = result;
                        page.ejecTemporaryData = response.success;
                        return page;
                    });
                } else {
                    page.ejecTemporaryData = false;
                    page.hasTemporaryData = false;
                    return page;
                }
            };
            $scope.vc.viewState.keyDown = function(e) {
                dsgnrUtils.container.validateOnEnter(e, $scope.vc);
            }
            $scope.vc.viewState.VC_PAYMENTSAN_916157 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PAYMENTSAN_916157",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_ZNXEHASOGQ_840157",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_XYWZLGVMRI_969316",
                hasId: true,
                componentStyle: [],
                label: 'LoanHeaderInfoForm',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Loan = {
                numProcedure: $scope.vc.channelDefaultValues("Loan", "numProcedure"),
                quotaCredit: $scope.vc.channelDefaultValues("Loan", "quotaCredit"),
                statusID: $scope.vc.channelDefaultValues("Loan", "statusID"),
                lastProcessDate: $scope.vc.channelDefaultValues("Loan", "lastProcessDate"),
                balanceDue: $scope.vc.channelDefaultValues("Loan", "balanceDue"),
                category: $scope.vc.channelDefaultValues("Loan", "category"),
                operationTypeID: $scope.vc.channelDefaultValues("Loan", "operationTypeID"),
                codCurrency: $scope.vc.channelDefaultValues("Loan", "codCurrency"),
                newStatusID: $scope.vc.channelDefaultValues("Loan", "newStatusID"),
                isDisbursment: $scope.vc.channelDefaultValues("Loan", "isDisbursment"),
                migratedOper: $scope.vc.channelDefaultValues("Loan", "migratedOper"),
                loanID: $scope.vc.channelDefaultValues("Loan", "loanID"),
                officeID: $scope.vc.channelDefaultValues("Loan", "officeID"),
                currencyName: $scope.vc.channelDefaultValues("Loan", "currencyName"),
                startDate: $scope.vc.channelDefaultValues("Loan", "startDate"),
                loanBankID: $scope.vc.channelDefaultValues("Loan", "loanBankID"),
                idType: $scope.vc.channelDefaultValues("Loan", "idType"),
                endDate: $scope.vc.channelDefaultValues("Loan", "endDate"),
                identityCardNumber: $scope.vc.channelDefaultValues("Loan", "identityCardNumber"),
                desOperationType: $scope.vc.channelDefaultValues("Loan", "desOperationType"),
                redesCont: $scope.vc.channelDefaultValues("Loan", "redesCont"),
                newStatus: $scope.vc.channelDefaultValues("Loan", "newStatus"),
                group: $scope.vc.channelDefaultValues("Loan", "group"),
                previousOper: $scope.vc.channelDefaultValues("Loan", "previousOper"),
                status: $scope.vc.channelDefaultValues("Loan", "status"),
                clientID: $scope.vc.channelDefaultValues("Loan", "clientID"),
                operationType: $scope.vc.channelDefaultValues("Loan", "operationType"),
                clientName: $scope.vc.channelDefaultValues("Loan", "clientName"),
                disbursementDate: $scope.vc.channelDefaultValues("Loan", "disbursementDate"),
                expirationDate: $scope.vc.channelDefaultValues("Loan", "expirationDate"),
                officer: $scope.vc.channelDefaultValues("Loan", "officer"),
                nextPayment: $scope.vc.channelDefaultValues("Loan", "nextPayment"),
                effectiveAnualRate: $scope.vc.channelDefaultValues("Loan", "effectiveAnualRate"),
                amount: $scope.vc.channelDefaultValues("Loan", "amount"),
                adjustment: $scope.vc.channelDefaultValues("Loan", "adjustment"),
                officerID: $scope.vc.channelDefaultValues("Loan", "officerID"),
                office: $scope.vc.channelDefaultValues("Loan", "office"),
                feeEndDate: $scope.vc.channelDefaultValues("Loan", "feeEndDate")
            };
            //ViewState - Group: Group2443
            $scope.vc.createViewState({
                id: "G_LOANHEADOD_564612",
                hasId: true,
                componentStyle: [],
                label: 'Group2443',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_143612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1657
            $scope.vc.createViewState({
                id: "G_LOANHEADRO_349612",
                hasId: true,
                componentStyle: [],
                label: 'Group1657',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: loanBankID
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_867612",
                componentStyle: [],
                labelImageId: "",
                label: "ASSTS.LBL_ASSTS_PRSTAMOFK_44930",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVITZRQ_108612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-info-sign",
                label: "ASSTS.LBL_ASSTS_MASINACIN_18792",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONORYJAMS_468612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-search",
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1848
            $scope.vc.createViewState({
                id: "G_LOANHEAINF_340612",
                hasId: true,
                componentStyle: [],
                label: 'Group1848',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_5034UOFCASVGKTK_993612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOCRDOO_69382",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: balanceDue
            $scope.vc.createViewState({
                id: "VA_2463BHBNLZPKLMU_865612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOEXBB_70535",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: status
            $scope.vc.createViewState({
                id: "VA_3853RRTWBIRUGHQ_533612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOEAI_33340",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: office
            $scope.vc.createViewState({
                id: "VA_7292SEAHPRAXOKC_868612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_IGBKXOBUDB_899157",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: PaymentsForm
            $scope.vc.createViewState({
                id: "VC_QXXNBZDVLA_903850",
                hasId: true,
                componentStyle: [],
                label: 'PaymentsForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1193
            $scope.vc.createViewState({
                id: "G_PAYMENTSSS_299141",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1193',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Payment = {
                amount: $scope.vc.channelDefaultValues("Payment", "amount"),
                referencedAccount: $scope.vc.channelDefaultValues("Payment", "referencedAccount"),
                retention: $scope.vc.channelDefaultValues("Payment", "retention"),
                customerID: $scope.vc.channelDefaultValues("Payment", "customerID"),
                reductionType: $scope.vc.channelDefaultValues("Payment", "reductionType"),
                user: $scope.vc.channelDefaultValues("Payment", "user"),
                paymentType: $scope.vc.channelDefaultValues("Payment", "paymentType"),
                category: $scope.vc.channelDefaultValues("Payment", "category"),
                date: $scope.vc.channelDefaultValues("Payment", "date"),
                collectionType: $scope.vc.channelDefaultValues("Payment", "collectionType"),
                entireFee: $scope.vc.channelDefaultValues("Payment", "entireFee"),
                quotationValue: $scope.vc.channelDefaultValues("Payment", "quotationValue"),
                payQuotationValue: $scope.vc.channelDefaultValues("Payment", "payQuotationValue"),
                reference: $scope.vc.channelDefaultValues("Payment", "reference"),
                currencyType: $scope.vc.channelDefaultValues("Payment", "currencyType"),
                numCheck: $scope.vc.channelDefaultValues("Payment", "numCheck"),
                continuePayment: $scope.vc.channelDefaultValues("Payment", "continuePayment"),
                finePrepayment: $scope.vc.channelDefaultValues("Payment", "finePrepayment"),
                operationCurrencyType: $scope.vc.channelDefaultValues("Payment", "operationCurrencyType"),
                value: $scope.vc.channelDefaultValues("Payment", "value"),
                datePay: $scope.vc.channelDefaultValues("Payment", "datePay"),
                querySequential: $scope.vc.channelDefaultValues("Payment", "querySequential"),
                advance: $scope.vc.channelDefaultValues("Payment", "advance"),
                quotation: $scope.vc.channelDefaultValues("Payment", "quotation"),
                sequential: $scope.vc.channelDefaultValues("Payment", "sequential"),
                customer: $scope.vc.channelDefaultValues("Payment", "customer"),
                amountPrepayment: $scope.vc.channelDefaultValues("Payment", "amountPrepayment"),
                bank: $scope.vc.channelDefaultValues("Payment", "bank"),
                onLine: $scope.vc.channelDefaultValues("Payment", "onLine"),
                unappliedPayments: $scope.vc.channelDefaultValues("Payment", "unappliedPayments"),
                sequentialPay: $scope.vc.channelDefaultValues("Payment", "sequentialPay"),
                status: $scope.vc.channelDefaultValues("Payment", "status"),
                regional: $scope.vc.channelDefaultValues("Payment", "regional"),
                billTo: $scope.vc.channelDefaultValues("Payment", "billTo"),
                unappliedAmount: $scope.vc.channelDefaultValues("Payment", "unappliedAmount"),
                note: $scope.vc.channelDefaultValues("Payment", "note"),
                prepayRate: $scope.vc.channelDefaultValues("Payment", "prepayRate")
            };
            //ViewState - Group: Group2407
            $scope.vc.createViewState({
                id: "G_PAYMENTSSS_270141",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_INGRESORA_23779",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_AMOUNTGSUZWEZJK_997141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOOPII_56896",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: date
            $scope.vc.createViewState({
                id: "VA_DATEGYMPIXSZGYL_543141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAQWBP_23514",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: paymentType
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXCFY_310141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APAGOVQRF_51833",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXCFY_310141 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXCFY_310141', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXCFY_310141'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXCFY_310141");
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Payment, Attribute: customer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHQX_290141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_COBRARAFT_16046",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: reference
            $scope.vc.createViewState({
                id: "VA_REFERENCECGUXXB_239141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REFERENCI_47355",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: value
            $scope.vc.createViewState({
                id: "VA_VALUEEFNQCTRLMP_628141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONTOEMFX_52083",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: currencyType
            $scope.vc.createViewState({
                id: "VA_CURRENCYSPEYFQA_285141",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CURRENCYSPEYFQA_285141 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CURRENCYSPEYFQA_285141', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CURRENCYSPEYFQA_285141'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CURRENCYSPEYFQA_285141");
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_923141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CONVERSSN_95041",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: numCheck
            $scope.vc.createViewState({
                id: "VA_NUMCHECKQLTBIOX_669141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CHEQUEBCI_27043",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: bank
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXSJQ_831141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BANCOPEGT_42609",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXSJQ_831141 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXSJQ_831141', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXSJQ_831141'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXSJQ_831141");
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Payment, Attribute: retention
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPMM_746141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RETENCINN_79250",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: note
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXIKP_805141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESCRIPNI_65857",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: onLine
            $scope.vc.createViewState({
                id: "VA_CHECKBOXIPQLEBS_550141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APLICAELN_71517",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: amountPrepayment
            $scope.vc.createViewState({
                id: "VA_AMOUNTPREPAYTME_876141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOPRCN_87630",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Payment, Attribute: finePrepayment
            $scope.vc.createViewState({
                id: "VA_FINEPREPAYMETTT_628141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MULTAPRCI_95892",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2717
            $scope.vc.createViewState({
                id: "G_PAYMENTSSS_827141",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORAPAA_99910",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QuoteDetails = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuoteDetails", "description", '')
                    },
                    expired: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuoteDetails", "expired", 0)
                    },
                    active: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuoteDetails", "active", 0)
                    },
                    inactive: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuoteDetails", "inactive", 0)
                    },
                    total: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuoteDetails", "total", 0)
                    }
                }
            });
            $scope.vc.model.QuoteDetails = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUOTEDLA_2540();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.QuoteDetails
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2540_50573").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUOTEDLA_2540 = $scope.vc.model.QuoteDetails;
            $scope.vc.trackers.QuoteDetails = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QuoteDetails);
            $scope.vc.model.QuoteDetails.bind('change', function(e) {
                $scope.vc.trackers.QuoteDetails.track(e);
            });
            $scope.vc.grids.QV_2540_50573 = {};
            $scope.vc.grids.QV_2540_50573.queryId = 'Q_QUOTEDLA_2540';
            $scope.vc.viewState.QV_2540_50573 = {
                style: []
            };
            $scope.vc.viewState.QV_2540_50573.column = {};
            $scope.vc.grids.QV_2540_50573.editable = false;
            $scope.vc.grids.QV_2540_50573.events = {
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.QuoteDetails.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_2540_50573.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_2540_50573", false, grid);
                    $scope.vc.hideShowColumns("QV_2540_50573", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2540_50573.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2540_50573.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_2540_50573.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2540_50573 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2540_50573 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_2540_50573.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2540_50573.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2540_50573.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPNI_65857',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEYP_949141',
                element: []
            };
            $scope.vc.grids.QV_2540_50573.AT65_DESCRIOP803 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_2540_50573.column.description.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2540_50573.column.expired = {
                title: 'ASSTS.LBL_ASSTS_VENCIDOUG_82584',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVNN_469141',
                element: []
            };
            $scope.vc.grids.QV_2540_50573.AT97_EXPIREDD803 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_2540_50573.column.expired.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2540_50573.column.active = {
                title: 'ASSTS.LBL_ASSTS_VIGENTEON_55349',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJHA_669141',
                element: []
            };
            $scope.vc.grids.QV_2540_50573.AT24_ACTIVEQS803 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_2540_50573.column.active.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2540_50573.column.inactive = {
                title: 'ASSTS.LBL_ASSTS_NOVIGENTT_94041',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBDE_877141',
                element: []
            };
            $scope.vc.grids.QV_2540_50573.AT11_INACTIVE803 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_2540_50573.column.inactive.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2540_50573.column.total = {
                title: 'ASSTS.LBL_ASSTS_TOTALAOJT_55920',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQVI_445141',
                element: []
            };
            $scope.vc.grids.QV_2540_50573.AT62_TOTALUTI803 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_2540_50573.column.total.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2540_50573.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_2540_50573.column.description.title|translate:vc.viewState.QV_2540_50573.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_2540_50573.column.description.width,
                    format: $scope.vc.viewState.QV_2540_50573.column.description.format,
                    editor: $scope.vc.grids.QV_2540_50573.AT65_DESCRIOP803.control,
                    template: "<span ng-class='vc.viewState.QV_2540_50573.column.description.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_2540_50573\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2540_50573.column.description.style",
                        "title": "{{vc.viewState.QV_2540_50573.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2540_50573.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2540_50573.columns.push({
                    field: 'expired',
                    title: '{{vc.viewState.QV_2540_50573.column.expired.title|translate:vc.viewState.QV_2540_50573.column.expired.titleArgs}}',
                    width: $scope.vc.viewState.QV_2540_50573.column.expired.width,
                    format: $scope.vc.viewState.QV_2540_50573.column.expired.format,
                    editor: $scope.vc.grids.QV_2540_50573.AT97_EXPIREDD803.control,
                    template: "<span ng-class='vc.viewState.QV_2540_50573.column.expired.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.expired, \"QV_2540_50573\", \"expired\"):kendo.toString(#=expired#, vc.viewState.QV_2540_50573.column.expired.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2540_50573.column.expired.style",
                        "title": "{{vc.viewState.QV_2540_50573.column.expired.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2540_50573.column.expired.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2540_50573.columns.push({
                    field: 'active',
                    title: '{{vc.viewState.QV_2540_50573.column.active.title|translate:vc.viewState.QV_2540_50573.column.active.titleArgs}}',
                    width: $scope.vc.viewState.QV_2540_50573.column.active.width,
                    format: $scope.vc.viewState.QV_2540_50573.column.active.format,
                    editor: $scope.vc.grids.QV_2540_50573.AT24_ACTIVEQS803.control,
                    template: "<span ng-class='vc.viewState.QV_2540_50573.column.active.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.active, \"QV_2540_50573\", \"active\"):kendo.toString(#=active#, vc.viewState.QV_2540_50573.column.active.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2540_50573.column.active.style",
                        "title": "{{vc.viewState.QV_2540_50573.column.active.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2540_50573.column.active.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2540_50573.columns.push({
                    field: 'inactive',
                    title: '{{vc.viewState.QV_2540_50573.column.inactive.title|translate:vc.viewState.QV_2540_50573.column.inactive.titleArgs}}',
                    width: $scope.vc.viewState.QV_2540_50573.column.inactive.width,
                    format: $scope.vc.viewState.QV_2540_50573.column.inactive.format,
                    editor: $scope.vc.grids.QV_2540_50573.AT11_INACTIVE803.control,
                    template: "<span ng-class='vc.viewState.QV_2540_50573.column.inactive.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.inactive, \"QV_2540_50573\", \"inactive\"):kendo.toString(#=inactive#, vc.viewState.QV_2540_50573.column.inactive.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2540_50573.column.inactive.style",
                        "title": "{{vc.viewState.QV_2540_50573.column.inactive.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2540_50573.column.inactive.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2540_50573.columns.push({
                    field: 'total',
                    title: '{{vc.viewState.QV_2540_50573.column.total.title|translate:vc.viewState.QV_2540_50573.column.total.titleArgs}}',
                    width: $scope.vc.viewState.QV_2540_50573.column.total.width,
                    format: $scope.vc.viewState.QV_2540_50573.column.total.format,
                    editor: $scope.vc.grids.QV_2540_50573.AT62_TOTALUTI803.control,
                    template: "<span ng-class='vc.viewState.QV_2540_50573.column.total.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.total, \"QV_2540_50573\", \"total\"):kendo.toString(#=total#, vc.viewState.QV_2540_50573.column.total.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2540_50573.column.total.style",
                        "title": "{{vc.viewState.QV_2540_50573.column.total.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2540_50573.column.total.hidden
                });
            }
            $scope.vc.viewState.QV_2540_50573.toolbar = {
                CEQV_201QV_2540_50573_362: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_2540_50573.toolbar = [{
                "name": "CEQV_201QV_2540_50573_362",
                "text": "{{'ASSTS.LBL_ASSTS_DETALLECT_10474'|translate}}",
                "template": "<button id='CEQV_201QV_2540_50573_362' " + " ng-if='vc.viewState.QV_2540_50573.toolbar.CEQV_201QV_2540_50573_362.visible' " + "ng-disabled = 'vc.viewState.G_PAYMENTSSS_827141.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_2540_50573_362\",\"QuoteDetails\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }];
            //ViewState - Group: Group1756
            $scope.vc.createViewState({
                id: "G_PAYMENTSSS_505141",
                hasId: true,
                componentStyle: [],
                label: 'Group1756',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.Priorities = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    item: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Priorities", "item", '')
                    },
                    priority: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Priorities", "priority", 0)
                    }
                }
            });
            $scope.vc.model.Priorities = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_PRIORIIT_3510();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.Priorities
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3510_91785").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PRIORIIT_3510 = $scope.vc.model.Priorities;
            $scope.vc.trackers.Priorities = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Priorities);
            $scope.vc.model.Priorities.bind('change', function(e) {
                $scope.vc.trackers.Priorities.track(e);
            });
            $scope.vc.grids.QV_3510_91785 = {};
            $scope.vc.grids.QV_3510_91785.queryId = 'Q_PRIORIIT_3510';
            $scope.vc.viewState.QV_3510_91785 = {
                style: []
            };
            $scope.vc.viewState.QV_3510_91785.column = {};
            $scope.vc.grids.QV_3510_91785.editable = false;
            $scope.vc.grids.QV_3510_91785.events = {
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.Priorities.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3510_91785.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_3510_91785", false, grid);
                    $scope.vc.hideShowColumns("QV_3510_91785", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3510_91785.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3510_91785.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3510_91785.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3510_91785 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3510_91785 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3510_91785.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3510_91785.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3510_91785.column.item = {
                title: 'item',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRNV_593141',
                element: []
            };
            $scope.vc.grids.QV_3510_91785.AT77_ITEMFUQE152 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3510_91785.column.item.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRNV_593141",
                        'data-validation-code': "{{vc.viewState.QV_3510_91785.column.item.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3510_91785.column.item.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3510_91785.column.priority = {
                title: 'priority',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPSA_455141',
                element: []
            };
            $scope.vc.grids.QV_3510_91785.AT30_PRIORITT152 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3510_91785.column.priority.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPSA_455141",
                        'data-validation-code': "{{vc.viewState.QV_3510_91785.column.priority.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3510_91785.column.priority.format",
                        'k-decimals': "vc.viewState.QV_3510_91785.column.priority.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3510_91785.column.priority.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3510_91785.columns.push({
                    field: 'item',
                    title: '{{vc.viewState.QV_3510_91785.column.item.title|translate:vc.viewState.QV_3510_91785.column.item.titleArgs}}',
                    width: $scope.vc.viewState.QV_3510_91785.column.item.width,
                    format: $scope.vc.viewState.QV_3510_91785.column.item.format,
                    editor: $scope.vc.grids.QV_3510_91785.AT77_ITEMFUQE152.control,
                    template: "<span ng-class='vc.viewState.QV_3510_91785.column.item.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.item, \"QV_3510_91785\", \"item\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3510_91785.column.item.style",
                        "title": "{{vc.viewState.QV_3510_91785.column.item.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3510_91785.column.item.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3510_91785.columns.push({
                    field: 'priority',
                    title: '{{vc.viewState.QV_3510_91785.column.priority.title|translate:vc.viewState.QV_3510_91785.column.priority.titleArgs}}',
                    width: $scope.vc.viewState.QV_3510_91785.column.priority.width,
                    format: $scope.vc.viewState.QV_3510_91785.column.priority.format,
                    editor: $scope.vc.grids.QV_3510_91785.AT30_PRIORITT152.control,
                    template: "<span ng-class='vc.viewState.QV_3510_91785.column.priority.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.priority, \"QV_3510_91785\", \"priority\"):kendo.toString(#=priority#, vc.viewState.QV_3510_91785.column.priority.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3510_91785.column.priority.style",
                        "title": "{{vc.viewState.QV_3510_91785.column.priority.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3510_91785.column.priority.hidden
                });
            }
            $scope.vc.viewState.QV_3510_91785.toolbar = {}
            $scope.vc.grids.QV_3510_91785.toolbar = [];
            //ViewState - Group: Group1139
            $scope.vc.createViewState({
                id: "G_PAYMENTSSS_641141",
                hasId: true,
                componentStyle: [],
                label: 'Group1139',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.CondonationDetail = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "concept", ''),
                        validation: {
                            conceptRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "description", '')
                    },
                    observation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "observation", '')
                    },
                    percentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "percentage", 0)
                    },
                    valueToCondone: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "valueToCondone", 0)
                    },
                    maximumPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "maximumPercentage", 0)
                    },
                    totalValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "totalValue", 0)
                    }
                }
            });
            $scope.vc.model.CondonationDetail = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_CONDONDE_7324();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.CondonationDetail
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7324_97053").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CONDONDE_7324 = $scope.vc.model.CondonationDetail;
            $scope.vc.trackers.CondonationDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CondonationDetail);
            $scope.vc.model.CondonationDetail.bind('change', function(e) {
                $scope.vc.trackers.CondonationDetail.track(e);
            });
            $scope.vc.grids.QV_7324_97053 = {};
            $scope.vc.grids.QV_7324_97053.queryId = 'Q_CONDONDE_7324';
            $scope.vc.viewState.QV_7324_97053 = {
                style: []
            };
            $scope.vc.viewState.QV_7324_97053.column = {};
            $scope.vc.grids.QV_7324_97053.editable = false;
            $scope.vc.grids.QV_7324_97053.events = {
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.CondonationDetail.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7324_97053.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7324_97053", false, grid);
                    $scope.vc.hideShowColumns("QV_7324_97053", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7324_97053.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7324_97053.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7324_97053.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7324_97053 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7324_97053 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7324_97053.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7324_97053.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7324_97053.column.concept = {
                title: 'concept',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXRMI_168141',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXRMI_168141 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXRMI_168141', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXRMI_168141'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_7324_97053.AT98_CONCEPTT795 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_97053.column.concept.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRMI_168141",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_7324_97053.column.concept.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXRMI_168141",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_7324_97053.column.concept.template",
                        'required': '',
                        'data-required-msg': 'concept' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_7324_97053.column.concept.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'dsgrequired': "",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,3",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_97053.column.description = {
                title: 'description',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLCG_746141',
                element: []
            };
            $scope.vc.grids.QV_7324_97053.AT92_DESCRIPN795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_97053.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLCG_746141",
                        'data-validation-code': "{{vc.viewState.QV_7324_97053.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_97053.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_97053.column.observation = {
                title: 'observation',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZOM_536141',
                element: []
            };
            $scope.vc.grids.QV_7324_97053.AT89_OBSERVNT795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_97053.column.observation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZOM_536141",
                        'data-validation-code': "{{vc.viewState.QV_7324_97053.column.observation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_97053.column.observation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_97053.column.percentage = {
                title: 'percentage',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGOF_926141',
                element: []
            };
            $scope.vc.grids.QV_7324_97053.AT91_PERCENAT795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_97053.column.percentage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGOF_926141",
                        'data-validation-code': "{{vc.viewState.QV_7324_97053.column.percentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_97053.column.percentage.format",
                        'k-decimals': "vc.viewState.QV_7324_97053.column.percentage.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_97053.column.percentage.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_97053.column.valueToCondone = {
                title: 'valueToCondone',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBXZ_110141',
                element: []
            };
            $scope.vc.grids.QV_7324_97053.AT14_VALUETOO795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_97053.column.valueToCondone.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBXZ_110141",
                        'data-validation-code': "{{vc.viewState.QV_7324_97053.column.valueToCondone.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_97053.column.valueToCondone.format",
                        'k-decimals': "vc.viewState.QV_7324_97053.column.valueToCondone.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_97053.column.valueToCondone.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_97053.column.maximumPercentage = {
                title: 'maximumPercentage',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUKY_647141',
                element: []
            };
            $scope.vc.grids.QV_7324_97053.AT66_MAXIMUEG795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_97053.column.maximumPercentage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUKY_647141",
                        'data-validation-code': "{{vc.viewState.QV_7324_97053.column.maximumPercentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_97053.column.maximumPercentage.format",
                        'k-decimals': "vc.viewState.QV_7324_97053.column.maximumPercentage.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_97053.column.maximumPercentage.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_97053.column.totalValue = {
                title: 'totalValue',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYXB_876141',
                element: []
            };
            $scope.vc.grids.QV_7324_97053.AT91_TOTALVAE795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_97053.column.totalValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYXB_876141",
                        'data-validation-code': "{{vc.viewState.QV_7324_97053.column.totalValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_97053.column.totalValue.format",
                        'k-decimals': "vc.viewState.QV_7324_97053.column.totalValue.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_97053.column.totalValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_97053.columns.push({
                    field: 'concept',
                    title: '{{vc.viewState.QV_7324_97053.column.concept.title|translate:vc.viewState.QV_7324_97053.column.concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_97053.column.concept.width,
                    format: $scope.vc.viewState.QV_7324_97053.column.concept.format,
                    editor: $scope.vc.grids.QV_7324_97053.AT98_CONCEPTT795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_97053.column.concept.element[dataItem.dsgnrId].style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXRMI_168141.get(dataItem.concept).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7324_97053.column.concept.style",
                        "title": "{{vc.viewState.QV_7324_97053.column.concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_97053.column.concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_97053.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7324_97053.column.description.title|translate:vc.viewState.QV_7324_97053.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_97053.column.description.width,
                    format: $scope.vc.viewState.QV_7324_97053.column.description.format,
                    editor: $scope.vc.grids.QV_7324_97053.AT92_DESCRIPN795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_97053.column.description.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7324_97053\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7324_97053.column.description.style",
                        "title": "{{vc.viewState.QV_7324_97053.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_97053.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_97053.columns.push({
                    field: 'observation',
                    title: '{{vc.viewState.QV_7324_97053.column.observation.title|translate:vc.viewState.QV_7324_97053.column.observation.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_97053.column.observation.width,
                    format: $scope.vc.viewState.QV_7324_97053.column.observation.format,
                    editor: $scope.vc.grids.QV_7324_97053.AT89_OBSERVNT795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_97053.column.observation.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.observation, \"QV_7324_97053\", \"observation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7324_97053.column.observation.style",
                        "title": "{{vc.viewState.QV_7324_97053.column.observation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_97053.column.observation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_97053.columns.push({
                    field: 'percentage',
                    title: '{{vc.viewState.QV_7324_97053.column.percentage.title|translate:vc.viewState.QV_7324_97053.column.percentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_97053.column.percentage.width,
                    format: $scope.vc.viewState.QV_7324_97053.column.percentage.format,
                    editor: $scope.vc.grids.QV_7324_97053.AT91_PERCENAT795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_97053.column.percentage.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.percentage, \"QV_7324_97053\", \"percentage\"):kendo.toString(#=percentage#, vc.viewState.QV_7324_97053.column.percentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_97053.column.percentage.style",
                        "title": "{{vc.viewState.QV_7324_97053.column.percentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_97053.column.percentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_97053.columns.push({
                    field: 'valueToCondone',
                    title: '{{vc.viewState.QV_7324_97053.column.valueToCondone.title|translate:vc.viewState.QV_7324_97053.column.valueToCondone.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_97053.column.valueToCondone.width,
                    format: $scope.vc.viewState.QV_7324_97053.column.valueToCondone.format,
                    editor: $scope.vc.grids.QV_7324_97053.AT14_VALUETOO795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_97053.column.valueToCondone.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueToCondone, \"QV_7324_97053\", \"valueToCondone\"):kendo.toString(#=valueToCondone#, vc.viewState.QV_7324_97053.column.valueToCondone.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_97053.column.valueToCondone.style",
                        "title": "{{vc.viewState.QV_7324_97053.column.valueToCondone.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7324_97053.column.valueToCondone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_97053.columns.push({
                    field: 'maximumPercentage',
                    title: '{{vc.viewState.QV_7324_97053.column.maximumPercentage.title|translate:vc.viewState.QV_7324_97053.column.maximumPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_97053.column.maximumPercentage.width,
                    format: $scope.vc.viewState.QV_7324_97053.column.maximumPercentage.format,
                    editor: $scope.vc.grids.QV_7324_97053.AT66_MAXIMUEG795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_97053.column.maximumPercentage.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.maximumPercentage, \"QV_7324_97053\", \"maximumPercentage\"):kendo.toString(#=maximumPercentage#, vc.viewState.QV_7324_97053.column.maximumPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_97053.column.maximumPercentage.style",
                        "title": "{{vc.viewState.QV_7324_97053.column.maximumPercentage.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7324_97053.column.maximumPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_97053.columns.push({
                    field: 'totalValue',
                    title: '{{vc.viewState.QV_7324_97053.column.totalValue.title|translate:vc.viewState.QV_7324_97053.column.totalValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_97053.column.totalValue.width,
                    format: $scope.vc.viewState.QV_7324_97053.column.totalValue.format,
                    editor: $scope.vc.grids.QV_7324_97053.AT91_TOTALVAE795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_97053.column.totalValue.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.totalValue, \"QV_7324_97053\", \"totalValue\"):kendo.toString(#=totalValue#, vc.viewState.QV_7324_97053.column.totalValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_97053.column.totalValue.style",
                        "title": "{{vc.viewState.QV_7324_97053.column.totalValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7324_97053.column.totalValue.hidden
                });
            }
            $scope.vc.viewState.QV_7324_97053.toolbar = {}
            $scope.vc.grids.QV_7324_97053.toolbar = [];
            //ViewState - Group: Group1105
            $scope.vc.createViewState({
                id: "G_PAYMENTSSS_563141",
                hasId: true,
                componentStyle: [],
                label: 'Group1105',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.QuotationCurrency = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    currencyType: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuotationCurrency", "currencyType", 0)
                    },
                    date: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuotationCurrency", "date", new Date())
                    },
                    value: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuotationCurrency", "value", 0)
                    },
                    result: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuotationCurrency", "result", 0)
                    }
                }
            });
            $scope.vc.model.QuotationCurrency = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUOTATNU_1156();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.QuotationCurrency
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1156_30060").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUOTATNU_1156 = $scope.vc.model.QuotationCurrency;
            $scope.vc.trackers.QuotationCurrency = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QuotationCurrency);
            $scope.vc.model.QuotationCurrency.bind('change', function(e) {
                $scope.vc.trackers.QuotationCurrency.track(e);
            });
            $scope.vc.grids.QV_1156_30060 = {};
            $scope.vc.grids.QV_1156_30060.queryId = 'Q_QUOTATNU_1156';
            $scope.vc.viewState.QV_1156_30060 = {
                style: []
            };
            $scope.vc.viewState.QV_1156_30060.column = {};
            $scope.vc.grids.QV_1156_30060.editable = false;
            $scope.vc.grids.QV_1156_30060.events = {
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.QuotationCurrency.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1156_30060.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_1156_30060", false, grid);
                    $scope.vc.hideShowColumns("QV_1156_30060", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1156_30060.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1156_30060.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1156_30060.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1156_30060 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1156_30060 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1156_30060.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1156_30060.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1156_30060.column.currencyType = {
                title: 'currencyType',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZKD_152141',
                element: []
            };
            $scope.vc.grids.QV_1156_30060.AT62_CURRENCT860 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_30060.column.currencyType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZKD_152141",
                        'data-validation-code': "{{vc.viewState.QV_1156_30060.column.currencyType.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1156_30060.column.currencyType.format",
                        'k-decimals': "vc.viewState.QV_1156_30060.column.currencyType.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,4",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_30060.column.currencyType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_30060.column.date = {
                title: 'date',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDMQBLSD_801141',
                element: []
            };
            $scope.vc.grids.QV_1156_30060.AT30_DATERVCF860 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_30060.column.date.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDMQBLSD_801141",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_1156_30060.column.date.validationCode}}",
                        'ng-class': "vc.viewState.QV_1156_30060.column.date.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_30060.column.value = {
                title: 'value',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUVG_286141',
                element: []
            };
            $scope.vc.grids.QV_1156_30060.AT41_VALUEKRT860 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_30060.column.value.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUVG_286141",
                        'data-validation-code': "{{vc.viewState.QV_1156_30060.column.value.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1156_30060.column.value.format",
                        'k-decimals': "vc.viewState.QV_1156_30060.column.value.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,4",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_30060.column.value.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_30060.column.result = {
                title: 'result',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBHX_855141',
                element: []
            };
            $scope.vc.grids.QV_1156_30060.AT74_RESULTRD860 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_30060.column.result.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBHX_855141",
                        'data-validation-code': "{{vc.viewState.QV_1156_30060.column.result.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1156_30060.column.result.format",
                        'k-decimals': "vc.viewState.QV_1156_30060.column.result.decimals",
                        'data-cobis-group': "GroupLayout,G_PAYMENTSSS_299141,4",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_30060.column.result.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_30060.columns.push({
                    field: 'currencyType',
                    title: '{{vc.viewState.QV_1156_30060.column.currencyType.title|translate:vc.viewState.QV_1156_30060.column.currencyType.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_30060.column.currencyType.width,
                    format: $scope.vc.viewState.QV_1156_30060.column.currencyType.format,
                    editor: $scope.vc.grids.QV_1156_30060.AT62_CURRENCT860.control,
                    template: "<span ng-class='vc.viewState.QV_1156_30060.column.currencyType.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.currencyType, \"QV_1156_30060\", \"currencyType\"):kendo.toString(#=currencyType#, vc.viewState.QV_1156_30060.column.currencyType.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1156_30060.column.currencyType.style",
                        "title": "{{vc.viewState.QV_1156_30060.column.currencyType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_30060.column.currencyType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_30060.columns.push({
                    field: 'date',
                    title: '{{vc.viewState.QV_1156_30060.column.date.title|translate:vc.viewState.QV_1156_30060.column.date.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_30060.column.date.width,
                    format: $scope.vc.viewState.QV_1156_30060.column.date.format,
                    editor: $scope.vc.grids.QV_1156_30060.AT30_DATERVCF860.control,
                    template: "<span ng-class='vc.viewState.QV_1156_30060.column.date.element[dataItem.dsgnrId].style'>#=((date !== null) ? kendo.toString(date, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_30060.column.date.style",
                        "title": "{{vc.viewState.QV_1156_30060.column.date.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_30060.column.date.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_30060.columns.push({
                    field: 'value',
                    title: '{{vc.viewState.QV_1156_30060.column.value.title|translate:vc.viewState.QV_1156_30060.column.value.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_30060.column.value.width,
                    format: $scope.vc.viewState.QV_1156_30060.column.value.format,
                    editor: $scope.vc.grids.QV_1156_30060.AT41_VALUEKRT860.control,
                    template: "<span ng-class='vc.viewState.QV_1156_30060.column.value.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.value, \"QV_1156_30060\", \"value\"):kendo.toString(#=value#, vc.viewState.QV_1156_30060.column.value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1156_30060.column.value.style",
                        "title": "{{vc.viewState.QV_1156_30060.column.value.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_1156_30060.column.value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_30060.columns.push({
                    field: 'result',
                    title: '{{vc.viewState.QV_1156_30060.column.result.title|translate:vc.viewState.QV_1156_30060.column.result.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_30060.column.result.width,
                    format: $scope.vc.viewState.QV_1156_30060.column.result.format,
                    editor: $scope.vc.grids.QV_1156_30060.AT74_RESULTRD860.control,
                    template: "<span ng-class='vc.viewState.QV_1156_30060.column.result.element[dataItem.dsgnrId].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.result, \"QV_1156_30060\", \"result\"):kendo.toString(#=result#, vc.viewState.QV_1156_30060.column.result.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1156_30060.column.result.style",
                        "title": "{{vc.viewState.QV_1156_30060.column.result.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_30060.column.result.hidden
                });
            }
            $scope.vc.viewState.QV_1156_30060.toolbar = {}
            $scope.vc.grids.QV_1156_30060.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PAYMENTSMANII_157_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PAYMENTSMANII_157_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_PAYMENTS_SS1",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SOBRANTSE_66830",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_PAYMENTS_T3A",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GUARDARRI_81055",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_PAYMENTS_T7N",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NEGOCIANI_54038",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command4
            $scope.vc.createViewState({
                id: "CM_PAYMENTS_NNS",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRIORIDAA_58251",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command5
            $scope.vc.createViewState({
                id: "CM_TPAYMENT_MA5",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CONDONASE_22340",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command6
            $scope.vc.createViewState({
                id: "CM_TPAYMENT_Y_2",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GUARDARRI_81055",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Negotiation = {
                paymentType: $scope.vc.channelDefaultValues("Negotiation", "paymentType"),
                interestType: $scope.vc.channelDefaultValues("Negotiation", "interestType"),
                fullFee: $scope.vc.channelDefaultValues("Negotiation", "fullFee"),
                additionalPayments: $scope.vc.channelDefaultValues("Negotiation", "additionalPayments"),
                calculateReturn: $scope.vc.channelDefaultValues("Negotiation", "calculateReturn"),
                reductionType: $scope.vc.channelDefaultValues("Negotiation", "reductionType")
            };
            $scope.vc.model.PaymentMethod = {
                product: $scope.vc.channelDefaultValues("PaymentMethod", "product"),
                description: $scope.vc.channelDefaultValues("PaymentMethod", "description"),
                category: $scope.vc.channelDefaultValues("PaymentMethod", "category"),
                retention: $scope.vc.channelDefaultValues("PaymentMethod", "retention"),
                cobisProduct: $scope.vc.channelDefaultValues("PaymentMethod", "cobisProduct")
            };
            $scope.vc.model.LeftOverPayment = {
                currencyType: $scope.vc.channelDefaultValues("LeftOverPayment", "currencyType"),
                paymentType: $scope.vc.channelDefaultValues("LeftOverPayment", "paymentType"),
                reference: $scope.vc.channelDefaultValues("LeftOverPayment", "reference"),
                note: $scope.vc.channelDefaultValues("LeftOverPayment", "note"),
                numCheck: $scope.vc.channelDefaultValues("LeftOverPayment", "numCheck"),
                bank: $scope.vc.channelDefaultValues("LeftOverPayment", "bank"),
                value: $scope.vc.channelDefaultValues("LeftOverPayment", "value"),
                leftoverQuotationValue: $scope.vc.channelDefaultValues("LeftOverPayment", "leftoverQuotationValue")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXRMI_168141.read();
                }
            });
        }
        $scope.isInvalid = function(form, field) {
            if (!field) {
                return false;
            }
            var submitted = $scope.vc.submitted[form.$name];
            return ((submitted || field.$dirty) && field.$invalid);
        };
        $scope._initPage_CRUDExecuteQueryEntities = function(page) {
            if (!designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                if (page.hasTemporaryDataSupport && page.ejecTemporaryData && !page.hasTemporaryData) {
                    return $scope.vc.CRUDExecuteQueryEntities(page);
                } else if (page.hasCRUDSupport) {
                    return $scope.vc.CRUDExecuteQueryEntities(page);
                } else {
                    return page;
                }
            } else {
                return page;
            }
        };
        $scope._initPage_InitializeTrackers = function(page) {
            $scope.vc.addChangeEvents($scope);
            $scope.vc.crud.addTrackers($scope.vc.model);
            return page;
        };
        $scope._initPage_ChangeInitData = function(page) {
            return $scope.vc.changeInitData(page, $scope.vc);
        };
        $scope._initPage_ProcessRender = function(page) {
            if (page.hasSearchRenderEvent) {
                $scope.vc.render('VC_PAYMENTSAN_916157');
            }
            return page;
        };
        if ($scope.vc.isModal($scope) || $scope.vc.isDetailGrid($scope) || $scope.isDesignerInclude) {
            //para ventanas modales se usa ng-include con onload
            $scope.runLifeCycle = function() {
                var threadLifeCycle = $scope.vc.lifeCycle.prepareThread(page);
                if (threadLifeCycle) {
                    if (!$scope.isDesignerInclude) {
                        cobis.showMessageWindow.loading(true, "none");
                    }
                    $scope.vc.lifeCycle.run(page, threadLifeCycle, $scope);
                    cobis.showMessageWindow.loading(false);
                }
            };
        } else {
            //con ngView no funciona el $document.ready se cambia por $viewContentLoaded
            $scope.$on('$viewContentLoaded', function() {
                if ($scope.vc.loaded) {
                    //Si se esta regresando de otra pantalla
                    $scope.vc.addChangeEvents($scope);
                    if (($scope.vc.hasOnCloseModalEvent && angular.isDefined($scope.vc.dialogParameters.autoSync) && $scope.vc.dialogParameters.autoSync === false) && ($scope.vc.dialogResponse || $scope.vc.customDialogResponse)) {
                        $scope.vc.onCloseModalEvent();
                    }
                    if ($scope.vc.dialogResponse || $scope.vc.customDialogResponse) {
                        $scope.vc.afterCloseGridDialog();
                    }
                    cobis.showMessageWindow.loading(false);
                } else {
                    //Si es la primera vez que se ejecuta la pantalla
                    var threadLifeCycle = $scope.vc.lifeCycle.prepareThread(page);
                    if (threadLifeCycle) {
                        $scope.vc.lifeCycle.run(page, threadLifeCycle, $scope);
                        cobis.showMessageWindow.loading(false);
                    }
                }
            });
        }
    }]);
}
if (typeof cobisMainModule === "undefined") {
    var cobisMainModule = cobis.createModule("VC_PAYMENTSAN_916157", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
    cobisMainModule.config(["$controllerProvider", "$compileProvider", "$filterProvider", "$locationProvider", "$routeProvider", "$provide", "$translateProvider", "$translatePartialLoaderProvider", "$ocLazyLoadProvider",

    function($controllerProvider, $compileProvider, $filterProvider, $locationProvider, $routeProvider, $provide, $translateProvider, $translatePartialLoaderProvider, $ocLazyLoadProvider) {
        $ocLazyLoadProvider.config({
            asyncLoader: $script
        });
        $locationProvider.html5Mode(true);
        cobisMainModule.controllerProvider = $controllerProvider;
        cobisMainModule.compileProvider = $compileProvider;
        cobisMainModule.routeProvider = $routeProvider;
        cobisMainModule.filterProvider = $filterProvider;
        cobisMainModule.provide = $provide;
        var culture = cobis.userContext.getValue(cobis.constant.CULTURE);
        $routeProvider.when("/VC_PAYMENTSAN_916157", {
            templateUrl: "VC_PAYMENTSAN_916157_FORM.html",
            controller: "VC_PAYMENTSAN_916157_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PAYMENTSAN_916157?" + $.param(search);
            }
        });
        VC_PAYMENTSAN_916157(cobisMainModule);
    }]);
} else {
    VC_PAYMENTSAN_916157(cobisMainModule);
}