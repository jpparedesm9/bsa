//Designer Generator v 6.4.0.2 - SPR 2018-13 26/06/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.addalertsform = designerEvents.api.addalertsform || designer.dsgEvents();

function VC_ADDALERTSS_984829(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_ADDALERTSS_984829_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_ADDALERTSS_984829_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "CSTMR",
            subModuleId: "CSTMR",
            taskId: "T_CSTMRZIMDHJYH_829",
            taskVersion: "1.0.0",
            viewContainerId: "VC_ADDALERTSS_984829",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMRZIMDHJYH_829",
        designerEvents.api.addalertsform,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
                hasChangeInitDataSupport: false,
                hasSearchRenderEvent: false,
                ejecTemporaryData: false,
                ejecInitData: false,
                ejecChangeInitData: false,
                ejecSearchRenderEvent: false,
                hasTemporaryData: false,
                hasInitData: false,
                hasChangeInitData: false,
                hasCRUDSupport: false,
                vcName: 'VC_ADDALERTSS_984829'
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
                    moduleId: 'CSTMR',
                    subModuleId: 'CSTMR',
                    taskId: 'T_CSTMRZIMDHJYH_829',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    UnusualOperations: "UnusualOperations",
                    UnusualOperationsView: "UnusualOperationsView"
                },
                entities: {
                    UnusualOperations: {
                        commentary: 'AT16_COMMENRY757',
                        customerSecondSurname: 'AT38_CUSTOMEM757',
                        customerSurname: 'AT45_CUSTOMRR757',
                        highDate: 'AT58_HIGHDAEE757',
                        customerName: 'AT69_CUSTOMEN757',
                        reportDate: 'AT74_REPORTDE757',
                        typeOperation: 'AT82_TYPEOPII757',
                        customerSecondName: 'AT93_CUSTOMER757',
                        _pks: [],
                        _entityId: 'EN_UNUSUALNR_757',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    UnusualOperationsView: {
                        typeOperation: 'AT14_TYPEOPIO630',
                        customerName: 'AT61_CUSTOMAN630',
                        highDate: 'AT72_HIGHDATE630',
                        code: 'AT79_CODIGOGJ630',
                        commentary: 'AT92_COMMENTA630',
                        reportDate: 'AT99_REPORTDT630',
                        _pks: [],
                        _entityId: 'EN_UNUSUALOS_630',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_UNUSUAPO_1129 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_UNUSUAPO_1129 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UNUSUAPO_1129_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UNUSUAPO_1129_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_UNUSUALOS_630',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UNUSUAPO_1129',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_UNUSUAPO_1129_filters = {};
            var defaultValues = {
                UnusualOperations: {},
                UnusualOperationsView: {}
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
                $scope.vc.execute("temporarySave", VC_ADDALERTSS_984829, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_ADDALERTSS_984829, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_ADDALERTSS_984829, data, function() {});
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
            $scope.vc.viewState.VC_ADDALERTSS_984829 = {
                style: []
            }
            $scope.vc.model.UnusualOperations = {
                commentary: $scope.vc.channelDefaultValues("UnusualOperations", "commentary"),
                customerSecondSurname: $scope.vc.channelDefaultValues("UnusualOperations", "customerSecondSurname"),
                customerSurname: $scope.vc.channelDefaultValues("UnusualOperations", "customerSurname"),
                highDate: $scope.vc.channelDefaultValues("UnusualOperations", "highDate"),
                customerName: $scope.vc.channelDefaultValues("UnusualOperations", "customerName"),
                reportDate: $scope.vc.channelDefaultValues("UnusualOperations", "reportDate"),
                typeOperation: $scope.vc.channelDefaultValues("UnusualOperations", "typeOperation"),
                customerSecondName: $scope.vc.channelDefaultValues("UnusualOperations", "customerSecondName")
            };
            //ViewState - Group: Group1213
            $scope.vc.createViewState({
                id: "G_ADDALERSST_162527",
                hasId: true,
                componentStyle: [],
                label: 'Group1213',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: typeOperation
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDSP_311527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOOPERR_94414",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXDSP_311527 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXDSP_311527', 'cl_operaciones_inusuales', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXDSP_311527'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXDSP_311527");
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
                id: "Spacer2841",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1492",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: highDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDVBENWI_336527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHAALAA_51277",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: reportDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDKKWVTW_833527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHAREPP_53187",
                validationCode: 36,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: customerName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTVB_163527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRIMERNRB_92048",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: customerSecondName
            $scope.vc.createViewState({
                id: "VA_CUSTOMERSECOMEE_535527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SEGUNDOEN_22809",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: customerSurname
            $scope.vc.createViewState({
                id: "VA_CUSTOMERSURNMEA_528527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDPT_76332",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: customerSecondSurname
            $scope.vc.createViewState({
                id: "VA_CUSTOMERSECONNN_410527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: UnusualOperations, Attribute: commentary
            $scope.vc.createViewState({
                id: "VA_COMMENTARYSEHXR_641527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_COMENTASO_77518",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2521",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2811",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2440",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONOGPGXMU_783527",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GRABARZHA_67567",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1535
            $scope.vc.createViewState({
                id: "G_ADDALERSTS_846527",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1535',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1637
            $scope.vc.createViewState({
                id: "G_ADDALERSTT_863527",
                hasId: true,
                componentStyle: [],
                label: 'Group1637',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.UnusualOperationsView = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    typeOperation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("UnusualOperationsView", "typeOperation", '')
                    },
                    code: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("UnusualOperationsView", "code", 0)
                    },
                    highDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("UnusualOperationsView", "highDate", new Date())
                    },
                    reportDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("UnusualOperationsView", "reportDate", new Date())
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("UnusualOperationsView", "customerName", '')
                    },
                    commentary: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("UnusualOperationsView", "commentary", '')
                    }
                }
            });
            $scope.vc.model.UnusualOperationsView = new kendo.data.DataSource({
                pageSize: 25,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_UNUSUAPO_1129';
                            var queryRequest = $scope.vc.getRequestQuery_Q_UNUSUAPO_1129();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_1129_31576',
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
                                            'pageSize': 25
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'UnusualOperationsView',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_1129_31576', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.UnusualOperationsView
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1129_31576").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UNUSUAPO_1129 = $scope.vc.model.UnusualOperationsView;
            $scope.vc.trackers.UnusualOperationsView = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.UnusualOperationsView);
            $scope.vc.model.UnusualOperationsView.bind('change', function(e) {
                $scope.vc.trackers.UnusualOperationsView.track(e);
            });
            $scope.vc.grids.QV_1129_31576 = {};
            $scope.vc.grids.QV_1129_31576.queryId = 'Q_UNUSUAPO_1129';
            $scope.vc.viewState.QV_1129_31576 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1129_31576.column = {};
            $scope.vc.grids.QV_1129_31576.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_1129_31576.events = {
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
                    $scope.vc.trackers.UnusualOperationsView.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1129_31576.selectedRow = e.model;
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'UnusualOperationsView',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_1129_31576", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_1129_31576");
                    $scope.vc.hideShowColumns("QV_1129_31576", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1129_31576.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1129_31576.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1129_31576.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1129_31576 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1129_31576 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_1129_31576.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1129_31576.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1129_31576.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1129_31576.column.typeOperation = {
                title: 'CSTMR.LBL_CSTMR_TIPOOPERR_94414',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRCX_635527',
                element: []
            };
            $scope.vc.grids.QV_1129_31576.AT14_TYPEOPIO630 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1129_31576.column.typeOperation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRCX_635527",
                        'data-validation-code': "{{vc.viewState.QV_1129_31576.column.typeOperation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_ADDALERSTS_846527,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1129_31576.column.typeOperation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1129_31576.column.code = {
                title: 'codigo',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKLJ_777527',
                element: []
            };
            $scope.vc.grids.QV_1129_31576.AT79_CODIGOGJ630 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1129_31576.column.code.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKLJ_777527",
                        'data-validation-code': "{{vc.viewState.QV_1129_31576.column.code.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1129_31576.column.code.format",
                        'k-decimals': "vc.viewState.QV_1129_31576.column.code.decimals",
                        'data-cobis-group': "GroupLayout,G_ADDALERSTS_846527,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1129_31576.column.code.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1129_31576.column.highDate = {
                title: 'CSTMR.LBL_CSTMR_FECHAALAA_51277',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDFBZGSY_566527',
                element: []
            };
            $scope.vc.grids.QV_1129_31576.AT72_HIGHDATE630 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1129_31576.column.highDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDFBZGSY_566527",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_1129_31576.column.highDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_1129_31576.column.highDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1129_31576.column.reportDate = {
                title: 'CSTMR.LBL_CSTMR_FECHAREPP_53187',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDMCUQCX_573527',
                element: []
            };
            $scope.vc.grids.QV_1129_31576.AT99_REPORTDT630 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1129_31576.column.reportDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDMCUQCX_573527",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_1129_31576.column.reportDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_1129_31576.column.reportDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1129_31576.column.customerName = {
                title: 'CSTMR.LBL_CSTMR_NOMBREDLO_64247',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBUL_139527',
                element: []
            };
            $scope.vc.grids.QV_1129_31576.AT61_CUSTOMAN630 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1129_31576.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBUL_139527",
                        'data-validation-code': "{{vc.viewState.QV_1129_31576.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_ADDALERSTS_846527,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1129_31576.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1129_31576.column.commentary = {
                title: 'CSTMR.LBL_CSTMR_COMENTASO_77518',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHPJ_884527',
                element: []
            };
            $scope.vc.grids.QV_1129_31576.AT92_COMMENTA630 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1129_31576.column.commentary.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHPJ_884527",
                        'data-validation-code': "{{vc.viewState.QV_1129_31576.column.commentary.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_ADDALERSTS_846527,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1129_31576.column.commentary.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1129_31576.columns.push({
                    field: 'typeOperation',
                    title: '{{vc.viewState.QV_1129_31576.column.typeOperation.title|translate:vc.viewState.QV_1129_31576.column.typeOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_1129_31576.column.typeOperation.width,
                    format: $scope.vc.viewState.QV_1129_31576.column.typeOperation.format,
                    editor: $scope.vc.grids.QV_1129_31576.AT14_TYPEOPIO630.control,
                    template: "<span ng-class='vc.viewState.QV_1129_31576.column.typeOperation.style' ng-bind='vc.getStringColumnFormat(dataItem.typeOperation, \"QV_1129_31576\", \"typeOperation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1129_31576.column.typeOperation.style",
                        "title": "{{vc.viewState.QV_1129_31576.column.typeOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1129_31576.column.typeOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_1129_31576.columns.push({
                    field: 'code',
                    title: '{{vc.viewState.QV_1129_31576.column.code.title|translate:vc.viewState.QV_1129_31576.column.code.titleArgs}}',
                    width: $scope.vc.viewState.QV_1129_31576.column.code.width,
                    format: $scope.vc.viewState.QV_1129_31576.column.code.format,
                    editor: $scope.vc.grids.QV_1129_31576.AT79_CODIGOGJ630.control,
                    template: "<span ng-class='vc.viewState.QV_1129_31576.column.code.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.code, \"QV_1129_31576\", \"code\"):kendo.toString(#=code#, vc.viewState.QV_1129_31576.column.code.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1129_31576.column.code.style",
                        "title": "{{vc.viewState.QV_1129_31576.column.code.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1129_31576.column.code.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1129_31576.columns.push({
                    field: 'highDate',
                    title: '{{vc.viewState.QV_1129_31576.column.highDate.title|translate:vc.viewState.QV_1129_31576.column.highDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_1129_31576.column.highDate.width,
                    format: $scope.vc.viewState.QV_1129_31576.column.highDate.format,
                    editor: $scope.vc.grids.QV_1129_31576.AT72_HIGHDATE630.control,
                    template: "<span ng-class='vc.viewState.QV_1129_31576.column.highDate.style'>#=((highDate !== null) ? kendo.toString(highDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1129_31576.column.highDate.style",
                        "title": "{{vc.viewState.QV_1129_31576.column.highDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1129_31576.column.highDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1129_31576.columns.push({
                    field: 'reportDate',
                    title: '{{vc.viewState.QV_1129_31576.column.reportDate.title|translate:vc.viewState.QV_1129_31576.column.reportDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_1129_31576.column.reportDate.width,
                    format: $scope.vc.viewState.QV_1129_31576.column.reportDate.format,
                    editor: $scope.vc.grids.QV_1129_31576.AT99_REPORTDT630.control,
                    template: "<span ng-class='vc.viewState.QV_1129_31576.column.reportDate.style'>#=((reportDate !== null) ? kendo.toString(reportDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1129_31576.column.reportDate.style",
                        "title": "{{vc.viewState.QV_1129_31576.column.reportDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1129_31576.column.reportDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1129_31576.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_1129_31576.column.customerName.title|translate:vc.viewState.QV_1129_31576.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_1129_31576.column.customerName.width,
                    format: $scope.vc.viewState.QV_1129_31576.column.customerName.format,
                    editor: $scope.vc.grids.QV_1129_31576.AT61_CUSTOMAN630.control,
                    template: "<span ng-class='vc.viewState.QV_1129_31576.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_1129_31576\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1129_31576.column.customerName.style",
                        "title": "{{vc.viewState.QV_1129_31576.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1129_31576.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1129_31576.columns.push({
                    field: 'commentary',
                    title: '{{vc.viewState.QV_1129_31576.column.commentary.title|translate:vc.viewState.QV_1129_31576.column.commentary.titleArgs}}',
                    width: $scope.vc.viewState.QV_1129_31576.column.commentary.width,
                    format: $scope.vc.viewState.QV_1129_31576.column.commentary.format,
                    editor: $scope.vc.grids.QV_1129_31576.AT92_COMMENTA630.control,
                    template: "<span ng-class='vc.viewState.QV_1129_31576.column.commentary.style' ng-bind='vc.getStringColumnFormat(dataItem.commentary, \"QV_1129_31576\", \"commentary\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1129_31576.column.commentary.style",
                        "title": "{{vc.viewState.QV_1129_31576.column.commentary.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1129_31576.column.commentary.hidden
                });
            }
            $scope.vc.viewState.QV_1129_31576.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_1129_31576.column.cmdEdition = {};
            $scope.vc.viewState.QV_1129_31576.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_1129_31576.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_1129_31576.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_1129_31576.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDALERSTT_863527.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_1129_31576.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_1129_31576.toolbar = {}
            $scope.vc.grids.QV_1129_31576.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMRZIMDHJYH_829_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMRZIMDHJYH_829_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
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
                $scope.vc.render('VC_ADDALERTSS_984829');
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
    var cobisMainModule = cobis.createModule("VC_ADDALERTSS_984829", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_ADDALERTSS_984829", {
            templateUrl: "VC_ADDALERTSS_984829_FORM.html",
            controller: "VC_ADDALERTSS_984829_CTRL",
            labelId: "CSTMR.LBL_CSTMR_INSERTAAL_52833",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_ADDALERTSS_984829?" + $.param(search);
            }
        });
        VC_ADDALERTSS_984829(cobisMainModule);
    }]);
} else {
    VC_ADDALERTSS_984829(cobisMainModule);
}