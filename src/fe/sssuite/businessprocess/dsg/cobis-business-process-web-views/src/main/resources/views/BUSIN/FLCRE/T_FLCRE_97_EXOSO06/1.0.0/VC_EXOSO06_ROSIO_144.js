<!-- Designer Generator v 5.1.0.1604 - release SPR 2016-04 04/03/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.genericexpromission = designerEvents.api.genericexpromission || designer.dsgEvents();

function VC_EXOSO06_ROSIO_144(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_EXOSO06_ROSIO_144_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_EXOSO06_ROSIO_144_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_97_EXOSO06",
            taskVersion: "1.0.0",
            viewContainerId: "VC_EXOSO06_ROSIO_144",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_97_EXOSO06",
        designerEvents.api.genericexpromission,
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
                vcName: 'VC_EXOSO06_ROSIO_144'
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
                    taskId: 'T_FLCRE_97_EXOSO06',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    RefinancingOperations: "RefinancingOperations",
                    InfocredHeader: "InfocredHeader",
                    CreditOtherData: "CreditOtherData",
                    LineHeader: "LineHeader",
                    SourceRevenueCustomer: "SourceRevenueCustomer",
                    Context: "Context",
                    OfficerAnalysis: "OfficerAnalysis",
                    OriginalHeader: "OriginalHeader",
                    DebtorGeneral: "DebtorGeneral"
                },
                entities: {
                    RefinancingOperations: {
                        IdOperation: 'AT_RNA459DPER71',
                        RefinancingOption: 'AT_RNA459ANOP06',
                        Balance: 'AT_RNA459BANC23',
                        OriginalAmount: 'AT_RNA459GAMO94',
                        LocalCurrencyAmount: 'AT_RNA459RNUN43',
                        CreditType: 'AT_RNA459EITY95',
                        InternalCustomerClassification: 'AT_RNA459NAIC57',
                        DateGranting: 'AT_RNA459DTGN73',
                        IdRequestedOperation: 'AT_RNA459IDOO11',
                        OperationBank: 'AT_RNA459EANA92',
                        LocalCurrencyBalance: 'AT_RNA459OCBA30',
                        CurrencyOperation: 'AT_RNA459CURA87',
                        IsBase: 'AT_RNA459SIAL87',
                        oficialOperation: 'AT_RNA459AORN87',
                        OperationQualification: 'AT_RNA459EATI72',
                        PayoutPercentage: 'AT_RNA459PEEE15',
                        Rate: 'AT_RNA459RATE39',
                        Sector: 'AT_RNA459SEOR45',
                        _pks: [],
                        _entityId: 'EN_RNANCOPAI459',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    InfocredHeader: {
                        CustomerId: 'AT_INF260CTME27',
                        CustomerName: 'AT_INF260CTOM95',
                        ExpirationDate: 'AT_INF260EIRT18',
                        Count: 'AT_INF260COUN65',
                        AssociateTo: 'AT_INF260TYPE25',
                        ExistsLoanId: 'AT_INF260RUSI31',
                        AssociateWith: 'AT_INF260SCAP79',
                        NewLoanId: 'AT_INF260ANCK80',
                        NewRequestId: 'AT_INF260WEEI96',
                        NewLoanCode: 'AT_INF260EWNO77',
                        Role: 'AT_INF260ROLE49',
                        Out_HasManySimilar: 'AT_INF260MIMA95',
                        Out_SimilarList: 'AT_INF260ONTL63',
                        Out_Source: 'AT_INF260OUTC02',
                        Out_Role: 'AT_INF260OROL00',
                        Out_RequestIdLoanId: 'AT_INF260ESIO38',
                        _pks: [],
                        _entityId: 'EN_INFOREDHD260',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CreditOtherData: {
                        CreditPorpuse: 'AT_CDT309RPPU08',
                        CreditDestination: 'AT_CDT309RDTN13',
                        SourceOfFunding: 'AT_CDT309OUED37',
                        EconomicActivityCredit: 'AT_CDT309NCRI65',
                        ActivityDestinationCredit: 'AT_CDT309TATT21',
                        DescriptionDestinationRequested: 'AT_CDT309DSNS61',
                        CreditDestinationValue: 'AT_CDT309EDSN48',
                        _pks: [],
                        _entityId: 'EN_CDTTEDATA309',
                        _entityVersion: '1.0.0',
                        _transient: true,
                        _transient_list: ['CreditDestinationValue']
                    },
                    LineHeader: {
                        Rotary: 'AT_LIN382RTAY60',
                        Committed: 'AT_LIN382COMT19',
                        AmountProposed: 'AT_LIN382PROE14',
                        CurrencyProposed: 'AT_LIN382EPRO88',
                        EntryDate: 'AT_LIN382NDTE92',
                        ExpirationDate: 'AT_LIN382XPIA29',
                        Officer: 'AT_LIN382OFIC98',
                        Sector: 'AT_LIN382SCTR87',
                        Province: 'AT_LIN382RVIC64',
                        GeograohicDestination: 'AT_LIN382ADSN85',
                        officerName: 'AT_LIN382OFRE66',
                        AmountLocalCurrency: 'AT_LIN382AAUN05',
                        Number: 'AT_LIN382NUBE83',
                        Term: 'AT_LIN382TERM81',
                        CreditCode: 'AT_LIN382CEDD71',
                        AmountUsed: 'AT_LIN382USED53',
                        AvailableAmount: 'AT_LIN382ALEA97',
                        OfficeCode: 'AT_LIN382FIEC49',
                        CityCode: 'AT_LIN382CTCE01',
                        Code: 'AT_LIN382CODE27',
                        NumberTestimony: 'AT_LIN382NBTE14',
                        MaximunQuoteLine: 'AT_LIN382MAQI65',
                        MaximunQuote: 'AT_LIN382MUQT61',
                        _pks: [],
                        _entityId: 'EN_LINEEADER382',
                        _entityVersion: '1.0.0',
                        _transient: false
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
                        _pks: ['ApplicationNumber'],
                        _entityId: 'EN_FICRALYSS039',
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
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    DebtorGeneral: {
                        CustomerCode: 'AT_DEB342CUST03',
                        Role: 'AT_DEB342ROLE73',
                        Identification: 'AT_DEB342IDEN84',
                        CustomerName: 'AT_DEB342CUST55',
                        TypeDocumentId: 'AT_DEB342DOTD15',
                        Address: 'AT_DEB342ADRS63',
                        Qualification: 'AT_DEB342UALN46',
                        AditionalCode: 'AT_DEB342ITDE08',
                        DateCIC: 'AT_DEB342DTCC73',
                        _pks: ['CustomerCode'],
                        _entityId: 'EN_DEBTORHHW342',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_BOREGEEL_0798 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_BOREGEEL_0798 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_BOREGEEL_0798_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_BOREGEEL_0798_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DEBTORHHW342',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_BOREGEEL_0798',
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
            $scope.vc.queries.Q_BOREGEEL_0798_filters = {};
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
            $scope.vc.queryProperties.Q_ITRICNAN_1523 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_ITRICNAN_1523 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ITRICNAN_1523_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ITRICNAN_1523_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RNANCOPAI459',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ITRICNAN_1523',
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
            $scope.vc.queries.Q_ITRICNAN_1523_filters = {};
            defaultValues = {
                RefinancingOperations: {},
                InfocredHeader: {},
                CreditOtherData: {},
                LineHeader: {},
                SourceRevenueCustomer: {},
                Context: {},
                OfficerAnalysis: {},
                OriginalHeader: {},
                DebtorGeneral: {}
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
            $scope.vc.viewState.VC_EXOSO06_ROSIO_144 = {
                style: []
            }
            //ViewState - Container: GenericExpromission
            $scope.vc.createViewState({
                id: "VC_EXOSO06_ROSIO_144",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SLIITDMII_00328",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: HeaderView
            $scope.vc.createViewState({
                id: "VC_EXOSO06_HAERI_142",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RQUSTDTAI_62920",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
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
                HousingCount: $scope.vc.channelDefaultValues("OriginalHeader", "HousingCount")
            };
            //ViewState - Group: GRUOP_HEADER
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_02",
                hasId: true,
                componentStyle: "",
                label: 'GRUOP_HEADER',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: ApplicationNumber
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_IOUR445",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PLATONUER_39479",
                label: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: IDRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_RQSD386",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CRDITCODE_86774",
                label: "BUSIN.DLB_BUSIN_CRDITCODE_86774",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Office
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_0000908",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OFFICEWWB_98352",
                label: "BUSIN.DLB_BUSIN_OFFICELSD_48549",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_0000908 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_0000908', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_0000908'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_0000908");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: CityCode
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_ITCE121",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                label: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_ITCE121 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_ITCE121', 'cl_ciudad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_ITCE121'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_ITCE121");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: AmountRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_OQUE134",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_AMOUTREED_14545",
                label: "BUSIN.DLB_BUSIN_AMOUTREED_14545",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: CurrencyRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_URQT595",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_RENEQESED_71054",
                label: "BUSIN.DLB_BUSIN_RENEQESED_71054",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_URQT595 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8602_URQT595', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_URQT595'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_URQT595");
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
            //ViewState - Entity: OriginalHeader, Attribute: Quota
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_QUOA306",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PAYMENTOS_89327",
                label: "BUSIN.DLB_BUSIN_PAYMENTLI_94219",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 37,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: PaymentFrequency
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_NQUE773",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PYTFREUNY_61581",
                label: "BUSIN.DLB_BUSIN_PYTFREUNY_61581",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_NQUE773 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_NQUE773', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_NQUE773'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_NQUE773");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_TERM237",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                haslabelArgs: true,
                format: "###0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: CreditTarget
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_CRET312",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ENRUEINAN_89137",
                label: "BUSIN.DLB_BUSIN_DCIOEEDDT_35512",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: InitialDate
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_IALT328",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_STARTDATE_61282",
                label: "BUSIN.DLB_BUSIN_STARTDATE_61282",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: OfficerName
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_FNME018",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICIALR_02742",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: NumberLine
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_NMLN737",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NROLINEAB_08143",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: Expromission
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_XSIN642",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OTIVOEXRI_92521",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_XSIN642 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_XSIN642', 'cr_motivoexp', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_XSIN642'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_XSIN642");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: ReasonRefinancing
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_AONN156",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_REASONMLS_18269",
                label: "BUSIN.DLB_BUSIN_REASONMLS_18269",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_AONN156 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_AONN156', 'cr_motivoref', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_AONN156'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_AONN156");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: OpNumberBank
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_NRAK349",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NROLINEAB_08143",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: ProductType
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_PEOE356",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PODUCTTPE_53088",
                label: "BUSIN.DLB_BUSIN_PODUCTTPE_53088",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_PEOE356 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_PEOE356', 'ca_toperacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_PEOE356'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_PEOE356");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: CreditLineValid
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_EVAL957",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_LNEDERDIT_79082",
                label: "BUSIN.DLB_BUSIN_LNEDERDIT_79082",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_EVAL957 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8602_EVAL957', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_EVAL957'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_EVAL957");
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
            //ViewState - Entity: OriginalHeader, Attribute: Agreement
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_REEM856",
                componentStyle: "text-left",
                label: "BUSIN.DLB_BUSIN_CONVENIOQ_42669",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: CodeAgreement
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_REET975",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CDIOEMPRS_19259",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_REET975 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8602_REET975', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_REET975'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_REET975");
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
            //ViewState - Entity: OriginalHeader, Attribute: RejectionReason
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_EIEA610",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MOTORECHZ_03662",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_EIEA610 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_EIEA610', 'cr_motivo_rechazo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_EIEA610'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_EIEA610");
                        }, null, options.data.filter, 1);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: ProductFIE
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_RUCE927",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PRODUTOFE_94210",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_RUCE927 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_RUCE927', 'cr_producto_FIE', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_RUCE927'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_RUCE927");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: HousingCount
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_GCUN722",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MRDEVVINS_17580",
                haslabelArgs: true,
                format: "##",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: OfficerAnalysisView
            $scope.vc.createViewState({
                id: "VC_EXOSO06_CEASV_620",
                hasId: true,
                componentStyle: "",
                label: 'OfficerAnalysisView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GPOfficerAnalysis
            $scope.vc.createViewState({
                id: "GR_OFICANSSEW26_04",
                hasId: true,
                componentStyle: "",
                label: 'GPOfficerAnalysis',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
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
                observationReprog: $scope.vc.channelDefaultValues("OfficerAnalysis", "observationReprog")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OFICANSSEW26_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: ApplicationNumber
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_APIB151",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PLATONUER_39479",
                label: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: SuggestedAmount
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_SAMN032",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_GGESTEAMT_15655",
                label: "BUSIN.DLB_BUSIN_SGSEDAMNT_58429",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: AmounttoDisburse
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_UNDU035",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_AMOUNTBSE_67188",
                label: "BUSIN.DLB_BUSIN_UNTODISUR_74563",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: Suggestedcurrency
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_SURE913",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_GGSDCURNC_47914",
                label: "BUSIN.DLB_BUSIN_UGECRENCY_17995",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_SURE913 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_SURE913', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_SURE913'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_SURE913");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: ProductType
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_POCT250",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PODUCTTPE_53088",
                label: "BUSIN.DLB_BUSIN_PROUCTTPE_88016",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_POCT250 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_POCT250', 'ca_toperacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_POCT250'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_POCT250");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_TENY472",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TERMKHLPJ_39636",
                label: "BUSIN.DLB_BUSIN_TERMCUWZU_98612",
                haslabelArgs: true,
                format: "###0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: TermFrecuency
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_TERM877",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ECUEYTERM_20622",
                label: "BUSIN.DLB_BUSIN_RUECYTERM_46135",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_TERM877 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_TERM877', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_TERM877'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_TERM877");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: Officer
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_FFCE753",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OFFICERTU_38261",
                label: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: OfficierName
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_OCEC262",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                label: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: Sector
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_SCOR371",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TMERDUSRY_93208",
                label: "BUSIN.DLB_BUSIN_TMERDUSRY_93208",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_SCOR371 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_SCOR371', 'cl_sector_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_SCOR371'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_SCOR371");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: Province
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_PONE992",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                label: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_PONE992 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_PONE992', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_PONE992'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_PONE992");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: SerctorNeg
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_ORNG078",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CREITNSTY_93122",
                label: "BUSIN.DLB_BUSIN_CREITNSTY_93122",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_ORNG078 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_ORNG078', 'cl_sector_neg', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_ORNG078'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_ORNG078");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: City
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_CITY183",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                label: "BUSIN.DLB_BUSIN_CITYAQLIM_46735",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_CITY183 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OFICANSSEW2603_CITY183', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_CITY183'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_CITY183");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: CreditLine
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_CRTN299",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TYPECREIT_29679",
                label: "BUSIN.DLB_BUSIN_CREDITYPE_12941",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_CRTN299 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_CRTN299', 'ca_tipo_cartera', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_CRTN299'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_CRTN299");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: CreditLineValid
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_ETIA407",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OFICANSSEW26_05",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: observationReprog
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2605_BINO138",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EVRRRAMCN_87315",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: Borrower Data
            $scope.vc.createViewState({
                id: "VC_EXOSO06_BOEVW_372",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BORWERDTA_05940",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_BORRWRVIEW27_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: BorrowerGroup
            $scope.vc.createViewState({
                id: "GR_BORRWRVIEW27_83",
                hasId: true,
                componentStyle: "",
                label: 'BorrowerGroup',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DebtorGeneral = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CustomerCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerCode", 0),
                        validation: {
                            CustomerCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    CustomerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerName", '')
                    },
                    Role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Role", '')
                    },
                    TypeDocumentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "TypeDocumentId", '')
                    },
                    Identification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Identification", '')
                    },
                    Qualification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Qualification", '')
                    },
                    DateCIC: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "DateCIC", new Date())
                    }
                }
            });;
            $scope.vc.model.DebtorGeneral = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_BOREGEEL_0798();
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DebtorGeneral',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_BOREG0798_55', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
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
                    model: $scope.vc.types.DebtorGeneral
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_BOREG0798_55").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_BOREGEEL_0798 = $scope.vc.model.DebtorGeneral;
            $scope.vc.trackers.DebtorGeneral = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DebtorGeneral);
            $scope.vc.model.DebtorGeneral.bind('change', function(e) {
                $scope.vc.trackers.DebtorGeneral.track(e);
            });
            $scope.vc.grids.QV_BOREG0798_55 = {};
            $scope.vc.grids.QV_BOREG0798_55.queryId = 'Q_BOREGEEL_0798';
            $scope.vc.viewState.QV_BOREG0798_55 = {
                style: undefined
            };
            $scope.vc.viewState.QV_BOREG0798_55.column = {};
            $scope.vc.grids.QV_BOREG0798_55.events = {
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
                    var index = e.container.find("td > a.k-grid-update").parent().index();
                    if (index != -1) {
                        $scope.vc.changeGridColumnWidth('QV_BOREG0798_55', index, "0px");
                    }
                    $scope.vc.trackers.DebtorGeneral.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_BOREG0798_55.selectedRow = e.model;
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
                    $scope.vc.changeGridColumnWidth('QV_BOREG0798_55', index, "auto");
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'DebtorGeneral',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_BOREG0798_55", args, function() {
                        if (args.cancel) {
                            $("#QV_BOREG0798_55").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    index = grid.element.find("td > span.cb-commands").parent().index();
                    if (index != -1) {
                        $scope.vc.changeGridColumnWidth('QV_BOREG0798_55', index, "0px");
                    }
                    $scope.vc.gridDataBound("QV_BOREG0798_55");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_BOREG0798_55 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_BOREG0798_55 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_BOREG0798_55.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_BOREG0798_55.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode = {
                title: 'BUSIN.DLB_BUSIN_CDIGOZVON_13133',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CUTOMEROD_75260',
                width: 60,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_BORRWRVIEW2783_CUST965',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerCode.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CUTOMEROD_75260'|translate}}",
                        'id': "VA_BORRWRVIEW2783_CUST965",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CDIGOZVON_13133') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.format",
                        'k-decimals': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.decimals",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerCode.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName = {
                title: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_CUST678',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST55 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_NAMEFDOFF_74379'|translate}}",
                        'id': "VA_BORRWRVIEW2783_CUST678",
                        'maxlength': 255,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerName.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Role = {
                title: 'BUSIN.DLB_BUSIN_MANTRYTYP_29149',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_MANTRYTYP_29149',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_ROLE954',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values)) {
                            $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_BORRWRVIEW2783_ROLE954',
                                'cr_cat_deudor',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_BORRWRVIEW2783_ROLE954'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_ROLE954");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_ROLE954");
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
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ROLE73 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Role.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_MANTRYTYP_29149'|translate}}",
                        'id': "VA_BORRWRVIEW2783_ROLE954",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.Role.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_BORRWRVIEW2783_ROLE954",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.Role.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Role.validationCode}}",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'k-on-change': "vc.change(kendoEvent,'VA_BORRWRVIEW2783_ROLE954',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_BORRWRVIEW2783_ROLE954',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId = {
                title: 'BUSIN.DLB_BUSIN_TIPOOMETO_33623',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_TIPOOMETO_33623',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_DOTD256',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values)) {
                            $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_BORRWRVIEW2783_DOTD256',
                                'cl_tipo_documento',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_BORRWRVIEW2783_DOTD256'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_DOTD256");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_DOTD256");
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
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DOTD15 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_TIPOOMETO_33623'|translate}}",
                        'id': "VA_BORRWRVIEW2783_DOTD256",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_BORRWRVIEW2783_DOTD256",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.validationCode}}",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'k-on-change': "vc.change(kendoEvent,'VA_BORRWRVIEW2783_DOTD256',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_BORRWRVIEW2783_DOTD256',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Identification = {
                title: 'BUSIN.DLB_BUSIN_IFICTNBER_84824',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_IFICTNBER_84824',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_IDEN901',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342IDEN84 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Identification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_IFICTNBER_84824'|translate}}",
                        'id': "VA_BORRWRVIEW2783_IDEN901",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Identification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Identification.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Identification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Qualification = {
                title: 'BUSIN.DLB_BUSIN_CALIFCAIN_39502',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CALIFCAIN_39502',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_UALN736',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342UALN46 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Qualification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CALIFCAIN_39502'|translate}}",
                        'id': "VA_BORRWRVIEW2783_UALN736",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Qualification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Qualification.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Qualification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC = {
                title: 'BUSIN.DLB_BUSIN_FECHACICY_04196',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_DTCC540',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DTCC73 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.DateCIC.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_BORRWRVIEW2783_DTCC540",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.DateCIC.validationCode}}",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.DateCIC.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'CustomerCode',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.title|translate:vc.viewState.QV_BOREG0798_55.column.CustomerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST03.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerCode.element[dataItem.uid].style' ng-bind='kendo.toString(#=CustomerCode#, vc.viewState.QV_BOREG0798_55.column.CustomerCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.CustomerCode.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'CustomerName',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.CustomerName.title|translate:vc.viewState.QV_BOREG0798_55.column.CustomerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST55.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerName.element[dataItem.uid].style'>#if (CustomerName !== null) {# #=CustomerName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.CustomerName.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Role',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.Role.title|translate:vc.viewState.QV_BOREG0798_55.column.Role.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Role.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Role.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ROLE73.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Role.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_BORRWRVIEW2783_ROLE954.get(dataItem.Role).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Role.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'TypeDocumentId',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.title|translate:vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DOTD15.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_BORRWRVIEW2783_DOTD256.get(dataItem.TypeDocumentId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Identification',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.Identification.title|translate:vc.viewState.QV_BOREG0798_55.column.Identification.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342IDEN84.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Identification.element[dataItem.uid].style'>#if (Identification !== null) {# #=Identification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Identification.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Identification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Qualification',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.Qualification.title|translate:vc.viewState.QV_BOREG0798_55.column.Qualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342UALN46.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Qualification.element[dataItem.uid].style'>#if (Qualification !== null) {# #=Qualification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Qualification.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Qualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'DateCIC',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.DateCIC.title|translate:vc.viewState.QV_BOREG0798_55.column.DateCIC.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_BOREG0798_55', 'DateCIC', $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DTCC73.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_BOREG0798_55', 'DateCIC'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.DateCIC.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.DateCIC.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.hidden
                });
            }
            $scope.vc.grids.QV_BOREG0798_55.columns.push({
                command: {
                    template: "<span class='cb-commands'></span>"
                },
                attributes: {
                    "class": "btn-toolbar"
                },
                width: 1
            });
            $scope.vc.viewState.QV_BOREG0798_55.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                },
                CEQV_201_QV_BOREG0798_55_719: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_BOREG0798_55.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_BOREG0798_55.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_BORRWRVIEW27_83.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }, {
                "name": "CEQV_201_QV_BOREG0798_55_719",
                "text": "{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}",
                "template": "<button id='CEQV_201_QV_BOREG0798_55_719' ng-if='vc.viewState.QV_BOREG0798_55.toolbar.CEQV_201_QV_BOREG0798_55_719.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_BOREG0798_55_719\",\"DebtorGeneral\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand' title=\"{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}\"> #: text #</button>"
            }]; //ViewState - Container: [TAB]
            $scope.vc.createViewState({
                id: "VC_EXOSO06_TABMD_007",
                hasId: true,
                componentStyle: "",
                label: '[TAB]',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ExpromissionOperationView
            $scope.vc.createViewState({
                id: "VC_EXOSO06_EFIPE_206",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OCSDXPMIN_54556",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor de Pestañas
            $scope.vc.createViewState({
                id: "GR_POMSSOEATO98_12",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor de Pesta\u00f1as',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Pestaña para RefinancingOperations
            $scope.vc.createViewState({
                id: "GR_POMSSOEATO98_11",
                hasId: true,
                componentStyle: "",
                label: 'Pesta\u00f1a para RefinancingOperations',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RefinancingOperations = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    IsBase: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "IsBase", false)
                    },
                    IdOperation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "IdOperation", '')
                    },
                    OperationBank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OperationBank", '')
                    },
                    RefinancingOption: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "RefinancingOption", '')
                    },
                    CurrencyOperation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "CurrencyOperation", 0)
                    },
                    Balance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "Balance", 0)
                    },
                    LocalCurrencyBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "LocalCurrencyBalance", 0)
                    },
                    OriginalAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OriginalAmount", 0)
                    },
                    LocalCurrencyAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "LocalCurrencyAmount", 0)
                    },
                    CreditType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "CreditType", '')
                    },
                    InternalCustomerClassification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "InternalCustomerClassification", '')
                    },
                    OperationQualification: {
                        type: "string",
                        editable: true
                    },
                    DateGranting: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "DateGranting", '')
                    },
                    PayoutPercentage: {
                        type: "number",
                        editable: true
                    },
                    oficialOperation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "oficialOperation", 0)
                    },
                    Rate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "Rate", 0)
                    }
                }
            });;
            $scope.vc.model.RefinancingOperations = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_ITRICNAN_1523();
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
                    model: $scope.vc.types.RefinancingOperations
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_ITRIC1523_37").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ITRICNAN_1523 = $scope.vc.model.RefinancingOperations;
            $scope.vc.trackers.RefinancingOperations = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RefinancingOperations);
            $scope.vc.model.RefinancingOperations.bind('change', function(e) {
                $scope.vc.trackers.RefinancingOperations.track(e);
            });
            $scope.vc.grids.QV_ITRIC1523_37 = {};
            $scope.vc.grids.QV_ITRIC1523_37.queryId = 'Q_ITRICNAN_1523';
            $scope.vc.viewState.QV_ITRIC1523_37 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column = {};
            $scope.vc.grids.QV_ITRIC1523_37.events = {
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
                    $scope.vc.trackers.RefinancingOperations.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_ITRIC1523_37.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_ITRIC1523_37");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_ITRIC1523_37.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_ITRIC1523_37.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_ITRIC1523_37.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_ITRIC1523_37 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_ITRIC1523_37 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_ITRIC1523_37.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_ITRIC1523_37.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_ITRIC1523_37.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "RefinancingOperations",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_ITRIC1523_37", args);
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
            $scope.vc.grids.QV_ITRIC1523_37.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ITRIC1523_37.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ITRIC1523_37.column.IsBase = {
                title: 'BUSIN.DLB_BUSIN_SELECIOAR_14656',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_SIAL925',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459SIAL87 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.IsBase.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_SIAL925",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.IsBase.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.IsBase.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.IsBase.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.IdOperation = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_DPER235',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459DPER71 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.IdOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_POMSSOEATO9811_DPER235",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.IdOperation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.IdOperation.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.IdOperation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.OperationBank = {
                title: 'BUSIN.DLB_BUSIN_OPEIONBER_32159',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_EANA185',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459EANA92 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.OperationBank.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_EANA185",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.OperationBank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.OperationBank.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.OperationBank.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.RefinancingOption = {
                title: 'BUSIN.DLB_BUSIN_RFNANIPTN_49588',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_ANOP948',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_POMSSOEATO9811_ANOP948 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_POMSSOEATO9811_ANOP948_values)) {
                            $scope.vc.catalogs.VA_POMSSOEATO9811_ANOP948_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_POMSSOEATO9811_ANOP948',
                                'cr_opcion_refinan',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_POMSSOEATO9811_ANOP948'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_POMSSOEATO9811_ANOP948_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_37", "VA_POMSSOEATO9811_ANOP948");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_POMSSOEATO9811_ANOP948_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_37", "VA_POMSSOEATO9811_ANOP948");
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
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459ANOP06 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_ANOP948",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_POMSSOEATO9811_ANOP948",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.validationCode}}",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation = {
                title: 'BUSIN.DLB_BUSIN_MONEDAWDW_15876',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_CURA790',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_POMSSOEATO9811_CURA790 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_POMSSOEATO9811_CURA790_values)) {
                            $scope.vc.catalogs.VA_POMSSOEATO9811_CURA790_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_POMSSOEATO9811_CURA790',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_POMSSOEATO9811_CURA790'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_POMSSOEATO9811_CURA790_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_37", "VA_POMSSOEATO9811_CURA790");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_POMSSOEATO9811_CURA790_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_37", "VA_POMSSOEATO9811_CURA790");
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
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459CURA87 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_CURA790",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_POMSSOEATO9811_CURA790",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.validationCode}}",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.Balance = {
                title: 'BUSIN.DLB_BUSIN_BALANCESI_24039',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_BANC168',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459BANC23 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.Balance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_BANC168",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.Balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_37.column.Balance.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_37.column.Balance.decimals",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.Balance.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.Balance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance = {
                title: 'BUSIN.DLB_BUSIN_LORRNYANE_43671',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_OCBA749',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459OCBA30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_OCBA749",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.decimals",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.OriginalAmount = {
                title: 'BUSIN.DLB_BUSIN_ORILAMOUN_89859',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_GAMO217',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459GAMO94 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_GAMO217",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.decimals",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount = {
                title: 'BUSIN.DLB_BUSIN_MOTLOCENC_66188',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_RNUN987',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459RNUN43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_RNUN987",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.decimals",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.CreditType = {
                title: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_EITY479',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_POMSSOEATO9811_EITY479 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_POMSSOEATO9811_EITY479_values)) {
                            $scope.vc.catalogs.VA_POMSSOEATO9811_EITY479_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_POMSSOEATO9811_EITY479',
                                'ca_toperacion',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_POMSSOEATO9811_EITY479'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_POMSSOEATO9811_EITY479_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_37", "VA_POMSSOEATO9811_EITY479");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_POMSSOEATO9811_EITY479_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_37", "VA_POMSSOEATO9811_EITY479");
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
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459EITY95 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.CreditType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_EITY479",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_37.column.CreditType.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_POMSSOEATO9811_EITY479",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_37.column.CreditType.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.CreditType.validationCode}}",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification = {
                title: 'BUSIN.DLB_BUSIN_INATOIATO_87203',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_NAIC743',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459NAIC57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_NAIC743",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.OperationQualification = {
                title: 'OperationQualification',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459EATI72 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 10,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.OperationQualification.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.OperationQualification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.DateGranting = {
                title: 'BUSIN.DLB_BUSIN_ATEGRANTN_55879',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_DTGN947',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459DTGN73 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.DateGranting.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_POMSSOEATO9811_DTGN947",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.DateGranting.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.DateGranting.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.DateGranting.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage = {
                title: 'PayoutPercentage',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459PEEE15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 5,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.oficialOperation = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_AORN680',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459AORN87 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.oficialOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_POMSSOEATO9811_AORN680",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.oficialOperation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_37.column.oficialOperation.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_37.column.oficialOperation.decimals",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.oficialOperation.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.oficialOperation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_37.column.Rate = {
                title: 'BUSIN.DLB_BUSIN_TASAGRLAC_24263',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_TASAGRLAC_24263',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_POMSSOEATO9811_RATE379',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459RATE39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.Rate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_TASAGRLAC_24263'|translate}}",
                        'id': "VA_POMSSOEATO9811_RATE379",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_37.column.Rate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_37.column.Rate.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_37.column.Rate.decimals",
                        'data-cobis-group': "Group,GR_POMSSOEATO98_12,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_37.column.Rate.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_37.column.Rate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'IsBase',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.IsBase.title|translate:vc.viewState.QV_ITRIC1523_37.column.IsBase.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.IsBase.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.IsBase.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459SIAL87.control,
                    template: "<input name='IsBase' type='checkbox' value='#=IsBase#' #=IsBase?checked='checked':''# disabled='disabled' data-bind='value:IsBase' ng-class='vc.viewState.QV_ITRIC1523_37.column.IsBase.element[dataItem.uid].style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.IsBase.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.IsBase.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.IsBase.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'IdOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.IdOperation.title|translate:vc.viewState.QV_ITRIC1523_37.column.IdOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.IdOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.IdOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459DPER71.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.IdOperation.element[dataItem.uid].style'>#if (IdOperation !== null) {# #=IdOperation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.IdOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.IdOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.IdOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'OperationBank',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.OperationBank.title|translate:vc.viewState.QV_ITRIC1523_37.column.OperationBank.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.OperationBank.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.OperationBank.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459EANA92.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.OperationBank.element[dataItem.uid].style'>#if (OperationBank !== null) {# #=OperationBank# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.OperationBank.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.OperationBank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.OperationBank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'RefinancingOption',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.title|translate:vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459ANOP06.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_POMSSOEATO9811_ANOP948.get(dataItem.RefinancingOption).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.RefinancingOption.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'CurrencyOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.title|translate:vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459CURA87.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_POMSSOEATO9811_CURA790.get(dataItem.CurrencyOperation).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.CurrencyOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'Balance',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.Balance.title|translate:vc.viewState.QV_ITRIC1523_37.column.Balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.Balance.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.Balance.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459BANC23.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.Balance.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance#, vc.viewState.QV_ITRIC1523_37.column.Balance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.Balance.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.Balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.Balance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'LocalCurrencyBalance',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.title|translate:vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459OCBA30.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=LocalCurrencyBalance#, vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'OriginalAmount',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.title|translate:vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459GAMO94.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=OriginalAmount#, vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.OriginalAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'LocalCurrencyAmount',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.title|translate:vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459RNUN43.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=LocalCurrencyAmount#, vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.LocalCurrencyAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'CreditType',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.CreditType.title|translate:vc.viewState.QV_ITRIC1523_37.column.CreditType.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.CreditType.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.CreditType.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459EITY95.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.CreditType.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_POMSSOEATO9811_EITY479.get(dataItem.CreditType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.CreditType.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.CreditType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.CreditType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'InternalCustomerClassification',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.title|translate:vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459NAIC57.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.element[dataItem.uid].style'>#if (InternalCustomerClassification !== null) {# #=InternalCustomerClassification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.InternalCustomerClassification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'OperationQualification',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.OperationQualification.title|translate:vc.viewState.QV_ITRIC1523_37.column.OperationQualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.OperationQualification.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.OperationQualification.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459EATI72.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.OperationQualification.element[dataItem.uid].style'>#if (OperationQualification !== null) {# #=OperationQualification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.OperationQualification.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.OperationQualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.OperationQualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'DateGranting',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.DateGranting.title|translate:vc.viewState.QV_ITRIC1523_37.column.DateGranting.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.DateGranting.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.DateGranting.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459DTGN73.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.DateGranting.element[dataItem.uid].style'>#if (DateGranting !== null) {# #=DateGranting# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.DateGranting.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.DateGranting.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.DateGranting.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'PayoutPercentage',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.title|translate:vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459PEEE15.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.element[dataItem.uid].style' ng-bind='kendo.toString(#=PayoutPercentage#, vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.PayoutPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'oficialOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.oficialOperation.title|translate:vc.viewState.QV_ITRIC1523_37.column.oficialOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.oficialOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.oficialOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459AORN87.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.oficialOperation.element[dataItem.uid].style' ng-bind='kendo.toString(#=oficialOperation#, vc.viewState.QV_ITRIC1523_37.column.oficialOperation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.oficialOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.oficialOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.oficialOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_37.columns.push({
                    field: 'Rate',
                    title: '{{vc.viewState.QV_ITRIC1523_37.column.Rate.title|translate:vc.viewState.QV_ITRIC1523_37.column.Rate.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_37.column.Rate.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_37.column.Rate.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_37.AT_RNA459RATE39.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_37.column.Rate.element[dataItem.uid].style' ng-bind='kendo.toString(#=Rate#, vc.viewState.QV_ITRIC1523_37.column.Rate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_37.column.Rate.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_37.column.Rate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_37.column.Rate.hidden
                });
            }
            $scope.vc.viewState.QV_ITRIC1523_37.toolbar = {
                CEQV_201_QV_ITRIC1523_37_807: {
                    visible: true
                },
                CEQV_201_QV_ITRIC1523_37_856: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_ITRIC1523_37.toolbar = [{
                "name": "CEQV_201_QV_ITRIC1523_37_807",
                "text": "{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}",
                "template": "<button id='CEQV_201_QV_ITRIC1523_37_807' ng-if='vc.viewState.QV_ITRIC1523_37.toolbar.CEQV_201_QV_ITRIC1523_37_807.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_ITRIC1523_37_807\",\"RefinancingOperations\")' class='btn btn-default cb-grid-button cb-btn-custom-cmdnew' title=\"{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}\"> #: text #</button>"
            }, {
                "name": "CEQV_201_QV_ITRIC1523_37_856",
                "text": "{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}",
                "template": "<button id='CEQV_201_QV_ITRIC1523_37_856' ng-if='vc.viewState.QV_ITRIC1523_37.toolbar.CEQV_201_QV_ITRIC1523_37_856.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_ITRIC1523_37_856\",\"RefinancingOperations\")' class='btn btn-default cb-grid-button cb-btn-custom-cmddelete' title=\"{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}\"> #: text #</button>"
            }]; //ViewState - Container: CreditOtherDataOlnyView
            $scope.vc.createViewState({
                id: "VC_EXOSO06_ERONV_022",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OTHERDATA_97873",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_RDIHONLYVE38_20",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CreditOtherData = {
                CreditPorpuse: $scope.vc.channelDefaultValues("CreditOtherData", "CreditPorpuse"),
                CreditDestination: $scope.vc.channelDefaultValues("CreditOtherData", "CreditDestination"),
                SourceOfFunding: $scope.vc.channelDefaultValues("CreditOtherData", "SourceOfFunding"),
                EconomicActivityCredit: $scope.vc.channelDefaultValues("CreditOtherData", "EconomicActivityCredit"),
                ActivityDestinationCredit: $scope.vc.channelDefaultValues("CreditOtherData", "ActivityDestinationCredit"),
                DescriptionDestinationRequested: $scope.vc.channelDefaultValues("CreditOtherData", "DescriptionDestinationRequested"),
                CreditDestinationValue: $scope.vc.channelDefaultValues("CreditOtherData", "CreditDestinationValue")
            };
            //ViewState - Group: Panel Plegable para CreditOtherData
            $scope.vc.createViewState({
                id: "GR_RDIHONLYVE38_02",
                hasId: true,
                componentStyle: "",
                label: 'Panel Plegable para CreditOtherData',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CreditOtherData, Attribute: ActivityDestinationCredit
            $scope.vc.createViewState({
                id: "VA_RDIHONLYVE3802_TATT187",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ISACTIVTY_63441",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RDIHONLYVE3802_TATT187 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RDIHONLYVE3802_TATT187', 'cl_actividad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RDIHONLYVE3802_TATT187'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RDIHONLYVE3802_TATT187");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CreditOtherData, Attribute: CreditPorpuse
            $scope.vc.createViewState({
                id: "VA_RDIHONLYVE3802_RPPU462",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CREDIPUSE_23520",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RDIHONLYVE3802_RPPU462 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RDIHONLYVE3802_RPPU462', 'cr_objeto', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RDIHONLYVE3802_RPPU462'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RDIHONLYVE3802_RPPU462");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CreditOtherData, Attribute: CreditDestination
            $scope.vc.createViewState({
                id: "VA_RDIHONLYVE3802_RDTN079",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TYETNCRED_24143",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RDIHONLYVE3802_RDTN079 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RDIHONLYVE3802_RDTN079', 'cl_actividad_ec', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RDIHONLYVE3802_RDTN079'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RDIHONLYVE3802_RDTN079");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CreditOtherData, Attribute: SourceOfFunding
            $scope.vc.createViewState({
                id: "VA_RDIHONLYVE3802_OUED176",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FETEFIMIO_08044",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RDIHONLYVE3802_OUED176 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RDIHONLYVE3802_OUED176', 'ca_origen_fondo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RDIHONLYVE3802_OUED176'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RDIHONLYVE3802_OUED176");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CreditOtherData, Attribute: EconomicActivityCredit
            $scope.vc.createViewState({
                id: "VA_RDIHONLYVE3802_NCRI218",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CreditOtherData, Attribute: DescriptionDestinationRequested
            $scope.vc.createViewState({
                id: "VA_RDIHONLYVE3802_DSNS328",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CRIATVITY_63237",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: FuentedeIngresosCliente
            $scope.vc.createViewState({
                id: "VC_EXOSO06_EIRIE_013",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FUENTEDLI_58290",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Fuente de Ingresos Cliente
            $scope.vc.createViewState({
                id: "GR_UETDINECET49_02",
                hasId: true,
                componentStyle: "",
                label: 'Fuente de Ingresos Cliente',
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
                    Clarification: {
                        type: "string",
                        editable: true
                    },
                    descriptionActivity: {
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
                        editable: true
                    }
                }
            });;
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
                title: 'BUSIN.DLB_BUSIN_CUTOMEROD_75260',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "##########",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_UETDINECET4902_DCLN211',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755DCLN75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.IdClient.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_UETDINECET4902_DCLN211",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CUTOMEROD_75260') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.IdClient.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_RURCE2364_74.column.IdClient.format",
                        'k-decimals': "vc.viewState.QV_RURCE2364_74.column.IdClient.decimals",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_UETDINECET4902_ROLU565',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_UETDINECET4902_ROLU565 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_UETDINECET4902_ROLU565_values)) {
                            $scope.vc.catalogs.VA_UETDINECET4902_ROLU565_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_UETDINECET4902_ROLU565',
                                'cr_cat_deudor',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_UETDINECET4902_ROLU565'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_UETDINECET4902_ROLU565_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_ROLU565");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_UETDINECET4902_ROLU565_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_ROLU565");
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
                        'id': "VA_UETDINECET4902_ROLU565",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.Rol.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_UETDINECET4902_ROLU565",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.Rol.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ROLEVJMGD_53686') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Rol.validationCode}}",
                        'dsgrequired': "",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_UETDINECET4902_TYPE628',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755TYPE77 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_UETDINECET4902_TYPE628",
                        'maxlength': 4,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TYPEYLJIK_10770') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_UETDINECET4902_SCOR924',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_UETDINECET4902_SCOR924 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_UETDINECET4902_SCOR924_values)) {
                            $scope.vc.catalogs.VA_UETDINECET4902_SCOR924_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_UETDINECET4902_SCOR924',
                                'cl_sector_economico',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_UETDINECET4902_SCOR924'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_UETDINECET4902_SCOR924_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_SCOR924");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_UETDINECET4902_SCOR924_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_SCOR924");
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
                        'id': "VA_UETDINECET4902_SCOR924",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.Sector.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_UETDINECET4902_SCOR924",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.Sector.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_WUIWWCGVG_35342') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Sector.validationCode}}",
                        'dsgrequired': "",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_UETDINECET4902_STOR680',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_UETDINECET4902_STOR680 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_UETDINECET4902_STOR680_values)) {
                            $scope.vc.catalogs.VA_UETDINECET4902_STOR680_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_UETDINECET4902_STOR680',
                                'cl_subsector_ec',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_UETDINECET4902_STOR680'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_UETDINECET4902_STOR680_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_STOR680");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_UETDINECET4902_STOR680_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_STOR680");
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
                        'id': "VA_UETDINECET4902_STOR680",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.SubSector.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_UETDINECET4902_STOR680",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.SubSector.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_SSECTCTID_26184') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.SubSector.validationCode}}",
                        'dsgrequired': "",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_UETDINECET4902_OCIT955',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_UETDINECET4902_OCIT955 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_UETDINECET4902_OCIT955_values)) {
                            $scope.vc.catalogs.VA_UETDINECET4902_OCIT955_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_UETDINECET4902_OCIT955',
                                'cl_actividad_ec',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_UETDINECET4902_OCIT955'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_UETDINECET4902_OCIT955_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_OCIT955");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_UETDINECET4902_OCIT955_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_UETDINECET4902_OCIT955");
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
                        'id': "VA_UETDINECET4902_OCIT955",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.EconomicActivity.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_UETDINECET4902_OCIT955",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.EconomicActivity.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TIVDECOIA_60481') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.EconomicActivity.validationCode}}",
                        'dsgrequired': "",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
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
            $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity = {
                title: 'BUSIN.DLB_BUSIN_ESIELATII_72943',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755ATVY95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.descriptionActivity.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.descriptionActivity.element['" + options.model.uid + "'].style"
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
                title: 'subActividadEconomica',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
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
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Rol.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_UETDINECET4902_ROLU565.get(dataItem.Rol).value'> </span>",
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
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Sector.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_UETDINECET4902_SCOR924.get(dataItem.Sector).value'> </span>",
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
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.SubSector.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_UETDINECET4902_STOR680.get(dataItem.SubSector).value'> </span>",
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
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.EconomicActivity.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_UETDINECET4902_OCIT955.get(dataItem.EconomicActivity).value'> </span>",
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
            $scope.vc.viewState.QV_RURCE2364_74.toolbar = {}
            $scope.vc.grids.QV_RURCE2364_74.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_97_EXOSO06_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_97_EXOSO06_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Save
            $scope.vc.createViewState({
                id: "CM_EXOSO06SVE84",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PRINTNQCA_63767",
                label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Print
            $scope.vc.createViewState({
                id: "CM_EXOSO06PRN39",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PRINTNQCA_63767",
                label: "BUSIN.DLB_BUSIN_PRINTNQCA_63767",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: SaveInfocred
            $scope.vc.createViewState({
                id: "CM_EXOSO06VEI89",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ESRARINOD_66891",
                label: "BUSIN.DLB_BUSIN_ESRARINOD_66891",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: ReportInfocred
            $scope.vc.createViewState({
                id: "CM_EXOSO06NOD61",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PTEIOCRED_97562",
                label: "BUSIN.DLB_BUSIN_PTEIOCRED_97562",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.InfocredHeader = {
                CustomerId: $scope.vc.channelDefaultValues("InfocredHeader", "CustomerId"),
                CustomerName: $scope.vc.channelDefaultValues("InfocredHeader", "CustomerName"),
                ExpirationDate: $scope.vc.channelDefaultValues("InfocredHeader", "ExpirationDate"),
                Count: $scope.vc.channelDefaultValues("InfocredHeader", "Count"),
                AssociateTo: $scope.vc.channelDefaultValues("InfocredHeader", "AssociateTo"),
                ExistsLoanId: $scope.vc.channelDefaultValues("InfocredHeader", "ExistsLoanId"),
                AssociateWith: $scope.vc.channelDefaultValues("InfocredHeader", "AssociateWith"),
                NewLoanId: $scope.vc.channelDefaultValues("InfocredHeader", "NewLoanId"),
                NewRequestId: $scope.vc.channelDefaultValues("InfocredHeader", "NewRequestId"),
                NewLoanCode: $scope.vc.channelDefaultValues("InfocredHeader", "NewLoanCode"),
                Role: $scope.vc.channelDefaultValues("InfocredHeader", "Role"),
                Out_HasManySimilar: $scope.vc.channelDefaultValues("InfocredHeader", "Out_HasManySimilar"),
                Out_SimilarList: $scope.vc.channelDefaultValues("InfocredHeader", "Out_SimilarList"),
                Out_Source: $scope.vc.channelDefaultValues("InfocredHeader", "Out_Source"),
                Out_Role: $scope.vc.channelDefaultValues("InfocredHeader", "Out_Role"),
                Out_RequestIdLoanId: $scope.vc.channelDefaultValues("InfocredHeader", "Out_RequestIdLoanId")
            };
            $scope.vc.model.LineHeader = {
                Rotary: $scope.vc.channelDefaultValues("LineHeader", "Rotary"),
                Committed: $scope.vc.channelDefaultValues("LineHeader", "Committed"),
                AmountProposed: $scope.vc.channelDefaultValues("LineHeader", "AmountProposed"),
                CurrencyProposed: $scope.vc.channelDefaultValues("LineHeader", "CurrencyProposed"),
                EntryDate: $scope.vc.channelDefaultValues("LineHeader", "EntryDate"),
                ExpirationDate: $scope.vc.channelDefaultValues("LineHeader", "ExpirationDate"),
                Officer: $scope.vc.channelDefaultValues("LineHeader", "Officer"),
                Sector: $scope.vc.channelDefaultValues("LineHeader", "Sector"),
                Province: $scope.vc.channelDefaultValues("LineHeader", "Province"),
                GeograohicDestination: $scope.vc.channelDefaultValues("LineHeader", "GeograohicDestination"),
                officerName: $scope.vc.channelDefaultValues("LineHeader", "officerName"),
                AmountLocalCurrency: $scope.vc.channelDefaultValues("LineHeader", "AmountLocalCurrency"),
                Number: $scope.vc.channelDefaultValues("LineHeader", "Number"),
                Term: $scope.vc.channelDefaultValues("LineHeader", "Term"),
                CreditCode: $scope.vc.channelDefaultValues("LineHeader", "CreditCode"),
                AmountUsed: $scope.vc.channelDefaultValues("LineHeader", "AmountUsed"),
                AvailableAmount: $scope.vc.channelDefaultValues("LineHeader", "AvailableAmount"),
                OfficeCode: $scope.vc.channelDefaultValues("LineHeader", "OfficeCode"),
                CityCode: $scope.vc.channelDefaultValues("LineHeader", "CityCode"),
                Code: $scope.vc.channelDefaultValues("LineHeader", "Code"),
                NumberTestimony: $scope.vc.channelDefaultValues("LineHeader", "NumberTestimony"),
                MaximunQuoteLine: $scope.vc.channelDefaultValues("LineHeader", "MaximunQuoteLine"),
                MaximunQuote: $scope.vc.channelDefaultValues("LineHeader", "MaximunQuote")
            };
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
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_0000908.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_ITCE121.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_URQT595.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_NQUE773.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_XSIN642.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_AONN156.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_PEOE356.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_EVAL957.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_REET975.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_EIEA610.read();
                    $scope.vc.catalogs.VA_ORIAHEADER8602_RUCE927.read();
                    $scope.vc.catalogs.VA_OFICANSSEW2603_SURE913.read();
                    $scope.vc.catalogs.VA_OFICANSSEW2603_POCT250.read();
                    $scope.vc.catalogs.VA_OFICANSSEW2603_TERM877.read();
                    $scope.vc.catalogs.VA_OFICANSSEW2603_SCOR371.read();
                    $scope.vc.catalogs.VA_OFICANSSEW2603_PONE992.read();
                    $scope.vc.catalogs.VA_OFICANSSEW2603_ORNG078.read();
                    $scope.vc.catalogs.VA_OFICANSSEW2603_CRTN299.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256.read();
                    $scope.vc.catalogs.VA_POMSSOEATO9811_ANOP948.read();
                    $scope.vc.catalogs.VA_POMSSOEATO9811_CURA790.read();
                    $scope.vc.catalogs.VA_POMSSOEATO9811_EITY479.read();
                    $scope.vc.catalogs.VA_RDIHONLYVE3802_TATT187.read();
                    $scope.vc.catalogs.VA_RDIHONLYVE3802_RPPU462.read();
                    $scope.vc.catalogs.VA_RDIHONLYVE3802_RDTN079.read();
                    $scope.vc.catalogs.VA_RDIHONLYVE3802_OUED176.read();
                    $scope.vc.catalogs.VA_UETDINECET4902_ROLU565.read();
                    $scope.vc.catalogs.VA_UETDINECET4902_SCOR924.read();
                    $scope.vc.catalogs.VA_UETDINECET4902_STOR680.read();
                    $scope.vc.catalogs.VA_UETDINECET4902_OCIT955.read();
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
                $scope.vc.render('VC_EXOSO06_ROSIO_144');
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
    var cobisMainModule = cobis.createModule("VC_EXOSO06_ROSIO_144", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_EXOSO06_ROSIO_144", {
            templateUrl: "VC_EXOSO06_ROSIO_144_FORM.html",
            controller: "VC_EXOSO06_ROSIO_144_CTRL",
            labelId: "BUSIN.DLB_BUSIN_SLIITDMII_00328",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_EXOSO06_ROSIO_144?" + $.param(search);
            }
        });
        VC_EXOSO06_ROSIO_144(cobisMainModule);
    }]);
} else {
    VC_EXOSO06_ROSIO_144(cobisMainModule);
}