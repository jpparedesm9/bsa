//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.massivepayment = designerEvents.api.massivepayment || designer.dsgEvents();

function VC_MASSIVEPTY_109349(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MASSIVEPTY_109349_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MASSIVEPTY_109349_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSEUQOESBB_349",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MASSIVEPTY_109349",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_ASSTSEUQOESBB_349",
        designerEvents.api.massivepayment,
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
                vcName: 'VC_MASSIVEPTY_109349'
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
                    taskId: 'T_ASSTSEUQOESBB_349',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    MassivePaymentRecord: "MassivePaymentRecord",
                    MassivePaymentFile: "MassivePaymentFile"
                },
                entities: {
                    MassivePaymentRecord: {
                        reference: 'AT15_REFERENE261',
                        paymentDate: 'AT18_PAYMENAE261',
                        rowNumber: 'AT37_ROWNUMER261',
                        observations: 'AT38_OBSERVAN261',
                        amount: 'AT53_AMOUNTIE261',
                        paymentMethod: 'AT67_PAYMENHD261',
                        corresponsalCode: 'AT86_CORRESSA261',
                        _pks: [],
                        _entityId: 'EN_MASSIVEEM_261',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    MassivePaymentFile: {
                        processedRecords: 'AT23_PROCESOD375',
                        fileObservations: 'AT34_FILEOBEO375',
                        processedAmount: 'AT58_PROCESTU375',
                        fileName: 'AT82_FILENAME375',
                        _pks: [],
                        _entityId: 'EN_MASSIVEFA_375',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_MASSIVEE_3035 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_MASSIVEE_3035 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MASSIVEE_3035_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MASSIVEE_3035_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MASSIVEEM_261',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MASSIVEE_3035',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_MASSIVEE_3035_filters = {};
            var defaultValues = {
                MassivePaymentRecord: {},
                MassivePaymentFile: {}
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
                $scope.vc.execute("temporarySave", VC_MASSIVEPTY_109349, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MASSIVEPTY_109349, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MASSIVEPTY_109349, data, function() {});
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
            $scope.vc.viewState.VC_MASSIVEPTY_109349 = {
                style: []
            }
            $scope.vc.model.MassivePaymentFile = {
                processedRecords: $scope.vc.channelDefaultValues("MassivePaymentFile", "processedRecords"),
                fileObservations: $scope.vc.channelDefaultValues("MassivePaymentFile", "fileObservations"),
                processedAmount: $scope.vc.channelDefaultValues("MassivePaymentFile", "processedAmount"),
                fileName: $scope.vc.channelDefaultValues("MassivePaymentFile", "fileName")
            };
            //ViewState - Group: Group1708
            $scope.vc.createViewState({
                id: "G_MASSIVETYY_524263",
                hasId: true,
                componentStyle: [],
                label: 'Group1708',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MassivePaymentFile, Attribute: fileName
            $scope.vc.createViewState({
                id: "VA_1OTMQVYBJOEHUHZ_818263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CARGARAVI_75931",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.viewState.VA_1OTMQVYBJOEHUHZ_818263.disableUpload = false;
            $scope.vc.viewState.uploadVisible = true;
            $scope.vc.uploaders.VA_1OTMQVYBJOEHUHZ_818263 = {
                maxSizeInMB: 10,
                relativePath: null,
                confirmUpload: false,
                visualAttributeModel: 'vc.model.MassivePaymentFile.fileName',
                fileUploadAPI: null
            };
            $scope.vc.createViewState({
                id: "Spacer2475",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONDGDOXOG_649263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CARGARPOO_74793",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONMYCSNRW_701263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APLICARGO_52527",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONVBEQBSD_442263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_LIMPIARBR_19991",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONGTRMBBC_889263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_EJECUTAPG_41960",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: MassivePaymentFile, Attribute: fileObservations
            $scope.vc.createViewState({
                id: "VA_9939YRHGHTTGZIP_333263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OBSERVACC_15377",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MassivePaymentFile, Attribute: processedRecords
            $scope.vc.createViewState({
                id: "VA_5024RNPWSHZKYMR_530263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REGISTRSS_92389",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MassivePaymentFile, Attribute: processedAmount
            $scope.vc.createViewState({
                id: "VA_3954FXWSKTHWQYJ_157263",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONTOPRSO_74489",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1466
            $scope.vc.createViewState({
                id: "G_MASSIVEPYT_103263",
                hasId: true,
                componentStyle: [],
                label: 'Group1466',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.MassivePaymentRecord = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    rowNumber: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MassivePaymentRecord", "rowNumber", 0)
                    },
                    paymentDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MassivePaymentRecord", "paymentDate", '')
                    },
                    reference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MassivePaymentRecord", "reference", '')
                    },
                    amount: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MassivePaymentRecord", "amount", '')
                    },
                    paymentMethod: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MassivePaymentRecord", "paymentMethod", '')
                    },
                    corresponsalCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MassivePaymentRecord", "corresponsalCode", '')
                    },
                    observations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MassivePaymentRecord", "observations", '')
                    }
                }
            });
            $scope.vc.model.MassivePaymentRecord = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_MASSIVEE_3035';
                            var queryRequest = $scope.vc.getRequestQuery_Q_MASSIVEE_3035();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3035_86132',
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
                    model: $scope.vc.types.MassivePaymentRecord
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3035_86132").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MASSIVEE_3035 = $scope.vc.model.MassivePaymentRecord;
            $scope.vc.trackers.MassivePaymentRecord = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.MassivePaymentRecord);
            $scope.vc.model.MassivePaymentRecord.bind('change', function(e) {
                $scope.vc.trackers.MassivePaymentRecord.track(e);
            });
            $scope.vc.grids.QV_3035_86132 = {};
            $scope.vc.grids.QV_3035_86132.queryId = 'Q_MASSIVEE_3035';
            $scope.vc.viewState.QV_3035_86132 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3035_86132.column = {};
            $scope.vc.grids.QV_3035_86132.editable = false;
            $scope.vc.grids.QV_3035_86132.events = {
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
                    $scope.vc.trackers.MassivePaymentRecord.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3035_86132.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_3035_86132");
                    $scope.vc.hideShowColumns("QV_3035_86132", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3035_86132.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3035_86132.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3035_86132.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3035_86132 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3035_86132 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3035_86132.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3035_86132.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3035_86132.column.rowNumber = {
                title: 'ASSTS.LBL_ASSTS_NROFILAAE_26520',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVLL_370263',
                element: []
            };
            $scope.vc.grids.QV_3035_86132.AT37_ROWNUMER261 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3035_86132.column.rowNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVLL_370263",
                        'data-validation-code': "{{vc.viewState.QV_3035_86132.column.rowNumber.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3035_86132.column.rowNumber.format",
                        'k-decimals': "vc.viewState.QV_3035_86132.column.rowNumber.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3035_86132.column.rowNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3035_86132.column.paymentDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAPAOG_28145',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHJI_455263',
                element: []
            };
            $scope.vc.grids.QV_3035_86132.AT18_PAYMENAE261 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3035_86132.column.paymentDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHJI_455263",
                        'data-validation-code': "{{vc.viewState.QV_3035_86132.column.paymentDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3035_86132.column.paymentDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3035_86132.column.reference = {
                title: 'ASSTS.LBL_ASSTS_REFERENAI_72258',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGKR_209263',
                element: []
            };
            $scope.vc.grids.QV_3035_86132.AT15_REFERENE261 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3035_86132.column.reference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGKR_209263",
                        'data-validation-code': "{{vc.viewState.QV_3035_86132.column.reference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3035_86132.column.reference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3035_86132.column.amount = {
                title: 'ASSTS.LBL_ASSTS_MONTOEMFX_52083',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZKN_697263',
                element: []
            };
            $scope.vc.grids.QV_3035_86132.AT53_AMOUNTIE261 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3035_86132.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZKN_697263",
                        'data-validation-code': "{{vc.viewState.QV_3035_86132.column.amount.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3035_86132.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3035_86132.column.paymentMethod = {
                title: 'ASSTS.LBL_ASSTS_APAGOUKPC_13431',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJQP_153263',
                element: []
            };
            $scope.vc.grids.QV_3035_86132.AT67_PAYMENHD261 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3035_86132.column.paymentMethod.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJQP_153263",
                        'data-validation-code': "{{vc.viewState.QV_3035_86132.column.paymentMethod.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3035_86132.column.paymentMethod.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3035_86132.column.corresponsalCode = {
                title: 'ASSTS.LBL_ASSTS_IDTRNCOEL_13292',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXONK_759263',
                element: []
            };
            $scope.vc.grids.QV_3035_86132.AT86_CORRESSA261 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3035_86132.column.corresponsalCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXONK_759263",
                        'data-validation-code': "{{vc.viewState.QV_3035_86132.column.corresponsalCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3035_86132.column.corresponsalCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3035_86132.column.observations = {
                title: 'ASSTS.LBL_ASSTS_OBSERVACC_15377',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVZV_510263',
                element: []
            };
            $scope.vc.grids.QV_3035_86132.AT38_OBSERVAN261 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3035_86132.column.observations.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVZV_510263",
                        'data-validation-code': "{{vc.viewState.QV_3035_86132.column.observations.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3035_86132.column.observations.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3035_86132.columns.push({
                    field: 'rowNumber',
                    title: '{{vc.viewState.QV_3035_86132.column.rowNumber.title|translate:vc.viewState.QV_3035_86132.column.rowNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_3035_86132.column.rowNumber.width,
                    format: $scope.vc.viewState.QV_3035_86132.column.rowNumber.format,
                    editor: $scope.vc.grids.QV_3035_86132.AT37_ROWNUMER261.control,
                    template: "<span ng-class='vc.viewState.QV_3035_86132.column.rowNumber.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.rowNumber, \"QV_3035_86132\", \"rowNumber\"):kendo.toString(#=rowNumber#, vc.viewState.QV_3035_86132.column.rowNumber.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3035_86132.column.rowNumber.style",
                        "title": "{{vc.viewState.QV_3035_86132.column.rowNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3035_86132.column.rowNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3035_86132.columns.push({
                    field: 'paymentDate',
                    title: '{{vc.viewState.QV_3035_86132.column.paymentDate.title|translate:vc.viewState.QV_3035_86132.column.paymentDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3035_86132.column.paymentDate.width,
                    format: $scope.vc.viewState.QV_3035_86132.column.paymentDate.format,
                    editor: $scope.vc.grids.QV_3035_86132.AT18_PAYMENAE261.control,
                    template: "<span ng-class='vc.viewState.QV_3035_86132.column.paymentDate.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentDate, \"QV_3035_86132\", \"paymentDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3035_86132.column.paymentDate.style",
                        "title": "{{vc.viewState.QV_3035_86132.column.paymentDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3035_86132.column.paymentDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3035_86132.columns.push({
                    field: 'reference',
                    title: '{{vc.viewState.QV_3035_86132.column.reference.title|translate:vc.viewState.QV_3035_86132.column.reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_3035_86132.column.reference.width,
                    format: $scope.vc.viewState.QV_3035_86132.column.reference.format,
                    editor: $scope.vc.grids.QV_3035_86132.AT15_REFERENE261.control,
                    template: "<span ng-class='vc.viewState.QV_3035_86132.column.reference.style' ng-bind='vc.getStringColumnFormat(dataItem.reference, \"QV_3035_86132\", \"reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3035_86132.column.reference.style",
                        "title": "{{vc.viewState.QV_3035_86132.column.reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3035_86132.column.reference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3035_86132.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_3035_86132.column.amount.title|translate:vc.viewState.QV_3035_86132.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_3035_86132.column.amount.width,
                    format: $scope.vc.viewState.QV_3035_86132.column.amount.format,
                    editor: $scope.vc.grids.QV_3035_86132.AT53_AMOUNTIE261.control,
                    template: "<span ng-class='vc.viewState.QV_3035_86132.column.amount.style' ng-bind='vc.getStringColumnFormat(dataItem.amount, \"QV_3035_86132\", \"amount\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3035_86132.column.amount.style",
                        "title": "{{vc.viewState.QV_3035_86132.column.amount.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3035_86132.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3035_86132.columns.push({
                    field: 'paymentMethod',
                    title: '{{vc.viewState.QV_3035_86132.column.paymentMethod.title|translate:vc.viewState.QV_3035_86132.column.paymentMethod.titleArgs}}',
                    width: $scope.vc.viewState.QV_3035_86132.column.paymentMethod.width,
                    format: $scope.vc.viewState.QV_3035_86132.column.paymentMethod.format,
                    editor: $scope.vc.grids.QV_3035_86132.AT67_PAYMENHD261.control,
                    template: "<span ng-class='vc.viewState.QV_3035_86132.column.paymentMethod.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentMethod, \"QV_3035_86132\", \"paymentMethod\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3035_86132.column.paymentMethod.style",
                        "title": "{{vc.viewState.QV_3035_86132.column.paymentMethod.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3035_86132.column.paymentMethod.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3035_86132.columns.push({
                    field: 'corresponsalCode',
                    title: '{{vc.viewState.QV_3035_86132.column.corresponsalCode.title|translate:vc.viewState.QV_3035_86132.column.corresponsalCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_3035_86132.column.corresponsalCode.width,
                    format: $scope.vc.viewState.QV_3035_86132.column.corresponsalCode.format,
                    editor: $scope.vc.grids.QV_3035_86132.AT86_CORRESSA261.control,
                    template: "<span ng-class='vc.viewState.QV_3035_86132.column.corresponsalCode.style' ng-bind='vc.getStringColumnFormat(dataItem.corresponsalCode, \"QV_3035_86132\", \"corresponsalCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3035_86132.column.corresponsalCode.style",
                        "title": "{{vc.viewState.QV_3035_86132.column.corresponsalCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3035_86132.column.corresponsalCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3035_86132.columns.push({
                    field: 'observations',
                    title: '{{vc.viewState.QV_3035_86132.column.observations.title|translate:vc.viewState.QV_3035_86132.column.observations.titleArgs}}',
                    width: $scope.vc.viewState.QV_3035_86132.column.observations.width,
                    format: $scope.vc.viewState.QV_3035_86132.column.observations.format,
                    editor: $scope.vc.grids.QV_3035_86132.AT38_OBSERVAN261.control,
                    template: "<span ng-class='vc.viewState.QV_3035_86132.column.observations.style' ng-bind='vc.getStringColumnFormat(dataItem.observations, \"QV_3035_86132\", \"observations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3035_86132.column.observations.style",
                        "title": "{{vc.viewState.QV_3035_86132.column.observations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3035_86132.column.observations.hidden
                });
            }
            $scope.vc.viewState.QV_3035_86132.toolbar = {}
            $scope.vc.grids.QV_3035_86132.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSEUQOESBB_349_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSEUQOESBB_349_CANCEL",
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
                $scope.vc.render('VC_MASSIVEPTY_109349');
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
    var cobisMainModule = cobis.createModule("VC_MASSIVEPTY_109349", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_MASSIVEPTY_109349", {
            templateUrl: "VC_MASSIVEPTY_109349_FORM.html",
            controller: "VC_MASSIVEPTY_109349_CTRL",
            labelId: "ASSTS.LBL_ASSTS_CARGAMAAO_53639",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MASSIVEPTY_109349?" + $.param(search);
            }
        });
        VC_MASSIVEPTY_109349(cobisMainModule);
    }]);
} else {
    VC_MASSIVEPTY_109349(cobisMainModule);
}