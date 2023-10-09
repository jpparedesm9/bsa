//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.readjustmentdetalilsloanform = designerEvents.api.readjustmentdetalilsloanform || designer.dsgEvents();

function VC_REAJUSTEMF_502264(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REAJUSTEMF_502264_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REAJUSTEMF_502264_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_REAJUSTEDEFTF_264",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REAJUSTEMF_502264",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_REAJUSTEDEFTF_264",
        designerEvents.api.readjustmentdetalilsloanform,
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
                vcName: 'VC_REAJUSTEMF_502264'
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
                    taskId: 'T_REAJUSTEDEFTF_264',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Entity6: "Entity6",
                    ReadjustmentDetalilsLoan: "ReadjustmentDetalilsLoan",
                    Loan: "Loan",
                    ReadjustmentLoanCab: "ReadjustmentLoanCab"
                },
                entities: {
                    Entity6: {
                        Attribute1: 'AT02_1QUCGCAO283',
                        _pks: [],
                        _entityId: 'EN_6BWKVCDJP_283',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ReadjustmentDetalilsLoan: {
                        concepto: 'AT42_CONCEPTO221',
                        referencial: 'AT97_REFERENA221',
                        signo: 'AT68_SIGNOBWL221',
                        factor: 'AT95_FACTORRR221',
                        porcentaje: 'AT92_PORCENJJ221',
                        _pks: [],
                        _entityId: 'EN_REAJUSTEE_221',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Loan: {
                        numProcedure: 'AT10_NUMPROUE882',
                        quotaCredit: 'AT12_QUOTACEE882',
                        statusID: 'AT12_STATUSID882',
                        lastProcessDate: 'AT19_LASTPRED882',
                        balanceDue: 'AT21_BALANCDD882',
                        category: 'AT23_CATEGOYR882',
                        operationTypeID: 'AT23_OPERATDP882',
                        codCurrency: 'AT24_CODMONDD882',
                        newStatusID: 'AT25_NEWSTATT882',
                        isDisbursment: 'AT26_ISDISBTU882',
                        migratedOper: 'AT33_MIGRATEO882',
                        loanID: 'AT37_LOANIDFI882',
                        officeID: 'AT37_OFFICEID882',
                        currencyName: 'AT39_CURRENYY882',
                        startDate: 'AT39_STARTDEE882',
                        loanBankID: 'AT42_LOANBADK882',
                        idType: 'AT48_IDTYPEBH882',
                        endDate: 'AT50_ENDDATEE882',
                        identityCardNumber: 'AT56_IDCARDUU882',
                        desOperationType: 'AT57_DESOPETI882',
                        redesCont: 'AT58_REDESCTN882',
                        newStatus: 'AT59_NEWSTASS882',
                        group: 'AT62_GROUPTNG882',
                        previousOper: 'AT65_PREVIOPU882',
                        status: 'AT66_STATUSOB882',
                        clientID: 'AT68_CLIENTII882',
                        operationType: 'AT70_OPERATPP882',
                        clientName: 'AT71_CLIENTNA882',
                        disbursementDate: 'AT76_DISBURTS882',
                        expirationDate: 'AT76_EXPIRAEE882',
                        officer: 'AT77_OFFICERR882',
                        nextPayment: 'AT85_NEXTPAMT882',
                        effectiveAnualRate: 'AT90_EFFECTAU882',
                        amount: 'AT91_AMOUNTMO882',
                        adjustment: 'AT94_ADJUSTNT882',
                        officerID: 'AT95_OFFICEID882',
                        office: 'AT96_OFFICEPU882',
                        feeEndDate: 'AT99_FEEENDED882',
                        _pks: [],
                        _entityId: 'EN_LOANKYMRI_882',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ReadjustmentLoanCab: {
                        date: 'AT21_FECHAOFI191',
                        mantCuota: 'AT57_MANTCUAT191',
                        secuencial: 'AT54_SECUENAC191',
                        desagio: 'AT28_TIPOQBOA191',
                        _pks: [],
                        _entityId: 'EN_REAJUSTBB_191',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_REAJUSTE_2618 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_REAJUSTE_2618 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_REAJUSTE_2618_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_REAJUSTE_2618_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_REAJUSTEE_221',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_REAJUSTE_2618',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_REAJUSTE_2618_filters = {};
            var defaultValues = {
                Entity6: {},
                ReadjustmentDetalilsLoan: {},
                Loan: {},
                ReadjustmentLoanCab: {}
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
                $scope.vc.execute("temporarySave", VC_REAJUSTEMF_502264, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REAJUSTEMF_502264, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REAJUSTEMF_502264, data, function() {});
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
            $scope.vc.viewState.VC_REAJUSTEMF_502264 = {
                style: []
            }
            $scope.vc.model.Entity6 = {
                Attribute1: $scope.vc.channelDefaultValues("Entity6", "Attribute1")
            };
            //ViewState - Group: Group1568
            $scope.vc.createViewState({
                id: "G_REAJUSTRRT_182141",
                hasId: true,
                componentStyle: [],
                label: 'Group1568',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_938141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DETALLEAE_87475",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2244",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2391",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONRGCIAEL_707141",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group1839
            $scope.vc.createViewState({
                id: "G_REAJUSTTFE_294141",
                hasId: true,
                componentStyle: [],
                label: 'Group1839',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ReadjustmentDetalilsLoan = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    concepto: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentDetalilsLoan", "concepto", ''),
                        validation: {
                            conceptoRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    referencial: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentDetalilsLoan", "referencial", '')
                    },
                    signo: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentDetalilsLoan", "signo", '')
                    },
                    factor: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentDetalilsLoan", "factor", 0)
                    },
                    porcentaje: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ReadjustmentDetalilsLoan", "porcentaje", 0)
                    }
                }
            });
            $scope.vc.model.ReadjustmentDetalilsLoan = new kendo.data.DataSource({
                pageSize: 5,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_REAJUSTE_2618();
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ReadjustmentDetalilsLoan',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_2618_23821', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    destroy: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ReadjustmentDetalilsLoan',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_2618_23821', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.ReadjustmentDetalilsLoan
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2618_23821").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_REAJUSTE_2618 = $scope.vc.model.ReadjustmentDetalilsLoan;
            $scope.vc.trackers.ReadjustmentDetalilsLoan = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ReadjustmentDetalilsLoan);
            $scope.vc.model.ReadjustmentDetalilsLoan.bind('change', function(e) {
                $scope.vc.trackers.ReadjustmentDetalilsLoan.track(e);
            });
            $scope.vc.grids.QV_2618_23821 = {};
            $scope.vc.grids.QV_2618_23821.queryId = 'Q_REAJUSTE_2618';
            $scope.vc.viewState.QV_2618_23821 = {
                style: undefined
            };
            $scope.vc.viewState.QV_2618_23821.column = {};
            $scope.vc.grids.QV_2618_23821.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_2618_23821.events = {
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
                    $scope.vc.trackers.ReadjustmentDetalilsLoan.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_2618_23821.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_2618_23821");
                    $scope.vc.hideShowColumns("QV_2618_23821", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2618_23821.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2618_23821.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_2618_23821.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2618_23821 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2618_23821 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_2618_23821.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2618_23821.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2618_23821.column.concepto = {
                title: 'ASSTS.LBL_ASSTS_CONCEPTOO_16181',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXVNC_178141',
                element: []
            };
            $scope.vc.grids.QV_2618_23821.AT42_CONCEPTO221 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2618_23821.column.concepto.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVNC_178141",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_CONCEPTOO_16181') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_2618_23821.column.concepto.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2618_23821.column.concepto.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2618_23821.column.referencial = {
                title: 'ASSTS.LBL_ASSTS_REFERENCL_42296',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFYD_123141',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXFYD_123141 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXFYD_123141', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXFYD_123141'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
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
            $scope.vc.grids.QV_2618_23821.AT97_REFERENA221 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2618_23821.column.referencial.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFYD_123141",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_2618_23821.column.referencial.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXFYD_123141",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_2618_23821.column.referencial.template",
                        'data-validation-code': "{{vc.viewState.QV_2618_23821.column.referencial.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXFYD_123141',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_TEXTINPUTBOXFYD_123141',this.dataItem,'" + options.field + "')",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2618_23821.column.signo = {
                title: 'ASSTS.LBL_ASSTS_SIGNORIHO_57042',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIEY_291141',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXIEY_291141 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXIEY_291141',
                            'ca_signo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXIEY_291141'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_2618_23821.AT68_SIGNOBWL221 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2618_23821.column.signo.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIEY_291141",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_2618_23821.column.signo.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXIEY_291141",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_2618_23821.column.signo.template",
                        'data-validation-code': "{{vc.viewState.QV_2618_23821.column.signo.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXIEY_291141',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_TEXTINPUTBOXIEY_291141',this.dataItem,'" + options.field + "')",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2618_23821.column.factor = {
                title: 'ASSTS.LBL_ASSTS_FACTORQJB_54710',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#0.000000",
                decimals: 6,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYTY_525141',
                element: []
            };
            $scope.vc.grids.QV_2618_23821.AT95_FACTORRR221 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2618_23821.column.factor.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYTY_525141",
                        'data-validation-code': "{{vc.viewState.QV_2618_23821.column.factor.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2618_23821.column.factor.format",
                        'k-decimals': "vc.viewState.QV_2618_23821.column.factor.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXYTY_525141',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXYTY_525141',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2618_23821.column.factor.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2618_23821.column.porcentaje = {
                title: 'ASSTS.LBL_ASSTS_PORCENTAE_66428',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#0.000000",
                decimals: 6,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAAA_377141',
                element: []
            };
            $scope.vc.grids.QV_2618_23821.AT92_PORCENJJ221 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2618_23821.column.porcentaje.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAAA_377141",
                        'data-validation-code': "{{vc.viewState.QV_2618_23821.column.porcentaje.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2618_23821.column.porcentaje.format",
                        'k-decimals': "vc.viewState.QV_2618_23821.column.porcentaje.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXAAA_377141',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXAAA_377141',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2618_23821.column.porcentaje.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2618_23821.columns.push({
                    field: 'concepto',
                    title: '{{vc.viewState.QV_2618_23821.column.concepto.title|translate:vc.viewState.QV_2618_23821.column.concepto.titleArgs}}',
                    width: $scope.vc.viewState.QV_2618_23821.column.concepto.width,
                    format: $scope.vc.viewState.QV_2618_23821.column.concepto.format,
                    editor: $scope.vc.grids.QV_2618_23821.AT42_CONCEPTO221.control,
                    template: "<span ng-class='vc.viewState.QV_2618_23821.column.concepto.style' ng-bind='vc.getStringColumnFormat(dataItem.concepto, \"QV_2618_23821\", \"concepto\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2618_23821.column.concepto.style",
                        "title": "{{vc.viewState.QV_2618_23821.column.concepto.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2618_23821.column.concepto.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2618_23821.columns.push({
                    field: 'referencial',
                    title: '{{vc.viewState.QV_2618_23821.column.referencial.title|translate:vc.viewState.QV_2618_23821.column.referencial.titleArgs}}',
                    width: $scope.vc.viewState.QV_2618_23821.column.referencial.width,
                    format: $scope.vc.viewState.QV_2618_23821.column.referencial.format,
                    editor: $scope.vc.grids.QV_2618_23821.AT97_REFERENA221.control,
                    template: "<span ng-class='vc.viewState.QV_2618_23821.column.referencial.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXFYD_123141.get(dataItem.referencial).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2618_23821.column.referencial.style",
                        "title": "{{vc.viewState.QV_2618_23821.column.referencial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2618_23821.column.referencial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2618_23821.columns.push({
                    field: 'signo',
                    title: '{{vc.viewState.QV_2618_23821.column.signo.title|translate:vc.viewState.QV_2618_23821.column.signo.titleArgs}}',
                    width: $scope.vc.viewState.QV_2618_23821.column.signo.width,
                    format: $scope.vc.viewState.QV_2618_23821.column.signo.format,
                    editor: $scope.vc.grids.QV_2618_23821.AT68_SIGNOBWL221.control,
                    template: "<span ng-class='vc.viewState.QV_2618_23821.column.signo.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXIEY_291141.get(dataItem.signo).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2618_23821.column.signo.style",
                        "title": "{{vc.viewState.QV_2618_23821.column.signo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2618_23821.column.signo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2618_23821.columns.push({
                    field: 'factor',
                    title: '{{vc.viewState.QV_2618_23821.column.factor.title|translate:vc.viewState.QV_2618_23821.column.factor.titleArgs}}',
                    width: $scope.vc.viewState.QV_2618_23821.column.factor.width,
                    format: $scope.vc.viewState.QV_2618_23821.column.factor.format,
                    editor: $scope.vc.grids.QV_2618_23821.AT95_FACTORRR221.control,
                    template: "<span ng-class='vc.viewState.QV_2618_23821.column.factor.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.factor, \"QV_2618_23821\", \"factor\"):kendo.toString(#=factor#, vc.viewState.QV_2618_23821.column.factor.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2618_23821.column.factor.style",
                        "title": "{{vc.viewState.QV_2618_23821.column.factor.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2618_23821.column.factor.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2618_23821.columns.push({
                    field: 'porcentaje',
                    title: '{{vc.viewState.QV_2618_23821.column.porcentaje.title|translate:vc.viewState.QV_2618_23821.column.porcentaje.titleArgs}}',
                    width: $scope.vc.viewState.QV_2618_23821.column.porcentaje.width,
                    format: $scope.vc.viewState.QV_2618_23821.column.porcentaje.format,
                    editor: $scope.vc.grids.QV_2618_23821.AT92_PORCENJJ221.control,
                    template: "<span ng-class='vc.viewState.QV_2618_23821.column.porcentaje.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.porcentaje, \"QV_2618_23821\", \"porcentaje\"):kendo.toString(#=porcentaje#, vc.viewState.QV_2618_23821.column.porcentaje.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2618_23821.column.porcentaje.style",
                        "title": "{{vc.viewState.QV_2618_23821.column.porcentaje.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2618_23821.column.porcentaje.hidden
                });
            }
            $scope.vc.viewState.QV_2618_23821.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_2618_23821.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_2618_23821.column.cmdEdition = {};
            $scope.vc.viewState.QV_2618_23821.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_2618_23821.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_2618_23821.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_2618_23821.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_REAJUSTTFE_294141.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_2618_23821.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_2618_23821.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_REAJUSTTFE_294141.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_2618_23821.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_2618_23821.toolbar = {}
            $scope.vc.grids.QV_2618_23821.toolbar = [];
            $scope.vc.model.Loan = {
                numProcedure: $scope.vc.channelDefaultValues("Loan", "numProcedure"),
                quotaCredit: $scope.vc.channelDefaultValues("Loan", "quotaCredit"),
                statusID: $scope.vc.channelDefaultValues("Loan", "statusID"),
                lastProcessDate: $scope.vc.channelDefaultValues("Loan", "lastProcessDate"),
                balanceDue: $scope.vc.channelDefaultValues("Loan", "balanceDue"),
                category: $scope.vc.channelDefaultValues("Loan", "category"),
                operationTypeID: $scope.vc.channelDefaultValues("Loan", "operationTypeID"),
                codCurrency: $scope.vc.channelDefaultValues("Loan", "codCurrency"),
                newStatusID: $scope.vc.channelDefaultValues("Loan", "newStatusID"),
                isDisbursment: $scope.vc.channelDefaultValues("Loan", "isDisbursment"),
                migratedOper: $scope.vc.channelDefaultValues("Loan", "migratedOper"),
                loanID: $scope.vc.channelDefaultValues("Loan", "loanID"),
                officeID: $scope.vc.channelDefaultValues("Loan", "officeID"),
                currencyName: $scope.vc.channelDefaultValues("Loan", "currencyName"),
                startDate: $scope.vc.channelDefaultValues("Loan", "startDate"),
                loanBankID: $scope.vc.channelDefaultValues("Loan", "loanBankID"),
                idType: $scope.vc.channelDefaultValues("Loan", "idType"),
                endDate: $scope.vc.channelDefaultValues("Loan", "endDate"),
                identityCardNumber: $scope.vc.channelDefaultValues("Loan", "identityCardNumber"),
                desOperationType: $scope.vc.channelDefaultValues("Loan", "desOperationType"),
                redesCont: $scope.vc.channelDefaultValues("Loan", "redesCont"),
                newStatus: $scope.vc.channelDefaultValues("Loan", "newStatus"),
                group: $scope.vc.channelDefaultValues("Loan", "group"),
                previousOper: $scope.vc.channelDefaultValues("Loan", "previousOper"),
                status: $scope.vc.channelDefaultValues("Loan", "status"),
                clientID: $scope.vc.channelDefaultValues("Loan", "clientID"),
                operationType: $scope.vc.channelDefaultValues("Loan", "operationType"),
                clientName: $scope.vc.channelDefaultValues("Loan", "clientName"),
                disbursementDate: $scope.vc.channelDefaultValues("Loan", "disbursementDate"),
                expirationDate: $scope.vc.channelDefaultValues("Loan", "expirationDate"),
                officer: $scope.vc.channelDefaultValues("Loan", "officer"),
                nextPayment: $scope.vc.channelDefaultValues("Loan", "nextPayment"),
                effectiveAnualRate: $scope.vc.channelDefaultValues("Loan", "effectiveAnualRate"),
                amount: $scope.vc.channelDefaultValues("Loan", "amount"),
                adjustment: $scope.vc.channelDefaultValues("Loan", "adjustment"),
                officerID: $scope.vc.channelDefaultValues("Loan", "officerID"),
                office: $scope.vc.channelDefaultValues("Loan", "office"),
                feeEndDate: $scope.vc.channelDefaultValues("Loan", "feeEndDate")
            };
            //ViewState - Group: Group1328
            $scope.vc.createViewState({
                id: "G_READJUSSAA_728141",
                hasId: true,
                componentStyle: [],
                label: 'Group1328',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer2917",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ReadjustmentLoanCab = {
                date: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "date"),
                mantCuota: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "mantCuota"),
                secuencial: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "secuencial"),
                desagio: $scope.vc.channelDefaultValues("ReadjustmentLoanCab", "desagio")
            };
            //ViewState - Group: Group2266
            $scope.vc.createViewState({
                id: "G_READJUSTON_605141",
                hasId: true,
                componentStyle: [],
                label: 'Group2266',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer2328",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_REAJUSTEDEFTF_264_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_REAJUSTEDEFTF_264_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXFYD_123141.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXIEY_291141.read();
                }
            });
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
                $scope.vc.render('VC_REAJUSTEMF_502264');
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
    var cobisMainModule = cobis.createModule("VC_REAJUSTEMF_502264", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_REAJUSTEMF_502264", {
            templateUrl: "VC_REAJUSTEMF_502264_FORM.html",
            controller: "VC_REAJUSTEMF_502264_CTRL",
            labelId: "ASSTS.LBL_ASSTS_DETALLEEE_62584",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REAJUSTEMF_502264?" + $.param(search);
            }
        });
        VC_REAJUSTEMF_502264(cobisMainModule);
    }]);
} else {
    VC_REAJUSTEMF_502264(cobisMainModule);
}