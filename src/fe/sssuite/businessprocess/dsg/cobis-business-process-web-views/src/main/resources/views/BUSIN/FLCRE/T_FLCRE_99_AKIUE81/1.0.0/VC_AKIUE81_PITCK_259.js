<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskprintguaranteetickets = designerEvents.api.taskprintguaranteetickets || designer.dsgEvents();

function VC_AKIUE81_PITCK_259(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_AKIUE81_PITCK_259_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_AKIUE81_PITCK_259_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_99_AKIUE81",
            taskVersion: "1.0.0",
            viewContainerId: "VC_AKIUE81_PITCK_259",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_99_AKIUE81",
        designerEvents.api.taskprintguaranteetickets,
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
                vcName: 'VC_AKIUE81_PITCK_259'
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
                    taskId: 'T_FLCRE_99_AKIUE81',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Context: "Context",
                    HeaderGuaranteesTicket: "HeaderGuaranteesTicket",
                    OriginalHeader: "OriginalHeader",
                    DocumentProduct: "DocumentProduct"
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
                    DocumentProduct: {
                        Document: 'AT_OUM175DOUN12',
                        YesNot: 'AT_OUM175YSNO59',
                        Nemonic: 'AT_OUM175NONC04',
                        Description: 'AT_OUM175SITO30',
                        NroImpressions: 'AT_OUM175NMON61',
                        Template: 'AT_OUM175TEME23',
                        ReportParamGuarantor: 'AT_OUM175AANT23',
                        _pks: [],
                        _entityId: 'EN_OUMTPROUT175',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QDMNTPRO_8051 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_QDMNTPRO_8051 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_QDMNTPRO_8051 = {
                mainEntityPk: {
                    entityId: 'EN_OUMTPROUT175',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_QDMNTPRO_8051',
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
                HeaderGuaranteesTicket: {},
                OriginalHeader: {},
                DocumentProduct: {}
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
            $scope.vc.viewState.VC_AKIUE81_PITCK_259 = {
                style: []
            }
            //ViewState - Container: FPrintGuaranteesTicket
            $scope.vc.createViewState({
                id: "VC_AKIUE81_PITCK_259",
                hasId: true,
                componentStyle: "",
                label: 'FPrintGuaranteesTicket',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: [ViewGuaranteeTicket]
            $scope.vc.createViewState({
                id: "VC_AKIUE81_AAECT_512",
                hasId: true,
                componentStyle: "",
                label: '[ViewGuaranteeTicket]',
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
            //ViewState - Container: [DocumentsPrint]
            $scope.vc.createViewState({
                id: "VC_AKIUE81_UPRIN_681",
                hasId: true,
                componentStyle: "",
                label: '[DocumentsPrint]',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_02",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DocumentProduct = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Document: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "Document", '')
                    },
                    Nemonic: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "Nemonic", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "Description", '')
                    },
                    NroImpressions: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "NroImpressions", '')
                    },
                    YesNot: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "YesNot", false)
                    }
                }
            });;
            $scope.vc.model.DocumentProduct = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_QDMNTPRO_8051', function(data) {
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
                    model: $scope.vc.types.DocumentProduct
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QDMNT8051_16").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QDMNTPRO_8051 = $scope.vc.model.DocumentProduct;
            $scope.vc.trackers.DocumentProduct = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DocumentProduct);
            $scope.vc.model.DocumentProduct.bind('change', function(e) {
                $scope.vc.trackers.DocumentProduct.track(e);
            });
            $scope.vc.grids.QV_QDMNT8051_16 = {};
            $scope.vc.grids.QV_QDMNT8051_16.queryId = 'Q_QDMNTPRO_8051';
            $scope.vc.viewState.QV_QDMNT8051_16 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column = {};
            $scope.vc.grids.QV_QDMNT8051_16.events = {
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
                    $scope.vc.trackers.DocumentProduct.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QDMNT8051_16.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QDMNT8051_16");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_QDMNT8051_16.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_QDMNT8051_16.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_QDMNT8051_16.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "DocumentProduct",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_QDMNT8051_16", args);
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
            $scope.vc.grids.QV_QDMNT8051_16.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QDMNT8051_16.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QDMNT8051_16.column.Document = {
                title: 'BUSIN.DLB_BUSIN_DOCUMENTL_70141',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000409',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175DOUN12 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Document.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_0000409",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.Document.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_DOCUNODCVW73_02,0",
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Document.enabled",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.Document.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic = {
                title: 'BUSIN.DLB_BUSIN_MNEMONICW_31037',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000045',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NONC04 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Nemonic.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_0000045",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.Nemonic.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_DOCUNODCVW73_02,0",
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Nemonic.enabled",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.Nemonic.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000216',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175SITO30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_0000216",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_DOCUNODCVW73_02,0",
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Description.enabled",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions = {
                title: 'BUSIN.DLB_BUSIN_NOIPESONS_73030',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000674',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NMON61 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.NroImpressions.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_0000674",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.NroImpressions.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_DOCUNODCVW73_02,0",
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.NroImpressions.enabled",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.NroImpressions.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot = {
                title: 'BUSIN.DLB_BUSIN_YESNOTSDF_53122',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_YSNO533',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175YSNO59 = {
                control: function(container, options) {
                    $scope.options_QV_QDMNT8051_16 = options;
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.YesNot.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_YSNO533",
                        'ng-class': 'vc.viewState.QV_QDMNT8051_16.column.YesNot.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'Document',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.Document.title|translate:vc.viewState.QV_QDMNT8051_16.column.Document.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.Document.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.Document.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175DOUN12.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.Document.element[dataItem.uid].style'>#if (Document !== null) {# #=Document# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.Document.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.Document.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.Document.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'Nemonic',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.Nemonic.title|translate:vc.viewState.QV_QDMNT8051_16.column.Nemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NONC04.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.Nemonic.element[dataItem.uid].style'>#if (Nemonic !== null) {# #=Nemonic# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.Nemonic.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.Nemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.Description.title|translate:vc.viewState.QV_QDMNT8051_16.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.Description.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.Description.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175SITO30.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.Description.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'NroImpressions',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.NroImpressions.title|translate:vc.viewState.QV_QDMNT8051_16.column.NroImpressions.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NMON61.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.NroImpressions.element[dataItem.uid].style'>#if (NroImpressions !== null) {# #=NroImpressions# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.NroImpressions.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.NroImpressions.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'YesNot',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.YesNot.title|translate:vc.viewState.QV_QDMNT8051_16.column.YesNot.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_QDMNT8051_16', 'YesNot', $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175YSNO59.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_QDMNT8051_16', 'YesNot'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.YesNot.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.YesNot.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot.hidden
                });
            }
            $scope.vc.viewState.QV_QDMNT8051_16.toolbar = {}
            $scope.vc.grids.QV_QDMNT8051_16.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_99_AKIUE81_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_99_AKIUE81_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: CMPrintGuarantee
            $scope.vc.createViewState({
                id: "CM_AKIUE81RNN18",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_IMPRIMIRH_85279",
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
                $scope.vc.render('VC_AKIUE81_PITCK_259');
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
    var cobisMainModule = cobis.createModule("VC_AKIUE81_PITCK_259", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_AKIUE81_PITCK_259", {
            templateUrl: "VC_AKIUE81_PITCK_259_FORM.html",
            controller: "VC_AKIUE81_PITCK_259_CTRL",
            label: "FPrintGuaranteesTicket",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_AKIUE81_PITCK_259?" + $.param(search);
            }
        });
        VC_AKIUE81_PITCK_259(cobisMainModule);
    }]);
} else {
    VC_AKIUE81_PITCK_259(cobisMainModule);
}