//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.accountstatusform = designerEvents.api.accountstatusform || designer.dsgEvents();

function VC_ACCOUNTSSA_935726(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_ACCOUNTSSA_935726_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_ACCOUNTSSA_935726_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSFIQJZFID_726",
            taskVersion: "1.0.0",
            viewContainerId: "VC_ACCOUNTSSA_935726",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_ASSTSFIQJZFID_726",
        designerEvents.api.accountstatusform,
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
                vcName: 'VC_ACCOUNTSSA_935726'
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
                    taskId: 'T_ASSTSFIQJZFID_726',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    AccountStatus: "AccountStatus"
                },
                entities: {
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
                    AccountStatus: {
                        clientId: 'AT14_CLIENTDI868',
                        bankNumber: 'AT25_BANKNURB868',
                        sequential: 'AT31_SEQUENTL868',
                        toPrint: 'AT40_TOPRINTT868',
                        date: 'AT43_DATEUYLK868',
                        clientName: 'AT75_CLIENTNN868',
                        email: 'AT92_EMAILIDN868',
                        groupName: 'AT95_GROUPNAE868',
                        _pks: [],
                        _entityId: 'EN_ACCOUNTSS_868',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ACCOUNSS_3580 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_ACCOUNSS_3580 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ACCOUNSS_3580_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ACCOUNSS_3580_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ACCOUNTSS_868',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ACCOUNSS_3580',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_ACCOUNSS_3580_filters = {};
            var defaultValues = {
                Loan: {},
                AccountStatus: {}
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
                $scope.vc.execute("temporarySave", VC_ACCOUNTSSA_935726, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_ACCOUNTSSA_935726, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_ACCOUNTSSA_935726, data, function() {});
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
            $scope.vc.viewState.VC_ACCOUNTSSA_935726 = {
                style: []
            }
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
            //ViewState - Group: Group1250
            $scope.vc.createViewState({
                id: "G_ACCOUNTSAT_568859",
                hasId: true,
                componentStyle: [],
                label: 'Group1250',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: clientName
            $scope.vc.createViewState({
                id: "VA_CLIENTNAMEEZJBH_766859",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: feeEndDate
            $scope.vc.createViewState({
                id: "VA_FEEENDDATEXFOYY_333859",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAQWBP_23514",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2369",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONPMSVXME_604859",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2494
            $scope.vc.createViewState({
                id: "G_ACCOUNTTTS_801859",
                hasId: true,
                componentStyle: [],
                label: 'Group2494',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.AccountStatus = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    date: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountStatus", "date", new Date())
                    },
                    clientId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountStatus", "clientId", 0)
                    },
                    bankNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountStatus", "bankNumber", '')
                    },
                    clientName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountStatus", "clientName", '')
                    },
                    groupName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountStatus", "groupName", '')
                    },
                    email: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountStatus", "email", '')
                    },
                    toPrint: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountStatus", "toPrint", false)
                    }
                }
            });
            $scope.vc.model.AccountStatus = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_ACCOUNSS_3580';
                            var queryRequest = $scope.vc.getRequestQuery_Q_ACCOUNSS_3580();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3580_21558',
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
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.AccountStatus
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3580_21558").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ACCOUNSS_3580 = $scope.vc.model.AccountStatus;
            $scope.vc.trackers.AccountStatus = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AccountStatus);
            $scope.vc.model.AccountStatus.bind('change', function(e) {
                $scope.vc.trackers.AccountStatus.track(e);
            });
            $scope.vc.grids.QV_3580_21558 = {};
            $scope.vc.grids.QV_3580_21558.queryId = 'Q_ACCOUNSS_3580';
            $scope.vc.viewState.QV_3580_21558 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3580_21558.column = {};
            $scope.vc.grids.QV_3580_21558.editable = false;
            $scope.vc.grids.QV_3580_21558.events = {
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
                    $scope.vc.trackers.AccountStatus.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3580_21558.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_3580_21558");
                    $scope.vc.hideShowColumns("QV_3580_21558", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3580_21558.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3580_21558.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3580_21558.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3580_21558 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3580_21558 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_3580_21558.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_3580_21558.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_3580_21558.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "AccountStatus",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_3580_21558", args);
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
            $scope.vc.grids.QV_3580_21558.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3580_21558.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3580_21558.column.date = {
                title: 'ASSTS.LBL_ASSTS_FECHAQWBP_23514',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDKACVTJ_411859',
                element: []
            };
            $scope.vc.grids.QV_3580_21558.AT43_DATEUYLK868 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3580_21558.column.date.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDKACVTJ_411859",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_3580_21558.column.date.validationCode}}",
                        'ng-class': "vc.viewState.QV_3580_21558.column.date.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3580_21558.column.clientId = {
                title: 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCDM_103859',
                element: []
            };
            $scope.vc.grids.QV_3580_21558.AT14_CLIENTDI868 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3580_21558.column.clientId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCDM_103859",
                        'data-validation-code': "{{vc.viewState.QV_3580_21558.column.clientId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3580_21558.column.clientId.format",
                        'k-decimals': "vc.viewState.QV_3580_21558.column.clientId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3580_21558.column.clientId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3580_21558.column.bankNumber = {
                title: 'ASSTS.LBL_ASSTS_NMEROBACO_37648',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNAI_832859',
                element: []
            };
            $scope.vc.grids.QV_3580_21558.AT25_BANKNURB868 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3580_21558.column.bankNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNAI_832859",
                        'data-validation-code': "{{vc.viewState.QV_3580_21558.column.bankNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3580_21558.column.bankNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3580_21558.column.clientName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREDLE_56666',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAYT_745859',
                element: []
            };
            $scope.vc.grids.QV_3580_21558.AT75_CLIENTNN868 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3580_21558.column.clientName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAYT_745859",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_3580_21558.column.clientName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3580_21558.column.clientName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3580_21558.column.groupName = {
                title: 'ASSTS.LBL_ASSTS_GRUPOOBAY_84995',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMHX_934859',
                element: []
            };
            $scope.vc.grids.QV_3580_21558.AT95_GROUPNAE868 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3580_21558.column.groupName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMHX_934859",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_3580_21558.column.groupName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3580_21558.column.groupName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3580_21558.column.email = {
                title: 'ASSTS.LBL_ASSTS_CORREOWGJ_72729',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRFI_286859',
                element: []
            };
            $scope.vc.grids.QV_3580_21558.AT92_EMAILIDN868 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3580_21558.column.email.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRFI_286859",
                        'data-validation-code': "{{vc.viewState.QV_3580_21558.column.email.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3580_21558.column.email.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3580_21558.column.toPrint = {
                title: 'ASSTS.LBL_ASSTS_IMPRIMIRR_18630',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXDCCDNZV_992859',
                element: []
            };
            $scope.vc.grids.QV_3580_21558.AT40_TOPRINTT868 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3580_21558.column.toPrint.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CHECKBOXDCCDNZV_992859",
                        'ng-class': 'vc.viewState.QV_3580_21558.column.toPrint.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3580_21558.columns.push({
                    field: 'date',
                    title: '{{vc.viewState.QV_3580_21558.column.date.title|translate:vc.viewState.QV_3580_21558.column.date.titleArgs}}',
                    width: $scope.vc.viewState.QV_3580_21558.column.date.width,
                    format: $scope.vc.viewState.QV_3580_21558.column.date.format,
                    editor: $scope.vc.grids.QV_3580_21558.AT43_DATEUYLK868.control,
                    template: "<span ng-class='vc.viewState.QV_3580_21558.column.date.style'>#=((date !== null) ? kendo.toString(date, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3580_21558.column.date.style",
                        "title": "{{vc.viewState.QV_3580_21558.column.date.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3580_21558.column.date.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3580_21558.columns.push({
                    field: 'clientId',
                    title: '{{vc.viewState.QV_3580_21558.column.clientId.title|translate:vc.viewState.QV_3580_21558.column.clientId.titleArgs}}',
                    width: $scope.vc.viewState.QV_3580_21558.column.clientId.width,
                    format: $scope.vc.viewState.QV_3580_21558.column.clientId.format,
                    editor: $scope.vc.grids.QV_3580_21558.AT14_CLIENTDI868.control,
                    template: "<span ng-class='vc.viewState.QV_3580_21558.column.clientId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.clientId, \"QV_3580_21558\", \"clientId\"):kendo.toString(#=clientId#, vc.viewState.QV_3580_21558.column.clientId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3580_21558.column.clientId.style",
                        "title": "{{vc.viewState.QV_3580_21558.column.clientId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3580_21558.column.clientId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3580_21558.columns.push({
                    field: 'bankNumber',
                    title: '{{vc.viewState.QV_3580_21558.column.bankNumber.title|translate:vc.viewState.QV_3580_21558.column.bankNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_3580_21558.column.bankNumber.width,
                    format: $scope.vc.viewState.QV_3580_21558.column.bankNumber.format,
                    editor: $scope.vc.grids.QV_3580_21558.AT25_BANKNURB868.control,
                    template: "<span ng-class='vc.viewState.QV_3580_21558.column.bankNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.bankNumber, \"QV_3580_21558\", \"bankNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3580_21558.column.bankNumber.style",
                        "title": "{{vc.viewState.QV_3580_21558.column.bankNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3580_21558.column.bankNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3580_21558.columns.push({
                    field: 'clientName',
                    title: '{{vc.viewState.QV_3580_21558.column.clientName.title|translate:vc.viewState.QV_3580_21558.column.clientName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3580_21558.column.clientName.width,
                    format: $scope.vc.viewState.QV_3580_21558.column.clientName.format,
                    editor: $scope.vc.grids.QV_3580_21558.AT75_CLIENTNN868.control,
                    template: "<span ng-class='vc.viewState.QV_3580_21558.column.clientName.style' ng-bind='vc.getStringColumnFormat(dataItem.clientName, \"QV_3580_21558\", \"clientName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3580_21558.column.clientName.style",
                        "title": "{{vc.viewState.QV_3580_21558.column.clientName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3580_21558.column.clientName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3580_21558.columns.push({
                    field: 'groupName',
                    title: '{{vc.viewState.QV_3580_21558.column.groupName.title|translate:vc.viewState.QV_3580_21558.column.groupName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3580_21558.column.groupName.width,
                    format: $scope.vc.viewState.QV_3580_21558.column.groupName.format,
                    editor: $scope.vc.grids.QV_3580_21558.AT95_GROUPNAE868.control,
                    template: "<span ng-class='vc.viewState.QV_3580_21558.column.groupName.style' ng-bind='vc.getStringColumnFormat(dataItem.groupName, \"QV_3580_21558\", \"groupName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3580_21558.column.groupName.style",
                        "title": "{{vc.viewState.QV_3580_21558.column.groupName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3580_21558.column.groupName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3580_21558.columns.push({
                    field: 'email',
                    title: '{{vc.viewState.QV_3580_21558.column.email.title|translate:vc.viewState.QV_3580_21558.column.email.titleArgs}}',
                    width: $scope.vc.viewState.QV_3580_21558.column.email.width,
                    format: $scope.vc.viewState.QV_3580_21558.column.email.format,
                    editor: $scope.vc.grids.QV_3580_21558.AT92_EMAILIDN868.control,
                    template: "<span ng-class='vc.viewState.QV_3580_21558.column.email.style' ng-bind='vc.getStringColumnFormat(dataItem.email, \"QV_3580_21558\", \"email\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3580_21558.column.email.style",
                        "title": "{{vc.viewState.QV_3580_21558.column.email.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3580_21558.column.email.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3580_21558.columns.push({
                    field: 'toPrint',
                    title: '{{vc.viewState.QV_3580_21558.column.toPrint.title|translate:vc.viewState.QV_3580_21558.column.toPrint.titleArgs}}',
                    width: $scope.vc.viewState.QV_3580_21558.column.toPrint.width,
                    format: $scope.vc.viewState.QV_3580_21558.column.toPrint.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_3580_21558', 'toPrint', $scope.vc.grids.QV_3580_21558.AT40_TOPRINTT868.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_3580_21558', 'toPrint'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3580_21558.column.toPrint.style",
                        "title": "{{vc.viewState.QV_3580_21558.column.toPrint.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3580_21558.column.toPrint.hidden
                });
            }
            $scope.vc.viewState.QV_3580_21558.toolbar = {}
            $scope.vc.grids.QV_3580_21558.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSFIQJZFID_726_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSFIQJZFID_726_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TASSTSFI_AS9",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VISTAPRAI_13132",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TASSTSFI_S64",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ENVIARRFA_30717",
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
                $scope.vc.render('VC_ACCOUNTSSA_935726');
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
    var cobisMainModule = cobis.createModule("VC_ACCOUNTSSA_935726", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_ACCOUNTSSA_935726", {
            templateUrl: "VC_ACCOUNTSSA_935726_FORM.html",
            controller: "VC_ACCOUNTSSA_935726_CTRL",
            labelId: "ASSTS.LBL_ASSTS_ESTADOCAE_42774",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_ACCOUNTSSA_935726?" + $.param(search);
            }
        });
        VC_ACCOUNTSSA_935726(cobisMainModule);
    }]);
} else {
    VC_ACCOUNTSSA_935726(cobisMainModule);
}