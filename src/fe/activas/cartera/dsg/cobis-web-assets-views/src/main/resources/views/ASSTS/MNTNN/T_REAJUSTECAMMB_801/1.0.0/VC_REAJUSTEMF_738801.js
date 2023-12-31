//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.readjustmentloancabform = designerEvents.api.readjustmentloancabform || designer.dsgEvents();

function VC_REAJUSTEMF_738801(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REAJUSTEMF_738801_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REAJUSTEMF_738801_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_REAJUSTECAMMB_801",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REAJUSTEMF_738801",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_REAJUSTECAMMB_801",
        designerEvents.api.readjustmentloancabform,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: true,
                hasChangeInitDataSupport: true,
                hasSearchRenderEvent: false,
                ejecTemporaryData: false,
                ejecInitData: false,
                ejecChangeInitData: false,
                ejecSearchRenderEvent: false,
                hasTemporaryData: false,
                hasInitData: false,
                hasChangeInitData: false,
                hasCRUDSupport: false,
                vcName: 'VC_REAJUSTEMF_738801'
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
                    taskId: 'T_REAJUSTECAMMB_801',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Entity1: "Entity1",
                    ReadjustmentLoanCab: "ReadjustmentLoanCab",
                    LoanInstancia: "LoanInstancia"
                },
                entities: {
                    Entity1: {
                        Attribute2: 'AT03_2KPWBWBM241',
                        _pks: [],
                        _entityId: 'EN_1IRAKPKDY_241',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ReadjustmentLoanCab: {
                        date: 'AT21_FECHAOFI191',
                        mantCuota: 'AT57_MANTCUAT191',
                        secuencial: 'AT54_SECUENAC191',
                        desagio: 'AT28_TIPOQBOA191',
                        _pks: [],
                        _entityId: 'EN_REAJUSTBB_191',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanInstancia: {
                        idInstancia: 'AT74_IDINSTAA482',
                        idOptionMenu: 'AT59_IDOPTINM482',
                        errorValidation: 'AT62_ERRORVAA482',
                        _pks: [],
                        _entityId: 'EN_LOANINSTC_482',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_REAJUSBC_5831 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_REAJUSBC_5831 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_REAJUSBC_5831_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_REAJUSBC_5831_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_REAJUSTBB_191',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_REAJUSBC_5831',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_REAJUSBC_5831_filters = {};
            var defaultValues = {
                Entity1: {},
                ReadjustmentLoanCab: {},
                LoanInstancia: {}
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
                $scope.vc.execute("temporarySave", VC_REAJUSTEMF_738801, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REAJUSTEMF_738801, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REAJUSTEMF_738801, data, function() {});
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
            $scope.vc.viewState.VC_REAJUSTEMF_738801 = {
                style: []
            }
            $scope.vc.model.Entity1 = {
                Attribute2: $scope.vc.channelDefaultValues("Entity1", "Attribute2")
            };
            //ViewState - Group: Group1785
            $scope.vc.createViewState({
                id: "G_REAJUSTCBF_678319",
                hasId: true,
                componentStyle: [],
                label: 'Group1785',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_902319",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REAJUSTEE_43024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2220",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2653",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONERNAJQR_704319",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group2576
            $scope.vc.createViewState({
                id: "G_REAJUSTMEC_674319",
                hasId: true,
                componentStyle: [],
                label: 'Group2576',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ReadjustmentLoanCab = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "date", new Date()),
                        validation: {
                            dateRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    mantCuota: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "mantCuota", ''),
                        validation: {
                            mantCuotaRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    secuencial: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "secuencial", 0)
                    },
                    desagio: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "desagio", '')
                    }
                }
            });
            $scope.vc.model.ReadjustmentLoanCab = new kendo.data.DataSource({
                pageSize: 5,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_REAJUSBC_5831();
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ReadjustmentLoanCab',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5831_17646', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    destroy: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ReadjustmentLoanCab',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5831_17646', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.ReadjustmentLoanCab
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5831_17646").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_REAJUSBC_5831 = $scope.vc.model.ReadjustmentLoanCab;
            $scope.vc.trackers.ReadjustmentLoanCab = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ReadjustmentLoanCab);
            $scope.vc.model.ReadjustmentLoanCab.bind('change', function(e) {
                $scope.vc.trackers.ReadjustmentLoanCab.track(e);
                $scope.vc.grids.QV_5831_17646.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_5831_17646 = {};
            $scope.vc.grids.QV_5831_17646.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_5831_17646) && expandedRowUidActual !== expandedRowUid_QV_5831_17646) {
                    var gridWidget = $('#QV_5831_17646').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_5831_17646 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_5831_17646 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_5831_17646 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_5831_17646);
                }
                expandedRowUid_QV_5831_17646 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_5831_17646', args);
                if (angular.isDefined($scope.vc.grids.QV_5831_17646.view)) {
                    $scope.vc.grids.QV_5831_17646.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_5831_17646.customView)) {
                    $scope.vc.grids.QV_5831_17646.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_5831_17646'/>"
            };
            $scope.vc.grids.QV_5831_17646.queryId = 'Q_REAJUSBC_5831';
            $scope.vc.viewState.QV_5831_17646 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5831_17646.column = {};
            var expandedRowUid_QV_5831_17646;
            $scope.vc.grids.QV_5831_17646.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_5831_17646.events = {
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
                    $scope.vc.trackers.ReadjustmentLoanCab.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_5831_17646.selectedRow = e.model;
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
                    $scope.vc.grids.QV_5831_17646.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    $scope.vc.validateForm();
                },
                evalVisibilityOfGridRowDetailIcon: function(dataSource) {
                    var dataView = dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        var args = {
                            nameEntityGrid: "ReadjustmentLoanCab",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_5831_17646", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_5831_17646", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_5831_17646");
                    $scope.vc.hideShowColumns("QV_5831_17646", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5831_17646.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5831_17646.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5831_17646.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5831_17646 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5831_17646 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_5831_17646.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_5831_17646 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_5831_17646.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5831_17646.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5831_17646.column.date = {
                title: 'ASSTS.LBL_ASSTS_FECHAQWBP_23514',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXCKZ_136319',
                element: []
            };
            $scope.vc.grids.QV_5831_17646.AT21_FECHAOFI191 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5831_17646.column.date.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCKZ_136319",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_FECHAQWBP_23514') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_5831_17646.column.date.validationCode}}",
                        'required': "true",
                        'ng-class': "vc.viewState.QV_5831_17646.column.date.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5831_17646.column.mantCuota = {
                title: 'ASSTS.LBL_ASSTS_MANTCUOTT_96843',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXQCR_748319',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXQCR_748319 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXQCR_748319',
                            'ca_reajuste_especial',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQCR_748319'];
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
            $scope.vc.grids.QV_5831_17646.AT57_MANTCUAT191 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5831_17646.column.mantCuota.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQCR_748319",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_5831_17646.column.mantCuota.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXQCR_748319",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_5831_17646.column.mantCuota.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_MANTCUOTT_96843') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_5831_17646.column.mantCuota.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'dsgrequired': "",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5831_17646.column.secuencial = {
                title: 'ASSTS.LBL_ASSTS_SECUENCAA_14570',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKUR_906319',
                element: []
            };
            $scope.vc.grids.QV_5831_17646.AT54_SECUENAC191 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5831_17646.column.secuencial.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKUR_906319",
                        'data-validation-code': "{{vc.viewState.QV_5831_17646.column.secuencial.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5831_17646.column.secuencial.format",
                        'k-decimals': "vc.viewState.QV_5831_17646.column.secuencial.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5831_17646.column.secuencial.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5831_17646.column.desagio = {
                title: 'ASSTS.LBL_ASSTS_TIPOLDSKB_46090',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPIL_163319',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXPIL_163319 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXPIL_163319',
                            'ca_desagio',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXPIL_163319'];
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
            $scope.vc.grids.QV_5831_17646.AT28_TIPOQBOA191 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5831_17646.column.desagio.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPIL_163319",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_5831_17646.column.desagio.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXPIL_163319",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_5831_17646.column.desagio.template",
                        'data-validation-code': "{{vc.viewState.QV_5831_17646.column.desagio.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5831_17646.columns.push({
                    field: 'date',
                    title: '{{vc.viewState.QV_5831_17646.column.date.title|translate:vc.viewState.QV_5831_17646.column.date.titleArgs}}',
                    width: $scope.vc.viewState.QV_5831_17646.column.date.width,
                    format: $scope.vc.viewState.QV_5831_17646.column.date.format,
                    editor: $scope.vc.grids.QV_5831_17646.AT21_FECHAOFI191.control,
                    template: "<span ng-class='vc.viewState.QV_5831_17646.column.date.style'>#=((date !== null) ? kendo.toString(date, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5831_17646.column.date.style",
                        "title": "{{vc.viewState.QV_5831_17646.column.date.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5831_17646.column.date.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5831_17646.columns.push({
                    field: 'mantCuota',
                    title: '{{vc.viewState.QV_5831_17646.column.mantCuota.title|translate:vc.viewState.QV_5831_17646.column.mantCuota.titleArgs}}',
                    width: $scope.vc.viewState.QV_5831_17646.column.mantCuota.width,
                    format: $scope.vc.viewState.QV_5831_17646.column.mantCuota.format,
                    editor: $scope.vc.grids.QV_5831_17646.AT57_MANTCUAT191.control,
                    template: "<span ng-class='vc.viewState.QV_5831_17646.column.mantCuota.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXQCR_748319.get(dataItem.mantCuota).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5831_17646.column.mantCuota.style",
                        "title": "{{vc.viewState.QV_5831_17646.column.mantCuota.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5831_17646.column.mantCuota.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5831_17646.columns.push({
                    field: 'secuencial',
                    title: '{{vc.viewState.QV_5831_17646.column.secuencial.title|translate:vc.viewState.QV_5831_17646.column.secuencial.titleArgs}}',
                    width: $scope.vc.viewState.QV_5831_17646.column.secuencial.width,
                    format: $scope.vc.viewState.QV_5831_17646.column.secuencial.format,
                    editor: $scope.vc.grids.QV_5831_17646.AT54_SECUENAC191.control,
                    template: "<span ng-class='vc.viewState.QV_5831_17646.column.secuencial.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuencial, \"QV_5831_17646\", \"secuencial\"):kendo.toString(#=secuencial#, vc.viewState.QV_5831_17646.column.secuencial.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5831_17646.column.secuencial.style",
                        "title": "{{vc.viewState.QV_5831_17646.column.secuencial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5831_17646.column.secuencial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5831_17646.columns.push({
                    field: 'desagio',
                    title: '{{vc.viewState.QV_5831_17646.column.desagio.title|translate:vc.viewState.QV_5831_17646.column.desagio.titleArgs}}',
                    width: $scope.vc.viewState.QV_5831_17646.column.desagio.width,
                    format: $scope.vc.viewState.QV_5831_17646.column.desagio.format,
                    editor: $scope.vc.grids.QV_5831_17646.AT28_TIPOQBOA191.control,
                    template: "<span ng-class='vc.viewState.QV_5831_17646.column.desagio.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXPIL_163319.get(dataItem.desagio).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5831_17646.column.desagio.style",
                        "title": "{{vc.viewState.QV_5831_17646.column.desagio.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5831_17646.column.desagio.hidden
                });
            }
            $scope.vc.viewState.QV_5831_17646.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_5831_17646.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_5831_17646.column.cmdEdition = {};
            $scope.vc.viewState.QV_5831_17646.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_5831_17646.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_5831_17646.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5831_17646.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_REAJUSTMEC_674319.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_5831_17646.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5831_17646.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_REAJUSTMEC_674319.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_5831_17646.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_5831_17646.toolbar = {}
            $scope.vc.grids.QV_5831_17646.toolbar = [];
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
            };
            //ViewState - Group: Group1705
            $scope.vc.createViewState({
                id: "G_READJUSBAT_800319",
                hasId: true,
                componentStyle: [],
                label: 'Group1705',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1922",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_REAJUSTECAMMB_801_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_REAJUSTECAMMB_801_CANCEL",
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
                    $scope.vc.catalogs.VA_TEXTINPUTBOXQCR_748319.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXPIL_163319.read();
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
                $scope.vc.render('VC_REAJUSTEMF_738801');
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
    var cobisMainModule = cobis.createModule("VC_REAJUSTEMF_738801", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_REAJUSTEMF_738801", {
            templateUrl: "VC_REAJUSTEMF_738801_FORM.html",
            controller: "VC_REAJUSTEMF_738801_CTRL",
            label: "ReadjustmentLoanCabForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REAJUSTEMF_738801?" + $.param(search);
            }
        });
        VC_REAJUSTEMF_738801(cobisMainModule);
    }]);
} else {
    VC_REAJUSTEMF_738801(cobisMainModule);
}