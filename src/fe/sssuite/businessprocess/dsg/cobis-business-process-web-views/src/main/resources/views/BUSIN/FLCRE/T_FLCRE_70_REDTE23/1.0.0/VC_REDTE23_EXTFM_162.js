<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskextendedcreditline = designerEvents.api.taskextendedcreditline || designer.dsgEvents();

function VC_REDTE23_EXTFM_162(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REDTE23_EXTFM_162_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REDTE23_EXTFM_162_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_70_REDTE23",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REDTE23_EXTFM_162",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_70_REDTE23",
        designerEvents.api.taskextendedcreditline,
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
                vcName: 'VC_REDTE23_EXTFM_162'
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
                    taskId: 'T_FLCRE_70_REDTE23',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Context: "Context",
                    OriginalHeader: "OriginalHeader",
                    CustomerReference: "CustomerReference",
                    LineHeader: "LineHeader",
                    DebtorGeneral: "DebtorGeneral",
                    Flag: "Flag",
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
                    Flag: {
                        flag: 'AT_FLA641FLAG90',
                        _pks: [],
                        _entityId: 'EN_FLAGDMKRN641',
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
            $scope.vc.queryProperties.Q_QURRFRNE_6164 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_QURRFRNE_6164 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_QURRFRNE_6164 = {
                mainEntityPk: {
                    entityId: 'EN_TOMREFREC822',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_QURRFRNE_6164',
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
            defaultValues = {
                Context: {},
                OriginalHeader: {},
                CustomerReference: {},
                LineHeader: {},
                DebtorGeneral: {},
                Flag: {},
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
            $scope.vc.viewState.VC_REDTE23_EXTFM_162 = {
                style: []
            }
            //ViewState - Container: formExtendedCreditLine
            $scope.vc.createViewState({
                id: "VC_REDTE23_EXTFM_162",
                hasId: true,
                componentStyle: "",
                label: 'formExtendedCreditLine',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ApplicationHeader
            $scope.vc.createViewState({
                id: "VC_REDTE23_PCIEA_000",
                hasId: true,
                componentStyle: "",
                label: 'ApplicationHeader',
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
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
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
                label: "BUSIN.DLB_BUSIN_FEHAINGRS_62019",
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
                id: "VC_REDTE23_BRROI_186",
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
            }]; //ViewState - Container: CustomerReference
            $scope.vc.createViewState({
                id: "VC_REDTE23_UEREN_028",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VFDCUSDAA_51219",
                haslabelArgs: true,
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
            });;
            $scope.vc.model.CustomerReference = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_QURRFRNE_6164', function(data) {
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
                    var dataView = null;
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
                format: "n0",
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
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,0",
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
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,0",
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
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,0",
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
                        'data-cobis-group': "Group,GR_USTMRENCVW39_48,0",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
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
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-true-value': "'1'",
                        'ng-false-value': "'0'",
                        'ng-model': 'options_QV_QURRF6164_42.model.Result',
                        'ng-class': 'vc.viewState.QV_QURRF6164_42.column.Result.element["' + options.model.uid + '"].style'
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
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
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
            $scope.vc.grids.QV_QURRF6164_42.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_70_REDTE23_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_70_REDTE23_CANCEL",
                componentStyle: "",
                label: 'Cancel',
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
            $scope.vc.model.Flag = {
                flag: $scope.vc.channelDefaultValues("Flag", "flag")
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
                $scope.vc.render('VC_REDTE23_EXTFM_162');
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
    var cobisMainModule = cobis.createModule("VC_REDTE23_EXTFM_162", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_REDTE23_EXTFM_162", {
            templateUrl: "VC_REDTE23_EXTFM_162_FORM.html",
            controller: "VC_REDTE23_EXTFM_162_CTRL",
            label: "formExtendedCreditLine",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REDTE23_EXTFM_162?" + $.param(search);
            }
        });
        VC_REDTE23_EXTFM_162(cobisMainModule);
    }]);
} else {
    VC_REDTE23_EXTFM_162(cobisMainModule);
}