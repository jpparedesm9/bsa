<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.officialassigwarrantiesticket = designerEvents.api.officialassigwarrantiesticket || designer.dsgEvents();

function VC_FILWA58_IAAAE_126(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_FILWA58_IAAAE_126_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_FILWA58_IAAAE_126_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_23_FILWA58",
            taskVersion: "1.0.0",
            viewContainerId: "VC_FILWA58_IAAAE_126",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_23_FILWA58",
        designerEvents.api.officialassigwarrantiesticket,
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
                vcName: 'VC_FILWA58_IAAAE_126'
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
                    taskId: 'T_FLCRE_23_FILWA58',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Context: "Context",
                    OfficialLoadAll: "OfficialLoadAll",
                    HeaderGuaranteesTicket: "HeaderGuaranteesTicket",
                    OriginalHeader: "OriginalHeader",
                    Official: "Official",
                    CentralInternalReasons: "CentralInternalReasons",
                    DebtorGeneral: "DebtorGeneral",
                    OfficialLoad: "OfficialLoad"
                },
                entities: {
                    Context: {
                        Application: 'AT_CON762APCI65',
                        RequestId: 'AT_CON762EUTD32',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        CustomerId: 'AT_CON762CSTE68',
                        Bookmark: 'AT_CON762BKAK11',
                        Type: 'AT_CON762FLAG45',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OfficialLoadAll: {
                        CodeOfficial: 'AT_OFF597DECI03',
                        Name: 'AT_OFF597NAME30',
                        InProcess: 'AT_OFF597PROS49',
                        Disbursed: 'AT_OFF597ISSD63',
                        _pks: [],
                        _entityId: 'EN_OFFICALDA597',
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
                    Official: {
                        Official: 'AT_OFF156OFIL09',
                        Destinatario: 'AT_OFF156DSIN25',
                        _pks: [],
                        _entityId: 'EN_OFFICIALN156',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CentralInternalReasons: {
                        IdCustomer: 'AT_CIR228USTO98',
                        Role: 'AT_CIR228ROLM68',
                        Reason: 'AT_CIR228REAO75',
                        _pks: [],
                        _entityId: 'EN_CIRARESOS228',
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
                    },
                    OfficialLoad: {
                        CodeOfficial: 'AT_OIC020DEIA61',
                        Name: 'AT_OIC020NAME59',
                        InProcess: 'AT_OIC020IPOE45',
                        Disbursed: 'AT_OIC020ISRS30',
                        _pks: [],
                        _entityId: 'EN_OICIALLOA020',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_BOREGEEL_0798 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_BOREGEEL_0798 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_BOREGEEL_0798 = {
                mainEntityPk: {
                    entityId: 'EN_DEBTORHHW342',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_BOREGEEL_0798',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queryProperties.Q_RYFCALLA_8403 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_RYFCALLA_8403 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_RYFCALLA_8403 = {
                mainEntityPk: {
                    entityId: 'EN_OFFICALDA597',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_RYFCALLA_8403',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queryProperties.Q_OFFIALOA_3873 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_OFFIALOA_3873 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_OFFIALOA_3873 = {
                mainEntityPk: {
                    entityId: 'EN_OICIALLOA020',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_OFFIALOA_3873',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queryProperties.Q_NUTERNAS_6889 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_NUTERNAS_6889 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_NUTERNAS_6889 = {
                mainEntityPk: {
                    entityId: 'EN_CIRARESOS228',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_NUTERNAS_6889',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {};
                    }
                }
            };
            defaultValues = {
                Context: {},
                OfficialLoadAll: {},
                HeaderGuaranteesTicket: {},
                OriginalHeader: {},
                Official: {},
                CentralInternalReasons: {},
                DebtorGeneral: {},
                OfficialLoad: {}
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
            $scope.vc.executeCRUDQuery = function(queryId, loadInModel) {
                var queryRequest = $scope.vc.request.qr[queryId];
                return $scope.vc.CRUDExecuteQueryId(queryRequest, loadInModel);
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
            $scope.vc.viewState.VC_FILWA58_IAAAE_126 = {
                style: []
            }
            //ViewState - Container: OfficialAssigWarrantiesTicket
            $scope.vc.createViewState({
                id: "VC_FILWA58_IAAAE_126",
                hasId: true,
                componentStyle: "",
                label: 'OfficialAssigWarrantiesTicket',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Oficial
            $scope.vc.createViewState({
                id: "VC_FILWA58_OICAL_487",
                hasId: true,
                componentStyle: "",
                label: 'Oficial',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OFICIALOBG21_00",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Official = {
                Official: $scope.vc.channelDefaultValues("Official", "Official"),
                Destinatario: $scope.vc.channelDefaultValues("Official", "Destinatario")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OFICIALOBG21_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Official, Attribute: Official
            $scope.vc.createViewState({
                id: "VA_OFICIALOBG2103_OFIL240",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICIALR_02742",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICIALOBG2103_OFIL240 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OFICIALOBG2103_OFIL240', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OFICIALOBG2103_OFIL240'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICIALOBG2103_OFIL240");
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
            //ViewState - Entity: Official, Attribute: Destinatario
            $scope.vc.createViewState({
                id: "VA_OFICIALOBG2103_DSIN835",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: Cabecera Boletas Garantias
            $scope.vc.createViewState({
                id: "VC_FILWA58_BATAG_863",
                hasId: true,
                componentStyle: "",
                label: 'Cabecera Boletas Garantias',
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
                validationCode: 32,
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
                validationCode: 32,
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
                validationCode: 32,
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
            //ViewState - Container: Borrower
            $scope.vc.createViewState({
                id: "VC_FILWA58_ORWER_121",
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
                            $scope.vc.CRUDExecuteQuery('Q_BOREGEEL_0798', function(data) {
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
                        'placeholder': "{{dateFormatPlaceFormat}}",
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
            }]; //ViewState - Container: Oficiales
            $scope.vc.createViewState({
                id: "VC_FILWA58_FICLS_509",
                hasId: true,
                componentStyle: "",
                label: 'Oficiales',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: officialLoadAll
            $scope.vc.createViewState({
                id: "GR_OFCIALODEW43_69",
                hasId: true,
                componentStyle: "",
                label: 'officialLoadAll',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: OfficialLoad
            $scope.vc.createViewState({
                id: "GR_OFCIALODEW43_58",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OICIAESSG_79411",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.OfficialLoad = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CodeOfficial: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoad", "CodeOfficial", 0)
                    },
                    Name: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoad", "Name", '')
                    },
                    InProcess: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoad", "InProcess", 0)
                    },
                    Disbursed: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoad", "Disbursed", 0)
                    }
                }
            });;
            $scope.vc.model.OfficialLoad = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_OFFIALOA_3873', function(data) {
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
                    model: $scope.vc.types.OfficialLoad
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_OFFIA3873_31").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_OFFIALOA_3873 = $scope.vc.model.OfficialLoad;
            $scope.vc.trackers.OfficialLoad = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.OfficialLoad);
            $scope.vc.model.OfficialLoad.bind('change', function(e) {
                $scope.vc.trackers.OfficialLoad.track(e);
            });
            $scope.vc.grids.QV_OFFIA3873_31 = {};
            $scope.vc.grids.QV_OFFIA3873_31.queryId = 'Q_OFFIALOA_3873';
            $scope.vc.viewState.QV_OFFIA3873_31 = {
                style: undefined
            };
            $scope.vc.viewState.QV_OFFIA3873_31.column = {};
            $scope.vc.grids.QV_OFFIA3873_31.events = {
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
                    $scope.vc.trackers.OfficialLoad.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_OFFIA3873_31.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_OFFIA3873_31");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_OFFIA3873_31.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_OFFIA3873_31.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_OFFIA3873_31.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "OfficialLoad",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_OFFIA3873_31", args);
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
            $scope.vc.grids.QV_OFFIA3873_31.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_OFFIA3873_31.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_OFFIA3873_31.column.CodeOfficial = {
                title: 'BUSIN.DLB_BUSIN_ODEOFFCAL_38210',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4358_DEIA865',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020DEIA61 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4358_DEIA865",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.format",
                        'k-decimals': "vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,0",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OFFIA3873_31.column.Name = {
                title: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4358_NAME146',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020NAME59 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.Name.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4358_NAME146",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_31.column.Name.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,0",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.Name.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_31.column.Name.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OFFIA3873_31.column.InProcess = {
                title: 'BUSIN.DLB_BUSIN_INPROCESS_99127',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4358_IPOE985',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020IPOE45 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.InProcess.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4358_IPOE985",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_31.column.InProcess.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_OFFIA3873_31.column.InProcess.format",
                        'k-decimals': "vc.viewState.QV_OFFIA3873_31.column.InProcess.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,0",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.InProcess.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_31.column.InProcess.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OFFIA3873_31.column.Disbursed = {
                title: 'BUSIN.DLB_BUSIN_DISBURSED_78118',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4358_ISRS167',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020ISRS30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.Disbursed.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4358_ISRS167",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_31.column.Disbursed.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_OFFIA3873_31.column.Disbursed.format",
                        'k-decimals': "vc.viewState.QV_OFFIA3873_31.column.Disbursed.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,0",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_31.column.Disbursed.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_31.column.Disbursed.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_31.columns.push({
                    field: 'CodeOfficial',
                    title: '{{vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.title|translate:vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020DEIA61.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.element[dataItem.uid].style' ng-bind='kendo.toString(#=CodeOfficial#, vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_31.column.CodeOfficial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_31.columns.push({
                    field: 'Name',
                    title: '{{vc.viewState.QV_OFFIA3873_31.column.Name.title|translate:vc.viewState.QV_OFFIA3873_31.column.Name.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_31.column.Name.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_31.column.Name.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020NAME59.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_31.column.Name.element[dataItem.uid].style'>#if (Name !== null) {# #=Name# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_OFFIA3873_31.column.Name.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_31.column.Name.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_31.column.Name.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_31.columns.push({
                    field: 'InProcess',
                    title: '{{vc.viewState.QV_OFFIA3873_31.column.InProcess.title|translate:vc.viewState.QV_OFFIA3873_31.column.InProcess.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_31.column.InProcess.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_31.column.InProcess.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020IPOE45.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_31.column.InProcess.element[dataItem.uid].style' ng-bind='kendo.toString(#=InProcess#, vc.viewState.QV_OFFIA3873_31.column.InProcess.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_OFFIA3873_31.column.InProcess.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_31.column.InProcess.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_31.column.InProcess.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_31.columns.push({
                    field: 'Disbursed',
                    title: '{{vc.viewState.QV_OFFIA3873_31.column.Disbursed.title|translate:vc.viewState.QV_OFFIA3873_31.column.Disbursed.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_31.column.Disbursed.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_31.column.Disbursed.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_31.AT_OIC020ISRS30.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_31.column.Disbursed.element[dataItem.uid].style' ng-bind='kendo.toString(#=Disbursed#, vc.viewState.QV_OFFIA3873_31.column.Disbursed.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_OFFIA3873_31.column.Disbursed.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_31.column.Disbursed.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_31.column.Disbursed.hidden
                });
            }
            $scope.vc.viewState.QV_OFFIA3873_31.toolbar = {}
            $scope.vc.grids.QV_OFFIA3873_31.toolbar = [];
            //ViewState - Group: OfficialLoadAll
            $scope.vc.createViewState({
                id: "GR_OFCIALODEW43_05",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OISPONIBS_89367",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.OfficialLoadAll = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CodeOfficial: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoadAll", "CodeOfficial", 0)
                    },
                    Name: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoadAll", "Name", '')
                    },
                    InProcess: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoadAll", "InProcess", 0)
                    },
                    Disbursed: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OfficialLoadAll", "Disbursed", 0)
                    }
                }
            });;
            $scope.vc.model.OfficialLoadAll = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_RYFCALLA_8403', function(data) {
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
                    model: $scope.vc.types.OfficialLoadAll
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_OFFIA3873_22").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RYFCALLA_8403 = $scope.vc.model.OfficialLoadAll;
            $scope.vc.trackers.OfficialLoadAll = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.OfficialLoadAll);
            $scope.vc.model.OfficialLoadAll.bind('change', function(e) {
                $scope.vc.trackers.OfficialLoadAll.track(e);
            });
            $scope.vc.grids.QV_OFFIA3873_22 = {};
            $scope.vc.grids.QV_OFFIA3873_22.queryId = 'Q_RYFCALLA_8403';
            $scope.vc.viewState.QV_OFFIA3873_22 = {
                style: undefined
            };
            $scope.vc.viewState.QV_OFFIA3873_22.column = {};
            $scope.vc.grids.QV_OFFIA3873_22.events = {
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
                    $scope.vc.trackers.OfficialLoadAll.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_OFFIA3873_22.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_OFFIA3873_22");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_OFFIA3873_22.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_OFFIA3873_22.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_OFFIA3873_22.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "OfficialLoadAll",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_OFFIA3873_22", args);
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
            $scope.vc.grids.QV_OFFIA3873_22.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_OFFIA3873_22.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_OFFIA3873_22.column.CodeOfficial = {
                title: 'BUSIN.DLB_BUSIN_ODEOFFCAL_38210',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4305_DECI088',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597DECI03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4305_DECI088",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.format",
                        'k-decimals': "vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,1",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OFFIA3873_22.column.Name = {
                title: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4305_NAME879',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597NAME30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.Name.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4305_NAME879",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_22.column.Name.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,1",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.Name.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_22.column.Name.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OFFIA3873_22.column.InProcess = {
                title: 'BUSIN.DLB_BUSIN_INPROCESS_99127',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4305_PROS015',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597PROS49 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.InProcess.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4305_PROS015",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_22.column.InProcess.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_OFFIA3873_22.column.InProcess.format",
                        'k-decimals': "vc.viewState.QV_OFFIA3873_22.column.InProcess.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,1",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.InProcess.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_22.column.InProcess.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OFFIA3873_22.column.Disbursed = {
                title: 'BUSIN.DLB_BUSIN_DISBURSED_78118',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4305_ISSD865',
                element: []
            };
            $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597ISSD63 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.Disbursed.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4305_ISSD865",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_OFFIA3873_22.column.Disbursed.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_OFFIA3873_22.column.Disbursed.format",
                        'k-decimals': "vc.viewState.QV_OFFIA3873_22.column.Disbursed.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,1",
                        'ng-disabled': "!vc.viewState.QV_OFFIA3873_22.column.Disbursed.enabled",
                        'ng-class': "vc.viewState.QV_OFFIA3873_22.column.Disbursed.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_22.columns.push({
                    field: 'CodeOfficial',
                    title: '{{vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.title|translate:vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597DECI03.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.element[dataItem.uid].style' ng-bind='kendo.toString(#=CodeOfficial#, vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_22.column.CodeOfficial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_22.columns.push({
                    field: 'Name',
                    title: '{{vc.viewState.QV_OFFIA3873_22.column.Name.title|translate:vc.viewState.QV_OFFIA3873_22.column.Name.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_22.column.Name.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_22.column.Name.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597NAME30.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_22.column.Name.element[dataItem.uid].style'>#if (Name !== null) {# #=Name# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_OFFIA3873_22.column.Name.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_22.column.Name.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_22.column.Name.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_22.columns.push({
                    field: 'InProcess',
                    title: '{{vc.viewState.QV_OFFIA3873_22.column.InProcess.title|translate:vc.viewState.QV_OFFIA3873_22.column.InProcess.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_22.column.InProcess.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_22.column.InProcess.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597PROS49.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_22.column.InProcess.element[dataItem.uid].style' ng-bind='kendo.toString(#=InProcess#, vc.viewState.QV_OFFIA3873_22.column.InProcess.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_OFFIA3873_22.column.InProcess.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_22.column.InProcess.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_22.column.InProcess.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OFFIA3873_22.columns.push({
                    field: 'Disbursed',
                    title: '{{vc.viewState.QV_OFFIA3873_22.column.Disbursed.title|translate:vc.viewState.QV_OFFIA3873_22.column.Disbursed.titleArgs}}',
                    width: $scope.vc.viewState.QV_OFFIA3873_22.column.Disbursed.width,
                    format: $scope.vc.viewState.QV_OFFIA3873_22.column.Disbursed.format,
                    editor: $scope.vc.grids.QV_OFFIA3873_22.AT_OFF597ISSD63.control,
                    template: "<span ng-class='vc.viewState.QV_OFFIA3873_22.column.Disbursed.element[dataItem.uid].style' ng-bind='kendo.toString(#=Disbursed#, vc.viewState.QV_OFFIA3873_22.column.Disbursed.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_OFFIA3873_22.column.Disbursed.style",
                        "title": "{{vc.viewState.QV_OFFIA3873_22.column.Disbursed.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_OFFIA3873_22.column.Disbursed.hidden
                });
            }
            $scope.vc.viewState.QV_OFFIA3873_22.toolbar = {}
            $scope.vc.grids.QV_OFFIA3873_22.toolbar = [];
            //ViewState - Group: CentralInternalReasons
            $scope.vc.createViewState({
                id: "GR_OFCIALODEW43_04",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NNLEAONON_21217",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CentralInternalReasons = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("CentralInternalReasons", "IdCustomer", 0)
                    },
                    Role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CentralInternalReasons", "Role", '')
                    },
                    Reason: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CentralInternalReasons", "Reason", '')
                    }
                }
            });;
            $scope.vc.model.CentralInternalReasons = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_NUTERNAS_6889', function(data) {
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
                    model: $scope.vc.types.CentralInternalReasons
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_NUTER6889_40").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_NUTERNAS_6889 = $scope.vc.model.CentralInternalReasons;
            $scope.vc.trackers.CentralInternalReasons = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CentralInternalReasons);
            $scope.vc.model.CentralInternalReasons.bind('change', function(e) {
                $scope.vc.trackers.CentralInternalReasons.track(e);
            });
            $scope.vc.grids.QV_NUTER6889_40 = {};
            $scope.vc.grids.QV_NUTER6889_40.queryId = 'Q_NUTERNAS_6889';
            $scope.vc.viewState.QV_NUTER6889_40 = {
                style: undefined
            };
            $scope.vc.viewState.QV_NUTER6889_40.column = {};
            $scope.vc.grids.QV_NUTER6889_40.events = {
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
                    $scope.vc.trackers.CentralInternalReasons.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_NUTER6889_40.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_NUTER6889_40");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_NUTER6889_40.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_NUTER6889_40.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_NUTER6889_40.column.IdCustomer = {
                title: 'BUSIN.DLB_BUSIN_CUSTOMERK_83530',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4304_USTO161',
                element: []
            };
            $scope.vc.grids.QV_NUTER6889_40.AT_CIR228USTO98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_NUTER6889_40.column.IdCustomer.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4304_USTO161",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_NUTER6889_40.column.IdCustomer.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_NUTER6889_40.column.IdCustomer.format",
                        'k-decimals': "vc.viewState.QV_NUTER6889_40.column.IdCustomer.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,2",
                        'ng-disabled': "!vc.viewState.QV_NUTER6889_40.column.IdCustomer.enabled",
                        'ng-class': "vc.viewState.QV_NUTER6889_40.column.IdCustomer.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_NUTER6889_40.column.Role = {
                title: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4304_ROLM410',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OFCIALODEW4304_ROLM410 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OFCIALODEW4304_ROLM410_values)) {
                            $scope.vc.catalogs.VA_OFCIALODEW4304_ROLM410_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OFCIALODEW4304_ROLM410',
                                'cr_cat_deudor',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OFCIALODEW4304_ROLM410'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OFCIALODEW4304_ROLM410_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_NUTER6889_40", "VA_OFCIALODEW4304_ROLM410");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OFCIALODEW4304_ROLM410_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_NUTER6889_40", "VA_OFCIALODEW4304_ROLM410");
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
            $scope.vc.grids.QV_NUTER6889_40.AT_CIR228ROLM68 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_NUTER6889_40.column.Role.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4304_ROLM410",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_NUTER6889_40.column.Role.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OFCIALODEW4304_ROLM410",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_NUTER6889_40.column.Role.template",
                        'data-validation-code': "{{vc.viewState.QV_NUTER6889_40.column.Role.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,2",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_NUTER6889_40.column.Reason = {
                title: 'BUSIN.DLB_BUSIN_REASONMLS_18269',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OFCIALODEW4304_REAO588',
                element: []
            };
            $scope.vc.grids.QV_NUTER6889_40.AT_CIR228REAO75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_NUTER6889_40.column.Reason.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OFCIALODEW4304_REAO588",
                        'maxlength': 1.000,
                        'data-validation-code': "{{vc.viewState.QV_NUTER6889_40.column.Reason.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OFCIALODEW43_69,2",
                        'ng-disabled': "!vc.viewState.QV_NUTER6889_40.column.Reason.enabled",
                        'ng-class': "vc.viewState.QV_NUTER6889_40.column.Reason.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_NUTER6889_40.columns.push({
                    field: 'IdCustomer',
                    title: '{{vc.viewState.QV_NUTER6889_40.column.IdCustomer.title|translate:vc.viewState.QV_NUTER6889_40.column.IdCustomer.titleArgs}}',
                    width: $scope.vc.viewState.QV_NUTER6889_40.column.IdCustomer.width,
                    format: $scope.vc.viewState.QV_NUTER6889_40.column.IdCustomer.format,
                    editor: $scope.vc.grids.QV_NUTER6889_40.AT_CIR228USTO98.control,
                    template: "<span ng-class='vc.viewState.QV_NUTER6889_40.column.IdCustomer.element[dataItem.uid].style' ng-bind='kendo.toString(#=IdCustomer#, vc.viewState.QV_NUTER6889_40.column.IdCustomer.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_NUTER6889_40.column.IdCustomer.style",
                        "title": "{{vc.viewState.QV_NUTER6889_40.column.IdCustomer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_NUTER6889_40.column.IdCustomer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_NUTER6889_40.columns.push({
                    field: 'Role',
                    title: '{{vc.viewState.QV_NUTER6889_40.column.Role.title|translate:vc.viewState.QV_NUTER6889_40.column.Role.titleArgs}}',
                    width: $scope.vc.viewState.QV_NUTER6889_40.column.Role.width,
                    format: $scope.vc.viewState.QV_NUTER6889_40.column.Role.format,
                    editor: $scope.vc.grids.QV_NUTER6889_40.AT_CIR228ROLM68.control,
                    template: "<span ng-class='vc.viewState.QV_NUTER6889_40.column.Role.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OFCIALODEW4304_ROLM410.get(dataItem.Role).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_NUTER6889_40.column.Role.style",
                        "title": "{{vc.viewState.QV_NUTER6889_40.column.Role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_NUTER6889_40.column.Role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_NUTER6889_40.columns.push({
                    field: 'Reason',
                    title: '{{vc.viewState.QV_NUTER6889_40.column.Reason.title|translate:vc.viewState.QV_NUTER6889_40.column.Reason.titleArgs}}',
                    width: $scope.vc.viewState.QV_NUTER6889_40.column.Reason.width,
                    format: $scope.vc.viewState.QV_NUTER6889_40.column.Reason.format,
                    editor: $scope.vc.grids.QV_NUTER6889_40.AT_CIR228REAO75.control,
                    template: "<span ng-class='vc.viewState.QV_NUTER6889_40.column.Reason.element[dataItem.uid].style'>#if (Reason !== null) {# #=Reason# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_NUTER6889_40.column.Reason.style",
                        "title": "{{vc.viewState.QV_NUTER6889_40.column.Reason.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_NUTER6889_40.column.Reason.hidden
                });
            }
            $scope.vc.viewState.QV_NUTER6889_40.toolbar = {}
            $scope.vc.grids.QV_NUTER6889_40.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_23_FILWA58_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_23_FILWA58_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: SaveCmd
            $scope.vc.createViewState({
                id: "CM_FILWA58SVE22",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                Type: $scope.vc.channelDefaultValues("Context", "Type")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256.read();
                    $scope.vc.catalogs.VA_OFCIALODEW4304_ROLM410.read();
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
                $scope.vc.render('VC_FILWA58_IAAAE_126');
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
    var cobisMainModule = cobis.createModule("VC_FILWA58_IAAAE_126", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_FILWA58_IAAAE_126", {
            templateUrl: "VC_FILWA58_IAAAE_126_FORM.html",
            controller: "VC_FILWA58_IAAAE_126_CTRL",
            label: "OfficialAssigWarrantiesTicket",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_FILWA58_IAAAE_126?" + $.param(search);
            }
        });
        VC_FILWA58_IAAAE_126(cobisMainModule);
    }]);
} else {
    VC_FILWA58_IAAAE_126(cobisMainModule);
}