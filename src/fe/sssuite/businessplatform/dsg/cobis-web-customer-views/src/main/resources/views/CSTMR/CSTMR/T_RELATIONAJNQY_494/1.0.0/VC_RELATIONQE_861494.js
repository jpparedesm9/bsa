//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.relationform = designerEvents.api.relationform || designer.dsgEvents();

function VC_RELATIONQE_861494(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RELATIONQE_861494_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RELATIONQE_861494_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_RELATIONAJNQY_494",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RELATIONQE_861494",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_RELATIONAJNQY_494",
        designerEvents.api.relationform,
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
                vcName: 'VC_RELATIONQE_861494'
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
                    taskId: 'T_RELATIONAJNQY_494',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Entity2: "Entity2",
                    RelationPerson: "RelationPerson",
                    RelationContext: "RelationContext"
                },
                entities: {
                    Entity2: {
                        attribute1: 'AT02_1VJEZBOL806',
                        _pks: [],
                        _entityId: 'EN_2GIDTYAGL_806',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RelationPerson: {
                        secuentialPersonLeft: 'AT23_UBCXGLUZ414',
                        namePersonLeft: 'AT26_NAMEPEOS414',
                        namePersonRight: 'AT35_NAMEPEHT414',
                        nameRelation: 'AT64_NAMEREIO414',
                        secuentialPersonRight: 'AT80_SECUENLR414',
                        side: 'AT90_SIDEPBTC414',
                        relationId: 'AT95_RELATIII414',
                        _pks: [],
                        _entityId: 'EN_RELATIOSS_414',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RelationContext: {
                        secuential: 'AT60_SECUENII716',
                        relatioId: 'AT67_RELATIIO716',
                        _pks: [],
                        _entityId: 'EN_RELATIONC_716',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_RELATION_6114 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_RELATION_6114 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RELATION_6114_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_RELATION_6114_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RELATIOSS_414',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RELATION_6114',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_RELATION_6114_filters = {};
            var defaultValues = {
                Entity2: {},
                RelationPerson: {},
                RelationContext: {}
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
                $scope.vc.execute("temporarySave", VC_RELATIONQE_861494, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_RELATIONQE_861494, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_RELATIONQE_861494, data, function() {});
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
            $scope.vc.viewState.VC_RELATIONQE_861494 = {
                style: []
            }
            //ViewState - Group: Group1399
            $scope.vc.createViewState({
                id: "G_RELATIONNN_434954",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1399',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2466",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2568
            $scope.vc.createViewState({
                id: "G_RELATIONNN_730954",
                hasId: true,
                componentStyle: [],
                label: 'Group2568',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RelationPerson = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    namePersonRight: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RelationPerson", "namePersonRight", '')
                    },
                    relationId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RelationPerson", "relationId", ''),
                        validation: {
                            relationIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    secuentialPersonRight: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RelationPerson", "secuentialPersonRight", 0)
                    },
                    secuentialPersonLeft: {
                        type: "number",
                        editable: true
                    },
                    namePersonLeft: {
                        type: "string",
                        editable: true
                    },
                    nameRelation: {
                        type: "string",
                        editable: true
                    },
                    side: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.RelationPerson = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_RELATION_6114';
                            var queryRequest = $scope.vc.getRequestQuery_Q_RELATION_6114();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6114_93961',
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
                                            'allowPaging': false,
                                            'pageSize': 0
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RelationPerson',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_6114_93961', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RelationPerson',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_6114_93961', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.RelationPerson
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6114_93961").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RELATION_6114 = $scope.vc.model.RelationPerson;
            $scope.vc.trackers.RelationPerson = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RelationPerson);
            $scope.vc.model.RelationPerson.bind('change', function(e) {
                $scope.vc.trackers.RelationPerson.track(e);
            });
            $scope.vc.grids.QV_6114_93961 = {};
            $scope.vc.grids.QV_6114_93961.queryId = 'Q_RELATION_6114';
            $scope.vc.viewState.QV_6114_93961 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6114_93961.column = {};
            $scope.vc.grids.QV_6114_93961.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_6114_93961.events = {
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
                    $scope.vc.trackers.RelationPerson.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6114_93961.selectedRow = e.model;
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
                        nameEntityGrid: 'RelationPerson',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_6114_93961", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_6114_93961");
                    $scope.vc.hideShowColumns("QV_6114_93961", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6114_93961.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6114_93961.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6114_93961.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6114_93961 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6114_93961 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_6114_93961.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6114_93961.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6114_93961.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6114_93961.column.namePersonRight = {
                title: 'CSTMR.LBL_CSTMR_CLIENTEAG_28760',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJMD_724954',
                element: []
            };
            $scope.vc.grids.QV_6114_93961.AT35_NAMEPEHT414 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6114_93961.column.namePersonRight.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJMD_724954",
                        'type': "text",
                        'data-validation-code': "{{vc.viewState.QV_6114_93961.column.namePersonRight.validationCode}}",
                        'class': "form-control"
                    });
                    var button = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "!designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "false",
                        'ng-class': "vc.viewState.QV_6114_93961.column.namePersonRight.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-click': "vc.clickTextInputButtonGrid('VA_TEXTINPUTBOXJMD_724954',vc.grids.QV_6114_93961.selectedRow)"
                    });
                    var divRow = $('<div/>', {
                        'class': "input-group"
                    });
                    var innerDivRow = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var spanImage = $('<span />', {
                        'class': "glyphicon glyphicon-align-justify"
                    });
                    spanImage.appendTo(button);
                    button.appendTo(innerDivRow);
                    textInput.appendTo(divRow);
                    innerDivRow.appendTo(divRow)
                    divRow.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6114_93961.column.relationId = {
                title: 'CSTMR.LBL_CSTMR_RELACINNV_87930',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXCLW_566954',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXCLW_566954 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXCLW_566954', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXCLW_566954'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
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
            $scope.vc.grids.QV_6114_93961.AT95_RELATIII414 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6114_93961.column.relationId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCLW_566954",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_6114_93961.column.relationId.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXCLW_566954",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_6114_93961.column.relationId.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('CSTMR.LBL_CSTMR_RELACINNV_87930') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_6114_93961.column.relationId.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'dsgrequired': "",
                        'placeholder': "vc.getPlaceHolder()",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight = {
                title: 'secuentialPersonRight',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZRU_978954',
                element: []
            };
            $scope.vc.grids.QV_6114_93961.AT80_SECUENLR414 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6114_93961.column.secuentialPersonRight.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZRU_978954",
                        'data-validation-code': "{{vc.viewState.QV_6114_93961.column.secuentialPersonRight.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6114_93961.column.secuentialPersonRight.format",
                        'k-decimals': "vc.viewState.QV_6114_93961.column.secuentialPersonRight.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6114_93961.column.secuentialPersonRight.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6114_93961.column.secuentialPersonLeft = {
                title: 'secuentialPersonLeft',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_6114_93961.column.namePersonLeft = {
                title: 'namePersonLeft',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_6114_93961.column.nameRelation = {
                title: 'nameRelation',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_6114_93961.column.side = {
                title: 'side',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6114_93961.columns.push({
                    field: 'namePersonRight',
                    title: '{{vc.viewState.QV_6114_93961.column.namePersonRight.title|translate:vc.viewState.QV_6114_93961.column.namePersonRight.titleArgs}}',
                    width: $scope.vc.viewState.QV_6114_93961.column.namePersonRight.width,
                    format: $scope.vc.viewState.QV_6114_93961.column.namePersonRight.format,
                    editor: $scope.vc.grids.QV_6114_93961.AT35_NAMEPEHT414.control,
                    template: "<span ng-class='vc.viewState.QV_6114_93961.column.namePersonRight.style' ng-bind='vc.getStringColumnFormat(dataItem.namePersonRight, \"QV_6114_93961\", \"namePersonRight\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6114_93961.column.namePersonRight.style",
                        "title": "{{vc.viewState.QV_6114_93961.column.namePersonRight.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6114_93961.column.namePersonRight.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6114_93961.columns.push({
                    field: 'relationId',
                    title: '{{vc.viewState.QV_6114_93961.column.relationId.title|translate:vc.viewState.QV_6114_93961.column.relationId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6114_93961.column.relationId.width,
                    format: $scope.vc.viewState.QV_6114_93961.column.relationId.format,
                    editor: $scope.vc.grids.QV_6114_93961.AT95_RELATIII414.control,
                    template: "<span ng-class='vc.viewState.QV_6114_93961.column.relationId.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXCLW_566954.get(dataItem.relationId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6114_93961.column.relationId.style",
                        "title": "{{vc.viewState.QV_6114_93961.column.relationId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6114_93961.column.relationId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6114_93961.columns.push({
                    field: 'secuentialPersonRight',
                    title: '{{vc.viewState.QV_6114_93961.column.secuentialPersonRight.title|translate:vc.viewState.QV_6114_93961.column.secuentialPersonRight.titleArgs}}',
                    width: $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight.width,
                    format: $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight.format,
                    editor: $scope.vc.grids.QV_6114_93961.AT80_SECUENLR414.control,
                    template: "<span ng-class='vc.viewState.QV_6114_93961.column.secuentialPersonRight.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuentialPersonRight, \"QV_6114_93961\", \"secuentialPersonRight\"):kendo.toString(#=secuentialPersonRight#, vc.viewState.QV_6114_93961.column.secuentialPersonRight.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6114_93961.column.secuentialPersonRight.style",
                        "title": "{{vc.viewState.QV_6114_93961.column.secuentialPersonRight.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight.hidden
                });
            }
            $scope.vc.viewState.QV_6114_93961.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_6114_93961.column.cmdEdition = {};
            $scope.vc.viewState.QV_6114_93961.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_6114_93961.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_6114_93961.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_6114_93961.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_RELATIONNN_730954.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_6114_93961.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_6114_93961.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_6114_93961.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_6114_93961.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_RELATIONNN_730954.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            $scope.vc.model.Entity2 = {
                attribute1: $scope.vc.channelDefaultValues("Entity2", "attribute1")
            };
            //ViewState - Group: Group1128
            $scope.vc.createViewState({
                id: "G_RELATIONNN_320954",
                hasId: true,
                componentStyle: [],
                label: 'Group1128',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONAPPHYWK_615954",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_RELATIONAJNQY_494_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_RELATIONAJNQY_494_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.RelationContext = {
                secuential: $scope.vc.channelDefaultValues("RelationContext", "secuential"),
                relatioId: $scope.vc.channelDefaultValues("RelationContext", "relatioId")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXCLW_566954.read();
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
                $scope.vc.render('VC_RELATIONQE_861494');
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
    var cobisMainModule = cobis.createModule("VC_RELATIONQE_861494", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_RELATIONQE_861494", {
            templateUrl: "VC_RELATIONQE_861494_FORM.html",
            controller: "VC_RELATIONQE_861494_CTRL",
            labelId: "CSTMR.LBL_CSTMR_RELACINNL_90572",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RELATIONQE_861494?" + $.param(search);
            }
        });
        VC_RELATIONQE_861494(cobisMainModule);
    }]);
} else {
    VC_RELATIONQE_861494(cobisMainModule);
}