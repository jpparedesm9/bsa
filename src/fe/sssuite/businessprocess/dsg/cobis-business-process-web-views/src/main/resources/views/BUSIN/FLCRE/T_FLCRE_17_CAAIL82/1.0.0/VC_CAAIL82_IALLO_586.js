<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.officialactivityallocation = designerEvents.api.officialactivityallocation || designer.dsgEvents();

function VC_CAAIL82_IALLO_586(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CAAIL82_IALLO_586_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CAAIL82_IALLO_586_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_17_CAAIL82",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CAAIL82_IALLO_586",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_17_CAAIL82",
        designerEvents.api.officialactivityallocation,
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
                vcName: 'VC_CAAIL82_IALLO_586'
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
                    taskId: 'T_FLCRE_17_CAAIL82',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Context: "Context",
                    OfficialLoadAll: "OfficialLoadAll",
                    OriginalHeader: "OriginalHeader",
                    Official: "Official",
                    LineHeader: "LineHeader",
                    CentralInternalReasons: "CentralInternalReasons",
                    DebtorGeneral: "DebtorGeneral",
                    OfficialLoad: "OfficialLoad",
                    InfocredHeader: "InfocredHeader"
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
                OriginalHeader: {},
                Official: {},
                LineHeader: {},
                CentralInternalReasons: {},
                DebtorGeneral: {},
                OfficialLoad: {},
                InfocredHeader: {}
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
            $scope.vc.viewState.VC_CAAIL82_IALLO_586 = {
                style: []
            }
            //ViewState - Container: FormOfficialActivityAllocation
            $scope.vc.createViewState({
                id: "VC_CAAIL82_IALLO_586",
                hasId: true,
                componentStyle: "",
                label: 'FormOfficialActivityAllocation',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Oficial
            $scope.vc.createViewState({
                id: "VC_CAAIL82_ICIAL_049",
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
            //ViewState - Container: Head
            $scope.vc.createViewState({
                id: "VC_CAAIL82_HEADS_971",
                hasId: true,
                componentStyle: "",
                label: 'Head',
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
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine")
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
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_URQT595', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_URQT595'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_URQT595");
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
            //ViewState - Container: Borrower
            $scope.vc.createViewState({
                id: "VC_CAAIL82_BORWR_709",
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
            }]; //ViewState - Container: OfficialLoad
            $scope.vc.createViewState({
                id: "VC_CAAIL82_CALAD_804",
                hasId: true,
                componentStyle: "",
                label: 'OfficialLoad',
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
                id: "T_FLCRE_17_CAAIL82_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_17_CAAIL82_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Save
            $scope.vc.createViewState({
                id: "CM_CAAIL82SAE52",
                componentStyle: "",
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
                $scope.vc.render('VC_CAAIL82_IALLO_586');
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
    var cobisMainModule = cobis.createModule("VC_CAAIL82_IALLO_586", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_CAAIL82_IALLO_586", {
            templateUrl: "VC_CAAIL82_IALLO_586_FORM.html",
            controller: "VC_CAAIL82_IALLO_586_CTRL",
            label: "FormOfficialActivityAllocation",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CAAIL82_IALLO_586?" + $.param(search);
            }
        });
        VC_CAAIL82_IALLO_586(cobisMainModule);
    }]);
} else {
    VC_CAAIL82_IALLO_586(cobisMainModule);
}