//Designer Generator v 1.13.2 - release ART 13.2 28/11/2014
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskqueryoperation = designerEvents.api.taskqueryoperation || {
    initData: {},
    initDataCallback: {},
    changeInitData: {},
    executeCommand: {},
    executeLabelCommand: {},
    executeCommandCallback: {},
    executeCrudCallback: {},
    validateTransaction: {},
    callTransaction: {},
    showResult: {},
    closeModalEvent: {},
    change: {},
    changeGroup: {},
    changeCallback: {},
    loadCatalog: {},
    executeQuery: {},
    textInputButtonEvent: {},
    textInputButtonCloseModalEvent: {},
    gridRowInserting: {},
    gridRowUpdating: {},
    gridRowDeleting: {},
    gridRowSelecting: {},
    gridRowCommand: {},
    gridRowCommandCallback: {},
    gridCommand: {},
    gridBeforeEnterInLineRow: {},
    gridAfterLeaveInLineRow: {},
    gridInitDetailTemplate: {},
    gridInitColumnTemplate: {},
    gridInitEditColumnTemplate: {},
    beforeOpenGridDialog: {},
    afterCloseGridDialog: {},
    textInputButtonEventGrid: {},
    textInputButtonCloseModalEventGrid: {}
};

function VC_SPETN81_AQUAT_670(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_SPETN81_AQUAT_670_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_SPETN81_AQUAT_670_CTRL", ["$scope", "$location", "$document", "$parse", "designer", "cobisMessage", "$filter", "$modal", cobis.modules.CONTAINER + ".preferencesService", "$q",

    function($scope, $location, $document, $parse, designer, cobisMessage, $filter, $modal, preferencesService, $q) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT)) {
            $scope.dateFormat = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT);
        } else {
            $scope.dateFormat = 'yyyy/MM/dd';
        }
        $scope.designer = designer;
        $scope.validatorOptions = validatorOptions;
        $scope.vc = designer.initViewContainer({
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_62_SPETN81",
            taskVersion: "1.0.0",
            viewContainerId: "VC_SPETN81_AQUAT_670"
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_62_SPETN81",
        designerEvents.api.taskqueryoperation);
        if ($scope.vc.isDetailGrid($scope)) {
            var uid = "VC_SPETN81_AQUAT_670_" + $scope.vc.parentVc.detail.uid;
            $scope.vc = designer.initViewContainer({
                moduleId: "BUSIN",
                subModuleId: "FLCRE",
                taskId: "T_FLCRE_62_SPETN81",
                taskVersion: "1.0.0",
                viewContainerId: "VC_SPETN81_AQUAT_670"
            },
                "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_62_SPETN81",
            designerEvents.api.taskqueryoperation, uid);
        }
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
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
                vcName: 'VC_SPETN81_AQUAT_670'
            };
            if (($scope.vc.isModal($scope) || $scope.isDesignerInclude) && angular.isDefined($scope.queryParameters)) {
                $scope.vc.pk = $scope.queryParameters.pk;
                $scope.vc.mode = parseInt($scope.queryParameters.mode || designer.constants.mode.Insert);
            } else {
                if ($scope.vc.isDetailGrid($scope) && angular.isDefined($scope.$parent.queryParameters)) {
                    $scope.vc.pk = $scope.$parent.queryParameters.pk;
                    $scope.vc.mode = parseInt($scope.$parent.queryParameters.mode || designer.constants.mode.Insert);
                } else {
                    $scope.vc.pk = $location.search().pk;
                    $scope.vc.mode = parseInt($location.search().mode || designer.constants.mode.Insert);
                }
            }
            $scope.vc.args.pk = $scope.vc.pk;
            $scope.vc.args.mode = $scope.vc.mode;
            if (cobis.userContext.getValue(cobis.constant.USER_NAME)) {
                $scope.vc.args.user = cobis.userContext.getValue(cobis.constant.USER_NAME);
            } else {
                $scope.vc.args.user = "UserOutContainer";
            }
            $scope.vc.args.channel = $location.search().channel;
            $scope.vc.metadata = {
                taskPk: {
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_62_SPETN81',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    TermsOperation: "TermsOperation",
                    CollateralEntity: "CollateralEntity",
                    DebtBalance: "DebtBalance",
                    DebtorGeneral: "DebtorGeneral",
                    DatosGeneralesOperacion: "DatosGeneralesOperacion"
                },
                entities: {
                    TermsOperation: {
                        InterestRate: 'AT_TRM231IESA74',
                        ReschedulTypeRate: 'AT_TRM231EERE49',
                        ReschedulPeriod: 'AT_TRM231REPE38',
                        NextReschedulDate: 'AT_TRM231ERED54',
                        AcceptAdditionalPayments: 'AT_TRM231CETE98',
                        ReductionType: 'AT_TRM231DUTE35',
                        FullInstallmentPayments: 'AT_TRM231ITET75',
                        ApplicationType: 'AT_TRM231PPII78',
                        _pks: [],
                        _entityId: 'EN_TRMERATIO231',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CollateralEntity: {
                        CollateralCode: 'AT_COR494OALC98',
                        CollateralDescription: 'AT_COR494ERII56',
                        CollateralAmount: 'AT_COR494OAMO88',
                        CoveragePercent: 'AT_COR494GRCT64',
                        LastInspectionDate: 'AT_COR494LITE77',
                        CollateralState: 'AT_COR494LLAL92',
                        _pks: [],
                        _entityId: 'EN_CORAENITY494',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DebtBalance: {
                        OverdueCapital: 'AT_DEB824ITEM23',
                        OverdueInterest: 'AT_DEB824ATTT72',
                        OverdueArrears: 'AT_DEB824ARRS90',
                        OverdueInsurance: 'AT_DEB824UANU08',
                        OverdueOtherItems: 'AT_DEB824OETR70',
                        OverdueTotal: 'AT_DEB824DETL55',
                        CapitalToFallDue: 'AT_DEB824PLFA40',
                        InterestToFallDue: 'AT_DEB824TEDE55',
                        ArrearsToFallDue: 'AT_DEB824REAL01',
                        InsuranceToFallDue: 'AT_DEB824NADE03',
                        OtherItemsToFallDue: 'AT_DEB824TOLE43',
                        TotalToFallDue: 'AT_DEB824TAOL36',
                        CapitalTotalIndebtedness: 'AT_DEB824TATB51',
                        InterestTotalIndebtedness: 'AT_DEB824ESLD48',
                        ArrearsTotalIndebtedness: 'AT_DEB824RIDS45',
                        InsuranceTotalIndebtedness: 'AT_DEB824LDSS56',
                        OtherItemsTotalIndebtedness: 'AT_DEB824ELIE95',
                        TotalIndebtedness: 'AT_DEB824OENS18',
                        _pks: [],
                        _entityId: 'EN_DEBBALANE824',
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
                        _pks: ['CustomerCode'],
                        _entityId: 'EN_DEBTORHHW342',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DatosGeneralesOperacion: {
                        OperationType: 'AT_DTT506ANYP68',
                        Executive: 'AT_DTT506OFCL04',
                        OfficeCod: 'AT_DTT506OFIC26',
                        Operation: 'AT_DTT506ACON09',
                        Currency: 'AT_DTT506MONY35',
                        ExchangeRate: 'AT_DTT506QUOT83',
                        FinishDate: 'AT_DTT506EXDE44',
                        AmountApproved: 'AT_DTT506UNTP86',
                        Amount: 'AT_DTT506AMUN88',
                        Status: 'AT_DTT506STEN03',
                        ClientCod: 'AT_DTT506ENTD15',
                        ClientName: 'AT_DTT506LINE95',
                        ApplicationNumber: 'AT_DTT506ITNR31',
                        DisbursementAmount: 'AT_DTT506ETMT15',
                        DisbursementDate: 'AT_DTT506BMEE18',
                        InstallmentDueDate: 'AT_DTT506NSLD59',
                        NextPaymentDate: 'AT_DTT506PATT18',
                        BalanceDue: 'AT_DTT506AACU83',
                        CreditLine: 'AT_DTT506EILE36',
                        _pks: ['Operation'],
                        _entityId: 'EN_DTTBLOIZA506',
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
                updateParameters: function() {
                    this.parameters = {};
                }
            };
            $scope.vc.queryProperties.Q_OLARQUER_2932 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_OLARQUER_2932 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_OLARQUER_2932 = {
                mainEntityPk: {
                    entityId: 'EN_CORAENITY494',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_OLARQUER_2932',
                    version: '1.0.0'
                },
                parameters: {},
                updateParameters: function() {
                    this.parameters = {};
                }
            };
            defaultValues = {
                TermsOperation: {},
                CollateralEntity: {},
                DebtBalance: {},
                DebtorGeneral: {},
                DatosGeneralesOperacion: {}
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
                $scope.vc.CRUDExecuteQueryId(queryRequest, loadInModel);
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
            $scope.vc.viewState.VC_SPETN81_AQUAT_670 = {
                style: []
            }
            //ViewState - Container: GrViewQueryOperation
            $scope.vc.viewState.VC_SPETN81_ELAON_598 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: 'GrViewQueryOperation',
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return true;
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: DatosGeneralesOperacion
            $scope.vc.viewState.GR_VIWROPRAIO56_04 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_EATIONDAA_74861"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.model.DatosGeneralesOperacion = {
                OperationType: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "OperationType"),
                Executive: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Executive"),
                OfficeCod: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "OfficeCod"),
                Operation: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Operation"),
                Currency: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Currency"),
                ExchangeRate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ExchangeRate"),
                FinishDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "FinishDate"),
                AmountApproved: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "AmountApproved"),
                Amount: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Amount"),
                Status: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Status"),
                ClientCod: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ClientCod"),
                ClientName: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ClientName"),
                ApplicationNumber: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ApplicationNumber"),
                DisbursementAmount: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "DisbursementAmount"),
                DisbursementDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "DisbursementDate"),
                InstallmentDueDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "InstallmentDueDate"),
                NextPaymentDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "NextPaymentDate"),
                BalanceDue: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "BalanceDue"),
                CreditLine: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "CreditLine")
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Operation
            $scope.vc.viewState.VA_VIWROPRAIO5604_ACON597 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_EATINUMBR_47864"),
                validationCode: 32,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: OperationType
            $scope.vc.viewState.VA_VIWROPRAIO5604_ANYP274 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_PROUCTTPE_88016"),
                validationCode: 32,
                template: '',
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.catalogs.VA_VIWROPRAIO5604_ANYP274 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIWROPRAIO5604_ANYP274', 'ca_toperacion', function(response) {
                            if (response.data['RESULTVA_VIWROPRAIO5604_ANYP274'] != null) {
                                options.success(response.data['RESULTVA_VIWROPRAIO5604_ANYP274']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: OfficeCod
            $scope.vc.viewState.VA_VIWROPRAIO5604_OFIC634 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_OFFICELSD_48549"),
                validationCode: 0,
                template: '',
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.catalogs.VA_VIWROPRAIO5604_OFIC634 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIWROPRAIO5604_OFIC634', 'cl_oficina', function(response) {
                            if (response.data['RESULTVA_VIWROPRAIO5604_OFIC634'] != null) {
                                options.success(response.data['RESULTVA_VIWROPRAIO5604_OFIC634']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Status
            $scope.vc.viewState.VA_VIWROPRAIO5604_STEN164 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_STATUSXVU_76843"),
                format: "n0",
                decimals: 0,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: ClientName
            $scope.vc.viewState.VA_VIWROPRAIO5604_LINE347 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_CLIENTNAE_03679"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Container: TabOperationData
            $scope.vc.viewState.VC_SPETN81_ROSNE_617 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: 'TabOperationData',
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return true;
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Container: GrGeneralData
            $scope.vc.viewState.VC_SPETN81_NERDA_779 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_GNERLDATA_65811"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return true;
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: Panel de Acordeón para DatosGeneralesOperacion
            $scope.vc.viewState.GR_IGENERLATA42_04 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: 'Panel de Acordeón para DatosGeneralesOperacion',
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: ApplicationNumber
            $scope.vc.viewState.VA_IGENERLATA4204_ITNR832 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_APAONMBER_11346"),
                format: "n0",
                decimals: 0,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Executive
            $scope.vc.viewState.VA_IGENERLATA4204_OFCL867 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_OFFICERAT_46633"),
                format: "n0",
                decimals: 0,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: OfficeCod
            $scope.vc.viewState.VA_IGENERLATA4204_OFIC746 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_OFFICELSD_48549"),
                validationCode: 0,
                template: '',
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.catalogs.VA_IGENERLATA4204_OFIC746 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IGENERLATA4204_OFIC746', 'cl_oficina', function(response) {
                            if (response.data['RESULTVA_IGENERLATA4204_OFIC746'] != null) {
                                options.success(response.data['RESULTVA_IGENERLATA4204_OFIC746']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Currency
            $scope.vc.viewState.VA_IGENERLATA4204_MONY940 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_CURRENCYJ_79423"),
                format: "n0",
                decimals: 0,
                validationCode: 32,
                template: '',
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.catalogs.VA_IGENERLATA4204_MONY940 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IGENERLATA4204_MONY940', 'cl_moneda', function(response) {
                            if (response.data['RESULTVA_IGENERLATA4204_MONY940'] != null) {
                                options.success(response.data['RESULTVA_IGENERLATA4204_MONY940']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: ExchangeRate
            $scope.vc.viewState.VA_IGENERLATA4204_QUOT081 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_XCANGRATE_42960"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: FinishDate
            $scope.vc.viewState.VA_IGENERLATA4204_EXDE444 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_ENDDATEDZ_24905"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: AmountApproved
            $scope.vc.viewState.VA_IGENERLATA4204_UNTP963 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_AONTAPOEB_50978"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Amount
            $scope.vc.viewState.VA_IGENERLATA4204_AMUN882 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_AMOUNTNIO_63870"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: DisbursementAmount
            $scope.vc.viewState.VA_IGENERLATA4204_ETMT694 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_MUNTIBURS_69801"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: DisbursementDate
            $scope.vc.viewState.VA_IGENERLATA4204_BMEE844 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_DRSEMENAT_58739"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: InstallmentDueDate
            $scope.vc.viewState.VA_IGENERLATA4204_NSLD376 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_MREILMTUT_07411"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: NextPaymentDate
            $scope.vc.viewState.VA_IGENERLATA4204_PATT174 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_NETYMETDA_94309"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: BalanceDue
            $scope.vc.viewState.VA_IGENERLATA4204_AACU227 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_ALANCEDUE_71445"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DatosGeneralesOperacion, Attribute: CreditLine
            $scope.vc.viewState.VA_IGENERLATA4204_EILE525 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_CREDITINE_69900"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Container: GrConditions
            $scope.vc.viewState.VC_SPETN81_RONIO_486 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_CONDITONS_15667"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return true;
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: TermsOperation
            $scope.vc.viewState.GR_VIEDIIOOTO70_04 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: 'TermsOperation',
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.model.TermsOperation = {
                InterestRate: $scope.vc.channelDefaultValues("TermsOperation", "InterestRate"),
                ReschedulTypeRate: $scope.vc.channelDefaultValues("TermsOperation", "ReschedulTypeRate"),
                ReschedulPeriod: $scope.vc.channelDefaultValues("TermsOperation", "ReschedulPeriod"),
                NextReschedulDate: $scope.vc.channelDefaultValues("TermsOperation", "NextReschedulDate"),
                AcceptAdditionalPayments: $scope.vc.channelDefaultValues("TermsOperation", "AcceptAdditionalPayments"),
                ReductionType: $scope.vc.channelDefaultValues("TermsOperation", "ReductionType"),
                FullInstallmentPayments: $scope.vc.channelDefaultValues("TermsOperation", "FullInstallmentPayments"),
                ApplicationType: $scope.vc.channelDefaultValues("TermsOperation", "ApplicationType")
            };
            //ViewState - Entity: TermsOperation, Attribute: InterestRate
            $scope.vc.viewState.VA_VIEDIIOOTO7004_IESA374 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_INTERETAT_36036"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: TermsOperation, Attribute: ReschedulTypeRate
            $scope.vc.viewState.VA_VIEDIIOOTO7004_EERE350 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_DUSNTETEP_99090"),
                validationCode: 0,
                template: '',
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.catalogs.VA_VIEDIIOOTO7004_EERE350 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEDIIOOTO7004_EERE350', 'fp_reajuste', function(response) {
                            if (response.data['RESULTVA_VIEDIIOOTO7004_EERE350'] != null) {
                                options.success(response.data['RESULTVA_VIEDIIOOTO7004_EERE350']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: TermsOperation, Attribute: ReschedulPeriod
            $scope.vc.viewState.VA_VIEDIIOOTO7004_REPE725 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_EDADJUTEN_48772"),
                format: "n0",
                decimals: 0,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: TermsOperation, Attribute: NextReschedulDate
            $scope.vc.viewState.VA_VIEDIIOOTO7004_ERED494 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_NINATJSEE_92947"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: TermsOperation, Attribute: AcceptAdditionalPayments
            $scope.vc.viewState.VA_VIEDIIOOTO7004_CETE430 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_ERTIOAPMN_81111"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: TermsOperation, Attribute: ReductionType
            $scope.vc.viewState.VA_VIEDIIOOTO7004_DUTE630 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_RDCTONYPE_32179"),
                validationCode: 0,
                template: '',
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.catalogs.VA_VIEDIIOOTO7004_DUTE630 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEDIIOOTO7004_DUTE630', 'ca_treduccion', function(response) {
                            if (response.data['RESULTVA_VIEDIIOOTO7004_DUTE630'] != null) {
                                options.success(response.data['RESULTVA_VIEDIIOOTO7004_DUTE630']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: TermsOperation, Attribute: FullInstallmentPayments
            $scope.vc.viewState.VA_VIEDIIOOTO7004_ITET522 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_OYLLPAETS_15461"),
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: TermsOperation, Attribute: ApplicationType
            $scope.vc.viewState.VA_VIEDIIOOTO7004_PPII969 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_PPLICTTYE_23337"),
                validationCode: 0,
                template: '',
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.catalogs.VA_VIEDIIOOTO7004_PPII969 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIEDIIOOTO7004_PPII969', 'ca_taplicacion', function(response) {
                            if (response.data['RESULTVA_VIEDIIOOTO7004_PPII969'] != null) {
                                options.success(response.data['RESULTVA_VIEDIIOOTO7004_PPII969']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Container: GrpBorrowers
            $scope.vc.viewState.VC_SPETN81_ROROS_201 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_BORWERDTA_05940"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return true;
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: BorrowerGroup
            $scope.vc.viewState.GR_BORRWRVIEW27_83 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: 'BorrowerGroup',
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
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
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerCode", 0)
                    },
                    Role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Role", '')
                    },
                    Identification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Identification", '')
                    },
                    TypeDocumentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "TypeDocumentId", '')
                    },
                    CustomerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerName", '')
                    },
                    Address: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Address", '')
                    }
                }
            });;
            $scope.vc.model.DebtorGeneral = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
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
                        $scope.grids.QV_BOREG0798_55.cancelChanges();
                    }
                }
            });
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
                customRowClick: function(e, controlId, entity, grid) {
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
                    $scope.vc.trackers.DebtorGeneral.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_BOREG0798_55.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("th.k-header[data-role='droptarget']").index();
                        if (index == -1) {
                            commandCell = e.container.find("td:last");
                            index = commandCell.index();
                        } else {
                            commandCell = e.container.find("td > a.k-grid-update").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html('<a class="k-grid-update" href="#" title="' + titleUpdate + '"><span class="glyphicon glyphicon-ok-sign"></span></a>&nbsp<a class="k-grid-cancel" href="#" title="' + titleCancel + '"><span class="glyphicon glyphicon-remove-sign"></span></a>');
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    grid.tbody.on('mousedown', 'a,button,input[type="button"],td.k-hierarchy-cell', function(evnt) {
                        evnt.stopImmediatePropagation();
                        evnt.stopPropagation();
                    });
                    $scope.vc.gridDataBound("QV_BOREG0798_55");
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_BOREG0798_55.columns = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_CUTOMEROD_75260'),
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_CUST965',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerCode.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        maxlength: 10,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.format",
                        'k-decimals': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.decimals",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Role = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_ROLEVJMGD_53686'),
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_ROLE954',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ROLE73 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Role.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        maxlength: 10,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Role.validationCode}}",
                        type: "text",
                        class: "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Role.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Identification = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_ENTICAION_65975'),
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
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
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Identification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        maxlength: 20,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Identification.validationCode}}",
                        type: "text",
                        class: "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Identification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_TIFIATNTY_81125'),
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_DOTD538',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DOTD15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        maxlength: 255,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.validationCode}}",
                        type: "text",
                        class: "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_CTMERNAME_20933'),
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_CUST619',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST55 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        maxlength: 255,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.validationCode}}",
                        type: "text",
                        class: "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Address = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_USOMEADRS_61973'),
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_ADRS738',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ADRS63 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Address.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        maxlength: 255,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Address.validationCode}}",
                        type: "text",
                        class: "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Address.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'CustomerCode',
                    title: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.title,
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST03.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerCode.element[dataItem.uid].style' ng-bind='kendo.toString(#=CustomerCode#, vc.viewState.QV_BOREG0798_55.column.CustomerCode.format)'></span>",
                    attributes: {
                        style: "text-align:right;",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.CustomerCode.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Role',
                    title: $scope.vc.viewState.QV_BOREG0798_55.column.Role.title,
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Role.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Role.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ROLE73.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Role.element[dataItem.uid].style'>#=Role#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Role.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Role.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Identification',
                    title: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.title,
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342IDEN84.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Identification.element[dataItem.uid].style'>#=Identification#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Identification.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Identification.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'TypeDocumentId',
                    title: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.title,
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DOTD15.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element[dataItem.uid].style'>#=TypeDocumentId#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'CustomerName',
                    title: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.title,
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST55.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerName.element[dataItem.uid].style'>#=CustomerName#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.CustomerName.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Address',
                    title: $scope.vc.viewState.QV_BOREG0798_55.column.Address.title,
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Address.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Address.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ADRS63.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Address.element[dataItem.uid].style'>#=Address#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Address.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Address.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Address.hidden
                });
            }
            $scope.vc.viewState.QV_BOREG0798_55.column.edit = {
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.columns.push({
                command: [{
                    name: "edit",
                    text: "",
                    template: "<a ng-class='vc.viewState.QV_BOREG0798_55.column.edit.element[dataItem.uid].style' class='k-grid-edit' href='' title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\"><span class='glyphicon glyphicon-pencil'></span></a>&nbsp"
                }],
                width: 75
            });
            //No hay comandos de fila repetidos
            $scope.vc.grids.QV_BOREG0798_55.toolbar = [{
                name: 'create',
                text: "",
                template: "<a class='k-grid-add' href='' title=\"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\"><span class='glyphicon glyphicon-plus-sign'></span></a>&nbsp"
            }, {
                name: 'CEQV_201_QV_BOREG0798_55_719',
                text: $filter('translate')('BUSIN.DLB_BUSIN_DELETEVPS_36022'),
                template: '<button id="CEQV_201_QV_BOREG0798_55_719" data-ng-click=\'vc.executeGridCommand("CEQV_201_QV_BOREG0798_55_719","DebtorGeneral")\' class="btn btn-default">#: text #</button>'
            }]; //ViewState - Container: GrpCollateral
            $scope.vc.viewState.VC_SPETN81_RCLTL_270 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_LAERALNFO_03769"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return true;
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: CollateralGroup
            $scope.vc.viewState.GR_OLLATLVIEW46_02 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_LAERALNFO_03769"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.types.CollateralEntity = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CollateralCode: {
                        type: "string",
                        editable: true
                    },
                    CollateralDescription: {
                        type: "string",
                        editable: true
                    },
                    CollateralAmount: {
                        type: "number",
                        editable: true
                    },
                    CoveragePercent: {
                        type: "number",
                        editable: true
                    },
                    LastInspectionDate: {
                        type: "date",
                        editable: true
                    },
                    CollateralState: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.CollateralEntity = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
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
                    model: $scope.vc.types.CollateralEntity
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $scope.grids.QV_OLARQ2932_17.cancelChanges();
                    }
                }
            });
            $scope.vc.trackers.CollateralEntity = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CollateralEntity);
            $scope.vc.model.CollateralEntity.bind('change', function(e) {
                $scope.vc.trackers.CollateralEntity.track(e);
            });
            $scope.vc.grids.QV_OLARQ2932_17 = {};
            $scope.vc.grids.QV_OLARQ2932_17.queryId = 'Q_OLARQUER_2932';
            $scope.vc.viewState.QV_OLARQ2932_17 = {
                style: undefined
            };
            $scope.vc.viewState.QV_OLARQ2932_17.column = {};
            $scope.vc.grids.QV_OLARQ2932_17.events = {
                customRowClick: function(e, controlId, entity, grid) {
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
                    $scope.vc.trackers.CollateralEntity.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_OLARQ2932_17.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("th.k-header[data-role='droptarget']").index();
                        if (index == -1) {
                            commandCell = e.container.find("td:last");
                            index = commandCell.index();
                        } else {
                            commandCell = e.container.find("td > a.k-grid-update").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html('<a class="btn btn-default k-grid-update" href="#"><span class="glyphicon glyphicon-ok-sign"></span>&nbsp' + titleUpdate + '<a class="btn btn-default k-grid-cancel" href="#"><span class="glyphicon glyphicon-remove-sign"></span>&nbsp' + titleCancel + '</a>');
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    grid.tbody.on('mousedown', 'a,button,input[type="button"],td.k-hierarchy-cell', function(evnt) {
                        evnt.stopImmediatePropagation();
                        evnt.stopPropagation();
                    });
                    $scope.vc.gridDataBound("QV_OLARQ2932_17");
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_OLARQ2932_17.columns = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralCode = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_CIGGARANT_91183'),
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_OLARQ2932_17.AT_COR494OALC98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 10,
                        type: "text",
                        class: "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_OLARQ2932_17.column.CollateralCode.enabled",
                        'ng-class': "vc.viewState.QV_OLARQ2932_17.column.CollateralCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralDescription = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_DESCRPCIN_18275'),
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_OLARQ2932_17.AT_COR494ERII56 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 25,
                        type: "text",
                        class: "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.enabled",
                        'ng-class': "vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralAmount = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_VALORIJCE_15863'),
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_OLARQ2932_17.AT_COR494OAMO88 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 13,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.enabled",
                        'ng-class': "vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OLARQ2932_17.column.CoveragePercent = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_PCENCOTUA_20521'),
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_OLARQ2932_17.AT_COR494GRCT64 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 13,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'n'",
                        'ng-disabled': "!vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.enabled",
                        'ng-class': "vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_ASTSEONDT_97311'),
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "d",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_OLARQ2932_17.AT_COR494LITE77 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'kendo-ext-date-picker': "",
                        placeholder: "{{dateFormat}}",
                        'ng-disabled': "!vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.enabled",
                        'ng-class': "vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralState = {
                title: $filter('translate')('BUSIN.DLB_BUSIN_ESTADOOZF_72052'),
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_OLARQ2932_17.AT_COR494LLAL92 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 20,
                        type: "text",
                        class: "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_OLARQ2932_17.column.CollateralState.enabled",
                        'ng-class': "vc.viewState.QV_OLARQ2932_17.column.CollateralState.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OLARQ2932_17.columns.push({
                    field: 'CollateralCode',
                    title: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralCode.title,
                    width: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralCode.width,
                    format: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralCode.format,
                    editor: $scope.vc.grids.QV_OLARQ2932_17.AT_COR494OALC98.control,
                    template: "<span ng-class='vc.viewState.QV_OLARQ2932_17.column.CollateralCode.element[dataItem.uid].style'>#=CollateralCode#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_OLARQ2932_17.column.CollateralCode.style",
                        "title": "{{vc.viewState.QV_OLARQ2932_17.column.CollateralCode.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OLARQ2932_17.columns.push({
                    field: 'CollateralDescription',
                    title: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.title,
                    width: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.width,
                    format: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.format,
                    editor: $scope.vc.grids.QV_OLARQ2932_17.AT_COR494ERII56.control,
                    template: "<span ng-class='vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.element[dataItem.uid].style'>#=CollateralDescription#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.style",
                        "title": "{{vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OLARQ2932_17.columns.push({
                    field: 'CollateralAmount',
                    title: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.title,
                    width: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.width,
                    format: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.format,
                    editor: $scope.vc.grids.QV_OLARQ2932_17.AT_COR494OAMO88.control,
                    template: "<span ng-class='vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=CollateralAmount#, vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.format)'></span>",
                    attributes: {
                        style: "text-align:right;",
                        "ng-class": "vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.style",
                        "title": "{{vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.tooltip}}"
                    },
                    headerAttributes: {
                        style: "text-align:right;"
                    },
                    hidden: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OLARQ2932_17.columns.push({
                    field: 'CoveragePercent',
                    title: $scope.vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.title,
                    width: $scope.vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.width,
                    format: $scope.vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.format,
                    editor: $scope.vc.grids.QV_OLARQ2932_17.AT_COR494GRCT64.control,
                    template: "<span ng-class='vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.element[dataItem.uid].style' ng-bind='kendo.toString(#=CoveragePercent#, vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.format)'></span>",
                    attributes: {
                        style: "text-align:right;",
                        "ng-class": "vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.style",
                        "title": "{{vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_OLARQ2932_17.column.CoveragePercent.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OLARQ2932_17.columns.push({
                    field: 'LastInspectionDate',
                    title: $scope.vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.title,
                    width: $scope.vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.width,
                    format: $scope.vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.format,
                    editor: $scope.vc.grids.QV_OLARQ2932_17.AT_COR494LITE77.control,
                    template: "<span ng-class='vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.element[dataItem.uid].style'>#=kendo.toString(LastInspectionDate, 'd')#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.style",
                        "title": "{{vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_OLARQ2932_17.column.LastInspectionDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_OLARQ2932_17.columns.push({
                    field: 'CollateralState',
                    title: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralState.title,
                    width: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralState.width,
                    format: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralState.format,
                    editor: $scope.vc.grids.QV_OLARQ2932_17.AT_COR494LLAL92.control,
                    template: "<span ng-class='vc.viewState.QV_OLARQ2932_17.column.CollateralState.element[dataItem.uid].style'>#=CollateralState#</span>",
                    attributes: {
                        style: "",
                        "ng-class": "vc.viewState.QV_OLARQ2932_17.column.CollateralState.style",
                        "title": "{{vc.viewState.QV_OLARQ2932_17.column.CollateralState.tooltip}}"
                    },
                    hidden: $scope.vc.viewState.QV_OLARQ2932_17.column.CollateralState.hidden
                });
            }
            //No hay comandos de fila repetidos
            $scope.vc.grids.QV_OLARQ2932_17.toolbar = []; //ViewState - Container: GPBalance
            $scope.vc.viewState.VC_SPETN81_GPBCE_828 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_RICALLANC_26031"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return true;
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: GPBalancePastDue
            $scope.vc.viewState.GR_VIEWALANCE97_04 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_PADUEBANC_09903"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.model.DebtBalance = {
                OverdueCapital: $scope.vc.channelDefaultValues("DebtBalance", "OverdueCapital"),
                OverdueInterest: $scope.vc.channelDefaultValues("DebtBalance", "OverdueInterest"),
                OverdueArrears: $scope.vc.channelDefaultValues("DebtBalance", "OverdueArrears"),
                OverdueInsurance: $scope.vc.channelDefaultValues("DebtBalance", "OverdueInsurance"),
                OverdueOtherItems: $scope.vc.channelDefaultValues("DebtBalance", "OverdueOtherItems"),
                OverdueTotal: $scope.vc.channelDefaultValues("DebtBalance", "OverdueTotal"),
                CapitalToFallDue: $scope.vc.channelDefaultValues("DebtBalance", "CapitalToFallDue"),
                InterestToFallDue: $scope.vc.channelDefaultValues("DebtBalance", "InterestToFallDue"),
                ArrearsToFallDue: $scope.vc.channelDefaultValues("DebtBalance", "ArrearsToFallDue"),
                InsuranceToFallDue: $scope.vc.channelDefaultValues("DebtBalance", "InsuranceToFallDue"),
                OtherItemsToFallDue: $scope.vc.channelDefaultValues("DebtBalance", "OtherItemsToFallDue"),
                TotalToFallDue: $scope.vc.channelDefaultValues("DebtBalance", "TotalToFallDue"),
                CapitalTotalIndebtedness: $scope.vc.channelDefaultValues("DebtBalance", "CapitalTotalIndebtedness"),
                InterestTotalIndebtedness: $scope.vc.channelDefaultValues("DebtBalance", "InterestTotalIndebtedness"),
                ArrearsTotalIndebtedness: $scope.vc.channelDefaultValues("DebtBalance", "ArrearsTotalIndebtedness"),
                InsuranceTotalIndebtedness: $scope.vc.channelDefaultValues("DebtBalance", "InsuranceTotalIndebtedness"),
                OtherItemsTotalIndebtedness: $scope.vc.channelDefaultValues("DebtBalance", "OtherItemsTotalIndebtedness"),
                TotalIndebtedness: $scope.vc.channelDefaultValues("DebtBalance", "TotalIndebtedness")
            };
            //ViewState - Entity: DebtBalance, Attribute: OverdueCapital
            $scope.vc.viewState.VA_VIEWALANCE9704_ITEM731 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_CAPMEKBVN_97226"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: OverdueInterest
            $scope.vc.viewState.VA_VIEWALANCE9704_ATTT475 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_INTERESTW_15793"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: OverdueArrears
            $scope.vc.viewState.VA_VIEWALANCE9704_ARRS591 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_ARREARSJS_67269"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: OverdueInsurance
            $scope.vc.viewState.VA_VIEWALANCE9704_UANU000 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_INSUREUQZ_06562"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: OverdueOtherItems
            $scope.vc.viewState.VA_VIEWALANCE9704_OETR661 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_OTHERITEM_36371"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.viewState.VA_VIEWALANCE9704_0000043 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: '',
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: OverdueTotal
            $scope.vc.viewState.VA_VIEWALANCE9704_DETL049 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_TOTALOCEI_29396"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: GPNextBalanceDue
            $scope.vc.viewState.GR_VIEWALANCE97_05 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_NEXTUBNCE_79766"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: CapitalToFallDue
            $scope.vc.viewState.VA_VIEWALANCE9705_PLFA620 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_CAPMEKBVN_97226"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: InterestToFallDue
            $scope.vc.viewState.VA_VIEWALANCE9705_TEDE998 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_INTERESTW_15793"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: ArrearsToFallDue
            $scope.vc.viewState.VA_VIEWALANCE9705_REAL098 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_ARREARSJS_67269"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: InsuranceToFallDue
            $scope.vc.viewState.VA_VIEWALANCE9705_NADE213 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_INSUREUQZ_06562"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: OtherItemsToFallDue
            $scope.vc.viewState.VA_VIEWALANCE9705_TOLE799 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_OTHERITEM_36371"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.viewState.VA_VIEWALANCE9705_0000790 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: '',
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: TotalToFallDue
            $scope.vc.viewState.VA_VIEWALANCE9705_TAOL760 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_TOTALOCEI_29396"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Group: GPTotalDebtBalance
            $scope.vc.viewState.GR_VIEWALANCE97_06 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                statusStyle: {
                    success: false,
                    fail: false,
                    none: true,
                    numErrors: undefined
                },
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_TOTATNGAA_98056"),
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: CapitalTotalIndebtedness
            $scope.vc.viewState.VA_VIEWALANCE9706_0000322 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_CAPMEKBVN_97226"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: InterestTotalIndebtedness
            $scope.vc.viewState.VA_VIEWALANCE9706_ESLD555 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_INTERESTW_15793"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: ArrearsTotalIndebtedness
            $scope.vc.viewState.VA_VIEWALANCE9706_RIDS553 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_ARREARSJS_67269"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: InsuranceTotalIndebtedness
            $scope.vc.viewState.VA_VIEWALANCE9706_LDSS167 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_INSUREUQZ_06562"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: OtherItemsTotalIndebtedness
            $scope.vc.viewState.VA_VIEWALANCE9706_ELIE182 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_OTHERITEM_36371"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            $scope.vc.viewState.VA_VIEWALANCE9706_0000712 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: '',
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Entity: DebtBalance, Attribute: TotalIndebtedness
            $scope.vc.viewState.VA_VIEWALANCE9706_OENS116 = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: $filter("translate")("BUSIN.DLB_BUSIN_TOTALOCEI_29396"),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                get readonly() {
                    if (angular.isDefined(this._readonly)) {
                        return this._readonly;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
                },
                set readonly(readonly) {
                    this._readonly = readonly;
                },
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //Creación de viewState para los botones de comandos
            //ViewState - Command: Accept
            $scope.vc.viewState.T_FLCRE_62_SPETN81_ACCEPT = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: 'Accept',
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
            };
            //ViewState - Command: Cancel
            $scope.vc.viewState.T_FLCRE_62_SPETN81_CANCEL = {
                _readonly: undefined,
                _disabled: undefined,
                _visible: undefined,
                style: [],
                label: 'Cancel',
                get disabled() {
                    if (angular.isDefined(this._disabled)) {
                        return this._disabled;
                    }
                    return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set disabled(disabled) {
                    this._disabled = disabled;
                },
                get visible() {
                    if (angular.isDefined(this._visible)) {
                        return this._visible;
                    }
                    return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
                },
                set visible(visible) {
                    this._visible = visible;
                }
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
        $scope._initGrids = function() {
            for (var gridN in $scope.vc.grids) {
                var queryId = $scope.vc.grids[gridN].queryId;
                var queryRequest = $scope.vc.request.qr[queryId];
                if (queryId && queryRequest) {
                    if ($scope.vc.model[designer.utils.metadata.findEntityNameById($scope.vc.metadata, queryRequest.mainEntityPk.entityId)].total() == 0) {
                        if ($scope.vc.queryProperties[queryId].autoCrud) {
                            $scope.vc.CRUDExecuteQueryId(queryRequest, true);
                        } else {
                            queryRequest.updateParameters();
                            $scope.vc.executeQuery(gridN, queryRequest.queryPk.queryId, queryRequest.parameters, queryRequest.mainEntityPk.entityId, true);
                        }
                    }
                }
            }
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
        $scope._initPage_ProcessData = function(page) {
            if (!page.hasTemporaryData && !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                //llenado de grids
                $scope._initGrids();
                return page;
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
                $scope.vc.render('VC_SPETN81_AQUAT_670');
            }
            return page;
        };
        $scope._prepareThreadLifeCycle = function(page) {
            var deferrer = $q.defer();
            setTimeout(function() {
                deferrer.resolve(page);
            }, 0);
            return deferrer.promise;
        };
        $scope._runLifeCycle = function(page, promise) {
            promise.then(

            function(page) {
                return $scope.vc.temporaryRead(page);
            })
                .then(

            function(page) {
                return $scope.vc.initData(page, $scope.vc);
            })
                .then(

            function(page) {
                return $scope._initPage_CRUDExecuteQueryEntities(page);
            })
                .then(

            function(page) {
                return $scope._initPage_ProcessData(page);
            })
                .then(

            function(page) {
                return $scope._initPage_InitializeTrackers(page);
            })
                .then(

            function(page) {
                return $scope._initPage_ChangeInitData(page);
            })
                .then(

            function(page) {
                return $scope._initPage_ProcessRender(page);
            });
        };
        if ($scope.vc.isModal($scope) || $scope.vc.isDetailGrid($scope) || $scope.isDesignerInclude) {
            //para ventanas modales se usa ng-include con onload
            $scope.runLifeCycle = function() {
                var threadLifeCycle = $scope._prepareThreadLifeCycle(page);
                if (threadLifeCycle) {
                    $scope._runLifeCycle(page, threadLifeCycle);
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
                } else {
                    //Si es la primera vez que se ejecuta la pantalla
                    var threadLifeCycle = $scope._prepareThreadLifeCycle(page);
                    if (threadLifeCycle) {
                        $scope._runLifeCycle(page, threadLifeCycle);
                    }
                }
            });
        }
    }]);
}
if (typeof cobisMainModule === "undefined") {
    var cobisMainModule = cobis.createModule("VC_SPETN81_AQUAT_670", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_SPETN81_AQUAT_670", {
            templateUrl: "VC_SPETN81_AQUAT_670_FORM.html",
            controller: "VC_SPETN81_AQUAT_670_CTRL",
            labelId: "BUSIN.DLB_BUSIN_OATOOFTIO_48779",
            locales: function($translatePartialLoaderProvider, $translate) {
                $translatePartialLoaderProvider.addPart('DSGNR');
                $translatePartialLoaderProvider.addPart('BUSIN');
                if (culture) {
                    $translate.use(culture);
                } else {
                    $translate.use('es');
                }
                return $translate.refresh();
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_SPETN81_AQUAT_670?" + $.param(search);
            },
            locales: function($translatePartialLoaderProvider, $translate) {
                $translatePartialLoaderProvider.addPart('DSGNR');
                $translatePartialLoaderProvider.addPart('BUSIN');
                if (culture) {
                    $translate.use(culture);
                } else {
                    $translate.use('es');
                }
                return $translate.refresh();
            }
        });
        VC_SPETN81_AQUAT_670(cobisMainModule);
    }]);
} else {
    VC_SPETN81_AQUAT_670(cobisMainModule);
}