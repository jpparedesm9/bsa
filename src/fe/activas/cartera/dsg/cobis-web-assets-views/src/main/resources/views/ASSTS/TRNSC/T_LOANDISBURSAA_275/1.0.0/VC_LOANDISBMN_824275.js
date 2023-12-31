//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.loandisbursementmain = designerEvents.api.loandisbursementmain || designer.dsgEvents();

function VC_LOANDISBMN_824275(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LOANDISBMN_824275_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LOANDISBMN_824275_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LOANDISBURSAA_275",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LOANDISBMN_824275",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_LOANDISBURSAA_275",
        designerEvents.api.loandisbursementmain,
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
                vcName: 'VC_LOANDISBMN_824275'
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
                    taskId: 'T_LOANDISBURSAA_275',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    LoanAdditionalInformation: "LoanAdditionalInformation",
                    Entity14: "Entity14",
                    Entity15: "Entity15",
                    DetailAmountsToCancel: "DetailAmountsToCancel",
                    DetailPaymentForm: "DetailPaymentForm",
                    LiquidateResult: "LiquidateResult",
                    DisbursementResult: "DisbursementResult",
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
                    LoanAdditionalInformation: {
                        dateToDisburse: 'AT16_LOANDAEE167',
                        amountToCancel: 'AT10_AMOUNTCT167',
                        amountOperation: 'AT81_AMOUNTAO167',
                        quotation: 'AT23_QUOTATOI167',
                        lblAmountToCancel: 'AT65_LBLAMOTA167',
                        renovation: 'AT99_RENOVANI167',
                        _pks: [],
                        _entityId: 'EN_LOANADDOI_167',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Entity14: {
                        _pks: [],
                        _entityId: 'EN_14IGGBHIR_425',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Entity15: {
                        _pks: [],
                        _entityId: 'EN_15DDLEMQE_537',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DetailAmountsToCancel: {
                        description: 'AT24_DESCRIOT439',
                        item: 'AT85_ITEMBYHT439',
                        value: 'AT44_VALUELCR439',
                        _pks: [],
                        _entityId: 'EN_DETAILANC_439',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DetailPaymentForm: {
                        disbursementId: 'AT57_INDEXKGR835',
                        disbursementrate: 'AT56_DISBURNT835',
                        currencyId: 'AT99_CURRENID835',
                        currencyDescription: 'AT21_CURRENNE835',
                        amount: 'AT72_AMOUNTEH835',
                        typeQuotation: 'AT79_TYPEQUNA835',
                        quote: 'AT86_QUOTEGAO835',
                        amountOp: 'AT50_AMOUNTOP835',
                        quoteTypeOp: 'AT89_QUOTETYE835',
                        quoteOp: 'AT71_QUOTEOPP835',
                        amountMn: 'AT72_AMOUNTMM835',
                        account: 'AT72_ACCOUNTT835',
                        beneficiary: 'AT51_BENEFICC835',
                        officeId: 'AT28_OFFICEID835',
                        officeName: 'AT98_OFFICEAM835',
                        sequential: 'AT28_SEQUENTT835',
                        productCategory: 'AT92_PRODUCER835',
                        preNotification: 'AT23_PRENOTFI835',
                        observations: 'AT29_OBSERVAN835',
                        _pks: [],
                        _entityId: 'EN_DETAILPNN_835',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LiquidateResult: {
                        sumTotal: 'AT76_SUMTOTLL728',
                        _pks: [],
                        _entityId: 'EN_LIQUIDATT_728',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DisbursementResult: {
                        sumTotal: 'AT77_SUMTOTLA282',
                        difference: 'AT11_DIFFERNC282',
                        _pks: [],
                        _entityId: 'EN_DISBURSTE_282',
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
            $scope.vc.queryProperties.Q_DETAILTM_1603 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_DETAILTM_1603 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DETAILTM_1603_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DETAILTM_1603_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DETAILANC_439',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DETAILTM_1603',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_DETAILTM_1603_filters = {};
            $scope.vc.queryProperties.Q_DETAILAP_5973 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DETAILAP_5973 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DETAILAP_5973_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DETAILAP_5973_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DETAILPNN_835',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DETAILAP_5973',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_DETAILAP_5973_filters = {};
            var defaultValues = {
                Loan: {},
                LoanAdditionalInformation: {},
                Entity14: {},
                Entity15: {},
                DetailAmountsToCancel: {},
                DetailPaymentForm: {},
                LiquidateResult: {},
                DisbursementResult: {},
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
                $scope.vc.execute("temporarySave", VC_LOANDISBMN_824275, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LOANDISBMN_824275, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LOANDISBMN_824275, data, function() {});
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
            $scope.vc.viewState.VC_LOANDISBMN_824275 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_LOANDISBMN_824275",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_VBHENKGGPP_117275",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_WTBFTWKEGX_182316",
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
                id: "VC_GBKYDENEAL_496275",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Disbursement
            $scope.vc.createViewState({
                id: "VC_OCCPJFLCAB_318810",
                hasId: true,
                componentStyle: [],
                label: 'Disbursement',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2529
            $scope.vc.createViewState({
                id: "G_DISBURSENT_411405",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2529',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanAdditionalInformation = {
                dateToDisburse: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "dateToDisburse"),
                amountToCancel: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "amountToCancel"),
                amountOperation: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "amountOperation"),
                quotation: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "quotation"),
                lblAmountToCancel: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "lblAmountToCancel"),
                renovation: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "renovation")
            };
            //ViewState - Group: Group1809
            $scope.vc.createViewState({
                id: "G_DISBURSEET_626405",
                hasId: true,
                componentStyle: [],
                label: 'Group1809',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanAdditionalInformation, Attribute: dateToDisburse
            $scope.vc.createViewState({
                id: "Spacer2433",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHADEOO_31153",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanAdditionalInformation, Attribute: lblAmountToCancel
            $scope.vc.createViewState({
                id: "VA_9687YKSEJAICISC_489405",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_COTIZACEM_75026",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Group: GroupLayout1518
            $scope.vc.createViewState({
                id: "G_DISBURSTTM_328405",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1518',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Entity14 = {};
            //ViewState - Group: Group2912
            $scope.vc.createViewState({
                id: "G_DISBURSNEE_432405",
                hasId: true,
                componentStyle: [],
                label: 'Group2912',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_562405",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DETALLEAR_35261",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Entity15 = {};
            //ViewState - Group: Group2974
            $scope.vc.createViewState({
                id: "G_DISBURSTTT_570405",
                hasId: true,
                componentStyle: [],
                label: 'Group2974',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_897405",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DETALLEES_47444",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2505
            $scope.vc.createViewState({
                id: "G_DISBURSETE_715405",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DETALLEAR_35261",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2120
            $scope.vc.createViewState({
                id: "G_DISBURSEET_695405",
                hasId: true,
                componentStyle: [],
                label: 'Group2120',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DetailAmountsToCancel = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("DetailAmountsToCancel", "description", '')
                    },
                    value: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailAmountsToCancel", "value", 0)
                    }
                }
            });
            $scope.vc.model.DetailAmountsToCancel = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_DETAILTM_1603();
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
                    model: $scope.vc.types.DetailAmountsToCancel
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1603_21320").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DETAILTM_1603 = $scope.vc.model.DetailAmountsToCancel;
            $scope.vc.trackers.DetailAmountsToCancel = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DetailAmountsToCancel);
            $scope.vc.model.DetailAmountsToCancel.bind('change', function(e) {
                $scope.vc.trackers.DetailAmountsToCancel.track(e);
            });
            $scope.vc.grids.QV_1603_21320 = {};
            $scope.vc.grids.QV_1603_21320.queryId = 'Q_DETAILTM_1603';
            $scope.vc.viewState.QV_1603_21320 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1603_21320.column = {};
            $scope.vc.grids.QV_1603_21320.editable = false;
            $scope.vc.grids.QV_1603_21320.events = {
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
                    $scope.vc.trackers.DetailAmountsToCancel.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1603_21320.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_1603_21320");
                    $scope.vc.hideShowColumns("QV_1603_21320", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1603_21320.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1603_21320.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1603_21320.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1603_21320 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1603_21320 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1603_21320.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1603_21320.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1603_21320.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPII_28027',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBKP_698405',
                element: []
            };
            $scope.vc.grids.QV_1603_21320.AT24_DESCRIOT439 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1603_21320.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBKP_698405",
                        'maxlength': 35,
                        'data-validation-code': "{{vc.viewState.QV_1603_21320.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1603_21320.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1603_21320.column.value = {
                title: 'ASSTS.LBL_ASSTS_VALORNPRH_26284',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXMW_735405',
                element: []
            };
            $scope.vc.grids.QV_1603_21320.AT44_VALUELCR439 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1603_21320.column.value.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXMW_735405",
                        'data-validation-code': "{{vc.viewState.QV_1603_21320.column.value.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1603_21320.column.value.format",
                        'k-decimals': "vc.viewState.QV_1603_21320.column.value.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1603_21320.column.value.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1603_21320.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_1603_21320.column.description.title|translate:vc.viewState.QV_1603_21320.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_1603_21320.column.description.width,
                    format: $scope.vc.viewState.QV_1603_21320.column.description.format,
                    editor: $scope.vc.grids.QV_1603_21320.AT24_DESCRIOT439.control,
                    template: "<span ng-class='vc.viewState.QV_1603_21320.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_1603_21320\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1603_21320.column.description.style",
                        "title": "{{vc.viewState.QV_1603_21320.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1603_21320.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1603_21320.columns.push({
                    field: 'value',
                    title: '{{vc.viewState.QV_1603_21320.column.value.title|translate:vc.viewState.QV_1603_21320.column.value.titleArgs}}',
                    width: $scope.vc.viewState.QV_1603_21320.column.value.width,
                    format: $scope.vc.viewState.QV_1603_21320.column.value.format,
                    editor: $scope.vc.grids.QV_1603_21320.AT44_VALUELCR439.control,
                    template: "<span ng-class='vc.viewState.QV_1603_21320.column.value.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.value, \"QV_1603_21320\", \"value\"):kendo.toString(#=value#, vc.viewState.QV_1603_21320.column.value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1603_21320.column.value.style",
                        "title": "{{vc.viewState.QV_1603_21320.column.value.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_1603_21320.column.value.hidden
                });
            }
            $scope.vc.viewState.QV_1603_21320.toolbar = {}
            $scope.vc.grids.QV_1603_21320.toolbar = [];
            //ViewState - Group: Group2309
            $scope.vc.createViewState({
                id: "G_DISBURSETE_903405",
                hasId: true,
                componentStyle: [],
                label: 'Group2309',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DetailPaymentForm = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    disbursementId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "disbursementId", 0)
                    },
                    disbursementrate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "disbursementrate", '')
                    },
                    currencyId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "currencyId", 0)
                    },
                    currencyDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "currencyDescription", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "amount", 0)
                    },
                    typeQuotation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "typeQuotation", '')
                    },
                    quote: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "quote", 0)
                    },
                    amountOp: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "amountOp", 0)
                    },
                    quoteTypeOp: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "quoteTypeOp", '')
                    },
                    quoteOp: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "quoteOp", 0)
                    },
                    amountMn: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "amountMn", 0)
                    },
                    account: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "account", '')
                    },
                    beneficiary: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "beneficiary", '')
                    },
                    officeId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "officeId", 0)
                    },
                    officeName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "officeName", '')
                    },
                    sequential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "sequential", 0)
                    },
                    productCategory: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "productCategory", '')
                    },
                    preNotification: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "preNotification", 0)
                    },
                    observations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailPaymentForm", "observations", '')
                    }
                }
            });
            $scope.vc.model.DetailPaymentForm = new kendo.data.DataSource({
                pageSize: 5,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DETAILAP_5973';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DETAILAP_5973();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_5973_48889',
                                    queryRequest,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                options.success(result);
                                            } else {
                                                options.success([]);
                                            }
                                        } else {
                                            options.error([]);
                                        }
                                    }, (function() {
                                        var queryOptions = options.data;
                                        var queryView = {
                                            'allowPaging': true,
                                            'pageSize': 5
                                        };

                                        function config(queryOptions, queryView) {
                                            var result = undefined;
                                            if (queryView.allowPaging === true) {
                                                result = {};
                                                if (angular.isDefined(queryOptions.appendRecords) && queryOptions.appendRecords === true) {
                                                    result.appendRecords = true;
                                                }
                                                result.pageSize = queryView.pageSize;
                                            }
                                            return result;
                                        }
                                        return config(queryOptions, queryView);
                                    }()));
                                }
                            }
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DetailPaymentForm',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5973_48889', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
                            if (!args.cancel) {
                                options.success(args.row);
                            } else {
                                options.error(new Error('DeletingError'));
                            }
                        });
                        // end block
                    }
                },
                schema: {
                    model: $scope.vc.types.DetailPaymentForm
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5973_48889").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DETAILAP_5973 = $scope.vc.model.DetailPaymentForm;
            $scope.vc.trackers.DetailPaymentForm = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DetailPaymentForm);
            $scope.vc.model.DetailPaymentForm.bind('change', function(e) {
                $scope.vc.trackers.DetailPaymentForm.track(e);
            });
            $scope.vc.grids.QV_5973_48889 = {};
            $scope.vc.grids.QV_5973_48889.queryId = 'Q_DETAILAP_5973';
            $scope.vc.viewState.QV_5973_48889 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5973_48889.column = {};
            $scope.vc.grids.QV_5973_48889.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_5973_48889.events = {
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
                    $scope.vc.trackers.DetailPaymentForm.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_5973_48889.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_5973_48889");
                    $scope.vc.hideShowColumns("QV_5973_48889", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5973_48889.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5973_48889.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5973_48889.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5973_48889 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5973_48889 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_5973_48889.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_5973_48889.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_5973_48889.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "DetailPaymentForm",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_5973_48889", args);
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
            $scope.vc.grids.QV_5973_48889.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5973_48889.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5973_48889.column.disbursementId = {
                title: 'ASSTS.LBL_ASSTS_NONSYXWRW_43467',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHUQ_857405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT57_INDEXKGR835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.disbursementId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHUQ_857405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.disbursementId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.disbursementId.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.disbursementId.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.disbursementId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.disbursementrate = {
                title: 'ASSTS.LBL_ASSTS_ARUJAZZWD_36528',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOKM_482405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT56_DISBURNT835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.disbursementrate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOKM_482405",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.disbursementrate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.disbursementrate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.currencyId = {
                title: 'ASSTS.LBL_ASSTS_MONLYCWKQ_22133',
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
                componentId: 'VA_TEXTINPUTBOXDPF_455405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT99_CURRENID835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.currencyId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDPF_455405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.currencyId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.currencyId.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.currencyId.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.currencyId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.currencyDescription = {
                title: 'ASSTS.LBL_ASSTS_MONEDATUB_92849',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLVA_650405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT21_CURRENNE835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.currencyDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLVA_650405",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.currencyDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.currencyDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.amount = {
                title: 'ASSTS.LBL_ASSTS_VALOROEQM_99484',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAKE_256405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT72_AMOUNTEH835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAKE_256405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.amount.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.amount.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.typeQuotation = {
                title: 'ASSTS.LBL_ASSTS_TCGUTJEYQ_91264',
                titleArgs: {},
                tooltip: '',
                width: 30,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPIY_824405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT79_TYPEQUNA835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.typeQuotation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPIY_824405",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.typeQuotation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.typeQuotation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.quote = {
                title: 'ASSTS.LBL_ASSTS_COTIZIXLE_90326',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFBW_549405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT86_QUOTEGAO835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.quote.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFBW_549405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.quote.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.quote.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.quote.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.quote.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.amountOp = {
                title: 'ASSTS.LBL_ASSTS_VALOROPMP_71937',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNRM_694405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT50_AMOUNTOP835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.amountOp.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNRM_694405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.amountOp.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.amountOp.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.amountOp.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.amountOp.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.quoteTypeOp = {
                title: 'ASSTS.LBL_ASSTS_TCOPOIVKZ_88167',
                titleArgs: {},
                tooltip: '',
                width: 50,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGJS_417405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT89_QUOTETYE835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.quoteTypeOp.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGJS_417405",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.quoteTypeOp.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.quoteTypeOp.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.quoteOp = {
                title: 'ASSTS.LBL_ASSTS_COTIZOPLX_93409',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHKY_687405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT71_QUOTEOPP835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.quoteOp.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHKY_687405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.quoteOp.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.quoteOp.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.quoteOp.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.quoteOp.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.amountMn = {
                title: 'ASSTS.LBL_ASSTS_VALORMNDJ_15135',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOQY_980405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT72_AMOUNTMM835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.amountMn.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOQY_980405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.amountMn.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.amountMn.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.amountMn.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.amountMn.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.account = {
                title: 'ASSTS.LBL_ASSTS_REFERENAI_72258',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRFX_333405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT72_ACCOUNTT835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.account.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRFX_333405",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.account.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.account.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.beneficiary = {
                title: 'ASSTS.LBL_ASSTS_BENEFICII_99714',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPHT_403405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT51_BENEFICC835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.beneficiary.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPHT_403405",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.beneficiary.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.beneficiary.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.officeId = {
                title: 'ASSTS.LBL_ASSTS_CODOFICII_21157',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEZU_598405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT28_OFFICEID835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.officeId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEZU_598405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.officeId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.officeId.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.officeId.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.officeId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.officeName = {
                title: 'ASSTS.LBL_ASSTS_OFICINAHX_44623',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUJF_534405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT98_OFFICEAM835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.officeName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUJF_534405",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.officeName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.officeName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.sequential = {
                title: 'ASSTS.LBL_ASSTS_SECUENCAA_14570',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIMM_485405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT28_SEQUENTT835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.sequential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIMM_485405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.sequential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.sequential.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.sequential.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.sequential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.productCategory = {
                title: 'ASSTS.LBL_ASSTS_CATEGORII_77267',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXLH_478405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT92_PRODUCER835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.productCategory.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXLH_478405",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.productCategory.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.productCategory.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.preNotification = {
                title: 'ASSTS.LBL_ASSTS_INSACHVDD_55034',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAPS_637405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT23_PRENOTFI835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.preNotification.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAPS_637405",
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.preNotification.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5973_48889.column.preNotification.format",
                        'k-decimals': "vc.viewState.QV_5973_48889.column.preNotification.decimals",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.preNotification.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5973_48889.column.observations = {
                title: 'ASSTS.LBL_ASSTS_CONCEPTEN_27056',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKEH_204405',
                element: []
            };
            $scope.vc.grids.QV_5973_48889.AT29_OBSERVAN835 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5973_48889.column.observations.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKEH_204405",
                        'maxlength': 255,
                        'data-validation-code': "{{vc.viewState.QV_5973_48889.column.observations.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DISBURSETE_715405,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5973_48889.column.observations.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'disbursementId',
                    title: '{{vc.viewState.QV_5973_48889.column.disbursementId.title|translate:vc.viewState.QV_5973_48889.column.disbursementId.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.disbursementId.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.disbursementId.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT57_INDEXKGR835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.disbursementId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.disbursementId, \"QV_5973_48889\", \"disbursementId\"):kendo.toString(#=disbursementId#, vc.viewState.QV_5973_48889.column.disbursementId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.disbursementId.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.disbursementId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.disbursementId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'disbursementrate',
                    title: '{{vc.viewState.QV_5973_48889.column.disbursementrate.title|translate:vc.viewState.QV_5973_48889.column.disbursementrate.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.disbursementrate.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.disbursementrate.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT56_DISBURNT835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.disbursementrate.style' ng-bind='vc.getStringColumnFormat(dataItem.disbursementrate, \"QV_5973_48889\", \"disbursementrate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.disbursementrate.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.disbursementrate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.disbursementrate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'currencyId',
                    title: '{{vc.viewState.QV_5973_48889.column.currencyId.title|translate:vc.viewState.QV_5973_48889.column.currencyId.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.currencyId.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.currencyId.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT99_CURRENID835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.currencyId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.currencyId, \"QV_5973_48889\", \"currencyId\"):kendo.toString(#=currencyId#, vc.viewState.QV_5973_48889.column.currencyId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.currencyId.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.currencyId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.currencyId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'currencyDescription',
                    title: '{{vc.viewState.QV_5973_48889.column.currencyDescription.title|translate:vc.viewState.QV_5973_48889.column.currencyDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.currencyDescription.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.currencyDescription.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT21_CURRENNE835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.currencyDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.currencyDescription, \"QV_5973_48889\", \"currencyDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.currencyDescription.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.currencyDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.currencyDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_5973_48889.column.amount.title|translate:vc.viewState.QV_5973_48889.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.amount.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.amount.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT72_AMOUNTEH835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_5973_48889\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_5973_48889.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.amount.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'typeQuotation',
                    title: '{{vc.viewState.QV_5973_48889.column.typeQuotation.title|translate:vc.viewState.QV_5973_48889.column.typeQuotation.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.typeQuotation.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.typeQuotation.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT79_TYPEQUNA835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.typeQuotation.style' ng-bind='vc.getStringColumnFormat(dataItem.typeQuotation, \"QV_5973_48889\", \"typeQuotation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.typeQuotation.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.typeQuotation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.typeQuotation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'quote',
                    title: '{{vc.viewState.QV_5973_48889.column.quote.title|translate:vc.viewState.QV_5973_48889.column.quote.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.quote.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.quote.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT86_QUOTEGAO835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.quote.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.quote, \"QV_5973_48889\", \"quote\"):kendo.toString(#=quote#, vc.viewState.QV_5973_48889.column.quote.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.quote.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.quote.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.quote.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'amountOp',
                    title: '{{vc.viewState.QV_5973_48889.column.amountOp.title|translate:vc.viewState.QV_5973_48889.column.amountOp.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.amountOp.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.amountOp.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT50_AMOUNTOP835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.amountOp.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amountOp, \"QV_5973_48889\", \"amountOp\"):kendo.toString(#=amountOp#, vc.viewState.QV_5973_48889.column.amountOp.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.amountOp.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.amountOp.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.amountOp.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'quoteTypeOp',
                    title: '{{vc.viewState.QV_5973_48889.column.quoteTypeOp.title|translate:vc.viewState.QV_5973_48889.column.quoteTypeOp.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.quoteTypeOp.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.quoteTypeOp.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT89_QUOTETYE835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.quoteTypeOp.style' ng-bind='vc.getStringColumnFormat(dataItem.quoteTypeOp, \"QV_5973_48889\", \"quoteTypeOp\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.quoteTypeOp.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.quoteTypeOp.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.quoteTypeOp.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'quoteOp',
                    title: '{{vc.viewState.QV_5973_48889.column.quoteOp.title|translate:vc.viewState.QV_5973_48889.column.quoteOp.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.quoteOp.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.quoteOp.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT71_QUOTEOPP835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.quoteOp.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.quoteOp, \"QV_5973_48889\", \"quoteOp\"):kendo.toString(#=quoteOp#, vc.viewState.QV_5973_48889.column.quoteOp.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.quoteOp.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.quoteOp.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.quoteOp.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'amountMn',
                    title: '{{vc.viewState.QV_5973_48889.column.amountMn.title|translate:vc.viewState.QV_5973_48889.column.amountMn.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.amountMn.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.amountMn.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT72_AMOUNTMM835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.amountMn.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amountMn, \"QV_5973_48889\", \"amountMn\"):kendo.toString(#=amountMn#, vc.viewState.QV_5973_48889.column.amountMn.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.amountMn.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.amountMn.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.amountMn.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'account',
                    title: '{{vc.viewState.QV_5973_48889.column.account.title|translate:vc.viewState.QV_5973_48889.column.account.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.account.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.account.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT72_ACCOUNTT835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.account.style' ng-bind='vc.getStringColumnFormat(dataItem.account, \"QV_5973_48889\", \"account\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.account.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.account.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.account.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'beneficiary',
                    title: '{{vc.viewState.QV_5973_48889.column.beneficiary.title|translate:vc.viewState.QV_5973_48889.column.beneficiary.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.beneficiary.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.beneficiary.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT51_BENEFICC835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.beneficiary.style' ng-bind='vc.getStringColumnFormat(dataItem.beneficiary, \"QV_5973_48889\", \"beneficiary\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.beneficiary.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.beneficiary.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.beneficiary.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'officeId',
                    title: '{{vc.viewState.QV_5973_48889.column.officeId.title|translate:vc.viewState.QV_5973_48889.column.officeId.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.officeId.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.officeId.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT28_OFFICEID835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.officeId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.officeId, \"QV_5973_48889\", \"officeId\"):kendo.toString(#=officeId#, vc.viewState.QV_5973_48889.column.officeId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.officeId.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.officeId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.officeId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'officeName',
                    title: '{{vc.viewState.QV_5973_48889.column.officeName.title|translate:vc.viewState.QV_5973_48889.column.officeName.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.officeName.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.officeName.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT98_OFFICEAM835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.officeName.style' ng-bind='vc.getStringColumnFormat(dataItem.officeName, \"QV_5973_48889\", \"officeName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.officeName.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.officeName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.officeName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'sequential',
                    title: '{{vc.viewState.QV_5973_48889.column.sequential.title|translate:vc.viewState.QV_5973_48889.column.sequential.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.sequential.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.sequential.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT28_SEQUENTT835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.sequential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequential, \"QV_5973_48889\", \"sequential\"):kendo.toString(#=sequential#, vc.viewState.QV_5973_48889.column.sequential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.sequential.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.sequential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.sequential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'productCategory',
                    title: '{{vc.viewState.QV_5973_48889.column.productCategory.title|translate:vc.viewState.QV_5973_48889.column.productCategory.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.productCategory.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.productCategory.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT92_PRODUCER835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.productCategory.style' ng-bind='vc.getStringColumnFormat(dataItem.productCategory, \"QV_5973_48889\", \"productCategory\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.productCategory.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.productCategory.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.productCategory.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'preNotification',
                    title: '{{vc.viewState.QV_5973_48889.column.preNotification.title|translate:vc.viewState.QV_5973_48889.column.preNotification.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.preNotification.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.preNotification.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT23_PRENOTFI835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.preNotification.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.preNotification, \"QV_5973_48889\", \"preNotification\"):kendo.toString(#=preNotification#, vc.viewState.QV_5973_48889.column.preNotification.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_48889.column.preNotification.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.preNotification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.preNotification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_48889.columns.push({
                    field: 'observations',
                    title: '{{vc.viewState.QV_5973_48889.column.observations.title|translate:vc.viewState.QV_5973_48889.column.observations.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_48889.column.observations.width,
                    format: $scope.vc.viewState.QV_5973_48889.column.observations.format,
                    editor: $scope.vc.grids.QV_5973_48889.AT29_OBSERVAN835.control,
                    template: "<span ng-class='vc.viewState.QV_5973_48889.column.observations.style' ng-bind='vc.getStringColumnFormat(dataItem.observations, \"QV_5973_48889\", \"observations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_48889.column.observations.style",
                        "title": "{{vc.viewState.QV_5973_48889.column.observations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_48889.column.observations.hidden
                });
            }
            $scope.vc.viewState.QV_5973_48889.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_5973_48889.column.cmdEdition = {};
            $scope.vc.viewState.QV_5973_48889.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_5973_48889.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_5973_48889.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5973_48889.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_DISBURSETE_903405.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_5973_48889.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_5973_48889.toolbar = {
                CEQV_201QV_5973_48889_606: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_5973_48889.toolbar = [{
                "name": "CEQV_201QV_5973_48889_606",
                "text": "{{'ASSTS.LBL_ASSTS_CREAROWFP_92542'|translate}}",
                "template": "<button id='CEQV_201QV_5973_48889_606' " + " ng-if='vc.viewState.QV_5973_48889.toolbar.CEQV_201QV_5973_48889_606.visible' " + "ng-disabled = 'vc.viewState.G_DISBURSETE_903405.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_5973_48889_606\",\"DetailPaymentForm\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }]; //ViewState - Group: GroupLayout2297
            $scope.vc.createViewState({
                id: "G_DISBURSEME_609405",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2297',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LiquidateResult = {
                sumTotal: $scope.vc.channelDefaultValues("LiquidateResult", "sumTotal")
            };
            //ViewState - Group: Group2673
            $scope.vc.createViewState({
                id: "G_DISBURSNTE_204405",
                hasId: true,
                componentStyle: [],
                label: 'Group2673',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LiquidateResult, Attribute: sumTotal
            $scope.vc.createViewState({
                id: "Spacer1176",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TOTALALRD_64279",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.DisbursementResult = {
                sumTotal: $scope.vc.channelDefaultValues("DisbursementResult", "sumTotal"),
                difference: $scope.vc.channelDefaultValues("DisbursementResult", "difference")
            };
            //ViewState - Group: Group1591
            $scope.vc.createViewState({
                id: "G_DISBURSEME_974405",
                hasId: true,
                componentStyle: [],
                label: 'Group1591',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementResult, Attribute: sumTotal
            $scope.vc.createViewState({
                id: "Spacer1865",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TOTALDEEE_75722",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementResult, Attribute: difference
            $scope.vc.createViewState({
                id: "Spacer2275",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DIFERENCC_25127",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANDISBURSAA_275_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANDISBURSAA_275_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TLOANDIS_S5N",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ENVIARRFA_30717",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
            };
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
                $scope.vc.render('VC_LOANDISBMN_824275');
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
    var cobisMainModule = cobis.createModule("VC_LOANDISBMN_824275", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_LOANDISBMN_824275", {
            templateUrl: "VC_LOANDISBMN_824275_FORM.html",
            controller: "VC_LOANDISBMN_824275_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LOANDISBMN_824275?" + $.param(search);
            }
        });
        VC_LOANDISBMN_824275(cobisMainModule);
    }]);
} else {
    VC_LOANDISBMN_824275(cobisMainModule);
}