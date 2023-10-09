//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.biovalidationcomposite = designerEvents.api.biovalidationcomposite || designer.dsgEvents();

function VC_BIOVALIDSA_412339(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_BIOVALIDSA_412339_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_BIOVALIDSA_412339_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "BMTRC",
            subModuleId: "TRNSC",
            taskId: "T_BMTRCXBFSYZSS_339",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BIOVALIDSA_412339",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BMTRC/TRNSC/T_BMTRCXBFSYZSS_339",
        designerEvents.api.biovalidationcomposite,
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
                vcName: 'VC_BIOVALIDSA_412339'
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
                    moduleId: 'BMTRC',
                    subModuleId: 'TRNSC',
                    taskId: 'T_BMTRCXBFSYZSS_339',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Customer: "Customer",
                    ValidationData: "ValidationData",
                    Credit: "Credit",
                    AdditionalInformation: "AdditionalInformation"
                },
                entities: {
                    Customer: {
                        year: 'AT23_YEARRIJK928',
                        leftFinger: 'AT29_LEFTFIRG928',
                        motherSurname: 'AT30_MOTHERRU928',
                        registrySituation: 'AT32_REGISTIU928',
                        role: 'AT38_ROLELRKC928',
                        birthDay: 'AT39_BIRTHDTA928',
                        credentialNumber: 'AT40_CREDENET928',
                        withoutFingerprintValue: 'AT42_WITHOUVI928',
                        birthCity: 'AT46_BIRTHCYI928',
                        withoutFingerprint: 'AT46_WITHOUGR928',
                        hash: 'AT49_HASHHCFR928',
                        curp: 'AT52_CURPHDQH928',
                        channel: 'AT53_CHANNELL928',
                        cic: 'AT54_CICVFQGP928',
                        customer: 'AT54_CUSTOMRE928',
                        idCustomer: 'AT56_IDCUSTMR928',
                        rightFinger: 'AT60_RIGHTFEE928',
                        buc: 'AT69_BUCRNBLB928',
                        surname: 'AT76_SURNAMEE928',
                        typeTheftReport: 'AT78_TYPETHRE928',
                        validationStatus: 'AT81_VALIDASO928',
                        ocr: 'AT83_OCRDITSJ928',
                        voterKey: 'AT85_VOTERKEE928',
                        amount: 'AT87_AMOUNTFR928',
                        customerName: 'AT87_CUSTOMMR928',
                        yearEmission: 'AT97_YEAREMIS928',
                        sequential: 'AT98_SEQUENTT928',
                        _pks: [],
                        _entityId: 'EN_CUSTOMERR_928',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ValidationData: {
                        customerId: 'AT14_CUSTOMDR518',
                        customerName: 'AT28_CUSTOMNE518',
                        processInstance: 'AT33_PROCESSN518',
                        userKey: 'AT44_USERKEYY518',
                        resultValidation: 'AT65_RESULTDT518',
                        customerType: 'AT77_CUSTOMRT518',
                        office: 'AT78_OFFICEGU518',
                        cycleNumber: 'AT83_CYCLENUM518',
                        _pks: [],
                        _entityId: 'EN_VALIDATOA_518',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Credit: {
                        productType: 'AT18_PRODUCTY484',
                        officeName: 'AT19_OFFICEME484',
                        cycleNumber: 'AT21_CYCLENEE484',
                        creditCode: 'AT34_CREDITDE484',
                        amountRequested: 'AT35_AMOUNTQE484',
                        sector: 'AT37_SECTORCN484',
                        operationNumber: 'AT49_OPERATMN484',
                        approvedAmount: 'AT50_APPROVEM484',
                        paymentFrecuency: 'AT57_PAYMENEE484',
                        applicationNumber: 'AT62_APPLICEE484',
                        term: 'AT62_TERMCBDA484',
                        office: 'AT69_OFFICEPX484',
                        amount: 'AT91_AMOUNTHY484',
                        _pks: [],
                        _entityId: 'EN_CREDITKKB_484',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    AdditionalInformation: {
                        environment: 'AT25_ENVIROEN239',
                        _pks: [],
                        _entityId: 'EN_ADDITIOLA_239',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CUSTOMEE_6806 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_CUSTOMEE_6806 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CUSTOMEE_6806_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CUSTOMEE_6806_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CUSTOMERR_928',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CUSTOMEE_6806',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_CUSTOMEE_6806_filters = {};
            var defaultValues = {
                Customer: {},
                ValidationData: {},
                Credit: {},
                AdditionalInformation: {}
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
                $scope.vc.execute("temporarySave", VC_BIOVALIDSA_412339, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_BIOVALIDSA_412339, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_BIOVALIDSA_412339, data, function() {});
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
            $scope.vc.viewState.VC_BIOVALIDSA_412339 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_BIOVALIDSA_412339",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_EKUISTTDGE_644339",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: HeaderForm
            $scope.vc.createViewState({
                id: "VC_GDRJNAMPUX_648833",
                hasId: true,
                componentStyle: [],
                label: 'HeaderForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1931
            $scope.vc.createViewState({
                id: "G_HEADERSYFS_536967",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1931',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_HEADERSYFS_536967-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: BiometricValidation
            $scope.vc.createViewState({
                id: "VC_SUNDSCXBDJ_542925",
                hasId: true,
                componentStyle: [],
                label: 'BiometricValidation',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1819
            $scope.vc.createViewState({
                id: "G_BIOMETRVLI_359515",
                hasId: true,
                componentStyle: [],
                label: 'Group1819',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_BIOMETRVLI_359515-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2111
            $scope.vc.createViewState({
                id: "G_BIOMETRALD_208515",
                hasId: true,
                componentStyle: [],
                label: 'Group2111',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Customer = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    sequential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "sequential", 0)
                    },
                    idCustomer: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "idCustomer", 0)
                    },
                    customer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "customer", '')
                    },
                    role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "role", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "amount", 0)
                    },
                    withoutFingerprint: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "withoutFingerprint", false)
                    },
                    validationStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "validationStatus", '')
                    },
                    withoutFingerprintValue: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "withoutFingerprintValue", '')
                    },
                    year: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "year", '')
                    },
                    voterKey: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "voterKey", '')
                    },
                    surname: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "surname", '')
                    },
                    motherSurname: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "motherSurname", '')
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "customerName", '')
                    },
                    yearEmission: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "yearEmission", '')
                    },
                    credentialNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "credentialNumber", '')
                    },
                    rightFinger: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "rightFinger", 0)
                    },
                    leftFinger: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "leftFinger", 0)
                    },
                    hash: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "hash", 0)
                    },
                    registrySituation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "registrySituation", '')
                    },
                    typeTheftReport: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "typeTheftReport", '')
                    },
                    ocr: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "ocr", '')
                    },
                    cic: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "cic", '')
                    },
                    curp: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "curp", '')
                    },
                    birthCity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "birthCity", '')
                    },
                    birthDay: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "birthDay", '')
                    },
                    channel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "channel", '')
                    },
                    buc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Customer", "buc", '')
                    }
                }
            });
            $scope.vc.model.Customer = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CUSTOMEE_6806';
                            var queryRequest = $scope.vc.getRequestQuery_Q_CUSTOMEE_6806();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6806_82610',
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
                    model: $scope.vc.types.Customer
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6806_82610").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CUSTOMEE_6806 = $scope.vc.model.Customer;
            $scope.vc.trackers.Customer = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Customer);
            $scope.vc.model.Customer.bind('change', function(e) {
                $scope.vc.trackers.Customer.track(e);
            });
            $scope.vc.grids.QV_6806_82610 = {};
            $scope.vc.grids.QV_6806_82610.queryId = 'Q_CUSTOMEE_6806';
            $scope.vc.viewState.QV_6806_82610 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6806_82610.column = {};
            $scope.vc.grids.QV_6806_82610.editable = false;
            $scope.vc.grids.QV_6806_82610.events = {
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
                    $scope.vc.trackers.Customer.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6806_82610.selectedRow = e.model;
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'Customer',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_6806_82610", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_6806_82610");
                    $scope.vc.hideShowColumns("QV_6806_82610", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6806_82610.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6806_82610.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6806_82610.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6806_82610 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6806_82610 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_6806_82610.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6806_82610.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6806_82610.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6806_82610.column.sequential = {
                title: 'BMTRC.LBL_BMTRC_SECUENCIA_83496',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCCH_386515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT98_SEQUENTT928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.sequential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCCH_386515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.sequential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6806_82610.column.sequential.format",
                        'k-decimals': "vc.viewState.QV_6806_82610.column.sequential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.sequential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.idCustomer = {
                title: 'BMTRC.LBL_BMTRC_IDCLIENEE_91101',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCWW_612515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT56_IDCUSTMR928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.idCustomer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCWW_612515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.idCustomer.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6806_82610.column.idCustomer.format",
                        'k-decimals': "vc.viewState.QV_6806_82610.column.idCustomer.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.idCustomer.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.customer = {
                title: 'BMTRC.LBL_BMTRC_CLIENTENZ_54095',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNXL_677515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT54_CUSTOMRE928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.customer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNXL_677515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.customer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.customer.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.role = {
                title: 'BMTRC.LBL_BMTRC_ROLPQHZPJ_78022',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBJQ_709515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT38_ROLELRKC928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.role.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBJQ_709515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.role.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.role.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.amount = {
                title: 'BMTRC.LBL_BMTRC_MONTOKRLB_26966',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSVM_225515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT87_AMOUNTFR928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSVM_225515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6806_82610.column.amount.format",
                        'k-decimals': "vc.viewState.QV_6806_82610.column.amount.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.withoutFingerprint = {
                title: 'BMTRC.LBL_BMTRC_SINHUELLL_21053',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXITPMJYY_954515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT46_WITHOUGR928 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.withoutFingerprint.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CHECKBOXITPMJYY_954515",
                        'ng-class': 'vc.viewState.QV_6806_82610.column.withoutFingerprint.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.validationStatus = {
                title: 'BMTRC.LBL_BMTRC_ESTADOCGT_81458',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXITJ_402515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT81_VALIDASO928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.validationStatus.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXITJ_402515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.validationStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.validationStatus.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.withoutFingerprintValue = {
                title: 'withoutFingerprintValue',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRBE_118515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT42_WITHOUVI928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.withoutFingerprintValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRBE_118515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.withoutFingerprintValue.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.withoutFingerprintValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.year = {
                title: 'year',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRQC_442515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT23_YEARRIJK928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.year.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRQC_442515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.year.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.year.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.voterKey = {
                title: 'voterKey',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWVJ_257515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT85_VOTERKEE928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.voterKey.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWVJ_257515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.voterKey.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.voterKey.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.surname = {
                title: 'surname',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIEQ_897515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT76_SURNAMEE928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.surname.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIEQ_897515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.surname.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.surname.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.motherSurname = {
                title: 'motherSurname',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEAI_981515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT30_MOTHERRU928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.motherSurname.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEAI_981515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.motherSurname.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.motherSurname.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.customerName = {
                title: 'customerName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXGN_558515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT87_CUSTOMMR928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXGN_558515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.yearEmission = {
                title: 'yearEmission',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZCD_900515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT97_YEAREMIS928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.yearEmission.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZCD_900515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.yearEmission.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.yearEmission.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.credentialNumber = {
                title: 'credentialNumber',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWDO_179515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT40_CREDENET928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.credentialNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWDO_179515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.credentialNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.credentialNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.rightFinger = {
                title: 'rightFinger',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNRP_963515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT60_RIGHTFEE928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.rightFinger.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNRP_963515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.rightFinger.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6806_82610.column.rightFinger.format",
                        'k-decimals': "vc.viewState.QV_6806_82610.column.rightFinger.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.rightFinger.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.leftFinger = {
                title: 'leftFinger',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRVU_624515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT29_LEFTFIRG928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.leftFinger.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRVU_624515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.leftFinger.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6806_82610.column.leftFinger.format",
                        'k-decimals': "vc.viewState.QV_6806_82610.column.leftFinger.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.leftFinger.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.hash = {
                title: 'hash',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXFU_874515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT49_HASHHCFR928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.hash.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXFU_874515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.hash.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6806_82610.column.hash.format",
                        'k-decimals': "vc.viewState.QV_6806_82610.column.hash.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.hash.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.registrySituation = {
                title: 'registrySituation',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGDK_301515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT32_REGISTIU928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.registrySituation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGDK_301515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.registrySituation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.registrySituation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.typeTheftReport = {
                title: 'typeTheftReport',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVRD_380515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT78_TYPETHRE928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.typeTheftReport.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVRD_380515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.typeTheftReport.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.typeTheftReport.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.ocr = {
                title: 'ocr',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOEN_307515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT83_OCRDITSJ928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.ocr.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOEN_307515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.ocr.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.ocr.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.cic = {
                title: 'cic',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKCV_501515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT54_CICVFQGP928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.cic.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKCV_501515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.cic.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.cic.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.curp = {
                title: 'curp',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSHS_270515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT52_CURPHDQH928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.curp.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSHS_270515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.curp.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.curp.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.birthCity = {
                title: 'birthCity',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMCG_676515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT46_BIRTHCYI928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.birthCity.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMCG_676515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.birthCity.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.birthCity.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.birthDay = {
                title: 'birthDay',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTKP_778515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT39_BIRTHDTA928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.birthDay.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTKP_778515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.birthDay.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.birthDay.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.channel = {
                title: 'channel',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEJO_691515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT53_CHANNELL928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.channel.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEJO_691515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.channel.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.channel.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6806_82610.column.buc = {
                title: 'buc',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVDK_320515',
                element: []
            };
            $scope.vc.grids.QV_6806_82610.AT69_BUCRNBLB928 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6806_82610.column.buc.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVDK_320515",
                        'data-validation-code': "{{vc.viewState.QV_6806_82610.column.buc.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6806_82610.column.buc.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'sequential',
                    title: '{{vc.viewState.QV_6806_82610.column.sequential.title|translate:vc.viewState.QV_6806_82610.column.sequential.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.sequential.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.sequential.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT98_SEQUENTT928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.sequential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequential, \"QV_6806_82610\", \"sequential\"):kendo.toString(#=sequential#, vc.viewState.QV_6806_82610.column.sequential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6806_82610.column.sequential.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.sequential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.sequential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'idCustomer',
                    title: '{{vc.viewState.QV_6806_82610.column.idCustomer.title|translate:vc.viewState.QV_6806_82610.column.idCustomer.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.idCustomer.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.idCustomer.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT56_IDCUSTMR928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.idCustomer.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.idCustomer, \"QV_6806_82610\", \"idCustomer\"):kendo.toString(#=idCustomer#, vc.viewState.QV_6806_82610.column.idCustomer.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6806_82610.column.idCustomer.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.idCustomer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.idCustomer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'customer',
                    title: '{{vc.viewState.QV_6806_82610.column.customer.title|translate:vc.viewState.QV_6806_82610.column.customer.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.customer.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.customer.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT54_CUSTOMRE928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.customer.style' ng-bind='vc.getStringColumnFormat(dataItem.customer, \"QV_6806_82610\", \"customer\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.customer.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.customer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.customer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'role',
                    title: '{{vc.viewState.QV_6806_82610.column.role.title|translate:vc.viewState.QV_6806_82610.column.role.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.role.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.role.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT38_ROLELRKC928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.role.style' ng-bind='vc.getStringColumnFormat(dataItem.role, \"QV_6806_82610\", \"role\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.role.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_6806_82610.column.amount.title|translate:vc.viewState.QV_6806_82610.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.amount.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.amount.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT87_AMOUNTFR928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_6806_82610\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_6806_82610.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6806_82610.column.amount.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'withoutFingerprint',
                    title: '{{vc.viewState.QV_6806_82610.column.withoutFingerprint.title|translate:vc.viewState.QV_6806_82610.column.withoutFingerprint.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.withoutFingerprint.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.withoutFingerprint.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6806_82610', 'withoutFingerprint', $scope.vc.grids.QV_6806_82610.AT46_WITHOUGR928.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6806_82610', 'withoutFingerprint', "<input name='withoutFingerprint' type='checkbox' value='#=withoutFingerprint#' #=withoutFingerprint?checked='checked':''# disabled='disabled' data-bind='value:withoutFingerprint' ng-class='vc.viewState.QV_6806_82610.column.withoutFingerprint.style' />"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.withoutFingerprint.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.withoutFingerprint.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.withoutFingerprint.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'validationStatus',
                    title: '{{vc.viewState.QV_6806_82610.column.validationStatus.title|translate:vc.viewState.QV_6806_82610.column.validationStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.validationStatus.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.validationStatus.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT81_VALIDASO928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.validationStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.validationStatus, \"QV_6806_82610\", \"validationStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.validationStatus.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.validationStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.validationStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'withoutFingerprintValue',
                    title: '{{vc.viewState.QV_6806_82610.column.withoutFingerprintValue.title|translate:vc.viewState.QV_6806_82610.column.withoutFingerprintValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.withoutFingerprintValue.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.withoutFingerprintValue.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT42_WITHOUVI928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.withoutFingerprintValue.style' ng-bind='vc.getStringColumnFormat(dataItem.withoutFingerprintValue, \"QV_6806_82610\", \"withoutFingerprintValue\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.withoutFingerprintValue.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.withoutFingerprintValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.withoutFingerprintValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'year',
                    title: '{{vc.viewState.QV_6806_82610.column.year.title|translate:vc.viewState.QV_6806_82610.column.year.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.year.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.year.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT23_YEARRIJK928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.year.style' ng-bind='vc.getStringColumnFormat(dataItem.year, \"QV_6806_82610\", \"year\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.year.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.year.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.year.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'voterKey',
                    title: '{{vc.viewState.QV_6806_82610.column.voterKey.title|translate:vc.viewState.QV_6806_82610.column.voterKey.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.voterKey.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.voterKey.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT85_VOTERKEE928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.voterKey.style' ng-bind='vc.getStringColumnFormat(dataItem.voterKey, \"QV_6806_82610\", \"voterKey\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.voterKey.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.voterKey.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.voterKey.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'surname',
                    title: '{{vc.viewState.QV_6806_82610.column.surname.title|translate:vc.viewState.QV_6806_82610.column.surname.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.surname.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.surname.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT76_SURNAMEE928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.surname.style' ng-bind='vc.getStringColumnFormat(dataItem.surname, \"QV_6806_82610\", \"surname\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.surname.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.surname.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.surname.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'motherSurname',
                    title: '{{vc.viewState.QV_6806_82610.column.motherSurname.title|translate:vc.viewState.QV_6806_82610.column.motherSurname.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.motherSurname.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.motherSurname.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT30_MOTHERRU928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.motherSurname.style' ng-bind='vc.getStringColumnFormat(dataItem.motherSurname, \"QV_6806_82610\", \"motherSurname\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.motherSurname.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.motherSurname.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.motherSurname.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_6806_82610.column.customerName.title|translate:vc.viewState.QV_6806_82610.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.customerName.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.customerName.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT87_CUSTOMMR928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_6806_82610\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.customerName.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'yearEmission',
                    title: '{{vc.viewState.QV_6806_82610.column.yearEmission.title|translate:vc.viewState.QV_6806_82610.column.yearEmission.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.yearEmission.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.yearEmission.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT97_YEAREMIS928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.yearEmission.style' ng-bind='vc.getStringColumnFormat(dataItem.yearEmission, \"QV_6806_82610\", \"yearEmission\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.yearEmission.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.yearEmission.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.yearEmission.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'credentialNumber',
                    title: '{{vc.viewState.QV_6806_82610.column.credentialNumber.title|translate:vc.viewState.QV_6806_82610.column.credentialNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.credentialNumber.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.credentialNumber.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT40_CREDENET928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.credentialNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.credentialNumber, \"QV_6806_82610\", \"credentialNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.credentialNumber.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.credentialNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.credentialNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'rightFinger',
                    title: '{{vc.viewState.QV_6806_82610.column.rightFinger.title|translate:vc.viewState.QV_6806_82610.column.rightFinger.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.rightFinger.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.rightFinger.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT60_RIGHTFEE928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.rightFinger.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.rightFinger, \"QV_6806_82610\", \"rightFinger\"):kendo.toString(#=rightFinger#, vc.viewState.QV_6806_82610.column.rightFinger.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6806_82610.column.rightFinger.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.rightFinger.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.rightFinger.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'leftFinger',
                    title: '{{vc.viewState.QV_6806_82610.column.leftFinger.title|translate:vc.viewState.QV_6806_82610.column.leftFinger.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.leftFinger.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.leftFinger.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT29_LEFTFIRG928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.leftFinger.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.leftFinger, \"QV_6806_82610\", \"leftFinger\"):kendo.toString(#=leftFinger#, vc.viewState.QV_6806_82610.column.leftFinger.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6806_82610.column.leftFinger.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.leftFinger.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.leftFinger.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'hash',
                    title: '{{vc.viewState.QV_6806_82610.column.hash.title|translate:vc.viewState.QV_6806_82610.column.hash.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.hash.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.hash.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT49_HASHHCFR928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.hash.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.hash, \"QV_6806_82610\", \"hash\"):kendo.toString(#=hash#, vc.viewState.QV_6806_82610.column.hash.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6806_82610.column.hash.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.hash.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.hash.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'registrySituation',
                    title: '{{vc.viewState.QV_6806_82610.column.registrySituation.title|translate:vc.viewState.QV_6806_82610.column.registrySituation.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.registrySituation.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.registrySituation.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT32_REGISTIU928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.registrySituation.style' ng-bind='vc.getStringColumnFormat(dataItem.registrySituation, \"QV_6806_82610\", \"registrySituation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.registrySituation.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.registrySituation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.registrySituation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'typeTheftReport',
                    title: '{{vc.viewState.QV_6806_82610.column.typeTheftReport.title|translate:vc.viewState.QV_6806_82610.column.typeTheftReport.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.typeTheftReport.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.typeTheftReport.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT78_TYPETHRE928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.typeTheftReport.style' ng-bind='vc.getStringColumnFormat(dataItem.typeTheftReport, \"QV_6806_82610\", \"typeTheftReport\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.typeTheftReport.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.typeTheftReport.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.typeTheftReport.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'ocr',
                    title: '{{vc.viewState.QV_6806_82610.column.ocr.title|translate:vc.viewState.QV_6806_82610.column.ocr.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.ocr.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.ocr.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT83_OCRDITSJ928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.ocr.style' ng-bind='vc.getStringColumnFormat(dataItem.ocr, \"QV_6806_82610\", \"ocr\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.ocr.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.ocr.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.ocr.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'cic',
                    title: '{{vc.viewState.QV_6806_82610.column.cic.title|translate:vc.viewState.QV_6806_82610.column.cic.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.cic.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.cic.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT54_CICVFQGP928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.cic.style' ng-bind='vc.getStringColumnFormat(dataItem.cic, \"QV_6806_82610\", \"cic\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.cic.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.cic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.cic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'curp',
                    title: '{{vc.viewState.QV_6806_82610.column.curp.title|translate:vc.viewState.QV_6806_82610.column.curp.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.curp.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.curp.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT52_CURPHDQH928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.curp.style' ng-bind='vc.getStringColumnFormat(dataItem.curp, \"QV_6806_82610\", \"curp\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.curp.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.curp.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.curp.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'birthCity',
                    title: '{{vc.viewState.QV_6806_82610.column.birthCity.title|translate:vc.viewState.QV_6806_82610.column.birthCity.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.birthCity.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.birthCity.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT46_BIRTHCYI928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.birthCity.style' ng-bind='vc.getStringColumnFormat(dataItem.birthCity, \"QV_6806_82610\", \"birthCity\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.birthCity.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.birthCity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.birthCity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'birthDay',
                    title: '{{vc.viewState.QV_6806_82610.column.birthDay.title|translate:vc.viewState.QV_6806_82610.column.birthDay.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.birthDay.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.birthDay.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT39_BIRTHDTA928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.birthDay.style' ng-bind='vc.getStringColumnFormat(dataItem.birthDay, \"QV_6806_82610\", \"birthDay\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.birthDay.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.birthDay.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.birthDay.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'channel',
                    title: '{{vc.viewState.QV_6806_82610.column.channel.title|translate:vc.viewState.QV_6806_82610.column.channel.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.channel.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.channel.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT53_CHANNELL928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.channel.style' ng-bind='vc.getStringColumnFormat(dataItem.channel, \"QV_6806_82610\", \"channel\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.channel.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.channel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.channel.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'buc',
                    title: '{{vc.viewState.QV_6806_82610.column.buc.title|translate:vc.viewState.QV_6806_82610.column.buc.titleArgs}}',
                    width: $scope.vc.viewState.QV_6806_82610.column.buc.width,
                    format: $scope.vc.viewState.QV_6806_82610.column.buc.format,
                    editor: $scope.vc.grids.QV_6806_82610.AT69_BUCRNBLB928.control,
                    template: "<span ng-class='vc.viewState.QV_6806_82610.column.buc.style' ng-bind='vc.getStringColumnFormat(dataItem.buc, \"QV_6806_82610\", \"buc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6806_82610.column.buc.style",
                        "title": "{{vc.viewState.QV_6806_82610.column.buc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.buc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515 = {
                    tooltip: '',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515)) {
                    $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515 = {};
                }
                $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515.hidden = false;
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'VA_GRIDROWCOMMMDNN_192515',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMDNN_192515",
                        entity: "Customer",
                        text: "{{'BMTRC.LBL_BMTRC_VALIDARCP_27431'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmdnn':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMDNN_192515\", " + "vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515.enabled || vc.viewState.G_BIOMETRALD_208515.disabled' " + "data-ng-click = 'vc.grids.QV_6806_82610.events.customRowClick($event, \"VA_GRIDROWCOMMMDNN_192515\", \"#:entity#\", \"QV_6806_82610\")' " + "title = \"{{vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515.tooltip|translate}}\" " + "href = '\\#'>" + "#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMDNN_192515.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515 = {
                    tooltip: 'BMTRC.LBL_BMTRC_DOCUMENOO_55979',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515)) {
                    $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515 = {};
                }
                $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515.hidden = false;
                $scope.vc.grids.QV_6806_82610.columns.push({
                    field: 'VA_GRIDROWCOMMMNAN_197515',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNAN_197515",
                        entity: "Customer",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmnan':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNAN_197515\", " + "vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515.enabled || vc.viewState.G_BIOMETRALD_208515.disabled' " + "data-ng-click = 'vc.grids.QV_6806_82610.events.customRowClick($event, \"VA_GRIDROWCOMMMNAN_197515\", \"#:entity#\", \"QV_6806_82610\")' " + "title = \"{{vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_6806_82610.column.VA_GRIDROWCOMMMNAN_197515.hidden
                });
            }
            $scope.vc.viewState.QV_6806_82610.toolbar = {}
            $scope.vc.grids.QV_6806_82610.toolbar = [];
            $scope.vc.model.ValidationData = {
                customerId: $scope.vc.channelDefaultValues("ValidationData", "customerId"),
                customerName: $scope.vc.channelDefaultValues("ValidationData", "customerName"),
                processInstance: $scope.vc.channelDefaultValues("ValidationData", "processInstance"),
                userKey: $scope.vc.channelDefaultValues("ValidationData", "userKey"),
                resultValidation: $scope.vc.channelDefaultValues("ValidationData", "resultValidation"),
                customerType: $scope.vc.channelDefaultValues("ValidationData", "customerType"),
                office: $scope.vc.channelDefaultValues("ValidationData", "office"),
                cycleNumber: $scope.vc.channelDefaultValues("ValidationData", "cycleNumber")
            };
            //ViewState - Group: Group1773
            $scope.vc.createViewState({
                id: "G_BIOMETRTIC_762515",
                hasId: true,
                componentStyle: [],
                label: 'Group1773',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValidationData, Attribute: resultValidation
            $scope.vc.createViewState({
                id: "VA_RESULTVALIDAIOT_362515",
                componentStyle: [],
                label: "BMTRC.LBL_BMTRC_ESTADODOG_28084",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONVNZFJKQ_704515",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BMTRCXBFSYZSS_339_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BMTRCXBFSYZSS_339_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TBMTRCXB_T69",
                componentStyle: [],
                label: "BMTRC.LBL_BMTRC_GUARDARWD_23610",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Credit = {
                productType: $scope.vc.channelDefaultValues("Credit", "productType"),
                officeName: $scope.vc.channelDefaultValues("Credit", "officeName"),
                cycleNumber: $scope.vc.channelDefaultValues("Credit", "cycleNumber"),
                creditCode: $scope.vc.channelDefaultValues("Credit", "creditCode"),
                amountRequested: $scope.vc.channelDefaultValues("Credit", "amountRequested"),
                sector: $scope.vc.channelDefaultValues("Credit", "sector"),
                operationNumber: $scope.vc.channelDefaultValues("Credit", "operationNumber"),
                approvedAmount: $scope.vc.channelDefaultValues("Credit", "approvedAmount"),
                paymentFrecuency: $scope.vc.channelDefaultValues("Credit", "paymentFrecuency"),
                applicationNumber: $scope.vc.channelDefaultValues("Credit", "applicationNumber"),
                term: $scope.vc.channelDefaultValues("Credit", "term"),
                office: $scope.vc.channelDefaultValues("Credit", "office"),
                amount: $scope.vc.channelDefaultValues("Credit", "amount")
            };
            $scope.vc.model.AdditionalInformation = {
                environment: $scope.vc.channelDefaultValues("AdditionalInformation", "environment")
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
                $scope.vc.render('VC_BIOVALIDSA_412339');
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
    var cobisMainModule = cobis.createModule("VC_BIOVALIDSA_412339", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BMTRC"]);
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
        $routeProvider.when("/VC_BIOVALIDSA_412339", {
            templateUrl: "VC_BIOVALIDSA_412339_FORM.html",
            controller: "VC_BIOVALIDSA_412339_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BMTRC');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_BIOVALIDSA_412339?" + $.param(search);
            }
        });
        VC_BIOVALIDSA_412339(cobisMainModule);
    }]);
} else {
    VC_BIOVALIDSA_412339(cobisMainModule);
}