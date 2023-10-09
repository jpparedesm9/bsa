//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.bankaccountslistform = designerEvents.api.bankaccountslistform || designer.dsgEvents();

function VC_BANKACCOTT_940944(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_BANKACCOTT_940944_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_BANKACCOTT_940944_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "TRNSC",
            taskId: "T_BANKACCOUNTIS_944",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BANKACCOTT_940944",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_BANKACCOUNTIS_944",
        designerEvents.api.bankaccountslistform,
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
                vcName: 'VC_BANKACCOTT_940944'
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
                    subModuleId: 'TRNSC',
                    taskId: 'T_BANKACCOUNTIS_944',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    BankAccount: "BankAccount",
                    Payment: "Payment"
                },
                entities: {
                    BankAccount: {
                        account: 'AT42_ACCOUNTT291',
                        customerCode: 'AT47_CUSTOMEO291',
                        accountName: 'AT53_ACCOUNNN291',
                        _pks: [],
                        _entityId: 'EN_BANKACCNN_291',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Payment: {
                        amount: 'AT10_AMOUNTQX669',
                        referencedAccount: 'AT11_REFERECA669',
                        retention: 'AT18_RETENTNN669',
                        customerID: 'AT19_CUSTOMED669',
                        reductionType: 'AT21_REDUCTIP669',
                        user: 'AT31_USERGUMY669',
                        paymentType: 'AT32_PAYMENTS669',
                        category: 'AT35_CLASSCHA669',
                        date: 'AT37_DATEIISZ669',
                        collectionType: 'AT39_COLLECOT669',
                        entireFee: 'AT44_ENTIREEE669',
                        quotationValue: 'AT45_QUOTATOI669',
                        payQuotationValue: 'AT46_LEFTOVTT669',
                        reference: 'AT46_REFERECN669',
                        currencyType: 'AT53_CURRENCY669',
                        numCheck: 'AT54_NUMCHEKC669',
                        finePrepayment: 'AT60_FINEPRAN669',
                        operationCurrencyType: 'AT61_OPERATRE669',
                        value: 'AT62_VALUEGQO669',
                        datePay: 'AT68_DATEPAYY669',
                        querySequential: 'AT68_SEQUENAT669',
                        advance: 'AT70_ADVANCEE669',
                        quotation: 'AT73_QUOTATIN669',
                        sequential: 'AT74_SEQUENIT669',
                        customer: 'AT77_CUSTOMEE669',
                        amountPrepayment: 'AT83_AMOUNTER669',
                        bank: 'AT86_BANKCZUQ669',
                        onLine: 'AT87_ONLINEZV669',
                        sequentialPay: 'AT89_SEQUENPI669',
                        status: 'AT89_STATUSVP669',
                        regional: 'AT95_REGIONLL669',
                        billTo: 'AT96_BILLTOST669',
                        note: 'AT99_NOTESOKT669',
                        prepayRate: 'AT99_PREPAYEE669',
                        _pks: [],
                        _entityId: 'EN_PAYMENTZY_669',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_BANKACUC_1987 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_BANKACUC_1987 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_BANKACUC_1987_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_BANKACUC_1987_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_BANKACCNN_291',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_BANKACUC_1987',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_BANKACUC_1987_filters = {};
            var defaultValues = {
                BankAccount: {},
                Payment: {}
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
                $scope.vc.execute("temporarySave", VC_BANKACCOTT_940944, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_BANKACCOTT_940944, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_BANKACCOTT_940944, data, function() {});
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
            $scope.vc.viewState.VC_BANKACCOTT_940944 = {
                style: []
            }
            //ViewState - Group: Group1906
            $scope.vc.createViewState({
                id: "G_BANKACCTTS_177561",
                hasId: true,
                componentStyle: [],
                label: 'Group1906',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.BankAccount = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    account: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("BankAccount", "account", '')
                    },
                    customerCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("BankAccount", "customerCode", 0)
                    },
                    accountName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("BankAccount", "accountName", '')
                    }
                }
            });
            $scope.vc.model.BankAccount = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_BANKACUC_1987();
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
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.BankAccount
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1987_42894").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_BANKACUC_1987 = $scope.vc.model.BankAccount;
            $scope.vc.trackers.BankAccount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.BankAccount);
            $scope.vc.model.BankAccount.bind('change', function(e) {
                $scope.vc.trackers.BankAccount.track(e);
            });
            $scope.vc.grids.QV_1987_42894 = {};
            $scope.vc.grids.QV_1987_42894.queryId = 'Q_BANKACUC_1987';
            $scope.vc.viewState.QV_1987_42894 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1987_42894.column = {};
            $scope.vc.grids.QV_1987_42894.editable = false;
            $scope.vc.grids.QV_1987_42894.events = {
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
                    $scope.vc.trackers.BankAccount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1987_42894.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_1987_42894");
                    $scope.vc.hideShowColumns("QV_1987_42894", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1987_42894.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1987_42894.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1987_42894.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1987_42894 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1987_42894 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_1987_42894.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_1987_42894.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_1987_42894.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "BankAccount",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_1987_42894", args);
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
            $scope.vc.grids.QV_1987_42894.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1987_42894.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1987_42894.column.account = {
                title: 'ASSTS.LBL_ASSTS_CUENTADIA_22037',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSGC_732561',
                element: []
            };
            $scope.vc.grids.QV_1987_42894.AT42_ACCOUNTT291 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1987_42894.column.account.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSGC_732561",
                        'data-validation-code': "{{vc.viewState.QV_1987_42894.column.account.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1987_42894.column.account.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1987_42894.column.customerCode = {
                title: 'ASSTS.LBL_ASSTS_CLIENTEWV_22561',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTWF_198561',
                element: []
            };
            $scope.vc.grids.QV_1987_42894.AT47_CUSTOMEO291 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1987_42894.column.customerCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTWF_198561",
                        'data-validation-code': "{{vc.viewState.QV_1987_42894.column.customerCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1987_42894.column.customerCode.format",
                        'k-decimals': "vc.viewState.QV_1987_42894.column.customerCode.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1987_42894.column.customerCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1987_42894.column.accountName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREULS_81822',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGBN_738561',
                element: []
            };
            $scope.vc.grids.QV_1987_42894.AT53_ACCOUNNN291 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1987_42894.column.accountName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGBN_738561",
                        'data-validation-code': "{{vc.viewState.QV_1987_42894.column.accountName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1987_42894.column.accountName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1987_42894.columns.push({
                    field: 'account',
                    title: '{{vc.viewState.QV_1987_42894.column.account.title|translate:vc.viewState.QV_1987_42894.column.account.titleArgs}}',
                    width: $scope.vc.viewState.QV_1987_42894.column.account.width,
                    format: $scope.vc.viewState.QV_1987_42894.column.account.format,
                    editor: $scope.vc.grids.QV_1987_42894.AT42_ACCOUNTT291.control,
                    template: "<span ng-class='vc.viewState.QV_1987_42894.column.account.style' ng-bind='vc.getStringColumnFormat(dataItem.account, \"QV_1987_42894\", \"account\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1987_42894.column.account.style",
                        "title": "{{vc.viewState.QV_1987_42894.column.account.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1987_42894.column.account.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1987_42894.columns.push({
                    field: 'customerCode',
                    title: '{{vc.viewState.QV_1987_42894.column.customerCode.title|translate:vc.viewState.QV_1987_42894.column.customerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_1987_42894.column.customerCode.width,
                    format: $scope.vc.viewState.QV_1987_42894.column.customerCode.format,
                    editor: $scope.vc.grids.QV_1987_42894.AT47_CUSTOMEO291.control,
                    template: "<span ng-class='vc.viewState.QV_1987_42894.column.customerCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerCode, \"QV_1987_42894\", \"customerCode\"):kendo.toString(#=customerCode#, vc.viewState.QV_1987_42894.column.customerCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1987_42894.column.customerCode.style",
                        "title": "{{vc.viewState.QV_1987_42894.column.customerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1987_42894.column.customerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1987_42894.columns.push({
                    field: 'accountName',
                    title: '{{vc.viewState.QV_1987_42894.column.accountName.title|translate:vc.viewState.QV_1987_42894.column.accountName.titleArgs}}',
                    width: $scope.vc.viewState.QV_1987_42894.column.accountName.width,
                    format: $scope.vc.viewState.QV_1987_42894.column.accountName.format,
                    editor: $scope.vc.grids.QV_1987_42894.AT53_ACCOUNNN291.control,
                    template: "<span ng-class='vc.viewState.QV_1987_42894.column.accountName.style' ng-bind='vc.getStringColumnFormat(dataItem.accountName, \"QV_1987_42894\", \"accountName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1987_42894.column.accountName.style",
                        "title": "{{vc.viewState.QV_1987_42894.column.accountName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1987_42894.column.accountName.hidden
                });
            }
            $scope.vc.viewState.QV_1987_42894.toolbar = {}
            $scope.vc.grids.QV_1987_42894.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BANKACCOUNTIS_944_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BANKACCOUNTIS_944_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Payment = {
                amount: $scope.vc.channelDefaultValues("Payment", "amount"),
                referencedAccount: $scope.vc.channelDefaultValues("Payment", "referencedAccount"),
                retention: $scope.vc.channelDefaultValues("Payment", "retention"),
                customerID: $scope.vc.channelDefaultValues("Payment", "customerID"),
                reductionType: $scope.vc.channelDefaultValues("Payment", "reductionType"),
                user: $scope.vc.channelDefaultValues("Payment", "user"),
                paymentType: $scope.vc.channelDefaultValues("Payment", "paymentType"),
                category: $scope.vc.channelDefaultValues("Payment", "category"),
                date: $scope.vc.channelDefaultValues("Payment", "date"),
                collectionType: $scope.vc.channelDefaultValues("Payment", "collectionType"),
                entireFee: $scope.vc.channelDefaultValues("Payment", "entireFee"),
                quotationValue: $scope.vc.channelDefaultValues("Payment", "quotationValue"),
                payQuotationValue: $scope.vc.channelDefaultValues("Payment", "payQuotationValue"),
                reference: $scope.vc.channelDefaultValues("Payment", "reference"),
                currencyType: $scope.vc.channelDefaultValues("Payment", "currencyType"),
                numCheck: $scope.vc.channelDefaultValues("Payment", "numCheck"),
                finePrepayment: $scope.vc.channelDefaultValues("Payment", "finePrepayment"),
                operationCurrencyType: $scope.vc.channelDefaultValues("Payment", "operationCurrencyType"),
                value: $scope.vc.channelDefaultValues("Payment", "value"),
                datePay: $scope.vc.channelDefaultValues("Payment", "datePay"),
                querySequential: $scope.vc.channelDefaultValues("Payment", "querySequential"),
                advance: $scope.vc.channelDefaultValues("Payment", "advance"),
                quotation: $scope.vc.channelDefaultValues("Payment", "quotation"),
                sequential: $scope.vc.channelDefaultValues("Payment", "sequential"),
                customer: $scope.vc.channelDefaultValues("Payment", "customer"),
                amountPrepayment: $scope.vc.channelDefaultValues("Payment", "amountPrepayment"),
                bank: $scope.vc.channelDefaultValues("Payment", "bank"),
                onLine: $scope.vc.channelDefaultValues("Payment", "onLine"),
                sequentialPay: $scope.vc.channelDefaultValues("Payment", "sequentialPay"),
                status: $scope.vc.channelDefaultValues("Payment", "status"),
                regional: $scope.vc.channelDefaultValues("Payment", "regional"),
                billTo: $scope.vc.channelDefaultValues("Payment", "billTo"),
                note: $scope.vc.channelDefaultValues("Payment", "note"),
                prepayRate: $scope.vc.channelDefaultValues("Payment", "prepayRate")
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
                $scope.vc.render('VC_BANKACCOTT_940944');
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
    var cobisMainModule = cobis.createModule("VC_BANKACCOTT_940944", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_BANKACCOTT_940944", {
            templateUrl: "VC_BANKACCOTT_940944_FORM.html",
            controller: "VC_BANKACCOTT_940944_CTRL",
            label: "BankAccountsListForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_BANKACCOTT_940944?" + $.param(search);
            }
        });
        VC_BANKACCOTT_940944(cobisMainModule);
    }]);
} else {
    VC_BANKACCOTT_940944(cobisMainModule);
}