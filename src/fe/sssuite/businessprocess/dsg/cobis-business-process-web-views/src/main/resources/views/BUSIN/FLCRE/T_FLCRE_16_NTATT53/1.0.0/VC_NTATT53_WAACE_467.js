<!-- Designer Generator v 5.1.0.1601 - release SPR 2016-01 22/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.entrywarrantyticket = designerEvents.api.entrywarrantyticket || designer.dsgEvents();

function VC_NTATT53_WAACE_467(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_NTATT53_WAACE_467_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_NTATT53_WAACE_467_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_16_NTATT53",
            taskVersion: "1.0.0",
            viewContainerId: "VC_NTATT53_WAACE_467",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_16_NTATT53",
        designerEvents.api.entrywarrantyticket,
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
                vcName: 'VC_NTATT53_WAACE_467'
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
                    taskId: 'T_FLCRE_16_NTATT53',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Context: "Context",
                    PersonalGuarantor: "PersonalGuarantor",
                    OriginalHeader: "OriginalHeader",
                    InfocredHeader: "InfocredHeader",
                    HeaderGuaranteesTicket: "HeaderGuaranteesTicket",
                    OtherWarranty: "OtherWarranty"
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
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
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
                    HeaderGuaranteesTicket: {
                        CustomerName: 'AT_HAU747OMAM15',
                        CustomerAddress: 'AT_HAU747TORR16',
                        CustomerId: 'AT_HAU747CUSI47',
                        ApplicationType: 'AT_HAU747PCTP54',
                        RenewOperation: 'AT_HAU747REWP64',
                        CreditLineDistrib: 'AT_HAU747LIES09',
                        AmountAvailable: 'AT_HAU747UNIB21',
                        WarrantyClass: 'AT_HAU747WNTS09',
                        WarrantyType: 'AT_HAU747WNTP34',
                        CurrencyRequested: 'AT_HAU747RRQE67',
                        AmountRequested: 'AT_HAU747TREU97',
                        FromDate: 'AT_HAU747ATRO20',
                        RequestedTermInDays: 'AT_HAU747EUER31',
                        ExpirationDate: 'AT_HAU747POTE28',
                        Sector: 'AT_HAU747UMRO75',
                        ByAccountName: 'AT_HAU747YCON57',
                        ByAccountAddress: 'AT_HAU747STCN02',
                        ByAccountId: 'AT_HAU747ACCD02',
                        BeneficiaryName: 'AT_HAU747EEAR39',
                        BeneficiaryAddress: 'AT_HAU747SNCI41',
                        BeneficiaryId: 'AT_HAU747IIRI06',
                        ObjectGuarantee: 'AT_HAU747OUEE73',
                        ObjectGuaranteeTwo: 'AT_HAU747JGEW50',
                        AdditionalInstruction: 'AT_HAU747DLCO07',
                        AdditionalInstructionTwo: 'AT_HAU747ALNI95',
                        AdditionalInstructionThree: 'AT_HAU747INTE64',
                        DateAdmission: 'AT_HAU747AEIN24',
                        DateProcess: 'AT_HAU747DAPS52',
                        User: 'AT_HAU747USER46',
                        CreationDate: 'AT_HAU747COND98',
                        CustomerType: 'AT_HAU747COMR24',
                        _pks: [],
                        _entityId: 'EN_HAUTSICKE747',
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
                Context: {},
                PersonalGuarantor: {},
                OriginalHeader: {},
                InfocredHeader: {},
                HeaderGuaranteesTicket: {},
                OtherWarranty: {}
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
            $scope.vc.viewState.VC_NTATT53_WAACE_467 = {
                style: []
            }
            //ViewState - Container: EntryWarrantyTicket
            $scope.vc.createViewState({
                id: "VC_NTATT53_WAACE_467",
                hasId: true,
                componentStyle: "",
                label: 'EntryWarrantyTicket',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewGuaranteesTicket
            $scope.vc.createViewState({
                id: "VC_NTATT53_IWUES_675",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EERCAPPIO_57615",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.HeaderGuaranteesTicket = {
                CustomerName: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "CustomerName"),
                CustomerAddress: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "CustomerAddress"),
                CustomerId: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "CustomerId"),
                ApplicationType: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "ApplicationType"),
                RenewOperation: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "RenewOperation"),
                CreditLineDistrib: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "CreditLineDistrib"),
                AmountAvailable: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "AmountAvailable"),
                WarrantyClass: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "WarrantyClass"),
                WarrantyType: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "WarrantyType"),
                CurrencyRequested: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "CurrencyRequested"),
                AmountRequested: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "AmountRequested"),
                FromDate: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "FromDate"),
                RequestedTermInDays: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "RequestedTermInDays"),
                ExpirationDate: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "ExpirationDate"),
                Sector: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "Sector"),
                ByAccountName: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "ByAccountName"),
                ByAccountAddress: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "ByAccountAddress"),
                ByAccountId: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "ByAccountId"),
                BeneficiaryName: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "BeneficiaryName"),
                BeneficiaryAddress: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "BeneficiaryAddress"),
                BeneficiaryId: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "BeneficiaryId"),
                ObjectGuarantee: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "ObjectGuarantee"),
                ObjectGuaranteeTwo: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "ObjectGuaranteeTwo"),
                AdditionalInstruction: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "AdditionalInstruction"),
                AdditionalInstructionTwo: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "AdditionalInstructionTwo"),
                AdditionalInstructionThree: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "AdditionalInstructionThree"),
                DateAdmission: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "DateAdmission"),
                DateProcess: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "DateProcess"),
                User: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "User"),
                CreationDate: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "CreationDate"),
                CustomerType: $scope.vc.channelDefaultValues("HeaderGuaranteesTicket", "CustomerType")
            };
            //ViewState - Group: CustomerData
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_04",
                hasId: true,
                componentStyle: "",
                label: 'CustomerData',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: CustomerName
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6804_OMAM834",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LJRXITRFW_70117",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: CustomerAddress
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_07",
                hasId: true,
                componentStyle: "",
                label: 'CustomerAddress',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: CustomerAddress
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6807_TORR665",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DIRECCINR_88355",
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
            //ViewState - Group: ApplicationSession
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_05",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DATOSICIT_94836",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: ApplicationNumber
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6805_IOUR839",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_INSNCAROC_84210",
                haslabelArgs: true,
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: OpNumberBank
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6805_NRAK766",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OPEIONBER_32159",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: IDRequested
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6805_RQSD720",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NEODTRMTE_52071",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Office
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6805_FICE145",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICELSD_48549",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6805_FICE145 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IEWGUARNTK6805_FICE145', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6805_FICE145'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6805_FICE145");
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
                id: "VA_IEWGUARNTK6805_ITCE935",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6805_ITCE935 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IEWGUARNTK6805_ITCE935', 'cl_ciudad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6805_ITCE935'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6805_ITCE935");
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
            //ViewState - Entity: OriginalHeader, Attribute: UserL
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6805_USRL092",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Province
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6805_OINC062",
                componentStyle: "",
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
            $scope.vc.catalogs.VA_IEWGUARNTK6805_OINC062 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IEWGUARNTK6805_OINC062', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6805_OINC062'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6805_OINC062");
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
            //ViewState - Entity: OriginalHeader, Attribute: CreditSector
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6805_EDCT992",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CRDTSECOR_41454",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6805_EDCT992 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
                        $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6805_EDCT992");
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
                id: "VA_IEWGUARNTK6805_CRET464",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ETIOLITAO_71957",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: ApplicationData
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_06",
                hasId: true,
                componentStyle: "",
                label: 'ApplicationData',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: ApplicationType
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_PCTP590",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TISOLIIUD_96006",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: RenewOperation
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_REWP949",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OPERANANV_07872",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: CurrencyRequested
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_RRQE376",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RENEQESED_71054",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6806_RRQE376 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IEWGUARNTK6806_RRQE376', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6806_RRQE376'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6806_RRQE376");
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
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: CreditLineDistrib
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_LIES496",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NADRIOITI_71863",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6806_LIES496 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_IEWGUARNTK6806_LIES496', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6806_LIES496'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6806_LIES496");
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
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: AmountAvailable
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_UNIB222",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DISPONIBE_91677",
                haslabelArgs: true,
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: WarrantyClass
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_WNTS030",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CLEEAANTA_38635",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6806_WNTS030 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IEWGUARNTK6806_WNTS030', 'ce_clase_grb', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6806_WNTS030'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6806_WNTS030");
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
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: WarrantyType
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_WNTP122",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIPODERNT_79668",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6806_WNTP122 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_IEWGUARNTK6806_WNTP122', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6806_WNTP122'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6806_WNTP122");
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
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: AmountRequested
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_TREU555",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AMOUTREED_14545",
                haslabelArgs: true,
                format: "####",
                decimals: 0,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: FromDate
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_ATRO527",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FEHAAARTE_94559",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: RequestedTermInDays
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_EUER032",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_POSLICTDS_82254",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: ExpirationDate
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_POTE119",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EXIRTIONA_39042",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: Sector
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_UMRO301",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TMERDUSRY_93208",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEWGUARNTK6806_UMRO301 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IEWGUARNTK6806_UMRO301', 'cl_sector_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_IEWGUARNTK6806_UMRO301'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEWGUARNTK6806_UMRO301");
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
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: DateProcess
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6806_DAPS003",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_FEHAINGRS_62019",
                label: "BUSIN.DLB_BUSIN_FEHAINGRS_62019",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Datos Ordenante
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_08",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ATSRDENNT_64935",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: ByAccountName
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6808_YCON750",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PCUENTADE_43892",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: ByAccountAddress
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6808_STCN795",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DIRECCINR_88355",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Datos Beneficiario
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_09",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AOENEFIAI_77890",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: BeneficiaryName
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6809_EEAR819",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NAMEFDOFF_74379",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: BeneficiaryAddress
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6809_SNCI435",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DIRECCINR_88355",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Others
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_10",
                hasId: true,
                componentStyle: "",
                label: 'Others',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: ObjectGuarantee
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6810_OUEE698",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TTENGTHEN_81454",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: AdditionalInstruction
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6810_DLCO699",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ISCCAICNL_04258",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: AdditionalInstructionTwo
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6810_ALNI891",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_INTCDNADO_50357",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderGuaranteesTicket, Attribute: AdditionalInstructionThree
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6810_INTE642",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ISRCNDINR_94971",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_11",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_IEWGUARNTK68_12",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6812_0000268",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6812_0000537",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EAHGUANES_27474",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6812_0000372",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_IEWGUARNTK6812_0000459",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EAHGUANES_27474",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: PersonalGuarantorView
            $scope.vc.createViewState({
                id: "VC_NTATT53_POSIE_990",
                hasId: true,
                componentStyle: "",
                label: 'PersonalGuarantorView',
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
            //ViewState - Group: GroupGuarantor
            $scope.vc.createViewState({
                id: "GR_PRSAUARNTE35_88",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ERSOALWAY_81979",
                haslabelArgs: true,
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
                    }
                }
            });;
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
                    $scope.vc.trackers.PersonalGuarantor.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_PESAU2317_81.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_PESAU2317_81");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_PESAU2317_81.selectedRow)) {
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601CDEW22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.CodeWarranty.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_CDEW390",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.CodeWarranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.CodeWarranty.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.CodeWarranty.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601TYPE43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_TYPE391",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601ESCP00 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_0000401",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Description.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601GUAN15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_0000761",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601CLAN02 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.ClassOpen.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_CLAN959",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.ClassOpen.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.ClassOpen.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.ClassOpen.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601IDSE19 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.IdCustomer.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_0000449",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.IdCustomer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.IdCustomer.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.IdCustomer.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601STAT69 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.State.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_STAT403",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.State.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.State.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.State.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC = {
                title: 'BUSIN.DLB_BUSIN_FECHACICY_04196',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_PRSAUARNTE3588_DATE142',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601DATE60 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.DateCIC.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_DATE142",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.DateCIC.validationCode}}",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.DateCIC.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601IHER96 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.isHeritage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_PRSAUARNTE3588_IHER479",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.isHeritage.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_PRSAUARNTE35_96,0",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.isHeritage.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.isHeritage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'CodeWarranty',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.CodeWarranty.title|translate:vc.viewState.QV_PESAU2317_81.column.CodeWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.CodeWarranty.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.CodeWarranty.format,
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601CDEW22.control,
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601TYPE43.control,
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601ESCP00.control,
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601GUAN15.control,
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601CLAN02.control,
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601IDSE19.control,
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601STAT69.control,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.State.element[dataItem.uid].style'>#if (State !== null) {# #=State# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.State.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.State.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.State.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_PESAU2317_81.columns.push({
                    field: 'DateCIC',
                    title: '{{vc.viewState.QV_PESAU2317_81.column.DateCIC.title|translate:vc.viewState.QV_PESAU2317_81.column.DateCIC.titleArgs}}',
                    width: $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC.width,
                    format: $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_PESAU2317_81', 'DateCIC', $scope.vc.grids.QV_PESAU2317_81.AT_SNA601DATE60.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_PESAU2317_81', 'DateCIC'),
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601IHER96.control,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.isHeritage.element[dataItem.uid].style'>#if (isHeritage !== null) {# #=isHeritage# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.isHeritage.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.isHeritage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.isHeritage.hidden
                });
            }
            $scope.vc.viewState.QV_PESAU2317_81.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.columns.push({
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_PESAU2317_81.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_PESAU2317_81.toolbar = {}
            $scope.vc.grids.QV_PESAU2317_81.toolbar = []; //ViewState - Container: OtherWarrantyView
            $scope.vc.createViewState({
                id: "VC_NTATT53_GUPNM_924",
                hasId: true,
                componentStyle: "",
                label: 'OtherWarrantyView',
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
                label: "BUSIN.DLB_BUSIN_OTETFWRRY_06685",
                haslabelArgs: true,
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
            });;
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
                    $scope.vc.trackers.OtherWarranty.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_URYTH5890_66.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_URYTH5890_66");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_URYTH5890_66.selectedRow)) {
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
                title: 'BUSIN.DLB_BUSIN_DWARRANTY_01979',
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152OERA58 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.CodeWarranty.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_OERA057",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.CodeWarranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.CodeWarranty.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.CodeWarranty.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TYPEYLJIK_10770',
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152TYPE96 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_0000033",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152ECIP99 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_0000921",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.Description.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.InitialValue = {
                title: 'BUSIN.DLB_BUSIN_NITIALVLU_66179',
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152IAUE93 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.InitialValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_0000048",
                        'maxlength': 53,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.InitialValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_66.column.InitialValue.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_66.column.InitialValue.decimals",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.InitialValue.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.InitialValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue = {
                title: 'BUSIN.DLB_BUSIN_VUATODATE_41694',
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152PIAE66 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_0000201",
                        'maxlength': 60,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.DateAppraisedValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.ValueApportionment = {
                title: 'BUSIN.DLB_BUSIN_APPOIONEA_90622',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_0000049',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152AENT57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ValueApportionment.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_0000049",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.ValueApportionment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_66.column.ValueApportionment.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_66.column.ValueApportionment.decimals",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ValueApportionment.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.ValueApportionment.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.ClassOpen = {
                title: 'BUSIN.DLB_BUSIN_CLASSOPEN_47401',
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152LSON48 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ClassOpen.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_LSON038",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.ClassOpen.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ClassOpen.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.ClassOpen.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.ValueAvailable = {
                title: 'BUSIN.DLB_BUSIN_VAEAAILAL_53568',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_AEIL886',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152AEIL95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ValueAvailable.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_AEIL886",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.ValueAvailable.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_66.column.ValueAvailable.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_66.column.ValueAvailable.decimals",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ValueAvailable.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.ValueAvailable.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152USOM81 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.IdCustomer.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_0000676",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.IdCustomer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.IdCustomer.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.IdCustomer.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152AMEA59 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.NameGar.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_0000781",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.NameGar.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.NameGar.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.NameGar.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.State = {
                title: 'BUSIN.DLB_BUSIN_STATUSUAS_80798',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OHRWARAYIE8744_TATE773',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152TATE08 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.State.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_TATE773",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.State.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.State.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.State.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152VLNR47 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ValueVNR.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_VLNR942",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.ValueVNR.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_66.column.ValueVNR.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_66.column.ValueVNR.decimals",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.ValueVNR.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.ValueVNR.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees = {
                title: 'BUSIN.DLB_BUSIN_RATINPUAE_21235',
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152TRTS26 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_TRTS480",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.decimals",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.RelationshipGuarantees.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
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
            $scope.vc.grids.QV_URYTH5890_66.AT_OTH152IHAE86 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.isHeritage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_OHRWARAYIE8744_IHAE368",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_66.column.isHeritage.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OHRWARAYIE87_96,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_66.column.isHeritage.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_66.column.isHeritage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_66.columns.push({
                    field: 'CodeWarranty',
                    title: '{{vc.viewState.QV_URYTH5890_66.column.CodeWarranty.title|translate:vc.viewState.QV_URYTH5890_66.column.CodeWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_66.column.CodeWarranty.width,
                    format: $scope.vc.viewState.QV_URYTH5890_66.column.CodeWarranty.format,
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152OERA58.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152TYPE96.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152ECIP99.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152IAUE93.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152PIAE66.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152AENT57.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152LSON48.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152AEIL95.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152USOM81.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152AMEA59.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152TATE08.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.State.element[dataItem.uid].style'>#if (State !== null) {# #=State# #}#</span>",
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152VLNR47.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152TRTS26.control,
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
                    editor: $scope.vc.grids.QV_URYTH5890_66.AT_OTH152IHAE86.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_66.column.isHeritage.element[dataItem.uid].style'>#if (isHeritage !== null) {# #=isHeritage# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_66.column.isHeritage.style",
                        "title": "{{vc.viewState.QV_URYTH5890_66.column.isHeritage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_66.column.isHeritage.hidden
                });
            }
            $scope.vc.viewState.QV_URYTH5890_66.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_66.columns.push({
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_URYTH5890_66.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_URYTH5890_66.toolbar = {}
            $scope.vc.grids.QV_URYTH5890_66.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_16_NTATT53_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_16_NTATT53_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Asoaciar
            $scope.vc.createViewState({
                id: "CM_NTATT53AAR41",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ASSOCIATE_40673",
                haslabelArgs: true,
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
                $scope.vc.render('VC_NTATT53_WAACE_467');
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
    var cobisMainModule = cobis.createModule("VC_NTATT53_WAACE_467", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_NTATT53_WAACE_467", {
            templateUrl: "VC_NTATT53_WAACE_467_FORM.html",
            controller: "VC_NTATT53_WAACE_467_CTRL",
            label: "EntryWarrantyTicket",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_NTATT53_WAACE_467?" + $.param(search);
            }
        });
        VC_NTATT53_WAACE_467(cobisMainModule);
    }]);
} else {
    VC_NTATT53_WAACE_467(cobisMainModule);
}