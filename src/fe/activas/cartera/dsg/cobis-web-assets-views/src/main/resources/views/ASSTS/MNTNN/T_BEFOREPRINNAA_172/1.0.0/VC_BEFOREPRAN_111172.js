//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.beforeprintpaymentform = designerEvents.api.beforeprintpaymentform || designer.dsgEvents();

function VC_BEFOREPRAN_111172(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_BEFOREPRAN_111172_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_BEFOREPRAN_111172_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_BEFOREPRINNAA_172",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BEFOREPRAN_111172",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_BEFOREPRINNAA_172",
        designerEvents.api.beforeprintpaymentform,
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
                vcName: 'VC_BEFOREPRAN_111172'
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
                    taskId: 'T_BEFOREPRINNAA_172',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    PrintingPaymentInfo: "PrintingPaymentInfo",
                    LoanInstancia: "LoanInstancia"
                },
                entities: {
                    PrintingPaymentInfo: {
                        numReceipt: 'AT38_NUMRECIE519',
                        secuentialIng: 'AT99_SECUENIG519',
                        secuentialPag: 'AT12_SECUENIG519',
                        statusPag: 'AT48_STATUSGG519',
                        paymentDate: 'AT96_PAYMENAE519',
                        official: 'AT10_OFFICIMM519',
                        itemSel: 'AT20_ITEMSELL519',
                        _pks: [],
                        _entityId: 'EN_PRINTINNP_519',
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
            $scope.vc.queryProperties.Q_PRINTIEF_5858 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_PRINTIEF_5858 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PRINTIEF_5858_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PRINTIEF_5858_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PRINTINNP_519',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PRINTIEF_5858',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_PRINTIEF_5858_filters = {};
            var defaultValues = {
                PrintingPaymentInfo: {},
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
                $scope.vc.execute("temporarySave", VC_BEFOREPRAN_111172, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_BEFOREPRAN_111172, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_BEFOREPRAN_111172, data, function() {});
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
            $scope.vc.viewState.VC_BEFOREPRAN_111172 = {
                style: []
            }
            //ViewState - Group: Group1291
            $scope.vc.createViewState({
                id: "G_BEFOREPIRI_867811",
                hasId: true,
                componentStyle: [],
                label: 'Group1291',
                enabled: designer.constants.mode.Insert + designer.constants.mode.Query,
                visible: designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.types.PrintingPaymentInfo = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    numReceipt: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PrintingPaymentInfo", "numReceipt", 0)
                    },
                    secuentialIng: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PrintingPaymentInfo", "secuentialIng", 0)
                    },
                    secuentialPag: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PrintingPaymentInfo", "secuentialPag", 0)
                    },
                    statusPag: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PrintingPaymentInfo", "statusPag", '')
                    },
                    paymentDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PrintingPaymentInfo", "paymentDate", '')
                    },
                    official: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PrintingPaymentInfo", "official", 0)
                    }
                }
            });
            $scope.vc.model.PrintingPaymentInfo = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_PRINTIEF_5858';
                            var queryRequest = $scope.vc.getRequestQuery_Q_PRINTIEF_5858();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_5858_58779',
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
                    model: $scope.vc.types.PrintingPaymentInfo
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5858_58779").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PRINTIEF_5858 = $scope.vc.model.PrintingPaymentInfo;
            $scope.vc.trackers.PrintingPaymentInfo = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PrintingPaymentInfo);
            $scope.vc.model.PrintingPaymentInfo.bind('change', function(e) {
                $scope.vc.trackers.PrintingPaymentInfo.track(e);
            });
            $scope.vc.grids.QV_5858_58779 = {};
            $scope.vc.grids.QV_5858_58779.queryId = 'Q_PRINTIEF_5858';
            $scope.vc.viewState.QV_5858_58779 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5858_58779.column = {};
            $scope.vc.grids.QV_5858_58779.editable = false;
            $scope.vc.grids.QV_5858_58779.events = {
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
                    $scope.vc.trackers.PrintingPaymentInfo.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_5858_58779.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_5858_58779");
                    $scope.vc.hideShowColumns("QV_5858_58779", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5858_58779.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5858_58779.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5858_58779.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5858_58779 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5858_58779 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_5858_58779.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_5858_58779.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_5858_58779.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "PrintingPaymentInfo",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_5858_58779", args);
                        }
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
            $scope.vc.grids.QV_5858_58779.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5858_58779.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5858_58779.column.numReceipt = {
                title: 'ASSTS.LBL_ASSTS_NUMRECIOO_91989',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXSP_798811',
                element: []
            };
            $scope.vc.grids.QV_5858_58779.AT38_NUMRECIE519 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5858_58779.column.numReceipt.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXSP_798811",
                        'data-validation-code': "{{vc.viewState.QV_5858_58779.column.numReceipt.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5858_58779.column.numReceipt.format",
                        'k-decimals': "vc.viewState.QV_5858_58779.column.numReceipt.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5858_58779.column.numReceipt.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5858_58779.column.secuentialIng = {
                title: 'ASSTS.LBL_ASSTS_SECUENCIG_21991',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPDZ_468811',
                element: []
            };
            $scope.vc.grids.QV_5858_58779.AT99_SECUENIG519 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5858_58779.column.secuentialIng.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPDZ_468811",
                        'data-validation-code': "{{vc.viewState.QV_5858_58779.column.secuentialIng.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5858_58779.column.secuentialIng.format",
                        'k-decimals': "vc.viewState.QV_5858_58779.column.secuentialIng.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5858_58779.column.secuentialIng.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5858_58779.column.secuentialPag = {
                title: 'ASSTS.LBL_ASSTS_SECUENCIA_84627',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNRF_323811',
                element: []
            };
            $scope.vc.grids.QV_5858_58779.AT12_SECUENIG519 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5858_58779.column.secuentialPag.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNRF_323811",
                        'data-validation-code': "{{vc.viewState.QV_5858_58779.column.secuentialPag.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5858_58779.column.secuentialPag.format",
                        'k-decimals': "vc.viewState.QV_5858_58779.column.secuentialPag.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5858_58779.column.secuentialPag.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5858_58779.column.statusPag = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOTN_927811',
                element: []
            };
            $scope.vc.grids.QV_5858_58779.AT48_STATUSGG519 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5858_58779.column.statusPag.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOTN_927811",
                        'data-validation-code': "{{vc.viewState.QV_5858_58779.column.statusPag.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5858_58779.column.statusPag.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5858_58779.column.paymentDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAPAGG_21416',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWJS_799811',
                element: []
            };
            $scope.vc.grids.QV_5858_58779.AT96_PAYMENAE519 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5858_58779.column.paymentDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWJS_799811",
                        'data-validation-code': "{{vc.viewState.QV_5858_58779.column.paymentDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5858_58779.column.paymentDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5858_58779.column.official = {
                title: 'ASSTS.LBL_ASSTS_OFICIALYV_61839',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFCE_661811',
                element: []
            };
            $scope.vc.grids.QV_5858_58779.AT10_OFFICIMM519 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5858_58779.column.official.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFCE_661811",
                        'data-validation-code': "{{vc.viewState.QV_5858_58779.column.official.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5858_58779.column.official.format",
                        'k-decimals': "vc.viewState.QV_5858_58779.column.official.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5858_58779.column.official.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5858_58779.columns.push({
                    field: 'numReceipt',
                    title: '{{vc.viewState.QV_5858_58779.column.numReceipt.title|translate:vc.viewState.QV_5858_58779.column.numReceipt.titleArgs}}',
                    width: $scope.vc.viewState.QV_5858_58779.column.numReceipt.width,
                    format: $scope.vc.viewState.QV_5858_58779.column.numReceipt.format,
                    editor: $scope.vc.grids.QV_5858_58779.AT38_NUMRECIE519.control,
                    template: "<span ng-class='vc.viewState.QV_5858_58779.column.numReceipt.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numReceipt, \"QV_5858_58779\", \"numReceipt\"):kendo.toString(#=numReceipt#, vc.viewState.QV_5858_58779.column.numReceipt.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5858_58779.column.numReceipt.style",
                        "title": "{{vc.viewState.QV_5858_58779.column.numReceipt.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5858_58779.column.numReceipt.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5858_58779.columns.push({
                    field: 'secuentialIng',
                    title: '{{vc.viewState.QV_5858_58779.column.secuentialIng.title|translate:vc.viewState.QV_5858_58779.column.secuentialIng.titleArgs}}',
                    width: $scope.vc.viewState.QV_5858_58779.column.secuentialIng.width,
                    format: $scope.vc.viewState.QV_5858_58779.column.secuentialIng.format,
                    editor: $scope.vc.grids.QV_5858_58779.AT99_SECUENIG519.control,
                    template: "<span ng-class='vc.viewState.QV_5858_58779.column.secuentialIng.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuentialIng, \"QV_5858_58779\", \"secuentialIng\"):kendo.toString(#=secuentialIng#, vc.viewState.QV_5858_58779.column.secuentialIng.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5858_58779.column.secuentialIng.style",
                        "title": "{{vc.viewState.QV_5858_58779.column.secuentialIng.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5858_58779.column.secuentialIng.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5858_58779.columns.push({
                    field: 'secuentialPag',
                    title: '{{vc.viewState.QV_5858_58779.column.secuentialPag.title|translate:vc.viewState.QV_5858_58779.column.secuentialPag.titleArgs}}',
                    width: $scope.vc.viewState.QV_5858_58779.column.secuentialPag.width,
                    format: $scope.vc.viewState.QV_5858_58779.column.secuentialPag.format,
                    editor: $scope.vc.grids.QV_5858_58779.AT12_SECUENIG519.control,
                    template: "<span ng-class='vc.viewState.QV_5858_58779.column.secuentialPag.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuentialPag, \"QV_5858_58779\", \"secuentialPag\"):kendo.toString(#=secuentialPag#, vc.viewState.QV_5858_58779.column.secuentialPag.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5858_58779.column.secuentialPag.style",
                        "title": "{{vc.viewState.QV_5858_58779.column.secuentialPag.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5858_58779.column.secuentialPag.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5858_58779.columns.push({
                    field: 'statusPag',
                    title: '{{vc.viewState.QV_5858_58779.column.statusPag.title|translate:vc.viewState.QV_5858_58779.column.statusPag.titleArgs}}',
                    width: $scope.vc.viewState.QV_5858_58779.column.statusPag.width,
                    format: $scope.vc.viewState.QV_5858_58779.column.statusPag.format,
                    editor: $scope.vc.grids.QV_5858_58779.AT48_STATUSGG519.control,
                    template: "<span ng-class='vc.viewState.QV_5858_58779.column.statusPag.style' ng-bind='vc.getStringColumnFormat(dataItem.statusPag, \"QV_5858_58779\", \"statusPag\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5858_58779.column.statusPag.style",
                        "title": "{{vc.viewState.QV_5858_58779.column.statusPag.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5858_58779.column.statusPag.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5858_58779.columns.push({
                    field: 'paymentDate',
                    title: '{{vc.viewState.QV_5858_58779.column.paymentDate.title|translate:vc.viewState.QV_5858_58779.column.paymentDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_5858_58779.column.paymentDate.width,
                    format: $scope.vc.viewState.QV_5858_58779.column.paymentDate.format,
                    editor: $scope.vc.grids.QV_5858_58779.AT96_PAYMENAE519.control,
                    template: "<span ng-class='vc.viewState.QV_5858_58779.column.paymentDate.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentDate, \"QV_5858_58779\", \"paymentDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5858_58779.column.paymentDate.style",
                        "title": "{{vc.viewState.QV_5858_58779.column.paymentDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5858_58779.column.paymentDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5858_58779.columns.push({
                    field: 'official',
                    title: '{{vc.viewState.QV_5858_58779.column.official.title|translate:vc.viewState.QV_5858_58779.column.official.titleArgs}}',
                    width: $scope.vc.viewState.QV_5858_58779.column.official.width,
                    format: $scope.vc.viewState.QV_5858_58779.column.official.format,
                    editor: $scope.vc.grids.QV_5858_58779.AT10_OFFICIMM519.control,
                    template: "<span ng-class='vc.viewState.QV_5858_58779.column.official.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.official, \"QV_5858_58779\", \"official\"):kendo.toString(#=official#, vc.viewState.QV_5858_58779.column.official.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5858_58779.column.official.style",
                        "title": "{{vc.viewState.QV_5858_58779.column.official.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5858_58779.column.official.hidden
                });
            }
            $scope.vc.viewState.QV_5858_58779.toolbar = {}
            $scope.vc.grids.QV_5858_58779.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BEFOREPRINNAA_172_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BEFOREPRINNAA_172_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TBEFOREP_5TF",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ACEPTARDV_64984",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
            };
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
                $scope.vc.render('VC_BEFOREPRAN_111172');
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
    var cobisMainModule = cobis.createModule("VC_BEFOREPRAN_111172", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_BEFOREPRAN_111172", {
            templateUrl: "VC_BEFOREPRAN_111172_FORM.html",
            controller: "VC_BEFOREPRAN_111172_CTRL",
            label: "BeforePrintPaymentForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_BEFOREPRAN_111172?" + $.param(search);
            }
        });
        VC_BEFOREPRAN_111172(cobisMainModule);
    }]);
} else {
    VC_BEFOREPRAN_111172(cobisMainModule);
}