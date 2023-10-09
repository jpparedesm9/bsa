<!-- Designer Generator v 6.1.0 - release SPR 2016-21 20/10/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.entrywarranty = designerEvents.api.entrywarranty || designer.dsgEvents();

function VC_EYWRY63_FMRRT_302(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_EYWRY63_FMRRT_302_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_EYWRY63_FMRRT_302_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_21_EYWRY63",
            taskVersion: "1.0.0",
            viewContainerId: "VC_EYWRY63_FMRRT_302",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_21_EYWRY63",
        designerEvents.api.entrywarranty,
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
                vcName: 'VC_EYWRY63_FMRRT_302'
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
                    taskId: 'T_FLCRE_21_EYWRY63',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    DebtorGeneral: "DebtorGeneral",
                    PersonalGuarantor: "PersonalGuarantor",
                    GuaranteesBtn: "GuaranteesBtn",
                    OtherWarranty: "OtherWarranty",
                    Context: "Context",
                    OfficerAnalysis: "OfficerAnalysis",
                    OriginalHeader: "OriginalHeader"
                },
                entities: {
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
                    GuaranteesBtn: {
                        Monto: 'AT_GAR197ONTO71',
                        Searchbtn: 'AT_GAR197HBTN43',
                        Associatebtn: 'AT_GAR197SCTE99',
                        _pks: [],
                        _entityId: 'EN_GARATEBTN197',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OtherWarranty: {
                        CodeWarranty: 'AT_OTH152OERA58',
                        Type: 'AT_OTH152TYPE96',
                        Description: 'AT_OTH152ECIP99',
                        InitialValue: 'AT_OTH152IAUE93',
                        DateAppraisedValue: 'AT_OTH152PIAE66',
                        ValueApportionment: 'AT_OTH152AENT57',
                        ClassOpen: 'AT_OTH152LSON48',
                        ValueAvailable: 'AT_OTH152AEIL95',
                        IdCustomer: 'AT_OTH152USOM81',
                        NameGar: 'AT_OTH152AMEA59',
                        State: 'AT_OTH152TATE08',
                        Flag: 'AT_OTH152FLAG56',
                        IsNew: 'AT_OTH152EMOV51',
                        ValueVNR: 'AT_OTH152VLNR47',
                        RelationshipGuarantees: 'AT_OTH152TRTS26',
                        isHeritage: 'AT_OTH152IHAE86',
                        relation: 'AT_OTH152LATI03',
                        _pks: [],
                        _entityId: 'EN_OTHERANTY152',
                        _entityVersion: '1.0.0',
                        _transient: false
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
                        Parroquia: 'AT_FIC039RQIA94',
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
            $scope.vc.queryProperties.Q_URYTHAAN_5890 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_URYTHAAN_5890 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_URYTHAAN_5890_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_URYTHAAN_5890_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_OTHERANTY152',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_URYTHAAN_5890',
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
            $scope.vc.queries.Q_URYTHAAN_5890_filters = {};
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
                DebtorGeneral: {},
                PersonalGuarantor: {},
                GuaranteesBtn: {},
                OtherWarranty: {},
                Context: {},
                OfficerAnalysis: {},
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
            $scope.vc.viewState.VC_EYWRY63_FMRRT_302 = {
                style: []
            }
            //ViewState - Container: FormEntryWarranty
            $scope.vc.createViewState({
                id: "VC_EYWRY63_FMRRT_302",
                hasId: true,
                componentStyle: "",
                label: 'FormEntryWarranty',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: T_VW_WTTTEPRCES08
            $scope.vc.createViewState({
                id: "VC_EYWRY63_ADRSG_549",
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
            //ViewState - Container: Guarantees
            $scope.vc.createViewState({
                id: "VC_EYWRY63_RPSNO_481",
                hasId: true,
                componentStyle: "",
                label: 'T_VW_UARNTEESEW96',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_UARNTEESEW96_21",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GuaranteesBtn = {
                Monto: $scope.vc.channelDefaultValues("GuaranteesBtn", "Monto"),
                Searchbtn: $scope.vc.channelDefaultValues("GuaranteesBtn", "Searchbtn"),
                Associatebtn: $scope.vc.channelDefaultValues("GuaranteesBtn", "Associatebtn")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_UARNTEESEW96_10",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_UARNTEESEW9610_0000924",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NUEVOOPAM_52575",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_UARNTEESEW9610_HBTN418",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BUSCARGJN_88350",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_UARNTEESEW9610_0000180",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: T_VW_PRSAUARNTE35
            $scope.vc.createViewState({
                id: "VC_EYWRY63_UPNNE_629",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ERSOALWAY_81979",
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
            $scope.vc.model.DebtorGeneral = {
                CustomerCode: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerCode"),
                Role: $scope.vc.channelDefaultValues("DebtorGeneral", "Role"),
                Identification: $scope.vc.channelDefaultValues("DebtorGeneral", "Identification"),
                CustomerName: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerName"),
                TypeDocumentId: $scope.vc.channelDefaultValues("DebtorGeneral", "TypeDocumentId"),
                Address: $scope.vc.channelDefaultValues("DebtorGeneral", "Address"),
                Qualification: $scope.vc.channelDefaultValues("DebtorGeneral", "Qualification"),
                AditionalCode: $scope.vc.channelDefaultValues("DebtorGeneral", "AditionalCode"),
                DateCIC: $scope.vc.channelDefaultValues("DebtorGeneral", "DateCIC")
            };
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
                title: 'BUSIN.DLB_BUSIN_CIGEARNTA_66805',
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
                title: 'BUSIN.DLB_BUSIN_TIPOXAASN_24763',
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
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
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
                title: 'BUSIN.LBL_BUSIN_GARANTERI_43305',
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
                title: 'BUSIN.LBL_BUSIN_CLASEABRA_92992',
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
                title: 'BUSIN.LBL_BUSIN_VALORACLA_58791',
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
                title: 'BUSIN.DLB_BUSIN_MONEDAWDW_15876',
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
            $scope.vc.grids.QV_PESAU2317_81.toolbar = []; //ViewState - Container: T_VW_OHRWARAYIE87
            $scope.vc.createViewState({
                id: "VC_EYWRY63_RPIMR_022",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OTETFWRRY_06685",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OHRWARAYIE87_96",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupWarrantes
            $scope.vc.createViewState({
                id: "GR_OHRWARAYIE87_44",
                hasId: true,
                componentStyle: "",
                label: 'GroupWarrantes',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.OtherWarranty = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "CodeWarranty", '')
                    },
                    Type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "Type", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "Description", '')
                    },
                    InitialValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "InitialValue", 0)
                    },
                    DateAppraisedValue: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "DateAppraisedValue", '')
                    },
                    ValueApportionment: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "ValueApportionment", 0)
                    },
                    ClassOpen: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "ClassOpen", '')
                    },
                    ValueAvailable: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "ValueAvailable", 0)
                    },
                    IdCustomer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "IdCustomer", '')
                    },
                    NameGar: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "NameGar", '')
                    },
                    State: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "State", '')
                    },
                    ValueVNR: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "ValueVNR", 0)
                    },
                    RelationshipGuarantees: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "RelationshipGuarantees", 0)
                    },
                    isHeritage: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "isHeritage", '')
                    }
                }
            });
            $scope.vc.model.OtherWarranty = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_URYTHAAN_5890();
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
                            nameEntityGrid: 'OtherWarranty',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_URYTH5890_66', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.OtherWarranty
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_URYTH5890_66").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_URYTHAAN_5890 = $scope.vc.model.OtherWarranty;
            $scope.vc.trackers.OtherWarranty = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.OtherWarranty);
            $scope.vc.model.OtherWarranty.bind('change', function(e) {
                $scope.vc.trackers.OtherWarranty.track(e);
            });
            $scope.vc.grids.QV_URYTH5890_66 = {};
            $scope.vc.grids.QV_URYTH5890_66.queryId = 'Q_URYTHAAN_5890';
            $scope.vc.viewState.QV_URYTH5890_66 = {
                style: undefined
            };
            $scope.vc.viewState.QV_URYTH5890_66.column = {};
            $scope.vc.grids.QV_URYTH5890_66.events = {
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    $scope.vc.grids.QV_URYTH5890_66.selectedRow = dataItem;
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
                    $scope.vc.beforeOpenGridDialog("QV_URYTH5890_66", dialogParameters);
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
                    $scope.vc.gridDataBound("QV_URYTH5890_66");
                    $scope.vc.hideShowColumns("QV_URYTH5890_66", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_URYTH5890_66.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_URYTH5890_66.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_URYTH5890_66.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_URYTH5890_66 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_URYTH5890_66 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_URYTH5890_66.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_URYTH5890_66.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_URYTH5890_66.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "OtherWarranty",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_URYTH5890_66", args);
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
            $scope.vc.grids.QV_URYTH5890_66.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_URYTH5890_66.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_URYTH5890_66.column.CodeWarranty = {
                title: 'BUSIN.DLB_BUSIN_CIGEARNTA_66805',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_OERA057',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TIPOXAASN_24763',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000033',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000921',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.InitialValue = {
                title: 'BUSIN.DLB_BUSIN_VALRINICL_45750',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000048',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue = {
                title: 'BUSIN.DLB_BUSIN_FHDEAVALO_98024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000201',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.ValueApportionment = {
                title: 'BUSIN.LBL_BUSIN_VALORPRRR_75270',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000049',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.ClassOpen = {
                title: 'BUSIN.LBL_BUSIN_CLASEABRA_92992',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_LSON038',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.ValueAvailable = {
                title: 'BUSIN.LBL_BUSIN_VALORDINO_56965',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_AEIL886',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.IdCustomer = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000676',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.NameGar = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000781',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.State = {
                title: 'BUSIN.DLB_BUSIN_ESTADORJE_43391',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_TATE773',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OHRWARAYIE8744_TATE773 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OHRWARAYIE8744_TATE773_values)) {
                            $scope.vc.catalogs.VA_OHRWARAYIE8744_TATE773_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OHRWARAYIE8744_TATE773',
                                'cu_est_custodia',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OHRWARAYIE8744_TATE773'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OHRWARAYIE8744_TATE773_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_URYTH5890_66", "VA_OHRWARAYIE8744_TATE773");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OHRWARAYIE8744_TATE773_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_URYTH5890_66", "VA_OHRWARAYIE8744_TATE773");
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
            $scope.vc.viewState.QV_URYTH5890_66.column.ValueVNR = {
                title: 'BUSIN.DLB_BUSIN_VALORVNRE_02989',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_VLNR942',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees = {
                title: 'BUSIN.LBL_BUSIN_RELACINAT_51634',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_TRTS480',
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.isHeritage = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_IHAE368',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'CodeWarranty',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.CodeWarranty.title|translate:vc.viewState.QV_URYTH5890_66.column.CodeWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.CodeWarranty.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.CodeWarranty.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.CodeWarranty.element[dataItem.uid].style'>#if (CodeWarranty !== null) {# #=CodeWarranty# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.CodeWarranty.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.CodeWarranty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.CodeWarranty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.Type.title|translate:vc.viewState.QV_URYTH5890_66.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.Type.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.Type.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.Type.element[dataItem.uid].style'>#if (Type !== null) {# #=Type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.Type.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.Description.title|translate:vc.viewState.QV_URYTH5890_66.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.Description.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.Description.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.Description.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'InitialValue',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.InitialValue.title|translate:vc.viewState.QV_URYTH5890_66.column.InitialValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.InitialValue.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.InitialValue.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.InitialValue.element[dataItem.uid].style' ng-bind='kendo.toString(#=InitialValue#, vc.viewState.QV_URYTH5890_66.column.InitialValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.InitialValue.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.InitialValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.InitialValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'DateAppraisedValue',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.title|translate:vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.element[dataItem.uid].style'>#if (DateAppraisedValue !== null) {# #=DateAppraisedValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'ValueApportionment',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.ValueApportionment.title|translate:vc.viewState.QV_URYTH5890_66.column.ValueApportionment.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.ValueApportionment.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.ValueApportionment.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.ValueApportionment.element[dataItem.uid].style' ng-bind='kendo.toString(#=ValueApportionment#, vc.viewState.QV_URYTH5890_66.column.ValueApportionment.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.ValueApportionment.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.ValueApportionment.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.ValueApportionment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'ClassOpen',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.ClassOpen.title|translate:vc.viewState.QV_URYTH5890_66.column.ClassOpen.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.ClassOpen.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.ClassOpen.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.ClassOpen.element[dataItem.uid].style'>#if (ClassOpen !== null) {# #=ClassOpen# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.ClassOpen.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.ClassOpen.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.ClassOpen.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'ValueAvailable',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.ValueAvailable.title|translate:vc.viewState.QV_URYTH5890_66.column.ValueAvailable.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.ValueAvailable.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.ValueAvailable.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.ValueAvailable.element[dataItem.uid].style' ng-bind='kendo.toString(#=ValueAvailable#, vc.viewState.QV_URYTH5890_66.column.ValueAvailable.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.ValueAvailable.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.ValueAvailable.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.ValueAvailable.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'IdCustomer',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.IdCustomer.title|translate:vc.viewState.QV_URYTH5890_66.column.IdCustomer.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.IdCustomer.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.IdCustomer.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.IdCustomer.element[dataItem.uid].style'>#if (IdCustomer !== null) {# #=IdCustomer# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.IdCustomer.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.IdCustomer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.IdCustomer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'NameGar',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.NameGar.title|translate:vc.viewState.QV_URYTH5890_66.column.NameGar.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.NameGar.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.NameGar.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.NameGar.element[dataItem.uid].style'>#if (NameGar !== null) {# #=NameGar# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.NameGar.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.NameGar.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.NameGar.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'State',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.State.title|translate:vc.viewState.QV_URYTH5890_66.column.State.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.State.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.State.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.State.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OHRWARAYIE8744_TATE773.get(dataItem.State).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.State.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.State.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.State.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'ValueVNR',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.ValueVNR.title|translate:vc.viewState.QV_URYTH5890_66.column.ValueVNR.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.ValueVNR.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.ValueVNR.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.ValueVNR.element[dataItem.uid].style' ng-bind='kendo.toString(#=ValueVNR#, vc.viewState.QV_URYTH5890_66.column.ValueVNR.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.ValueVNR.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.ValueVNR.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.ValueVNR.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'RelationshipGuarantees',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.title|translate:vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.element[dataItem.uid].style' ng-bind='kendo.toString(#=RelationshipGuarantees#, vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'isHeritage',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.isHeritage.title|translate:vc.viewState.QV_URYTH5890_66.column.isHeritage.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.isHeritage.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.isHeritage.format,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.isHeritage.element[dataItem.uid].style'>#if (isHeritage !== null) {# #=isHeritage# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.isHeritage.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.isHeritage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.isHeritage.hidden
                });
            }
            $scope.vc.viewState.QV_URYTH5890_66.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_66.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_66.columns.push({
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "OtherWarranty",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_URYTH5890_66.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.GR_OHRWARAYIE87_44.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_URYTH5890_66.events.customEdit($event, \"#:entity#\", grids.QV_URYTH5890_66)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_URYTH5890_66.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_URYTH5890_66.toolbar = {}
            $scope.vc.grids.QV_URYTH5890_66.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_21_EYWRY63_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_21_EYWRY63_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Associate
            $scope.vc.createViewState({
                id: "CM_EYWRY63SOA19",
                componentStyle: "",
                label: "BUSIN.LBL_BUSIN_ASOCIARCF_21687",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_OHRWARAYIE8744_TATE773.read();
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
                $scope.vc.render('VC_EYWRY63_FMRRT_302');
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
    var cobisMainModule = cobis.createModule("VC_EYWRY63_FMRRT_302", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_EYWRY63_FMRRT_302", {
            templateUrl: "VC_EYWRY63_FMRRT_302_FORM.html",
            controller: "VC_EYWRY63_FMRRT_302_CTRL",
            label: "FormEntryWarranty",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_EYWRY63_FMRRT_302?" + $.param(search);
            }
        });
        VC_EYWRY63_FMRRT_302(cobisMainModule);
    }]);
} else {
    VC_EYWRY63_FMRRT_302(cobisMainModule);
}