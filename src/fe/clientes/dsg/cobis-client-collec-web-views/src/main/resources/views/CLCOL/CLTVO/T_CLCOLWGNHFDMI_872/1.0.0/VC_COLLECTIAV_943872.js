//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.collectiveadvisorsroles = designerEvents.api.collectiveadvisorsroles || designer.dsgEvents();

function VC_COLLECTIAV_943872(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_COLLECTIAV_943872_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_COLLECTIAV_943872_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "CLCOL",
            subModuleId: "CLTVO",
            taskId: "T_CLCOLWGNHFDMI_872",
            taskVersion: "1.0.0",
            viewContainerId: "VC_COLLECTIAV_943872",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CLCOL/CLTVO/T_CLCOLWGNHFDMI_872",
        designerEvents.api.collectiveadvisorsroles,
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
                vcName: 'VC_COLLECTIAV_943872'
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
                    moduleId: 'CLCOL',
                    subModuleId: 'CLTVO',
                    taskId: 'T_CLCOLWGNHFDMI_872',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CollectiveRolList: "CollectiveRolList",
                    CollectiveRole: "CollectiveRole"
                },
                entities: {
                    CollectiveRolList: {
                        collectiveDescription: 'AT17_COLLECRD695',
                        officialID: 'AT34_OFFICIIA695',
                        idCollective: 'AT50_IDCOLLCT695',
                        roleDescription: 'AT64_ROLEDESS695',
                        officialName: 'AT97_OFFICINL695',
                        _pks: [],
                        _entityId: 'EN_COLLECTRE_695',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CollectiveRole: {
                        collective: 'AT21_COLLECVV340',
                        collectiveDescription: 'AT36_COLLECET340',
                        official: 'AT46_OFFICILA340',
                        roleDescription: 'AT68_ROLEDEPN340',
                        role: 'AT75_ROLEAVXA340',
                        _pks: [],
                        _entityId: 'EN_COLLECTLI_340',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_COLLECER_7238 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_COLLECER_7238 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_COLLECER_7238_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_COLLECER_7238_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_COLLECTRE_695',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_COLLECER_7238',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_COLLECER_7238_filters = {};
            var defaultValues = {
                CollectiveRolList: {},
                CollectiveRole: {}
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
                $scope.vc.execute("temporarySave", VC_COLLECTIAV_943872, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_COLLECTIAV_943872, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_COLLECTIAV_943872, data, function() {});
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
            $scope.vc.viewState.VC_COLLECTIAV_943872 = {
                style: []
            }
            $scope.vc.model.CollectiveRole = {
                collective: $scope.vc.channelDefaultValues("CollectiveRole", "collective"),
                collectiveDescription: $scope.vc.channelDefaultValues("CollectiveRole", "collectiveDescription"),
                official: $scope.vc.channelDefaultValues("CollectiveRole", "official"),
                roleDescription: $scope.vc.channelDefaultValues("CollectiveRole", "roleDescription"),
                role: $scope.vc.channelDefaultValues("CollectiveRole", "role")
            };
            //ViewState - Group: Group1826
            $scope.vc.createViewState({
                id: "G_COLLECTISR_920380",
                hasId: true,
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_ROLESWINY_46037",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CollectiveRole, Attribute: role
            $scope.vc.createViewState({
                id: "VA_ROLERJQVGOOROND_932380",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_ROLESWINY_46037",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ROLERJQVGOOROND_932380 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ROLERJQVGOOROND_932380', 'cl_rol_asesor_colectivo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ROLERJQVGOOROND_932380'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ROLERJQVGOOROND_932380");
                            $scope.vc.setReadOnlyInputCombobox("VA_ROLERJQVGOOROND_932380");
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
            //ViewState - Entity: CollectiveRole, Attribute: official
            $scope.vc.createViewState({
                id: "VA_OFFICIALYYQHLMI_968380",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_OFICIALBG_58997",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFFICIALYYQHLMI_968380 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OFFICIALYYQHLMI_968380', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OFFICIALYYQHLMI_968380'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'contains'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CollectiveRole, Attribute: collective
            $scope.vc.createViewState({
                id: "VA_COLLECTIVESPPQW_866380",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_COLECTIVO_28840",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COLLECTIVESPPQW_866380 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COLLECTIVESPPQW_866380', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COLLECTIVESPPQW_866380'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COLLECTIVESPPQW_866380");
                            $scope.vc.setReadOnlyInputCombobox("VA_COLLECTIVESPPQW_866380");
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
            //ViewState - Group: Group2975
            $scope.vc.createViewState({
                id: "G_COLLECTIAS_254380",
                hasId: true,
                componentStyle: [],
                label: 'Group2975',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2548",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONUCULYAE_906380",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_AGREGARIJ_46436",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2424",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2174
            $scope.vc.createViewState({
                id: "G_COLLECTIIE_967380",
                hasId: true,
                componentStyle: [],
                label: 'Group2174',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CollectiveRolList = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    idCollective: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveRolList", "idCollective", '')
                    },
                    collectiveDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveRolList", "collectiveDescription", '')
                    },
                    officialID: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveRolList", "officialID", '')
                    },
                    officialName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveRolList", "officialName", '')
                    },
                    roleDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveRolList", "roleDescription", '')
                    }
                }
            });
            $scope.vc.model.CollectiveRolList = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_COLLECER_7238';
                            var queryRequest = $scope.vc.getRequestQuery_Q_COLLECER_7238();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7238_33339',
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'CollectiveRolList',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7238_33339', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.CollectiveRolList
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7238_33339").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_COLLECER_7238 = $scope.vc.model.CollectiveRolList;
            $scope.vc.trackers.CollectiveRolList = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CollectiveRolList);
            $scope.vc.model.CollectiveRolList.bind('change', function(e) {
                $scope.vc.trackers.CollectiveRolList.track(e);
            });
            $scope.vc.grids.QV_7238_33339 = {};
            $scope.vc.grids.QV_7238_33339.queryId = 'Q_COLLECER_7238';
            $scope.vc.viewState.QV_7238_33339 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7238_33339.column = {};
            $scope.vc.grids.QV_7238_33339.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_7238_33339.events = {
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
                    $scope.vc.trackers.CollectiveRolList.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7238_33339.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_7238_33339");
                    $scope.vc.hideShowColumns("QV_7238_33339", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7238_33339.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7238_33339.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7238_33339.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7238_33339 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7238_33339 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7238_33339.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7238_33339.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7238_33339.column.idCollective = {
                title: 'idCollective',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUOL_581380',
                element: []
            };
            $scope.vc.grids.QV_7238_33339.AT50_IDCOLLCT695 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7238_33339.column.idCollective.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUOL_581380",
                        'data-validation-code': "{{vc.viewState.QV_7238_33339.column.idCollective.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7238_33339.column.idCollective.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7238_33339.column.collectiveDescription = {
                title: 'CLCOL.LBL_CLCOL_COLECTIVV_92246',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSPD_919380',
                element: []
            };
            $scope.vc.grids.QV_7238_33339.AT17_COLLECRD695 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7238_33339.column.collectiveDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSPD_919380",
                        'data-validation-code': "{{vc.viewState.QV_7238_33339.column.collectiveDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7238_33339.column.collectiveDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7238_33339.column.officialID = {
                title: 'CLCOL.LBL_CLCOL_IDOFICILA_14131',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFPI_660380',
                element: []
            };
            $scope.vc.grids.QV_7238_33339.AT34_OFFICIIA695 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7238_33339.column.officialID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFPI_660380",
                        'data-validation-code': "{{vc.viewState.QV_7238_33339.column.officialID.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7238_33339.column.officialID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7238_33339.column.officialName = {
                title: 'CLCOL.LBL_CLCOL_NOMBREOCC_55096',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCFY_764380',
                element: []
            };
            $scope.vc.grids.QV_7238_33339.AT97_OFFICINL695 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7238_33339.column.officialName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCFY_764380",
                        'data-validation-code': "{{vc.viewState.QV_7238_33339.column.officialName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7238_33339.column.officialName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7238_33339.column.roleDescription = {
                title: 'CLCOL.LBL_CLCOL_DESCRIPLO_80149',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDQL_440380',
                element: []
            };
            $scope.vc.grids.QV_7238_33339.AT64_ROLEDESS695 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7238_33339.column.roleDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDQL_440380",
                        'data-validation-code': "{{vc.viewState.QV_7238_33339.column.roleDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7238_33339.column.roleDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7238_33339.columns.push({
                    field: 'idCollective',
                    title: '{{vc.viewState.QV_7238_33339.column.idCollective.title|translate:vc.viewState.QV_7238_33339.column.idCollective.titleArgs}}',
                    width: $scope.vc.viewState.QV_7238_33339.column.idCollective.width,
                    format: $scope.vc.viewState.QV_7238_33339.column.idCollective.format,
                    editor: $scope.vc.grids.QV_7238_33339.AT50_IDCOLLCT695.control,
                    template: "<span ng-class='vc.viewState.QV_7238_33339.column.idCollective.style' ng-bind='vc.getStringColumnFormat(dataItem.idCollective, \"QV_7238_33339\", \"idCollective\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7238_33339.column.idCollective.style",
                        "title": "{{vc.viewState.QV_7238_33339.column.idCollective.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7238_33339.column.idCollective.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7238_33339.columns.push({
                    field: 'collectiveDescription',
                    title: '{{vc.viewState.QV_7238_33339.column.collectiveDescription.title|translate:vc.viewState.QV_7238_33339.column.collectiveDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_7238_33339.column.collectiveDescription.width,
                    format: $scope.vc.viewState.QV_7238_33339.column.collectiveDescription.format,
                    editor: $scope.vc.grids.QV_7238_33339.AT17_COLLECRD695.control,
                    template: "<span ng-class='vc.viewState.QV_7238_33339.column.collectiveDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.collectiveDescription, \"QV_7238_33339\", \"collectiveDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7238_33339.column.collectiveDescription.style",
                        "title": "{{vc.viewState.QV_7238_33339.column.collectiveDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7238_33339.column.collectiveDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7238_33339.columns.push({
                    field: 'officialID',
                    title: '{{vc.viewState.QV_7238_33339.column.officialID.title|translate:vc.viewState.QV_7238_33339.column.officialID.titleArgs}}',
                    width: $scope.vc.viewState.QV_7238_33339.column.officialID.width,
                    format: $scope.vc.viewState.QV_7238_33339.column.officialID.format,
                    editor: $scope.vc.grids.QV_7238_33339.AT34_OFFICIIA695.control,
                    template: "<span ng-class='vc.viewState.QV_7238_33339.column.officialID.style' ng-bind='vc.getStringColumnFormat(dataItem.officialID, \"QV_7238_33339\", \"officialID\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7238_33339.column.officialID.style",
                        "title": "{{vc.viewState.QV_7238_33339.column.officialID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7238_33339.column.officialID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7238_33339.columns.push({
                    field: 'officialName',
                    title: '{{vc.viewState.QV_7238_33339.column.officialName.title|translate:vc.viewState.QV_7238_33339.column.officialName.titleArgs}}',
                    width: $scope.vc.viewState.QV_7238_33339.column.officialName.width,
                    format: $scope.vc.viewState.QV_7238_33339.column.officialName.format,
                    editor: $scope.vc.grids.QV_7238_33339.AT97_OFFICINL695.control,
                    template: "<span ng-class='vc.viewState.QV_7238_33339.column.officialName.style' ng-bind='vc.getStringColumnFormat(dataItem.officialName, \"QV_7238_33339\", \"officialName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7238_33339.column.officialName.style",
                        "title": "{{vc.viewState.QV_7238_33339.column.officialName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7238_33339.column.officialName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7238_33339.columns.push({
                    field: 'roleDescription',
                    title: '{{vc.viewState.QV_7238_33339.column.roleDescription.title|translate:vc.viewState.QV_7238_33339.column.roleDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_7238_33339.column.roleDescription.width,
                    format: $scope.vc.viewState.QV_7238_33339.column.roleDescription.format,
                    editor: $scope.vc.grids.QV_7238_33339.AT64_ROLEDESS695.control,
                    template: "<span ng-class='vc.viewState.QV_7238_33339.column.roleDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.roleDescription, \"QV_7238_33339\", \"roleDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7238_33339.column.roleDescription.style",
                        "title": "{{vc.viewState.QV_7238_33339.column.roleDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7238_33339.column.roleDescription.hidden
                });
            }
            $scope.vc.viewState.QV_7238_33339.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_7238_33339.column.cmdEdition = {};
            $scope.vc.viewState.QV_7238_33339.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7238_33339.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_7238_33339.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7238_33339.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_COLLECTIIE_967380.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7238_33339.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_7238_33339.toolbar = {}
            $scope.vc.grids.QV_7238_33339.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CLCOLWGNHFDMI_872_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CLCOLWGNHFDMI_872_CANCEL",
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
                $scope.vc.render('VC_COLLECTIAV_943872');
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
    var cobisMainModule = cobis.createModule("VC_COLLECTIAV_943872", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CLCOL"]);
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
        $routeProvider.when("/VC_COLLECTIAV_943872", {
            templateUrl: "VC_COLLECTIAV_943872_FORM.html",
            controller: "VC_COLLECTIAV_943872_CTRL",
            labelId: "CLCOL.LBL_CLCOL_ASIGNACCE_15751",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CLCOL');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_COLLECTIAV_943872?" + $.param(search);
            }
        });
        VC_COLLECTIAV_943872(cobisMainModule);
    }]);
} else {
    VC_COLLECTIAV_943872(cobisMainModule);
}