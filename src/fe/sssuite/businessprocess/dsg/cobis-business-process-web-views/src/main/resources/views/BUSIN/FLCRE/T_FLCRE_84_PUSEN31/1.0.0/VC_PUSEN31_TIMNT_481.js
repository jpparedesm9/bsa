<!-- Designer Generator v 6.0.0 - release SPR 2016-16 19/08/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tpunishmentplan = designerEvents.api.tpunishmentplan || designer.dsgEvents();

function VC_PUSEN31_TIMNT_481(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PUSEN31_TIMNT_481_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PUSEN31_TIMNT_481_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_84_PUSEN31",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PUSEN31_TIMNT_481",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_84_PUSEN31",
        designerEvents.api.tpunishmentplan,
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
                vcName: 'VC_PUSEN31_TIMNT_481'
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
                    taskId: 'T_FLCRE_84_PUSEN31',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    OfficerAnalysis: "OfficerAnalysis",
                    HeaderPunishment: "HeaderPunishment",
                    PersonalGuarantor: "PersonalGuarantor",
                    OriginalHeader: "OriginalHeader",
                    Amount: "Amount",
                    DebtorGeneral: "DebtorGeneral",
                    Context: "Context"
                },
                entities: {
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
                    HeaderPunishment: {
                        SpecificForecast: 'AT_EDR212AANS58',
                        PercentageRecovered: 'AT_EDR212AGRD14',
                        CourtDate: 'AT_EDR212ORTT66',
                        DisbursementDate: 'AT_EDR212SBME09',
                        CreditStatus: 'AT_EDR212DTTA08',
                        CustomerOriginalActivity: 'AT_EDR212SMIA17',
                        NumberCreditsEarned: 'AT_EDR212BEDS90',
                        CourtDaysLate: 'AT_EDR212OURS34',
                        ApplicationDaysLate: 'AT_EDR212APCA64',
                        OfficialGrant: 'AT_EDR212CIRA07',
                        ResponsibleCurrent: 'AT_EDR212RENN73',
                        ActualUseLoan: 'AT_EDR212AUOA04',
                        Trouble: 'AT_EDR212TOBL12',
                        ImpossibilityDescription: 'AT_EDR212EPTI39',
                        DescripNotRecoverGaranties: 'AT_EDR212PNUR98',
                        DisbursedAmount: 'AT_EDR212IBRS42',
                        ApplicationNumber: 'AT_EDR212LINU69',
                        IDRequested: 'AT_EDR212EUED07',
                        Agency: 'AT_EDR212AGCY42',
                        CityCode: 'AT_EDR212CTYE71',
                        CurrencyRequest: 'AT_EDR212CQUE29',
                        CreditTarget: 'AT_EDR212RDRE99',
                        NumberOperation: 'AT_EDR212PRAI16',
                        ConsistencyApplication: 'AT_EDR212DTIN81',
                        Observation: 'AT_EDR212BRTO11',
                        Province: 'AT_EDR212RINE98',
                        UserL: 'AT_EDR212UELI22',
                        CustomerId: 'AT_EDR212UTMD63',
                        Type: 'AT_EDR212TYPE26',
                        Status: 'AT_EDR212STAU79',
                        ParentGroupID: 'AT_EDR212ARNI56',
                        GroupID: 'AT_EDR212GPID89',
                        Sindico1: 'AT_EDR212NICO38',
                        Sindico2: 'AT_EDR212SII259',
                        Step: 'AT_EDR212STEP97',
                        _pks: [],
                        _entityId: 'EN_EDRPNSMET212',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PersonalGuarantor: {
                        CodeWarranty: 'AT_SNA601CDEW22',
                        Type: 'AT_SNA601TYPE43',
                        Description: 'AT_SNA601ESCP00',
                        GuarantorPrimarySecondary: 'AT_SNA601GUAN15',
                        ClassOpen: 'AT_SNA601CLAN02',
                        IdCustomer: 'AT_SNA601IDSE19',
                        State: 'AT_SNA601STAT69',
                        isHeritage: 'AT_SNA601IHER96',
                        relation: 'AT_SNA601RLON48',
                        DateCIC: 'AT_SNA601DATE60',
                        CurrentValue: 'AT_SNA601URET41',
                        Currency: 'AT_SNA601CRRN03',
                        _pks: [],
                        _entityId: 'EN_SNALUATOR601',
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
                    },
                    Amount: {
                        Concept: 'AT_AMO270CNCP77',
                        AgreedAmount: 'AT_AMO270RUNT83',
                        AmountPaid: 'AT_AMO270AMNA98',
                        BalanceCutoffDate: 'AT_AMO270ACUT93',
                        BalanceDate: 'AT_AMO270ANDA11',
                        _pks: [],
                        _entityId: 'EN_AMOUNTJEN270',
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
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_UERMOUNT_1513 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_UERMOUNT_1513 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UERMOUNT_1513_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UERMOUNT_1513_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_AMOUNTJEN270',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UERMOUNT_1513',
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
            $scope.vc.queries.Q_UERMOUNT_1513_filters = {};
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
            $scope.vc.queryProperties.Q_PESAUANT_2317 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_PESAUANT_2317 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PESAUANT_2317_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PESAUANT_2317_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SNALUATOR601',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PESAUANT_2317',
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
            $scope.vc.queries.Q_PESAUANT_2317_filters = {};
            defaultValues = {
                OfficerAnalysis: {},
                HeaderPunishment: {},
                PersonalGuarantor: {},
                OriginalHeader: {},
                Amount: {},
                DebtorGeneral: {},
                Context: {}
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
            };
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
            $scope.vc.viewState.VC_PUSEN31_TIMNT_481 = {
                style: []
            }
            //ViewState - Container: FPunishmentPlan
            $scope.vc.createViewState({
                id: "VC_PUSEN31_TIMNT_481",
                hasId: true,
                componentStyle: "cb-without-margins",
                label: 'FPunishmentPlan',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: headerTskGrp
            $scope.vc.createViewState({
                id: "VC_PUSEN31_HESKG_220",
                hasId: true,
                componentStyle: "cabecera",
                label: 'headerTskGrp',
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
            //ViewState - Container: GrpVertical
            $scope.vc.createViewState({
                id: "VC_PUSEN31_GONOB_832",
                hasId: true,
                componentStyle: "",
                label: 'GrpVertical',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: HeaderPunishment
            $scope.vc.createViewState({
                id: "VC_PUSEN31_HEDRI_944",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OSGENERAE_41401",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.HeaderPunishment = {
                SpecificForecast: $scope.vc.channelDefaultValues("HeaderPunishment", "SpecificForecast"),
                PercentageRecovered: $scope.vc.channelDefaultValues("HeaderPunishment", "PercentageRecovered"),
                CourtDate: $scope.vc.channelDefaultValues("HeaderPunishment", "CourtDate"),
                DisbursementDate: $scope.vc.channelDefaultValues("HeaderPunishment", "DisbursementDate"),
                CreditStatus: $scope.vc.channelDefaultValues("HeaderPunishment", "CreditStatus"),
                CustomerOriginalActivity: $scope.vc.channelDefaultValues("HeaderPunishment", "CustomerOriginalActivity"),
                NumberCreditsEarned: $scope.vc.channelDefaultValues("HeaderPunishment", "NumberCreditsEarned"),
                CourtDaysLate: $scope.vc.channelDefaultValues("HeaderPunishment", "CourtDaysLate"),
                ApplicationDaysLate: $scope.vc.channelDefaultValues("HeaderPunishment", "ApplicationDaysLate"),
                OfficialGrant: $scope.vc.channelDefaultValues("HeaderPunishment", "OfficialGrant"),
                ResponsibleCurrent: $scope.vc.channelDefaultValues("HeaderPunishment", "ResponsibleCurrent"),
                ActualUseLoan: $scope.vc.channelDefaultValues("HeaderPunishment", "ActualUseLoan"),
                Trouble: $scope.vc.channelDefaultValues("HeaderPunishment", "Trouble"),
                ImpossibilityDescription: $scope.vc.channelDefaultValues("HeaderPunishment", "ImpossibilityDescription"),
                DescripNotRecoverGaranties: $scope.vc.channelDefaultValues("HeaderPunishment", "DescripNotRecoverGaranties"),
                DisbursedAmount: $scope.vc.channelDefaultValues("HeaderPunishment", "DisbursedAmount"),
                ApplicationNumber: $scope.vc.channelDefaultValues("HeaderPunishment", "ApplicationNumber"),
                IDRequested: $scope.vc.channelDefaultValues("HeaderPunishment", "IDRequested"),
                Agency: $scope.vc.channelDefaultValues("HeaderPunishment", "Agency"),
                CityCode: $scope.vc.channelDefaultValues("HeaderPunishment", "CityCode"),
                CurrencyRequest: $scope.vc.channelDefaultValues("HeaderPunishment", "CurrencyRequest"),
                CreditTarget: $scope.vc.channelDefaultValues("HeaderPunishment", "CreditTarget"),
                NumberOperation: $scope.vc.channelDefaultValues("HeaderPunishment", "NumberOperation"),
                ConsistencyApplication: $scope.vc.channelDefaultValues("HeaderPunishment", "ConsistencyApplication"),
                Observation: $scope.vc.channelDefaultValues("HeaderPunishment", "Observation"),
                Province: $scope.vc.channelDefaultValues("HeaderPunishment", "Province"),
                UserL: $scope.vc.channelDefaultValues("HeaderPunishment", "UserL"),
                CustomerId: $scope.vc.channelDefaultValues("HeaderPunishment", "CustomerId"),
                Type: $scope.vc.channelDefaultValues("HeaderPunishment", "Type"),
                Status: $scope.vc.channelDefaultValues("HeaderPunishment", "Status"),
                ParentGroupID: $scope.vc.channelDefaultValues("HeaderPunishment", "ParentGroupID"),
                GroupID: $scope.vc.channelDefaultValues("HeaderPunishment", "GroupID"),
                Sindico1: $scope.vc.channelDefaultValues("HeaderPunishment", "Sindico1"),
                Sindico2: $scope.vc.channelDefaultValues("HeaderPunishment", "Sindico2"),
                Step: $scope.vc.channelDefaultValues("HeaderPunishment", "Step")
            };
            //ViewState - Group: GeneralInfoGrp
            $scope.vc.createViewState({
                id: "GR_VIEANSHMET72_02",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ERALNFOTT_82055",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: NumberOperation
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_PRAI568",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OPEIONBER_32159",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: CreditStatus
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_DTTA160",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SDOLRDITO_43121",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIEANSHMET7202_DTTA160 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEANSHMET7202_DTTA160', 'cr_estado_castigo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIEANSHMET7202_DTTA160'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIEANSHMET7202_DTTA160");
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
            //ViewState - Entity: HeaderPunishment, Attribute: CurrencyRequest
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_CQUE733",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIEANSHMET7202_CQUE733 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEANSHMET7202_CQUE733', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIEANSHMET7202_CQUE733'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIEANSHMET7202_CQUE733");
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
            //ViewState - Entity: HeaderPunishment, Attribute: DisbursedAmount
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_IBRS444",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONOEEMOO_46223",
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: SpecificForecast
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_AANS963",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EINESPCFC_62417",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: PercentageRecovered
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_AGRD226",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PCAUPRADO_92903",
                format: "##0.00",
                suffix: "%",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: CreditTarget
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_RDRE671",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FNAALPOEL_12452",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: NumberCreditsEarned
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_BEDS390",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NMERTSEID_83243",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: CourtDaysLate
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_OURS795",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ADEATRAOE_55864",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: ApplicationDaysLate
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_APCA209",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DASTOLCUD_15106",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: OfficialGrant
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_CIRA064",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FIIINCIAL_83295",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: ResponsibleCurrent
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_RENN389",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RESPSAATL_02928",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: IDRequested
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_EUED823",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CRDITCODE_86774",
                format: "###########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: HeaderPunishment, Attribute: Agency
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_AGCY745",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFICINAJD_61287",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIEANSHMET7202_AGCY745 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEANSHMET7202_AGCY745', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIEANSHMET7202_AGCY745'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIEANSHMET7202_AGCY745");
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
            //ViewState - Entity: HeaderPunishment, Attribute: Province
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_RINE497",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIEANSHMET7202_RINE497 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEANSHMET7202_RINE497', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIEANSHMET7202_RINE497'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIEANSHMET7202_RINE497");
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
            //ViewState - Entity: HeaderPunishment, Attribute: CourtDate
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_ORTT140",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ECHAECORE_43828",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: HeaderPunishment, Attribute: CityCode
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_CTYE911",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIEANSHMET7202_CTYE911 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEANSHMET7202_CTYE911', 'cl_ciudad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIEANSHMET7202_CTYE911'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIEANSHMET7202_CTYE911");
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
            //ViewState - Entity: HeaderPunishment, Attribute: DisbursementDate
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_SBME489",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FECAEBOLO_12083",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: HeaderPunishment, Attribute: CustomerOriginalActivity
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_SMIA744",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_IDAIGNLNE_54575",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIEANSHMET7202_SMIA744 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEANSHMET7202_SMIA744', 'cl_actividad_ec', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIEANSHMET7202_SMIA744'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIEANSHMET7202_SMIA744");
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
            //ViewState - Group: ExcuseGrp
            $scope.vc.createViewState({
                id: "GR_VIEANSHMET72_03",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EAUNISMEN_23590",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: Trouble
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_TOBL390",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PROBLEMAD_97079",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIEANSHMET7202_TOBL390 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEANSHMET7202_TOBL390', 'cr_problemas_castigo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIEANSHMET7202_TOBL390'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIEANSHMET7202_TOBL390");
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
            //ViewState - Entity: HeaderPunishment, Attribute: ActualUseLoan
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7202_AUOA601",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RJIILATNS_36928",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: ImpossibilityDescription
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7203_EPTI020",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DEIMIIAPO_40326",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: DescripNotRecoverGaranties
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7203_PNUR402",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LGACIOLBL_62562",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: RecommendationGrp
            $scope.vc.createViewState({
                id: "GR_VIEANSHMET72_04",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RECENDAON_73799",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: ConsistencyApplication
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7204_DTIN896",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CRCISOLIU_00263",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: Observation
            $scope.vc.createViewState({
                id: "VA_VIEANSHMET7204_BRTO954",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OBSERVACI_93291",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: AmountPunishment
            $scope.vc.createViewState({
                id: "VC_PUSEN31_GOOMB_570",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ONTOSALOS_31286",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VIEWAMOUNT61_37",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Amount = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "Concept", '')
                    },
                    AgreedAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "AgreedAmount", 0)
                    },
                    AmountPaid: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "AmountPaid", 0)
                    },
                    BalanceCutoffDate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "BalanceCutoffDate", 0)
                    },
                    BalanceDate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "BalanceDate", 0)
                    }
                }
            });
            $scope.vc.model.Amount = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_UERMOUNT_1513();
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
                    model: $scope.vc.types.Amount
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UERMO1513_46").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UERMOUNT_1513 = $scope.vc.model.Amount;
            $scope.vc.trackers.Amount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Amount);
            $scope.vc.model.Amount.bind('change', function(e) {
                $scope.vc.trackers.Amount.track(e);
            });
            $scope.vc.grids.QV_UERMO1513_46 = {};
            $scope.vc.grids.QV_UERMO1513_46.queryId = 'Q_UERMOUNT_1513';
            $scope.vc.viewState.QV_UERMO1513_46 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UERMO1513_46.column = {};
            $scope.vc.grids.QV_UERMO1513_46.events = {
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
                    $scope.vc.trackers.Amount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UERMO1513_46.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_UERMO1513_46");
                    $scope.vc.hideShowColumns("QV_UERMO1513_46", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UERMO1513_46.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UERMO1513_46.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UERMO1513_46.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UERMO1513_46 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UERMO1513_46 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UERMO1513_46.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UERMO1513_46.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UERMO1513_46.column.Concept = {
                title: 'BUSIN.DLB_BUSIN_CONCEPTIY_86172',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIEWAMOUNT6137_CNCP506',
                element: []
            };
            $scope.vc.grids.QV_UERMO1513_46.AT_AMO270CNCP77 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.Concept.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIEWAMOUNT6137_CNCP506",
                        'maxlength': 500,
                        'data-validation-code': "{{vc.viewState.QV_UERMO1513_46.column.Concept.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.Concept.enabled",
                        'ng-class': "vc.viewState.QV_UERMO1513_46.column.Concept.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERMO1513_46.column.AgreedAmount = {
                title: 'BUSIN.DLB_BUSIN_ONPPLANAO_42706',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIEWAMOUNT6137_RUNT171',
                element: []
            };
            $scope.vc.grids.QV_UERMO1513_46.AT_AMO270RUNT83 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.AgreedAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIEWAMOUNT6137_RUNT171",
                        'maxlength': 13,
                        'data-validation-code': "{{vc.viewState.QV_UERMO1513_46.column.AgreedAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_UERMO1513_46.column.AgreedAmount.format",
                        'k-decimals': "vc.viewState.QV_UERMO1513_46.column.AgreedAmount.decimals",
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.AgreedAmount.enabled",
                        'ng-class': "vc.viewState.QV_UERMO1513_46.column.AgreedAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERMO1513_46.column.AmountPaid = {
                title: 'BUSIN.DLB_BUSIN_MOTOAACHA_78347',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIEWAMOUNT6137_AMNA921',
                element: []
            };
            $scope.vc.grids.QV_UERMO1513_46.AT_AMO270AMNA98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.AmountPaid.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIEWAMOUNT6137_AMNA921",
                        'maxlength': 13,
                        'data-validation-code': "{{vc.viewState.QV_UERMO1513_46.column.AmountPaid.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_UERMO1513_46.column.AmountPaid.format",
                        'k-decimals': "vc.viewState.QV_UERMO1513_46.column.AmountPaid.decimals",
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.AmountPaid.enabled",
                        'ng-class': "vc.viewState.QV_UERMO1513_46.column.AmountPaid.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate = {
                title: 'BUSIN.DLB_BUSIN_SOAFEAEOT_32473',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIEWAMOUNT6137_ACUT135',
                element: []
            };
            $scope.vc.grids.QV_UERMO1513_46.AT_AMO270ACUT93 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIEWAMOUNT6137_ACUT135",
                        'maxlength': 13,
                        'data-validation-code': "{{vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.format",
                        'k-decimals': "vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.decimals",
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.enabled",
                        'ng-class': "vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERMO1513_46.column.BalanceDate = {
                title: 'BUSIN.DLB_BUSIN_SADOALAEH_80462',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIEWAMOUNT6137_ANDA558',
                element: []
            };
            $scope.vc.grids.QV_UERMO1513_46.AT_AMO270ANDA11 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.BalanceDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIEWAMOUNT6137_ANDA558",
                        'maxlength': 13,
                        'data-validation-code': "{{vc.viewState.QV_UERMO1513_46.column.BalanceDate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_UERMO1513_46.column.BalanceDate.format",
                        'k-decimals': "vc.viewState.QV_UERMO1513_46.column.BalanceDate.decimals",
                        'ng-disabled': "!vc.viewState.QV_UERMO1513_46.column.BalanceDate.enabled",
                        'ng-class': "vc.viewState.QV_UERMO1513_46.column.BalanceDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERMO1513_46.columns.push({
                    field: 'Concept',
                    title: '{{vc.viewState.QV_UERMO1513_46.column.Concept.title|translate:vc.viewState.QV_UERMO1513_46.column.Concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERMO1513_46.column.Concept.width,
                    format: $scope.vc.viewState.QV_UERMO1513_46.column.Concept.format,
                    editor: $scope.vc.grids.QV_UERMO1513_46.AT_AMO270CNCP77.control,
                    template: "<span ng-class='vc.viewState.QV_UERMO1513_46.column.Concept.element[dataItem.uid].style'>#if (Concept !== null) {# #=Concept# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERMO1513_46.column.Concept.style",
                        "title": "{{vc.viewState.QV_UERMO1513_46.column.Concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERMO1513_46.column.Concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERMO1513_46.columns.push({
                    field: 'AgreedAmount',
                    title: '{{vc.viewState.QV_UERMO1513_46.column.AgreedAmount.title|translate:vc.viewState.QV_UERMO1513_46.column.AgreedAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERMO1513_46.column.AgreedAmount.width,
                    format: $scope.vc.viewState.QV_UERMO1513_46.column.AgreedAmount.format,
                    editor: $scope.vc.grids.QV_UERMO1513_46.AT_AMO270RUNT83.control,
                    template: "<span ng-class='vc.viewState.QV_UERMO1513_46.column.AgreedAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=AgreedAmount#, vc.viewState.QV_UERMO1513_46.column.AgreedAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UERMO1513_46.column.AgreedAmount.style",
                        "title": "{{vc.viewState.QV_UERMO1513_46.column.AgreedAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_UERMO1513_46.column.AgreedAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERMO1513_46.columns.push({
                    field: 'AmountPaid',
                    title: '{{vc.viewState.QV_UERMO1513_46.column.AmountPaid.title|translate:vc.viewState.QV_UERMO1513_46.column.AmountPaid.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERMO1513_46.column.AmountPaid.width,
                    format: $scope.vc.viewState.QV_UERMO1513_46.column.AmountPaid.format,
                    editor: $scope.vc.grids.QV_UERMO1513_46.AT_AMO270AMNA98.control,
                    template: "<span ng-class='vc.viewState.QV_UERMO1513_46.column.AmountPaid.element[dataItem.uid].style' ng-bind='kendo.toString(#=AmountPaid#, vc.viewState.QV_UERMO1513_46.column.AmountPaid.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UERMO1513_46.column.AmountPaid.style",
                        "title": "{{vc.viewState.QV_UERMO1513_46.column.AmountPaid.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_UERMO1513_46.column.AmountPaid.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERMO1513_46.columns.push({
                    field: 'BalanceCutoffDate',
                    title: '{{vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.title|translate:vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.width,
                    format: $scope.vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.format,
                    editor: $scope.vc.grids.QV_UERMO1513_46.AT_AMO270ACUT93.control,
                    template: "<span ng-class='vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.element[dataItem.uid].style' ng-bind='kendo.toString(#=BalanceCutoffDate#, vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.style",
                        "title": "{{vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_UERMO1513_46.column.BalanceCutoffDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERMO1513_46.columns.push({
                    field: 'BalanceDate',
                    title: '{{vc.viewState.QV_UERMO1513_46.column.BalanceDate.title|translate:vc.viewState.QV_UERMO1513_46.column.BalanceDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERMO1513_46.column.BalanceDate.width,
                    format: $scope.vc.viewState.QV_UERMO1513_46.column.BalanceDate.format,
                    editor: $scope.vc.grids.QV_UERMO1513_46.AT_AMO270ANDA11.control,
                    template: "<span ng-class='vc.viewState.QV_UERMO1513_46.column.BalanceDate.element[dataItem.uid].style' ng-bind='kendo.toString(#=BalanceDate#, vc.viewState.QV_UERMO1513_46.column.BalanceDate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UERMO1513_46.column.BalanceDate.style",
                        "title": "{{vc.viewState.QV_UERMO1513_46.column.BalanceDate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_UERMO1513_46.column.BalanceDate.hidden
                });
            }
            $scope.vc.viewState.QV_UERMO1513_46.toolbar = {}
            $scope.vc.grids.QV_UERMO1513_46.toolbar = []; //ViewState - Container: DebtorPunishment
            $scope.vc.createViewState({
                id: "VC_PUSEN31_GSIOE_966",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DEUDORESN_35493",
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
            });
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
                    $scope.vc.hideShowColumns("QV_BOREG0798_55", grid);
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
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_BOREG0798_55.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_BOREG0798_55.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_BOREG0798_55.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "DebtorGeneral",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_BOREG0798_55", args);
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
            $scope.vc.grids.QV_BOREG0798_55.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_BOREG0798_55.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode = {
                title: 'BUSIN.DLB_BUSIN_CDIGOZVON_13133',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CUTOMEROD_75260',
                width: 30,
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
                width: 300,
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
                title: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
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
                        'title': "{{'BUSIN.DLB_BUSIN_ROLEVJMGD_53686'|translate}}",
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
                width: 30,
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
            }]; //ViewState - Container: WarrantyPunishment
            $scope.vc.createViewState({
                id: "VC_PUSEN31_OSMBR_895",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GARANTASQ_18496",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_PRSAUARNTE35_96",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GrpEntidades
            $scope.vc.createViewState({
                id: "GR_PRSAUARNTE35_07",
                hasId: true,
                componentStyle: "",
                label: 'GrpEntidades',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GrpOriginalHeader
            $scope.vc.createViewState({
                id: "GR_PRSAUARNTE35_08",
                hasId: true,
                componentStyle: "",
                label: 'GrpOriginalHeader',
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
                id: "GR_PRSAUARNTE35_09",
                hasId: true,
                componentStyle: "",
                label: 'GrpOfficerAnalysis',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: GrpContext
            $scope.vc.createViewState({
                id: "GR_PRSAUARNTE35_10",
                hasId: true,
                componentStyle: "",
                label: 'GrpContext',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: GrpBorrower
            $scope.vc.createViewState({
                id: "GR_PRSAUARNTE35_11",
                hasId: true,
                componentStyle: "",
                label: 'GrpBorrower',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: GroupGuarantor
            $scope.vc.createViewState({
                id: "GR_PRSAUARNTE35_88",
                hasId: true,
                componentStyle: "",
                label: 'GroupGuarantor',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.PersonalGuarantor = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CodeWarranty: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "CodeWarranty", '')
                    },
                    Type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "Type", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "Description", '')
                    },
                    GuarantorPrimarySecondary: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "GuarantorPrimarySecondary", '')
                    },
                    ClassOpen: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "ClassOpen", '')
                    },
                    IdCustomer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "IdCustomer", '')
                    },
                    State: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "State", '')
                    },
                    DateCIC: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "DateCIC", new Date())
                    },
                    isHeritage: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "isHeritage", '')
                    },
                    CurrentValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "CurrentValue", 0)
                    },
                    Currency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PersonalGuarantor", "Currency", '')
                    }
                }
            });
            $scope.vc.model.PersonalGuarantor = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_PESAUANT_2317();
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
                            nameEntityGrid: 'PersonalGuarantor',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_PESAU2317_81', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.PersonalGuarantor
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_PESAU2317_81").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PESAUANT_2317 = $scope.vc.model.PersonalGuarantor;
            $scope.vc.trackers.PersonalGuarantor = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PersonalGuarantor);
            $scope.vc.model.PersonalGuarantor.bind('change', function(e) {
                $scope.vc.trackers.PersonalGuarantor.track(e);
            });
            $scope.vc.grids.QV_PESAU2317_81 = {};
            $scope.vc.grids.QV_PESAU2317_81.queryId = 'Q_PESAUANT_2317';
            $scope.vc.viewState.QV_PESAU2317_81 = {
                style: undefined
            };
            $scope.vc.viewState.QV_PESAU2317_81.column = {};
            $scope.vc.grids.QV_PESAU2317_81.events = {
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    $scope.vc.grids.QV_PESAU2317_81.selectedRow = dataItem;
                    var rowIndex = grid.dataSource.indexOf(dataItem);
                    var row = grid.tbody.find(">tr:not(.k-grouping-row)").eq(rowIndex);
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        isNew: false,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "BUSIN",
                        subModuleId: "FLCRE",
                        taskId: "T_FLCRE_35_RRCAI67",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_RRCAI67_WACRI_884',
                        title: 'BUSIN.DLB_BUSIN_GARANTASQ_18496',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_PESAU2317_81", dialogParameters);
                },
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_PESAU2317_81");
                    $scope.vc.hideShowColumns("QV_PESAU2317_81", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_PESAU2317_81.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_PESAU2317_81.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_PESAU2317_81.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_PESAU2317_81 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_PESAU2317_81 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_PESAU2317_81.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_PESAU2317_81.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_PESAU2317_81.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "PersonalGuarantor",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_PESAU2317_81", args);
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
            $scope.vc.grids.QV_PESAU2317_81.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_PESAU2317_81.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_PESAU2317_81.column.CodeWarranty = {
                title: 'BUSIN.DLB_BUSIN_DWARRANTY_01979',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_CDEW390',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TYPEYLJIK_10770',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_TYPE391',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_0000401',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary = {
                title: 'BUSIN.DLB_BUSIN_GUROONDAY_85151',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_0000761',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.ClassOpen = {
                title: 'BUSIN.DLB_BUSIN_CLASSOPEN_47401',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_CLAN959',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.IdCustomer = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_0000449',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.State = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_STAT403',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_DATE784',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.isHeritage = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_IHER479',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.CurrentValue = {
                title: 'BUSIN.DLB_BUSIN_VALOREYDC_15105',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_URET936',
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_CRRN473',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'CodeWarranty',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.CodeWarranty.title|translate:vc.viewState.QV_PESAU2317_81.column.CodeWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.CodeWarranty.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.CodeWarranty.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.CodeWarranty.element[dataItem.uid].style'>#if (CodeWarranty !== null) {# #=CodeWarranty# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.CodeWarranty.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.CodeWarranty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.CodeWarranty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.Type.title|translate:vc.viewState.QV_PESAU2317_81.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.Type.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.Type.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.Type.element[dataItem.uid].style'>#if (Type !== null) {# #=Type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.Type.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.Description.title|translate:vc.viewState.QV_PESAU2317_81.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.Description.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.Description.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.Description.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'GuarantorPrimarySecondary',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.title|translate:vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.element[dataItem.uid].style'>#if (GuarantorPrimarySecondary !== null) {# #=GuarantorPrimarySecondary# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'ClassOpen',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.ClassOpen.title|translate:vc.viewState.QV_PESAU2317_81.column.ClassOpen.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.ClassOpen.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.ClassOpen.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.ClassOpen.element[dataItem.uid].style'>#if (ClassOpen !== null) {# #=ClassOpen# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.ClassOpen.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.ClassOpen.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.ClassOpen.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'IdCustomer',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.IdCustomer.title|translate:vc.viewState.QV_PESAU2317_81.column.IdCustomer.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.IdCustomer.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.IdCustomer.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.IdCustomer.element[dataItem.uid].style'>#if (IdCustomer !== null) {# #=IdCustomer# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.IdCustomer.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.IdCustomer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.IdCustomer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'State',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.State.title|translate:vc.viewState.QV_PESAU2317_81.column.State.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.State.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.State.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.State.element[dataItem.uid].style'>#if (State !== null) {# #=State# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.State.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.State.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.State.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'DateCIC',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.DateCIC.title|translate:vc.viewState.QV_PESAU2317_81.column.DateCIC.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.DateCIC.element[dataItem.uid].style'>#=((DateCIC !== null) ? kendo.toString(DateCIC, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.DateCIC.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.DateCIC.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'isHeritage',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.isHeritage.title|translate:vc.viewState.QV_PESAU2317_81.column.isHeritage.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.isHeritage.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.isHeritage.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.isHeritage.element[dataItem.uid].style'>#if (isHeritage !== null) {# #=isHeritage# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.isHeritage.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.isHeritage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.isHeritage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'CurrentValue',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.CurrentValue.title|translate:vc.viewState.QV_PESAU2317_81.column.CurrentValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.CurrentValue.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.CurrentValue.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.CurrentValue.element[dataItem.uid].style' ng-bind='kendo.toString(#=CurrentValue#, vc.viewState.QV_PESAU2317_81.column.CurrentValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.CurrentValue.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.CurrentValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.CurrentValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.Currency.title|translate:vc.viewState.QV_PESAU2317_81.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.Currency.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.Currency.format,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.Currency.element[dataItem.uid].style'>#if (Currency !== null) {# #=Currency# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.Currency.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.Currency.hidden
                });
            }
            $scope.vc.viewState.QV_PESAU2317_81.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_PESAU2317_81.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.columns.push({
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "PersonalGuarantor",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_PESAU2317_81.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.GR_PRSAUARNTE35_88.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_PESAU2317_81.events.customEdit($event, \"#:entity#\", grids.QV_PESAU2317_81)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_PESAU2317_81.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_PESAU2317_81.toolbar = {}
            $scope.vc.grids.QV_PESAU2317_81.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_84_PUSEN31_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_84_PUSEN31_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Save
            $scope.vc.createViewState({
                id: "CM_PUSEN31SAV72",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Print
            $scope.vc.createViewState({
                id: "CM_PUSEN31RIN94",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_IMPRIMIRH_85279",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_VIEANSHMET7202_DTTA160.read();
                    $scope.vc.catalogs.VA_VIEANSHMET7202_CQUE733.read();
                    $scope.vc.catalogs.VA_VIEANSHMET7202_AGCY745.read();
                    $scope.vc.catalogs.VA_VIEANSHMET7202_RINE497.read();
                    $scope.vc.catalogs.VA_VIEANSHMET7202_CTYE911.read();
                    $scope.vc.catalogs.VA_VIEANSHMET7202_SMIA744.read();
                    $scope.vc.catalogs.VA_VIEANSHMET7202_TOBL390.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256.read();
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
                $scope.vc.render('VC_PUSEN31_TIMNT_481');
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
    var cobisMainModule = cobis.createModule("VC_PUSEN31_TIMNT_481", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_PUSEN31_TIMNT_481", {
            templateUrl: "VC_PUSEN31_TIMNT_481_FORM.html",
            controller: "VC_PUSEN31_TIMNT_481_CTRL",
            label: "FPunishmentPlan",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PUSEN31_TIMNT_481?" + $.param(search);
            }
        });
        VC_PUSEN31_TIMNT_481(cobisMainModule);
    }]);
} else {
    VC_PUSEN31_TIMNT_481(cobisMainModule);
}