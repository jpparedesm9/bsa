<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.arrears = designerEvents.api.arrears || designer.dsgEvents();

function VC_RREAR10_ARRRM_816(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RREAR10_ARRRM_816_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RREAR10_ARRRM_816_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_28_RREAR10",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RREAR10_ARRRM_816",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_28_RREAR10",
        designerEvents.api.arrears,
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
                vcName: 'VC_RREAR10_ARRRM_816'
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
                    taskId: 'T_FLCRE_28_RREAR10',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ArrearsInfo: "ArrearsInfo",
                    NegotiablePayments: "NegotiablePayments",
                    DebtorGeneral: "DebtorGeneral",
                    InfoPayment: "InfoPayment",
                    AmortizationTableHeader: "AmortizationTableHeader",
                    AmortizationTableItem: "AmortizationTableItem",
                    PersonalGuarantor: "PersonalGuarantor",
                    ArrearsDetail: "ArrearsDetail"
                },
                entities: {
                    ArrearsInfo: {
                        creditNumber: 'AT_ARR773DITU39',
                        operationBank: 'AT_ARR773AIOE20',
                        processedNumber: 'AT_ARR773RSMB42',
                        officeId: 'AT_ARR773OFED41',
                        province: 'AT_ARR773PVIE46',
                        city: 'AT_ARR773CITY40',
                        requestedDestination: 'AT_ARR773ESDT09',
                        requestedCurrency: 'AT_ARR773QSUN72',
                        disbursementDate: 'AT_ARR773SRDE40',
                        creditStatus: 'AT_ARR773ETUS24',
                        numberOfCreditsEarned: 'AT_ARR773BFDE08',
                        overdueDays: 'AT_ARR773DUDS69',
                        Official: 'AT_ARR773OFCA08',
                        committedAmount: 'AT_ARR773CDNT96',
                        paymentFrequency: 'AT_ARR773TQNC70',
                        capitalOverdueQuotes: 'AT_ARR773PATS48',
                        userL: 'AT_ARR773USRL09',
                        CustomerOriginalActivity: 'AT_ARR773EICT95',
                        CustomerCurrentActivity: 'AT_ARR773OCAI23',
                        Term: 'AT_ARR773TERM95',
                        _pks: [],
                        _entityId: 'EN_ARREARNFO773',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    NegotiablePayments: {
                        paymentOne: 'AT_GTI486METO92',
                        paymentTwo: 'AT_GTI486MNTO02',
                        total: 'AT_GTI486TTAL77',
                        negotiableBalance: 'AT_GTI486OIAA11',
                        applicationDate: 'AT_GTI486LCOD51',
                        amount: 'AT_GTI486MONT85',
                        _pks: [],
                        _entityId: 'EN_GTIBPENTS486',
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
                    AmortizationTableHeader: {
                        Description: 'AT_ZTO288DCPN45',
                        _pks: [],
                        _entityId: 'EN_ZTOTBEEAD288',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    AmortizationTableItem: {
                        Dividend: 'AT_MRI884DVDE03',
                        ExpirationDate: 'AT_MRI884EPTI34',
                        Balance: 'AT_MRI884BAAC22',
                        Item1: 'AT_MRI884TEM164',
                        Item2: 'AT_MRI884ITE219',
                        Item3: 'AT_MRI884ITEM64',
                        Item4: 'AT_MRI884IEM481',
                        Item5: 'AT_MRI884ITEM43',
                        Item6: 'AT_MRI884IEM603',
                        Item7: 'AT_MRI884ITE729',
                        Item8: 'AT_MRI884TEM887',
                        Item9: 'AT_MRI884TEM984',
                        Item10: 'AT_MRI884TE1034',
                        Item11: 'AT_MRI884ITM148',
                        Item12: 'AT_MRI884TEM155',
                        Item13: 'AT_MRI884ITM128',
                        Fee: 'AT_MRI884SHRE57',
                        _pks: [],
                        _entityId: 'EN_MRIZATITM884',
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
                    ArrearsDetail: {
                        applicationType: 'AT_ARR235IOYP68',
                        rangeArrears: 'AT_ARR235RARR94',
                        rateAmortization: 'AT_ARR235TTII88',
                        capitalAmortization: 'AT_ARR235MORT35',
                        problemsAndNegotiations: 'AT_ARR235RNAS80',
                        personalGuarantorStatus: 'AT_ARR235ESAT91',
                        consistencyComments: 'AT_ARR235OTCE85',
                        _pks: [],
                        _entityId: 'EN_ARRASDETA235',
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
            $scope.vc.queryProperties.Q_QUYOINBL_3312 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_QUYOINBL_3312 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_QUYOINBL_3312 = {
                mainEntityPk: {
                    entityId: 'EN_MRIZATITM884',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_QUYOINBL_3312',
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
            $scope.vc.queryProperties.Q_LTETAEYN_7447 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_LTETAEYN_7447 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_LTETAEYN_7447 = {
                mainEntityPk: {
                    entityId: 'EN_GTIBPENTS486',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_LTETAEYN_7447',
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
            $scope.vc.queryProperties.Q_HERAMITE_8244 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_HERAMITE_8244 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_HERAMITE_8244 = {
                mainEntityPk: {
                    entityId: 'EN_ZTOTBEEAD288',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_HERAMITE_8244',
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
            $scope.vc.queryProperties.Q_PESAUANT_2317 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_PESAUANT_2317 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_PESAUANT_2317 = {
                mainEntityPk: {
                    entityId: 'EN_SNALUATOR601',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_PESAUANT_2317',
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
                ArrearsInfo: {},
                NegotiablePayments: {},
                DebtorGeneral: {},
                InfoPayment: {},
                AmortizationTableHeader: {},
                AmortizationTableItem: {},
                PersonalGuarantor: {},
                ArrearsDetail: {}
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
            $scope.vc.viewState.VC_RREAR10_ARRRM_816 = {
                style: []
            }
            //ViewState - Container: ArrearsForm
            $scope.vc.createViewState({
                id: "VC_RREAR10_ARRRM_816",
                hasId: true,
                componentStyle: "",
                label: 'ArrearsForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Grupo para ArrearsView
            $scope.vc.createViewState({
                id: "VC_RREAR10_PRRRS_470",
                hasId: true,
                componentStyle: "",
                label: 'Grupo para ArrearsView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Grupo contenedor
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_19",
                hasId: true,
                componentStyle: "",
                label: 'Grupo contenedor',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ArrearsInfo = {
                creditNumber: $scope.vc.channelDefaultValues("ArrearsInfo", "creditNumber"),
                operationBank: $scope.vc.channelDefaultValues("ArrearsInfo", "operationBank"),
                processedNumber: $scope.vc.channelDefaultValues("ArrearsInfo", "processedNumber"),
                officeId: $scope.vc.channelDefaultValues("ArrearsInfo", "officeId"),
                province: $scope.vc.channelDefaultValues("ArrearsInfo", "province"),
                city: $scope.vc.channelDefaultValues("ArrearsInfo", "city"),
                requestedDestination: $scope.vc.channelDefaultValues("ArrearsInfo", "requestedDestination"),
                requestedCurrency: $scope.vc.channelDefaultValues("ArrearsInfo", "requestedCurrency"),
                disbursementDate: $scope.vc.channelDefaultValues("ArrearsInfo", "disbursementDate"),
                creditStatus: $scope.vc.channelDefaultValues("ArrearsInfo", "creditStatus"),
                numberOfCreditsEarned: $scope.vc.channelDefaultValues("ArrearsInfo", "numberOfCreditsEarned"),
                overdueDays: $scope.vc.channelDefaultValues("ArrearsInfo", "overdueDays"),
                Official: $scope.vc.channelDefaultValues("ArrearsInfo", "Official"),
                committedAmount: $scope.vc.channelDefaultValues("ArrearsInfo", "committedAmount"),
                paymentFrequency: $scope.vc.channelDefaultValues("ArrearsInfo", "paymentFrequency"),
                capitalOverdueQuotes: $scope.vc.channelDefaultValues("ArrearsInfo", "capitalOverdueQuotes"),
                userL: $scope.vc.channelDefaultValues("ArrearsInfo", "userL"),
                CustomerOriginalActivity: $scope.vc.channelDefaultValues("ArrearsInfo", "CustomerOriginalActivity"),
                CustomerCurrentActivity: $scope.vc.channelDefaultValues("ArrearsInfo", "CustomerCurrentActivity"),
                Term: $scope.vc.channelDefaultValues("ArrearsInfo", "Term")
            };
            //ViewState - Group: Seccion Cabecera
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_85",
                hasId: true,
                componentStyle: "",
                label: 'Seccion Cabecera',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: processedNumber
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_RSMB959",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                label: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: creditNumber
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_DITU443",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DGODEDITO_48769",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: operationBank
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_AIOE120",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OPEIONBER_32159",
                label: "BUSIN.DLB_BUSIN_OPEIONBER_32159",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: officeId
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_OFED841",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFICINAJD_61287",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3985_OFED841 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AREARSVIEW3985_OFED841', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3985_OFED841'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3985_OFED841");
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
            //ViewState - Entity: ArrearsInfo, Attribute: province
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_PVIE179",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3985_PVIE179 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AREARSVIEW3985_PVIE179', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3985_PVIE179'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3985_PVIE179");
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
            //ViewState - Entity: ArrearsInfo, Attribute: city
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_CITY589",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3985_CITY589 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_AREARSVIEW3985_CITY589', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3985_CITY589'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3985_CITY589");
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
            //ViewState - Entity: ArrearsInfo, Attribute: committedAmount
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_CDNT571",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MTOOMETDO_03753",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: paymentFrequency
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_TQNC755",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RUECYTERM_46135",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3985_TQNC755 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AREARSVIEW3985_TQNC755', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3985_TQNC755'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3985_TQNC755");
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
            //ViewState - Entity: ArrearsInfo, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_TERM661",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: ArrearsInfo, Attribute: requestedDestination
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_ESDT632",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DCIOEEDDT_35512",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: requestedCurrency
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_QSUN970",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_MONEDAQAQ_04700",
                label: "BUSIN.DLB_BUSIN_MONEDAQAQ_04700",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3985_QSUN970 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AREARSVIEW3985_QSUN970', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3985_QSUN970'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3985_QSUN970");
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
            //ViewState - Entity: ArrearsInfo, Attribute: disbursementDate
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_SRDE805",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FECAEBOLO_12083",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: creditStatus
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_ETUS014",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SDOLRDITO_43121",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: numberOfCreditsEarned
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_BFDE586",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NMERTSEID_83243",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: overdueDays
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_DUDS392",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DADEATRAS_80192",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: Official
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_OFCA801",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICIALR_02742",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: capitalOverdueQuotes
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_PATS497",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TCASVNCAA_67935",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsInfo, Attribute: CustomerOriginalActivity
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_EICT386",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_IDAIGNLNE_54575",
                label: "BUSIN.DLB_BUSIN_IDAIGNLNE_54575",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3985_EICT386 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AREARSVIEW3985_EICT386', 'cl_actividad_ec', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3985_EICT386'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3985_EICT386");
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
            //ViewState - Entity: ArrearsInfo, Attribute: CustomerCurrentActivity
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3985_OCAI738",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ATIICULEN_75812",
                label: "BUSIN.DLB_BUSIN_ATIICULEN_75812",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3985_OCAI738 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AREARSVIEW3985_OCAI738', 'cl_actividad_ec', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3985_OCAI738'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3985_OCAI738");
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
            $scope.vc.model.ArrearsDetail = {
                applicationType: $scope.vc.channelDefaultValues("ArrearsDetail", "applicationType"),
                rangeArrears: $scope.vc.channelDefaultValues("ArrearsDetail", "rangeArrears"),
                rateAmortization: $scope.vc.channelDefaultValues("ArrearsDetail", "rateAmortization"),
                capitalAmortization: $scope.vc.channelDefaultValues("ArrearsDetail", "capitalAmortization"),
                problemsAndNegotiations: $scope.vc.channelDefaultValues("ArrearsDetail", "problemsAndNegotiations"),
                personalGuarantorStatus: $scope.vc.channelDefaultValues("ArrearsDetail", "personalGuarantorStatus"),
                consistencyComments: $scope.vc.channelDefaultValues("ArrearsDetail", "consistencyComments")
            };
            //ViewState - Group: Seccion Moratoria
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_04",
                hasId: true,
                componentStyle: "",
                label: 'Seccion Moratoria',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsDetail, Attribute: applicationType
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3904_IOYP979",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SOIIUDPAA_01230",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AREARSVIEW3904_IOYP979 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AREARSVIEW3904_IOYP979', 'cr_tipo_moratoria', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AREARSVIEW3904_IOYP979'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AREARSVIEW3904_IOYP979");
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
            //ViewState - Entity: ArrearsDetail, Attribute: rangeArrears
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3904_RARR148",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ANODEMORA_74300",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsDetail, Attribute: capitalAmortization
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3904_MORT127",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ARZCINDTL_95133",
                haslabelArgs: true,
                format: "##",
                suffix: "\\%",
                decimals: 0,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsDetail, Attribute: rateAmortization
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3904_TTII027",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ARZAAITER_27742",
                haslabelArgs: true,
                format: "##",
                suffix: "\\%",
                decimals: 0,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsDetail, Attribute: problemsAndNegotiations
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3904_RNAS727",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OLEMAYCIE_83986",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsDetail, Attribute: personalGuarantorStatus
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3904_ESAT040",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_DLAEPRSOL_91722",
                label: "BUSIN.DLB_BUSIN_DLAEPRSOL_91722",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ArrearsDetail, Attribute: consistencyComments
            $scope.vc.createViewState({
                id: "VA_AREARSVIEW3904_OTCE850",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CERISOHRE_07033",
                label: "BUSIN.DLB_BUSIN_CERISOHRE_07033",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Datos Operacion Seleccionada
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_08",
                hasId: true,
                componentStyle: "",
                label: 'Datos Operacion Seleccionada',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Seccion Datos CCA
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_10",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ATOPEAION_63755",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Seccion Pagos
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_11",
                hasId: true,
                componentStyle: "",
                label: 'Seccion Pagos',
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
                title: 'BUSIN.DLB_BUSIN_CONCEPTOM_59109',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3911_IEOL272',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499IEOL88 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.titleColumn.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_AREARSVIEW3911_IEOL272",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.titleColumn.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_AREARSVIEW39_10,0",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3911_AGAE629',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499AGAE69 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.agreedPayment.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_AREARSVIEW3911_AGAE629",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.agreedPayment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_IFOPA9055_49.column.agreedPayment.format",
                        'k-decimals': "vc.viewState.QV_IFOPA9055_49.column.agreedPayment.decimals",
                        'data-cobis-group': "Group,GR_AREARSVIEW39_10,0",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3911_YMPD351',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499YMPD40 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.paymentPaid.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_AREARSVIEW3911_YMPD351",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.paymentPaid.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_IFOPA9055_49.column.paymentPaid.format",
                        'k-decimals': "vc.viewState.QV_IFOPA9055_49.column.paymentPaid.decimals",
                        'data-cobis-group': "Group,GR_AREARSVIEW39_10,0",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3911_BACE743',
                element: []
            };
            $scope.vc.grids.QV_IFOPA9055_49.AT_IFP499BACE63 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IFOPA9055_49.column.balance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_AREARSVIEW3911_BACE743",
                        'data-validation-code': "{{vc.viewState.QV_IFOPA9055_49.column.balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_IFOPA9055_49.column.balance.format",
                        'k-decimals': "vc.viewState.QV_IFOPA9055_49.column.balance.decimals",
                        'data-cobis-group': "Group,GR_AREARSVIEW39_10,0",
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
            $scope.vc.grids.QV_IFOPA9055_49.toolbar = [];
            //ViewState - Group: Seccion Pagos Negociables
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_12",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OITEPYMEN_20317",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.NegotiablePayments = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    applicationDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("NegotiablePayments", "applicationDate", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("NegotiablePayments", "amount", 0)
                    }
                }
            });;
            $scope.vc.model.NegotiablePayments = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_LTETAEYN_7447', function(data) {
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
                    model: $scope.vc.types.NegotiablePayments
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_LTETA7447_41").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_LTETAEYN_7447 = $scope.vc.model.NegotiablePayments;
            $scope.vc.trackers.NegotiablePayments = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.NegotiablePayments);
            $scope.vc.model.NegotiablePayments.bind('change', function(e) {
                $scope.vc.trackers.NegotiablePayments.track(e);
            });
            $scope.vc.grids.QV_LTETA7447_41 = {};
            $scope.vc.grids.QV_LTETA7447_41.queryId = 'Q_LTETAEYN_7447';
            $scope.vc.viewState.QV_LTETA7447_41 = {
                style: undefined
            };
            $scope.vc.viewState.QV_LTETA7447_41.column = {};
            $scope.vc.grids.QV_LTETA7447_41.events = {
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
                    $scope.vc.trackers.NegotiablePayments.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_LTETA7447_41.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_LTETA7447_41");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_LTETA7447_41.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_LTETA7447_41.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_LTETA7447_41.column.applicationDate = {
                title: 'BUSIN.DLB_BUSIN_FHAALIION_52574',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3912_LCOD123',
                element: []
            };
            $scope.vc.grids.QV_LTETA7447_41.AT_GTI486LCOD51 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_LTETA7447_41.column.applicationDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_AREARSVIEW3912_LCOD123",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_LTETA7447_41.column.applicationDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_AREARSVIEW39_10,1",
                        'ng-disabled': "!vc.viewState.QV_LTETA7447_41.column.applicationDate.enabled",
                        'ng-class': "vc.viewState.QV_LTETA7447_41.column.applicationDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_LTETA7447_41.column.amount = {
                title: 'BUSIN.DLB_BUSIN_MONTOFVFP_36531',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3912_MONT582',
                element: []
            };
            $scope.vc.grids.QV_LTETA7447_41.AT_GTI486MONT85 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_LTETA7447_41.column.amount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_AREARSVIEW3912_MONT582",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_LTETA7447_41.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_LTETA7447_41.column.amount.format",
                        'k-decimals': "vc.viewState.QV_LTETA7447_41.column.amount.decimals",
                        'data-cobis-group': "Group,GR_AREARSVIEW39_10,1",
                        'ng-disabled': "!vc.viewState.QV_LTETA7447_41.column.amount.enabled",
                        'ng-class': "vc.viewState.QV_LTETA7447_41.column.amount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_LTETA7447_41.columns.push({
                    field: 'applicationDate',
                    title: '{{vc.viewState.QV_LTETA7447_41.column.applicationDate.title|translate:vc.viewState.QV_LTETA7447_41.column.applicationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_LTETA7447_41.column.applicationDate.width,
                    format: $scope.vc.viewState.QV_LTETA7447_41.column.applicationDate.format,
                    editor: $scope.vc.grids.QV_LTETA7447_41.AT_GTI486LCOD51.control,
                    template: "<span ng-class='vc.viewState.QV_LTETA7447_41.column.applicationDate.element[dataItem.uid].style'>#if (applicationDate !== null) {# #=applicationDate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_LTETA7447_41.column.applicationDate.style",
                        "title": "{{vc.viewState.QV_LTETA7447_41.column.applicationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_LTETA7447_41.column.applicationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_LTETA7447_41.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_LTETA7447_41.column.amount.title|translate:vc.viewState.QV_LTETA7447_41.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_LTETA7447_41.column.amount.width,
                    format: $scope.vc.viewState.QV_LTETA7447_41.column.amount.format,
                    editor: $scope.vc.grids.QV_LTETA7447_41.AT_GTI486MONT85.control,
                    template: "<span ng-class='vc.viewState.QV_LTETA7447_41.column.amount.element[dataItem.uid].style' ng-bind='kendo.toString(#=amount#, vc.viewState.QV_LTETA7447_41.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_LTETA7447_41.column.amount.style",
                        "title": "{{vc.viewState.QV_LTETA7447_41.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_LTETA7447_41.column.amount.hidden
                });
            }
            $scope.vc.viewState.QV_LTETA7447_41.toolbar = {}
            $scope.vc.grids.QV_LTETA7447_41.toolbar = [];
            //ViewState - Group: Plan de Pagos
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_09",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLANDEPAO_31165",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.AmortizationTableItem = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Dividend: {
                        type: "number",
                        editable: true
                    },
                    ExpirationDate: {
                        type: "date",
                        editable: true
                    },
                    Balance: {
                        type: "number",
                        editable: true
                    },
                    Item1: {
                        type: "number",
                        editable: true
                    },
                    Item2: {
                        type: "number",
                        editable: true
                    },
                    Item3: {
                        type: "number",
                        editable: true
                    },
                    Item4: {
                        type: "number",
                        editable: true
                    },
                    Item5: {
                        type: "number",
                        editable: true
                    },
                    Item6: {
                        type: "number",
                        editable: true
                    },
                    Item7: {
                        type: "number",
                        editable: true
                    },
                    Item8: {
                        type: "number",
                        editable: true
                    },
                    Item9: {
                        type: "number",
                        editable: true
                    },
                    Item10: {
                        type: "number",
                        editable: true
                    },
                    Item11: {
                        type: "number",
                        editable: true
                    },
                    Item12: {
                        type: "number",
                        editable: true
                    },
                    Item13: {
                        type: "number",
                        editable: true
                    },
                    Fee: {
                        type: "number",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.AmortizationTableItem = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_QUYOINBL_3312', function(data) {
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
                    model: $scope.vc.types.AmortizationTableItem
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QUYOI3312_16").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUYOINBL_3312 = $scope.vc.model.AmortizationTableItem;
            $scope.vc.trackers.AmortizationTableItem = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AmortizationTableItem);
            $scope.vc.model.AmortizationTableItem.bind('change', function(e) {
                $scope.vc.trackers.AmortizationTableItem.track(e);
            });
            $scope.vc.grids.QV_QUYOI3312_16 = {};
            $scope.vc.grids.QV_QUYOI3312_16.queryId = 'Q_QUYOINBL_3312';
            $scope.vc.viewState.QV_QUYOI3312_16 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column = {};
            $scope.vc.grids.QV_QUYOI3312_16.events = {
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
                    $scope.vc.trackers.AmortizationTableItem.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QUYOI3312_16.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QUYOI3312_16");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUYOI3312_16.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUYOI3312_16.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend = {
                title: 'BUSIN.DLB_BUSIN_NMEROPAWQ_57199',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884DVDE03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 1,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Dividend.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Dividend.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate = {
                title: 'BUSIN.DLB_BUSIN_FEHVNCINO_77589',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "d",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884EPTI34 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'kendo-ext-date-picker': "",
                        placeholder: "{{dateFormatPlaceFormat}}",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Balance = {
                title: 'BUSIN.DLB_BUSIN_LDOECITAL_77904',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884BAAC22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Balance.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Balance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item1 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM164 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item1.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item1.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item2 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE219 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item2.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item2.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item3 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM64 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item3.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item3.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item4 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM481 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item4.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item4.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item5 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item5.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item5.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item6 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM603 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item6.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item6.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item7 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE729 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item7.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item7.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item8 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM887 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item8.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item8.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item9 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM984 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item9.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item9.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item10 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TE1034 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item10.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item10.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item11 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item11.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item11.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item12 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM155 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item12.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item12.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item13 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM128 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item13.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item13.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Fee = {
                title: 'BUSIN.DLB_BUSIN_CUOTADPJP_65632',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884SHRE57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Fee.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Fee.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Dividend',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Dividend.title|translate:vc.viewState.QV_QUYOI3312_16.column.Dividend.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884DVDE03.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Dividend.element[dataItem.uid].style' ng-bind='kendo.toString(#=Dividend#, vc.viewState.QV_QUYOI3312_16.column.Dividend.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Dividend.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Dividend.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'ExpirationDate',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.title|translate:vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884EPTI34.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.element[dataItem.uid].style'>#=((ExpirationDate !== null) ? kendo.toString(ExpirationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Balance',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Balance.title|translate:vc.viewState.QV_QUYOI3312_16.column.Balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Balance.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Balance.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884BAAC22.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Balance.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance#, vc.viewState.QV_QUYOI3312_16.column.Balance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Balance.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Balance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item1',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item1.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item1.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item1.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item1.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM164.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item1.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item1#, vc.viewState.QV_QUYOI3312_16.column.Item1.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item1.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item2',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item2.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item2.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item2.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item2.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE219.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item2.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item2#, vc.viewState.QV_QUYOI3312_16.column.Item2.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item2.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item3',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item3.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item3.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item3.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item3.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM64.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item3.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item3#, vc.viewState.QV_QUYOI3312_16.column.Item3.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item3.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item3.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item3.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item4',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item4.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item4.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item4.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item4.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM481.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item4.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item4#, vc.viewState.QV_QUYOI3312_16.column.Item4.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item4.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item4.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item4.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item5',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item5.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item5.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item5.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item5.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM43.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item5.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item5#, vc.viewState.QV_QUYOI3312_16.column.Item5.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item5.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item5.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item5.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item6',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item6.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item6.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM603.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item6.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item6#, vc.viewState.QV_QUYOI3312_16.column.Item6.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item6.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item6.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item7',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item7.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item7.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE729.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item7.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item7#, vc.viewState.QV_QUYOI3312_16.column.Item7.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item7.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item7.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item8',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item8.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item8.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item8.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item8.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM887.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item8.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item8#, vc.viewState.QV_QUYOI3312_16.column.Item8.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item8.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item8.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item8.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item9',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item9.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item9.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item9.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item9.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM984.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item9.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item9#, vc.viewState.QV_QUYOI3312_16.column.Item9.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item9.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item9.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item9.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item10',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item10.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item10.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item10.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item10.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TE1034.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item10.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item10#, vc.viewState.QV_QUYOI3312_16.column.Item10.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item10.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item10.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item10.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item11',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item11.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item11.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item11.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item11.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM148.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item11.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item11#, vc.viewState.QV_QUYOI3312_16.column.Item11.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item11.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item11.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item11.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item12',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item12.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item12.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item12.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item12.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM155.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item12.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item12#, vc.viewState.QV_QUYOI3312_16.column.Item12.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item12.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item12.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item12.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item13',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item13.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item13.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item13.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item13.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM128.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item13.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item13#, vc.viewState.QV_QUYOI3312_16.column.Item13.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item13.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item13.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item13.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Fee',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Fee.title|translate:vc.viewState.QV_QUYOI3312_16.column.Fee.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884SHRE57.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Fee.element[dataItem.uid].style' ng-bind='kendo.toString(#=Fee#, vc.viewState.QV_QUYOI3312_16.column.Fee.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Fee.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Fee.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.hidden
                });
            }
            $scope.vc.viewState.QV_QUYOI3312_16.toolbar = {}
            $scope.vc.grids.QV_QUYOI3312_16.toolbar = [];
            //ViewState - Group: Tabla Amortizacion
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_13",
                hasId: true,
                componentStyle: "",
                label: 'Tabla Amortizacion',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.AmortizationTableHeader = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Description: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.AmortizationTableHeader = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_HERAMITE_8244', function(data) {
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
                    model: $scope.vc.types.AmortizationTableHeader
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_HERAM8244_92").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_HERAMITE_8244 = $scope.vc.model.AmortizationTableHeader;
            $scope.vc.trackers.AmortizationTableHeader = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AmortizationTableHeader);
            $scope.vc.model.AmortizationTableHeader.bind('change', function(e) {
                $scope.vc.trackers.AmortizationTableHeader.track(e);
            });
            $scope.vc.grids.QV_HERAM8244_92 = {};
            $scope.vc.grids.QV_HERAM8244_92.queryId = 'Q_HERAMITE_8244';
            $scope.vc.viewState.QV_HERAM8244_92 = {
                style: undefined
            };
            $scope.vc.viewState.QV_HERAM8244_92.column = {};
            $scope.vc.grids.QV_HERAM8244_92.events = {
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
                    $scope.vc.trackers.AmortizationTableHeader.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_HERAM8244_92.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_HERAM8244_92");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_HERAM8244_92.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_HERAM8244_92.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_HERAM8244_92.column.Description = {
                title: 'Description',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            $scope.vc.viewState.QV_HERAM8244_92.toolbar = {}
            $scope.vc.grids.QV_HERAM8244_92.toolbar = [];
            //ViewState - Group: Garantias
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_14",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GARANTASQ_18496",
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
                        editable: true
                    }
                }
            });;
            $scope.vc.model.PersonalGuarantor = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_PESAUANT_2317', function(data) {
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
                title: 'BUSIN.DLB_BUSIN_CIGEARNTA_66805',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CIGEARNTA_66805',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3914_CDEW135',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601CDEW22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.CodeWarranty.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CIGEARNTA_66805'|translate}}",
                        'id': "VA_AREARSVIEW3914_CDEW135",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.CodeWarranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,3",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.CodeWarranty.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.CodeWarranty.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TIPOXAASN_24763',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_TIPOXAASN_24763',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3914_TYPE201',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601TYPE43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_TIPOXAASN_24763'|translate}}",
                        'id': "VA_AREARSVIEW3914_TYPE201",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,3",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3914_ESCP477',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601ESCP00 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_DESCRIPCI_06123'|translate}}",
                        'id': "VA_AREARSVIEW3914_ESCP477",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,3",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.Description.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary = {
                title: 'BUSIN.DLB_BUSIN_GUROONDAY_85151',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_GUROONDAY_85151',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3914_GUAN551',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601GUAN15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_GUROONDAY_85151'|translate}}",
                        'id': "VA_AREARSVIEW3914_GUAN551",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,3",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.GuarantorPrimarySecondary.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.ClassOpen = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3914_CLAN413',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601CLAN02 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.ClassOpen.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_AREARSVIEW3914_CLAN413",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.ClassOpen.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,3",
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
                componentId: 'VA_AREARSVIEW3914_IDSE269',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601IDSE19 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.IdCustomer.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_AREARSVIEW3914_IDSE269",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.IdCustomer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,3",
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
                componentId: 'VA_AREARSVIEW3914_STAT012',
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601STAT69 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.State.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_AREARSVIEW3914_STAT012",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_PESAU2317_81.column.State.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,3",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.State.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.State.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC = {
                title: 'DateCIC',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "d",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_PESAU2317_81.AT_SNA601DATE60 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'kendo-ext-date-picker': "",
                        placeholder: "{{dateFormatPlaceFormat}}",
                        'ng-disabled': "!vc.viewState.QV_PESAU2317_81.column.DateCIC.enabled",
                        'ng-class': "vc.viewState.QV_PESAU2317_81.column.DateCIC.element['" + options.model.uid + "'].style"
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
                    editor: $scope.vc.grids.QV_PESAU2317_81.AT_SNA601DATE60.control,
                    template: "<span ng-class='vc.viewState.QV_PESAU2317_81.column.DateCIC.element[dataItem.uid].style'>#=((DateCIC !== null) ? kendo.toString(DateCIC, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_PESAU2317_81.column.DateCIC.style",
                        "title": "{{vc.viewState.QV_PESAU2317_81.column.DateCIC.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_PESAU2317_81.column.DateCIC.hidden
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
            $scope.vc.grids.QV_PESAU2317_81.toolbar = [];
            //ViewState - Group: Deudores
            $scope.vc.createViewState({
                id: "GR_AREARSVIEW39_15",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DEUDORESN_35493",
                haslabelArgs: true,
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
                        editable: true
                    },
                    DateCIC: {
                        type: "date",
                        editable: true
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
                title: 'BUSIN.DLB_BUSIN_CUTOMEROD_75260',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CUTOMEROD_75260',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_AREARSVIEW3915_CUST434',
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
                        'id': "VA_AREARSVIEW3915_CUST434",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CUTOMEROD_75260') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.format",
                        'k-decimals': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.decimals",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,4",
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
                componentId: 'VA_AREARSVIEW3915_CUST603',
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
                        'id': "VA_AREARSVIEW3915_CUST603",
                        'maxlength': 255,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,4",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3915_ROLE018',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_AREARSVIEW3915_ROLE018 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_AREARSVIEW3915_ROLE018_values)) {
                            $scope.vc.catalogs.VA_AREARSVIEW3915_ROLE018_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_AREARSVIEW3915_ROLE018',
                                'cr_cat_deudor',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_AREARSVIEW3915_ROLE018'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_AREARSVIEW3915_ROLE018_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_AREARSVIEW3915_ROLE018");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_AREARSVIEW3915_ROLE018_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_AREARSVIEW3915_ROLE018");
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
                        'id': "VA_AREARSVIEW3915_ROLE018",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.Role.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_AREARSVIEW3915_ROLE018",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.Role.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Role.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,4",
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
                componentId: 'VA_AREARSVIEW3915_DOTD192',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_AREARSVIEW3915_DOTD192 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_AREARSVIEW3915_DOTD192_values)) {
                            $scope.vc.catalogs.VA_AREARSVIEW3915_DOTD192_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_AREARSVIEW3915_DOTD192',
                                'cl_tipo_documento',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_AREARSVIEW3915_DOTD192'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_AREARSVIEW3915_DOTD192_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_AREARSVIEW3915_DOTD192");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_AREARSVIEW3915_DOTD192_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_AREARSVIEW3915_DOTD192");
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
                        'id': "VA_AREARSVIEW3915_DOTD192",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_AREARSVIEW3915_DOTD192",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,4",
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
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_AREARSVIEW3915_IDEN453',
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
                        'id': "VA_AREARSVIEW3915_IDEN453",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Identification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_AREARSVIEW39_08,4",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Identification.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Identification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Qualification = {
                title: 'BUSIN.DLB_BUSIN_CALIFCAIN_39502',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342UALN46 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 5,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Qualification.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Qualification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC = {
                title: 'DateCIC',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "d",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DTCC73 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'kendo-ext-date-picker': "",
                        placeholder: "{{dateFormatPlaceFormat}}",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.DateCIC.enabled",
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
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Role.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_AREARSVIEW3915_ROLE018.get(dataItem.Role).value'> </span>",
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
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_AREARSVIEW3915_DOTD192.get(dataItem.TypeDocumentId).value'> </span>",
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
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DTCC73.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.DateCIC.element[dataItem.uid].style'>#=((DateCIC !== null) ? kendo.toString(DateCIC, 'd') : '')#</span>",
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
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-show = 'vc.viewState.QV_BOREG0798_55.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_AREARSVIEW39_15.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }, {
                "name": "CEQV_201_QV_BOREG0798_55_719",
                "text": "{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}",
                "template": "<button id='CEQV_201_QV_BOREG0798_55_719' ng-show='vc.viewState.QV_BOREG0798_55.toolbar.CEQV_201_QV_BOREG0798_55_719.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_BOREG0798_55_719\",\"DebtorGeneral\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand' title=\"{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}\"> #: text #</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_28_RREAR10_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_28_RREAR10_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: btnSave
            $scope.vc.createViewState({
                id: "CM_RREAR10BNE86",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: btnPrint
            $scope.vc.createViewState({
                id: "CM_RREAR10CMN40",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_IMPRIMIRH_85279",
                label: "BUSIN.DLB_BUSIN_IMPRIMIRH_85279",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_AREARSVIEW3915_ROLE018.read();
                    $scope.vc.catalogs.VA_AREARSVIEW3915_DOTD192.read();
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
                $scope.vc.render('VC_RREAR10_ARRRM_816');
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
    var cobisMainModule = cobis.createModule("VC_RREAR10_ARRRM_816", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_RREAR10_ARRRM_816", {
            templateUrl: "VC_RREAR10_ARRRM_816_FORM.html",
            controller: "VC_RREAR10_ARRRM_816_CTRL",
            label: "ArrearsForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RREAR10_ARRRM_816?" + $.param(search);
            }
        });
        VC_RREAR10_ARRRM_816(cobisMainModule);
    }]);
} else {
    VC_RREAR10_ARRRM_816(cobisMainModule);
}