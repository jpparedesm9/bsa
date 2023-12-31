//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.refinanceloansfilter = designerEvents.api.refinanceloansfilter || designer.dsgEvents();

function VC_REFINANCSL_902781(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REFINANCSL_902781_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REFINANCSL_902781_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_REFINANCELISS_781",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REFINANCSL_902781",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_REFINANCELISS_781",
        designerEvents.api.refinanceloansfilter,
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
                vcName: 'VC_REFINANCSL_902781'
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
                    taskId: 'T_REFINANCELISS_781',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    RefinanceLoanFilter: "RefinanceLoanFilter",
                    RefinanceLoans: "RefinanceLoans"
                },
                entities: {
                    RefinanceLoanFilter: {
                        addicionalPayMethod: 'AT10_ADDICIAP619',
                        currencyTypeAux: 'AT10_CURRENYP619',
                        interestBalance: 'AT11_INTEREAT619',
                        arrearsBalance: 'AT12_ARREARNE619',
                        additionalValue: 'AT14_ADDITILL619',
                        clientName: 'AT14_CLIENTEN619',
                        refreshData: 'AT15_REFRESHA619',
                        operation: 'AT20_OPERATII619',
                        currencyType: 'AT25_CURRENPC619',
                        periodicity: 'AT29_PERIODII619',
                        totalRefinance: 'AT30_TOTALRNI619',
                        account: 'AT52_ACCOUNTT619',
                        newLoanCurrency: 'AT52_NEWLOARY619',
                        payMethodCurrency: 'AT52_PAYMETCN619',
                        capitalBalance: 'AT53_CAPITALA619',
                        newLoanLabel: 'AT65_NEWLOAEL619',
                        otherBalance: 'AT71_OTHERBCL619',
                        overDue: 'AT79_OVERDUEE619',
                        operationType: 'AT80_OPERATYT619',
                        aditionalBalance: 'AT82_ADITIOBC619',
                        newLoanTerm: 'AT88_NEWLOAMM619',
                        clientID: 'AT96_CLIENTDD619',
                        _pks: [],
                        _entityId: 'EN_REFINANCA_619',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RefinanceLoans: {
                        loan: 'AT67_LOANWAUS582',
                        line: 'AT78_LINEUGLL582',
                        initialAmount: 'AT34_INITIAAA582',
                        totalToRefinance: 'AT94_TOTALTCA582',
                        totalBalance: 'AT16_TOTALBCN582',
                        currencyCode: 'AT55_CURRENDE582',
                        quotation: 'AT54_QUOTATNO582',
                        transactionID: 'AT25_TRANSANC582',
                        officialID: 'AT85_OFFICIDL582',
                        originalTerm: 'AT35_ORIGINAT582',
                        capitalBalance: 'AT89_CAPITABA582',
                        interestBalance: 'AT86_INTEREAA582',
                        defaultBalance: 'AT59_DEFAULCN582',
                        otherConceptsBalance: 'AT25_OTHERCAA582',
                        residualTerm: 'AT97_RESIDURR582',
                        loanStatus: 'AT33_LOANSTUA582',
                        currencyType: 'AT34_CURRENCP582',
                        overdueFees: 'AT30_OVERDUSE582',
                        _pks: [],
                        _entityId: 'EN_REFINANLC_582',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_REFINAAA_3375 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_REFINAAA_3375 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_REFINAAA_3375_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_REFINAAA_3375_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_REFINANLC_582',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_REFINAAA_3375',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_REFINAAA_3375_filters = {};
            var defaultValues = {
                RefinanceLoanFilter: {},
                RefinanceLoans: {}
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
                $scope.vc.execute("temporarySave", VC_REFINANCSL_902781, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REFINANCSL_902781, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REFINANCSL_902781, data, function() {});
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
            $scope.vc.viewState.VC_REFINANCSL_902781 = {
                style: []
            }
            //ViewState - Group: GroupLayout1343
            $scope.vc.createViewState({
                id: "G_REFINANSER_157515",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1343',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.RefinanceLoanFilter = {
                addicionalPayMethod: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "addicionalPayMethod"),
                currencyTypeAux: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "currencyTypeAux"),
                interestBalance: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "interestBalance"),
                arrearsBalance: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "arrearsBalance"),
                additionalValue: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "additionalValue"),
                clientName: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "clientName"),
                refreshData: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "refreshData"),
                operation: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "operation"),
                currencyType: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "currencyType"),
                periodicity: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "periodicity"),
                totalRefinance: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "totalRefinance"),
                account: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "account"),
                newLoanCurrency: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "newLoanCurrency"),
                payMethodCurrency: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "payMethodCurrency"),
                capitalBalance: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "capitalBalance"),
                newLoanLabel: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "newLoanLabel"),
                otherBalance: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "otherBalance"),
                overDue: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "overDue"),
                operationType: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "operationType"),
                aditionalBalance: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "aditionalBalance"),
                newLoanTerm: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "newLoanTerm"),
                clientID: $scope.vc.channelDefaultValues("RefinanceLoanFilter", "clientID")
            };
            //ViewState - Group: Group1469
            $scope.vc.createViewState({
                id: "G_REFINANCRN_122515",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRITERIEE_78531",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: clientName
            $scope.vc.createViewState({
                id: "VA_CLIENTNAMEBGXWU_198515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: currencyType
            $scope.vc.createViewState({
                id: "VA_CURRENCYTYPETLZ_990515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONEDATUB_92849",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CURRENCYTYPETLZ_990515 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CURRENCYTYPETLZ_990515', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CURRENCYTYPETLZ_990515'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CURRENCYTYPETLZ_990515");
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
            //ViewState - Entity: RefinanceLoanFilter, Attribute: operation
            $scope.vc.createViewState({
                id: "VA_OPERATIONPZCOUQ_327515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OPERACIAR_42315",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2949
            $scope.vc.createViewState({
                id: "G_REFINANACR_140515",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OPERACIOS_11374",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RefinanceLoans = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    loan: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "loan", '')
                    },
                    line: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "line", '')
                    },
                    initialAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "initialAmount", 0)
                    },
                    originalTerm: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "originalTerm", 0)
                    },
                    capitalBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "capitalBalance", 0)
                    },
                    interestBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "interestBalance", 0)
                    },
                    defaultBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "defaultBalance", 0)
                    },
                    otherConceptsBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "otherConceptsBalance", 0)
                    },
                    residualTerm: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "residualTerm", 0)
                    },
                    currencyType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "currencyType", '')
                    },
                    overdueFees: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "overdueFees", 0)
                    }
                }
            });
            $scope.vc.model.RefinanceLoans = new kendo.data.DataSource({
                pageSize: 4,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_REFINAAA_3375();
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RefinanceLoans',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_3375_11342', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.RefinanceLoans
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3375_11342").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_REFINAAA_3375 = $scope.vc.model.RefinanceLoans;
            $scope.vc.trackers.RefinanceLoans = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RefinanceLoans);
            $scope.vc.model.RefinanceLoans.bind('change', function(e) {
                $scope.vc.trackers.RefinanceLoans.track(e);
            });
            $scope.vc.grids.QV_3375_11342 = {};
            $scope.vc.grids.QV_3375_11342.queryId = 'Q_REFINAAA_3375';
            $scope.vc.viewState.QV_3375_11342 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3375_11342.column = {};
            $scope.vc.grids.QV_3375_11342.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_3375_11342.events = {
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
                    $scope.vc.trackers.RefinanceLoans.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3375_11342.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_3375_11342");
                    $scope.vc.hideShowColumns("QV_3375_11342", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3375_11342.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3375_11342.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3375_11342.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3375_11342 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3375_11342 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3375_11342.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3375_11342.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3375_11342.column.loan = {
                title: 'ASSTS.LBL_ASSTS_NROPRESMM_51743',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMHS_260515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT67_LOANWAUS582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.loan.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMHS_260515",
                        'maxlength': 16,
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.loan.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.loan.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.line = {
                title: 'ASSTS.LBL_ASSTS_TIPOPREMM_37747',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSSV_745515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT78_LINEUGLL582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.line.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSSV_745515",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.line.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.line.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.initialAmount = {
                title: 'ASSTS.LBL_ASSTS_MONTOORGI_46642',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFDY_704515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT34_INITIAAA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.initialAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFDY_704515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.initialAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.initialAmount.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.initialAmount.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.initialAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.originalTerm = {
                title: 'ASSTS.LBL_ASSTS_PLAZOORIG_11054',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFFP_550515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT35_ORIGINAT582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.originalTerm.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFFP_550515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.originalTerm.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.originalTerm.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.originalTerm.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.originalTerm.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.capitalBalance = {
                title: 'ASSTS.LBL_ASSTS_SALDOCAPI_87055',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXROR_675515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT89_CAPITABA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.capitalBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXROR_675515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.capitalBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.capitalBalance.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.capitalBalance.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.capitalBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.interestBalance = {
                title: 'ASSTS.LBL_ASSTS_SALDOINRR_32365',
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
                componentId: 'VA_TEXTINPUTBOXPZA_248515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT86_INTEREAA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.interestBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPZA_248515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.interestBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.interestBalance.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.interestBalance.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.interestBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.defaultBalance = {
                title: 'ASSTS.LBL_ASSTS_SALDOMOAR_33879',
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
                componentId: 'VA_TEXTINPUTBOXEQH_169515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT59_DEFAULCN582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.defaultBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEQH_169515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.defaultBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.defaultBalance.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.defaultBalance.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.defaultBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.otherConceptsBalance = {
                title: 'ASSTS.LBL_ASSTS_SALDOOTSO_22130',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIKG_248515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT25_OTHERCAA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.otherConceptsBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIKG_248515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.otherConceptsBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.otherConceptsBalance.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.otherConceptsBalance.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.otherConceptsBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.residualTerm = {
                title: 'ASSTS.LBL_ASSTS_PLAZORELL_79044',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMUB_575515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT97_RESIDURR582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.residualTerm.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMUB_575515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.residualTerm.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.residualTerm.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.residualTerm.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.residualTerm.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.currencyType = {
                title: 'ASSTS.LBL_ASSTS_MONEDAWBW_49541',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYEW_490515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT34_CURRENCP582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.currencyType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYEW_490515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.currencyType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.currencyType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3375_11342.column.overdueFees = {
                title: 'ASSTS.LBL_ASSTS_CUOTASVCE_30944',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIFR_825515',
                element: []
            };
            $scope.vc.grids.QV_3375_11342.AT30_OVERDUSE582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3375_11342.column.overdueFees.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIFR_825515",
                        'data-validation-code': "{{vc.viewState.QV_3375_11342.column.overdueFees.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3375_11342.column.overdueFees.format",
                        'k-decimals': "vc.viewState.QV_3375_11342.column.overdueFees.decimals",
                        'data-cobis-group': "GroupLayout,G_REFINANSER_157515,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3375_11342.column.overdueFees.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'loan',
                    title: '{{vc.viewState.QV_3375_11342.column.loan.title|translate:vc.viewState.QV_3375_11342.column.loan.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.loan.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.loan.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT67_LOANWAUS582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.loan.style' ng-bind='vc.getStringColumnFormat(dataItem.loan, \"QV_3375_11342\", \"loan\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3375_11342.column.loan.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.loan.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.loan.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'line',
                    title: '{{vc.viewState.QV_3375_11342.column.line.title|translate:vc.viewState.QV_3375_11342.column.line.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.line.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.line.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT78_LINEUGLL582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.line.style' ng-bind='vc.getStringColumnFormat(dataItem.line, \"QV_3375_11342\", \"line\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3375_11342.column.line.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.line.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.line.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'initialAmount',
                    title: '{{vc.viewState.QV_3375_11342.column.initialAmount.title|translate:vc.viewState.QV_3375_11342.column.initialAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.initialAmount.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.initialAmount.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT34_INITIAAA582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.initialAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.initialAmount, \"QV_3375_11342\", \"initialAmount\"):kendo.toString(#=initialAmount#, vc.viewState.QV_3375_11342.column.initialAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.initialAmount.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.initialAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.initialAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'originalTerm',
                    title: '{{vc.viewState.QV_3375_11342.column.originalTerm.title|translate:vc.viewState.QV_3375_11342.column.originalTerm.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.originalTerm.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.originalTerm.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT35_ORIGINAT582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.originalTerm.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.originalTerm, \"QV_3375_11342\", \"originalTerm\"):kendo.toString(#=originalTerm#, vc.viewState.QV_3375_11342.column.originalTerm.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.originalTerm.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.originalTerm.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.originalTerm.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'capitalBalance',
                    title: '{{vc.viewState.QV_3375_11342.column.capitalBalance.title|translate:vc.viewState.QV_3375_11342.column.capitalBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.capitalBalance.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.capitalBalance.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT89_CAPITABA582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.capitalBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.capitalBalance, \"QV_3375_11342\", \"capitalBalance\"):kendo.toString(#=capitalBalance#, vc.viewState.QV_3375_11342.column.capitalBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.capitalBalance.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.capitalBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.capitalBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'interestBalance',
                    title: '{{vc.viewState.QV_3375_11342.column.interestBalance.title|translate:vc.viewState.QV_3375_11342.column.interestBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.interestBalance.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.interestBalance.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT86_INTEREAA582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.interestBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.interestBalance, \"QV_3375_11342\", \"interestBalance\"):kendo.toString(#=interestBalance#, vc.viewState.QV_3375_11342.column.interestBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.interestBalance.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.interestBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.interestBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'defaultBalance',
                    title: '{{vc.viewState.QV_3375_11342.column.defaultBalance.title|translate:vc.viewState.QV_3375_11342.column.defaultBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.defaultBalance.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.defaultBalance.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT59_DEFAULCN582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.defaultBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.defaultBalance, \"QV_3375_11342\", \"defaultBalance\"):kendo.toString(#=defaultBalance#, vc.viewState.QV_3375_11342.column.defaultBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.defaultBalance.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.defaultBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.defaultBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'otherConceptsBalance',
                    title: '{{vc.viewState.QV_3375_11342.column.otherConceptsBalance.title|translate:vc.viewState.QV_3375_11342.column.otherConceptsBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.otherConceptsBalance.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.otherConceptsBalance.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT25_OTHERCAA582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.otherConceptsBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.otherConceptsBalance, \"QV_3375_11342\", \"otherConceptsBalance\"):kendo.toString(#=otherConceptsBalance#, vc.viewState.QV_3375_11342.column.otherConceptsBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.otherConceptsBalance.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.otherConceptsBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.otherConceptsBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'residualTerm',
                    title: '{{vc.viewState.QV_3375_11342.column.residualTerm.title|translate:vc.viewState.QV_3375_11342.column.residualTerm.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.residualTerm.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.residualTerm.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT97_RESIDURR582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.residualTerm.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.residualTerm, \"QV_3375_11342\", \"residualTerm\"):kendo.toString(#=residualTerm#, vc.viewState.QV_3375_11342.column.residualTerm.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.residualTerm.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.residualTerm.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.residualTerm.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'currencyType',
                    title: '{{vc.viewState.QV_3375_11342.column.currencyType.title|translate:vc.viewState.QV_3375_11342.column.currencyType.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.currencyType.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.currencyType.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT34_CURRENCP582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.currencyType.style' ng-bind='vc.getStringColumnFormat(dataItem.currencyType, \"QV_3375_11342\", \"currencyType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3375_11342.column.currencyType.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.currencyType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.currencyType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3375_11342.columns.push({
                    field: 'overdueFees',
                    title: '{{vc.viewState.QV_3375_11342.column.overdueFees.title|translate:vc.viewState.QV_3375_11342.column.overdueFees.titleArgs}}',
                    width: $scope.vc.viewState.QV_3375_11342.column.overdueFees.width,
                    format: $scope.vc.viewState.QV_3375_11342.column.overdueFees.format,
                    editor: $scope.vc.grids.QV_3375_11342.AT30_OVERDUSE582.control,
                    template: "<span ng-class='vc.viewState.QV_3375_11342.column.overdueFees.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.overdueFees, \"QV_3375_11342\", \"overdueFees\"):kendo.toString(#=overdueFees#, vc.viewState.QV_3375_11342.column.overdueFees.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3375_11342.column.overdueFees.style",
                        "title": "{{vc.viewState.QV_3375_11342.column.overdueFees.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3375_11342.column.overdueFees.hidden
                });
            }
            $scope.vc.viewState.QV_3375_11342.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_3375_11342.column.cmdEdition = {};
            $scope.vc.viewState.QV_3375_11342.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_3375_11342.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_3375_11342.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_3375_11342.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_REFINANACR_140515.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_3375_11342.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_3375_11342.toolbar = {}
            $scope.vc.grids.QV_3375_11342.toolbar = []; //ViewState - Group: GroupLayout1893
            $scope.vc.createViewState({
                id: "G_REFINANALR_445515",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1893',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2497
            $scope.vc.createViewState({
                id: "G_REFINANLEE_309515",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DATOSOPNV_65924",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: currencyTypeAux
            $scope.vc.createViewState({
                id: "VA_CURRENCYTYPEUXU_869515",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CURRENCYTYPEUXU_869515 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CURRENCYTYPEUXU_869515', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CURRENCYTYPEUXU_869515'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CURRENCYTYPEUXU_869515");
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
            //ViewState - Entity: RefinanceLoanFilter, Attribute: operationType
            $scope.vc.createViewState({
                id: "VA_OPERATIONTYPEEE_619515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOLDSKB_46090",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OPERATIONTYPEEE_619515 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OPERATIONTYPEEE_619515', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OPERATIONTYPEEE_619515'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OPERATIONTYPEEE_619515");
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
            //ViewState - Entity: RefinanceLoanFilter, Attribute: overDue
            $scope.vc.createViewState({
                id: "VA_OVERDUEVFBXKALY_348515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NACEVENOD_29221",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: newLoanTerm
            $scope.vc.createViewState({
                id: "VA_NEWLOANTERMUQHR_494515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PLAZOYJVK_49555",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: periodicity
            $scope.vc.createViewState({
                id: "VA_PERIODICITYSUIR_653515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERIODOSP_24297",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: newLoanCurrency
            $scope.vc.createViewState({
                id: "VA_NEWLOANCURRENNN_364515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONEDATUB_92849",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_600515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ADICIONAA_63161",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: addicionalPayMethod
            $scope.vc.createViewState({
                id: "VA_ADDICIONALPAYOH_649515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APAGOKXFB_84081",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ADDICIONALPAYOH_649515 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ADDICIONALPAYOH_649515', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ADDICIONALPAYOH_649515'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ADDICIONALPAYOH_649515");
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
            //ViewState - Entity: RefinanceLoanFilter, Attribute: payMethodCurrency
            $scope.vc.createViewState({
                id: "VA_PAYMETHODCURCYE_344515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONEDATUB_92849",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: additionalValue
            $scope.vc.createViewState({
                id: "VA_ADDITIONALVAUUU_896515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORNPRH_26284",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: account
            $scope.vc.createViewState({
                id: "VA_ACCOUNTYATVYIRL_740515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUENTADRA_18812",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: refreshData
            $scope.vc.createViewState({
                id: "VA_REFRESHDATALBDM_867515",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group2526
            $scope.vc.createViewState({
                id: "G_REFINANLOO_113515",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RESUMENBL_70613",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: capitalBalance
            $scope.vc.createViewState({
                id: "VA_CAPITALBALANCEC_436515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOCAAA_50381",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: otherBalance
            $scope.vc.createViewState({
                id: "VA_OTHERBALANCEJEN_649515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOOTOR_36722",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: interestBalance
            $scope.vc.createViewState({
                id: "VA_2598QVNXQLNVJQG_279515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_INTMORAOT_25587",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: aditionalBalance
            $scope.vc.createViewState({
                id: "VA_ADITIONALBALACN_754515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORADOA_45646",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1272
            $scope.vc.createViewState({
                id: "G_REFINANALS_386515",
                hasId: true,
                componentStyle: [],
                label: 'Group1272',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceLoanFilter, Attribute: totalRefinance
            $scope.vc.createViewState({
                id: "VA_TOTALREFINANEEC_261515",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TOTALAREO_20170",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_REFINANCELISS_781_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_REFINANCELISS_781_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TREFINAN_A4R",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TREFINAN_9NC",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CREARREVO_66981",
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
                $scope.vc.render('VC_REFINANCSL_902781');
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
    var cobisMainModule = cobis.createModule("VC_REFINANCSL_902781", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_REFINANCSL_902781", {
            templateUrl: "VC_REFINANCSL_902781_FORM.html",
            controller: "VC_REFINANCSL_902781_CTRL",
            labelId: "ASSTS.LBL_ASSTS_RENOVACMA_67253",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REFINANCSL_902781?" + $.param(search);
            }
        });
        VC_REFINANCSL_902781(cobisMainModule);
    }]);
} else {
    VC_REFINANCSL_902781(cobisMainModule);
}