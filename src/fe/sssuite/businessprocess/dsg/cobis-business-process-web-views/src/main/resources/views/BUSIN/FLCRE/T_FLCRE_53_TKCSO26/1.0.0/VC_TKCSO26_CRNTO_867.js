//Designer Generator v 6.1.1 - release SPR 2017-05_01 03/20/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskconsultdisbursementforms = designerEvents.api.taskconsultdisbursementforms || designer.dsgEvents();

function VC_TKCSO26_CRNTO_867(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TKCSO26_CRNTO_867_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TKCSO26_CRNTO_867_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_53_TKCSO26",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TKCSO26_CRNTO_867",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_53_TKCSO26",
        designerEvents.api.taskconsultdisbursementforms,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: true,
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
                vcName: 'VC_TKCSO26_CRNTO_867'
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
                    taskId: 'T_FLCRE_53_TKCSO26',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ConsultationDisbursementForms: "ConsultationDisbursementForms",
                    DisbursementForms: "DisbursementForms"
                },
                entities: {
                    ConsultationDisbursementForms: {
                        Description: 'AT_CUT286ECIN47',
                        AutomaticPayment: 'AT_CUT286OAME53',
                        Product: 'AT_CUT286PRCT67',
                        CobisProduct: 'AT_CUT286SRDT43',
                        Retention: 'AT_CUT286TENT50',
                        _pks: [],
                        _entityId: 'EN_CUTIUSMNT286',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    DisbursementForms: {
                        Observations: 'AT_DBR527BEIS98',
                        ContributionRate: 'AT_DBR527CNRE01',
                        Currency: 'AT_DBR527CRCY76',
                        Account: 'AT_DBR527CUNT68',
                        Amount: 'AT_DBR527MOUT62',
                        BeneficiaryId: 'AT_DBR527NEAD00',
                        Beneficiary: 'AT_DBR527NEAR05',
                        DisbursemenTrate: 'AT_DBR527SNTT15',
                        Quote: 'AT_DBR527UOTE58',
                        _pks: [],
                        _entityId: 'EN_DBRSMNFRM527',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_EULDBSTM_5756 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_EULDBSTM_5756 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_EULDBSTM_5756_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_EULDBSTM_5756_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CUTIUSMNT286',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_EULDBSTM_5756',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_EULDBSTM_5756_filters = {};
            var defaultValues = {
                ConsultationDisbursementForms: {},
                DisbursementForms: {}
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
                $scope.vc.execute("temporarySave", VC_TKCSO26_CRNTO_867, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_TKCSO26_CRNTO_867, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_TKCSO26_CRNTO_867, data, function() {});
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
            $scope.vc.viewState.VC_TKCSO26_CRNTO_867 = {
                style: []
            }
            //ViewState - Group: Contenedor Acordeón
            $scope.vc.createViewState({
                id: "GR_UTDSRMNSVW70_03",
                hasId: true,
                componentStyle: [],
                label: 'Contenedor Acorde\u00f3n',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_UTDSRMNSVW70_05",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_UTDSRMNSVW7005_0000031",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_NEXTWDPYJ_54101",
                label: "BUSIN.LBL_BUSIN_SIGUIENET_10260",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel de Acordeón para ConsultationDisbursementForms
            $scope.vc.createViewState({
                id: "GR_UTDSRMNSVW70_04",
                hasId: true,
                componentStyle: [],
                label: 'Panel de Acorde\u00f3n para ConsultationDisbursementForms',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ConsultationDisbursementForms = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Product: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConsultationDisbursementForms", "Product", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConsultationDisbursementForms", "Description", '')
                    },
                    Retention: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConsultationDisbursementForms", "Retention", 0)
                    },
                    CobisProduct: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConsultationDisbursementForms", "CobisProduct", 0)
                    },
                    AutomaticPayment: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConsultationDisbursementForms", "AutomaticPayment", '')
                    }
                }
            });
            $scope.vc.model.ConsultationDisbursementForms = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_EULDBSTM_5756';
                            var queryRequest = $scope.vc.getRequestQuery_Q_EULDBSTM_5756();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_EULDB5756_37',
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
                    model: $scope.vc.types.ConsultationDisbursementForms
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_EULDB5756_37").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EULDBSTM_5756 = $scope.vc.model.ConsultationDisbursementForms;
            $scope.vc.trackers.ConsultationDisbursementForms = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ConsultationDisbursementForms);
            $scope.vc.model.ConsultationDisbursementForms.bind('change', function(e) {
                $scope.vc.trackers.ConsultationDisbursementForms.track(e);
            });
            $scope.vc.grids.QV_EULDB5756_37 = {};
            $scope.vc.grids.QV_EULDB5756_37.queryId = 'Q_EULDBSTM_5756';
            $scope.vc.viewState.QV_EULDB5756_37 = {
                style: undefined
            };
            $scope.vc.viewState.QV_EULDB5756_37.column = {};
            $scope.vc.grids.QV_EULDB5756_37.editable = false;
            $scope.vc.grids.QV_EULDB5756_37.events = {
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
                    $scope.vc.trackers.ConsultationDisbursementForms.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_EULDB5756_37.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_EULDB5756_37");
                    $scope.vc.hideShowColumns("QV_EULDB5756_37", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_EULDB5756_37.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_EULDB5756_37.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_EULDB5756_37.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_EULDB5756_37 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_EULDB5756_37 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_EULDB5756_37.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_EULDB5756_37.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_EULDB5756_37.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "ConsultationDisbursementForms",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        $scope.vc.gridRowSelecting("QV_EULDB5756_37", args);
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
            $scope.vc.grids.QV_EULDB5756_37.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_EULDB5756_37.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_EULDB5756_37.column.Product = {
                title: 'BUSIN.DLB_BUSIN_PRODUCTOZ_18482',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_PRODUCTOZ_18482',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_UTDSRMNSVW7004_PRCT235',
                element: []
            };
            $scope.vc.grids.QV_EULDB5756_37.AT_CUT286PRCT67 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_EULDB5756_37.column.Product.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_PRODUCTOZ_18482'|translate}}",
                        'id': "VA_UTDSRMNSVW7004_PRCT235",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_EULDB5756_37.column.Product.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_UTDSRMNSVW70_03,1",
                        'ng-class': "vc.viewState.QV_EULDB5756_37.column.Product.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EULDB5756_37.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_UTDSRMNSVW7004_ECIN984',
                element: []
            };
            $scope.vc.grids.QV_EULDB5756_37.AT_CUT286ECIN47 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_EULDB5756_37.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_DESCRIPCI_06123'|translate}}",
                        'id': "VA_UTDSRMNSVW7004_ECIN984",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_EULDB5756_37.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_UTDSRMNSVW70_03,1",
                        'ng-class': "vc.viewState.QV_EULDB5756_37.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EULDB5756_37.column.Retention = {
                title: 'BUSIN.LBL_BUSIN_RETENCINN_48434',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_RETENCION_31353',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_UTDSRMNSVW7004_TENT928',
                element: []
            };
            $scope.vc.grids.QV_EULDB5756_37.AT_CUT286TENT50 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_EULDB5756_37.column.Retention.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_RETENCION_31353'|translate}}",
                        'id': "VA_UTDSRMNSVW7004_TENT928",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_EULDB5756_37.column.Retention.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_EULDB5756_37.column.Retention.format",
                        'k-decimals': "vc.viewState.QV_EULDB5756_37.column.Retention.decimals",
                        'data-cobis-group': "GroupLayout,GR_UTDSRMNSVW70_03,1",
                        'ng-class': "vc.viewState.QV_EULDB5756_37.column.Retention.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EULDB5756_37.column.CobisProduct = {
                title: 'BUSIN.DLB_BUSIN_PRODUCTBI_75086',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_PRODUCTBI_75086',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_UTDSRMNSVW7004_SRDT889',
                element: []
            };
            $scope.vc.grids.QV_EULDB5756_37.AT_CUT286SRDT43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_EULDB5756_37.column.CobisProduct.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_PRODUCTBI_75086'|translate}}",
                        'id': "VA_UTDSRMNSVW7004_SRDT889",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_EULDB5756_37.column.CobisProduct.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_EULDB5756_37.column.CobisProduct.format",
                        'k-decimals': "vc.viewState.QV_EULDB5756_37.column.CobisProduct.decimals",
                        'data-cobis-group': "GroupLayout,GR_UTDSRMNSVW70_03,1",
                        'ng-class': "vc.viewState.QV_EULDB5756_37.column.CobisProduct.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EULDB5756_37.column.AutomaticPayment = {
                title: 'BUSIN.LBL_BUSIN_PAGOAUTCI_86516',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_AGOAUTATO_57052',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_UTDSRMNSVW7004_OAME374',
                element: []
            };
            $scope.vc.grids.QV_EULDB5756_37.AT_CUT286OAME53 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_AGOAUTATO_57052'|translate}}",
                        'id': "VA_UTDSRMNSVW7004_OAME374",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_UTDSRMNSVW70_03,1",
                        'ng-class': "vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EULDB5756_37.columns.push({
                    field: 'Product',
                    title: '{{vc.viewState.QV_EULDB5756_37.column.Product.title|translate:vc.viewState.QV_EULDB5756_37.column.Product.titleArgs}}',
                    width: $scope.vc.viewState.QV_EULDB5756_37.column.Product.width,
                    format: $scope.vc.viewState.QV_EULDB5756_37.column.Product.format,
                    editor: $scope.vc.grids.QV_EULDB5756_37.AT_CUT286PRCT67.control,
                    template: "<span ng-class='vc.viewState.QV_EULDB5756_37.column.Product.element[dataItem.uid].style'>#if (Product !== null) {# #=Product# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EULDB5756_37.column.Product.style",
                        "title": "{{vc.viewState.QV_EULDB5756_37.column.Product.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EULDB5756_37.column.Product.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EULDB5756_37.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_EULDB5756_37.column.Description.title|translate:vc.viewState.QV_EULDB5756_37.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_EULDB5756_37.column.Description.width,
                    format: $scope.vc.viewState.QV_EULDB5756_37.column.Description.format,
                    editor: $scope.vc.grids.QV_EULDB5756_37.AT_CUT286ECIN47.control,
                    template: "<span ng-class='vc.viewState.QV_EULDB5756_37.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EULDB5756_37.column.Description.style",
                        "title": "{{vc.viewState.QV_EULDB5756_37.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EULDB5756_37.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EULDB5756_37.columns.push({
                    field: 'Retention',
                    title: '{{vc.viewState.QV_EULDB5756_37.column.Retention.title|translate:vc.viewState.QV_EULDB5756_37.column.Retention.titleArgs}}',
                    width: $scope.vc.viewState.QV_EULDB5756_37.column.Retention.width,
                    format: $scope.vc.viewState.QV_EULDB5756_37.column.Retention.format,
                    editor: $scope.vc.grids.QV_EULDB5756_37.AT_CUT286TENT50.control,
                    template: "<span ng-class='vc.viewState.QV_EULDB5756_37.column.Retention.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Retention, \"QV_EULDB5756_37\", \"Retention\"):kendo.toString(#=Retention#, vc.viewState.QV_EULDB5756_37.column.Retention.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_EULDB5756_37.column.Retention.style",
                        "title": "{{vc.viewState.QV_EULDB5756_37.column.Retention.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EULDB5756_37.column.Retention.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EULDB5756_37.columns.push({
                    field: 'CobisProduct',
                    title: '{{vc.viewState.QV_EULDB5756_37.column.CobisProduct.title|translate:vc.viewState.QV_EULDB5756_37.column.CobisProduct.titleArgs}}',
                    width: $scope.vc.viewState.QV_EULDB5756_37.column.CobisProduct.width,
                    format: $scope.vc.viewState.QV_EULDB5756_37.column.CobisProduct.format,
                    editor: $scope.vc.grids.QV_EULDB5756_37.AT_CUT286SRDT43.control,
                    template: "<span ng-class='vc.viewState.QV_EULDB5756_37.column.CobisProduct.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.CobisProduct, \"QV_EULDB5756_37\", \"CobisProduct\"):kendo.toString(#=CobisProduct#, vc.viewState.QV_EULDB5756_37.column.CobisProduct.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_EULDB5756_37.column.CobisProduct.style",
                        "title": "{{vc.viewState.QV_EULDB5756_37.column.CobisProduct.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EULDB5756_37.column.CobisProduct.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EULDB5756_37.columns.push({
                    field: 'AutomaticPayment',
                    title: '{{vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.title|translate:vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.width,
                    format: $scope.vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.format,
                    editor: $scope.vc.grids.QV_EULDB5756_37.AT_CUT286OAME53.control,
                    template: "<span ng-class='vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.element[dataItem.uid].style'>#if (AutomaticPayment !== null) {# #=AutomaticPayment# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.style",
                        "title": "{{vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EULDB5756_37.column.AutomaticPayment.hidden
                });
            }
            $scope.vc.viewState.QV_EULDB5756_37.toolbar = {}
            $scope.vc.grids.QV_EULDB5756_37.toolbar = [];
            $scope.vc.model.DisbursementForms = {
                Observations: $scope.vc.channelDefaultValues("DisbursementForms", "Observations"),
                ContributionRate: $scope.vc.channelDefaultValues("DisbursementForms", "ContributionRate"),
                Currency: $scope.vc.channelDefaultValues("DisbursementForms", "Currency"),
                Account: $scope.vc.channelDefaultValues("DisbursementForms", "Account"),
                Amount: $scope.vc.channelDefaultValues("DisbursementForms", "Amount"),
                BeneficiaryId: $scope.vc.channelDefaultValues("DisbursementForms", "BeneficiaryId"),
                Beneficiary: $scope.vc.channelDefaultValues("DisbursementForms", "Beneficiary"),
                DisbursemenTrate: $scope.vc.channelDefaultValues("DisbursementForms", "DisbursemenTrate"),
                Quote: $scope.vc.channelDefaultValues("DisbursementForms", "Quote")
            };
            //ViewState - Group: [Parametro para Formas]
            $scope.vc.createViewState({
                id: "GR_UTDSRMNSVW70_06",
                hasId: true,
                componentStyle: [],
                label: '[Parametro para Formas]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_UTDSRMNSVW70_06-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_53_TKCSO26_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_53_TKCSO26_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: ChooseButton
            $scope.vc.createViewState({
                id: "CM_TKCSO26COE67",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_CHOOSEPHQ_89411",
                label: "BUSIN.DLB_BUSIN_SELECIOAR_14656",
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
                $scope.vc.render('VC_TKCSO26_CRNTO_867');
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
    var cobisMainModule = cobis.createModule("VC_TKCSO26_CRNTO_867", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_TKCSO26_CRNTO_867", {
            templateUrl: "VC_TKCSO26_CRNTO_867_FORM.html",
            controller: "VC_TKCSO26_CRNTO_867_CTRL",
            labelId: "BUSIN.LBL_BUSIN_ASDEDESEO_21489",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TKCSO26_CRNTO_867?" + $.param(search);
            }
        });
        VC_TKCSO26_CRNTO_867(cobisMainModule);
    }]);
} else {
    VC_TKCSO26_CRNTO_867(cobisMainModule);
}