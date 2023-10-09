<!-- Designer Generator v 5.0.0.1601 - release SPR 2016-01 20/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.warrantymodify = designerEvents.api.warrantymodify || designer.dsgEvents();

function VC_WRRAO83_TYDIY_402(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_WRRAO83_TYDIY_402_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_WRRAO83_TYDIY_402_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_25_WRRAO83",
            taskVersion: "1.0.0",
            viewContainerId: "VC_WRRAO83_TYDIY_402",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_25_WRRAO83",
        designerEvents.api.warrantymodify,
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
                vcName: 'VC_WRRAO83_TYDIY_402'
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
                    taskId: 'T_FLCRE_25_WRRAO83',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    OriginalHeader: "OriginalHeader",
                    OtherWarranty: "OtherWarranty",
                    DebtorGeneral: "DebtorGeneral",
                    WarrantyHeaderRequest: "WarrantyHeaderRequest",
                    DocumentProduct: "DocumentProduct",
                    Exceptions: "Exceptions",
                    InfocredHeader: "InfocredHeader",
                    Context: "Context",
                    InfoPayment: "InfoPayment",
                    VariableExceptions: "VariableExceptions",
                    LineHeader: "LineHeader"
                },
                entities: {
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
                    WarrantyHeaderRequest: {
                        Type: 'AT_WAN577TYPE31',
                        RequestType: 'AT_WAN577RUEY04',
                        Amount: 'AT_WAN577MOUT51',
                        Currency: 'AT_WAN577RRCY90',
                        Balance: 'AT_WAN577BLAC50',
                        Term: 'AT_WAN577TERM99',
                        Reason: 'AT_WAN577RASO95',
                        _pks: [],
                        _entityId: 'EN_WANTYRUES577',
                        _entityVersion: '1.0.0',
                        _transient: false
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
                    },
                    Exceptions: {
                        mnemonic: 'AT_EXC513NONI25',
                        description: 'AT_EXC513RTIO01',
                        Aproved: 'AT_EXC513EULT52',
                        Authorized: 'AT_EXC513UOIZ62',
                        detail: 'AT_EXC513DETA22',
                        _pks: [],
                        _entityId: 'EN_EXCEPTINS513',
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
                    InfoPayment: {
                        titleColumn: 'AT_IFP499IEOL88',
                        agreedPayment: 'AT_IFP499AGAE69',
                        paymentPaid: 'AT_IFP499YMPD40',
                        balance: 'AT_IFP499BACE63',
                        _pks: [],
                        _entityId: 'EN_IFPAYMENT499',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VariableExceptions: {
                        VariableName: 'AT_ABL836RABM62',
                        VariableValue: 'AT_ABL836VBLE29',
                        VariableRule: 'AT_ABL836LELE47',
                        VariableDescription: 'AT_ABL836RSCP88',
                        _pks: [],
                        _entityId: 'EN_ABLEECPTO836',
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
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CWARANTY_2317 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_CWARANTY_2317 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_CWARANTY_2317 = {
                mainEntityPk: {
                    entityId: 'EN_OTHERANTY152',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_CWARANTY_2317',
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
            $scope.vc.queryProperties.Q_IFOPAYMN_9055 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_IFOPAYMN_9055 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_IFOPAYMN_9055 = {
                mainEntityPk: {
                    entityId: 'EN_IFPAYMENT499',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_IFOPAYMN_9055',
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
            $scope.vc.queryProperties.Q_UERXCPTS_4756 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_UERXCPTS_4756 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_UERXCPTS_4756 = {
                mainEntityPk: {
                    entityId: 'EN_EXCEPTINS513',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_UERXCPTS_4756',
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
            $scope.vc.queryProperties.Q_EAIBLEEP_2309 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_EAIBLEEP_2309 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_EAIBLEEP_2309 = {
                mainEntityPk: {
                    entityId: 'EN_ABLEECPTO836',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_EAIBLEEP_2309',
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
                OriginalHeader: {},
                OtherWarranty: {},
                DebtorGeneral: {},
                WarrantyHeaderRequest: {},
                DocumentProduct: {},
                Exceptions: {},
                InfocredHeader: {},
                Context: {},
                InfoPayment: {},
                VariableExceptions: {},
                LineHeader: {}
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
            $scope.vc.viewState.VC_WRRAO83_TYDIY_402 = {
                style: []
            }
            //ViewState - Container: WarrantyModify
            $scope.vc.createViewState({
                id: "VC_WRRAO83_TYDIY_402",
                hasId: true,
                componentStyle: "",
                label: 'WarrantyModify',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Panel para HeaderView
            $scope.vc.createViewState({
                id: "VC_WRRAO83_ALADR_815",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MOFCIDEAS_11538",
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
            //ViewState - Container: Panel para VWarrantyHeaderRequest
            $scope.vc.createViewState({
                id: "VC_WRRAO83_NRRED_631",
                hasId: true,
                componentStyle: "",
                label: 'Panel para VWarrantyHeaderRequest',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Principal
            $scope.vc.createViewState({
                id: "GR_WRRTAERRES11_51",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Principal',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.WarrantyHeaderRequest = {
                Type: $scope.vc.channelDefaultValues("WarrantyHeaderRequest", "Type"),
                RequestType: $scope.vc.channelDefaultValues("WarrantyHeaderRequest", "RequestType"),
                Amount: $scope.vc.channelDefaultValues("WarrantyHeaderRequest", "Amount"),
                Currency: $scope.vc.channelDefaultValues("WarrantyHeaderRequest", "Currency"),
                Balance: $scope.vc.channelDefaultValues("WarrantyHeaderRequest", "Balance"),
                Term: $scope.vc.channelDefaultValues("WarrantyHeaderRequest", "Term"),
                Reason: $scope.vc.channelDefaultValues("WarrantyHeaderRequest", "Reason")
            };
            //ViewState - Group: Panel_1 para WarrantyHeaderRequest
            $scope.vc.createViewState({
                id: "GR_WRRTAERRES11_99",
                hasId: true,
                componentStyle: "",
                label: 'Panel_1 para WarrantyHeaderRequest',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyHeaderRequest, Attribute: Type
            $scope.vc.createViewState({
                id: "VA_WRRTAERRES1199_TYPE485",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TISOLIIUD_96006",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WRRTAERRES1199_TYPE485 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WRRTAERRES1199_TYPE485', 'cr_tipo_solicitud', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WRRTAERRES1199_TYPE485'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WRRTAERRES1199_TYPE485");
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
            //ViewState - Entity: WarrantyHeaderRequest, Attribute: RequestType
            $scope.vc.createViewState({
                id: "VA_WRRTAERRES1199_RUEY376",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TYPECREIT_29679",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WRRTAERRES1199_RUEY376 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WRRTAERRES1199_RUEY376', 'ca_tipo_cartera', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WRRTAERRES1199_RUEY376'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WRRTAERRES1199_RUEY376");
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
            //ViewState - Entity: WarrantyHeaderRequest, Attribute: Amount
            $scope.vc.createViewState({
                id: "VA_WRRTAERRES1199_MOUT074",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONTOFVFP_36531",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyHeaderRequest, Attribute: Currency
            $scope.vc.createViewState({
                id: "VA_WRRTAERRES1199_RRCY912",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WRRTAERRES1199_RRCY912 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WRRTAERRES1199_RRCY912', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WRRTAERRES1199_RRCY912'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WRRTAERRES1199_RRCY912");
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
            //ViewState - Entity: WarrantyHeaderRequest, Attribute: Balance
            $scope.vc.createViewState({
                id: "VA_WRRTAERRES1199_BLAC194",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LDOECITAL_77904",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyHeaderRequest, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_WRRTAERRES1199_TERM768",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel_2 para WarrantyHeaderRequest
            $scope.vc.createViewState({
                id: "GR_WRRTAERRES11_95",
                hasId: true,
                componentStyle: "",
                label: 'Panel_2 para WarrantyHeaderRequest',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyHeaderRequest, Attribute: Reason
            $scope.vc.createViewState({
                id: "VA_WRRTAERRES1195_RASO850",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OTIVOSOIU_20945",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: Panel para VInfoPayment
            $scope.vc.createViewState({
                id: "VC_WRRAO83_RIOME_631",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ATOPEAION_63755",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor
            $scope.vc.createViewState({
                id: "GR_VNFOPAYMET19_72",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel para InfoPayment
            $scope.vc.createViewState({
                id: "GR_VNFOPAYMET19_83",
                hasId: true,
                componentStyle: "",
                label: 'Panel para InfoPayment',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.InfoPayment = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    titleColumn: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfoPayment", "titleColumn", '')
                    },
                    agreedPayment: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfoPayment", "agreedPayment", 0)
                    },
                    paymentPaid: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfoPayment", "paymentPaid", 0)
                    },
                    balance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfoPayment", "balance", 0)
                    }
                }
            });;
            $scope.vc.model.InfoPayment = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_IFOPAYMN_9055', function(data) {
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
                    model: $scope.vc.types.InfoPayment
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_IFOPA9055_49").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_IFOPAYMN_9055 = $scope.vc.model.InfoPayment;
            $scope.vc.trackers.InfoPayment = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.InfoPayment);
            $scope.vc.model.InfoPayment.bind('change', function(e) {
                $scope.vc.trackers.InfoPayment.track(e);
            });
            $scope.vc.grids.QV_IFOPA9055_49 = {};
            $scope.vc.grids.QV_IFOPA9055_49.queryId = 'Q_IFOPAYMN_9055';
            $scope.vc.viewState.QV_IFOPA9055_49 = {
                style: undefined
            };
            $scope.vc.viewState.QV_IFOPA9055_49.column = {};
            $scope.vc.grids.QV_IFOPA9055_49.events = {
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
                    $scope.vc.trackers.InfoPayment.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_IFOPA9055_49.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_IFOPA9055_49");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_IFOPA9055_49.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_IFOPA9055_49.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_IFOPA9055_49.column.titleColumn = {
                title: 'title',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VNFOPAYMET1983_IEOL733',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499IEOL88 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.titleColumn.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VNFOPAYMET1983_IEOL733",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.titleColumn.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VNFOPAYMET19_72,0",
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.titleColumn.enabled",
                        'ng-class': "vc.viewState.QV_IFOPA9055_49.column.titleColumn.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_IFOPA9055_49.column.agreedPayment = {
                title: 'BUSIN.DLB_BUSIN_ONPPLANAO_42706',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VNFOPAYMET1983_AGAE437',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499AGAE69 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.agreedPayment.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VNFOPAYMET1983_AGAE437",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.agreedPayment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_IFOPA9055_49.column.agreedPayment.format",
                        'k-decimals': "vc.viewState.QV_IFOPA9055_49.column.agreedPayment.decimals",
                        'data-cobis-group': "Group,GR_VNFOPAYMET19_72,0",
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.agreedPayment.enabled",
                        'ng-class': "vc.viewState.QV_IFOPA9055_49.column.agreedPayment.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_IFOPA9055_49.column.paymentPaid = {
                title: 'BUSIN.DLB_BUSIN_MNTOOLECH_51226',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VNFOPAYMET1983_YMPD956',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499YMPD40 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.paymentPaid.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VNFOPAYMET1983_YMPD956",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.paymentPaid.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_IFOPA9055_49.column.paymentPaid.format",
                        'k-decimals': "vc.viewState.QV_IFOPA9055_49.column.paymentPaid.decimals",
                        'data-cobis-group': "Group,GR_VNFOPAYMET19_72,0",
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.paymentPaid.enabled",
                        'ng-class': "vc.viewState.QV_IFOPA9055_49.column.paymentPaid.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_IFOPA9055_49.column.balance = {
                title: 'BUSIN.DLB_BUSIN_SOAFEAEOT_32473',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VNFOPAYMET1983_BACE089',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499BACE63 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.balance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VNFOPAYMET1983_BACE089",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_IFOPA9055_49.column.balance.format",
                        'k-decimals': "vc.viewState.QV_IFOPA9055_49.column.balance.decimals",
                        'data-cobis-group': "Group,GR_VNFOPAYMET19_72,0",
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.balance.enabled",
                        'ng-class': "vc.viewState.QV_IFOPA9055_49.column.balance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_IFOPA9055_49.columns.push({
                    field: 'titleColumn',
                    title: '{{vc.viewState.QV_IFOPA9055_49.column.titleColumn.title|translate:vc.viewState.QV_IFOPA9055_49.column.titleColumn.titleArgs}}',
                    width: $scope.vc.viewState.QV_IFOPA9055_49.column.titleColumn.width,
                    format: $scope.vc.viewState.QV_IFOPA9055_49.column.titleColumn.format,
                    editor: $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499IEOL88.control,
                    template: "<span ng-class='vc.viewState.QV_IFOPA9055_49.column.titleColumn.element[dataItem.uid].style'>#if (titleColumn !== null) {# #=titleColumn# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_IFOPA9055_49.column.titleColumn.style",
                        "title": "{{vc.viewState.QV_IFOPA9055_49.column.titleColumn.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_IFOPA9055_49.column.titleColumn.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_IFOPA9055_49.columns.push({
                    field: 'agreedPayment',
                    title: '{{vc.viewState.QV_IFOPA9055_49.column.agreedPayment.title|translate:vc.viewState.QV_IFOPA9055_49.column.agreedPayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_IFOPA9055_49.column.agreedPayment.width,
                    format: $scope.vc.viewState.QV_IFOPA9055_49.column.agreedPayment.format,
                    editor: $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499AGAE69.control,
                    template: "<span ng-class='vc.viewState.QV_IFOPA9055_49.column.agreedPayment.element[dataItem.uid].style' ng-bind='kendo.toString(#=agreedPayment#, vc.viewState.QV_IFOPA9055_49.column.agreedPayment.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_IFOPA9055_49.column.agreedPayment.style",
                        "title": "{{vc.viewState.QV_IFOPA9055_49.column.agreedPayment.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_IFOPA9055_49.column.agreedPayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_IFOPA9055_49.columns.push({
                    field: 'paymentPaid',
                    title: '{{vc.viewState.QV_IFOPA9055_49.column.paymentPaid.title|translate:vc.viewState.QV_IFOPA9055_49.column.paymentPaid.titleArgs}}',
                    width: $scope.vc.viewState.QV_IFOPA9055_49.column.paymentPaid.width,
                    format: $scope.vc.viewState.QV_IFOPA9055_49.column.paymentPaid.format,
                    editor: $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499YMPD40.control,
                    template: "<span ng-class='vc.viewState.QV_IFOPA9055_49.column.paymentPaid.element[dataItem.uid].style' ng-bind='kendo.toString(#=paymentPaid#, vc.viewState.QV_IFOPA9055_49.column.paymentPaid.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_IFOPA9055_49.column.paymentPaid.style",
                        "title": "{{vc.viewState.QV_IFOPA9055_49.column.paymentPaid.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_IFOPA9055_49.column.paymentPaid.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_IFOPA9055_49.columns.push({
                    field: 'balance',
                    title: '{{vc.viewState.QV_IFOPA9055_49.column.balance.title|translate:vc.viewState.QV_IFOPA9055_49.column.balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_IFOPA9055_49.column.balance.width,
                    format: $scope.vc.viewState.QV_IFOPA9055_49.column.balance.format,
                    editor: $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499BACE63.control,
                    template: "<span ng-class='vc.viewState.QV_IFOPA9055_49.column.balance.element[dataItem.uid].style' ng-bind='kendo.toString(#=balance#, vc.viewState.QV_IFOPA9055_49.column.balance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_IFOPA9055_49.column.balance.style",
                        "title": "{{vc.viewState.QV_IFOPA9055_49.column.balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_IFOPA9055_49.column.balance.hidden
                });
            }
            $scope.vc.viewState.QV_IFOPA9055_49.toolbar = {}
            $scope.vc.grids.QV_IFOPA9055_49.toolbar = []; //ViewState - Container: Panel para BorrowerView
            $scope.vc.createViewState({
                id: "VC_WRRAO83_PANPW_425",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ECCDEUORE_23411",
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
            }]; //ViewState - Container: Panel para VOtherWarrantyView
            $scope.vc.createViewState({
                id: "VC_WRRAO83_PPARN_927",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GARANTASQ_18496",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Acordeón
            $scope.vc.createViewState({
                id: "GR_VORWARRANT94_26",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Acorde\u00f3n',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel de Acordeón para OtherWarranty
            $scope.vc.createViewState({
                id: "GR_VORWARRANT94_57",
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
                    Flag: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "Flag", false)
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
                    ValueAvailable: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "ValueAvailable", 0)
                    },
                    State: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherWarranty", "State", '')
                    },
                    IsNew: {
                        type: "boolean",
                        editable: true
                    },
                    ClassOpen: {
                        type: "string",
                        editable: true
                    },
                    NameGar: {
                        type: "string",
                        editable: true
                    },
                    IdCustomer: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.OtherWarranty = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_CWARANTY_2317', function(data) {
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
                        $scope.vc.gridRowAction('QV_URYTH5890_38', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                        $("#QV_URYTH5890_38").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CWARANTY_2317 = $scope.vc.model.OtherWarranty;
            $scope.vc.trackers.OtherWarranty = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.OtherWarranty);
            $scope.vc.model.OtherWarranty.bind('change', function(e) {
                $scope.vc.trackers.OtherWarranty.track(e);
                $scope.vc.grids.QV_URYTH5890_38.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_URYTH5890_38 = {};
            $scope.vc.grids.QV_URYTH5890_38.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_URYTH5890_38) && expandedRowUidActual !== expandedRowUid_QV_URYTH5890_38) {
                    var gridWidget = $('#QV_URYTH5890_38').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_URYTH5890_38 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_URYTH5890_38 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_URYTH5890_38 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_URYTH5890_38);
                }
                expandedRowUid_QV_URYTH5890_38 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_URYTH5890_38', args);
                if (angular.isDefined($scope.vc.grids.QV_URYTH5890_38.view)) {
                    $scope.vc.grids.QV_URYTH5890_38.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_URYTH5890_38.customView)) {
                    $scope.vc.grids.QV_URYTH5890_38.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_URYTH5890_38'/>"
            };
            $scope.vc.grids.QV_URYTH5890_38.queryId = 'Q_CWARANTY_2317';
            $scope.vc.viewState.QV_URYTH5890_38 = {
                style: undefined
            };
            $scope.vc.viewState.QV_URYTH5890_38.column = {};
            var expandedRowUid_QV_URYTH5890_38;
            $scope.vc.grids.QV_URYTH5890_38.events = {
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
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_URYTH5890_38.selectedRow = e.model;
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
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'OtherWarranty',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_URYTH5890_38", args, function() {
                        if (args.cancel) {
                            $("#QV_URYTH5890_38").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.grids.QV_URYTH5890_38.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    $scope.vc.validateForm();
                },
                evalVisibilityOfGridRowDetailIcon: function(dataSource) {
                    var dataView = dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        var args = {
                            nameEntityGrid: "OtherWarranty",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_URYTH5890_38", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_URYTH5890_38", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_URYTH5890_38");
                    var dataView = null;
                    $scope.vc.grids.QV_URYTH5890_38.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_URYTH5890_38 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_URYTH5890_38.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_URYTH5890_38.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_URYTH5890_38.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_URYTH5890_38 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_URYTH5890_38 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                detailExpand: function(e) {
                    $(e.detailRow.find(".k-hierarchy-cell")).insertAfter($("td:last", e.detailRow));
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_URYTH5890_38.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_URYTH5890_38.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_URYTH5890_38.column.Flag = {
                title: 'BUSIN.DLB_BUSIN_RETIRARQG_25992',
                titleArgs: {},
                tooltip: '',
                width: 60,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_LSON247',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152FLAG56 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.Flag.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_LSON247",
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.Flag.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.Flag.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.Flag.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.CodeWarranty = {
                title: 'BUSIN.DLB_BUSIN_DWARRANTY_01979',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_OERA160',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152OERA58 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.CodeWarranty.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_OERA160",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.CodeWarranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.CodeWarranty.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.CodeWarranty.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TYPEYLJIK_10770',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_TYPE899',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152TYPE96 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_TYPE899",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_ECIP806',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152ECIP99 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_ECIP806",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.Description.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.InitialValue = {
                title: 'BUSIN.DLB_BUSIN_NITIALVLU_66179',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_IAUE969',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152IAUE93 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.InitialValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_IAUE969",
                        'maxlength': 53,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.InitialValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_38.column.InitialValue.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_38.column.InitialValue.decimals",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.InitialValue.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.InitialValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue = {
                title: 'BUSIN.DLB_BUSIN_VUATODATE_41694',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_PIAE818',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152PIAE66 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_PIAE818",
                        'maxlength': 60,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.ValueApportionment = {
                title: 'BUSIN.DLB_BUSIN_APPOIONEA_90622',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_AENT153',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152AENT57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.ValueApportionment.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_AENT153",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.ValueApportionment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_38.column.ValueApportionment.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_38.column.ValueApportionment.decimals",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.ValueApportionment.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.ValueApportionment.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.ValueAvailable = {
                title: 'BUSIN.DLB_BUSIN_VAEAAILAL_53568',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_AEIL276',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152AEIL95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.ValueAvailable.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_AEIL276",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.ValueAvailable.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URYTH5890_38.column.ValueAvailable.format",
                        'k-decimals': "vc.viewState.QV_URYTH5890_38.column.ValueAvailable.decimals",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.ValueAvailable.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.ValueAvailable.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.State = {
                title: 'BUSIN.DLB_BUSIN_STATUSUAS_80798',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VORWARRANT9457_TATE009',
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.AT_OTH152TATE08 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.State.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VORWARRANT9457_TATE009",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_URYTH5890_38.column.State.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VORWARRANT94_26,0",
                        'ng-disabled': "!vc.viewState.QV_URYTH5890_38.column.State.enabled",
                        'ng-class': "vc.viewState.QV_URYTH5890_38.column.State.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.IsNew = {
                title: 'IsNew',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.ClassOpen = {
                title: 'ClassOpen',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.NameGar = {
                title: 'NameGar',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_URYTH5890_38.column.IdCustomer = {
                title: 'IdCustomer',
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
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'Flag',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.Flag.title|translate:vc.viewState.QV_URYTH5890_38.column.Flag.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.Flag.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.Flag.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_URYTH5890_38', 'Flag', $scope.vc.grids.QV_URYTH5890_38.AT_OTH152FLAG56.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_URYTH5890_38', 'Flag'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.Flag.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.Flag.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.Flag.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'CodeWarranty',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.CodeWarranty.title|translate:vc.viewState.QV_URYTH5890_38.column.CodeWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.CodeWarranty.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.CodeWarranty.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152OERA58.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.CodeWarranty.element[dataItem.uid].style'>#if (CodeWarranty !== null) {# #=CodeWarranty# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.CodeWarranty.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.CodeWarranty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.CodeWarranty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.Type.title|translate:vc.viewState.QV_URYTH5890_38.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.Type.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.Type.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152TYPE96.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.Type.element[dataItem.uid].style'>#if (Type !== null) {# #=Type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.Type.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.Description.title|translate:vc.viewState.QV_URYTH5890_38.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.Description.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.Description.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152ECIP99.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.Description.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'InitialValue',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.InitialValue.title|translate:vc.viewState.QV_URYTH5890_38.column.InitialValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.InitialValue.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.InitialValue.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152IAUE93.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.InitialValue.element[dataItem.uid].style' ng-bind='kendo.toString(#=InitialValue#, vc.viewState.QV_URYTH5890_38.column.InitialValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.InitialValue.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.InitialValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.InitialValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'DateAppraisedValue',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.title|translate:vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152PIAE66.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.element[dataItem.uid].style'>#if (DateAppraisedValue !== null) {# #=DateAppraisedValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.DateAppraisedValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'ValueApportionment',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.ValueApportionment.title|translate:vc.viewState.QV_URYTH5890_38.column.ValueApportionment.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.ValueApportionment.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.ValueApportionment.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152AENT57.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.ValueApportionment.element[dataItem.uid].style' ng-bind='kendo.toString(#=ValueApportionment#, vc.viewState.QV_URYTH5890_38.column.ValueApportionment.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.ValueApportionment.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.ValueApportionment.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.ValueApportionment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'ValueAvailable',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.ValueAvailable.title|translate:vc.viewState.QV_URYTH5890_38.column.ValueAvailable.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.ValueAvailable.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.ValueAvailable.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152AEIL95.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.ValueAvailable.element[dataItem.uid].style' ng-bind='kendo.toString(#=ValueAvailable#, vc.viewState.QV_URYTH5890_38.column.ValueAvailable.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.ValueAvailable.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.ValueAvailable.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.ValueAvailable.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URYTH5890_38.columns.push({
                    field: 'State',
                    title: '{{vc.viewState.QV_URYTH5890_38.column.State.title|translate:vc.viewState.QV_URYTH5890_38.column.State.titleArgs}}',
                    width: $scope.vc.viewState.QV_URYTH5890_38.column.State.width,
                    format: $scope.vc.viewState.QV_URYTH5890_38.column.State.format,
                    editor: $scope.vc.grids.QV_URYTH5890_38.AT_OTH152TATE08.control,
                    template: "<span ng-class='vc.viewState.QV_URYTH5890_38.column.State.element[dataItem.uid].style'>#if (State !== null) {# #=State# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URYTH5890_38.column.State.style",
                        "title": "{{vc.viewState.QV_URYTH5890_38.column.State.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URYTH5890_38.column.State.hidden
                });
            }
            $scope.vc.viewState.QV_URYTH5890_38.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_URYTH5890_38.columns.push({
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_URYTH5890_38.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_URYTH5890_38.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_URYTH5890_38.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-show = 'vc.viewState.QV_URYTH5890_38.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_VORWARRANT94_57.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }]; //ViewState - Container: Panel para DocumentProductView
            $scope.vc.createViewState({
                id: "VC_WRRAO83_NLAUR_144",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DOCUMENTS_71527",
                haslabelArgs: true,
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
            $scope.vc.grids.QV_QDMNT8051_16.toolbar = []; //ViewState - Container: Panel para ExceptionApprove
            $scope.vc.createViewState({
                id: "VC_WRRAO83_XCPOV_772",
                hasId: true,
                componentStyle: "",
                label: 'Panel para ExceptionApprove',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor de Pestañas
            $scope.vc.createViewState({
                id: "GR_VEWCEIOPOV38_03",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor de Pesta\u00f1as',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Pestaña de Excepciones
            $scope.vc.createViewState({
                id: "GR_VEWCEIOPOV38_04",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EXCEPCONS_52292",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Excepciones
            $scope.vc.createViewState({
                id: "GR_VEWCEIOPOV38_05",
                hasId: true,
                componentStyle: "",
                label: 'Excepciones',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VEWCEIOPOV38_06",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Exceptions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    mnemonic: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "mnemonic", ''),
                        validation: {
                            mnemonicRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "description", ''),
                        validation: {
                            descriptionRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Aproved: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "Aproved", false),
                        validation: {
                            AprovedRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    detail: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.Exceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_UERXCPTS_4756', function(data) {
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
                    model: $scope.vc.types.Exceptions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UERXC4756_18").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UERXCPTS_4756 = $scope.vc.model.Exceptions;
            $scope.vc.trackers.Exceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Exceptions);
            $scope.vc.model.Exceptions.bind('change', function(e) {
                $scope.vc.trackers.Exceptions.track(e);
            });
            $scope.vc.grids.QV_UERXC4756_18 = {};
            $scope.vc.grids.QV_UERXC4756_18.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_UERXC4756_18) && expandedRowUidActual !== expandedRowUid_QV_UERXC4756_18) {
                    var gridWidget = $('#QV_UERXC4756_18').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_UERXC4756_18);
                }
                expandedRowUid_QV_UERXC4756_18 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_UERXC4756_18', args);
                if (angular.isDefined($scope.vc.grids.QV_UERXC4756_18.view)) {
                    $scope.vc.grids.QV_UERXC4756_18.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_UERXC4756_18.customView)) {
                    $scope.vc.grids.QV_UERXC4756_18.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_UERXC4756_18'/>"
            };
            $scope.vc.grids.QV_UERXC4756_18.queryId = 'Q_UERXCPTS_4756';
            $scope.vc.viewState.QV_UERXC4756_18 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UERXC4756_18.column = {};
            var expandedRowUid_QV_UERXC4756_18;
            $scope.vc.grids.QV_UERXC4756_18.events = {
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
                    $scope.vc.trackers.Exceptions.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UERXC4756_18.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_UERXC4756_18");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_UERXC4756_18.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_UERXC4756_18.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_UERXC4756_18.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Exceptions",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_UERXC4756_18", args);
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
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_UERXC4756_18 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UERXC4756_18 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UERXC4756_18 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                detailExpand: function(e) {
                    $(e.detailRow.find(".k-hierarchy-cell")).insertAfter($("td:last", e.detailRow));
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UERXC4756_18.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UERXC4756_18.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic = {
                title: 'BUSIN.DLB_BUSIN_NEMNICOZH_18160',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_VEWCEIOPOV3806_NONI510',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513NONI25 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.mnemonic.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VEWCEIOPOV3806_NONI510",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_NEMNICOZH_18160') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.mnemonic.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VEWCEIOPOV38_05,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.mnemonic.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.mnemonic.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_VEWCEIOPOV3806_RTIO573',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513RTIO01 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VEWCEIOPOV3806_RTIO573",
                        'maxlength': 50,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_DESCRIPCI_06123') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VEWCEIOPOV38_05,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.description.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.Aproved = {
                title: 'BUSIN.DLB_BUSIN_AUTORIZAR_89338',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_VEWCEIOPOV3806_EULT155',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513EULT52 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Aproved.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VEWCEIOPOV3806_EULT155",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_AUTORIZAR_89338') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.Aproved.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VEWCEIOPOV38_05,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Aproved.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.Aproved.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.detail = {
                title: 'BUSIN.DLB_BUSIN_DETAILVPQ_18459',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513DETA22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 500,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.detail.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.detail.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'mnemonic',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.mnemonic.title|translate:vc.viewState.QV_UERXC4756_18.column.mnemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513NONI25.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.mnemonic.element[dataItem.uid].style'>#if (mnemonic !== null) {# #=mnemonic# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.mnemonic.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.mnemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.description.title|translate:vc.viewState.QV_UERXC4756_18.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.description.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.description.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513RTIO01.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.description.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'Aproved',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.Aproved.title|translate:vc.viewState.QV_UERXC4756_18.column.Aproved.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_UERXC4756_18', 'Aproved', $scope.vc.grids.QV_UERXC4756_18.AT_EXC513EULT52.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_UERXC4756_18', 'Aproved'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.Aproved.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.Aproved.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'detail',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.detail.title|translate:vc.viewState.QV_UERXC4756_18.column.detail.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.detail.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.detail.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513DETA22.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.detail.element[dataItem.uid].style'>#if (detail !== null) {# #=detail# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.detail.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.detail.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.detail.hidden
                });
            }
            $scope.vc.viewState.QV_UERXC4756_18.toolbar = {}
            $scope.vc.grids.QV_UERXC4756_18.toolbar = [];
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VEWCEIOPOV38_07",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VEWCEIOPOV3807_0000587",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AUTORIZAR_89338",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Detalle de Excepciones
            $scope.vc.createViewState({
                id: "GR_VEWCEIOPOV38_08",
                hasId: true,
                componentStyle: "",
                label: 'Detalle de Excepciones',
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.VariableExceptions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    VariableName: {
                        type: "string",
                        editable: true
                    },
                    VariableValue: {
                        type: "string",
                        editable: true
                    },
                    VariableDescription: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.VariableExceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_EAIBLEEP_2309', function(data) {
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
                    model: $scope.vc.types.VariableExceptions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_EAIBL2309_87").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EAIBLEEP_2309 = $scope.vc.model.VariableExceptions;
            $scope.vc.trackers.VariableExceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariableExceptions);
            $scope.vc.model.VariableExceptions.bind('change', function(e) {
                $scope.vc.trackers.VariableExceptions.track(e);
            });
            $scope.vc.grids.QV_EAIBL2309_87 = {};
            $scope.vc.grids.QV_EAIBL2309_87.queryId = 'Q_EAIBLEEP_2309';
            $scope.vc.viewState.QV_EAIBL2309_87 = {
                style: undefined
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column = {};
            $scope.vc.grids.QV_EAIBL2309_87.events = {
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
                    $scope.vc.trackers.VariableExceptions.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_EAIBL2309_87.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_EAIBL2309_87");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_EAIBL2309_87.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEV_12696',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 45,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableName.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableValue.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RSCP88 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableDescription.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableName',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableName.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableName.element[dataItem.uid].style'>#if (VariableName !== null) {# #=VariableName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableName.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableValue',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableValue.element[dataItem.uid].style'>#if (VariableValue !== null) {# #=VariableValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableValue.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableDescription',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableDescription.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RSCP88.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableDescription.element[dataItem.uid].style'>#if (VariableDescription !== null) {# #=VariableDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableDescription.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.hidden
                });
            }
            $scope.vc.viewState.QV_EAIBL2309_87.toolbar = {}
            $scope.vc.grids.QV_EAIBL2309_87.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_25_WRRAO83_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_25_WRRAO83_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Guardar
            $scope.vc.createViewState({
                id: "CM_WRRAO83GDR62",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Hide
            $scope.vc.createViewState({
                id: "CM_WRRAO83IDE96",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VALORDWSB_39301",
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
                $scope.vc.render('VC_WRRAO83_TYDIY_402');
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
    var cobisMainModule = cobis.createModule("VC_WRRAO83_TYDIY_402", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_WRRAO83_TYDIY_402", {
            templateUrl: "VC_WRRAO83_TYDIY_402_FORM.html",
            controller: "VC_WRRAO83_TYDIY_402_CTRL",
            label: "WarrantyModify",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_WRRAO83_TYDIY_402?" + $.param(search);
            }
        });
        VC_WRRAO83_TYDIY_402(cobisMainModule);
    }]);
} else {
    VC_WRRAO83_TYDIY_402(cobisMainModule);
}