//Designer Generator v 6.3.6 - release SPR 2018-04 28/02/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.regularizedispersionsrejectedform = designerEvents.api.regularizedispersionsrejectedform || designer.dsgEvents();

function VC_REGULARIOE_732883(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REGULARIOE_732883_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REGULARIOE_732883_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "TRNSC",
            taskId: "T_ASSTSOSPSJXWE_883",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REGULARIOE_732883",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_ASSTSOSPSJXWE_883",
        designerEvents.api.regularizedispersionsrejectedform,
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
                vcName: 'VC_REGULARIOE_732883'
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
                    subModuleId: 'TRNSC',
                    taskId: 'T_ASSTSOSPSJXWE_883',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    SearchRejectedDispersions: "SearchRejectedDispersions",
                    DetailRejectedDispersions: "DetailRejectedDispersions"
                },
                entities: {
                    SearchRejectedDispersions: {
                        startDate: 'AT17_STARTDET733',
                        account: 'AT24_ACCOUNTT733',
                        customerCode: 'AT29_CUSTOMER733',
                        action: 'AT31_ACTIONRO733',
                        type: 'AT37_TYPEFZCB733',
                        selectAll: 'AT40_SELECTAL733',
                        endDate: 'AT95_ENDDATEE733',
                        _pks: [],
                        _entityId: 'EN_SEARCHRSD_733',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    DetailRejectedDispersions: {
                        account: 'AT10_ACCOUNTT659',
                        consecutive: 'AT23_CONSECIT659',
                        dateTimeAction: 'AT29_DATETIAI659',
                        date: 'AT30_DATEFXOB659',
                        customerNames: 'AT38_CUSTOMNS659',
                        selection: 'AT46_SELECTNO659',
                        buc: 'AT50_BUCQXEPF659',
                        bank: 'AT51_BANKIDOB659',
                        valueDispersion: 'AT52_VALUEDSP659',
                        dispersionType: 'AT54_DISPEROT659',
                        customerCode: 'AT55_CUSTOMEO659',
                        user: 'AT59_USERBLVG659',
                        groupName: 'AT69_GROUPNME659',
                        groupCode: 'AT72_GROUPCED659',
                        causal: 'AT76_CAUSALJP659',
                        action: 'AT92_ACTIONRF659',
                        line: 'AT92_LINECTBD659',
                        _pks: [],
                        _entityId: 'EN_DETAILRDN_659',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DETAILTI_3655 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DETAILTI_3655 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DETAILTI_3655_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DETAILTI_3655_filters;
                    parametersAux = {
                        account: filters.account,
                        date: filters.date,
                        customerCode: filters.customerCode,
                        groupCode: filters.groupCode,
                        action: filters.action
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DETAILRDN_659',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DETAILTI_3655',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['account'] = this.filters.account;
                            this.parameters['date'] = this.filters.date;
                            this.parameters['customerCode'] = this.filters.customerCode;
                            this.parameters['groupCode'] = this.filters.groupCode;
                            this.parameters['action'] = this.filters.action;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DETAILTI_3655_filters = {};
            var defaultValues = {
                SearchRejectedDispersions: {},
                DetailRejectedDispersions: {}
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
                $scope.vc.execute("temporarySave", VC_REGULARIOE_732883, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REGULARIOE_732883, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REGULARIOE_732883, data, function() {});
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
            $scope.vc.viewState.VC_REGULARIOE_732883 = {
                style: []
            }
            $scope.vc.model.SearchRejectedDispersions = {
                startDate: $scope.vc.channelDefaultValues("SearchRejectedDispersions", "startDate"),
                account: $scope.vc.channelDefaultValues("SearchRejectedDispersions", "account"),
                customerCode: $scope.vc.channelDefaultValues("SearchRejectedDispersions", "customerCode"),
                action: $scope.vc.channelDefaultValues("SearchRejectedDispersions", "action"),
                type: $scope.vc.channelDefaultValues("SearchRejectedDispersions", "type"),
                selectAll: $scope.vc.channelDefaultValues("SearchRejectedDispersions", "selectAll"),
                endDate: $scope.vc.channelDefaultValues("SearchRejectedDispersions", "endDate")
            };
            //ViewState - Group: Group1856
            $scope.vc.createViewState({
                id: "G_REGULARSPD_780759",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRITERIBS_16700",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchRejectedDispersions, Attribute: customerCode
            $scope.vc.createViewState({
                id: "VA_CUSTOMERCODEOES_830759",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEOP_58328",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchRejectedDispersions, Attribute: startDate
            $scope.vc.createViewState({
                id: "VA_STARTDATELGOWME_142759",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHADESD_11676",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchRejectedDispersions, Attribute: endDate
            $scope.vc.createViewState({
                id: "VA_ENDDATEUEPDHVSH_857759",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAHATS_18279",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchRejectedDispersions, Attribute: account
            $scope.vc.createViewState({
                id: "VA_ACCOUNTBTYMRXTL_129759",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUENTADIA_22037",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchRejectedDispersions, Attribute: action
            $scope.vc.createViewState({
                id: "VA_ACTIONNNJIDLEBK_954759",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ACCINLAPH_93876",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ACTIONNNJIDLEBK_954759 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ACTIONNNJIDLEBK_954759', 'ca_accion_disperciones', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ACTIONNNJIDLEBK_954759'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ACTIONNNJIDLEBK_954759");
                            $scope.vc.setReadOnlyInputCombobox("VA_ACTIONNNJIDLEBK_954759");
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
            //ViewState - Entity: SearchRejectedDispersions, Attribute: type
            $scope.vc.createViewState({
                id: "VA_TYPEEZSINNMYGNJ_496759",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOLDSKB_46090",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPEEZSINNMYGNJ_496759 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TYPEEZSINNMYGNJ_496759', 'ca_tipo_disperciones', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TYPEEZSINNMYGNJ_496759'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TYPEEZSINNMYGNJ_496759");
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
            $scope.vc.createViewState({
                id: "VA_VABUTTONCBSQYDU_564759",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_DETAILTI_3655',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2559
            $scope.vc.createViewState({
                id: "G_REGULAREIS_738759",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_LISTADOZD_94510",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DetailRejectedDispersions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    date: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "date", new Date())
                    },
                    customerCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "customerCode", '')
                    },
                    customerNames: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "customerNames", '')
                    },
                    buc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "buc", '')
                    },
                    dispersionType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "dispersionType", '')
                    },
                    account: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "account", '')
                    },
                    causal: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "causal", '')
                    },
                    groupCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "groupCode", '')
                    },
                    groupName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "groupName", '')
                    },
                    valueDispersion: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "valueDispersion", 0)
                    },
                    action: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "action", '')
                    },
                    dateTimeAction: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "dateTimeAction", '')
                    },
                    user: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "user", '')
                    },
                    selection: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "selection", false)
                    },
                    consecutive: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "consecutive", 0)
                    },
                    line: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "line", 0)
                    },
                    bank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailRejectedDispersions", "bank", '')
                    }
                }
            });
            $scope.vc.model.DetailRejectedDispersions = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DETAILTI_3655';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DETAILTI_3655();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3655_99787',
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
                                            'pageSize': 20
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
                    model: $scope.vc.types.DetailRejectedDispersions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3655_99787").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DETAILTI_3655 = $scope.vc.model.DetailRejectedDispersions;
            $scope.vc.trackers.DetailRejectedDispersions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DetailRejectedDispersions);
            $scope.vc.model.DetailRejectedDispersions.bind('change', function(e) {
                $scope.vc.trackers.DetailRejectedDispersions.track(e);
            });
            $scope.vc.grids.QV_3655_99787 = {};
            $scope.vc.grids.QV_3655_99787.queryId = 'Q_DETAILTI_3655';
            $scope.vc.viewState.QV_3655_99787 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3655_99787.column = {};
            $scope.vc.grids.QV_3655_99787.editable = false;
            $scope.vc.grids.QV_3655_99787.events = {
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
                cancel: function(e) {
                    $scope.vc.trackers.DetailRejectedDispersions.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3655_99787.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
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
                    $scope.vc.gridDataBound("QV_3655_99787");
                    $scope.vc.hideShowColumns("QV_3655_99787", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3655_99787.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3655_99787.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3655_99787.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3655_99787 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3655_99787 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3655_99787.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3655_99787.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3655_99787.column.date = {
                title: 'ASSTS.LBL_ASSTS_FECHAIXNV_55013',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDOAWIOB_824759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT30_DATEFXOB659 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.date.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDOAWIOB_824759",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.date.validationCode}}",
                        'ng-class': "vc.viewState.QV_3655_99787.column.date.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.customerCode = {
                title: 'ASSTS.LBL_ASSTS_IDCLIENET_20149',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSLF_463759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT55_CUSTOMEO659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.customerCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSLF_463759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.customerCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.customerCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.customerNames = {
                title: 'ASSTS.LBL_ASSTS_NOMBREDYM_42115',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDXE_832759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT38_CUSTOMNS659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.customerNames.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDXE_832759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.customerNames.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.customerNames.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.buc = {
                title: 'ASSTS.LBL_ASSTS_CDIGOBUCC_91782',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHOM_252759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT50_BUCQXEPF659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.buc.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHOM_252759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.buc.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.buc.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.dispersionType = {
                title: 'ASSTS.LBL_ASSTS_TIPOHPQQJ_60218',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUTH_713759',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXUTH_713759 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXUTH_713759',
                            'ca_tipo_disperciones',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXUTH_713759'];
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
            $scope.vc.grids.QV_3655_99787.AT54_DISPEROT659 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.dispersionType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUTH_713759",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_3655_99787.column.dispersionType.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXUTH_713759",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_3655_99787.column.dispersionType.template",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.dispersionType.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.account = {
                title: 'ASSTS.LBL_ASSTS_CUENTAFGE_63328',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCZY_322759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT10_ACCOUNTT659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.account.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCZY_322759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.account.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.account.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.causal = {
                title: 'ASSTS.LBL_ASSTS_CAUSALWKP_74638',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIEB_757759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT76_CAUSALJP659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.causal.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIEB_757759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.causal.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.causal.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.groupCode = {
                title: 'ASSTS.LBL_ASSTS_IDGRUPOVM_90058',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNPV_989759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT72_GROUPCED659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.groupCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNPV_989759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.groupCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.groupCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.groupName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREGPR_16019',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDXJ_866759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT69_GROUPNME659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.groupName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDXJ_866759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.groupName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.groupName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.valueDispersion = {
                title: 'ASSTS.LBL_ASSTS_VALORDINP_81022',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWZI_428759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT52_VALUEDSP659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.valueDispersion.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWZI_428759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.valueDispersion.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3655_99787.column.valueDispersion.format",
                        'k-decimals': "vc.viewState.QV_3655_99787.column.valueDispersion.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.valueDispersion.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.action = {
                title: 'ASSTS.LBL_ASSTS_ACCINJLSP_33226',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZZK_194759',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXZZK_194759 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXZZK_194759',
                            'ca_accion_disperciones',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXZZK_194759'];
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
            $scope.vc.grids.QV_3655_99787.AT92_ACTIONRF659 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.action.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZZK_194759",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_3655_99787.column.action.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXZZK_194759",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_3655_99787.column.action.template",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.action.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.dateTimeAction = {
                title: 'ASSTS.LBL_ASSTS_FECHAYHNO_14129',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSUL_587759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT29_DATETIAI659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.dateTimeAction.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSUL_587759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.dateTimeAction.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.dateTimeAction.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.user = {
                title: 'ASSTS.LBL_ASSTS_USUARIORT_71336',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZXY_459759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT59_USERBLVG659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.user.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZXY_459759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.user.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.user.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.selection = {
                title: 'ASSTS.LBL_ASSTS_SELECCINN_88001',
                titleArgs: {},
                tooltip: '',
                width: 50,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXIZTQJZZ_773759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT46_SELECTNO659 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.selection.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CHECKBOXIZTQJZZ_773759",
                        'ng-class': 'vc.viewState.QV_3655_99787.column.selection.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.consecutive = {
                title: 'consecutive',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGZT_421759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT23_CONSECIT659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.consecutive.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGZT_421759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.consecutive.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3655_99787.column.consecutive.format",
                        'k-decimals': "vc.viewState.QV_3655_99787.column.consecutive.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.consecutive.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.line = {
                title: 'line',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQGO_742759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT92_LINECTBD659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.line.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQGO_742759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.line.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3655_99787.column.line.format",
                        'k-decimals': "vc.viewState.QV_3655_99787.column.line.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.line.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3655_99787.column.bank = {
                title: 'bank',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLLN_279759',
                element: []
            };
            $scope.vc.grids.QV_3655_99787.AT51_BANKIDOB659 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3655_99787.column.bank.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLLN_279759",
                        'data-validation-code': "{{vc.viewState.QV_3655_99787.column.bank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3655_99787.column.bank.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'date',
                    title: '{{vc.viewState.QV_3655_99787.column.date.title|translate:vc.viewState.QV_3655_99787.column.date.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.date.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.date.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT30_DATEFXOB659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.date.style'>#=((date !== null) ? kendo.toString(date, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.date.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.date.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.date.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'customerCode',
                    title: '{{vc.viewState.QV_3655_99787.column.customerCode.title|translate:vc.viewState.QV_3655_99787.column.customerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.customerCode.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.customerCode.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT55_CUSTOMEO659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.customerCode.style' ng-bind='vc.getStringColumnFormat(dataItem.customerCode, \"QV_3655_99787\", \"customerCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.customerCode.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.customerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.customerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'customerNames',
                    title: '{{vc.viewState.QV_3655_99787.column.customerNames.title|translate:vc.viewState.QV_3655_99787.column.customerNames.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.customerNames.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.customerNames.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT38_CUSTOMNS659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.customerNames.style' ng-bind='vc.getStringColumnFormat(dataItem.customerNames, \"QV_3655_99787\", \"customerNames\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.customerNames.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.customerNames.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.customerNames.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'buc',
                    title: '{{vc.viewState.QV_3655_99787.column.buc.title|translate:vc.viewState.QV_3655_99787.column.buc.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.buc.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.buc.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT50_BUCQXEPF659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.buc.style' ng-bind='vc.getStringColumnFormat(dataItem.buc, \"QV_3655_99787\", \"buc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.buc.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.buc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.buc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'dispersionType',
                    title: '{{vc.viewState.QV_3655_99787.column.dispersionType.title|translate:vc.viewState.QV_3655_99787.column.dispersionType.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.dispersionType.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.dispersionType.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT54_DISPEROT659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.dispersionType.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXUTH_713759.get(dataItem.dispersionType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.dispersionType.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.dispersionType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.dispersionType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'account',
                    title: '{{vc.viewState.QV_3655_99787.column.account.title|translate:vc.viewState.QV_3655_99787.column.account.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.account.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.account.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT10_ACCOUNTT659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.account.style' ng-bind='vc.getStringColumnFormat(dataItem.account, \"QV_3655_99787\", \"account\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.account.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.account.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.account.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'causal',
                    title: '{{vc.viewState.QV_3655_99787.column.causal.title|translate:vc.viewState.QV_3655_99787.column.causal.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.causal.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.causal.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT76_CAUSALJP659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.causal.style' ng-bind='vc.getStringColumnFormat(dataItem.causal, \"QV_3655_99787\", \"causal\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.causal.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.causal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.causal.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'groupCode',
                    title: '{{vc.viewState.QV_3655_99787.column.groupCode.title|translate:vc.viewState.QV_3655_99787.column.groupCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.groupCode.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.groupCode.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT72_GROUPCED659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.groupCode.style' ng-bind='vc.getStringColumnFormat(dataItem.groupCode, \"QV_3655_99787\", \"groupCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.groupCode.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.groupCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.groupCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'groupName',
                    title: '{{vc.viewState.QV_3655_99787.column.groupName.title|translate:vc.viewState.QV_3655_99787.column.groupName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.groupName.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.groupName.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT69_GROUPNME659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.groupName.style' ng-bind='vc.getStringColumnFormat(dataItem.groupName, \"QV_3655_99787\", \"groupName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.groupName.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.groupName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.groupName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'valueDispersion',
                    title: '{{vc.viewState.QV_3655_99787.column.valueDispersion.title|translate:vc.viewState.QV_3655_99787.column.valueDispersion.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.valueDispersion.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.valueDispersion.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT52_VALUEDSP659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.valueDispersion.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueDispersion, \"QV_3655_99787\", \"valueDispersion\"):kendo.toString(#=valueDispersion#, vc.viewState.QV_3655_99787.column.valueDispersion.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3655_99787.column.valueDispersion.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.valueDispersion.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.valueDispersion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'action',
                    title: '{{vc.viewState.QV_3655_99787.column.action.title|translate:vc.viewState.QV_3655_99787.column.action.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.action.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.action.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT92_ACTIONRF659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.action.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXZZK_194759.get(dataItem.action).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.action.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.action.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.action.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'dateTimeAction',
                    title: '{{vc.viewState.QV_3655_99787.column.dateTimeAction.title|translate:vc.viewState.QV_3655_99787.column.dateTimeAction.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.dateTimeAction.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.dateTimeAction.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT29_DATETIAI659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.dateTimeAction.style' ng-bind='vc.getStringColumnFormat(dataItem.dateTimeAction, \"QV_3655_99787\", \"dateTimeAction\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.dateTimeAction.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.dateTimeAction.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.dateTimeAction.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'user',
                    title: '{{vc.viewState.QV_3655_99787.column.user.title|translate:vc.viewState.QV_3655_99787.column.user.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.user.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.user.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT59_USERBLVG659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.user.style' ng-bind='vc.getStringColumnFormat(dataItem.user, \"QV_3655_99787\", \"user\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.user.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.user.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.user.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'selection',
                    title: '{{vc.viewState.QV_3655_99787.column.selection.title|translate:vc.viewState.QV_3655_99787.column.selection.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.selection.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.selection.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_3655_99787', 'selection', $scope.vc.grids.QV_3655_99787.AT46_SELECTNO659.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_3655_99787', 'selection'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.selection.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.selection.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.selection.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'consecutive',
                    title: '{{vc.viewState.QV_3655_99787.column.consecutive.title|translate:vc.viewState.QV_3655_99787.column.consecutive.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.consecutive.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.consecutive.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT23_CONSECIT659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.consecutive.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.consecutive, \"QV_3655_99787\", \"consecutive\"):kendo.toString(#=consecutive#, vc.viewState.QV_3655_99787.column.consecutive.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3655_99787.column.consecutive.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.consecutive.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.consecutive.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'line',
                    title: '{{vc.viewState.QV_3655_99787.column.line.title|translate:vc.viewState.QV_3655_99787.column.line.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.line.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.line.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT92_LINECTBD659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.line.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.line, \"QV_3655_99787\", \"line\"):kendo.toString(#=line#, vc.viewState.QV_3655_99787.column.line.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3655_99787.column.line.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.line.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.line.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_3655_99787.columns.push({
                    field: 'bank',
                    title: '{{vc.viewState.QV_3655_99787.column.bank.title|translate:vc.viewState.QV_3655_99787.column.bank.titleArgs}}',
                    width: $scope.vc.viewState.QV_3655_99787.column.bank.width,
                    format: $scope.vc.viewState.QV_3655_99787.column.bank.format,
                    editor: $scope.vc.grids.QV_3655_99787.AT51_BANKIDOB659.control,
                    template: "<span ng-class='vc.viewState.QV_3655_99787.column.bank.style' ng-bind='vc.getStringColumnFormat(dataItem.bank, \"QV_3655_99787\", \"bank\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3655_99787.column.bank.style",
                        "title": "{{vc.viewState.QV_3655_99787.column.bank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3655_99787.column.bank.hidden
                });
            }
            $scope.vc.viewState.QV_3655_99787.toolbar = {
                CEQV_201QV_3655_99787_294: {
                    visible: true
                },
                CEQV_201QV_3655_99787_480: {
                    visible: true
                },
                CEQV_201QV_3655_99787_212: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_3655_99787.toolbar = [{
                "name": "CEQV_201QV_3655_99787_294",
                "text": "{{'ASSTS.LBL_ASSTS_MARCARTDO_30250'|translate}}",
                "template": "<button id='CEQV_201QV_3655_99787_294' " + " ng-if='vc.viewState.QV_3655_99787.toolbar.CEQV_201QV_3655_99787_294.visible' " + "ng-disabled = 'vc.viewState.G_REGULAREIS_738759.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_3655_99787_294\",\"DetailRejectedDispersions\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }, {
                "name": "CEQV_201QV_3655_99787_480",
                "template": "<button id='CEQV_201QV_3655_99787_480' " + " ng-if='vc.viewState.QV_3655_99787.toolbar.CEQV_201QV_3655_99787_480.visible' " + "ng-disabled = 'vc.viewState.G_REGULAREIS_738759.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_3655_99787_480\",\"DetailRejectedDispersions\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-square'></span></button>"
            }, {
                "name": "CEQV_201QV_3655_99787_212",
                "template": "<button id='CEQV_201QV_3655_99787_212' " + " ng-if='vc.viewState.QV_3655_99787.toolbar.CEQV_201QV_3655_99787_212.visible' " + "ng-disabled = 'vc.viewState.G_REGULAREIS_738759.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_3655_99787_212\",\"DetailRejectedDispersions\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-check-square'></span></button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSOSPSJXWE_883_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSOSPSJXWE_883_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TASSTSOS_EAN",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REINTENRT_46548",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TASSTSOS_SJO",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CAMBIAREN_91425",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_TASSTSOS_ASN",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CANCELAGB_34331",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXUTH_713759.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXZZK_194759.read();
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
                $scope.vc.render('VC_REGULARIOE_732883');
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
    var cobisMainModule = cobis.createModule("VC_REGULARIOE_732883", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_REGULARIOE_732883", {
            templateUrl: "VC_REGULARIOE_732883_FORM.html",
            controller: "VC_REGULARIOE_732883_CTRL",
            labelId: "ASSTS.LBL_ASSTS_REGULAREA_83070",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REGULARIOE_732883?" + $.param(search);
            }
        });
        VC_REGULARIOE_732883(cobisMainModule);
    }]);
} else {
    VC_REGULARIOE_732883(cobisMainModule);
}