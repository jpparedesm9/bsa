//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.applyclause = designerEvents.api.applyclause || designer.dsgEvents();

function VC_APPLYCLASS_521533(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_APPLYCLASS_521533_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_APPLYCLASS_521533_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_APPLYCLAUSEEE_533",
            taskVersion: "1.0.0",
            viewContainerId: "VC_APPLYCLASS_521533",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_APPLYCLAUSEEE_533",
        designerEvents.api.applyclause,
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
                vcName: 'VC_APPLYCLASS_521533'
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
                    taskId: 'T_APPLYCLAUSEEE_533',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    Amortization: "Amortization",
                    ItemsLoan: "ItemsLoan",
                    LoanInstancia: "LoanInstancia"
                },
                entities: {
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
                    Amortization: {
                        items12: 'AT10_ITEMS122592',
                        items6: 'AT11_ITEMS6DA592',
                        items2: 'AT13_ITEMS2OT592',
                        items8: 'AT13_ITEMS8ZO592',
                        items10: 'AT15_ITEMS100592',
                        items9: 'AT17_ITEMS9BT592',
                        shareValue: 'AT18_SHAREVEL592',
                        days: 'AT25_DAYSFBZN592',
                        expiration: 'AT33_EXPIRANO592',
                        items3: 'AT35_ITEMS3HC592',
                        items5: 'AT37_ITEMS5ZX592',
                        items4: 'AT51_ITEMS4SF592',
                        items7: 'AT54_ITEMS7OM592',
                        state: 'AT63_STATEQEV592',
                        porroga: 'AT65_PORROGAA592',
                        share: 'AT71_SHAREPCW592',
                        items13: 'AT72_ITEMS133592',
                        items14: 'AT74_ITEMS144592',
                        balanceCap: 'AT83_BALANCCA592',
                        items11: 'AT84_ITEMS111592',
                        items15: 'AT89_ITEMS155592',
                        items1: 'AT97_ITEMS1UJ592',
                        _pks: [],
                        _entityId: 'EN_2ZNYDYMCX_592',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ItemsLoan: {
                        concept: 'AT71_CONCEPTT118',
                        description: 'AT36_DESCRITO118',
                        itemType: 'AT64_ITEMTYEE118',
                        paymentMethod: 'AT22_PAYMENMD118',
                        value: 'AT14_VALUEIYS118',
                        priority: 'AT15_PRIORITT118',
                        latePayment: 'AT45_LATEPAYE118',
                        cause: 'AT75_CAUSEPOS118',
                        reference: 'AT23_REFERENN118',
                        sign: 'AT51_SIGNTBXM118',
                        pointsValue: 'AT15_POINTSLV118',
                        pointsType: 'AT18_POINTSET118',
                        valueTotalRate: 'AT63_VALUETAL118',
                        negotiatedRate: 'AT53_NEGOTITT118',
                        annualEfecRate: 'AT39_ANNUALTR118',
                        reajustmenSign: 'AT55_REAJUSSN118',
                        reajustmentValuePoints: 'AT21_REAJUSSL118',
                        reajustmentReference: 'AT15_REAJUSTE118',
                        gain: 'AT83_GAINNRTF118',
                        baseCalculation: 'AT53_BASECATL118',
                        chargeForRinging: 'AT41_CHARGERG118',
                        warrantyType: 'AT53_WARRANTT118',
                        warrantyNumber: 'AT47_WARRANBM118',
                        coveragePercentage: 'AT25_COVERANP118',
                        warrantyValue: 'AT39_WARRANAY118',
                        dividendType: 'AT28_DIVIDEDE118',
                        interestPeriod: 'AT10_INTERETR118',
                        tableOtherRate: 'AT93_TABLEOET118',
                        _pks: [],
                        _entityId: 'EN_ITEMSLONA_118',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanInstancia: {
                        idInstancia: 'AT74_IDINSTAA482',
                        idOptionMenu: 'AT59_IDOPTINM482',
                        errorValidation: 'AT62_ERRORVAA482',
                        _pks: [],
                        _entityId: 'EN_LOANINSTC_482',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_AMORTIAN_8237 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_AMORTIAN_8237 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AMORTIAN_8237_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_AMORTIAN_8237_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_2ZNYDYMCX_592',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AMORTIAN_8237',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_AMORTIAN_8237_filters = {};
            var defaultValues = {
                Loan: {},
                Amortization: {},
                ItemsLoan: {},
                LoanInstancia: {}
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
                $scope.vc.execute("temporarySave", VC_APPLYCLASS_521533, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_APPLYCLASS_521533, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_APPLYCLASS_521533, data, function() {});
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
            $scope.vc.viewState.VC_APPLYCLASS_521533 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_APPLYCLASS_521533",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLAUSULRI_36820",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_ZFLEAUPGRQ_436533",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_ZSSKHOVMQJ_164316",
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
                id: "VC_TQAJSELMWD_823533",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: AmortizationForm
            $scope.vc.createViewState({
                id: "VC_XNNJUDEHJS_791261",
                hasId: true,
                componentStyle: [],
                label: 'AmortizationForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group2591
            $scope.vc.createViewState({
                id: "G_AMORTIZTAI_460871",
                hasId: true,
                componentStyle: [],
                label: 'Group2591',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Amortization = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    share: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "share", 0)
                    },
                    expiration: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "expiration", new Date())
                    },
                    days: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "days", 0)
                    },
                    balanceCap: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "balanceCap", 0)
                    },
                    items1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items1", 0)
                    },
                    items2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items2", 0)
                    },
                    items3: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items3", 0)
                    },
                    items4: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items4", 0)
                    },
                    items5: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items5", 0)
                    },
                    items6: {
                        type: "number",
                        editable: true
                    },
                    items7: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items7", 0)
                    },
                    items8: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items8", 0)
                    },
                    items9: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items9", 0)
                    },
                    items10: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items10", 0)
                    },
                    items11: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items11", 0)
                    },
                    items12: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items12", 0)
                    },
                    items13: {
                        type: "number",
                        editable: true
                    },
                    items14: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items14", 0)
                    },
                    items15: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items15", 0)
                    },
                    shareValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "shareValue", 0)
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "state", '')
                    },
                    porroga: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "porroga", '')
                    }
                }
            });
            $scope.vc.model.Amortization = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_AMORTIAN_8237();
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
                    model: $scope.vc.types.Amortization
                },
                aggregate: [{
                    field: "items1",
                    aggregate: "sum"
                }, {
                    field: "items2",
                    aggregate: "sum"
                }, {
                    field: "items3",
                    aggregate: "sum"
                }, {
                    field: "items4",
                    aggregate: "sum"
                }, {
                    field: "items5",
                    aggregate: "sum"
                }, {
                    field: "items7",
                    aggregate: "sum"
                }, {
                    field: "items8",
                    aggregate: "sum"
                }, {
                    field: "items9",
                    aggregate: "sum"
                }, {
                    field: "items10",
                    aggregate: "sum"
                }, {
                    field: "items11",
                    aggregate: "sum"
                }, {
                    field: "items12",
                    aggregate: "sum"
                }, {
                    field: "items14",
                    aggregate: "sum"
                }, {
                    field: "items15",
                    aggregate: "sum"
                }, {
                    field: "shareValue",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8237_80795").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AMORTIAN_8237 = $scope.vc.model.Amortization;
            $scope.vc.trackers.Amortization = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Amortization);
            $scope.vc.model.Amortization.bind('change', function(e) {
                $scope.vc.trackers.Amortization.track(e);
            });
            $scope.vc.grids.QV_8237_80795 = {};
            $scope.vc.grids.QV_8237_80795.queryId = 'Q_AMORTIAN_8237';
            $scope.vc.viewState.QV_8237_80795 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8237_80795.column = {};
            $scope.vc.grids.QV_8237_80795.editable = false;
            $scope.vc.grids.QV_8237_80795.events = {
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
                    $scope.vc.trackers.Amortization.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_8237_80795.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_8237_80795");
                    $scope.vc.hideShowColumns("QV_8237_80795", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8237_80795.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8237_80795.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8237_80795.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8237_80795 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8237_80795 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_8237_80795.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_8237_80795.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_8237_80795.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Amortization",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_8237_80795", args);
                        }
                        if (!$scope.$root) {
                            if (e.sender.$angular_scope.$$phase !== '$apply' && e.sender.$angular_scope.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        } else {
                            if ($scope.$root.$$phase !== '$apply' && $scope.$root.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8237_80795.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8237_80795.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8237_80795.column.share = {
                title: 'ASSTS.LBL_ASSTS_CUOTASNJN_88896',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCGV_473871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT71_SHAREPCW592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.share.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCGV_473871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.share.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.share.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.share.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.share.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.expiration = {
                title: 'ASSTS.LBL_ASSTS_FECHAVENE_58948',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDFOXURB_182871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT33_EXPIRANO592 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.expiration.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDFOXURB_182871",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.expiration.validationCode}}",
                        'ng-class': "vc.viewState.QV_8237_80795.column.expiration.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.days = {
                title: 'ASSTS.LBL_ASSTS_DASBHLJCD_37784',
                titleArgs: {},
                tooltip: '',
                width: 50,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIPF_316871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT25_DAYSFBZN592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.days.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIPF_316871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.days.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.days.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.days.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.days.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.balanceCap = {
                title: 'ASSTS.LBL_ASSTS_SALDOCAAI_86331',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGNF_245871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT83_BALANCCA592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.balanceCap.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGNF_245871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.balanceCap.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.balanceCap.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.balanceCap.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.balanceCap.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items1 = {
                title: 'items1',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAHH_793871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT97_ITEMS1UJ592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items1.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAHH_793871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items1.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items1.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items1.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items2 = {
                title: 'items2',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSCO_259871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT13_ITEMS2OT592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items2.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSCO_259871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items2.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items2.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items2.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items3 = {
                title: 'items3',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHJE_714871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT35_ITEMS3HC592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items3.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHJE_714871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items3.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items3.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items3.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items3.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items4 = {
                title: 'items4',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGNU_184871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT51_ITEMS4SF592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items4.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGNU_184871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items4.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items4.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items4.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items4.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items5 = {
                title: 'items5',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXORN_815871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT37_ITEMS5ZX592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items5.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXORN_815871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items5.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items5.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items5.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items5.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items6 = {
                title: 'items6',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT11_ITEMS6DA592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items6.enabled",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items6.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items7 = {
                title: 'items7',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNNA_760871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT54_ITEMS7OM592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items7.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNNA_760871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items7.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items7.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items7.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items7.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items8 = {
                title: 'items8',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVNJ_518871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT13_ITEMS8ZO592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items8.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVNJ_518871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items8.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items8.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items8.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items8.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items9 = {
                title: 'items9',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWNG_395871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT17_ITEMS9BT592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items9.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWNG_395871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items9.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items9.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items9.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items9.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items10 = {
                title: 'items10',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLHX_722871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT15_ITEMS100592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items10.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLHX_722871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items10.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items10.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items10.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items10.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items11 = {
                title: 'items11',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYRS_353871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT84_ITEMS111592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items11.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYRS_353871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items11.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items11.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items11.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items11.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items12 = {
                title: 'items12',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJUK_798871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT10_ITEMS122592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items12.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJUK_798871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items12.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items12.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items12.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items12.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items13 = {
                title: 'items13',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT72_ITEMS133592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items13.enabled",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items13.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items14 = {
                title: 'items14',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLLZ_404871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT74_ITEMS144592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items14.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLLZ_404871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items14.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items14.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items14.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items14.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items15 = {
                title: 'items15',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUHU_691871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT89_ITEMS155592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items15.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUHU_691871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items15.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items15.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items15.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items15.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.shareValue = {
                title: 'ASSTS.LBL_ASSTS_VALORCUTO_78445',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKTI_114871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT18_SHAREVEL592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.shareValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKTI_114871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.shareValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.shareValue.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.shareValue.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.shareValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.state = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLBZ_172871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT63_STATEQEV592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.state.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLBZ_172871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.state.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.state.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.porroga = {
                title: 'ASSTS.LBL_ASSTS_PRRROGAER_90410',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJUQ_295871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT65_PORROGAA592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.porroga.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJUQ_295871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.porroga.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.porroga.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'share',
                    title: '{{vc.viewState.QV_8237_80795.column.share.title|translate:vc.viewState.QV_8237_80795.column.share.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.share.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.share.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT71_SHAREPCW592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.share.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.share, \"QV_8237_80795\", \"share\"):kendo.toString(#=share#, vc.viewState.QV_8237_80795.column.share.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.share.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.share.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.share.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'expiration',
                    title: '{{vc.viewState.QV_8237_80795.column.expiration.title|translate:vc.viewState.QV_8237_80795.column.expiration.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.expiration.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.expiration.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT33_EXPIRANO592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.expiration.style'>#=((expiration !== null) ? kendo.toString(expiration, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8237_80795.column.expiration.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.expiration.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.expiration.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'days',
                    title: '{{vc.viewState.QV_8237_80795.column.days.title|translate:vc.viewState.QV_8237_80795.column.days.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.days.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.days.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT25_DAYSFBZN592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.days.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.days, \"QV_8237_80795\", \"days\"):kendo.toString(#=days#, vc.viewState.QV_8237_80795.column.days.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.days.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.days.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.days.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'balanceCap',
                    title: '{{vc.viewState.QV_8237_80795.column.balanceCap.title|translate:vc.viewState.QV_8237_80795.column.balanceCap.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.balanceCap.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.balanceCap.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT83_BALANCCA592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.balanceCap.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.balanceCap, \"QV_8237_80795\", \"balanceCap\"):kendo.toString(#=balanceCap#, vc.viewState.QV_8237_80795.column.balanceCap.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.balanceCap.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.balanceCap.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.balanceCap.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items1',
                    title: '{{vc.viewState.QV_8237_80795.column.items1.title|translate:vc.viewState.QV_8237_80795.column.items1.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items1.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items1.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT97_ITEMS1UJ592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items1.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items1, \"QV_8237_80795\", \"items1\"):kendo.toString(#=items1#, vc.viewState.QV_8237_80795.column.items1.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items1.sum, $scope.vc.viewState.QV_8237_80795.column.items1.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items1.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items2',
                    title: '{{vc.viewState.QV_8237_80795.column.items2.title|translate:vc.viewState.QV_8237_80795.column.items2.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items2.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items2.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT13_ITEMS2OT592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items2.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items2, \"QV_8237_80795\", \"items2\"):kendo.toString(#=items2#, vc.viewState.QV_8237_80795.column.items2.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items2.sum, $scope.vc.viewState.QV_8237_80795.column.items2.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items2.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items3',
                    title: '{{vc.viewState.QV_8237_80795.column.items3.title|translate:vc.viewState.QV_8237_80795.column.items3.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items3.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items3.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT35_ITEMS3HC592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items3.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items3, \"QV_8237_80795\", \"items3\"):kendo.toString(#=items3#, vc.viewState.QV_8237_80795.column.items3.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items3.sum, $scope.vc.viewState.QV_8237_80795.column.items3.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items3.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items3.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items3.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items4',
                    title: '{{vc.viewState.QV_8237_80795.column.items4.title|translate:vc.viewState.QV_8237_80795.column.items4.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items4.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items4.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT51_ITEMS4SF592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items4.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items4, \"QV_8237_80795\", \"items4\"):kendo.toString(#=items4#, vc.viewState.QV_8237_80795.column.items4.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items4.sum, $scope.vc.viewState.QV_8237_80795.column.items4.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items4.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items4.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items4.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items5',
                    title: '{{vc.viewState.QV_8237_80795.column.items5.title|translate:vc.viewState.QV_8237_80795.column.items5.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items5.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items5.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT37_ITEMS5ZX592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items5.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items5, \"QV_8237_80795\", \"items5\"):kendo.toString(#=items5#, vc.viewState.QV_8237_80795.column.items5.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items5.sum, $scope.vc.viewState.QV_8237_80795.column.items5.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items5.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items5.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items5.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items6',
                    title: '{{vc.viewState.QV_8237_80795.column.items6.title|translate:vc.viewState.QV_8237_80795.column.items6.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items6.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items6.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT11_ITEMS6DA592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items6.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items6, \"QV_8237_80795\", \"items6\"):kendo.toString(#=items6#, vc.viewState.QV_8237_80795.column.items6.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items6.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items6.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items6.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items7',
                    title: '{{vc.viewState.QV_8237_80795.column.items7.title|translate:vc.viewState.QV_8237_80795.column.items7.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items7.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items7.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT54_ITEMS7OM592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items7.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items7, \"QV_8237_80795\", \"items7\"):kendo.toString(#=items7#, vc.viewState.QV_8237_80795.column.items7.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items7.sum, $scope.vc.viewState.QV_8237_80795.column.items7.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items7.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items7.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items7.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items8',
                    title: '{{vc.viewState.QV_8237_80795.column.items8.title|translate:vc.viewState.QV_8237_80795.column.items8.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items8.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items8.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT13_ITEMS8ZO592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items8.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items8, \"QV_8237_80795\", \"items8\"):kendo.toString(#=items8#, vc.viewState.QV_8237_80795.column.items8.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items8.sum, $scope.vc.viewState.QV_8237_80795.column.items8.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items8.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items8.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items8.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items9',
                    title: '{{vc.viewState.QV_8237_80795.column.items9.title|translate:vc.viewState.QV_8237_80795.column.items9.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items9.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items9.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT17_ITEMS9BT592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items9.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items9, \"QV_8237_80795\", \"items9\"):kendo.toString(#=items9#, vc.viewState.QV_8237_80795.column.items9.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items9.sum, $scope.vc.viewState.QV_8237_80795.column.items9.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items9.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items9.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items9.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items10',
                    title: '{{vc.viewState.QV_8237_80795.column.items10.title|translate:vc.viewState.QV_8237_80795.column.items10.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items10.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items10.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT15_ITEMS100592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items10.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items10, \"QV_8237_80795\", \"items10\"):kendo.toString(#=items10#, vc.viewState.QV_8237_80795.column.items10.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items10.sum, $scope.vc.viewState.QV_8237_80795.column.items10.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items10.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items10.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items10.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items11',
                    title: '{{vc.viewState.QV_8237_80795.column.items11.title|translate:vc.viewState.QV_8237_80795.column.items11.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items11.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items11.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT84_ITEMS111592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items11.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items11, \"QV_8237_80795\", \"items11\"):kendo.toString(#=items11#, vc.viewState.QV_8237_80795.column.items11.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items11.sum, $scope.vc.viewState.QV_8237_80795.column.items11.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items11.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items11.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items11.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items12',
                    title: '{{vc.viewState.QV_8237_80795.column.items12.title|translate:vc.viewState.QV_8237_80795.column.items12.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items12.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items12.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT10_ITEMS122592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items12.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items12, \"QV_8237_80795\", \"items12\"):kendo.toString(#=items12#, vc.viewState.QV_8237_80795.column.items12.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items12.sum, $scope.vc.viewState.QV_8237_80795.column.items12.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items12.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items12.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items12.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items13',
                    title: '{{vc.viewState.QV_8237_80795.column.items13.title|translate:vc.viewState.QV_8237_80795.column.items13.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items13.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items13.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT72_ITEMS133592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items13.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items13, \"QV_8237_80795\", \"items13\"):kendo.toString(#=items13#, vc.viewState.QV_8237_80795.column.items13.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items13.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items13.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items13.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items14',
                    title: '{{vc.viewState.QV_8237_80795.column.items14.title|translate:vc.viewState.QV_8237_80795.column.items14.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items14.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items14.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT74_ITEMS144592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items14.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items14, \"QV_8237_80795\", \"items14\"):kendo.toString(#=items14#, vc.viewState.QV_8237_80795.column.items14.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items14.sum, $scope.vc.viewState.QV_8237_80795.column.items14.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items14.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items14.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items14.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items15',
                    title: '{{vc.viewState.QV_8237_80795.column.items15.title|translate:vc.viewState.QV_8237_80795.column.items15.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items15.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items15.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT89_ITEMS155592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items15.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items15, \"QV_8237_80795\", \"items15\"):kendo.toString(#=items15#, vc.viewState.QV_8237_80795.column.items15.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items15.sum, $scope.vc.viewState.QV_8237_80795.column.items15.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items15.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items15.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items15.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'shareValue',
                    title: '{{vc.viewState.QV_8237_80795.column.shareValue.title|translate:vc.viewState.QV_8237_80795.column.shareValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.shareValue.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.shareValue.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT18_SHAREVEL592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.shareValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.shareValue, \"QV_8237_80795\", \"shareValue\"):kendo.toString(#=shareValue#, vc.viewState.QV_8237_80795.column.shareValue.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.shareValue.sum, $scope.vc.viewState.QV_8237_80795.column.shareValue.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.shareValue.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.shareValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.shareValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_8237_80795.column.state.title|translate:vc.viewState.QV_8237_80795.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.state.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.state.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT63_STATEQEV592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_8237_80795\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8237_80795.column.state.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'porroga',
                    title: '{{vc.viewState.QV_8237_80795.column.porroga.title|translate:vc.viewState.QV_8237_80795.column.porroga.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.porroga.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.porroga.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT65_PORROGAA592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.porroga.style' ng-bind='vc.getStringColumnFormat(dataItem.porroga, \"QV_8237_80795\", \"porroga\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8237_80795.column.porroga.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.porroga.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.porroga.hidden
                });
            }
            $scope.vc.viewState.QV_8237_80795.toolbar = {}
            $scope.vc.grids.QV_8237_80795.toolbar = [];
            $scope.vc.model.ItemsLoan = {
                concept: $scope.vc.channelDefaultValues("ItemsLoan", "concept"),
                description: $scope.vc.channelDefaultValues("ItemsLoan", "description"),
                itemType: $scope.vc.channelDefaultValues("ItemsLoan", "itemType"),
                paymentMethod: $scope.vc.channelDefaultValues("ItemsLoan", "paymentMethod"),
                value: $scope.vc.channelDefaultValues("ItemsLoan", "value"),
                priority: $scope.vc.channelDefaultValues("ItemsLoan", "priority"),
                latePayment: $scope.vc.channelDefaultValues("ItemsLoan", "latePayment"),
                cause: $scope.vc.channelDefaultValues("ItemsLoan", "cause"),
                reference: $scope.vc.channelDefaultValues("ItemsLoan", "reference"),
                sign: $scope.vc.channelDefaultValues("ItemsLoan", "sign"),
                pointsValue: $scope.vc.channelDefaultValues("ItemsLoan", "pointsValue"),
                pointsType: $scope.vc.channelDefaultValues("ItemsLoan", "pointsType"),
                valueTotalRate: $scope.vc.channelDefaultValues("ItemsLoan", "valueTotalRate"),
                negotiatedRate: $scope.vc.channelDefaultValues("ItemsLoan", "negotiatedRate"),
                annualEfecRate: $scope.vc.channelDefaultValues("ItemsLoan", "annualEfecRate"),
                reajustmenSign: $scope.vc.channelDefaultValues("ItemsLoan", "reajustmenSign"),
                reajustmentValuePoints: $scope.vc.channelDefaultValues("ItemsLoan", "reajustmentValuePoints"),
                reajustmentReference: $scope.vc.channelDefaultValues("ItemsLoan", "reajustmentReference"),
                gain: $scope.vc.channelDefaultValues("ItemsLoan", "gain"),
                baseCalculation: $scope.vc.channelDefaultValues("ItemsLoan", "baseCalculation"),
                chargeForRinging: $scope.vc.channelDefaultValues("ItemsLoan", "chargeForRinging"),
                warrantyType: $scope.vc.channelDefaultValues("ItemsLoan", "warrantyType"),
                warrantyNumber: $scope.vc.channelDefaultValues("ItemsLoan", "warrantyNumber"),
                coveragePercentage: $scope.vc.channelDefaultValues("ItemsLoan", "coveragePercentage"),
                warrantyValue: $scope.vc.channelDefaultValues("ItemsLoan", "warrantyValue"),
                dividendType: $scope.vc.channelDefaultValues("ItemsLoan", "dividendType"),
                interestPeriod: $scope.vc.channelDefaultValues("ItemsLoan", "interestPeriod"),
                tableOtherRate: $scope.vc.channelDefaultValues("ItemsLoan", "tableOtherRate")
            };
            //ViewState - Group: Group1611
            $scope.vc.createViewState({
                id: "G_AMORTIZANI_193871",
                hasId: true,
                componentStyle: [],
                label: 'Group1611',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer1382",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
            };
            //ViewState - Group: Group1963
            $scope.vc.createViewState({
                id: "G_AMORTIZTAT_967871",
                hasId: true,
                componentStyle: [],
                label: 'Group1963',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1460",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_APPLYCLAUSEEE_533_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_APPLYCLAUSEEE_533_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_APPLYCLA_C1S",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APLICARIP_57468",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
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
                $scope.vc.render('VC_APPLYCLASS_521533');
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
    var cobisMainModule = cobis.createModule("VC_APPLYCLASS_521533", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_APPLYCLASS_521533", {
            templateUrl: "VC_APPLYCLASS_521533_FORM.html",
            controller: "VC_APPLYCLASS_521533_CTRL",
            labelId: "ASSTS.LBL_ASSTS_CLAUSULRI_36820",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_APPLYCLASS_521533?" + $.param(search);
            }
        });
        VC_APPLYCLASS_521533(cobisMainModule);
    }]);
} else {
    VC_APPLYCLASS_521533(cobisMainModule);
}