//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.paymentapplication = designerEvents.api.paymentapplication || designer.dsgEvents();

function VC_PAYMENTALO_139983(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PAYMENTALO_139983_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PAYMENTALO_139983_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSWUUUFOXQ_983",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PAYMENTALO_139983",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_ASSTSWUUUFOXQ_983",
        designerEvents.api.paymentapplication,
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
                vcName: 'VC_PAYMENTALO_139983'
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
                    taskId: 'T_ASSTSWUUUFOXQ_983',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Entity17: "Entity17",
                    PaymentApplication: "PaymentApplication"
                },
                entities: {
                    Entity17: {
                        attribute1: 'AT02_1WOVHIBX372',
                        _pks: [],
                        _entityId: 'EN_17TNZEZPU_372',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentApplication: {
                        operation: 'AT12_OPERATIO239',
                        debitAmount: 'AT13_DEBITAUN239',
                        debitedAmount: 'AT13_DEBITEAD239',
                        groupReference: 'AT20_GROUPRER239',
                        processDate: 'AT45_PROCESTS239',
                        transaction: 'AT46_TRANSANI239',
                        identification: 'AT48_IDENTINI239',
                        bank: 'AT50_BANKTIVL239',
                        sendDate: 'AT54_SENDDAET239',
                        paymentType: 'AT57_PAYMENPY239',
                        debitAccount: 'AT68_DEBITACO239',
                        statement: 'AT76_STATEMEE239',
                        typeIdentification: 'AT82_TYPEIDII239',
                        recordAccount: 'AT84_RECORDUT239',
                        _pks: [],
                        _entityId: 'EN_PAYMENTPN_239',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_PAYMENII_8495 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_PAYMENII_8495 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PAYMENII_8495_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PAYMENII_8495_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PAYMENTPN_239',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PAYMENII_8495',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_PAYMENII_8495_filters = {};
            var defaultValues = {
                Entity17: {},
                PaymentApplication: {}
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
                $scope.vc.execute("temporarySave", VC_PAYMENTALO_139983, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_PAYMENTALO_139983, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_PAYMENTALO_139983, data, function() {});
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
            $scope.vc.viewState.VC_PAYMENTALO_139983 = {
                style: []
            }
            $scope.vc.model.Entity17 = {
                attribute1: $scope.vc.channelDefaultValues("Entity17", "attribute1")
            };
            //ViewState - Group: Group1316
            $scope.vc.createViewState({
                id: "G_PAYMENTLPA_538131",
                hasId: true,
                componentStyle: [],
                label: 'Group1316',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Entity17, Attribute: attribute1
            $scope.vc.createViewState({
                id: "VA_1RKSKKIACKZKFJR_539131",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CARGARAVI_75931",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.viewState.VA_1RKSKKIACKZKFJR_539131.disableUpload = false;
            $scope.vc.viewState.uploadVisible = true;
            $scope.vc.uploaders.VA_1RKSKKIACKZKFJR_539131 = {
                maxSizeInMB: 10,
                relativePath: null,
                confirmUpload: false,
                visualAttributeModel: 'vc.model.Entity17.attribute1',
                fileUploadAPI: null
            };
            $scope.vc.createViewState({
                id: "VA_VABUTTONUHRKEOM_688131",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PROCESARR_55017",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1678
            $scope.vc.createViewState({
                id: "G_PAYMENTAPI_167131",
                hasId: true,
                componentStyle: [],
                label: 'Group1678',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.PaymentApplication = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    processDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "processDate", new Date())
                    },
                    sendDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "sendDate", new Date())
                    },
                    identification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "identification", '')
                    },
                    typeIdentification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "typeIdentification", '')
                    },
                    debitAccount: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "debitAccount", '')
                    },
                    recordAccount: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "recordAccount", '')
                    },
                    groupReference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "groupReference", '')
                    },
                    operation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "operation", 0)
                    },
                    bank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "bank", '')
                    },
                    debitAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "debitAmount", 0)
                    },
                    debitedAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "debitedAmount", 0)
                    },
                    paymentType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "paymentType", '')
                    },
                    statement: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "statement", '')
                    },
                    transaction: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentApplication", "transaction", '')
                    }
                }
            });
            $scope.vc.model.PaymentApplication = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_PAYMENII_8495';
                            var queryRequest = $scope.vc.getRequestQuery_Q_PAYMENII_8495();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_8495_46282',
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
                    model: $scope.vc.types.PaymentApplication
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8495_46282").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PAYMENII_8495 = $scope.vc.model.PaymentApplication;
            $scope.vc.trackers.PaymentApplication = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PaymentApplication);
            $scope.vc.model.PaymentApplication.bind('change', function(e) {
                $scope.vc.trackers.PaymentApplication.track(e);
            });
            $scope.vc.grids.QV_8495_46282 = {};
            $scope.vc.grids.QV_8495_46282.queryId = 'Q_PAYMENII_8495';
            $scope.vc.viewState.QV_8495_46282 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8495_46282.column = {};
            $scope.vc.grids.QV_8495_46282.editable = false;
            $scope.vc.grids.QV_8495_46282.events = {
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
                    $scope.vc.trackers.PaymentApplication.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_8495_46282.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_8495_46282");
                    $scope.vc.hideShowColumns("QV_8495_46282", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8495_46282.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8495_46282.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8495_46282.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8495_46282 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8495_46282 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8495_46282.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8495_46282.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8495_46282.column.processDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAPRSC_69139',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDSDZJCT_688131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT45_PROCESTS239 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.processDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDSDZJCT_688131",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.processDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_8495_46282.column.processDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.sendDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAENVV_38174',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDRQBWLR_884131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT54_SENDDAET239 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.sendDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDRQBWLR_884131",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.sendDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_8495_46282.column.sendDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.identification = {
                title: 'ASSTS.LBL_ASSTS_IDENTIFCI_68121',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXARW_771131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT48_IDENTINI239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.identification.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXARW_771131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.identification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.identification.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.typeIdentification = {
                title: 'ASSTS.LBL_ASSTS_TIPOIDETI_21234',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPBG_388131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT82_TYPEIDII239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.typeIdentification.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPBG_388131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.typeIdentification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.typeIdentification.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.debitAccount = {
                title: 'ASSTS.LBL_ASSTS_NROCTADIT_66216',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVZR_848131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT68_DEBITACO239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.debitAccount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVZR_848131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.debitAccount.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.debitAccount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.recordAccount = {
                title: 'ASSTS.LBL_ASSTS_CTAEXPEIE_88433',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIQM_226131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT84_RECORDUT239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.recordAccount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIQM_226131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.recordAccount.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.recordAccount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.groupReference = {
                title: 'ASSTS.LBL_ASSTS_REFERENAA_79934',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIRC_899131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT20_GROUPRER239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.groupReference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIRC_899131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.groupReference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.groupReference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.operation = {
                title: 'ASSTS.LBL_ASSTS_OPERACICO_14654',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTSJ_688131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT12_OPERATIO239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.operation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTSJ_688131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.operation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8495_46282.column.operation.format",
                        'k-decimals': "vc.viewState.QV_8495_46282.column.operation.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.operation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.bank = {
                title: 'ASSTS.LBL_ASSTS_BANCOPEGT_42609',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXXS_442131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT50_BANKTIVL239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.bank.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXXS_442131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.bank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.bank.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.debitAmount = {
                title: 'ASSTS.LBL_ASSTS_VALORDEIR_79807',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRER_579131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT13_DEBITAUN239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.debitAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRER_579131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.debitAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8495_46282.column.debitAmount.format",
                        'k-decimals': "vc.viewState.QV_8495_46282.column.debitAmount.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.debitAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.debitedAmount = {
                title: 'ASSTS.LBL_ASSTS_VALORDEOA_75123',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPYD_181131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT13_DEBITEAD239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.debitedAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPYD_181131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.debitedAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8495_46282.column.debitedAmount.format",
                        'k-decimals': "vc.viewState.QV_8495_46282.column.debitedAmount.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.debitedAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.paymentType = {
                title: 'ASSTS.LBL_ASSTS_TIPOPAGOO_46459',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFNE_911131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT57_PAYMENPY239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.paymentType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFNE_911131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.paymentType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.paymentType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.statement = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGQB_653131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT76_STATEMEE239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.statement.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGQB_653131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.statement.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.statement.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8495_46282.column.transaction = {
                title: 'ASSTS.LBL_ASSTS_TRANSACCC_32542',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUUU_994131',
                element: []
            };
            $scope.vc.grids.QV_8495_46282.AT46_TRANSANI239 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8495_46282.column.transaction.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUUU_994131",
                        'data-validation-code': "{{vc.viewState.QV_8495_46282.column.transaction.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8495_46282.column.transaction.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'processDate',
                    title: '{{vc.viewState.QV_8495_46282.column.processDate.title|translate:vc.viewState.QV_8495_46282.column.processDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.processDate.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.processDate.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT45_PROCESTS239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.processDate.style'>#=((processDate !== null) ? kendo.toString(processDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.processDate.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.processDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.processDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'sendDate',
                    title: '{{vc.viewState.QV_8495_46282.column.sendDate.title|translate:vc.viewState.QV_8495_46282.column.sendDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.sendDate.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.sendDate.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT54_SENDDAET239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.sendDate.style'>#=((sendDate !== null) ? kendo.toString(sendDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.sendDate.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.sendDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.sendDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'identification',
                    title: '{{vc.viewState.QV_8495_46282.column.identification.title|translate:vc.viewState.QV_8495_46282.column.identification.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.identification.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.identification.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT48_IDENTINI239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.identification.style' ng-bind='vc.getStringColumnFormat(dataItem.identification, \"QV_8495_46282\", \"identification\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.identification.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.identification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.identification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'typeIdentification',
                    title: '{{vc.viewState.QV_8495_46282.column.typeIdentification.title|translate:vc.viewState.QV_8495_46282.column.typeIdentification.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.typeIdentification.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.typeIdentification.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT82_TYPEIDII239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.typeIdentification.style' ng-bind='vc.getStringColumnFormat(dataItem.typeIdentification, \"QV_8495_46282\", \"typeIdentification\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.typeIdentification.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.typeIdentification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.typeIdentification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'debitAccount',
                    title: '{{vc.viewState.QV_8495_46282.column.debitAccount.title|translate:vc.viewState.QV_8495_46282.column.debitAccount.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.debitAccount.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.debitAccount.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT68_DEBITACO239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.debitAccount.style' ng-bind='vc.getStringColumnFormat(dataItem.debitAccount, \"QV_8495_46282\", \"debitAccount\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.debitAccount.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.debitAccount.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.debitAccount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'recordAccount',
                    title: '{{vc.viewState.QV_8495_46282.column.recordAccount.title|translate:vc.viewState.QV_8495_46282.column.recordAccount.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.recordAccount.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.recordAccount.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT84_RECORDUT239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.recordAccount.style' ng-bind='vc.getStringColumnFormat(dataItem.recordAccount, \"QV_8495_46282\", \"recordAccount\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.recordAccount.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.recordAccount.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.recordAccount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'groupReference',
                    title: '{{vc.viewState.QV_8495_46282.column.groupReference.title|translate:vc.viewState.QV_8495_46282.column.groupReference.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.groupReference.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.groupReference.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT20_GROUPRER239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.groupReference.style' ng-bind='vc.getStringColumnFormat(dataItem.groupReference, \"QV_8495_46282\", \"groupReference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.groupReference.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.groupReference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.groupReference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'operation',
                    title: '{{vc.viewState.QV_8495_46282.column.operation.title|translate:vc.viewState.QV_8495_46282.column.operation.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.operation.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.operation.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT12_OPERATIO239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.operation.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.operation, \"QV_8495_46282\", \"operation\"):kendo.toString(#=operation#, vc.viewState.QV_8495_46282.column.operation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8495_46282.column.operation.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.operation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.operation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'bank',
                    title: '{{vc.viewState.QV_8495_46282.column.bank.title|translate:vc.viewState.QV_8495_46282.column.bank.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.bank.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.bank.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT50_BANKTIVL239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.bank.style' ng-bind='vc.getStringColumnFormat(dataItem.bank, \"QV_8495_46282\", \"bank\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.bank.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.bank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.bank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'debitAmount',
                    title: '{{vc.viewState.QV_8495_46282.column.debitAmount.title|translate:vc.viewState.QV_8495_46282.column.debitAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.debitAmount.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.debitAmount.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT13_DEBITAUN239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.debitAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.debitAmount, \"QV_8495_46282\", \"debitAmount\"):kendo.toString(#=debitAmount#, vc.viewState.QV_8495_46282.column.debitAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8495_46282.column.debitAmount.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.debitAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.debitAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'debitedAmount',
                    title: '{{vc.viewState.QV_8495_46282.column.debitedAmount.title|translate:vc.viewState.QV_8495_46282.column.debitedAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.debitedAmount.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.debitedAmount.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT13_DEBITEAD239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.debitedAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.debitedAmount, \"QV_8495_46282\", \"debitedAmount\"):kendo.toString(#=debitedAmount#, vc.viewState.QV_8495_46282.column.debitedAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8495_46282.column.debitedAmount.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.debitedAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.debitedAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'paymentType',
                    title: '{{vc.viewState.QV_8495_46282.column.paymentType.title|translate:vc.viewState.QV_8495_46282.column.paymentType.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.paymentType.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.paymentType.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT57_PAYMENPY239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.paymentType.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentType, \"QV_8495_46282\", \"paymentType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.paymentType.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.paymentType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.paymentType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'statement',
                    title: '{{vc.viewState.QV_8495_46282.column.statement.title|translate:vc.viewState.QV_8495_46282.column.statement.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.statement.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.statement.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT76_STATEMEE239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.statement.style' ng-bind='vc.getStringColumnFormat(dataItem.statement, \"QV_8495_46282\", \"statement\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.statement.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.statement.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.statement.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8495_46282.columns.push({
                    field: 'transaction',
                    title: '{{vc.viewState.QV_8495_46282.column.transaction.title|translate:vc.viewState.QV_8495_46282.column.transaction.titleArgs}}',
                    width: $scope.vc.viewState.QV_8495_46282.column.transaction.width,
                    format: $scope.vc.viewState.QV_8495_46282.column.transaction.format,
                    editor: $scope.vc.grids.QV_8495_46282.AT46_TRANSANI239.control,
                    template: "<span ng-class='vc.viewState.QV_8495_46282.column.transaction.style' ng-bind='vc.getStringColumnFormat(dataItem.transaction, \"QV_8495_46282\", \"transaction\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8495_46282.column.transaction.style",
                        "title": "{{vc.viewState.QV_8495_46282.column.transaction.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8495_46282.column.transaction.hidden
                });
            }
            $scope.vc.viewState.QV_8495_46282.toolbar = {}
            $scope.vc.grids.QV_8495_46282.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSWUUUFOXQ_983_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSWUUUFOXQ_983_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TASSTSWU_SAS",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GUARDARRI_81055",
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
                $scope.vc.render('VC_PAYMENTALO_139983');
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
    var cobisMainModule = cobis.createModule("VC_PAYMENTALO_139983", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_PAYMENTALO_139983", {
            templateUrl: "VC_PAYMENTALO_139983_FORM.html",
            controller: "VC_PAYMENTALO_139983_CTRL",
            labelId: "ASSTS.LBL_ASSTS_CARGAARIG_95378",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PAYMENTALO_139983?" + $.param(search);
            }
        });
        VC_PAYMENTALO_139983(cobisMainModule);
    }]);
} else {
    VC_PAYMENTALO_139983(cobisMainModule);
}