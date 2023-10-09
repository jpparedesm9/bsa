<!-- Designer Generator v 5.1.0.1608 - release SPR 2016-08 29/04/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.customerdataverification = designerEvents.api.customerdataverification || designer.dsgEvents();

function VC_ERFAN09_OEDAO_387(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_ERFAN09_OEDAO_387_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_ERFAN09_OEDAO_387_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)
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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_09_ERFAN09",
            taskVersion: "1.0.0",
            viewContainerId: "VC_ERFAN09_OEDAO_387",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_09_ERFAN09",
        designerEvents.api.customerdataverification,
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
                hasCRUDSupport: true,
                vcName: 'VC_ERFAN09_OEDAO_387'
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
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_09_ERFAN09',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Context: "Context",
                    CustomerReference: "CustomerReference",
                    OfficerAnalysis: "OfficerAnalysis",
                    SourceRevenueCustomer: "SourceRevenueCustomer",
                    OriginalHeader: "OriginalHeader"
                },
                entities: {
                    Context: {
                        Application: 'AT_CON762APCI65',
                        ApplicationSubject: 'AT_CON762ACAO34',
                        RequestId: 'AT_CON762EUTD32',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        CustomerId: 'AT_CON762CSTE68',
                        Bookmark: 'AT_CON762BKAK11',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        TaskSubject: 'AT_CON762TSUT41',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CustomerReference: {
                        VerifyData: 'AT_TOM822RFYD25',
                        DateVerification: 'AT_TOM822AITO45',
                        UserVerification: 'AT_TOM822URRI81',
                        Result: 'AT_TOM822RESL32',
                        IdCustomer: 'AT_TOM822CUSM39',
                        EffectiveDate: 'AT_TOM822ETDT31',
                        _pks: [],
                        _entityId: 'EN_TOMREFREC822',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OfficerAnalysis: {
                        CreditLineValid: 'AT_FIC039ETIA33',
                        CreditLineValidCustom: 'AT_FIC039ILDS81',
                        ApplicationNumber: 'AT_FIC039APIB92',
                        SuggestedAmount: 'AT_FIC039SAMN92',
                        AmounttoDisburse: 'AT_FIC039UNDU26',
                        Suggestedcurrency: 'AT_FIC039SURE63',
                        ProductType: 'AT_FIC039POCT17',
                        TermFrecuency: 'AT_FIC039TENY05',
                        Term: 'AT_FIC039TERM93',
                        Officer: 'AT_FIC039FFCE92',
                        Sector: 'AT_FIC039SCOR17',
                        Province: 'AT_FIC039PONE98',
                        City: 'AT_FIC039CITY75',
                        CreditLine: 'AT_FIC039CRTN56',
                        SerctorNeg: 'AT_FIC039ORNG42',
                        OfficierName: 'AT_FIC039OCEC07',
                        observationReprog: 'AT_FIC039BINO42',
                        Parroquia: 'AT_FIC039RQIA94',
                        _pks: ['ApplicationNumber'],
                        _entityId: 'EN_FICRALYSS039',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    SourceRevenueCustomer: {
                        subActivityEconomic: 'AT_RER755SAVM46',
                        Type: 'AT_RER755TYPE77',
                        Sector: 'AT_RER755SCOR68',
                        SubSector: 'AT_RER755STOR39',
                        EconomicActivity: 'AT_RER755OCIT66',
                        ExplanationActivity: 'AT_RER755ENTY85',
                        CodeFIE: 'AT_RER755IECO72',
                        SourceFinancing: 'AT_RER755SORN75',
                        Rol: 'AT_RER755ROLU15',
                        IdClient: 'AT_RER755DCLN75',
                        Clarification: 'AT_RER755LRIN62',
                        descriptionActivity: 'AT_RER755ATVY95',
                        detailClarification: 'AT_RER755ELIA39',
                        detailSubActivityEco: 'AT_RER755EVTE00',
                        _pks: [],
                        _entityId: 'EN_RERUCUTOR755',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    OriginalHeader: {
                        IDRequested: 'AT_RIG477RQSD66',
                        Office: 'AT_RIG477FICE32',
                        CityCode: 'AT_RIG477ITCE46',
                        AmountRequested: 'AT_RIG477OQUE10',
                        CurrencyRequested: 'AT_RIG477URQT91',
                        Quota: 'AT_RIG477QUOA32',
                        PaymentFrequency: 'AT_RIG477NQUE49',
                        CreditTarget: 'AT_RIG477CRET05',
                        InitialDate: 'AT_RIG477IALT55',
                        ApplicationNumber: 'AT_RIG477IOUR00',
                        UserL: 'AT_RIG477USRL75',
                        Country: 'AT_RIG477COTR74',
                        Province: 'AT_RIG477OINC84',
                        Term: 'AT_RIG477TERM59',
                        TypeRequest: 'AT_RIG477YPRU27',
                        OfficerName: 'AT_RIG477FNME01',
                        NumberLine: 'AT_RIG477NMLN54',
                        AmountApproved: 'AT_RIG477AUPR26',
                        OpNumberBank: 'AT_RIG477NRAK86',
                        StatusRequested: 'AT_RIG477SAUT78',
                        Expromission: 'AT_RIG477XSIN84',
                        ReasonRefinancing: 'AT_RIG477AONN01',
                        CityCredit: 'AT_RIG477CIDI98',
                        CreditSector: 'AT_RIG477EDCT30',
                        ClientSector: 'AT_RIG477LIEN42',
                        OfficerId: 'AT_RIG477OERD27',
                        AmountRequestedML: 'AT_RIG477ONTD67',
                        stageflux: 'AT_RIG477AGFX85',
                        ProductType: 'AT_RIG477PEOE42',
                        Type: 'AT_RIG477TYPE69',
                        CreditLineValid: 'AT_RIG477EVAL88',
                        Agreement: 'AT_RIG477REEM93',
                        CodeAgreement: 'AT_RIG477REET12',
                        RejectionReason: 'AT_RIG477EIEA32',
                        RequestLine: 'AT_RIG477UTIN05',
                        ProductFIE: 'AT_RIG477RUCE24',
                        HousingCount: 'AT_RIG477GCUN35',
                        ScoreType: 'AT_RIG477SOET77',
                        Score: 'AT_RIG477SCOR35',
                        IsWarrantyDestination: 'AT_RIG477DSIN93',
                        IsDebtorOwner: 'AT_RIG477IBTO19',
                        AmountAprobed: 'AT_RIG477MICI25',
                        TermLimit: 'AT_RIG477TEIM91',
                        ActivityNumber: 'AT_RIG477IIMB92',
                        RejectionExcuse: 'AT_RIG477AONC36',
                        PortfolioType: 'AT_RIG477POLY58',
                        ActivityDestination: 'AT_RIG477TETI07',
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QURRFRNE_6164 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QURRFRNE_6164 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QURRFRNE_6164_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QURRFRNE_6164_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_TOMREFREC822',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QURRFRNE_6164',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QURRFRNE_6164_filters = {};
            $scope.vc.queryProperties.Q_RURCECER_2364 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_RURCECER_2364 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RURCECER_2364_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_RURCECER_2364_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RERUCUTOR755',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RURCECER_2364',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_RURCECER_2364_filters = {};
            defaultValues = {
                Context: {},
                CustomerReference: {},
                OfficerAnalysis: {},
                SourceRevenueCustomer: {},
                OriginalHeader: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (en in defaultValues) {
                    if (en == entityName) {
                        for (att in defaultValues[en]) {
                            if (att == attributeName) {
                                for (ch in defaultValues[en][att]) {
                                    if (ch == channel) {
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
            }
            $scope.vc.temporarySave = function() {
                console.log("temporarySave");
                var modelo = $scope.vc.cleanData($scope.vc.model);
                var data = {
                    model: modelo,
                    trackers: $scope.vc.trackers,
                    temporaryStorePK: $scope.vc.metadata.taskPk
                }
                $scope.vc.execute("temporarySave", null, data, function(response) {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    console.log("readTemporaryData");
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    }
                    return $scope.vc.executeService("readTemporaryData", null, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", null, data, function(response) {});
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
            $scope.vc.viewState.VC_ERFAN09_OEDAO_387 = {
                style: []
            }
            //ViewState - Container: customerDataValidationForm
            $scope.vc.createViewState({
                id: "VC_ERFAN09_OEDAO_387",
                hasId: true,
                componentStyle: "cb-without-margins",
                label: 'customerDataValidationForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GrpTittleHeader
            $scope.vc.createViewState({
                id: "VC_ERFAN09_GEHAR_861",
                hasId: true,
                componentStyle: "cb-without-margins",
                label: 'GrpTittleHeader',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.OriginalHeader = {
                IDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "IDRequested"),
                Office: $scope.vc.channelDefaultValues("OriginalHeader", "Office"),
                CityCode: $scope.vc.channelDefaultValues("OriginalHeader", "CityCode"),
                AmountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequested"),
                CurrencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "CurrencyRequested"),
                Quota: $scope.vc.channelDefaultValues("OriginalHeader", "Quota"),
                PaymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "PaymentFrequency"),
                CreditTarget: $scope.vc.channelDefaultValues("OriginalHeader", "CreditTarget"),
                InitialDate: $scope.vc.channelDefaultValues("OriginalHeader", "InitialDate"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ApplicationNumber"),
                UserL: $scope.vc.channelDefaultValues("OriginalHeader", "UserL"),
                Country: $scope.vc.channelDefaultValues("OriginalHeader", "Country"),
                Province: $scope.vc.channelDefaultValues("OriginalHeader", "Province"),
                Term: $scope.vc.channelDefaultValues("OriginalHeader", "Term"),
                TypeRequest: $scope.vc.channelDefaultValues("OriginalHeader", "TypeRequest"),
                OfficerName: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerName"),
                NumberLine: $scope.vc.channelDefaultValues("OriginalHeader", "NumberLine"),
                AmountApproved: $scope.vc.channelDefaultValues("OriginalHeader", "AmountApproved"),
                OpNumberBank: $scope.vc.channelDefaultValues("OriginalHeader", "OpNumberBank"),
                StatusRequested: $scope.vc.channelDefaultValues("OriginalHeader", "StatusRequested"),
                Expromission: $scope.vc.channelDefaultValues("OriginalHeader", "Expromission"),
                ReasonRefinancing: $scope.vc.channelDefaultValues("OriginalHeader", "ReasonRefinancing"),
                CityCredit: $scope.vc.channelDefaultValues("OriginalHeader", "CityCredit"),
                CreditSector: $scope.vc.channelDefaultValues("OriginalHeader", "CreditSector"),
                ClientSector: $scope.vc.channelDefaultValues("OriginalHeader", "ClientSector"),
                OfficerId: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerId"),
                AmountRequestedML: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequestedML"),
                stageflux: $scope.vc.channelDefaultValues("OriginalHeader", "stageflux"),
                ProductType: $scope.vc.channelDefaultValues("OriginalHeader", "ProductType"),
                Type: $scope.vc.channelDefaultValues("OriginalHeader", "Type"),
                CreditLineValid: $scope.vc.channelDefaultValues("OriginalHeader", "CreditLineValid"),
                Agreement: $scope.vc.channelDefaultValues("OriginalHeader", "Agreement"),
                CodeAgreement: $scope.vc.channelDefaultValues("OriginalHeader", "CodeAgreement"),
                RejectionReason: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionReason"),
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine"),
                ProductFIE: $scope.vc.channelDefaultValues("OriginalHeader", "ProductFIE"),
                HousingCount: $scope.vc.channelDefaultValues("OriginalHeader", "HousingCount"),
                ScoreType: $scope.vc.channelDefaultValues("OriginalHeader", "ScoreType"),
                Score: $scope.vc.channelDefaultValues("OriginalHeader", "Score"),
                IsWarrantyDestination: $scope.vc.channelDefaultValues("OriginalHeader", "IsWarrantyDestination"),
                IsDebtorOwner: $scope.vc.channelDefaultValues("OriginalHeader", "IsDebtorOwner"),
                AmountAprobed: $scope.vc.channelDefaultValues("OriginalHeader", "AmountAprobed"),
                TermLimit: $scope.vc.channelDefaultValues("OriginalHeader", "TermLimit"),
                ActivityNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityNumber"),
                RejectionExcuse: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionExcuse"),
                PortfolioType: $scope.vc.channelDefaultValues("OriginalHeader", "PortfolioType"),
                ActivityDestination: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityDestination")
            };
            //ViewState - Group: GrpTittleManual
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_02",
                hasId: true,
                componentStyle: "cb-without-margins",
                htmlSection: true,
                label: 'GrpTittleManual',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                ApplicationSubject: $scope.vc.channelDefaultValues("Context", "ApplicationSubject"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2")
            };
            //ViewState - Group: GrpContextHide
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_03",
                hasId: true,
                componentStyle: "",
                label: 'GrpContextHide',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: customerDataValidationForm
            $scope.vc.createViewState({
                id: "VC_ERFAN09_PSIOB_426",
                hasId: true,
                componentStyle: "",
                label: 'customerDataValidationForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: CustomerReference
            $scope.vc.createViewState({
                id: "VC_ERFAN09_OFECE_713",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VFDCUSDAA_51219",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_USTMRENCVW39_48",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GrpEntidades
            $scope.vc.createViewState({
                id: "GR_USTMRENCVW39_07",
                hasId: true,
                componentStyle: "",
                label: 'GrpEntidades',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GrpOriginalHeader
            $scope.vc.createViewState({
                id: "GR_USTMRENCVW39_08",
                hasId: true,
                componentStyle: "",
                label: 'GrpOriginalHeader',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: GrpContext
            $scope.vc.createViewState({
                id: "GR_USTMRENCVW39_09",
                hasId: true,
                componentStyle: "",
                label: 'GrpContext',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.OfficerAnalysis = {
                CreditLineValid: $scope.vc.channelDefaultValues("OfficerAnalysis", "CreditLineValid"),
                CreditLineValidCustom: $scope.vc.channelDefaultValues("OfficerAnalysis", "CreditLineValidCustom"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OfficerAnalysis", "ApplicationNumber"),
                SuggestedAmount: $scope.vc.channelDefaultValues("OfficerAnalysis", "SuggestedAmount"),
                AmounttoDisburse: $scope.vc.channelDefaultValues("OfficerAnalysis", "AmounttoDisburse"),
                Suggestedcurrency: $scope.vc.channelDefaultValues("OfficerAnalysis", "Suggestedcurrency"),
                ProductType: $scope.vc.channelDefaultValues("OfficerAnalysis", "ProductType"),
                TermFrecuency: $scope.vc.channelDefaultValues("OfficerAnalysis", "TermFrecuency"),
                Term: $scope.vc.channelDefaultValues("OfficerAnalysis", "Term"),
                Officer: $scope.vc.channelDefaultValues("OfficerAnalysis", "Officer"),
                Sector: $scope.vc.channelDefaultValues("OfficerAnalysis", "Sector"),
                Province: $scope.vc.channelDefaultValues("OfficerAnalysis", "Province"),
                City: $scope.vc.channelDefaultValues("OfficerAnalysis", "City"),
                CreditLine: $scope.vc.channelDefaultValues("OfficerAnalysis", "CreditLine"),
                SerctorNeg: $scope.vc.channelDefaultValues("OfficerAnalysis", "SerctorNeg"),
                OfficierName: $scope.vc.channelDefaultValues("OfficerAnalysis", "OfficierName"),
                observationReprog: $scope.vc.channelDefaultValues("OfficerAnalysis", "observationReprog"),
                Parroquia: $scope.vc.channelDefaultValues("OfficerAnalysis", "Parroquia")
            };
            //ViewState - Group: GrpOfficerAnalysis
            $scope.vc.createViewState({
                id: "GR_USTMRENCVW39_10",
                hasId: true,
                componentStyle: "",
                label: 'GrpOfficerAnalysis',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_USTMRENCVW39_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CustomerReference = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    IdCustomer: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerReference", "IdCustomer", 0)
                    },
                    VerifyData: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerReference", "VerifyData", '')
                    },
                    DateVerification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerReference", "DateVerification", '')
                    },
                    UserVerification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerReference", "UserVerification", '')
                    },
                    EffectiveDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerReference", "EffectiveDate", '')
                    },
                    ResultBoolean: {
                        type: "boolean"
                    },
                    Result: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerReference", "Result", '')
                    }
                }
            });
            $scope.vc.model.CustomerReference = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QURRFRNE_6164();
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
                    model: $scope.vc.types.CustomerReference
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QURRF6164_42").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QURRFRNE_6164 = $scope.vc.model.CustomerReference;
            $scope.vc.trackers.CustomerReference = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CustomerReference);
            $scope.vc.model.CustomerReference.bind('change', function(e) {
                $scope.vc.trackers.CustomerReference.track(e);
            });
            $scope.vc.model.CustomerReference.bind('change', function(e) {
                if (e.action !== null && e.action !== '' && e.action === "itemchange") {
                    if (e.items.length > 0) {
                        var item = e.items[0];
                        if ((typeof item.ResultBoolean !== 'undefined') && ((String(item.ResultBoolean) === 'true' && item.Result == '0') || (String(item.ResultBoolean) === 'false' && item.Result == '1') || ((String(item.ResultBoolean) === 'true' || String(item.ResultBoolean) === 'false' && item.Result == '')))) {
                            if (String(item.ResultBoolean) === 'true') {
                                item.set('Result', '1');
                            } else {
                                item.set('Result', '0');
                            }
                        }
                    }
                }
            });
            $scope.vc.grids.QV_QURRF6164_42 = {};
            $scope.vc.grids.QV_QURRF6164_42.queryId = 'Q_QURRFRNE_6164';
            $scope.vc.viewState.QV_QURRF6164_42 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QURRF6164_42.column = {};
            $scope.vc.grids.QV_QURRF6164_42.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.CustomerReference.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QURRF6164_42.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                    $scope.vc.gridDataBound("QV_QURRF6164_42");
                    $scope.vc.hideShowColumns("QV_QURRF6164_42", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QURRF6164_42.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QURRF6164_42.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QURRF6164_42.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QURRF6164_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QURRF6164_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QURRF6164_42.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QURRF6164_42.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QURRF6164_42.column.IdCustomer = {
                title: 'BUSIN.DLB_BUSIN_CGODECLTE_92528',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#######",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_USTMRENCVW3903_CUSM623',
                element: []
            };
            $scope.vc.grids.QV_QURRF6164_42.AT_TOM822CUSM39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.IdCustomer.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_USTMRENCVW3903_CUSM623",
                        'data-validation-code': "{{vc.viewState.QV_QURRF6164_42.column.IdCustomer.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURRF6164_42.column.IdCustomer.format",
                        'k-decimals': "vc.viewState.QV_QURRF6164_42.column.IdCustomer.decimals",
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,1",
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.IdCustomer.enabled",
                        'ng-class': "vc.viewState.QV_QURRF6164_42.column.IdCustomer.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURRF6164_42.column.VerifyData = {
                title: 'BUSIN.DLB_BUSIN_VERIFYDAT_92878',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_USTMRENCVW3903_RFYD567',
                element: []
            };
            $scope.vc.grids.QV_QURRF6164_42.AT_TOM822RFYD25 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.VerifyData.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_USTMRENCVW3903_RFYD567",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QURRF6164_42.column.VerifyData.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,1",
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.VerifyData.enabled",
                        'ng-class': "vc.viewState.QV_QURRF6164_42.column.VerifyData.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURRF6164_42.column.DateVerification = {
                title: 'BUSIN.DLB_BUSIN_DATERCATN_18812',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_USTMRENCVW3903_0000865',
                element: []
            };
            $scope.vc.grids.QV_QURRF6164_42.AT_TOM822AITO45 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.DateVerification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_USTMRENCVW3903_0000865",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_QURRF6164_42.column.DateVerification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,1",
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.DateVerification.enabled",
                        'ng-class': "vc.viewState.QV_QURRF6164_42.column.DateVerification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURRF6164_42.column.UserVerification = {
                title: 'BUSIN.DLB_BUSIN_ERVEIFITI_31691',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_USTMRENCVW3903_0000554',
                element: []
            };
            $scope.vc.grids.QV_QURRF6164_42.AT_TOM822URRI81 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.UserVerification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_USTMRENCVW3903_0000554",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QURRF6164_42.column.UserVerification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,1",
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.UserVerification.enabled",
                        'ng-class': "vc.viewState.QV_QURRF6164_42.column.UserVerification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURRF6164_42.column.EffectiveDate = {
                title: 'BUSIN.DLB_BUSIN_ERCINVGET_27009',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_USTMRENCVW3903_ETDT966',
                element: []
            };
            $scope.vc.grids.QV_QURRF6164_42.AT_TOM822ETDT31 = {
                control: function(container, options) {
                    $scope.vc.catalogs.VA_USTMRENCVW3903_ETDT966 = [{
                        code: 'S',
                        value: 'SI'
                    }, {
                        code: 'N',
                        value: 'NO'
                    }];
                    $('<div class="col-sm-8 "' +
                        '>' +
                        '<label class=' +
                        '"d-radio-block"' +
                        'data-ng-repeat="result in vc.catalogs.VA_USTMRENCVW3903_ETDT966">' +
                        '<input id="VA_USTMRENCVW3903_ETDT966"' +
                        'name="CustomerReference_EffectiveDate"' +
                        'type="radio"' +
                        'value="{{result.code}}"' +
                        'data-bind="value:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'ng-class="vc.viewState.QV_QURRF6164_42.column.EffectiveDate.element[\'' + options.model.uid + '\'].style" ' +
                        'ng-disabled="!designer.enums.hasFlag(designer.constants.mode.All,vc.mode)" ' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)" ' +
                        'ng-readonly="designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)" ' +
                        'title="{{\'vc.viewState.QV_QURRF6164_42.column.EffectiveDate.tooltip\'|translate}}" ' +
                        '/>' +
                        '{{result.value}}' +
                        '</label>' +
                        '</div>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURRF6164_42.column.Result = {
                title: 'BUSIN.DLB_BUSIN_RESULTOEE_12272',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_USTMRENCVW3903_0000448',
                element: []
            };
            $scope.vc.grids.QV_QURRF6164_42.AT_TOM822RESL32 = {
                control: function(container, options) {
                    $scope.options_QV_QURRF6164_42 = options;
                    if (!angular.isDefined($scope.options_QV_QURRF6164_42.model.ResultBoolean)) {
                        if ($scope.options_QV_QURRF6164_42.model.Result === '1') {
                            $scope.options_QV_QURRF6164_42.model.ResultBoolean = true;
                        } else {
                            $scope.options_QV_QURRF6164_42.model.ResultBoolean = false;
                        }
                    }
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': 'ResultBoolean',
                        'data-bind': "value: ResultBoolean",
                        'ng-disabled': "!vc.viewState.QV_QURRF6164_42.column.Result.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-true-value': "'1'",
                        'ng-false-value': "'0'",
                        'ng-model': 'options_QV_QURRF6164_42.model.Result',
                        'ng-class': 'vc.viewState.QV_QURRF6164_42.column.Result.element["' + options.model.uid + '"].style',
                        'ng-click': "vc.change(null,'VA_USTMRENCVW3903_0000448',this.dataItem,'" + options.field + "', $event.target)"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURRF6164_42.columns.push({
                    field: 'IdCustomer',
                    title: '{{vc.viewState.QV_QURRF6164_42.column.IdCustomer.title|translate:vc.viewState.QV_QURRF6164_42.column.IdCustomer.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURRF6164_42.column.IdCustomer.width,
                    format: $scope.vc.viewState.QV_QURRF6164_42.column.IdCustomer.format,
                    editor: $scope.vc.grids.QV_QURRF6164_42.AT_TOM822CUSM39.control,
                    template: "<span ng-class='vc.viewState.QV_QURRF6164_42.column.IdCustomer.element[dataItem.uid].style' ng-bind='kendo.toString(#=IdCustomer#, vc.viewState.QV_QURRF6164_42.column.IdCustomer.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURRF6164_42.column.IdCustomer.style",
                        "title": "{{vc.viewState.QV_QURRF6164_42.column.IdCustomer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURRF6164_42.column.IdCustomer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURRF6164_42.columns.push({
                    field: 'VerifyData',
                    title: '{{vc.viewState.QV_QURRF6164_42.column.VerifyData.title|translate:vc.viewState.QV_QURRF6164_42.column.VerifyData.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURRF6164_42.column.VerifyData.width,
                    format: $scope.vc.viewState.QV_QURRF6164_42.column.VerifyData.format,
                    editor: $scope.vc.grids.QV_QURRF6164_42.AT_TOM822RFYD25.control,
                    template: "<span ng-class='vc.viewState.QV_QURRF6164_42.column.VerifyData.element[dataItem.uid].style'>#if (VerifyData !== null) {# #=VerifyData# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURRF6164_42.column.VerifyData.style",
                        "title": "{{vc.viewState.QV_QURRF6164_42.column.VerifyData.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURRF6164_42.column.VerifyData.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURRF6164_42.columns.push({
                    field: 'DateVerification',
                    title: '{{vc.viewState.QV_QURRF6164_42.column.DateVerification.title|translate:vc.viewState.QV_QURRF6164_42.column.DateVerification.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURRF6164_42.column.DateVerification.width,
                    format: $scope.vc.viewState.QV_QURRF6164_42.column.DateVerification.format,
                    editor: $scope.vc.grids.QV_QURRF6164_42.AT_TOM822AITO45.control,
                    template: "<span ng-class='vc.viewState.QV_QURRF6164_42.column.DateVerification.element[dataItem.uid].style'>#if (DateVerification !== null) {# #=DateVerification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURRF6164_42.column.DateVerification.style",
                        "title": "{{vc.viewState.QV_QURRF6164_42.column.DateVerification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURRF6164_42.column.DateVerification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURRF6164_42.columns.push({
                    field: 'UserVerification',
                    title: '{{vc.viewState.QV_QURRF6164_42.column.UserVerification.title|translate:vc.viewState.QV_QURRF6164_42.column.UserVerification.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURRF6164_42.column.UserVerification.width,
                    format: $scope.vc.viewState.QV_QURRF6164_42.column.UserVerification.format,
                    editor: $scope.vc.grids.QV_QURRF6164_42.AT_TOM822URRI81.control,
                    template: "<span ng-class='vc.viewState.QV_QURRF6164_42.column.UserVerification.element[dataItem.uid].style'>#if (UserVerification !== null) {# #=UserVerification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURRF6164_42.column.UserVerification.style",
                        "title": "{{vc.viewState.QV_QURRF6164_42.column.UserVerification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURRF6164_42.column.UserVerification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURRF6164_42.columns.push({
                    field: 'EffectiveDate',
                    title: '{{vc.viewState.QV_QURRF6164_42.column.EffectiveDate.title|translate:vc.viewState.QV_QURRF6164_42.column.EffectiveDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURRF6164_42.column.EffectiveDate.width,
                    format: $scope.vc.viewState.QV_QURRF6164_42.column.EffectiveDate.format,
                    editor: $scope.vc.grids.QV_QURRF6164_42.AT_TOM822ETDT31.control,
                    template: "<span ng-class='vc.viewState.QV_QURRF6164_42.column.EffectiveDate.element[dataItem.uid].style'>#if (EffectiveDate !== null) {# #=EffectiveDate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURRF6164_42.column.EffectiveDate.style",
                        "title": "{{vc.viewState.QV_QURRF6164_42.column.EffectiveDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURRF6164_42.column.EffectiveDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURRF6164_42.columns.push({
                    field: 'Result',
                    title: '{{vc.viewState.QV_QURRF6164_42.column.Result.title|translate:vc.viewState.QV_QURRF6164_42.column.Result.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURRF6164_42.column.Result.width,
                    format: $scope.vc.viewState.QV_QURRF6164_42.column.Result.format,
                    editor: $scope.vc.grids.QV_QURRF6164_42.AT_TOM822RESL32.control,
                    template: function(dataItem) {
                        var checked = "";
                        var valueBoolean = "false";
                        if (String(dataItem.Result) === "1") {
                            checked = "checked='checked'";
                            valueBoolean = "true";
                        }
                        return "<input name='Result' type='checkbox' value='" + valueBoolean + "' " + checked + " disabled='disabled' ng-class='vc.viewState.QV_QURRF6164_42.column.Result.element[dataItem.uid].style' /> ";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURRF6164_42.column.Result.style",
                        "title": "{{vc.viewState.QV_QURRF6164_42.column.Result.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURRF6164_42.column.Result.hidden
                });
            }
            $scope.vc.viewState.QV_QURRF6164_42.toolbar = {}
            $scope.vc.grids.QV_QURRF6164_42.toolbar = []; //ViewState - Container: Activity
            $scope.vc.createViewState({
                id: "VC_ERFAN09_IVITY_872",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FUENTEDLI_58290",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Other Data
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_03",
                hasId: true,
                componentStyle: "",
                label: 'Other Data',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: SourceRevenueCustomer
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_08",
                hasId: true,
                componentStyle: "",
                label: 'SourceRevenueCustomer',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.SourceRevenueCustomer = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    IdClient: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "IdClient", 0),
                        validation: {
                            IdClientRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Rol: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Rol", ''),
                        validation: {
                            RolRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Type", ''),
                        validation: {
                            TypeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Sector: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Sector", ''),
                        validation: {
                            SectorRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    SubSector: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "SubSector", ''),
                        validation: {
                            SubSectorRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    EconomicActivity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "EconomicActivity", ''),
                        validation: {
                            EconomicActivityRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    descriptionActivity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "descriptionActivity", ''),
                        validation: {
                            descriptionActivityRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Clarification: {
                        type: "string",
                        editable: true
                    },
                    detailSubActivityEco: {
                        type: "string",
                        editable: true
                    },
                    detailClarification: {
                        type: "string",
                        editable: true
                    },
                    subActivityEconomic: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "subActivityEconomic", '')
                    }
                }
            });
            $scope.vc.model.SourceRevenueCustomer = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_RURCECER_2364();
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
                    model: $scope.vc.types.SourceRevenueCustomer
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_RURCE2364_74").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RURCECER_2364 = $scope.vc.model.SourceRevenueCustomer;
            $scope.vc.trackers.SourceRevenueCustomer = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.SourceRevenueCustomer);
            $scope.vc.model.SourceRevenueCustomer.bind('change', function(e) {
                $scope.vc.trackers.SourceRevenueCustomer.track(e);
            });
            $scope.vc.grids.QV_RURCE2364_74 = {};
            $scope.vc.grids.QV_RURCE2364_74.queryId = 'Q_RURCECER_2364';
            $scope.vc.viewState.QV_RURCE2364_74 = {
                style: undefined
            };
            $scope.vc.viewState.QV_RURCE2364_74.column = {};
            $scope.vc.grids.QV_RURCE2364_74.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.SourceRevenueCustomer.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_RURCE2364_74.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                    $scope.vc.gridDataBound("QV_RURCE2364_74");
                    $scope.vc.hideShowColumns("QV_RURCE2364_74", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_RURCE2364_74.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_RURCE2364_74.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_RURCE2364_74.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_RURCE2364_74 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_RURCE2364_74 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_RURCE2364_74.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_RURCE2364_74.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_RURCE2364_74.column.IdClient = {
                title: 'BUSIN.DLB_BUSIN_CDIGOZVON_13133',
                titleArgs: {},
                tooltip: '',
                width: 65,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_DCLN483',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755DCLN75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.IdClient.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_DCLN483",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CDIGOZVON_13133') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.IdClient.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_RURCE2364_74.column.IdClient.format",
                        'k-decimals': "vc.viewState.QV_RURCE2364_74.column.IdClient.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_03,0",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.IdClient.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.IdClient.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Rol = {
                title: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_ROLU425',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RIOTRDTAVI4908_ROLU425 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_RIOTRDTAVI4908_ROLU425_values)) {
                            $scope.vc.catalogs.VA_RIOTRDTAVI4908_ROLU425_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_RIOTRDTAVI4908_ROLU425',
                                'cr_cat_deudor',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4908_ROLU425'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_RIOTRDTAVI4908_ROLU425_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_ROLU425");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_RIOTRDTAVI4908_ROLU425_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_ROLU425");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755ROLU15 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Rol.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_ROLU425",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.Rol.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RIOTRDTAVI4908_ROLU425",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.Rol.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ROLEVJMGD_53686') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Rol.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_03,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TYPEYLJIK_10770',
                titleArgs: {},
                tooltip: '',
                width: 45,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_0000787',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755TYPE77 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_0000787",
                        'maxlength': 4,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TYPEYLJIK_10770') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_03,0",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Sector = {
                title: 'BUSIN.DLB_BUSIN_WUIWWCGVG_35342',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_0000295',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000295 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_RIOTRDTAVI4908_0000295_values)) {
                            $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000295_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_RIOTRDTAVI4908_0000295',
                                'cl_sector_economico',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4908_0000295'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000295_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_0000295");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_RIOTRDTAVI4908_0000295_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_0000295");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755SCOR68 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Sector.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_0000295",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.Sector.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RIOTRDTAVI4908_0000295",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.Sector.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_WUIWWCGVG_35342') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Sector.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_03,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.SubSector = {
                title: 'BUSIN.DLB_BUSIN_SSECTCTID_26184',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_0000810',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000810 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_RIOTRDTAVI4908_0000810_values)) {
                            $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000810_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_RIOTRDTAVI4908_0000810',
                                'cl_subsector_ec',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4908_0000810'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000810_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_0000810");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_RIOTRDTAVI4908_0000810_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_0000810");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755STOR39 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.SubSector.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_0000810",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.SubSector.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RIOTRDTAVI4908_0000810",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.SubSector.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_SSECTCTID_26184') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.SubSector.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_03,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity = {
                title: 'BUSIN.DLB_BUSIN_TIVDECOIA_60481',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_0000668',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000668 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_RIOTRDTAVI4908_0000668_values)) {
                            $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000668_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_RIOTRDTAVI4908_0000668',
                                'cl_actividad_ec',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4908_0000668'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000668_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_0000668");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_RIOTRDTAVI4908_0000668_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_RIOTRDTAVI4908_0000668");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755OCIT66 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.EconomicActivity.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_0000668",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.EconomicActivity.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RIOTRDTAVI4908_0000668",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.EconomicActivity.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TIVDECOIA_60481') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.EconomicActivity.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_03,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity = {
                title: 'BUSIN.DLB_BUSIN_ESIELATII_72943',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_ATVY335',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755ATVY95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.descriptionActivity.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_ATVY335",
                        'maxlength': 100,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ESIELATII_72943') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.descriptionActivity.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_03,0",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.descriptionActivity.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.descriptionActivity.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Clarification = {
                title: 'BUSIN.DLB_BUSIN_ALARACIFI_82775',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755LRIN62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Clarification.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.Clarification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.detailSubActivityEco = {
                title: 'detailSubActivityEco',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.detailClarification = {
                title: 'detailClarification',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.subActivityEconomic = {
                title: 'BUSIN.DLB_BUSIN_UBACTTOIC_10500',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4908_SAVM175',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'IdClient',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.IdClient.title|translate:vc.viewState.QV_RURCE2364_74.column.IdClient.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.IdClient.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.IdClient.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755DCLN75.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.IdClient.element[dataItem.uid].style' ng-bind='kendo.toString(#=IdClient#, vc.viewState.QV_RURCE2364_74.column.IdClient.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.IdClient.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.IdClient.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.IdClient.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Rol',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Rol.title|translate:vc.viewState.QV_RURCE2364_74.column.Rol.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Rol.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Rol.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755ROLU15.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Rol.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RIOTRDTAVI4908_ROLU425.get(dataItem.Rol).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Rol.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Rol.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Rol.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Type.title|translate:vc.viewState.QV_RURCE2364_74.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Type.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Type.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755TYPE77.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Type.element[dataItem.uid].style'>#if (Type !== null) {# #=Type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Type.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Sector',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Sector.title|translate:vc.viewState.QV_RURCE2364_74.column.Sector.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Sector.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Sector.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755SCOR68.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Sector.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RIOTRDTAVI4908_0000295.get(dataItem.Sector).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Sector.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Sector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Sector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'SubSector',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.SubSector.title|translate:vc.viewState.QV_RURCE2364_74.column.SubSector.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.SubSector.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.SubSector.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755STOR39.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.SubSector.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RIOTRDTAVI4908_0000810.get(dataItem.SubSector).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.SubSector.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.SubSector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.SubSector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'EconomicActivity',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.EconomicActivity.title|translate:vc.viewState.QV_RURCE2364_74.column.EconomicActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755OCIT66.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.EconomicActivity.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RIOTRDTAVI4908_0000668.get(dataItem.EconomicActivity).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.EconomicActivity.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.EconomicActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'descriptionActivity',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.descriptionActivity.title|translate:vc.viewState.QV_RURCE2364_74.column.descriptionActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755ATVY95.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.descriptionActivity.element[dataItem.uid].style'>#if (descriptionActivity !== null) {# #=descriptionActivity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.descriptionActivity.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.descriptionActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Clarification',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Clarification.title|translate:vc.viewState.QV_RURCE2364_74.column.Clarification.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Clarification.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Clarification.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755LRIN62.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Clarification.element[dataItem.uid].style'>#if (Clarification !== null) {# #=Clarification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Clarification.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Clarification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Clarification.hidden
                });
            }
            $scope.vc.viewState.QV_RURCE2364_74.toolbar = {}
            $scope.vc.grids.QV_RURCE2364_74.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_09_ERFAN09_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_09_ERFAN09_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_ROLU425.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000295.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000810.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000668.read();
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
                $scope.vc.render('VC_ERFAN09_OEDAO_387');
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
    var cobisMainModule = cobis.createModule("VC_ERFAN09_OEDAO_387", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_ERFAN09_OEDAO_387", {
            templateUrl: "VC_ERFAN09_OEDAO_387_FORM.html",
            controller: "VC_ERFAN09_OEDAO_387_CTRL",
            label: "customerDataValidationForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_ERFAN09_OEDAO_387?" + $.param(search);
            }
        });
        VC_ERFAN09_OEDAO_387(cobisMainModule);
    }]);
} else {
    VC_ERFAN09_OEDAO_387(cobisMainModule);
}