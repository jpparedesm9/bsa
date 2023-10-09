//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.reportsettlementsheet = designerEvents.api.reportsettlementsheet || designer.dsgEvents();

function VC_REPORTSEEL_593126(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REPORTSEEL_593126_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REPORTSEEL_593126_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "LOANS",
            subModuleId: "GROUP",
            taskId: "T_REPORTSETTEET_126",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REPORTSEEL_593126",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_REPORTSETTEET_126",
        designerEvents.api.reportsettlementsheet,
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
                vcName: 'VC_REPORTSEEL_593126'
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
                    taskId: 'T_REPORTSETTEET_126',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    GeneralInformation: "GeneralInformation",
                    ClearanceSheet: "ClearanceSheet",
                    CreditHeader: "CreditHeader"
                },
                entities: {
                    GeneralInformation: {
                        datePayment: 'AT11_DATEPANN872',
                        currentCycle: 'AT18_CURRENCY872',
                        branchOffice: 'AT26_BRANCHFC872',
                        groupName: 'AT40_GROUPNMA872',
                        currentDate: 'AT56_CURRENDA872',
                        code: 'AT81_CODEAHBG872',
                        amountApproved: 'AT88_AMOUNTVP872',
                        _pks: [],
                        _entityId: 'EN_GENERALIN_872',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ClearanceSheet: {
                        amountApproved: 'AT17_AMOUNTEA795',
                        signature: 'AT20_SIGNATUE795',
                        incentive: 'AT22_INCENTEI795',
                        nameCustomer: 'AT25_NAMECUEE795',
                        valuesDiscounting: 'AT28_VALUESIS795',
                        loan: 'AT31_LOANMPSG795',
                        numberClearance: 'AT32_NUMBERTT795',
                        checkClearance: 'AT49_CHECKCRE795',
                        netToDeliver: 'AT59_NETTODIE795',
                        saving: 'AT91_SAVINGUU795',
                        _pks: [],
                        _entityId: 'EN_CLEARANTC_795',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CreditHeader: {
                        creditCode: 'AT25_CREDITCD216',
                        _pks: [],
                        _entityId: 'EN_CREDITHAD_216',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CLEARATE_4247 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_CLEARATE_4247 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CLEARATE_4247_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CLEARATE_4247_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CLEARANTC_795',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CLEARATE_4247',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_CLEARATE_4247_filters = {};
            var defaultValues = {
                GeneralInformation: {},
                ClearanceSheet: {},
                CreditHeader: {}
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
                $scope.vc.execute("temporarySave", VC_REPORTSEEL_593126, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REPORTSEEL_593126, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REPORTSEEL_593126, data, function() {});
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
            $scope.vc.viewState.VC_REPORTSEEL_593126 = {
                style: []
            }
            //ViewState - Group: GroupLayout1258
            $scope.vc.createViewState({
                id: "G_REPORTSTTE_334621",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1258',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GeneralInformation = {
                datePayment: $scope.vc.channelDefaultValues("GeneralInformation", "datePayment"),
                currentCycle: $scope.vc.channelDefaultValues("GeneralInformation", "currentCycle"),
                branchOffice: $scope.vc.channelDefaultValues("GeneralInformation", "branchOffice"),
                groupName: $scope.vc.channelDefaultValues("GeneralInformation", "groupName"),
                currentDate: $scope.vc.channelDefaultValues("GeneralInformation", "currentDate"),
                code: $scope.vc.channelDefaultValues("GeneralInformation", "code"),
                amountApproved: $scope.vc.channelDefaultValues("GeneralInformation", "amountApproved")
            };
            //ViewState - Group: Group1430
            $scope.vc.createViewState({
                id: "G_REPORTSEHE_224621",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DATOSGESA_62520",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2395",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2746",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralInformation, Attribute: currentDate
            $scope.vc.createViewState({
                id: "VA_CURRENTDATEBVTX_245621",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_FECHAZYFY_49226",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralInformation, Attribute: datePayment
            $scope.vc.createViewState({
                id: "VA_DATEPAYMENTEXYR_819621",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_FECHADEAG_89558",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralInformation, Attribute: groupName
            $scope.vc.createViewState({
                id: "VA_GROUPNAMECDIURB_985621",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GRUPOFMZP_63595",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralInformation, Attribute: code
            $scope.vc.createViewState({
                id: "VA_CODEEOKPJDVJIMO_201621",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CODQVMICS_83431",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralInformation, Attribute: amountApproved
            $scope.vc.createViewState({
                id: "VA_AMOUNTAPPROVDDE_369621",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MONTOFIDO_37749",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralInformation, Attribute: currentCycle
            $scope.vc.createViewState({
                id: "VA_CURRENTCYCLESTD_415621",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CICLOACAT_37911",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralInformation, Attribute: branchOffice
            $scope.vc.createViewState({
                id: "VA_BRANCHOFFICENRI_879621",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SUCURSALL_74727",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2495
            $scope.vc.createViewState({
                id: "G_REPORTSMSE_134621",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_HOJADELAI_23835",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ClearanceSheet = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    numberClearance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "numberClearance", 0)
                    },
                    loan: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "loan", '')
                    },
                    nameCustomer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "nameCustomer", '')
                    },
                    amountApproved: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "amountApproved", 0)
                    },
                    valuesDiscounting: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "valuesDiscounting", 0)
                    },
                    saving: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "saving", 0)
                    },
                    incentive: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "incentive", 0)
                    },
                    netToDeliver: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "netToDeliver", '')
                    },
                    checkClearance: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "checkClearance", '')
                    },
                    signature: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ClearanceSheet", "signature", '')
                    }
                }
            });
            $scope.vc.model.ClearanceSheet = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_CLEARATE_4247();
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
                    model: $scope.vc.types.ClearanceSheet
                },
                aggregate: [{
                    field: "loan",
                    aggregate: "sum"
                }, {
                    field: "amountApproved",
                    aggregate: "sum"
                }, {
                    field: "valuesDiscounting",
                    aggregate: "sum"
                }, {
                    field: "incentive",
                    aggregate: "sum"
                }, {
                    field: "netToDeliver",
                    aggregate: "sum"
                }, {
                    field: "checkClearance",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_4247_30477").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CLEARATE_4247 = $scope.vc.model.ClearanceSheet;
            $scope.vc.trackers.ClearanceSheet = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ClearanceSheet);
            $scope.vc.model.ClearanceSheet.bind('change', function(e) {
                $scope.vc.trackers.ClearanceSheet.track(e);
            });
            $scope.vc.grids.QV_4247_30477 = {};
            $scope.vc.grids.QV_4247_30477.queryId = 'Q_CLEARATE_4247';
            $scope.vc.viewState.QV_4247_30477 = {
                style: undefined
            };
            $scope.vc.viewState.QV_4247_30477.column = {};
            $scope.vc.grids.QV_4247_30477.editable = false;
            $scope.vc.grids.QV_4247_30477.events = {
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
                    $scope.vc.trackers.ClearanceSheet.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_4247_30477.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_4247_30477");
                    $scope.vc.hideShowColumns("QV_4247_30477", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_4247_30477.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_4247_30477.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_4247_30477.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_4247_30477 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_4247_30477 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_4247_30477.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_4247_30477.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_4247_30477.column.numberClearance = {
                title: 'LOANS.LBL_LOANS_NONZKWIFJ_17599',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJRT_917621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT32_NUMBERTT795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.numberClearance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJRT_917621",
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.numberClearance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4247_30477.column.numberClearance.format",
                        'k-decimals': "vc.viewState.QV_4247_30477.column.numberClearance.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.numberClearance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.loan = {
                title: 'LOANS.LBL_LOANS_PRESTAMOO_25395',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRLN_836621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT31_LOANMPSG795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.loan.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRLN_836621",
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.loan.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.loan.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.nameCustomer = {
                title: 'LOANS.LBL_LOANS_NOMBREDTT_75067',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZPW_758621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT25_NAMECUEE795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.nameCustomer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZPW_758621",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.nameCustomer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.nameCustomer.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.amountApproved = {
                title: 'LOANS.LBL_LOANS_MONTOAPBA_77860',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPYG_793621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT17_AMOUNTEA795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.amountApproved.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPYG_793621",
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.amountApproved.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4247_30477.column.amountApproved.format",
                        'k-decimals': "vc.viewState.QV_4247_30477.column.amountApproved.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.amountApproved.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.valuesDiscounting = {
                title: 'LOANS.LBL_LOANS_VALORESTN_65974',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFUC_278621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT28_VALUESIS795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.valuesDiscounting.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFUC_278621",
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.valuesDiscounting.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4247_30477.column.valuesDiscounting.format",
                        'k-decimals': "vc.viewState.QV_4247_30477.column.valuesDiscounting.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.valuesDiscounting.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.saving = {
                title: 'LOANS.LBL_LOANS_AHORROBBN_66457',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNSC_400621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT91_SAVINGUU795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.saving.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNSC_400621",
                        'maxlength': 33,
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.saving.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4247_30477.column.saving.format",
                        'k-decimals': "vc.viewState.QV_4247_30477.column.saving.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.saving.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.incentive = {
                title: 'LOANS.LBL_LOANS_INCENTIVV_16143',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGYL_440621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT22_INCENTEI795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.incentive.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGYL_440621",
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.incentive.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4247_30477.column.incentive.format",
                        'k-decimals': "vc.viewState.QV_4247_30477.column.incentive.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.incentive.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.netToDeliver = {
                title: 'LOANS.LBL_LOANS_NETOAENER_17039',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIPQ_975621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT59_NETTODIE795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.netToDeliver.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIPQ_975621",
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.netToDeliver.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.netToDeliver.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.checkClearance = {
                title: 'LOANS.LBL_LOANS_CHEQUEDNC_43613',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUIH_686621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT49_CHECKCRE795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.checkClearance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUIH_686621",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.checkClearance.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.checkClearance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4247_30477.column.signature = {
                title: 'LOANS.LBL_LOANS_FIRMAZCJA_18267',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTFL_970621',
                element: []
            };
            $scope.vc.grids.QV_4247_30477.AT20_SIGNATUE795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4247_30477.column.signature.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTFL_970621",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_4247_30477.column.signature.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REPORTSTTE_334621,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4247_30477.column.signature.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'numberClearance',
                    title: '{{vc.viewState.QV_4247_30477.column.numberClearance.title|translate:vc.viewState.QV_4247_30477.column.numberClearance.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.numberClearance.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.numberClearance.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT32_NUMBERTT795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.numberClearance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numberClearance, \"QV_4247_30477\", \"numberClearance\"):kendo.toString(#=numberClearance#, vc.viewState.QV_4247_30477.column.numberClearance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4247_30477.column.numberClearance.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.numberClearance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.numberClearance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'loan',
                    title: '{{vc.viewState.QV_4247_30477.column.loan.title|translate:vc.viewState.QV_4247_30477.column.loan.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.loan.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.loan.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT31_LOANMPSG795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.loan.style' ng-bind='vc.getStringColumnFormat(dataItem.loan, \"QV_4247_30477\", \"loan\")'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.loan.sum, $scope.vc.viewState.QV_4247_30477.column.loan.format);
                        return "<div class='' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4247_30477.column.loan.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.loan.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.loan.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'nameCustomer',
                    title: '{{vc.viewState.QV_4247_30477.column.nameCustomer.title|translate:vc.viewState.QV_4247_30477.column.nameCustomer.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.nameCustomer.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.nameCustomer.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT25_NAMECUEE795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.nameCustomer.style' ng-bind='vc.getStringColumnFormat(dataItem.nameCustomer, \"QV_4247_30477\", \"nameCustomer\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4247_30477.column.nameCustomer.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.nameCustomer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.nameCustomer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'amountApproved',
                    title: '{{vc.viewState.QV_4247_30477.column.amountApproved.title|translate:vc.viewState.QV_4247_30477.column.amountApproved.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.amountApproved.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.amountApproved.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT17_AMOUNTEA795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.amountApproved.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amountApproved, \"QV_4247_30477\", \"amountApproved\"):kendo.toString(#=amountApproved#, vc.viewState.QV_4247_30477.column.amountApproved.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.amountApproved.sum, $scope.vc.viewState.QV_4247_30477.column.amountApproved.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4247_30477.column.amountApproved.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.amountApproved.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.amountApproved.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'valuesDiscounting',
                    title: '{{vc.viewState.QV_4247_30477.column.valuesDiscounting.title|translate:vc.viewState.QV_4247_30477.column.valuesDiscounting.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.valuesDiscounting.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.valuesDiscounting.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT28_VALUESIS795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.valuesDiscounting.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valuesDiscounting, \"QV_4247_30477\", \"valuesDiscounting\"):kendo.toString(#=valuesDiscounting#, vc.viewState.QV_4247_30477.column.valuesDiscounting.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.valuesDiscounting.sum, $scope.vc.viewState.QV_4247_30477.column.valuesDiscounting.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4247_30477.column.valuesDiscounting.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.valuesDiscounting.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.valuesDiscounting.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'saving',
                    title: '{{vc.viewState.QV_4247_30477.column.saving.title|translate:vc.viewState.QV_4247_30477.column.saving.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.saving.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.saving.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT91_SAVINGUU795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.saving.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.saving, \"QV_4247_30477\", \"saving\"):kendo.toString(#=saving#, vc.viewState.QV_4247_30477.column.saving.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4247_30477.column.saving.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.saving.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.saving.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'incentive',
                    title: '{{vc.viewState.QV_4247_30477.column.incentive.title|translate:vc.viewState.QV_4247_30477.column.incentive.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.incentive.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.incentive.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT22_INCENTEI795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.incentive.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.incentive, \"QV_4247_30477\", \"incentive\"):kendo.toString(#=incentive#, vc.viewState.QV_4247_30477.column.incentive.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.incentive.sum, $scope.vc.viewState.QV_4247_30477.column.incentive.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4247_30477.column.incentive.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.incentive.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.incentive.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'netToDeliver',
                    title: '{{vc.viewState.QV_4247_30477.column.netToDeliver.title|translate:vc.viewState.QV_4247_30477.column.netToDeliver.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.netToDeliver.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.netToDeliver.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT59_NETTODIE795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.netToDeliver.style' ng-bind='vc.getStringColumnFormat(dataItem.netToDeliver, \"QV_4247_30477\", \"netToDeliver\")'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.netToDeliver.sum, $scope.vc.viewState.QV_4247_30477.column.netToDeliver.format);
                        return "<div class='' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4247_30477.column.netToDeliver.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.netToDeliver.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.netToDeliver.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'checkClearance',
                    title: '{{vc.viewState.QV_4247_30477.column.checkClearance.title|translate:vc.viewState.QV_4247_30477.column.checkClearance.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.checkClearance.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.checkClearance.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT49_CHECKCRE795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.checkClearance.style' ng-bind='vc.getStringColumnFormat(dataItem.checkClearance, \"QV_4247_30477\", \"checkClearance\")'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.checkClearance.sum, $scope.vc.viewState.QV_4247_30477.column.checkClearance.format);
                        return "<div class='' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4247_30477.column.checkClearance.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.checkClearance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.checkClearance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4247_30477.columns.push({
                    field: 'signature',
                    title: '{{vc.viewState.QV_4247_30477.column.signature.title|translate:vc.viewState.QV_4247_30477.column.signature.titleArgs}}',
                    width: $scope.vc.viewState.QV_4247_30477.column.signature.width,
                    format: $scope.vc.viewState.QV_4247_30477.column.signature.format,
                    editor: $scope.vc.grids.QV_4247_30477.AT20_SIGNATUE795.control,
                    template: "<span ng-class='vc.viewState.QV_4247_30477.column.signature.style' ng-bind='vc.getStringColumnFormat(dataItem.signature, \"QV_4247_30477\", \"signature\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4247_30477.column.signature.style",
                        "title": "{{vc.viewState.QV_4247_30477.column.signature.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4247_30477.column.signature.hidden
                });
            }
            $scope.vc.viewState.QV_4247_30477.toolbar = {}
            $scope.vc.grids.QV_4247_30477.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_REPORTSETTEET_126_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_REPORTSETTEET_126_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CreditHeader = {
                creditCode: $scope.vc.channelDefaultValues("CreditHeader", "creditCode")
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
                $scope.vc.render('VC_REPORTSEEL_593126');
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
    var cobisMainModule = cobis.createModule("VC_REPORTSEEL_593126", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_REPORTSEEL_593126", {
            templateUrl: "VC_REPORTSEEL_593126_FORM.html",
            controller: "VC_REPORTSEEL_593126_CTRL",
            label: "ReportSettlementSheet",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REPORTSEEL_593126?" + $.param(search);
            }
        });
        VC_REPORTSEEL_593126(cobisMainModule);
    }]);
} else {
    VC_REPORTSEEL_593126(cobisMainModule);
}