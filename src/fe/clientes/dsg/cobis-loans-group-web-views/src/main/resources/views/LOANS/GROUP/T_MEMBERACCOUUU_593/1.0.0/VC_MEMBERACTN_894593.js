//Designer Generator v 6.1.1 - release SPR 2017-05_01 03/20/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.memberaccountform = designerEvents.api.memberaccountform || designer.dsgEvents();

function VC_MEMBERACTN_894593(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MEMBERACTN_894593_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MEMBERACTN_894593_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            moduleId: "LOANS",
            subModuleId: "GROUP",
            taskId: "T_MEMBERACCOUUU_593",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MEMBERACTN_894593",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_MEMBERACCOUUU_593",
        designerEvents.api.memberaccountform,
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
                vcName: 'VC_MEMBERACTN_894593'
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
                    moduleId: 'LOANS',
                    subModuleId: 'GROUP',
                    taskId: 'T_MEMBERACCOUUU_593',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    PaymentSelection: "PaymentSelection",
                    Amount: "Amount"
                },
                entities: {
                    PaymentSelection: {
                        selectedType: 'AT12_SELECTED868',
                        groupId: 'AT61_GROUPIDD868',
                        transactionNumber: 'AT61_TRANSARC868',
                        _pks: [],
                        _entityId: 'EN_PAYMENTTS_868',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Amount: {
                        memberId: 'AT45_MEMBERID937',
                        amount: 'AT51_AMOUNTUQ937',
                        secuential: 'AT52_SECUENIA937',
                        memberName: 'AT62_MEMBERNN937',
                        groupId: 'AT70_GROUPIDD937',
                        accountNumber: 'AT80_ACCOUNRT937',
                        credit: 'AT83_CREDITGM937',
                        _pks: [],
                        _entityId: 'EN_MONTOSVSY_937',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_AMOUNTKL_6248 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_AMOUNTKL_6248 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AMOUNTKL_6248_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_AMOUNTKL_6248_filters;
                    parametersAux = {
                        memberId: filters.memberId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MONTOSVSY_937',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AMOUNTKL_6248',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['memberId'] = this.filters.memberId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_AMOUNTKL_6248_filters = {};
            var defaultValues = {
                PaymentSelection: {},
                Amount: {}
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
                $scope.vc.execute("temporarySave", VC_MEMBERACTN_894593, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MEMBERACTN_894593, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MEMBERACTN_894593, data, function() {});
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
            $scope.vc.viewState.VC_MEMBERACTN_894593 = {
                style: []
            }
            $scope.vc.model.PaymentSelection = {
                selectedType: $scope.vc.channelDefaultValues("PaymentSelection", "selectedType"),
                groupId: $scope.vc.channelDefaultValues("PaymentSelection", "groupId"),
                transactionNumber: $scope.vc.channelDefaultValues("PaymentSelection", "transactionNumber")
            };
            //ViewState - Group: Group1589
            $scope.vc.createViewState({
                id: "G_MEMBERAUCN_101750",
                hasId: true,
                componentStyle: [],
                label: 'Group1589',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentSelection, Attribute: selectedType
            $scope.vc.createViewState({
                id: "VA_1604DQVPVZOCATA_609750",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_ADEPAGOTR_68531",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_1604DQVPVZOCATA_609750 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_1604DQVPVZOCATA_609750', 'ca_forma_pago', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_1604DQVPVZOCATA_609750'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_1604DQVPVZOCATA_609750");
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
            //ViewState - Entity: PaymentSelection, Attribute: groupId
            $scope.vc.createViewState({
                id: "VA_GROUPIDVCEQLPRI_938750",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GRUPOQVCT_54778",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentSelection, Attribute: transactionNumber
            $scope.vc.createViewState({
                id: "VA_TRANSACTIONNBRM_714750",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TRMITEAHU_42523",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONINEGDLY_123750",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GUARDARLI_67841",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2165
            $scope.vc.createViewState({
                id: "G_MEMBERANUT_667750",
                hasId: true,
                componentStyle: [],
                label: 'Group2165',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Amount = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    memberName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "memberName", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "amount", 0)
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "secuential", 0)
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "groupId", 0)
                    },
                    credit: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "credit", 0)
                    },
                    accountNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "accountNumber", '')
                    },
                    memberId: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Amount = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_AMOUNTKL_6248';
                            var queryRequest = $scope.vc.getRequestQuery_Q_AMOUNTKL_6248();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6248_48646',
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
                    model: $scope.vc.types.Amount
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6248_48646").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AMOUNTKL_6248 = $scope.vc.model.Amount;
            $scope.vc.trackers.Amount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Amount);
            $scope.vc.model.Amount.bind('change', function(e) {
                $scope.vc.trackers.Amount.track(e);
            });
            $scope.vc.grids.QV_6248_48646 = {};
            $scope.vc.grids.QV_6248_48646.queryId = 'Q_AMOUNTKL_6248';
            $scope.vc.viewState.QV_6248_48646 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6248_48646.column = {};
            $scope.vc.grids.QV_6248_48646.editable = false;
            $scope.vc.grids.QV_6248_48646.events = {
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
                    $scope.vc.trackers.Amount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6248_48646.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6248_48646");
                    $scope.vc.hideShowColumns("QV_6248_48646", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6248_48646.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6248_48646.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_6248_48646.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6248_48646 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6248_48646 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6248_48646.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6248_48646.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6248_48646.column.memberName = {
                title: 'LOANS.LBL_LOANS_CLIENTEMZ_77659',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYXA_221750',
                element: []
            };
            $scope.vc.grids.QV_6248_48646.AT62_MEMBERNN937 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_6248_48646.column.memberName.element[\'' + options.model.uid + '\'].style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_48646.column.amount = {
                title: 'LOANS.LBL_LOANS_MONTOHJTW_23441',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIDN_154750',
                element: []
            };
            $scope.vc.grids.QV_6248_48646.AT51_AMOUNTUQ937 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_6248_48646.column.amount.element[\'' + options.model.uid + '\'].style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_48646.column.secuential = {
                title: 'LOANS.LBL_LOANS_SECUENCLL_73798',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGPR_209750',
                element: []
            };
            $scope.vc.grids.QV_6248_48646.AT52_SECUENIA937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_48646.column.secuential.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGPR_209750",
                        'data-validation-code': "{{vc.viewState.QV_6248_48646.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_48646.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_6248_48646.column.secuential.decimals",
                        'ng-class': "vc.viewState.QV_6248_48646.column.secuential.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_48646.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJNU_401750',
                element: []
            };
            $scope.vc.grids.QV_6248_48646.AT70_GROUPIDD937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_48646.column.groupId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJNU_401750",
                        'data-validation-code': "{{vc.viewState.QV_6248_48646.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_48646.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_6248_48646.column.groupId.decimals",
                        'ng-class': "vc.viewState.QV_6248_48646.column.groupId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_48646.column.credit = {
                title: 'credit',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTMB_321750',
                element: []
            };
            $scope.vc.grids.QV_6248_48646.AT83_CREDITGM937 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_6248_48646.column.credit.element[\'' + options.model.uid + '\'].style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_48646.column.accountNumber = {
                title: 'LOANS.LBL_LOANS_CUENTAULH_13412',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSPK_553750',
                element: []
            };
            $scope.vc.grids.QV_6248_48646.AT80_ACCOUNRT937 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_6248_48646.column.accountNumber.element[\'' + options.model.uid + '\'].style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_48646.column.memberId = {
                title: 'memberId',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_48646.columns.push({
                    field: 'memberName',
                    title: '{{vc.viewState.QV_6248_48646.column.memberName.title|translate:vc.viewState.QV_6248_48646.column.memberName.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_48646.column.memberName.width,
                    format: $scope.vc.viewState.QV_6248_48646.column.memberName.format,
                    editor: $scope.vc.grids.QV_6248_48646.AT62_MEMBERNN937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_48646.column.memberName.element[dataItem.uid].style'>#if (memberName !== null) {# #=memberName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_48646.column.memberName.style",
                        "title": "{{vc.viewState.QV_6248_48646.column.memberName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_48646.column.memberName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_48646.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_6248_48646.column.amount.title|translate:vc.viewState.QV_6248_48646.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_48646.column.amount.width,
                    format: $scope.vc.viewState.QV_6248_48646.column.amount.format,
                    editor: $scope.vc.grids.QV_6248_48646.AT51_AMOUNTUQ937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_48646.column.amount.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_6248_48646\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_6248_48646.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_48646.column.amount.style",
                        "title": "{{vc.viewState.QV_6248_48646.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6248_48646.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_48646.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_6248_48646.column.secuential.title|translate:vc.viewState.QV_6248_48646.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_48646.column.secuential.width,
                    format: $scope.vc.viewState.QV_6248_48646.column.secuential.format,
                    editor: $scope.vc.grids.QV_6248_48646.AT52_SECUENIA937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_48646.column.secuential.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_6248_48646\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_6248_48646.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_48646.column.secuential.style",
                        "title": "{{vc.viewState.QV_6248_48646.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_48646.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_48646.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_6248_48646.column.groupId.title|translate:vc.viewState.QV_6248_48646.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_48646.column.groupId.width,
                    format: $scope.vc.viewState.QV_6248_48646.column.groupId.format,
                    editor: $scope.vc.grids.QV_6248_48646.AT70_GROUPIDD937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_48646.column.groupId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_6248_48646\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_6248_48646.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_48646.column.groupId.style",
                        "title": "{{vc.viewState.QV_6248_48646.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_48646.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_48646.columns.push({
                    field: 'credit',
                    title: '{{vc.viewState.QV_6248_48646.column.credit.title|translate:vc.viewState.QV_6248_48646.column.credit.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_48646.column.credit.width,
                    format: $scope.vc.viewState.QV_6248_48646.column.credit.format,
                    editor: $scope.vc.grids.QV_6248_48646.AT83_CREDITGM937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_48646.column.credit.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.credit, \"QV_6248_48646\", \"credit\"):kendo.toString(#=credit#, vc.viewState.QV_6248_48646.column.credit.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_48646.column.credit.style",
                        "title": "{{vc.viewState.QV_6248_48646.column.credit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_48646.column.credit.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_48646.columns.push({
                    field: 'accountNumber',
                    title: '{{vc.viewState.QV_6248_48646.column.accountNumber.title|translate:vc.viewState.QV_6248_48646.column.accountNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_48646.column.accountNumber.width,
                    format: $scope.vc.viewState.QV_6248_48646.column.accountNumber.format,
                    editor: $scope.vc.grids.QV_6248_48646.AT80_ACCOUNRT937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_48646.column.accountNumber.element[dataItem.uid].style'>#if (accountNumber !== null) {# #=accountNumber# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_48646.column.accountNumber.style",
                        "title": "{{vc.viewState.QV_6248_48646.column.accountNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_48646.column.accountNumber.hidden
                });
            }
            $scope.vc.viewState.QV_6248_48646.toolbar = {}
            $scope.vc.grids.QV_6248_48646.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_MEMBERACCOUUU_593_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_MEMBERACCOUUU_593_CANCEL",
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
                $scope.vc.render('VC_MEMBERACTN_894593');
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
    var cobisMainModule = cobis.createModule("VC_MEMBERACTN_894593", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_MEMBERACTN_894593", {
            templateUrl: "VC_MEMBERACTN_894593_FORM.html",
            controller: "VC_MEMBERACTN_894593_CTRL",
            label: "MemberAccountForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MEMBERACTN_894593?" + $.param(search);
            }
        });
        VC_MEMBERACTN_894593(cobisMainModule);
    }]);
} else {
    VC_MEMBERACTN_894593(cobisMainModule);
}