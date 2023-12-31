//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.fregularizarpagosobjetados = designerEvents.api.fregularizarpagosobjetados || designer.dsgEvents();

function VC_FREGULARPJ_493168(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_FREGULARPJ_493168_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_FREGULARPJ_493168_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "PAOBJ",
            subModuleId: "PAOBJ",
            taskId: "T_PAOBJXPZXAKUO_168",
            taskVersion: "1.0.0",
            viewContainerId: "VC_FREGULARPJ_493168",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/PAOBJ/PAOBJ/T_PAOBJXPZXAKUO_168",
        designerEvents.api.fregularizarpagosobjetados,
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
                vcName: 'VC_FREGULARPJ_493168'
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
                    moduleId: 'PAOBJ',
                    subModuleId: 'PAOBJ',
                    taskId: 'T_PAOBJXPZXAKUO_168',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    DatosBusquedaPagoObjetado: "DatosBusquedaPagoObjetado",
                    DatosRegularizarPagos: "DatosRegularizarPagos",
                    ResultadoPagosObjetados: "ResultadoPagosObjetados"
                },
                entities: {
                    DatosBusquedaPagoObjetado: {
                        esGrupo: 'AT49_ESGRUPOO272',
                        criterioBusqueda: 'AT67_CRITERUI272',
                        _pks: [],
                        _entityId: 'EN_DATOSBUES_272',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DatosRegularizarPagos: {
                        formaPago: 'AT02_1DTDHUOC965',
                        _pks: [],
                        _entityId: 'EN_1EKQDWBQZ_965',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ResultadoPagosObjetados: {
                        idPago: 'AT15_IDPAGOWZ237',
                        seleccionar: 'AT28_REGULAIA237',
                        idPrestamo: 'AT31_IDPRESOM237',
                        sec: 'AT31_SECFEIEO237',
                        fecha: 'AT48_FECHAVXZ237',
                        tipoPrestamo: 'AT59_TIPOPRSS237',
                        montoPagado: 'AT83_MONTOPAA237',
                        _pks: [],
                        _entityId: 'EN_RESULTAED_237',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_RESULTTO_3724 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_RESULTTO_3724 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RESULTTO_3724_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_RESULTTO_3724_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RESULTAED_237',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RESULTTO_3724',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_RESULTTO_3724_filters = {};
            var defaultValues = {
                DatosBusquedaPagoObjetado: {},
                DatosRegularizarPagos: {},
                ResultadoPagosObjetados: {}
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
                $scope.vc.execute("temporarySave", VC_FREGULARPJ_493168, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_FREGULARPJ_493168, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_FREGULARPJ_493168, data, function() {});
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
            $scope.vc.viewState.VC_FREGULARPJ_493168 = {
                style: []
            }
            //ViewState - Group: GroupLayout2538
            $scope.vc.createViewState({
                id: "G_FREGULAARS_940505",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2538',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.DatosBusquedaPagoObjetado = {
                esGrupo: $scope.vc.channelDefaultValues("DatosBusquedaPagoObjetado", "esGrupo"),
                criterioBusqueda: $scope.vc.channelDefaultValues("DatosBusquedaPagoObjetado", "criterioBusqueda")
            };
            //ViewState - Group: Group2566
            $scope.vc.createViewState({
                id: "G_FREGULAERB_626505",
                hasId: true,
                componentStyle: [],
                label: "PAOBJ.LBL_PAOBJ_CRITERIOU_81978",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DatosBusquedaPagoObjetado, Attribute: criterioBusqueda
            $scope.vc.createViewState({
                id: "VA_1WFWHEAZGTYHGIU_390505",
                componentStyle: [],
                label: "PAOBJ.LBL_PAOBJ_CDIGOCLEI_32810",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONLJHGJNV_588505",
                componentStyle: [],
                label: "PAOBJ.LBL_PAOBJ_BUSCARHEQ_35645",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2478
            $scope.vc.createViewState({
                id: "G_FREGULASRO_315505",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2478',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2601
            $scope.vc.createViewState({
                id: "G_FREGULAEIZ_410505",
                hasId: true,
                componentStyle: [],
                label: "PAOBJ.LBL_PAOBJ_PAGOSOBJS_99434",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ResultadoPagosObjetados = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    sec: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultadoPagosObjetados", "sec", 0)
                    },
                    idPago: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultadoPagosObjetados", "idPago", '')
                    },
                    tipoPrestamo: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultadoPagosObjetados", "tipoPrestamo", '')
                    },
                    montoPagado: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultadoPagosObjetados", "montoPagado", 0)
                    },
                    fecha: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultadoPagosObjetados", "fecha", '')
                    },
                    idPrestamo: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultadoPagosObjetados", "idPrestamo", '')
                    },
                    seleccionar: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultadoPagosObjetados", "seleccionar", false)
                    }
                }
            });
            $scope.vc.model.ResultadoPagosObjetados = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_RESULTTO_3724';
                            var queryRequest = $scope.vc.getRequestQuery_Q_RESULTTO_3724();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3724_71065',
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
                    model: $scope.vc.types.ResultadoPagosObjetados
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3724_71065").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RESULTTO_3724 = $scope.vc.model.ResultadoPagosObjetados;
            $scope.vc.trackers.ResultadoPagosObjetados = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ResultadoPagosObjetados);
            $scope.vc.model.ResultadoPagosObjetados.bind('change', function(e) {
                $scope.vc.trackers.ResultadoPagosObjetados.track(e);
            });
            $scope.vc.grids.QV_3724_71065 = {};
            $scope.vc.grids.QV_3724_71065.queryId = 'Q_RESULTTO_3724';
            $scope.vc.viewState.QV_3724_71065 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3724_71065.column = {};
            $scope.vc.grids.QV_3724_71065.editable = false;
            $scope.vc.grids.QV_3724_71065.events = {
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
                    $scope.vc.trackers.ResultadoPagosObjetados.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3724_71065.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_3724_71065");
                    $scope.vc.hideShowColumns("QV_3724_71065", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3724_71065.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3724_71065.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3724_71065.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3724_71065 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3724_71065 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_3724_71065.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_3724_71065.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "ResultadoPagosObjetados", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3724_71065.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3724_71065.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3724_71065.column.sec = {
                title: 'sec',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYYN_778505',
                element: []
            };
            $scope.vc.grids.QV_3724_71065.AT31_SECFEIEO237 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3724_71065.column.sec.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYYN_778505",
                        'data-validation-code': "{{vc.viewState.QV_3724_71065.column.sec.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3724_71065.column.sec.format",
                        'k-decimals': "vc.viewState.QV_3724_71065.column.sec.decimals",
                        'data-cobis-group': "GroupLayout,G_FREGULASRO_315505,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3724_71065.column.sec.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3724_71065.column.idPago = {
                title: 'PAOBJ.LBL_PAOBJ_IDDELPAGO_14794',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXISA_255505',
                element: []
            };
            $scope.vc.grids.QV_3724_71065.AT15_IDPAGOWZ237 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_3724_71065.column.idPago.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3724_71065.column.tipoPrestamo = {
                title: 'PAOBJ.LBL_PAOBJ_TIPOPRSAM_29316',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBHO_178505',
                element: []
            };
            $scope.vc.grids.QV_3724_71065.AT59_TIPOPRSS237 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_3724_71065.column.tipoPrestamo.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3724_71065.column.montoPagado = {
                title: 'PAOBJ.LBL_PAOBJ_MONTODEII_20429',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKRJ_465505',
                element: []
            };
            $scope.vc.grids.QV_3724_71065.AT83_MONTOPAA237 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_3724_71065.column.montoPagado.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3724_71065.column.fecha = {
                title: 'PAOBJ.LBL_PAOBJ_FECHAVALO_46276',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLOS_534505',
                element: []
            };
            $scope.vc.grids.QV_3724_71065.AT48_FECHAVXZ237 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_3724_71065.column.fecha.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3724_71065.column.idPrestamo = {
                title: 'PAOBJ.LBL_PAOBJ_IDDELPRMO_41183',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNHC_589505',
                element: []
            };
            $scope.vc.grids.QV_3724_71065.AT31_IDPRESOM237 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_3724_71065.column.idPrestamo.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3724_71065.column.seleccionar = {
                title: 'seleccionar',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXSAGRGOQ_593505',
                element: []
            };
            $scope.vc.grids.QV_3724_71065.AT28_REGULAIA237 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3724_71065.column.seleccionar.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CHECKBOXSAGRGOQ_593505",
                        'ng-class': 'vc.viewState.QV_3724_71065.column.seleccionar.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_3724_71065.columns.push({
                    field: 'sec',
                    title: '{{vc.viewState.QV_3724_71065.column.sec.title|translate:vc.viewState.QV_3724_71065.column.sec.titleArgs}}',
                    width: $scope.vc.viewState.QV_3724_71065.column.sec.width,
                    format: $scope.vc.viewState.QV_3724_71065.column.sec.format,
                    editor: $scope.vc.grids.QV_3724_71065.AT31_SECFEIEO237.control,
                    template: "<span ng-class='vc.viewState.QV_3724_71065.column.sec.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sec, \"QV_3724_71065\", \"sec\"):kendo.toString(#=sec#, vc.viewState.QV_3724_71065.column.sec.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3724_71065.column.sec.style",
                        "title": "{{vc.viewState.QV_3724_71065.column.sec.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3724_71065.column.sec.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3724_71065.columns.push({
                    field: 'idPago',
                    title: '{{vc.viewState.QV_3724_71065.column.idPago.title|translate:vc.viewState.QV_3724_71065.column.idPago.titleArgs}}',
                    width: $scope.vc.viewState.QV_3724_71065.column.idPago.width,
                    format: $scope.vc.viewState.QV_3724_71065.column.idPago.format,
                    editor: $scope.vc.grids.QV_3724_71065.AT15_IDPAGOWZ237.control,
                    template: "<span ng-class='vc.viewState.QV_3724_71065.column.idPago.style' ng-bind='vc.getStringColumnFormat(dataItem.idPago, \"QV_3724_71065\", \"idPago\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3724_71065.column.idPago.style",
                        "title": "{{vc.viewState.QV_3724_71065.column.idPago.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3724_71065.column.idPago.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3724_71065.columns.push({
                    field: 'tipoPrestamo',
                    title: '{{vc.viewState.QV_3724_71065.column.tipoPrestamo.title|translate:vc.viewState.QV_3724_71065.column.tipoPrestamo.titleArgs}}',
                    width: $scope.vc.viewState.QV_3724_71065.column.tipoPrestamo.width,
                    format: $scope.vc.viewState.QV_3724_71065.column.tipoPrestamo.format,
                    editor: $scope.vc.grids.QV_3724_71065.AT59_TIPOPRSS237.control,
                    template: "<span ng-class='vc.viewState.QV_3724_71065.column.tipoPrestamo.style' ng-bind='vc.getStringColumnFormat(dataItem.tipoPrestamo, \"QV_3724_71065\", \"tipoPrestamo\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3724_71065.column.tipoPrestamo.style",
                        "title": "{{vc.viewState.QV_3724_71065.column.tipoPrestamo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3724_71065.column.tipoPrestamo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3724_71065.columns.push({
                    field: 'montoPagado',
                    title: '{{vc.viewState.QV_3724_71065.column.montoPagado.title|translate:vc.viewState.QV_3724_71065.column.montoPagado.titleArgs}}',
                    width: $scope.vc.viewState.QV_3724_71065.column.montoPagado.width,
                    format: $scope.vc.viewState.QV_3724_71065.column.montoPagado.format,
                    editor: $scope.vc.grids.QV_3724_71065.AT83_MONTOPAA237.control,
                    template: "<span ng-class='vc.viewState.QV_3724_71065.column.montoPagado.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.montoPagado, \"QV_3724_71065\", \"montoPagado\"):kendo.toString(#=montoPagado#, vc.viewState.QV_3724_71065.column.montoPagado.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3724_71065.column.montoPagado.style",
                        "title": "{{vc.viewState.QV_3724_71065.column.montoPagado.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3724_71065.column.montoPagado.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3724_71065.columns.push({
                    field: 'fecha',
                    title: '{{vc.viewState.QV_3724_71065.column.fecha.title|translate:vc.viewState.QV_3724_71065.column.fecha.titleArgs}}',
                    width: $scope.vc.viewState.QV_3724_71065.column.fecha.width,
                    format: $scope.vc.viewState.QV_3724_71065.column.fecha.format,
                    editor: $scope.vc.grids.QV_3724_71065.AT48_FECHAVXZ237.control,
                    template: "<span ng-class='vc.viewState.QV_3724_71065.column.fecha.style' ng-bind='vc.getStringColumnFormat(dataItem.fecha, \"QV_3724_71065\", \"fecha\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3724_71065.column.fecha.style",
                        "title": "{{vc.viewState.QV_3724_71065.column.fecha.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3724_71065.column.fecha.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3724_71065.columns.push({
                    field: 'idPrestamo',
                    title: '{{vc.viewState.QV_3724_71065.column.idPrestamo.title|translate:vc.viewState.QV_3724_71065.column.idPrestamo.titleArgs}}',
                    width: $scope.vc.viewState.QV_3724_71065.column.idPrestamo.width,
                    format: $scope.vc.viewState.QV_3724_71065.column.idPrestamo.format,
                    editor: $scope.vc.grids.QV_3724_71065.AT31_IDPRESOM237.control,
                    template: "<span ng-class='vc.viewState.QV_3724_71065.column.idPrestamo.style' ng-bind='vc.getStringColumnFormat(dataItem.idPrestamo, \"QV_3724_71065\", \"idPrestamo\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3724_71065.column.idPrestamo.style",
                        "title": "{{vc.viewState.QV_3724_71065.column.idPrestamo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3724_71065.column.idPrestamo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3724_71065.columns.push({
                    field: 'seleccionar',
                    title: '{{vc.viewState.QV_3724_71065.column.seleccionar.title|translate:vc.viewState.QV_3724_71065.column.seleccionar.titleArgs}}',
                    width: $scope.vc.viewState.QV_3724_71065.column.seleccionar.width,
                    format: $scope.vc.viewState.QV_3724_71065.column.seleccionar.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_3724_71065', 'seleccionar', $scope.vc.grids.QV_3724_71065.AT28_REGULAIA237.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_3724_71065', 'seleccionar', "<input name='seleccionar' type='checkbox' value='#=seleccionar#' #=seleccionar?checked='checked':''# disabled='disabled' data-bind='value:seleccionar' ng-class='vc.viewState.QV_3724_71065.column.seleccionar.style' />"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3724_71065.column.seleccionar.style",
                        "title": "{{vc.viewState.QV_3724_71065.column.seleccionar.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3724_71065.column.seleccionar.hidden
                });
            }
            $scope.vc.viewState.QV_3724_71065.toolbar = {}
            $scope.vc.grids.QV_3724_71065.toolbar = [];
            $scope.vc.model.DatosRegularizarPagos = {
                formaPago: $scope.vc.channelDefaultValues("DatosRegularizarPagos", "formaPago")
            };
            //ViewState - Group: Group1379
            $scope.vc.createViewState({
                id: "G_FREGULARSR_337505",
                hasId: true,
                componentStyle: [],
                label: 'Group1379',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DatosRegularizarPagos, Attribute: formaPago
            $scope.vc.createViewState({
                id: "VA_1MAZDGHHFBBVYEE_972505",
                componentStyle: [],
                label: "PAOBJ.LBL_PAOBJ_APAGORELL_78354",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_1MAZDGHHFBBVYEE_972505 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_1MAZDGHHFBBVYEE_972505', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_1MAZDGHHFBBVYEE_972505'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_1MAZDGHHFBBVYEE_972505");
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
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PAOBJXPZXAKUO_168_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PAOBJXPZXAKUO_168_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: CmdRegularizar
            $scope.vc.createViewState({
                id: "CM_TPAOBJXP_PBZ",
                componentStyle: [],
                label: "PAOBJ.LBL_PAOBJ_REGULARZR_16910",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: cmdSalir
            $scope.vc.createViewState({
                id: "CM_TPAOBJXP_796",
                componentStyle: [],
                label: "PAOBJ.LBL_PAOBJ_SALIRADDZ_26054",
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
                $scope.vc.render('VC_FREGULARPJ_493168');
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
    var cobisMainModule = cobis.createModule("VC_FREGULARPJ_493168", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "PAOBJ"]);
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
        $routeProvider.when("/VC_FREGULARPJ_493168", {
            templateUrl: "VC_FREGULARPJ_493168_FORM.html",
            controller: "VC_FREGULARPJ_493168_CTRL",
            labelId: "PAOBJ.LBL_PAOBJ_REGULAREA_99273",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('PAOBJ');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_FREGULARPJ_493168?" + $.param(search);
            }
        });
        VC_FREGULARPJ_493168(cobisMainModule);
    }]);
} else {
    VC_FREGULARPJ_493168(cobisMainModule);
}