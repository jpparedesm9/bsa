//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.paymentMaintenance = designerEvents.api.paymentMaintenance || designer.dsgEvents();

function VC_PAYMENTMNE_706586(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PAYMENTMNE_706586_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PAYMENTMNE_706586_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_PAYMENTMAIETA_586",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PAYMENTMNE_706586",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_PAYMENTMAIETA_586",
        designerEvents.api.paymentMaintenance,
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
                vcName: 'VC_PAYMENTMNE_706586'
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
                    taskId: 'T_PAYMENTMAIETA_586',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    MethodsRetention: "MethodsRetention"
                },
                entities: {
                    MethodsRetention: {
                        product: 'AT44_PRODUCTT271',
                        description: 'AT87_DESCRIPO271',
                        category: 'AT56_CATEGORR271',
                        disbursement: 'AT94_DISBURSS271',
                        payment: 'AT57_PAYMENTT271',
                        retentiondays: 'AT30_RETENTNN271',
                        valueCode: 'AT27_VALUECEO271',
                        paymentAut: 'AT13_PAYMENTU271',
                        currencyRetention: 'AT63_CURRENNN271',
                        paymentATX: 'AT65_PAYMENTX271',
                        descCurrency: 'AT43_DESCCUYN271',
                        pcobis: 'AT94_PCOBISAE271',
                        descCOBIS: 'AT71_DESCCOIB271',
                        reversePro: 'AT44_REVERSRR271',
                        affectation: 'AT99_AFFECTAA271',
                        activePassive: 'AT93_ACTIVEIP271',
                        state: 'AT95_STATELNK271',
                        bankInstrument: 'AT55_BANKINNT271',
                        descripBank: 'AT65_DESCRIAP271',
                        canal: 'AT40_CANALFYR271',
                        descriptionCanal: 'AT13_DESCRINL271',
                        bankServices: 'AT57_BANKSECR271',
                        paymentMethods: 'AT88_PAYMENSE271',
                        transacction: 'AT28_TRANSACO271',
                        codeCategory: 'AT56_CODECATY271',
                        descriptionCategory: 'AT75_DESCRIGI271',
                        _pks: [],
                        _entityId: 'EN_METHODSRT_271',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_METHODIR_7546 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_METHODIR_7546 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_METHODIR_7546_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_METHODIR_7546_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_METHODSRT_271',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_METHODIR_7546',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_METHODIR_7546_filters = {};
            var defaultValues = {
                MethodsRetention: {}
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
                $scope.vc.execute("temporarySave", VC_PAYMENTMNE_706586, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_PAYMENTMNE_706586, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_PAYMENTMNE_706586, data, function() {});
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
            $scope.vc.viewState.VC_PAYMENTMNE_706586 = {
                style: []
            }
            //ViewState - Group: Group1844
            $scope.vc.createViewState({
                id: "G_PAYMENTNEA_454448",
                hasId: true,
                componentStyle: [],
                label: 'Group1844',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.MethodsRetention = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    product: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MethodsRetention", "product", '')
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MethodsRetention", "description", '')
                    }
                }
            });
            $scope.vc.model.MethodsRetention = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_METHODIR_7546';
                            var queryRequest = $scope.vc.getRequestQuery_Q_METHODIR_7546();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7546_25470',
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
                            nameEntityGrid: 'MethodsRetention',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7546_25470', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.MethodsRetention
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7546_25470").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_METHODIR_7546 = $scope.vc.model.MethodsRetention;
            $scope.vc.trackers.MethodsRetention = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.MethodsRetention);
            $scope.vc.model.MethodsRetention.bind('change', function(e) {
                $scope.vc.trackers.MethodsRetention.track(e);
            });
            $scope.vc.grids.QV_7546_25470 = {};
            $scope.vc.grids.QV_7546_25470.queryId = 'Q_METHODIR_7546';
            $scope.vc.viewState.QV_7546_25470 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7546_25470.column = {};
            $scope.vc.grids.QV_7546_25470.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_7546_25470.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.MethodsRetention(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_PAYMENTMAIDLT_828",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_PAYMENTMDA_338828',
                        title: ''
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7546_25470", dialogParameters);
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
                        taskId: "T_PAYMENTMAIDLT_828",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_PAYMENTMDA_338828',
                        title: ''
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7546_25470", dialogParameters);
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
                    $scope.vc.gridDataBound("QV_7546_25470");
                    $scope.vc.hideShowColumns("QV_7546_25470", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7546_25470.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7546_25470.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7546_25470.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7546_25470 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7546_25470 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7546_25470.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7546_25470.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7546_25470.column.product = {
                title: 'ASSTS.LBL_ASSTS_IDENTIFRD_90451',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPMD_289448',
                element: []
            };
            $scope.vc.viewState.QV_7546_25470.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPNI_65857',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWRT_921448',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7546_25470.columns.push({
                    field: 'product',
                    title: '{{vc.viewState.QV_7546_25470.column.product.title|translate:vc.viewState.QV_7546_25470.column.product.titleArgs}}',
                    width: $scope.vc.viewState.QV_7546_25470.column.product.width,
                    format: $scope.vc.viewState.QV_7546_25470.column.product.format,
                    template: "<span ng-class='vc.viewState.QV_7546_25470.column.product.style' ng-bind='vc.getStringColumnFormat(dataItem.product, \"QV_7546_25470\", \"product\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7546_25470.column.product.style",
                        "title": "{{vc.viewState.QV_7546_25470.column.product.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7546_25470.column.product.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7546_25470.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7546_25470.column.description.title|translate:vc.viewState.QV_7546_25470.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7546_25470.column.description.width,
                    format: $scope.vc.viewState.QV_7546_25470.column.description.format,
                    template: "<span ng-class='vc.viewState.QV_7546_25470.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7546_25470\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7546_25470.column.description.style",
                        "title": "{{vc.viewState.QV_7546_25470.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7546_25470.column.description.hidden
                });
            }
            $scope.vc.viewState.QV_7546_25470.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7546_25470.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_7546_25470.column.cmdEdition = {};
            $scope.vc.viewState.QV_7546_25470.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7546_25470.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "MethodsRetention",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_7546_25470.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7546_25470.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_PAYMENTNEA_454448.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_7546_25470.events.customEdit($event, \"#:entity#\", grids.QV_7546_25470)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_7546_25470.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7546_25470.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_PAYMENTNEA_454448.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7546_25470.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_7546_25470.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_7546_25470.toolbar = [{
                "name": "create",
                "entity": "MethodsRetention",
                "text": "",
                "template": "<button id = 'QV_7546_25470_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_7546_25470.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_PAYMENTNEA_454448.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_7546_25470.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PAYMENTMAIETA_586_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PAYMENTMAIETA_586_CANCEL",
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
                $scope.vc.render('VC_PAYMENTMNE_706586');
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
    var cobisMainModule = cobis.createModule("VC_PAYMENTMNE_706586", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_PAYMENTMNE_706586", {
            templateUrl: "VC_PAYMENTMNE_706586_FORM.html",
            controller: "VC_PAYMENTMNE_706586_CTRL",
            label: "Payment maintenance",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PAYMENTMNE_706586?" + $.param(search);
            }
        });
        VC_PAYMENTMNE_706586(cobisMainModule);
    }]);
} else {
    VC_PAYMENTMNE_706586(cobisMainModule);
}