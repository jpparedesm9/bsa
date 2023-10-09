<!-- Designer Generator v 5.1.0.1602 - release SPR 2016-02 05/02/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.quotavsavailablebalancemodifylc = designerEvents.api.quotavsavailablebalancemodifylc || designer.dsgEvents();

function VC_AALAC85_OVBAF_912(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_AALAC85_OVBAF_912_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_AALAC85_OVBAF_912_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_36_AALAC85",
            taskVersion: "1.0.0",
            viewContainerId: "VC_AALAC85_OVBAF_912",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_36_AALAC85",
        designerEvents.api.quotavsavailablebalancemodifylc,
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
                vcName: 'VC_AALAC85_OVBAF_912'
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
                    taskId: 'T_FLCRE_36_AALAC85',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    LineHeader: "LineHeader",
                    PaymentCapacityHeader: "PaymentCapacityHeader",
                    SourceRevenueCustomer: "SourceRevenueCustomer",
                    Context: "Context",
                    ValidationQuotaVsAvailableBalance: "ValidationQuotaVsAvailableBalance",
                    IndexSizeActivity: "IndexSizeActivity",
                    CreditOtherData: "CreditOtherData",
                    VariableData: "VariableData",
                    QueryCentral: "QueryCentral",
                    InfocredHeader: "InfocredHeader",
                    DebtorGeneral: "DebtorGeneral",
                    DistributionLine: "DistributionLine",
                    OriginalHeader: "OriginalHeader",
                    Flag: "Flag",
                    FeeRate: "FeeRate",
                    PaymentCapacity: "PaymentCapacity"
                },
                entities: {
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
                    PaymentCapacityHeader: {
                        PeriodGrace: 'AT_AYE293PEIO73',
                        StartMonth: 'AT_AYE293ARTM76',
                        CountTerm: 'AT_AYE293OUTM83',
                        ValidationSuccess: 'AT_AYE293VTSS51',
                        Status: 'AT_AYE293SATU60',
                        _pks: [],
                        _entityId: 'EN_AYENTACTE293',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    SourceRevenueCustomer: {
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
                    ValidationQuotaVsAvailableBalance: {
                        MaximumQuota: 'AT_VLO560MAMU71',
                        MaximumQuotaLine: 'AT_VLO560IULI79',
                        Rate: 'AT_VLO560RATE75',
                        Term: 'AT_VLO560TERM63',
                        SumQuota: 'AT_VLO560UMUA12',
                        _pks: [],
                        _entityId: 'EN_VLOAEAACE560',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    IndexSizeActivity: {
                        Patrimony: 'AT_NXI784ATRN01',
                        Sales: 'AT_NXI784SALE78',
                        PersonalNumber: 'AT_NXI784PESL28',
                        IndexSizeActivity: 'AT_NXI784NEIY03',
                        AnnualSales: 'AT_NXI784NULE21',
                        ProductiveAssets: 'AT_NXI784RCIE94',
                        ParameterFixedIncome: 'AT_NXI784IXDO09',
                        BtnCalculate: 'AT_NXI784TLAT16',
                        sizeCompany: 'AT_NXI784SECY11',
                        _pks: [],
                        _entityId: 'EN_NXIZECVIY784',
                        _entityVersion: '1.0.0',
                        _transient: true
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
                    VariableData: {
                        IdFieldVariableData: 'AT_ARI489IIEL95',
                        Field: 'AT_ARI489FIEL33',
                        Value: 'AT_ARI489VALU09',
                        Mandatory: 'AT_ARI489MARY62',
                        Type: 'AT_ARI489TYPE13',
                        _pks: [],
                        _entityId: 'EN_ARIABLETA489',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    QueryCentral: {
                        ReportMonthCIC: 'AT_UEC063OTHC87',
                        ReportMonthINFOCRED: 'AT_UEC063MICE66',
                        LevelIndebtedness: 'AT_UEC063EDNE07',
                        _pks: [],
                        _entityId: 'EN_UECENTRAL063',
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
                    },
                    DistributionLine: {
                        CreditType: 'AT_STR478RITT46',
                        Currency: 'AT_STR478CUCY65',
                        AmountProposed: 'AT_STR478AONO09',
                        Quote: 'AT_STR478QOTE39',
                        AmountLocalCurrency: 'AT_STR478AREN75',
                        Module: 'AT_STR478MODL65',
                        _pks: [],
                        _entityId: 'EN_STRIIOINE478',
                        _entityVersion: '1.0.0',
                        _transient: false
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
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Flag: {
                        flag: 'AT_FLA641FLAG90',
                        _pks: [],
                        _entityId: 'EN_FLAGDMKRN641',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    FeeRate: {
                        costCategory: 'AT_FEE359CCGR75',
                        factorFrom: 'AT_FEE359FCTO00',
                        factorTo: 'AT_FEE359FORO90',
                        percentage: 'AT_FEE359RCEE53',
                        percentageNew: 'AT_FEE359PRNT92',
                        maxValue: 'AT_FEE359ALUE11',
                        minValue: 'AT_FEE359NALE71',
                        commission: 'AT_FEE359MION60',
                        currency: 'AT_FEE359CURE55',
                        minimum: 'AT_FEE359IMUM30',
                        currencyValueMin: 'AT_FEE359ECUE75',
                        currencyValueMax: 'AT_FEE359NVLX91',
                        _pks: [],
                        _entityId: 'EN_FEERATEXR359',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentCapacity: {
                        CustomerID: 'AT_AEN625CORI29',
                        CustomerName: 'AT_AEN625UTEA38',
                        Balance1: 'AT_AEN625BLNE27',
                        Balance2: 'AT_AEN625BLNC84',
                        Balance3: 'AT_AEN625BLNC39',
                        Balance4: 'AT_AEN625BAL417',
                        Balance5: 'AT_AEN625AAN573',
                        Balance6: 'AT_AEN625BANE67',
                        Balance7: 'AT_AEN625BAN705',
                        Balance8: 'AT_AEN625BLC803',
                        Balance9: 'AT_AEN625ANE944',
                        Balance10: 'AT_AEN625LE1053',
                        Balance11: 'AT_AEN625BAA127',
                        Balance12: 'AT_AEN625LANC40',
                        MonthAverage: 'AT_AEN625TEAG02',
                        TotalAnnual: 'AT_AEN625TOLA98',
                        _pks: [],
                        _entityId: 'EN_AENTAPAIT625',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_PATPCITY_8937 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_PATPCITY_8937 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PATPCITY_8937_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PATPCITY_8937_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_AENTAPAIT625',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PATPCITY_8937',
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
            $scope.vc.queries.Q_PATPCITY_8937_filters = {};
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
            $scope.vc.queryProperties.Q_QUERVILE_3248 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUERVILE_3248 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUERVILE_3248_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUERVILE_3248_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ARIABLETA489',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUERVILE_3248',
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
            $scope.vc.queries.Q_QUERVILE_3248_filters = {};
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
            $scope.vc.queryProperties.Q_QERISUIL_7170 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QERISUIL_7170 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QERISUIL_7170_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QERISUIL_7170_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_STRIIOINE478',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QERISUIL_7170',
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
            $scope.vc.queries.Q_QERISUIL_7170_filters = {};
            defaultValues = {
                LineHeader: {},
                PaymentCapacityHeader: {},
                SourceRevenueCustomer: {},
                Context: {},
                ValidationQuotaVsAvailableBalance: {},
                IndexSizeActivity: {},
                CreditOtherData: {},
                VariableData: {},
                QueryCentral: {},
                InfocredHeader: {},
                DebtorGeneral: {},
                DistributionLine: {},
                OriginalHeader: {},
                Flag: {},
                FeeRate: {},
                PaymentCapacity: {}
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
            $scope.vc.viewState.VC_AALAC85_OVBAF_912 = {
                style: []
            }
            //ViewState - Container: FormQuotaVsAvailableBalanceModifyLC
            $scope.vc.createViewState({
                id: "VC_AALAC85_OVBAF_912",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VIOOAIALN_29186",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ApplicationHeaderView
            $scope.vc.createViewState({
                id: "VC_AALAC85_CATEV_857",
                hasId: true,
                componentStyle: "",
                label: 'ApplicationHeaderView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Acordeón
            $scope.vc.createViewState({
                id: "GR_APITONEAEE55_04",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Acorde\u00f3n',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_APITONEAEE55_09",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
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
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_APITONEAEE55_10",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Number
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5510_0000944",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CREDILINE_85557",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Rotary
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5510_0000197",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
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
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_APITONEAEE55_11",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: IDRequested
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5511_RQSD053",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_APLIATION_48522",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Office
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5511_FICE246",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel de Acordeón para LineHeader
            $scope.vc.createViewState({
                id: "GR_APITONEAEE55_05",
                hasId: true,
                componentStyle: "",
                label: 'Panel de Acorde\u00f3n para LineHeader',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Rotary
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_RTAY481",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ROTARYEIR_50583",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: AmountProposed
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_PROE367",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CUPOKUVTB_02248",
                label: "BUSIN.DLB_BUSIN_CUPOKUVTB_02248",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: AmountUsed
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_USED740",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONOUSADO_15115",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: EntryDate
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_NDTE867",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ENTRYDATE_90791",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_TERM140",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TERMCUWZU_98612",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: ExpirationDate
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_XPIA086",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_XPIRATION_69508",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: officerName
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_OFIC220",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Sector
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_SCTR004",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SECTORJBS_77560",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5505_SCTR004 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5505_SCTR004', 'cl_sector_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5505_SCTR004'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5505_SCTR004");
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
            //ViewState - Entity: LineHeader, Attribute: Province
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_RVIC744",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                label: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5505_RVIC744 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5505_RVIC744', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5505_RVIC744'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5505_RVIC744");
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
            //ViewState - Entity: LineHeader, Attribute: GeograohicDestination
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_ADSN125",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OAHDETION_14498",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5505_ADSN125 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5505_ADSN125', 'cl_ciudad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5505_ADSN125'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5505_ADSN125");
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
            //ViewState - Entity: LineHeader, Attribute: CurrencyProposed
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_EPRO465",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5505_EPRO465 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5505_EPRO465', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5505_EPRO465'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5505_EPRO465");
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
            //ViewState - Entity: LineHeader, Attribute: NumberTestimony
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5505_NBTE960",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_UMROTSINO_09550",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Panel de Acordeón para OriginalHeader
            $scope.vc.createViewState({
                id: "GR_APITONEAEE55_06",
                hasId: true,
                componentStyle: "",
                label: 'Panel de Acorde\u00f3n para OriginalHeader',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Office
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_FICE377",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICELSD_48549",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5506_FICE377 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5506_FICE377', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5506_FICE377'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5506_FICE377");
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
            //ViewState - Entity: OriginalHeader, Attribute: CreditTarget
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_CRET209",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ETIOLITAO_71957",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: CityCode
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_ITCE223",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CITYAQLIM_46735",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5506_ITCE223 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5506_ITCE223', 'cl_ciudad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5506_ITCE223'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5506_ITCE223");
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
            //ViewState - Entity: OriginalHeader, Attribute: InitialDate
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_IALT470",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CHAGOOICD_69809",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: AmountRequested
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_OQUE114",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AMNTREQUT_92227",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_TERM631",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TERMCUWZU_98612",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Quota
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_QUOA497",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CUOTADPJP_65632",
                label: "BUSIN.DLB_BUSIN_CUOTADPJP_65632",
                haslabelArgs: true,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: PaymentFrequency
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_NQUE655",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PYTFREUNY_61581",
                label: "BUSIN.DLB_BUSIN_PYTFREUNY_61581",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5506_NQUE655 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5506_NQUE655', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5506_NQUE655'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5506_NQUE655");
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
            //ViewState - Entity: OriginalHeader, Attribute: CurrencyRequested
            $scope.vc.createViewState({
                id: "VA_APITONEAEE5506_URQT227",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RENEQESED_71054",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_APITONEAEE5506_URQT227 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_APITONEAEE5506_URQT227', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_APITONEAEE5506_URQT227'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_APITONEAEE5506_URQT227");
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
            //ViewState - Container: BorrowerView
            $scope.vc.createViewState({
                id: "VC_AALAC85_PSNRE_500",
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
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-show = 'vc.viewState.QV_BOREG0798_55.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_BORRWRVIEW27_83.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }, {
                "name": "CEQV_201_QV_BOREG0798_55_719",
                "text": "{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}",
                "template": "<button id='CEQV_201_QV_BOREG0798_55_719' ng-show='vc.viewState.QV_BOREG0798_55.toolbar.CEQV_201_QV_BOREG0798_55_719.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_BOREG0798_55_719\",\"DebtorGeneral\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand' title=\"{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}\"> #: text #</button>"
            }]; //ViewState - Container: CreditOtherDataView
            $scope.vc.createViewState({
                id: "VC_AALAC85_RPIMB_992",
                hasId: true,
                componentStyle: "",
                label: 'CreditOtherDataView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Other Data
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_03",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OTHERDATA_97873",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.QueryCentral = {
                ReportMonthCIC: $scope.vc.channelDefaultValues("QueryCentral", "ReportMonthCIC"),
                ReportMonthINFOCRED: $scope.vc.channelDefaultValues("QueryCentral", "ReportMonthINFOCRED"),
                LevelIndebtedness: $scope.vc.channelDefaultValues("QueryCentral", "LevelIndebtedness")
            };
            //ViewState - Group: QueryCentral
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_07",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CONULTNRL_07189",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QueryCentral, Attribute: ReportMonthCIC
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4907_OTHC416",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ONTEAROCI_36413",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QueryCentral, Attribute: ReportMonthINFOCRED
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4907_MICE804",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MOTOADINF_06914",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QueryCentral, Attribute: LevelIndebtedness
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4907_EDNE010",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_INREDVELS_81702",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4907_EDNE010 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_RIOTRDTAVI4907_EDNE010 !== "undefined") {}
            //ViewState - Group: SourceRevenueCustomer
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_08",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FUENTEDLI_58290",
                haslabelArgs: true,
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
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Clarification", ''),
                        validation: {
                            ClarificationRequired: function(input) {
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
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
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
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
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
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
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
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
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
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
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
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
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
                width: 160,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_RIOTRDTAVI4908_LRIN325',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755LRIN62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Clarification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4908_LRIN325",
                        'maxlength': 100,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ALARACIFI_82775') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Clarification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
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
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,1",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.descriptionActivity.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.descriptionActivity.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.model.CreditOtherData = {
                CreditPorpuse: $scope.vc.channelDefaultValues("CreditOtherData", "CreditPorpuse"),
                CreditDestination: $scope.vc.channelDefaultValues("CreditOtherData", "CreditDestination"),
                SourceOfFunding: $scope.vc.channelDefaultValues("CreditOtherData", "SourceOfFunding"),
                EconomicActivityCredit: $scope.vc.channelDefaultValues("CreditOtherData", "EconomicActivityCredit"),
                ActivityDestinationCredit: $scope.vc.channelDefaultValues("CreditOtherData", "ActivityDestinationCredit"),
                DescriptionDestinationRequested: $scope.vc.channelDefaultValues("CreditOtherData", "DescriptionDestinationRequested"),
                CreditDestinationValue: $scope.vc.channelDefaultValues("CreditOtherData", "CreditDestinationValue")
            };
            //ViewState - Group: CreditOtherData
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_04",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OTHERDATA_97873",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CreditOtherData, Attribute: ActivityDestinationCredit
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4904_TATT517",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ISACTIVTY_63441",
                label: "BUSIN.DLB_BUSIN_ISACTIVTY_63441",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4904_TATT517 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_RIOTRDTAVI4904_TATT517', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4904_TATT517'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4904_TATT517");
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
            //ViewState - Entity: CreditOtherData, Attribute: CreditPorpuse
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4904_RPPU470",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CREDIPUSE_23520",
                label: "BUSIN.DLB_BUSIN_CREDITPUO_21845",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4904_RPPU470 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_RIOTRDTAVI4904_RPPU470', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4904_RPPU470'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4904_RPPU470");
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
            //ViewState - Entity: CreditOtherData, Attribute: CreditDestinationValue
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4904_EDSN666",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TYETNCRED_24143",
                label: "BUSIN.DLB_BUSIN_TYETNCRED_24143",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CreditOtherData, Attribute: CreditDestination
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4904_RDTN715",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TYETNCRED_24143",
                label: "BUSIN.DLB_BUSIN_TYETNCRED_24143",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4904_RDTN715 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_RIOTRDTAVI4904_RDTN715', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4904_RDTN715'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4904_RDTN715");
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
            //ViewState - Entity: CreditOtherData, Attribute: SourceOfFunding
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4904_OUED020",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_FETEFIMIO_08044",
                label: "BUSIN.DLB_BUSIN_FETEFIMIO_08044",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4904_OUED020 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RIOTRDTAVI4904_OUED020', 'ca_origen_fondo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4904_OUED020'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4904_OUED020");
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
            //ViewState - Entity: CreditOtherData, Attribute: DescriptionDestinationRequested
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4904_DSNS029",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CRIATVITY_63237",
                label: "BUSIN.DLB_BUSIN_CRIATVITY_63237",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.IndexSizeActivity = {
                Patrimony: $scope.vc.channelDefaultValues("IndexSizeActivity", "Patrimony"),
                Sales: $scope.vc.channelDefaultValues("IndexSizeActivity", "Sales"),
                PersonalNumber: $scope.vc.channelDefaultValues("IndexSizeActivity", "PersonalNumber"),
                IndexSizeActivity: $scope.vc.channelDefaultValues("IndexSizeActivity", "IndexSizeActivity"),
                AnnualSales: $scope.vc.channelDefaultValues("IndexSizeActivity", "AnnualSales"),
                ProductiveAssets: $scope.vc.channelDefaultValues("IndexSizeActivity", "ProductiveAssets"),
                ParameterFixedIncome: $scope.vc.channelDefaultValues("IndexSizeActivity", "ParameterFixedIncome"),
                BtnCalculate: $scope.vc.channelDefaultValues("IndexSizeActivity", "BtnCalculate"),
                sizeCompany: $scope.vc.channelDefaultValues("IndexSizeActivity", "sizeCompany")
            };
            //ViewState - Group: IndexSizeActivity
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_09",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NDAAOCIID_54450",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: Patrimony
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4909_ATRN190",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PATRIONIO_19030",
                label: "BUSIN.DLB_BUSIN_PATRIONIO_19030",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: Sales
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4909_SALE147",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_VENTASTMS_38146",
                label: "BUSIN.DLB_BUSIN_VENTASTMS_38146",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: PersonalNumber
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4909_PESL753",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ROENLOUAO_93609",
                label: "BUSIN.DLB_BUSIN_ROENLOUAO_93609",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: IndexSizeActivity
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4909_NEIY699",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_NDAAOCIID_54450",
                label: "BUSIN.DLB_BUSIN_NDAAOCIID_54450",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: AnnualSales
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4909_NULE410",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_VETSNULES_35157",
                label: "BUSIN.DLB_BUSIN_VETSNULES_35157",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: ProductiveAssets
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4909_RCIE187",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_IVOPUCTOS_02893",
                label: "BUSIN.DLB_BUSIN_IVOPUCTOS_02893",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: VariableData
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_10",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DSVRABLES_87815",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.VariableData = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Field: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VariableData", "Field", '')
                    },
                    Value: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VariableData", "Value", '')
                    },
                    Mandatory: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VariableData", "Mandatory", '')
                    },
                    Type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VariableData", "Type", '')
                    },
                    IdFieldVariableData: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VariableData", "IdFieldVariableData", '')
                    }
                }
            });;
            $scope.vc.model.VariableData = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUERVILE_3248();
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'VariableData',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QUERV3248_81', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.VariableData
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QUERV3248_81").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUERVILE_3248 = $scope.vc.model.VariableData;
            $scope.vc.trackers.VariableData = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariableData);
            $scope.vc.model.VariableData.bind('change', function(e) {
                $scope.vc.trackers.VariableData.track(e);
            });
            $scope.vc.grids.QV_QUERV3248_81 = {};
            $scope.vc.grids.QV_QUERV3248_81.queryId = 'Q_QUERVILE_3248';
            $scope.vc.viewState.QV_QUERV3248_81 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QUERV3248_81.column = {};
            $scope.vc.grids.QV_QUERV3248_81.events = {
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
                    $scope.vc.trackers.VariableData.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QUERV3248_81.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QUERV3248_81");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QUERV3248_81.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QUERV3248_81.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QUERV3248_81.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QUERV3248_81 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QUERV3248_81 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUERV3248_81.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUERV3248_81.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUERV3248_81.column.Field = {
                title: 'BUSIN.DLB_BUSIN_CAMPOIJTJ_87064',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4910_FIEL838',
                element: []
            };
            $scope.vc.grids.QV_QUERV3248_81.AT_ARI489FIEL33 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.Field.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4910_FIEL838",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_QUERV3248_81.column.Field.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,4",
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.Field.enabled",
                        'ng-class': "vc.viewState.QV_QUERV3248_81.column.Field.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUERV3248_81.column.Value = {
                title: 'BUSIN.DLB_BUSIN_VALOREYDC_15105',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4910_VALU748',
                element: []
            };
            $scope.vc.grids.QV_QUERV3248_81.AT_ARI489VALU09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.Value.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4910_VALU748",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_QUERV3248_81.column.Value.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,4",
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.Value.enabled",
                        'ng-class': "vc.viewState.QV_QUERV3248_81.column.Value.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUERV3248_81.column.Mandatory = {
                title: 'BUSIN.DLB_BUSIN_MANDATORY_16739',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4910_MARY295',
                element: []
            };
            $scope.vc.grids.QV_QUERV3248_81.AT_ARI489MARY62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.Mandatory.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4910_MARY295",
                        'maxlength': 2,
                        'data-validation-code': "{{vc.viewState.QV_QUERV3248_81.column.Mandatory.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,4",
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.Mandatory.enabled",
                        'ng-class': "vc.viewState.QV_QUERV3248_81.column.Mandatory.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUERV3248_81.column.Type = {
                title: 'BUSIN.DLB_BUSIN_DATATYPEU_94714',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4910_TYPE655',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RIOTRDTAVI4910_TYPE655 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4910_TYPE655.data([{
                code: '1',
                value: 'Num\u00e9rico'
            }, {
                code: '2',
                value: 'Cat\u00e1logo'
            }, {
                code: '3',
                value: 'Alfab\u00e9tico'
            }, {
                code: '4',
                value: 'Alfanum\u00e9rico'
            }, {
                code: '6',
                value: 'Moneda'
            }]);
            $scope.vc.grids.QV_QUERV3248_81.AT_ARI489TYPE13 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4910_TYPE655",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QUERV3248_81.column.Type.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RIOTRDTAVI4910_TYPE655",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QUERV3248_81.column.Type.template",
                        'data-validation-code': "{{vc.viewState.QV_QUERV3248_81.column.Type.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,4",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4910_IIEL300',
                element: []
            };
            $scope.vc.grids.QV_QUERV3248_81.AT_ARI489IIEL95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_RIOTRDTAVI4910_IIEL300",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,4",
                        'ng-disabled': "!vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.enabled",
                        'ng-class': "vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERV3248_81.columns.push({
                    field: 'Field',
                    title: '{{vc.viewState.QV_QUERV3248_81.column.Field.title|translate:vc.viewState.QV_QUERV3248_81.column.Field.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERV3248_81.column.Field.width,
                    format: $scope.vc.viewState.QV_QUERV3248_81.column.Field.format,
                    editor: $scope.vc.grids.QV_QUERV3248_81.AT_ARI489FIEL33.control,
                    template: "<span ng-class='vc.viewState.QV_QUERV3248_81.column.Field.element[dataItem.uid].style'>#if (Field !== null) {# #=Field# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERV3248_81.column.Field.style",
                        "title": "{{vc.viewState.QV_QUERV3248_81.column.Field.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERV3248_81.column.Field.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERV3248_81.columns.push({
                    field: 'Value',
                    title: '{{vc.viewState.QV_QUERV3248_81.column.Value.title|translate:vc.viewState.QV_QUERV3248_81.column.Value.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERV3248_81.column.Value.width,
                    format: $scope.vc.viewState.QV_QUERV3248_81.column.Value.format,
                    editor: $scope.vc.grids.QV_QUERV3248_81.AT_ARI489VALU09.control,
                    template: "<span ng-class='vc.viewState.QV_QUERV3248_81.column.Value.element[dataItem.uid].style'>#if (Value !== null) {# #=Value# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERV3248_81.column.Value.style",
                        "title": "{{vc.viewState.QV_QUERV3248_81.column.Value.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERV3248_81.column.Value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERV3248_81.columns.push({
                    field: 'Mandatory',
                    title: '{{vc.viewState.QV_QUERV3248_81.column.Mandatory.title|translate:vc.viewState.QV_QUERV3248_81.column.Mandatory.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERV3248_81.column.Mandatory.width,
                    format: $scope.vc.viewState.QV_QUERV3248_81.column.Mandatory.format,
                    editor: $scope.vc.grids.QV_QUERV3248_81.AT_ARI489MARY62.control,
                    template: "<span ng-class='vc.viewState.QV_QUERV3248_81.column.Mandatory.element[dataItem.uid].style'>#if (Mandatory !== null) {# #=Mandatory# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERV3248_81.column.Mandatory.style",
                        "title": "{{vc.viewState.QV_QUERV3248_81.column.Mandatory.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERV3248_81.column.Mandatory.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERV3248_81.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_QUERV3248_81.column.Type.title|translate:vc.viewState.QV_QUERV3248_81.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERV3248_81.column.Type.width,
                    format: $scope.vc.viewState.QV_QUERV3248_81.column.Type.format,
                    editor: $scope.vc.grids.QV_QUERV3248_81.AT_ARI489TYPE13.control,
                    template: "<span ng-class='vc.viewState.QV_QUERV3248_81.column.Type.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RIOTRDTAVI4910_TYPE655.get(dataItem.Type).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERV3248_81.column.Type.style",
                        "title": "{{vc.viewState.QV_QUERV3248_81.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERV3248_81.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERV3248_81.columns.push({
                    field: 'IdFieldVariableData',
                    title: '{{vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.title|translate:vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.width,
                    format: $scope.vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.format,
                    editor: $scope.vc.grids.QV_QUERV3248_81.AT_ARI489IIEL95.control,
                    template: "<span ng-class='vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.element[dataItem.uid].style'>#if (IdFieldVariableData !== null) {# #=IdFieldVariableData# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.style",
                        "title": "{{vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERV3248_81.column.IdFieldVariableData.hidden
                });
            }
            $scope.vc.viewState.QV_QUERV3248_81.column.edit = {
                element: []
            };
            $scope.vc.grids.QV_QUERV3248_81.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_QUERV3248_81.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_QUERV3248_81.toolbar = {}
            $scope.vc.grids.QV_QUERV3248_81.toolbar = [];
            //ViewState - Group: DistributionLine
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_11",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DISTIIOIE_64780",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DistributionLine = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CreditType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "CreditType", '')
                    },
                    Currency: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "Currency", 0)
                    },
                    AmountProposed: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "AmountProposed", 0)
                    },
                    Quote: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "Quote", 0)
                    },
                    AmountLocalCurrency: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "AmountLocalCurrency", 0)
                    },
                    Module: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "Module", '')
                    }
                }
            });;
            $scope.vc.model.DistributionLine = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QERISUIL_7170();
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
                            nameEntityGrid: 'DistributionLine',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QERIS7170_82', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DistributionLine',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QERIS7170_82', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    destroy: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DistributionLine',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QERIS7170_82', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.DistributionLine
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QERIS7170_82").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QERISUIL_7170 = $scope.vc.model.DistributionLine;
            $scope.vc.trackers.DistributionLine = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DistributionLine);
            $scope.vc.model.DistributionLine.bind('change', function(e) {
                $scope.vc.trackers.DistributionLine.track(e);
            });
            $scope.vc.grids.QV_QERIS7170_82 = {};
            $scope.vc.grids.QV_QERIS7170_82.queryId = 'Q_QERISUIL_7170';
            $scope.vc.viewState.QV_QERIS7170_82 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QERIS7170_82.column = {};
            $scope.vc.grids.QV_QERIS7170_82.events = {
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
                    $scope.vc.trackers.DistributionLine.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QERIS7170_82.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QERIS7170_82");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QERIS7170_82.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QERIS7170_82.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QERIS7170_82.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QERIS7170_82 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QERIS7170_82 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QERIS7170_82.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QERIS7170_82.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QERIS7170_82.column.CreditType = {
                title: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4911_RITT092',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RIOTRDTAVI4911_RITT092 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_RIOTRDTAVI4911_RITT092_values)) {
                            $scope.vc.catalogs.VA_RIOTRDTAVI4911_RITT092_values = [];
                            $scope.vc.loadCatalog(
                                'VA_RIOTRDTAVI4911_RITT092', function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4911_RITT092'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_RIOTRDTAVI4911_RITT092_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_RIOTRDTAVI4911_RITT092");
                            },
                            options.data.filter, null, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_RIOTRDTAVI4911_RITT092_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_RIOTRDTAVI4911_RITT092");
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
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478RITT46 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.CreditType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4911_RITT092",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QERIS7170_82.column.CreditType.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RIOTRDTAVI4911_RITT092",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QERIS7170_82.column.CreditType.template",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.CreditType.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,5",
                        'k-on-change': "vc.change(kendoEvent,'VA_RIOTRDTAVI4911_RITT092',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_RIOTRDTAVI4911_RITT092',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4911_CUCY652',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RIOTRDTAVI4911_CUCY652 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_RIOTRDTAVI4911_CUCY652_values)) {
                            $scope.vc.catalogs.VA_RIOTRDTAVI4911_CUCY652_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_RIOTRDTAVI4911_CUCY652',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4911_CUCY652'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_RIOTRDTAVI4911_CUCY652_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_RIOTRDTAVI4911_CUCY652");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_RIOTRDTAVI4911_CUCY652_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_RIOTRDTAVI4911_CUCY652");
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
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478CUCY65 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4911_CUCY652",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QERIS7170_82.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RIOTRDTAVI4911_CUCY652",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QERIS7170_82.column.Currency.template",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.Currency.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,5",
                        'k-on-change': "vc.change(kendoEvent,'VA_RIOTRDTAVI4911_CUCY652',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_RIOTRDTAVI4911_CUCY652',this.dataItem,'" + options.field + "')",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed = {
                title: 'BUSIN.DLB_BUSIN_OUNTPROSE_37841',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4911_AONO671',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478AONO09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountProposed.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4911_AONO671",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.AmountProposed.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERIS7170_82.column.AmountProposed.format",
                        'k-decimals': "vc.viewState.QV_QERIS7170_82.column.AmountProposed.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_RIOTRDTAVI4911_AONO671',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_RIOTRDTAVI4911_AONO671',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,5",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountProposed.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.AmountProposed.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.Quote = {
                title: 'BUSIN.DLB_BUSIN_QUOTEGHSS_49243',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4911_QOTE117',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478QOTE39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Quote.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4911_QOTE117",
                        'maxlength': 7,
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.Quote.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERIS7170_82.column.Quote.format",
                        'k-decimals': "vc.viewState.QV_QERIS7170_82.column.Quote.decimals",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,5",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Quote.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.Quote.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency = {
                title: 'BUSIN.DLB_BUSIN_OTLCLCREY_32226',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4911_AREN478',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478AREN75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4911_AREN478",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.format",
                        'k-decimals': "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.decimals",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,5",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.Module = {
                title: 'BUSIN.DLB_BUSIN_MODULEFIQ_49292',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4911_MODL926',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478MODL65 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Module.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4911_MODL926",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.Module.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_RIOTRDTAVI49_03,5",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Module.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.Module.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'CreditType',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.CreditType.title|translate:vc.viewState.QV_QERIS7170_82.column.CreditType.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.CreditType.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.CreditType.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478RITT46.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.CreditType.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RIOTRDTAVI4911_RITT092.get(dataItem.CreditType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.CreditType.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.CreditType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.CreditType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.Currency.title|translate:vc.viewState.QV_QERIS7170_82.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.Currency.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.Currency.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478CUCY65.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RIOTRDTAVI4911_CUCY652.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.Currency.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'AmountProposed',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.AmountProposed.title|translate:vc.viewState.QV_QERIS7170_82.column.AmountProposed.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478AONO09.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.AmountProposed.element[dataItem.uid].style' ng-bind='kendo.toString(#=AmountProposed#, vc.viewState.QV_QERIS7170_82.column.AmountProposed.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.AmountProposed.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.AmountProposed.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'Quote',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.Quote.title|translate:vc.viewState.QV_QERIS7170_82.column.Quote.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.Quote.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.Quote.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478QOTE39.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.Quote.element[dataItem.uid].style' ng-bind='kendo.toString(#=Quote#, vc.viewState.QV_QERIS7170_82.column.Quote.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.Quote.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.Quote.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.Quote.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'AmountLocalCurrency',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.title|translate:vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478AREN75.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.element[dataItem.uid].style' ng-bind='kendo.toString(#=AmountLocalCurrency#, vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'Module',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.Module.title|translate:vc.viewState.QV_QERIS7170_82.column.Module.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.Module.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.Module.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478MODL65.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.Module.element[dataItem.uid].style'>#if (Module !== null) {# #=Module# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.Module.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.Module.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.Module.hidden
                });
            }
            $scope.vc.viewState.QV_QERIS7170_82.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_QERIS7170_82.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_QERIS7170_82.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_QERIS7170_82.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_QERIS7170_82.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_QERIS7170_82.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-image-button' " + "ng-show = 'vc.viewState.QV_QERIS7170_82.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_RIOTRDTAVI49_11.disabled?true:false' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\"> " + "<span class='glyphicon glyphicon-plus-sign'></span></button>"
            }]; //ViewState - Group: ValidationQuotaVsAvailableBalance
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_12",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VIOOAIALN_29186",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.ValidationQuotaVsAvailableBalance = {
                MaximumQuota: $scope.vc.channelDefaultValues("ValidationQuotaVsAvailableBalance", "MaximumQuota"),
                MaximumQuotaLine: $scope.vc.channelDefaultValues("ValidationQuotaVsAvailableBalance", "MaximumQuotaLine"),
                Rate: $scope.vc.channelDefaultValues("ValidationQuotaVsAvailableBalance", "Rate"),
                Term: $scope.vc.channelDefaultValues("ValidationQuotaVsAvailableBalance", "Term"),
                SumQuota: $scope.vc.channelDefaultValues("ValidationQuotaVsAvailableBalance", "SumQuota")
            };
            //ViewState - Group: [Grupo Saldo Disponible]
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_14",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Saldo Disponible]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValidationQuotaVsAvailableBalance, Attribute: MaximumQuota
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4912_MAMU147",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_MAXIMUMQA_70875",
                label: "BUSIN.DLB_BUSIN_MAXIMUMQA_70875",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValidationQuotaVsAvailableBalance, Attribute: MaximumQuotaLine
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4912_IULI202",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_MAXUTALNE_73481",
                label: "BUSIN.DLB_BUSIN_MAXUTALNE_73481",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValidationQuotaVsAvailableBalance, Attribute: Rate
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4912_RATE281",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_RATEYIYAF_91366",
                label: "BUSIN.DLB_BUSIN_RATEYIYAF_91366",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValidationQuotaVsAvailableBalance, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4912_TERM010",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TERMMONTH_18957",
                label: "BUSIN.DLB_BUSIN_TERMMONTH_18957",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValidationQuotaVsAvailableBalance, Attribute: SumQuota
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4912_UMUA249",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SUMQUOTAS_35980",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4912_0000847",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_VALIDATEB_59500",
                label: "BUSIN.DLB_BUSIN_VALIDATEB_59500",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Grid Saldo Disponible]
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_15",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Grid Saldo Disponible]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.PaymentCapacity = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CustomerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "CustomerName", '')
                    },
                    Balance1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance1", 0)
                    },
                    Balance2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance2", 0)
                    },
                    Balance3: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance3", 0)
                    },
                    Balance4: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance4", 0)
                    },
                    Balance5: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance5", 0)
                    },
                    Balance6: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance6", 0)
                    },
                    Balance7: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance7", 0)
                    },
                    Balance8: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance8", 0)
                    },
                    Balance9: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance9", 0)
                    },
                    Balance10: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance10", 0)
                    },
                    Balance11: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance11", 0)
                    },
                    Balance12: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance12", 0)
                    },
                    MonthAverage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "MonthAverage", 0)
                    },
                    TotalAnnual: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentCapacity", "TotalAnnual", 0)
                    },
                    CustomerID: {
                        type: "number",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.PaymentCapacity = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_PATPCITY_8937();
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
                    model: $scope.vc.types.PaymentCapacity
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_PATPC8937_50").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PATPCITY_8937 = $scope.vc.model.PaymentCapacity;
            $scope.vc.trackers.PaymentCapacity = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PaymentCapacity);
            $scope.vc.model.PaymentCapacity.bind('change', function(e) {
                $scope.vc.trackers.PaymentCapacity.track(e);
            });
            $scope.vc.grids.QV_PATPC8937_50 = {};
            $scope.vc.grids.QV_PATPC8937_50.queryId = 'Q_PATPCITY_8937';
            $scope.vc.viewState.QV_PATPC8937_50 = {
                style: undefined
            };
            $scope.vc.viewState.QV_PATPC8937_50.column = {};
            $scope.vc.grids.QV_PATPC8937_50.events = {
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
                    $scope.vc.trackers.PaymentCapacity.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_PATPC8937_50.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_PATPC8937_50");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_PATPC8937_50.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_PATPC8937_50.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_PATPC8937_50.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_PATPC8937_50 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_PATPC8937_50 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_PATPC8937_50.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_PATPC8937_50.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_PATPC8937_50.column.CustomerName = {
                title: 'BUSIN.DLB_BUSIN_PEROOUENA_59669',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_UTEA364',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625UTEA38 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.CustomerName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_UTEA364",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.CustomerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.CustomerName.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.CustomerName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance1 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BLNE197',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLNE27 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance1.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BLNE197",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance1.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance1.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance1.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance1.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance2 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BLNC506',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLNC84 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance2.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BLNC506",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance2.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance2.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance2.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance2.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance3 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BLNC946',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLNC39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance3.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BLNC946",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance3.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance3.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance3.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance3.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance3.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance4 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BAL4728',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BAL417 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance4.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BAL4728",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance4.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance4.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance4.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance4.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance4.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance5 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_AAN5610',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625AAN573 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance5.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_AAN5610",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance5.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance5.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance5.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance5.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance5.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance6 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BANE158',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BANE67 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance6.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BANE158",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance6.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance6.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance6.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance6.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance6.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance7 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BAN7269',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BAN705 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance7.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BAN7269",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance7.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance7.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance7.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance7.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance7.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance8 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BLC8317',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLC803 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance8.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BLC8317",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance8.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance8.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance8.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance8.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance8.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance9 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_ANE9939',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625ANE944 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance9.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_ANE9939",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance9.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance9.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance9.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance9.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance9.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance10 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_LE10449',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625LE1053 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance10.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_LE10449",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance10.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance10.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance10.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance10.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance10.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance11 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_BAA1680',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BAA127 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance11.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_BAA1680",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance11.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance11.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance11.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance11.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance11.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.Balance12 = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_LANC557',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625LANC40 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance12.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_LANC557",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.Balance12.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.Balance12.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.Balance12.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.Balance12.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.Balance12.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.MonthAverage = {
                title: 'BUSIN.DLB_BUSIN_PRMEDIMES_74725',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_TEAG656',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625TEAG02 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.MonthAverage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_TEAG656",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.MonthAverage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.MonthAverage.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.MonthAverage.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.MonthAverage.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.MonthAverage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.TotalAnnual = {
                title: 'BUSIN.DLB_BUSIN_TOTALANUA_05188',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_RIOTRDTAVI4915_TOLA146',
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.AT_AEN625TOLA98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.TotalAnnual.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RIOTRDTAVI4915_TOLA146",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_PATPC8937_50.column.TotalAnnual.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_PATPC8937_50.column.TotalAnnual.format",
                        'k-decimals': "vc.viewState.QV_PATPC8937_50.column.TotalAnnual.decimals",
                        'data-cobis-group': "Group,GR_RIOTRDTAVI49_12,1",
                        'ng-disabled': "!vc.viewState.QV_PATPC8937_50.column.TotalAnnual.enabled",
                        'ng-class': "vc.viewState.QV_PATPC8937_50.column.TotalAnnual.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PATPC8937_50.column.CustomerID = {
                title: 'CustomerID',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'CustomerName',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.CustomerName.title|translate:vc.viewState.QV_PATPC8937_50.column.CustomerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.CustomerName.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.CustomerName.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625UTEA38.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.CustomerName.element[dataItem.uid].style'>#if (CustomerName !== null) {# #=CustomerName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.CustomerName.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.CustomerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.CustomerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance1',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance1.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance1.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance1.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance1.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLNE27.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance1.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance1#, vc.viewState.QV_PATPC8937_50.column.Balance1.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance1.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance2',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance2.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance2.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance2.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance2.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLNC84.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance2.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance2#, vc.viewState.QV_PATPC8937_50.column.Balance2.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance2.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance3',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance3.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance3.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance3.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance3.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLNC39.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance3.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance3#, vc.viewState.QV_PATPC8937_50.column.Balance3.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance3.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance3.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance3.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance4',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance4.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance4.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance4.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance4.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BAL417.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance4.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance4#, vc.viewState.QV_PATPC8937_50.column.Balance4.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance4.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance4.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance4.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance5',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance5.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance5.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance5.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance5.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625AAN573.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance5.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance5#, vc.viewState.QV_PATPC8937_50.column.Balance5.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance5.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance5.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance5.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance6',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance6.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance6.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance6.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance6.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BANE67.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance6.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance6#, vc.viewState.QV_PATPC8937_50.column.Balance6.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance6.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance6.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance6.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance7',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance7.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance7.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance7.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance7.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BAN705.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance7.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance7#, vc.viewState.QV_PATPC8937_50.column.Balance7.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance7.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance7.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance7.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance8',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance8.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance8.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance8.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance8.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BLC803.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance8.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance8#, vc.viewState.QV_PATPC8937_50.column.Balance8.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance8.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance8.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance8.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance9',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance9.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance9.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance9.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance9.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625ANE944.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance9.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance9#, vc.viewState.QV_PATPC8937_50.column.Balance9.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance9.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance9.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance9.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance10',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance10.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance10.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance10.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance10.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625LE1053.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance10.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance10#, vc.viewState.QV_PATPC8937_50.column.Balance10.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance10.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance10.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance10.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance11',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance11.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance11.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance11.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance11.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625BAA127.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance11.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance11#, vc.viewState.QV_PATPC8937_50.column.Balance11.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance11.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance11.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance11.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'Balance12',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.Balance12.title|translate:vc.viewState.QV_PATPC8937_50.column.Balance12.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.Balance12.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.Balance12.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625LANC40.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.Balance12.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance12#, vc.viewState.QV_PATPC8937_50.column.Balance12.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.Balance12.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.Balance12.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.Balance12.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'MonthAverage',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.MonthAverage.title|translate:vc.viewState.QV_PATPC8937_50.column.MonthAverage.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.MonthAverage.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.MonthAverage.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625TEAG02.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.MonthAverage.element[dataItem.uid].style' ng-bind='kendo.toString(#=MonthAverage#, vc.viewState.QV_PATPC8937_50.column.MonthAverage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.MonthAverage.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.MonthAverage.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.MonthAverage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PATPC8937_50.columns.push({
                    field: 'TotalAnnual',
                    title: '{{vc.viewState.QV_PATPC8937_50.column.TotalAnnual.title|translate:vc.viewState.QV_PATPC8937_50.column.TotalAnnual.titleArgs}}',
                    width: $scope.vc.viewState.QV_PATPC8937_50.column.TotalAnnual.width,
                    format: $scope.vc.viewState.QV_PATPC8937_50.column.TotalAnnual.format,
                    editor: $scope.vc.grids.QV_PATPC8937_50.AT_AEN625TOLA98.control,
                    template: "<span ng-class='vc.viewState.QV_PATPC8937_50.column.TotalAnnual.element[dataItem.uid].style' ng-bind='kendo.toString(#=TotalAnnual#, vc.viewState.QV_PATPC8937_50.column.TotalAnnual.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PATPC8937_50.column.TotalAnnual.style",
                        "title": "{{vc.viewState.QV_PATPC8937_50.column.TotalAnnual.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PATPC8937_50.column.TotalAnnual.hidden
                });
            }
            $scope.vc.viewState.QV_PATPC8937_50.column.edit = {
                element: []
            };
            $scope.vc.grids.QV_PATPC8937_50.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_PATPC8937_50.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_PATPC8937_50.toolbar = {}
            $scope.vc.grids.QV_PATPC8937_50.toolbar = [];
            $scope.vc.model.FeeRate = {
                costCategory: $scope.vc.channelDefaultValues("FeeRate", "costCategory"),
                factorFrom: $scope.vc.channelDefaultValues("FeeRate", "factorFrom"),
                factorTo: $scope.vc.channelDefaultValues("FeeRate", "factorTo"),
                percentage: $scope.vc.channelDefaultValues("FeeRate", "percentage"),
                percentageNew: $scope.vc.channelDefaultValues("FeeRate", "percentageNew"),
                maxValue: $scope.vc.channelDefaultValues("FeeRate", "maxValue"),
                minValue: $scope.vc.channelDefaultValues("FeeRate", "minValue"),
                commission: $scope.vc.channelDefaultValues("FeeRate", "commission"),
                currency: $scope.vc.channelDefaultValues("FeeRate", "currency"),
                minimum: $scope.vc.channelDefaultValues("FeeRate", "minimum"),
                currencyValueMin: $scope.vc.channelDefaultValues("FeeRate", "currencyValueMin"),
                currencyValueMax: $scope.vc.channelDefaultValues("FeeRate", "currencyValueMax")
            };
            //ViewState - Group: CalculoComision
            $scope.vc.createViewState({
                id: "GR_RIOTRDTAVI49_13",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ORCETAJDI_03142",
                haslabelArgs: true,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: FeeRate, Attribute: costCategory
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_CCGR378",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AEGRACSTO_78529",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4913_CCGR378 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RIOTRDTAVI4913_CCGR378', 'ce_categoria', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4913_CCGR378'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4913_CCGR378");
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
            //ViewState - Entity: FeeRate, Attribute: factorFrom
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_FCTO304",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FACTOESDE_34564",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000088",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: percentage
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_RCEE421",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PORCENTJE_31752",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000840",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000200",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: factorTo
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_FORO253",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FACTORHAA_30289",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000800",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: minValue
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_NALE331",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ALORMNIMO_30715",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: currencyValueMin
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_ECUE519",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4913_ECUE519 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RIOTRDTAVI4913_ECUE519', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4913_ECUE519'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4913_ECUE519");
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
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000452",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: maxValue
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_ALUE739",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VLORMXIMO_06351",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: currencyValueMax
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_NVLX125",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4913_NVLX125 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RIOTRDTAVI4913_NVLX125', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4913_NVLX125'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4913_NVLX125");
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
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000886",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: percentageNew
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_PRNT606",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PORCENTJE_28614",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000492",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000623",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: commission
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_MION710",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AORACULDO_25417",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: currency
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_CURE278",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4913_CURE278 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RIOTRDTAVI4913_CURE278', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RIOTRDTAVI4913_CURE278'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RIOTRDTAVI4913_CURE278");
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
            //ViewState - Entity: FeeRate, Attribute: minimum
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_IMUM863",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MNIMODJBW_27031",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_RIOTRDTAVI4913_IMUM863 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_RIOTRDTAVI4913_IMUM863 !== "undefined") {}
            $scope.vc.createViewState({
                id: "VA_RIOTRDTAVI4913_0000660",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ACEPTARXV_30181",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_36_AALAC85_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_36_AALAC85_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: BtnSave
            $scope.vc.createViewState({
                id: "CM_AALAC85SAV65",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.PaymentCapacityHeader = {
                PeriodGrace: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "PeriodGrace"),
                StartMonth: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "StartMonth"),
                CountTerm: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "CountTerm"),
                ValidationSuccess: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "ValidationSuccess"),
                Status: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "Status")
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
            $scope.vc.model.Flag = {
                flag: $scope.vc.channelDefaultValues("Flag", "flag")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4907_EDNE010.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_ROLU425.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000295.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000810.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4908_0000668.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4911_RITT092.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4911_CUCY652.read();
                    $scope.vc.catalogs.VA_RIOTRDTAVI4913_IMUM863.read();
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
                $scope.vc.render('VC_AALAC85_OVBAF_912');
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
    var cobisMainModule = cobis.createModule("VC_AALAC85_OVBAF_912", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_AALAC85_OVBAF_912", {
            templateUrl: "VC_AALAC85_OVBAF_912_FORM.html",
            controller: "VC_AALAC85_OVBAF_912_CTRL",
            labelId: "BUSIN.DLB_BUSIN_VIOOAIALN_29186",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_AALAC85_OVBAF_912?" + $.param(search);
            }
        });
        VC_AALAC85_OVBAF_912(cobisMainModule);
    }]);
} else {
    VC_AALAC85_OVBAF_912(cobisMainModule);
}