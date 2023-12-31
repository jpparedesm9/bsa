<!-- Designer Generator v 6.1.0 - release SPR 2016-20 14/10/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.valuedatemain = designerEvents.api.valuedatemain || designer.dsgEvents();

function VC_VALUEDATEN_586689(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_VALUEDATEN_586689_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_VALUEDATEN_586689_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)
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
            taskId: "T_VALUEDATEMINN_689",
            taskVersion: "1.0.0",
            viewContainerId: "VC_VALUEDATEN_586689",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_VALUEDATEMINN_689",
        designerEvents.api.valuedatemain,
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
                vcName: 'VC_VALUEDATEN_586689'
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
                    taskId: 'T_VALUEDATEMINN_689',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    LoanHeaderInfo: "LoanHeaderInfo",
                    ValueDateFilter: "ValueDateFilter",
                    TransactionLoan: "TransactionLoan"
                },
                entities: {
                    LoanHeaderInfo: {
                        loanID: 'AT78_LOANIDGX450',
                        loanBankID: 'AT10_LOANBANK450',
                        office: 'AT49_OFFICEJK450',
                        currencyName: 'AT91_CURRENME450',
                        manager: 'AT16_MANAGERR450',
                        expiration: 'AT51_EXPIRATO450',
                        loanAmount: 'AT52_LOANAMUN450',
                        customerName: 'AT15_CUSTOMMA450',
                        overduePayment: 'AT71_OVERDUAE450',
                        creditLine: 'AT86_CREDITEL450',
                        status: 'AT15_STATUSJD450',
                        _pks: [],
                        _entityId: 'EN_LOANHEAFD_450',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ValueDateFilter: {
                        valueDate: 'AT54_VALUEDET530',
                        _pks: [],
                        _entityId: 'EN_VALUEDAET_237',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    TransactionLoan: {
                        transactionId: 'AT69_TRANSAIO147',
                        secuential: 'AT35_SECUENTA193',
                        operation: 'AT66_OPERATII193',
                        dateTran: 'AT87_DATETRAN193',
                        dateRef: 'AT32_DATEREFF193',
                        user: 'AT63_USERDUKD193',
                        status: 'AT55_STATUSJB193',
                        _pks: [],
                        _entityId: 'EN_TRANSACOA_147',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_TRANSAIN_3698 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_TRANSAIN_3698 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TRANSAIN_3698_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_TRANSAIN_3698_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_TRANSACOA_147',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TRANSAIN_3698',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_TRANSAIN_3698_filters = {};
            defaultValues = {
                LoanHeaderInfo: {},
                ValueDateFilter: {},
                TransactionLoan: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (en in defaultValues) {
                    if (en == entityName) {
                        for (att in defaultValues[en]) {
                            if (att == attributeName) {
                                for (ch in defaultValues[en][att]) {
                                    if (ch == channel) {
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
                }
                $scope.vc.execute("temporarySave", null, data, function(response) {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    console.log("readTemporaryData");
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    }
                    return $scope.vc.executeService("readTemporaryData", null, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", null, data, function(response) {});
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
            $scope.vc.viewState.VC_VALUEDATEN_586689 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_VALUEDATEN_586689",
                hasId: true,
                componentStyle: "",
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_CCXRDSMKLS_138689",
                hasId: true,
                componentStyle: "",
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_EQBPJNIDUP_395316",
                hasId: true,
                componentStyle: "",
                label: 'LoanHeaderInfoForm',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.LoanHeaderInfo = {
                loanID: $scope.vc.channelDefaultValues("LoanHeaderInfo", "loanID"),
                loanBankID: $scope.vc.channelDefaultValues("LoanHeaderInfo", "loanBankID"),
                office: $scope.vc.channelDefaultValues("LoanHeaderInfo", "office"),
                currencyName: $scope.vc.channelDefaultValues("LoanHeaderInfo", "currencyName"),
                manager: $scope.vc.channelDefaultValues("LoanHeaderInfo", "manager"),
                expiration: $scope.vc.channelDefaultValues("LoanHeaderInfo", "expiration"),
                loanAmount: $scope.vc.channelDefaultValues("LoanHeaderInfo", "loanAmount"),
                customerName: $scope.vc.channelDefaultValues("LoanHeaderInfo", "customerName"),
                overduePayment: $scope.vc.channelDefaultValues("LoanHeaderInfo", "overduePayment"),
                creditLine: $scope.vc.channelDefaultValues("LoanHeaderInfo", "creditLine"),
                status: $scope.vc.channelDefaultValues("LoanHeaderInfo", "status")
            };
            //ViewState - Group: Group1223
            $scope.vc.createViewState({
                id: "G_LOANHEAIDE_212612",
                hasId: true,
                componentStyle: "",
                label: 'Group1223',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_425612",
                componentStyle: "control_input",
                label: "ASSTS.LBL_ASSTS_DATOSGEAA_74525",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATORZGZL_505612",
                componentStyle: "control_obligatorio",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: creditLine
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXINK_625612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_LINEACRDO_62384",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: office
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVIL_284612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: loanBankID
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQRB_506612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_PRESTAMOO_76935",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: currencyName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXBGG_553612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_MONEDATUB_92849",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: manager
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQCL_441612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_GERENTEHF_21281",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: expiration
            $scope.vc.createViewState({
                id: "VA_DATEFIELDZAZOWT_532612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_VENCIMINN_14254",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: loanAmount
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDZE_556612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_MONTOLANA_58184",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: overduePayment
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXOE_837612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_CUOTAVEAC_25304",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2311",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanHeaderInfo, Attribute: customerName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQEY_972612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1675",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ValueDateForm
            $scope.vc.createViewState({
                id: "VC_LGOODZDZHW_892861",
                hasId: true,
                componentStyle: "",
                label: 'ValueDateForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1159
            $scope.vc.createViewState({
                id: "G_VALUEDAETT_568866",
                hasId: true,
                componentStyle: "",
                label: 'GroupLayout1159',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ValueDateFilter = {
                valueDate: $scope.vc.channelDefaultValues("ValueDateFilter", "valueDate")
            };
            //ViewState - Group: Group2999
            $scope.vc.createViewState({
                id: "G_VALUEDATET_698866",
                hasId: true,
                componentStyle: "",
                label: 'Group2999',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1186",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2840",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValueDateFilter, Attribute: valueDate
            $scope.vc.createViewState({
                id: "VA_3610ZOUUEMDZQED_313866",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_FECHAVAOO_18147",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1288
            $scope.vc.createViewState({
                id: "G_VALUEDAETT_261866",
                hasId: true,
                componentStyle: "",
                label: 'Group1288',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.TransactionLoan = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    transactionId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "transactionId", 0),
                        validation: {
                            transactionIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "secuential", 0),
                        validation: {
                            secuentialRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    operation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "operation", ''),
                        validation: {
                            operationRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    dateTran: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "dateTran", new Date()),
                        validation: {
                            dateTranRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    dateRef: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "dateRef", new Date()),
                        validation: {
                            dateRefRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    user: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "user", ''),
                        validation: {
                            userRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    status: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "status", ''),
                        validation: {
                            statusRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.TransactionLoan = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_TRANSAIN_3698();
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
                    model: $scope.vc.types.TransactionLoan
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_3698_35484").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TRANSAIN_3698 = $scope.vc.model.TransactionLoan;
            $scope.vc.trackers.TransactionLoan = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.TransactionLoan);
            $scope.vc.model.TransactionLoan.bind('change', function(e) {
                $scope.vc.trackers.TransactionLoan.track(e);
            });
            $scope.vc.grids.QV_3698_35484 = {};
            $scope.vc.grids.QV_3698_35484.queryId = 'Q_TRANSAIN_3698';
            $scope.vc.viewState.QV_3698_35484 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3698_35484.column = {};
            $scope.vc.grids.QV_3698_35484.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.TransactionLoan.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3698_35484.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                    $scope.vc.gridDataBound("QV_3698_35484");
                    $scope.vc.hideShowColumns("QV_3698_35484", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3698_35484.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3698_35484.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_3698_35484.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3698_35484 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3698_35484 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3698_35484.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3698_35484.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3698_35484.column.transactionId = {
                title: 'transactionId',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXVJX_502866',
                element: []
            };
            $scope.vc.grids.QV_3698_35484.AT69_TRANSAIO147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.transactionId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVJX_502866",
                        'required': '',
                        'data-required-msg': 'transactionId' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_3698_35484.column.transactionId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3698_35484.column.transactionId.format",
                        'k-decimals': "vc.viewState.QV_3698_35484.column.transactionId.decimals",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,1",
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.transactionId.enabled",
                        'ng-class': "vc.viewState.QV_3698_35484.column.transactionId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3698_35484.column.secuential = {
                title: 'secuential',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXKRZ_568866',
                element: []
            };
            $scope.vc.grids.QV_3698_35484.AT35_SECUENTA193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.secuential.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKRZ_568866",
                        'required': '',
                        'data-required-msg': 'secuential' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_3698_35484.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3698_35484.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_3698_35484.column.secuential.decimals",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,1",
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.secuential.enabled",
                        'ng-class': "vc.viewState.QV_3698_35484.column.secuential.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3698_35484.column.operation = {
                title: 'operation',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXWQP_440866',
                element: []
            };
            $scope.vc.grids.QV_3698_35484.AT66_OPERATII193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.operation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWQP_440866",
                        'maxlength': 20,
                        'required': '',
                        'data-required-msg': 'operation' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_3698_35484.column.operation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,1",
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.operation.enabled",
                        'ng-class': "vc.viewState.QV_3698_35484.column.operation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3698_35484.column.dateTran = {
                title: 'dateTran',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_DATEFIELDHWBRMQ_311866',
                element: []
            };
            $scope.vc.grids.QV_3698_35484.AT87_DATETRAN193 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.dateTran.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDHWBRMQ_311866",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'required': '',
                        'data-required-msg': 'dateTran' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_3698_35484.column.dateTran.validationCode}}",
                        'required': "true",
                        'ng-class': "vc.viewState.QV_3698_35484.column.dateTran.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3698_35484.column.dateRef = {
                title: 'dateRef',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_DATEFIELDHWDPIY_849866',
                element: []
            };
            $scope.vc.grids.QV_3698_35484.AT32_DATEREFF193 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.dateRef.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDHWDPIY_849866",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'required': '',
                        'data-required-msg': 'dateRef' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_3698_35484.column.dateRef.validationCode}}",
                        'required': "true",
                        'ng-class': "vc.viewState.QV_3698_35484.column.dateRef.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3698_35484.column.user = {
                title: 'user',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXRPY_263866',
                element: []
            };
            $scope.vc.grids.QV_3698_35484.AT63_USERDUKD193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.user.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRPY_263866",
                        'maxlength': 14,
                        'required': '',
                        'data-required-msg': 'user' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_3698_35484.column.user.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,1",
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.user.enabled",
                        'ng-class': "vc.viewState.QV_3698_35484.column.user.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3698_35484.column.status = {
                title: 'status',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXHAU_772866',
                element: []
            };
            $scope.vc.grids.QV_3698_35484.AT55_STATUSJB193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.status.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHAU_772866",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': 'status' + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_3698_35484.column.status.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,1",
                        'ng-disabled': "!vc.viewState.QV_3698_35484.column.status.enabled",
                        'ng-class': "vc.viewState.QV_3698_35484.column.status.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3698_35484.columns.push({
                    field: 'transactionId',
                    title: '{{vc.viewState.QV_3698_35484.column.transactionId.title|translate:vc.viewState.QV_3698_35484.column.transactionId.titleArgs}}',
                    width: $scope.vc.viewState.QV_3698_35484.column.transactionId.width,
                    format: $scope.vc.viewState.QV_3698_35484.column.transactionId.format,
                    editor: $scope.vc.grids.QV_3698_35484.AT69_TRANSAIO147.control,
                    template: "<span ng-class='vc.viewState.QV_3698_35484.column.transactionId.element[dataItem.uid].style' ng-bind='kendo.toString(#=transactionId#, vc.viewState.QV_3698_35484.column.transactionId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3698_35484.column.transactionId.style",
                        "title": "{{vc.viewState.QV_3698_35484.column.transactionId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3698_35484.column.transactionId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3698_35484.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_3698_35484.column.secuential.title|translate:vc.viewState.QV_3698_35484.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_3698_35484.column.secuential.width,
                    format: $scope.vc.viewState.QV_3698_35484.column.secuential.format,
                    editor: $scope.vc.grids.QV_3698_35484.AT35_SECUENTA193.control,
                    template: "<span ng-class='vc.viewState.QV_3698_35484.column.secuential.element[dataItem.uid].style' ng-bind='kendo.toString(#=secuential#, vc.viewState.QV_3698_35484.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3698_35484.column.secuential.style",
                        "title": "{{vc.viewState.QV_3698_35484.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3698_35484.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3698_35484.columns.push({
                    field: 'operation',
                    title: '{{vc.viewState.QV_3698_35484.column.operation.title|translate:vc.viewState.QV_3698_35484.column.operation.titleArgs}}',
                    width: $scope.vc.viewState.QV_3698_35484.column.operation.width,
                    format: $scope.vc.viewState.QV_3698_35484.column.operation.format,
                    editor: $scope.vc.grids.QV_3698_35484.AT66_OPERATII193.control,
                    template: "<span ng-class='vc.viewState.QV_3698_35484.column.operation.element[dataItem.uid].style'>#if (operation !== null) {# #=operation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3698_35484.column.operation.style",
                        "title": "{{vc.viewState.QV_3698_35484.column.operation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3698_35484.column.operation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3698_35484.columns.push({
                    field: 'dateTran',
                    title: '{{vc.viewState.QV_3698_35484.column.dateTran.title|translate:vc.viewState.QV_3698_35484.column.dateTran.titleArgs}}',
                    width: $scope.vc.viewState.QV_3698_35484.column.dateTran.width,
                    format: $scope.vc.viewState.QV_3698_35484.column.dateTran.format,
                    editor: $scope.vc.grids.QV_3698_35484.AT87_DATETRAN193.control,
                    template: "<span ng-class='vc.viewState.QV_3698_35484.column.dateTran.element[dataItem.uid].style'>#=((dateTran !== null) ? kendo.toString(dateTran, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3698_35484.column.dateTran.style",
                        "title": "{{vc.viewState.QV_3698_35484.column.dateTran.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3698_35484.column.dateTran.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3698_35484.columns.push({
                    field: 'dateRef',
                    title: '{{vc.viewState.QV_3698_35484.column.dateRef.title|translate:vc.viewState.QV_3698_35484.column.dateRef.titleArgs}}',
                    width: $scope.vc.viewState.QV_3698_35484.column.dateRef.width,
                    format: $scope.vc.viewState.QV_3698_35484.column.dateRef.format,
                    editor: $scope.vc.grids.QV_3698_35484.AT32_DATEREFF193.control,
                    template: "<span ng-class='vc.viewState.QV_3698_35484.column.dateRef.element[dataItem.uid].style'>#=((dateRef !== null) ? kendo.toString(dateRef, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3698_35484.column.dateRef.style",
                        "title": "{{vc.viewState.QV_3698_35484.column.dateRef.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3698_35484.column.dateRef.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3698_35484.columns.push({
                    field: 'user',
                    title: '{{vc.viewState.QV_3698_35484.column.user.title|translate:vc.viewState.QV_3698_35484.column.user.titleArgs}}',
                    width: $scope.vc.viewState.QV_3698_35484.column.user.width,
                    format: $scope.vc.viewState.QV_3698_35484.column.user.format,
                    editor: $scope.vc.grids.QV_3698_35484.AT63_USERDUKD193.control,
                    template: "<span ng-class='vc.viewState.QV_3698_35484.column.user.element[dataItem.uid].style'>#if (user !== null) {# #=user# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3698_35484.column.user.style",
                        "title": "{{vc.viewState.QV_3698_35484.column.user.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3698_35484.column.user.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3698_35484.columns.push({
                    field: 'status',
                    title: '{{vc.viewState.QV_3698_35484.column.status.title|translate:vc.viewState.QV_3698_35484.column.status.titleArgs}}',
                    width: $scope.vc.viewState.QV_3698_35484.column.status.width,
                    format: $scope.vc.viewState.QV_3698_35484.column.status.format,
                    editor: $scope.vc.grids.QV_3698_35484.AT55_STATUSJB193.control,
                    template: "<span ng-class='vc.viewState.QV_3698_35484.column.status.element[dataItem.uid].style'>#if (status !== null) {# #=status# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3698_35484.column.status.style",
                        "title": "{{vc.viewState.QV_3698_35484.column.status.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3698_35484.column.status.hidden
                });
            }
            $scope.vc.viewState.QV_3698_35484.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_3698_35484.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_3698_35484.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_3698_35484.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_3698_35484.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_3698_35484.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_3698_35484.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_3698_35484.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_VALUEDAETT_261866.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_VALUEDATEMINN_689_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_VALUEDATEMINN_689_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_VALUEDAT_NNN",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_APLICARIP_57468",
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
                $scope.vc.render('VC_VALUEDATEN_586689');
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
    var cobisMainModule = cobis.createModule("VC_VALUEDATEN_586689", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_VALUEDATEN_586689", {
            templateUrl: "VC_VALUEDATEN_586689_FORM.html",
            controller: "VC_VALUEDATEN_586689_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_VALUEDATEN_586689?" + $.param(search);
            }
        });
        VC_VALUEDATEN_586689(cobisMainModule);
    }]);
} else {
    VC_VALUEDATEN_586689(cobisMainModule);
}