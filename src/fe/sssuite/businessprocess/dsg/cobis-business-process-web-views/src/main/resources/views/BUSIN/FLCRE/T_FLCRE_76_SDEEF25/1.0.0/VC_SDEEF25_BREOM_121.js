//Designer Generator v 6.1.1 - release SPR 2017-05_01 03/20/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskdisbursementform = designerEvents.api.taskdisbursementform || designer.dsgEvents();

function VC_SDEEF25_BREOM_121(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_SDEEF25_BREOM_121_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_SDEEF25_BREOM_121_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_76_SDEEF25",
            taskVersion: "1.0.0",
            viewContainerId: "VC_SDEEF25_BREOM_121",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_76_SDEEF25",
        designerEvents.api.taskdisbursementform,
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
                vcName: 'VC_SDEEF25_BREOM_121'
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
                    taskId: 'T_FLCRE_76_SDEEF25',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    OriginalHeader: "OriginalHeader",
                    Context: "Context",
                    LoanHeader: "LoanHeader",
                    DetailLiquidateValues: "DetailLiquidateValues",
                    DisbursementDetail: "DisbursementDetail"
                },
                entities: {
                    OriginalHeader: {
                        stageflux: 'AT_RIG477AGFX85',
                        RejectionExcuse: 'AT_RIG477AONC36',
                        ReasonRefinancing: 'AT_RIG477AONN01',
                        AmountApproved: 'AT_RIG477AUPR26',
                        CityCredit: 'AT_RIG477CIDI98',
                        Country: 'AT_RIG477COTR74',
                        CreditTarget: 'AT_RIG477CRET05',
                        IsWarrantyDestination: 'AT_RIG477DSIN93',
                        CreditSector: 'AT_RIG477EDCT30',
                        RejectionReason: 'AT_RIG477EIEA32',
                        CreditLineValid: 'AT_RIG477EVAL88',
                        Office: 'AT_RIG477FICE32',
                        OfficerName: 'AT_RIG477FNME01',
                        HousingCount: 'AT_RIG477GCUN35',
                        InitialDate: 'AT_RIG477IALT55',
                        IsDebtorOwner: 'AT_RIG477IBTO19',
                        ActivityNumber: 'AT_RIG477IIMB92',
                        ApplicationNumber: 'AT_RIG477IOUR00',
                        CityCode: 'AT_RIG477ITCE46',
                        ClientSector: 'AT_RIG477LIEN42',
                        AmountAprobed: 'AT_RIG477MICI25',
                        AmountCalculated: 'AT_RIG477MNLA18',
                        NumberLine: 'AT_RIG477NMLN54',
                        PaymentFrequency: 'AT_RIG477NQUE49',
                        OpNumberBank: 'AT_RIG477NRAK86',
                        OfficerId: 'AT_RIG477OERD27',
                        Province: 'AT_RIG477OINC84',
                        AmountRequestedML: 'AT_RIG477ONTD67',
                        AmountRequested: 'AT_RIG477OQUE10',
                        ProductType: 'AT_RIG477PEOE42',
                        PortfolioType: 'AT_RIG477POLY58',
                        Quota: 'AT_RIG477QUOA32',
                        Agreement: 'AT_RIG477REEM93',
                        CodeAgreement: 'AT_RIG477REET12',
                        IDRequested: 'AT_RIG477RQSD66',
                        ProductFIE: 'AT_RIG477RUCE24',
                        StatusRequested: 'AT_RIG477SAUT78',
                        Score: 'AT_RIG477SCOR35',
                        ScoreType: 'AT_RIG477SOET77',
                        TermLimit: 'AT_RIG477TEIM91',
                        Term: 'AT_RIG477TERM59',
                        ActivityDestination: 'AT_RIG477TETI07',
                        Type: 'AT_RIG477TYPE69',
                        CurrencyRequested: 'AT_RIG477URQT91',
                        UserL: 'AT_RIG477USRL75',
                        RequestLine: 'AT_RIG477UTIN05',
                        Expromission: 'AT_RIG477XSIN84',
                        TypeRequest: 'AT_RIG477YPRU27',
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Context: {
                        ApplicationSubject: 'AT_CON762ACAO34',
                        Application: 'AT_CON762APCI65',
                        Bookmark: 'AT_CON762BKAK11',
                        CustomerId: 'AT_CON762CSTE68',
                        RequestId: 'AT_CON762EUTD32',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        TaskSubject: 'AT_CON762TSUT41',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanHeader: {
                        ValuetoDisburse: 'AT_LON746ATBS57',
                        BalanceOperation: 'AT_LON746BAIO42',
                        LockDelete: 'AT_LON746CDEE65',
                        Currency: 'AT_LON746CURR52',
                        CreditLineValid: 'AT_LON746DINI26',
                        Office: 'AT_LON746FFIE81',
                        InitialDate: 'AT_LON746IIAT97',
                        LockCode: 'AT_LON746LOOE05',
                        Operation: 'AT_LON746OAIO61',
                        OfficeId: 'AT_LON746OEID34',
                        OperationBanck: 'AT_LON746OERB97',
                        ProposedAmount: 'AT_LON746OMUT02',
                        PriceQuote: 'AT_LON746PIQO17',
                        ProductType: 'AT_LON746PTTP33',
                        ProcessNumber: 'AT_LON746RCME88',
                        CustomerId: 'AT_LON746TORI83',
                        NumberLine: 'AT_LON746UERE34',
                        AmounttoDisburse: 'AT_LON746UOBU96',
                        Customer: 'AT_LON746USMR12',
                        ValueDiscount: 'AT_LON746UUNT10',
                        _pks: [],
                        _entityId: 'EN_LONHEADER746',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    DetailLiquidateValues: {
                        Concept: 'AT_ELQ522CONP15',
                        Description: 'AT_ELQ522DCRI99',
                        Sign: 'AT_ELQ522SIGN15',
                        Value: 'AT_ELQ522VALU51',
                        _pks: [],
                        _entityId: 'EN_ELQUDATAU522',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DisbursementDetail: {
                        AmountMOP: 'AT_DBS924ATOP33',
                        Atx: 'AT_DBS924ATXX05',
                        ValueMl: 'AT_DBS924AUML51',
                        DisbursementValue: 'AT_DBS924BSNT06',
                        Currency: 'AT_DBS924CNCY45',
                        DisbursementId: 'AT_DBS924DBTI19',
                        DisbursementFormId: 'AT_DBS924DSSN62',
                        PriceQuote: 'AT_DBS924RUTE44',
                        sequential: 'AT_DBS924SEUL29',
                        DisbursementForm: 'AT_DBS924SUEN66',
                        _pks: [],
                        _entityId: 'EN_DBSMTDEAL924',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_TSRSEENL_1342 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_TSRSEENL_1342 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TSRSEENL_1342_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_TSRSEENL_1342_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DBSMTDEAL924',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TSRSEENL_1342',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_TSRSEENL_1342_filters = {};
            $scope.vc.queryProperties.Q_TDLIAEAL_9011 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_TDLIAEAL_9011 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TDLIAEAL_9011_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_TDLIAEAL_9011_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ELQUDATAU522',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TDLIAEAL_9011',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_TDLIAEAL_9011_filters = {};
            var defaultValues = {
                OriginalHeader: {},
                Context: {},
                LoanHeader: {},
                DetailLiquidateValues: {},
                DisbursementDetail: {}
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
                $scope.vc.execute("temporarySave", VC_SDEEF25_BREOM_121, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_SDEEF25_BREOM_121, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_SDEEF25_BREOM_121, data, function() {});
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
            $scope.vc.viewState.VC_SDEEF25_BREOM_121 = {
                style: []
            }
            //ViewState - Container: DisbursementForm
            $scope.vc.createViewState({
                id: "VC_SDEEF25_BREOM_121",
                hasId: true,
                componentStyle: [],
                label: 'DisbursementForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: T_VW_tittleProcess
            $scope.vc.createViewState({
                id: "VC_SDEEF25_GPOSR_389",
                hasId: true,
                componentStyle: [],
                label: 'T_VW_tittleProcess',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.OriginalHeader = {
                stageflux: $scope.vc.channelDefaultValues("OriginalHeader", "stageflux"),
                RejectionExcuse: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionExcuse"),
                ReasonRefinancing: $scope.vc.channelDefaultValues("OriginalHeader", "ReasonRefinancing"),
                AmountApproved: $scope.vc.channelDefaultValues("OriginalHeader", "AmountApproved"),
                CityCredit: $scope.vc.channelDefaultValues("OriginalHeader", "CityCredit"),
                Country: $scope.vc.channelDefaultValues("OriginalHeader", "Country"),
                CreditTarget: $scope.vc.channelDefaultValues("OriginalHeader", "CreditTarget"),
                IsWarrantyDestination: $scope.vc.channelDefaultValues("OriginalHeader", "IsWarrantyDestination"),
                CreditSector: $scope.vc.channelDefaultValues("OriginalHeader", "CreditSector"),
                RejectionReason: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionReason"),
                CreditLineValid: $scope.vc.channelDefaultValues("OriginalHeader", "CreditLineValid"),
                Office: $scope.vc.channelDefaultValues("OriginalHeader", "Office"),
                OfficerName: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerName"),
                HousingCount: $scope.vc.channelDefaultValues("OriginalHeader", "HousingCount"),
                InitialDate: $scope.vc.channelDefaultValues("OriginalHeader", "InitialDate"),
                IsDebtorOwner: $scope.vc.channelDefaultValues("OriginalHeader", "IsDebtorOwner"),
                ActivityNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityNumber"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ApplicationNumber"),
                CityCode: $scope.vc.channelDefaultValues("OriginalHeader", "CityCode"),
                ClientSector: $scope.vc.channelDefaultValues("OriginalHeader", "ClientSector"),
                AmountAprobed: $scope.vc.channelDefaultValues("OriginalHeader", "AmountAprobed"),
                AmountCalculated: $scope.vc.channelDefaultValues("OriginalHeader", "AmountCalculated"),
                NumberLine: $scope.vc.channelDefaultValues("OriginalHeader", "NumberLine"),
                PaymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "PaymentFrequency"),
                OpNumberBank: $scope.vc.channelDefaultValues("OriginalHeader", "OpNumberBank"),
                OfficerId: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerId"),
                Province: $scope.vc.channelDefaultValues("OriginalHeader", "Province"),
                AmountRequestedML: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequestedML"),
                AmountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequested"),
                ProductType: $scope.vc.channelDefaultValues("OriginalHeader", "ProductType"),
                PortfolioType: $scope.vc.channelDefaultValues("OriginalHeader", "PortfolioType"),
                Quota: $scope.vc.channelDefaultValues("OriginalHeader", "Quota"),
                Agreement: $scope.vc.channelDefaultValues("OriginalHeader", "Agreement"),
                CodeAgreement: $scope.vc.channelDefaultValues("OriginalHeader", "CodeAgreement"),
                IDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "IDRequested"),
                ProductFIE: $scope.vc.channelDefaultValues("OriginalHeader", "ProductFIE"),
                StatusRequested: $scope.vc.channelDefaultValues("OriginalHeader", "StatusRequested"),
                Score: $scope.vc.channelDefaultValues("OriginalHeader", "Score"),
                ScoreType: $scope.vc.channelDefaultValues("OriginalHeader", "ScoreType"),
                TermLimit: $scope.vc.channelDefaultValues("OriginalHeader", "TermLimit"),
                Term: $scope.vc.channelDefaultValues("OriginalHeader", "Term"),
                ActivityDestination: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityDestination"),
                Type: $scope.vc.channelDefaultValues("OriginalHeader", "Type"),
                CurrencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "CurrencyRequested"),
                UserL: $scope.vc.channelDefaultValues("OriginalHeader", "UserL"),
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine"),
                Expromission: $scope.vc.channelDefaultValues("OriginalHeader", "Expromission"),
                TypeRequest: $scope.vc.channelDefaultValues("OriginalHeader", "TypeRequest")
            };
            //ViewState - Group: GrpTittleManual
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_02",
                hasId: true,
                componentStyle: ["cb-without-margins"],
                htmlSection: true,
                label: 'GrpTittleManual',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_02-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                ApplicationSubject: $scope.vc.channelDefaultValues("Context", "ApplicationSubject"),
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject")
            };
            //ViewState - Group: GrpContextHide
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_03",
                hasId: true,
                componentStyle: [],
                label: 'GrpContextHide',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_03-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: T_DisbursementForms
            $scope.vc.createViewState({
                id: "VC_SDEEF25_RPDEN_077",
                hasId: true,
                componentStyle: [],
                label: 'T_DisbursementForms',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_DISURMETFR51_05",
                hasId: true,
                componentStyle: [],
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanHeader = {
                ValuetoDisburse: $scope.vc.channelDefaultValues("LoanHeader", "ValuetoDisburse"),
                BalanceOperation: $scope.vc.channelDefaultValues("LoanHeader", "BalanceOperation"),
                LockDelete: $scope.vc.channelDefaultValues("LoanHeader", "LockDelete"),
                Currency: $scope.vc.channelDefaultValues("LoanHeader", "Currency"),
                CreditLineValid: $scope.vc.channelDefaultValues("LoanHeader", "CreditLineValid"),
                Office: $scope.vc.channelDefaultValues("LoanHeader", "Office"),
                InitialDate: $scope.vc.channelDefaultValues("LoanHeader", "InitialDate"),
                LockCode: $scope.vc.channelDefaultValues("LoanHeader", "LockCode"),
                Operation: $scope.vc.channelDefaultValues("LoanHeader", "Operation"),
                OfficeId: $scope.vc.channelDefaultValues("LoanHeader", "OfficeId"),
                OperationBanck: $scope.vc.channelDefaultValues("LoanHeader", "OperationBanck"),
                ProposedAmount: $scope.vc.channelDefaultValues("LoanHeader", "ProposedAmount"),
                PriceQuote: $scope.vc.channelDefaultValues("LoanHeader", "PriceQuote"),
                ProductType: $scope.vc.channelDefaultValues("LoanHeader", "ProductType"),
                ProcessNumber: $scope.vc.channelDefaultValues("LoanHeader", "ProcessNumber"),
                CustomerId: $scope.vc.channelDefaultValues("LoanHeader", "CustomerId"),
                NumberLine: $scope.vc.channelDefaultValues("LoanHeader", "NumberLine"),
                AmounttoDisburse: $scope.vc.channelDefaultValues("LoanHeader", "AmounttoDisburse"),
                Customer: $scope.vc.channelDefaultValues("LoanHeader", "Customer"),
                ValueDiscount: $scope.vc.channelDefaultValues("LoanHeader", "ValueDiscount")
            };
            //ViewState - Group: Panel Plegable para LoanHeader
            $scope.vc.createViewState({
                id: "GR_DISURMETFR51_06",
                hasId: true,
                componentStyle: [],
                label: 'Panel Plegable para LoanHeader',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeader, Attribute: ValuetoDisburse
            $scope.vc.createViewState({
                id: "VA_DISURMETFR5106_ATBS301",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VALORADMS_70930",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeader, Attribute: BalanceOperation
            $scope.vc.createViewState({
                id: "VA_DISURMETFR5106_BAIO644",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SALDODENA_42327",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel Plegable para DetailLiquidateValues
            $scope.vc.createViewState({
                id: "GR_DISURMETFR51_07",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VALORESLA_52565",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DetailLiquidateValues = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailLiquidateValues", "Concept", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailLiquidateValues", "Description", '')
                    },
                    Value: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailLiquidateValues", "Value", 0)
                    },
                    Sign: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailLiquidateValues", "Sign", '')
                    }
                }
            });
            $scope.vc.model.DetailLiquidateValues = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_TDLIAEAL_9011();
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
                    model: $scope.vc.types.DetailLiquidateValues
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_TDLIA9011_50").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TDLIAEAL_9011 = $scope.vc.model.DetailLiquidateValues;
            $scope.vc.trackers.DetailLiquidateValues = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DetailLiquidateValues);
            $scope.vc.model.DetailLiquidateValues.bind('change', function(e) {
                $scope.vc.trackers.DetailLiquidateValues.track(e);
            });
            $scope.vc.grids.QV_TDLIA9011_50 = {};
            $scope.vc.grids.QV_TDLIA9011_50.queryId = 'Q_TDLIAEAL_9011';
            $scope.vc.viewState.QV_TDLIA9011_50 = {
                style: undefined
            };
            $scope.vc.viewState.QV_TDLIA9011_50.column = {};
            $scope.vc.grids.QV_TDLIA9011_50.editable = false;
            $scope.vc.grids.QV_TDLIA9011_50.events = {
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
                    $scope.vc.trackers.DetailLiquidateValues.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_TDLIA9011_50.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_TDLIA9011_50");
                    $scope.vc.hideShowColumns("QV_TDLIA9011_50", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_TDLIA9011_50.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_TDLIA9011_50.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_TDLIA9011_50.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_TDLIA9011_50 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_TDLIA9011_50 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_TDLIA9011_50.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_TDLIA9011_50.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_TDLIA9011_50.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "DetailLiquidateValues",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        $scope.vc.gridRowSelecting("QV_TDLIA9011_50", args);
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
            $scope.vc.grids.QV_TDLIA9011_50.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_TDLIA9011_50.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_TDLIA9011_50.column.Concept = {
                title: 'BUSIN.DLB_BUSIN_CONCEPTOM_59109',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CONCEPTIY_86172',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5107_CONP525',
                element: []
            };
            $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522CONP15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TDLIA9011_50.column.Concept.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CONCEPTIY_86172'|translate}}",
                        'id': "VA_DISURMETFR5107_CONP525",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_TDLIA9011_50.column.Concept.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,1",
                        'ng-class': "vc.viewState.QV_TDLIA9011_50.column.Concept.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_TDLIA9011_50.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5107_DCRI085',
                element: []
            };
            $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522DCRI99 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TDLIA9011_50.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_DESCRIPCI_06123'|translate}}",
                        'id': "VA_DISURMETFR5107_DCRI085",
                        'maxlength': 400,
                        'data-validation-code': "{{vc.viewState.QV_TDLIA9011_50.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,1",
                        'ng-class': "vc.viewState.QV_TDLIA9011_50.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_TDLIA9011_50.column.Value = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_VALOREYDC_15105',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5107_VALU028',
                element: []
            };
            $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522VALU51 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TDLIA9011_50.column.Value.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_VALOREYDC_15105'|translate}}",
                        'id': "VA_DISURMETFR5107_VALU028",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_TDLIA9011_50.column.Value.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_TDLIA9011_50.column.Value.format",
                        'k-decimals': "vc.viewState.QV_TDLIA9011_50.column.Value.decimals",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,1",
                        'ng-class': "vc.viewState.QV_TDLIA9011_50.column.Value.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_TDLIA9011_50.column.Sign = {
                title: 'BUSIN.DLB_BUSIN_SIGNOTCWB_56579',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_SIGNOPGTS_91531',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5107_SIGN810',
                element: []
            };
            $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522SIGN15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TDLIA9011_50.column.Sign.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_SIGNOPGTS_91531'|translate}}",
                        'id': "VA_DISURMETFR5107_SIGN810",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_TDLIA9011_50.column.Sign.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,1",
                        'ng-class': "vc.viewState.QV_TDLIA9011_50.column.Sign.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TDLIA9011_50.columns.push({
                    field: 'Concept',
                    title: '{{vc.viewState.QV_TDLIA9011_50.column.Concept.title|translate:vc.viewState.QV_TDLIA9011_50.column.Concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_TDLIA9011_50.column.Concept.width,
                    format: $scope.vc.viewState.QV_TDLIA9011_50.column.Concept.format,
                    editor: $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522CONP15.control,
                    template: "<span ng-class='vc.viewState.QV_TDLIA9011_50.column.Concept.element[dataItem.uid].style'>#if (Concept !== null) {# #=Concept# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_TDLIA9011_50.column.Concept.style",
                        "title": "{{vc.viewState.QV_TDLIA9011_50.column.Concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_TDLIA9011_50.column.Concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TDLIA9011_50.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_TDLIA9011_50.column.Description.title|translate:vc.viewState.QV_TDLIA9011_50.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_TDLIA9011_50.column.Description.width,
                    format: $scope.vc.viewState.QV_TDLIA9011_50.column.Description.format,
                    editor: $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522DCRI99.control,
                    template: "<span ng-class='vc.viewState.QV_TDLIA9011_50.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_TDLIA9011_50.column.Description.style",
                        "title": "{{vc.viewState.QV_TDLIA9011_50.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_TDLIA9011_50.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TDLIA9011_50.columns.push({
                    field: 'Value',
                    title: '{{vc.viewState.QV_TDLIA9011_50.column.Value.title|translate:vc.viewState.QV_TDLIA9011_50.column.Value.titleArgs}}',
                    width: $scope.vc.viewState.QV_TDLIA9011_50.column.Value.width,
                    format: $scope.vc.viewState.QV_TDLIA9011_50.column.Value.format,
                    editor: $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522VALU51.control,
                    template: "<span ng-class='vc.viewState.QV_TDLIA9011_50.column.Value.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Value, \"QV_TDLIA9011_50\", \"Value\"):kendo.toString(#=Value#, vc.viewState.QV_TDLIA9011_50.column.Value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_TDLIA9011_50.column.Value.style",
                        "title": "{{vc.viewState.QV_TDLIA9011_50.column.Value.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_TDLIA9011_50.column.Value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TDLIA9011_50.columns.push({
                    field: 'Sign',
                    title: '{{vc.viewState.QV_TDLIA9011_50.column.Sign.title|translate:vc.viewState.QV_TDLIA9011_50.column.Sign.titleArgs}}',
                    width: $scope.vc.viewState.QV_TDLIA9011_50.column.Sign.width,
                    format: $scope.vc.viewState.QV_TDLIA9011_50.column.Sign.format,
                    editor: $scope.vc.grids.QV_TDLIA9011_50.AT_ELQ522SIGN15.control,
                    template: "<span ng-class='vc.viewState.QV_TDLIA9011_50.column.Sign.element[dataItem.uid].style'>#if (Sign !== null) {# #=Sign# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_TDLIA9011_50.column.Sign.style",
                        "title": "{{vc.viewState.QV_TDLIA9011_50.column.Sign.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_TDLIA9011_50.column.Sign.hidden
                });
            }
            $scope.vc.viewState.QV_TDLIA9011_50.toolbar = {}
            $scope.vc.grids.QV_TDLIA9011_50.toolbar = [];
            //ViewState - Group: Panel Plegable para DisbursementDetail
            $scope.vc.createViewState({
                id: "GR_DISURMETFR51_08",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_DETALLELS_81109",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DisbursementDetail = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    DisbursementForm: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementDetail", "DisbursementForm", '')
                    },
                    Currency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementDetail", "Currency", '')
                    },
                    DisbursementValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementDetail", "DisbursementValue", 0)
                    },
                    ValueMl: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementDetail", "ValueMl", 0)
                    },
                    PriceQuote: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementDetail", "PriceQuote", 0)
                    }
                }
            });
            $scope.vc.model.DisbursementDetail = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_TSRSEENL_1342();
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DisbursementDetail',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_TSRSE1342_26', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.DisbursementDetail
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_TSRSE1342_26").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TSRSEENL_1342 = $scope.vc.model.DisbursementDetail;
            $scope.vc.trackers.DisbursementDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DisbursementDetail);
            $scope.vc.model.DisbursementDetail.bind('change', function(e) {
                $scope.vc.trackers.DisbursementDetail.track(e);
                $scope.vc.grids.QV_TSRSE1342_26.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_TSRSE1342_26 = {};
            $scope.vc.grids.QV_TSRSE1342_26.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_TSRSE1342_26) && expandedRowUidActual !== expandedRowUid_QV_TSRSE1342_26) {
                    var gridWidget = $('#QV_TSRSE1342_26').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_TSRSE1342_26 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_TSRSE1342_26 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_TSRSE1342_26 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_TSRSE1342_26);
                }
                expandedRowUid_QV_TSRSE1342_26 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_TSRSE1342_26', args);
                if (angular.isDefined($scope.vc.grids.QV_TSRSE1342_26.view)) {
                    $scope.vc.grids.QV_TSRSE1342_26.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_TSRSE1342_26.customView)) {
                    $scope.vc.grids.QV_TSRSE1342_26.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_TSRSE1342_26'/>"
            };
            $scope.vc.grids.QV_TSRSE1342_26.queryId = 'Q_TSRSEENL_1342';
            $scope.vc.viewState.QV_TSRSE1342_26 = {
                style: undefined
            };
            $scope.vc.viewState.QV_TSRSE1342_26.column = {};
            var expandedRowUid_QV_TSRSE1342_26;
            $scope.vc.grids.QV_TSRSE1342_26.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_TSRSE1342_26.events = {
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
                    $scope.vc.trackers.DisbursementDetail.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_TSRSE1342_26.selectedRow = e.model;
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
                    $scope.vc.grids.QV_TSRSE1342_26.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    $scope.vc.validateForm();
                },
                evalVisibilityOfGridRowDetailIcon: function(dataSource) {
                    var dataView = dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        var args = {
                            nameEntityGrid: "DisbursementDetail",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_TSRSE1342_26", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_TSRSE1342_26", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_TSRSE1342_26");
                    $scope.vc.hideShowColumns("QV_TSRSE1342_26", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_TSRSE1342_26.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_TSRSE1342_26.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_TSRSE1342_26.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_TSRSE1342_26 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_TSRSE1342_26 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_TSRSE1342_26.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_TSRSE1342_26 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_TSRSE1342_26.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_TSRSE1342_26.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementForm = {
                title: 'BUSIN.LBL_BUSIN_ADEDESESL_23793',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_DISURENOR_61646',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5108_SUEN374',
                element: []
            };
            $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924SUEN66 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_DISURENOR_61646'|translate}}",
                        'id': "VA_DISURMETFR5108_SUEN374",
                        'maxlength': 400,
                        'data-validation-code': "{{vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,2",
                        'ng-class': "vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_TSRSE1342_26.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDASSR_79424',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5108_CNCY768',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_DISURMETFR5108_CNCY768 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_DISURMETFR5108_CNCY768',
                            'cl_moneda',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_DISURMETFR5108_CNCY768'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924CNCY45 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TSRSE1342_26.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_MONEDAQAQ_04700'|translate}}",
                        'id': "VA_DISURMETFR5108_CNCY768",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_TSRSE1342_26.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_DISURMETFR5108_CNCY768",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_TSRSE1342_26.column.Currency.template",
                        'data-validation-code': "{{vc.viewState.QV_TSRSE1342_26.column.Currency.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,2",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_VALOREYDC_15105',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5108_BSNT947',
                element: []
            };
            $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924BSNT06 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_VALOREYDC_15105'|translate}}",
                        'id': "VA_DISURMETFR5108_BSNT947",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.format",
                        'k-decimals': "vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.decimals",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,2",
                        'ng-class': "vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_TSRSE1342_26.column.ValueMl = {
                title: 'BUSIN.LBL_BUSIN_VALORENMN_65302',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_VALUELMMY_18189',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5108_AUML843',
                element: []
            };
            $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924AUML51 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TSRSE1342_26.column.ValueMl.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_VALUELMMY_18189'|translate}}",
                        'id': "VA_DISURMETFR5108_AUML843",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_TSRSE1342_26.column.ValueMl.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_TSRSE1342_26.column.ValueMl.format",
                        'k-decimals': "vc.viewState.QV_TSRSE1342_26.column.ValueMl.decimals",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,2",
                        'ng-class': "vc.viewState.QV_TSRSE1342_26.column.ValueMl.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_TSRSE1342_26.column.PriceQuote = {
                title: 'BUSIN.DLB_BUSIN_COTIZACIN_81787',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_COTIZACIN_81787',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_DISURMETFR5108_RUTE458',
                element: []
            };
            $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924RUTE44 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_TSRSE1342_26.column.PriceQuote.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_COTIZACIN_81787'|translate}}",
                        'id': "VA_DISURMETFR5108_RUTE458",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_TSRSE1342_26.column.PriceQuote.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_TSRSE1342_26.column.PriceQuote.format",
                        'k-decimals': "vc.viewState.QV_TSRSE1342_26.column.PriceQuote.decimals",
                        'data-cobis-group': "GroupLayout,GR_DISURMETFR51_05,2",
                        'ng-class': "vc.viewState.QV_TSRSE1342_26.column.PriceQuote.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TSRSE1342_26.columns.push({
                    field: 'DisbursementForm',
                    title: '{{vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.title|translate:vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.titleArgs}}',
                    width: $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.width,
                    format: $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.format,
                    editor: $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924SUEN66.control,
                    template: "<span ng-class='vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.element[dataItem.uid].style'>#if (DisbursementForm !== null) {# #=DisbursementForm# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.style",
                        "title": "{{vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementForm.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TSRSE1342_26.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_TSRSE1342_26.column.Currency.title|translate:vc.viewState.QV_TSRSE1342_26.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_TSRSE1342_26.column.Currency.width,
                    format: $scope.vc.viewState.QV_TSRSE1342_26.column.Currency.format,
                    editor: $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924CNCY45.control,
                    template: "<span ng-class='vc.viewState.QV_TSRSE1342_26.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_DISURMETFR5108_CNCY768.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_TSRSE1342_26.column.Currency.style",
                        "title": "{{vc.viewState.QV_TSRSE1342_26.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_TSRSE1342_26.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TSRSE1342_26.columns.push({
                    field: 'DisbursementValue',
                    title: '{{vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.title|translate:vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.width,
                    format: $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.format,
                    editor: $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924BSNT06.control,
                    template: "<span ng-class='vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.DisbursementValue, \"QV_TSRSE1342_26\", \"DisbursementValue\"):kendo.toString(#=DisbursementValue#, vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.style",
                        "title": "{{vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_TSRSE1342_26.column.DisbursementValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TSRSE1342_26.columns.push({
                    field: 'ValueMl',
                    title: '{{vc.viewState.QV_TSRSE1342_26.column.ValueMl.title|translate:vc.viewState.QV_TSRSE1342_26.column.ValueMl.titleArgs}}',
                    width: $scope.vc.viewState.QV_TSRSE1342_26.column.ValueMl.width,
                    format: $scope.vc.viewState.QV_TSRSE1342_26.column.ValueMl.format,
                    editor: $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924AUML51.control,
                    template: "<span ng-class='vc.viewState.QV_TSRSE1342_26.column.ValueMl.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.ValueMl, \"QV_TSRSE1342_26\", \"ValueMl\"):kendo.toString(#=ValueMl#, vc.viewState.QV_TSRSE1342_26.column.ValueMl.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_TSRSE1342_26.column.ValueMl.style",
                        "title": "{{vc.viewState.QV_TSRSE1342_26.column.ValueMl.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_TSRSE1342_26.column.ValueMl.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_TSRSE1342_26.columns.push({
                    field: 'PriceQuote',
                    title: '{{vc.viewState.QV_TSRSE1342_26.column.PriceQuote.title|translate:vc.viewState.QV_TSRSE1342_26.column.PriceQuote.titleArgs}}',
                    width: $scope.vc.viewState.QV_TSRSE1342_26.column.PriceQuote.width,
                    format: $scope.vc.viewState.QV_TSRSE1342_26.column.PriceQuote.format,
                    editor: $scope.vc.grids.QV_TSRSE1342_26.AT_DBS924RUTE44.control,
                    template: "<span ng-class='vc.viewState.QV_TSRSE1342_26.column.PriceQuote.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.PriceQuote, \"QV_TSRSE1342_26\", \"PriceQuote\"):kendo.toString(#=PriceQuote#, vc.viewState.QV_TSRSE1342_26.column.PriceQuote.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_TSRSE1342_26.column.PriceQuote.style",
                        "title": "{{vc.viewState.QV_TSRSE1342_26.column.PriceQuote.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_TSRSE1342_26.column.PriceQuote.hidden
                });
            }
            $scope.vc.viewState.QV_TSRSE1342_26.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_TSRSE1342_26.columns.push({
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_TSRSE1342_26.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_TSRSE1342_26.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.GR_DISURMETFR51_08.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_TSRSE1342_26.toolbar = {
                CEQV_201_QV_TSRSE1342_26_253: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_TSRSE1342_26.toolbar = [{
                "name": "CEQV_201_QV_TSRSE1342_26_253",
                "text": "{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}",
                "template": "<button id='CEQV_201_QV_TSRSE1342_26_253' " + " ng-if='vc.viewState.QV_TSRSE1342_26.toolbar.CEQV_201_QV_TSRSE1342_26_253.visible' " + "ng-disabled = 'vc.viewState.GR_DISURMETFR51_08.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_TSRSE1342_26_253\",\"DisbursementDetail\")' class='btn btn-default cb-grid-image-button cb-btn-custom-newform'><span class='glyphicon glyphicon-plus-sign'></span> #: text #</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_76_SDEEF25_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_76_SDEEF25_CANCEL",
                componentStyle: [],
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
                    $scope.vc.catalogs.VA_DISURMETFR5108_CNCY768.read();
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
                $scope.vc.render('VC_SDEEF25_BREOM_121');
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
    var cobisMainModule = cobis.createModule("VC_SDEEF25_BREOM_121", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_SDEEF25_BREOM_121", {
            templateUrl: "VC_SDEEF25_BREOM_121_FORM.html",
            controller: "VC_SDEEF25_BREOM_121_CTRL",
            label: "DisbursementForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_SDEEF25_BREOM_121?" + $.param(search);
            }
        });
        VC_SDEEF25_BREOM_121(cobisMainModule);
    }]);
} else {
    VC_SDEEF25_BREOM_121(cobisMainModule);
}