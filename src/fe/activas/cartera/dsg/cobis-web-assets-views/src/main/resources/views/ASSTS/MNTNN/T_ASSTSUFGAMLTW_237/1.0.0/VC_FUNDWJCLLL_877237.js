//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.fund = designerEvents.api.fund || designer.dsgEvents();

function VC_FUNDWJCLLL_877237(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_FUNDWJCLLL_877237_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_FUNDWJCLLL_877237_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout, $translate) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL);
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
            moduleId: "ASSTS",
            subModuleId: "MNTNN",
            taskId: "T_ASSTSUFGAMLTW_237",
            taskVersion: "1.0.0",
            viewContainerId: "VC_FUNDWJCLLL_877237",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_ASSTSUFGAMLTW_237",
        designerEvents.api.fund,
        $scope.rowData);
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
                vcName: 'VC_FUNDWJCLLL_877237'
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
                    moduleId: 'ASSTS',
                    subModuleId: 'MNTNN',
                    taskId: 'T_ASSTSUFGAMLTW_237',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Fund: "Fund"
                },
                entities: {
                    Fund: {
                        amountSource: 'AT31_AMOUNTOR384',
                        incresedValue: 'AT35_INCRESEL384',
                        sponsorId: 'AT39_SPONSORR384',
                        fundName: 'AT57_FUNDNAEE384',
                        sourceType: 'AT60_SOURCEPP384',
                        validityDate: 'AT66_VALIDIDY384',
                        reservedValue: 'AT70_RESERVLL384',
                        statusCode: 'AT71_STATUSOO384',
                        availableBalance: 'AT74_AVAILABE384',
                        fundId: 'AT95_FUNDCOEE384',
                        usedValue: 'AT97_USEDVAUE384',
                        newCustomerCredit: 'AT98_NEWCUSOE384',
                        _pks: [],
                        _entityId: 'EN_FUNDMJKIO_384',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_FUNDQJFL_8975 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_FUNDQJFL_8975 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_FUNDQJFL_8975_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_FUNDQJFL_8975_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_FUNDMJKIO_384',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_FUNDQJFL_8975',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_FUNDQJFL_8975_filters = {};
            var defaultValues = {
                Fund: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (var en in defaultValues) {
                    if (defaultValues.hasOwnProperty(en) && en === entityName) {
                        for (var att in defaultValues[en]) {
                            if (defaultValues[en].hasOwnProperty(att) && att === attributeName) {
                                for (var ch in defaultValues[en][att]) {
                                    if (defaultValues[en][att].hasOwnProperty(ch) && ch === channel) {
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
                };
                $scope.vc.execute("temporarySave", VC_FUNDWJCLLL_877237, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_FUNDWJCLLL_877237, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_FUNDWJCLLL_877237, data, function() {});
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
            $scope.vc.viewState.VC_FUNDWJCLLL_877237 = {
                style: []
            }
            //ViewState - Group: GroupLayout1485
            $scope.vc.createViewState({
                id: "G_FUNDOLEPVM_456448",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1485',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1248
            $scope.vc.createViewState({
                id: "G_FUNDLLHLMN_777448",
                hasId: true,
                componentStyle: [],
                label: 'Group1248',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Fund = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    fundId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "fundId", 0)
                    },
                    fundName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "fundName", '')
                    },
                    sponsorId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "sponsorId", '')
                    },
                    amountSource: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "amountSource", 0)
                    },
                    incresedValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "incresedValue", 0)
                    },
                    usedValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "usedValue", 0)
                    },
                    availableBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "availableBalance", 0)
                    },
                    reservedValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "reservedValue", 0)
                    },
                    statusCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "statusCode", '')
                    },
                    sourceType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "sourceType", '')
                    },
                    newCustomerCredit: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "newCustomerCredit", 0)
                    },
                    validityDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Fund", "validityDate", new Date())
                    }
                }
            });
            $scope.vc.model.Fund = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_FUNDQJFL_8975';
                            var queryRequest = $scope.vc.getRequestQuery_Q_FUNDQJFL_8975();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_8975_37395',
                                    queryRequest,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                options.success(result);
                                            } else {
                                                options.success([]);
                                            }
                                        } else {
                                            options.error([]);
                                        }
                                    }, (function() {
                                        var queryOptions = options.data;
                                        var queryView = {
                                            'allowPaging': true,
                                            'pageSize': 10
                                        };

                                        function config(queryOptions, queryView) {
                                            var result = undefined;
                                            if (queryView.allowPaging === true) {
                                                result = {};
                                                if (angular.isDefined(queryOptions.appendRecords) && queryOptions.appendRecords === true) {
                                                    result.appendRecords = true;
                                                }
                                                result.pageSize = queryView.pageSize;
                                            }
                                            return result;
                                        }
                                        return config(queryOptions, queryView);
                                    }()));
                                }
                            }
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
                    model: $scope.vc.types.Fund
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8975_37395").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_FUNDQJFL_8975 = $scope.vc.model.Fund;
            $scope.vc.trackers.Fund = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Fund);
            $scope.vc.model.Fund.bind('change', function(e) {
                $scope.vc.trackers.Fund.track(e);
            });
            $scope.vc.grids.QV_8975_37395 = {};
            $scope.vc.grids.QV_8975_37395.queryId = 'Q_FUNDQJFL_8975';
            $scope.vc.viewState.QV_8975_37395 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8975_37395.column = {};
            $scope.vc.grids.QV_8975_37395.editable = {
                mode: 'inline',
            };
            $scope.vc.grids.QV_8975_37395.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.Fund(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_ASSTSLBVYTVMM_226",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_DETAILFUND_362226',
                        title: 'ASSTS.LBL_ASSTS_MANTENIEO_87275',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_8975_37395", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
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
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_ASSTSLBVYTVMM_226",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_DETAILFUND_362226',
                        title: 'ASSTS.LBL_ASSTS_MANTENIEO_87275',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_8975_37395", dialogParameters);
                },
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
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
                    $scope.vc.gridDataBound("QV_8975_37395");
                    $scope.vc.hideShowColumns("QV_8975_37395", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8975_37395.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8975_37395.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8975_37395.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8975_37395 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8975_37395 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8975_37395.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8975_37395.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8975_37395.column.fundId = {
                title: 'ASSTS.LBL_ASSTS_CDIGOFUTN_63507',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYUB_820448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.fundName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREDOF_51654',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGIY_595448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.sponsorId = {
                title: 'ASSTS.LBL_ASSTS_FUENTEROO_22709',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXASY_494448',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXASY_494448 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXASY_494448',
                            'ca_fuente_recurso',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXASY_494448'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_8975_37395.column.amountSource = {
                title: 'ASSTS.LBL_ASSTS_MONTOORNI_91217',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNUB_725448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.incresedValue = {
                title: 'ASSTS.LBL_ASSTS_AUMENTOTO_45456',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXORC_972448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.usedValue = {
                title: 'ASSTS.LBL_ASSTS_VALORUTZL_53340',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGDY_608448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.availableBalance = {
                title: 'ASSTS.LBL_ASSTS_SALDODISO_27034',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLLE_233448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.reservedValue = {
                title: 'ASSTS.LBL_ASSTS_VALORREDR_65983',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJTX_572448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.statusCode = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHTK_710448',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXHTK_710448 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXHTK_710448',
                            'cl_estado_ser',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXHTK_710448'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_8975_37395.column.sourceType = {
                title: 'ASSTS.LBL_ASSTS_TIPOFUENN_62952',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZFG_221448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.newCustomerCredit = {
                title: 'ASSTS.LBL_ASSTS_CRDITOCSL_10382',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDUB_509448',
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.validityDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAVIGC_60000',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDFFPDVP_590448',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'fundId',
                    title: '{{vc.viewState.QV_8975_37395.column.fundId.title|translate:vc.viewState.QV_8975_37395.column.fundId.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.fundId.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.fundId.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.fundId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.fundId, \"QV_8975_37395\", \"fundId\"):kendo.toString(#=fundId#, vc.viewState.QV_8975_37395.column.fundId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8975_37395.column.fundId.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.fundId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.fundId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'fundName',
                    title: '{{vc.viewState.QV_8975_37395.column.fundName.title|translate:vc.viewState.QV_8975_37395.column.fundName.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.fundName.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.fundName.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.fundName.style' ng-bind='vc.getStringColumnFormat(dataItem.fundName, \"QV_8975_37395\", \"fundName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8975_37395.column.fundName.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.fundName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.fundName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'sponsorId',
                    title: '{{vc.viewState.QV_8975_37395.column.sponsorId.title|translate:vc.viewState.QV_8975_37395.column.sponsorId.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.sponsorId.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.sponsorId.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.sponsorId.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXASY_494448.get(dataItem.sponsorId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8975_37395.column.sponsorId.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.sponsorId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.sponsorId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'amountSource',
                    title: '{{vc.viewState.QV_8975_37395.column.amountSource.title|translate:vc.viewState.QV_8975_37395.column.amountSource.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.amountSource.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.amountSource.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.amountSource.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amountSource, \"QV_8975_37395\", \"amountSource\"):kendo.toString(#=amountSource#, vc.viewState.QV_8975_37395.column.amountSource.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8975_37395.column.amountSource.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.amountSource.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.amountSource.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'incresedValue',
                    title: '{{vc.viewState.QV_8975_37395.column.incresedValue.title|translate:vc.viewState.QV_8975_37395.column.incresedValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.incresedValue.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.incresedValue.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.incresedValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.incresedValue, \"QV_8975_37395\", \"incresedValue\"):kendo.toString(#=incresedValue#, vc.viewState.QV_8975_37395.column.incresedValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8975_37395.column.incresedValue.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.incresedValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.incresedValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'usedValue',
                    title: '{{vc.viewState.QV_8975_37395.column.usedValue.title|translate:vc.viewState.QV_8975_37395.column.usedValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.usedValue.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.usedValue.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.usedValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.usedValue, \"QV_8975_37395\", \"usedValue\"):kendo.toString(#=usedValue#, vc.viewState.QV_8975_37395.column.usedValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8975_37395.column.usedValue.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.usedValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.usedValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'availableBalance',
                    title: '{{vc.viewState.QV_8975_37395.column.availableBalance.title|translate:vc.viewState.QV_8975_37395.column.availableBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.availableBalance.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.availableBalance.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.availableBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.availableBalance, \"QV_8975_37395\", \"availableBalance\"):kendo.toString(#=availableBalance#, vc.viewState.QV_8975_37395.column.availableBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8975_37395.column.availableBalance.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.availableBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.availableBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'reservedValue',
                    title: '{{vc.viewState.QV_8975_37395.column.reservedValue.title|translate:vc.viewState.QV_8975_37395.column.reservedValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.reservedValue.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.reservedValue.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.reservedValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.reservedValue, \"QV_8975_37395\", \"reservedValue\"):kendo.toString(#=reservedValue#, vc.viewState.QV_8975_37395.column.reservedValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8975_37395.column.reservedValue.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.reservedValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.reservedValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'statusCode',
                    title: '{{vc.viewState.QV_8975_37395.column.statusCode.title|translate:vc.viewState.QV_8975_37395.column.statusCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.statusCode.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.statusCode.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.statusCode.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXHTK_710448.get(dataItem.statusCode).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8975_37395.column.statusCode.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.statusCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.statusCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'sourceType',
                    title: '{{vc.viewState.QV_8975_37395.column.sourceType.title|translate:vc.viewState.QV_8975_37395.column.sourceType.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.sourceType.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.sourceType.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.sourceType.style' ng-bind='vc.getStringColumnFormat(dataItem.sourceType, \"QV_8975_37395\", \"sourceType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8975_37395.column.sourceType.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.sourceType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.sourceType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'newCustomerCredit',
                    title: '{{vc.viewState.QV_8975_37395.column.newCustomerCredit.title|translate:vc.viewState.QV_8975_37395.column.newCustomerCredit.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.newCustomerCredit.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.newCustomerCredit.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.newCustomerCredit.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.newCustomerCredit, \"QV_8975_37395\", \"newCustomerCredit\"):kendo.toString(#=newCustomerCredit#, vc.viewState.QV_8975_37395.column.newCustomerCredit.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8975_37395.column.newCustomerCredit.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.newCustomerCredit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.newCustomerCredit.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8975_37395.columns.push({
                    field: 'validityDate',
                    title: '{{vc.viewState.QV_8975_37395.column.validityDate.title|translate:vc.viewState.QV_8975_37395.column.validityDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_8975_37395.column.validityDate.width,
                    format: $scope.vc.viewState.QV_8975_37395.column.validityDate.format,
                    template: "<span ng-class='vc.viewState.QV_8975_37395.column.validityDate.style'>#=((validityDate !== null) ? kendo.toString(validityDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8975_37395.column.validityDate.style",
                        "title": "{{vc.viewState.QV_8975_37395.column.validityDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8975_37395.column.validityDate.hidden
                });
            }
            $scope.vc.viewState.QV_8975_37395.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_8975_37395.column.cmdEdition = {};
            $scope.vc.viewState.QV_8975_37395.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_8975_37395.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Fund",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_8975_37395.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_8975_37395.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_FUNDLLHLMN_777448.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_8975_37395.events.customEdit($event, \"#:entity#\", grids.QV_8975_37395)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_8975_37395.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_8975_37395.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_8975_37395.toolbar = [{
                "name": "create",
                "entity": "Fund",
                "text": "",
                "template": "<button id = 'QV_8975_37395_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_8975_37395.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_FUNDLLHLMN_777448.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_8975_37395.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSUFGAMLTW_237_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSUFGAMLTW_237_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXASY_494448.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXHTK_710448.read();
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
                $scope.vc.render('VC_FUNDWJCLLL_877237');
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
                    if (($scope.vc.hasOnCloseModalEvent && angular.isDefined($scope.vc.dialogParameters.autoSync) && $scope.vc.dialogParameters.autoSync === false) && ($scope.vc.dialogResponse || $scope.vc.customDialogResponse)) {
                        $scope.vc.onCloseModalEvent();
                    }
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
    var cobisMainModule = cobis.createModule("VC_FUNDWJCLLL_877237", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_FUNDWJCLLL_877237", {
            templateUrl: "VC_FUNDWJCLLL_877237_FORM.html",
            controller: "VC_FUNDWJCLLL_877237_CTRL",
            labelId: "ASSTS.LBL_ASSTS_MANEJOFOO_89494",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_FUNDWJCLLL_877237?" + $.param(search);
            }
        });
        VC_FUNDWJCLLL_877237(cobisMainModule);
    }]);
} else {
    VC_FUNDWJCLLL_877237(cobisMainModule);
}