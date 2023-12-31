<!-- Designer Generator v 6.0.0 - release SPR 2016-13 08/07/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.operationsearch = designerEvents.api.operationsearch || designer.dsgEvents();

function VC_OSRCH32_AOEAR_233(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_OSRCH32_AOEAR_233_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_OSRCH32_AOEAR_233_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_21_OSRCH32",
            taskVersion: "1.0.0",
            viewContainerId: "VC_OSRCH32_AOEAR_233",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_21_OSRCH32",
        designerEvents.api.operationsearch,
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
                vcName: 'VC_OSRCH32_AOEAR_233'
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
                    taskId: 'T_FLCRE_21_OSRCH32',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CustomerSearch: "CustomerSearch",
                    RefinancingOperations: "RefinancingOperations"
                },
                entities: {
                    CustomerSearch: {
                        Principal: 'AT_CTM765PRIL69',
                        Customer: 'AT_CTM765CSER32',
                        CustomerId: 'AT_CTM765CTRD40',
                        TypeOperation: 'AT_CTM765TETI67',
                        TypeObject: 'AT_CTM765EBCT18',
                        FlagCriteria: 'AT_CTM765CRTA11',
                        Sector: 'AT_CTM765SCTR12',
                        Flagexit: 'AT_CTM765LGET20',
                        TypeProcess: 'AT_CTM765TPOE49',
                        Expromission: 'AT_CTM765RMII18',
                        Officer: 'AT_CTM765OFIE85',
                        OfficerId: 'AT_CTM765FCED82',
                        _pks: [],
                        _entityId: 'EN_CTMERSEAR765',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RefinancingOperations: {
                        IdOperation: 'AT_RNA459DPER71',
                        RefinancingOption: 'AT_RNA459ANOP06',
                        Balance: 'AT_RNA459BANC23',
                        OriginalAmount: 'AT_RNA459GAMO94',
                        LocalCurrencyAmount: 'AT_RNA459RNUN43',
                        CreditType: 'AT_RNA459EITY95',
                        InternalCustomerClassification: 'AT_RNA459NAIC57',
                        DateGranting: 'AT_RNA459DTGN73',
                        IdRequestedOperation: 'AT_RNA459IDOO11',
                        OperationBank: 'AT_RNA459EANA92',
                        LocalCurrencyBalance: 'AT_RNA459OCBA30',
                        CurrencyOperation: 'AT_RNA459CURA87',
                        IsBase: 'AT_RNA459SIAL87',
                        oficialOperation: 'AT_RNA459AORN87',
                        OperationQualification: 'AT_RNA459EATI72',
                        PayoutPercentage: 'AT_RNA459PEEE15',
                        Rate: 'AT_RNA459RATE39',
                        Sector: 'AT_RNA459SEOR45',
                        Payment: 'AT_RNA459AMEN20',
                        Capitalize: 'AT_RNA459APIT61',
                        State: 'AT_RNA459STTS89',
                        ExpirationDate: 'AT_RNA459EPIN83',
                        Moratory: 'AT_RNA459RORY08',
                        TypeOperation: 'AT_RNA459EPER64',
                        _pks: [],
                        _entityId: 'EN_RNANCOPAI459',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ITRICNAN_1523 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_ITRICNAN_1523 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ITRICNAN_1523_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ITRICNAN_1523_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RNANCOPAI459',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ITRICNAN_1523',
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
            $scope.vc.queries.Q_ITRICNAN_1523_filters = {};
            defaultValues = {
                CustomerSearch: {},
                RefinancingOperations: {}
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
            $scope.vc.viewState.VC_OSRCH32_AOEAR_233 = {
                style: []
            }
            //ViewState - Container: operationSearch
            $scope.vc.createViewState({
                id: "VC_OSRCH32_AOEAR_233",
                hasId: true,
                componentStyle: "",
                label: 'operationSearch',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Customer
            $scope.vc.createViewState({
                id: "VC_OSRCH32_UNORE_091",
                hasId: true,
                componentStyle: "",
                label: 'Customer',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.CustomerSearch = {
                Principal: $scope.vc.channelDefaultValues("CustomerSearch", "Principal"),
                Customer: $scope.vc.channelDefaultValues("CustomerSearch", "Customer"),
                CustomerId: $scope.vc.channelDefaultValues("CustomerSearch", "CustomerId"),
                TypeOperation: $scope.vc.channelDefaultValues("CustomerSearch", "TypeOperation"),
                TypeObject: $scope.vc.channelDefaultValues("CustomerSearch", "TypeObject"),
                FlagCriteria: $scope.vc.channelDefaultValues("CustomerSearch", "FlagCriteria"),
                Sector: $scope.vc.channelDefaultValues("CustomerSearch", "Sector"),
                Flagexit: $scope.vc.channelDefaultValues("CustomerSearch", "Flagexit"),
                TypeProcess: $scope.vc.channelDefaultValues("CustomerSearch", "TypeProcess"),
                Expromission: $scope.vc.channelDefaultValues("CustomerSearch", "Expromission"),
                Officer: $scope.vc.channelDefaultValues("CustomerSearch", "Officer"),
                OfficerId: $scope.vc.channelDefaultValues("CustomerSearch", "OfficerId")
            };
            //ViewState - Group: CustomerSearch
            $scope.vc.createViewState({
                id: "GR_TOMERSHVIW60_14",
                hasId: true,
                componentStyle: "",
                label: 'CustomerSearch',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CustomerSearch, Attribute: Customer
            $scope.vc.createViewState({
                id: "VA_TOMERSHVIW6014_CSER255",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LJRXITRFW_70117",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CustomerSearch, Attribute: CustomerId
            $scope.vc.createViewState({
                id: "VA_TOMERSHVIW6014_CTRD054",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BUSCARGJN_88350",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: Operaciones
            $scope.vc.createViewState({
                id: "VC_OSRCH32_GPOSM_522",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OPERAIONS_92635",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_EINNIETODA34_62",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_EINNIETODA34_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RefinancingOperations = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    OperationBank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OperationBank", '')
                    },
                    CurrencyOperation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "CurrencyOperation", 0)
                    },
                    Balance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "Balance", 0)
                    },
                    LocalCurrencyBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "LocalCurrencyBalance", 0)
                    },
                    OriginalAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OriginalAmount", 0)
                    },
                    LocalCurrencyAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "LocalCurrencyAmount", 0)
                    },
                    TypeOperation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "TypeOperation", '')
                    },
                    CreditType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "CreditType", '')
                    },
                    InternalCustomerClassification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "InternalCustomerClassification", '')
                    },
                    DateGranting: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "DateGranting", '')
                    },
                    ExpirationDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "ExpirationDate", '')
                    },
                    State: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "State", '')
                    },
                    IdOperation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "IdOperation", '')
                    },
                    RefinancingOption: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "RefinancingOption", '')
                    },
                    IsBase: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "IsBase", false)
                    },
                    oficialOperation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "oficialOperation", 0)
                    },
                    OperationQualification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OperationQualification", '')
                    },
                    PayoutPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "PayoutPercentage", 0)
                    },
                    Payment: {
                        type: "number",
                        editable: true
                    },
                    Rate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "Rate", 0)
                    },
                    Moratory: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "Moratory", 0)
                    },
                    Capitalize: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "Capitalize", false)
                    }
                }
            });
            $scope.vc.model.RefinancingOperations = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_ITRICNAN_1523();
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
                    model: $scope.vc.types.RefinancingOperations
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_ITRIC1523_25").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ITRICNAN_1523 = $scope.vc.model.RefinancingOperations;
            $scope.vc.trackers.RefinancingOperations = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RefinancingOperations);
            $scope.vc.model.RefinancingOperations.bind('change', function(e) {
                $scope.vc.trackers.RefinancingOperations.track(e);
            });
            $scope.vc.grids.QV_ITRIC1523_25 = {};
            $scope.vc.grids.QV_ITRIC1523_25.queryId = 'Q_ITRICNAN_1523';
            $scope.vc.viewState.QV_ITRIC1523_25 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column = {};
            $scope.vc.grids.QV_ITRIC1523_25.events = {
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
                    $scope.vc.trackers.RefinancingOperations.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_ITRIC1523_25.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_ITRIC1523_25");
                    $scope.vc.hideShowColumns("QV_ITRIC1523_25", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_ITRIC1523_25.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_ITRIC1523_25.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_ITRIC1523_25.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_ITRIC1523_25 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_ITRIC1523_25 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_ITRIC1523_25.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ITRIC1523_25.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ITRIC1523_25.column.OperationBank = {
                title: 'BUSIN.DLB_BUSIN_OPEIONBER_32159',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_EANA040',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EANA92 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.OperationBank.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_EANA040",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.OperationBank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.OperationBank.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.OperationBank.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation = {
                title: 'BUSIN.DLB_BUSIN_MONEDAWDW_15876',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_CURA526',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_EINNIETODA3403_CURA526 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_EINNIETODA3403_CURA526_values)) {
                            $scope.vc.catalogs.VA_EINNIETODA3403_CURA526_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_EINNIETODA3403_CURA526',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_EINNIETODA3403_CURA526'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_EINNIETODA3403_CURA526_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_25", "VA_EINNIETODA3403_CURA526");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_EINNIETODA3403_CURA526_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_25", "VA_EINNIETODA3403_CURA526");
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
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459CURA87 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_CURA526",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_EINNIETODA3403_CURA526",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.validationCode}}",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.Balance = {
                title: 'BUSIN.DLB_BUSIN_BALANCESI_24039',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_BANC305',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459BANC23 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Balance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_BANC305",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.Balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.Balance.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.Balance.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Balance.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.Balance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance = {
                title: 'BUSIN.DLB_BUSIN_LORRNYANE_43671',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_OCBA303',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459OCBA30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_OCBA303",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.OriginalAmount = {
                title: 'BUSIN.DLB_BUSIN_ORILAMOUN_89859',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_GAMO975',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459GAMO94 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_GAMO975",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount = {
                title: 'BUSIN.DLB_BUSIN_OTLCLCREY_32226',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_RNUN109',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459RNUN43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_RNUN109",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.TypeOperation = {
                title: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                width: 220,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_EPER323',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EPER64 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.TypeOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CREDITYPE_12941'|translate}}",
                        'id': "VA_EINNIETODA3403_EPER323",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.TypeOperation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.TypeOperation.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.TypeOperation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.CreditType = {
                title: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_EITY714',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_EINNIETODA3403_EITY714 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_EINNIETODA3403_EITY714_values)) {
                            $scope.vc.catalogs.VA_EINNIETODA3403_EITY714_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_EINNIETODA3403_EITY714',
                                'ca_toperacion',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_EINNIETODA3403_EITY714'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_EINNIETODA3403_EITY714_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_25", "VA_EINNIETODA3403_EITY714");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_EINNIETODA3403_EITY714_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_25", "VA_EINNIETODA3403_EITY714");
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
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EITY95 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.CreditType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_EITY714",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_25.column.CreditType.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_EINNIETODA3403_EITY714",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_25.column.CreditType.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.CreditType.validationCode}}",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification = {
                title: 'BUSIN.DLB_BUSIN_INATOIATO_87203',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_NAIC831',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459NAIC57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_NAIC831",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.DateGranting = {
                title: 'BUSIN.DLB_BUSIN_ATEGRANTN_55879',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_DTGN810',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459DTGN73 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.DateGranting.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_DTGN810",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.DateGranting.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.DateGranting.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.DateGranting.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.ExpirationDate = {
                title: 'BUSIN.DLB_BUSIN_EXIRTIONA_39042',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_EXIRTIONA_39042',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_EPIN142',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EPIN83 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_EXIRTIONA_39042'|translate}}",
                        'id': "VA_EINNIETODA3403_EPIN142",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.State = {
                title: 'BUSIN.DLB_BUSIN_STATEQINL_03037',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_STATEQINL_03037',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_STTS104',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459STTS89 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.State.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_STATEQINL_03037'|translate}}",
                        'id': "VA_EINNIETODA3403_STTS104",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.State.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.State.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.State.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.IdOperation = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_DPER989',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459DPER71 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.IdOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_DPER989",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.IdOperation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.IdOperation.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.IdOperation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.RefinancingOption = {
                title: 'BUSIN.DLB_BUSIN_RFNANIPTN_49588',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_ANOP850',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_EINNIETODA3403_ANOP850 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_EINNIETODA3403_ANOP850_values)) {
                            $scope.vc.catalogs.VA_EINNIETODA3403_ANOP850_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_EINNIETODA3403_ANOP850',
                                'cr_opcion_refinan',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_EINNIETODA3403_ANOP850'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_EINNIETODA3403_ANOP850_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_25", "VA_EINNIETODA3403_ANOP850");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_EINNIETODA3403_ANOP850_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_25", "VA_EINNIETODA3403_ANOP850");
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
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459ANOP06 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EINNIETODA3403_ANOP850",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_EINNIETODA3403_ANOP850",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.validationCode}}",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.IsBase = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_SIAL602',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459SIAL87 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.IsBase.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_EINNIETODA3403_SIAL602",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.IsBase.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.IsBase.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.IsBase.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.oficialOperation = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_AORN643',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459AORN87 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.oficialOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_EINNIETODA3403_AORN643",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.oficialOperation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.oficialOperation.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.oficialOperation.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.oficialOperation.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.oficialOperation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.OperationQualification = {
                title: 'BUSIN.DLB_BUSIN_ERINUICON_75539',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_EATI160',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EATI72 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.OperationQualification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_EINNIETODA3403_EATI160",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.OperationQualification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.OperationQualification.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.OperationQualification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_PEEE435',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459PEEE15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_EINNIETODA3403_PEEE435",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.Payment = {
                title: 'Payment',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459AMEN20 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Payment.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.Payment.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.Rate = {
                title: 'BUSIN.DLB_BUSIN_TASAGRLAC_24263',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_TASAGRLAC_24263',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_RATE361',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459RATE39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Rate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_TASAGRLAC_24263'|translate}}",
                        'id': "VA_EINNIETODA3403_RATE361",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.Rate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.Rate.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.Rate.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Rate.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.Rate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.Moratory = {
                title: 'BUSIN.DLB_BUSIN_MORARYDAS_35235',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_MORARYDAS_35235',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_RORY668',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459RORY08 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Moratory.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_MORARYDAS_35235'|translate}}",
                        'id': "VA_EINNIETODA3403_RORY668",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_25.column.Moratory.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_25.column.Moratory.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_25.column.Moratory.decimals",
                        'data-cobis-group': "Group,GR_EINNIETODA34_62,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Moratory.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_25.column.Moratory.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_25.column.Capitalize = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EINNIETODA3403_APIT635',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459APIT61 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_25.column.Capitalize.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_EINNIETODA3403_APIT635",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_25.column.Capitalize.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'OperationBank',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.OperationBank.title|translate:vc.viewState.QV_ITRIC1523_25.column.OperationBank.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.OperationBank.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.OperationBank.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EANA92.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.OperationBank.element[dataItem.uid].style'>#if (OperationBank !== null) {# #=OperationBank# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.OperationBank.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.OperationBank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.OperationBank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'CurrencyOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.title|translate:vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459CURA87.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_EINNIETODA3403_CURA526.get(dataItem.CurrencyOperation).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.CurrencyOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'Balance',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.Balance.title|translate:vc.viewState.QV_ITRIC1523_25.column.Balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.Balance.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.Balance.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459BANC23.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.Balance.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance#, vc.viewState.QV_ITRIC1523_25.column.Balance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.Balance.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.Balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.Balance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'LocalCurrencyBalance',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.title|translate:vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459OCBA30.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=LocalCurrencyBalance#, vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'OriginalAmount',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.title|translate:vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459GAMO94.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=OriginalAmount#, vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.OriginalAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'LocalCurrencyAmount',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.title|translate:vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459RNUN43.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=LocalCurrencyAmount#, vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.LocalCurrencyAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'TypeOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.TypeOperation.title|translate:vc.viewState.QV_ITRIC1523_25.column.TypeOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.TypeOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.TypeOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EPER64.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.TypeOperation.element[dataItem.uid].style'>#if (TypeOperation !== null) {# #=TypeOperation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.TypeOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.TypeOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.TypeOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'CreditType',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.CreditType.title|translate:vc.viewState.QV_ITRIC1523_25.column.CreditType.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.CreditType.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.CreditType.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EITY95.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.CreditType.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_EINNIETODA3403_EITY714.get(dataItem.CreditType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.CreditType.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.CreditType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.CreditType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'InternalCustomerClassification',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.title|translate:vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459NAIC57.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.element[dataItem.uid].style'>#if (InternalCustomerClassification !== null) {# #=InternalCustomerClassification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.InternalCustomerClassification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'DateGranting',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.DateGranting.title|translate:vc.viewState.QV_ITRIC1523_25.column.DateGranting.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.DateGranting.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.DateGranting.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459DTGN73.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.DateGranting.element[dataItem.uid].style'>#if (DateGranting !== null) {# #=DateGranting# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.DateGranting.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.DateGranting.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.DateGranting.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'ExpirationDate',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.title|translate:vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EPIN83.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.element[dataItem.uid].style'>#if (ExpirationDate !== null) {# #=ExpirationDate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.ExpirationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'State',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.State.title|translate:vc.viewState.QV_ITRIC1523_25.column.State.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.State.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.State.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459STTS89.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.State.element[dataItem.uid].style'>#if (State !== null) {# #=State# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.State.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.State.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.State.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'IdOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.IdOperation.title|translate:vc.viewState.QV_ITRIC1523_25.column.IdOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.IdOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.IdOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459DPER71.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.IdOperation.element[dataItem.uid].style'>#if (IdOperation !== null) {# #=IdOperation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.IdOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.IdOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.IdOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'RefinancingOption',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.title|translate:vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459ANOP06.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_EINNIETODA3403_ANOP850.get(dataItem.RefinancingOption).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.RefinancingOption.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'IsBase',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.IsBase.title|translate:vc.viewState.QV_ITRIC1523_25.column.IsBase.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.IsBase.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.IsBase.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459SIAL87.control,
                    template: "<input name='IsBase' type='checkbox' value='#=IsBase#' #=IsBase?checked='checked':''# disabled='disabled' data-bind='value:IsBase' ng-class='vc.viewState.QV_ITRIC1523_25.column.IsBase.element[dataItem.uid].style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.IsBase.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.IsBase.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.IsBase.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'oficialOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.oficialOperation.title|translate:vc.viewState.QV_ITRIC1523_25.column.oficialOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.oficialOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.oficialOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459AORN87.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.oficialOperation.element[dataItem.uid].style' ng-bind='kendo.toString(#=oficialOperation#, vc.viewState.QV_ITRIC1523_25.column.oficialOperation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.oficialOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.oficialOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.oficialOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'OperationQualification',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.OperationQualification.title|translate:vc.viewState.QV_ITRIC1523_25.column.OperationQualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.OperationQualification.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.OperationQualification.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459EATI72.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.OperationQualification.element[dataItem.uid].style'>#if (OperationQualification !== null) {# #=OperationQualification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.OperationQualification.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.OperationQualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.OperationQualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'PayoutPercentage',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.title|translate:vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459PEEE15.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.element[dataItem.uid].style' ng-bind='kendo.toString(#=PayoutPercentage#, vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.PayoutPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'Payment',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.Payment.title|translate:vc.viewState.QV_ITRIC1523_25.column.Payment.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.Payment.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.Payment.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459AMEN20.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.Payment.element[dataItem.uid].style' ng-bind='kendo.toString(#=Payment#, vc.viewState.QV_ITRIC1523_25.column.Payment.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.Payment.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.Payment.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.Payment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'Rate',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.Rate.title|translate:vc.viewState.QV_ITRIC1523_25.column.Rate.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.Rate.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.Rate.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459RATE39.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.Rate.element[dataItem.uid].style' ng-bind='kendo.toString(#=Rate#, vc.viewState.QV_ITRIC1523_25.column.Rate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.Rate.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.Rate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.Rate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'Moratory',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.Moratory.title|translate:vc.viewState.QV_ITRIC1523_25.column.Moratory.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.Moratory.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.Moratory.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459RORY08.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_25.column.Moratory.element[dataItem.uid].style' ng-bind='kendo.toString(#=Moratory#, vc.viewState.QV_ITRIC1523_25.column.Moratory.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.Moratory.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.Moratory.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.Moratory.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_25.columns.push({
                    field: 'Capitalize',
                    title: '{{vc.viewState.QV_ITRIC1523_25.column.Capitalize.title|translate:vc.viewState.QV_ITRIC1523_25.column.Capitalize.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_25.column.Capitalize.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_25.column.Capitalize.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_25.AT_RNA459APIT61.control,
                    template: "<input name='Capitalize' type='checkbox' value='#=Capitalize#' #=Capitalize?checked='checked':''# disabled='disabled' data-bind='value:Capitalize' ng-class='vc.viewState.QV_ITRIC1523_25.column.Capitalize.element[dataItem.uid].style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_25.column.Capitalize.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_25.column.Capitalize.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_25.column.Capitalize.hidden
                });
            }
            $scope.vc.viewState.QV_ITRIC1523_25.toolbar = {}
            $scope.vc.grids.QV_ITRIC1523_25.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_21_OSRCH32_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_21_OSRCH32_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: select
            $scope.vc.createViewState({
                id: "CM_OSRCH32SCT35",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_SELECIOAR_14656",
                label: "BUSIN.DLB_BUSIN_SELECIOAR_14656",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_EINNIETODA3403_CURA526.read();
                    $scope.vc.catalogs.VA_EINNIETODA3403_EITY714.read();
                    $scope.vc.catalogs.VA_EINNIETODA3403_ANOP850.read();
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
                $scope.vc.render('VC_OSRCH32_AOEAR_233');
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
    var cobisMainModule = cobis.createModule("VC_OSRCH32_AOEAR_233", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_OSRCH32_AOEAR_233", {
            templateUrl: "VC_OSRCH32_AOEAR_233_FORM.html",
            controller: "VC_OSRCH32_AOEAR_233_CTRL",
            label: "operationSearch",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_OSRCH32_AOEAR_233?" + $.param(search);
            }
        });
        VC_OSRCH32_AOEAR_233(cobisMainModule);
    }]);
} else {
    VC_OSRCH32_AOEAR_233(cobisMainModule);
}