//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.loadcollectiveperson = designerEvents.api.loadcollectiveperson || designer.dsgEvents();

function VC_LOADCOLLEV_719333(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LOADCOLLEV_719333_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LOADCOLLEV_719333_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "CLCOL",
            subModuleId: "CLTVO",
            taskId: "T_CLCOLIQAJNDTG_333",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LOADCOLLEV_719333",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CLCOL/CLTVO/T_CLCOLIQAJNDTG_333",
        designerEvents.api.loadcollectiveperson,
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
                vcName: 'VC_LOADCOLLEV_719333'
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
                    moduleId: 'CLCOL',
                    subModuleId: 'CLTVO',
                    taskId: 'T_CLCOLIQAJNDTG_333',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CollectiveProcessProgress: "CollectiveProcessProgress",
                    CollectivePersonRecord: "CollectivePersonRecord",
                    CollectivePersonFile: "CollectivePersonFile"
                },
                entities: {
                    CollectiveProcessProgress: {
                        progress: 'AT91_PROGRESS545',
                        _pks: [],
                        _entityId: 'EN_COLLECTEC_545',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CollectivePersonRecord: {
                        numberExtAddress: 'AT13_NUMBERAT520',
                        streetAddress: 'AT15_STREETRD520',
                        surname: 'AT18_SURNAMEE520',
                        birthEntityDesc: 'AT24_BIRTHDCS520',
                        cellPhoneNumber: 'AT29_CELLPHRU520',
                        email: 'AT32_EMAILJQI520',
                        officeDesc: 'AT40_OFFICECC520',
                        secondSurname: 'AT41_SECONDRM520',
                        curp: 'AT43_CURPWUPS520',
                        birthDate: 'AT47_BIRTHDTT520',
                        gender: 'AT53_GENDERBB520',
                        colonyAddress: 'AT56_COLONYSE520',
                        cpAddress: 'AT57_CPADDRSE520',
                        periodicity: 'AT60_PERIODCI520',
                        officeId: 'AT66_OFFICEII520',
                        monthSales: 'AT68_MONTHSAS520',
                        observations: 'AT69_OBSERVNI520',
                        economicActivity: 'AT84_ECONOMYA520',
                        collectiveName: 'AT85_COLLECMT520',
                        numberChildren: 'AT85_NUMBERIH520',
                        birthEntity: 'AT86_BIRTHNYF520',
                        firstName: 'AT87_FIRSTNEM520',
                        officialLogin: 'AT87_OFFICIAL520',
                        clientLevel: 'AT89_CLIENTLL520',
                        secondName: 'AT89_SECONDEE520',
                        numberIntAddress: 'AT94_NUMBERRS520',
                        rfc: 'AT99_RFCLWVZN520',
                        _pks: [],
                        _entityId: 'EN_COLLECTDI_520',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CollectivePersonFile: {
                        successRecords: 'AT57_SUCCESSS310',
                        fileName: 'AT90_FILENAEM310',
                        _pks: [],
                        _entityId: 'EN_COLLECTIE_310',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_COLLECON_8718 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_COLLECON_8718 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_COLLECON_8718_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_COLLECON_8718_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_COLLECTDI_520',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_COLLECON_8718',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_COLLECON_8718_filters = {};
            var defaultValues = {
                CollectiveProcessProgress: {},
                CollectivePersonRecord: {},
                CollectivePersonFile: {}
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
                $scope.vc.execute("temporarySave", VC_LOADCOLLEV_719333, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LOADCOLLEV_719333, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LOADCOLLEV_719333, data, function() {});
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
            $scope.vc.viewState.VC_LOADCOLLEV_719333 = {
                style: []
            }
            $scope.vc.model.CollectivePersonFile = {
                successRecords: $scope.vc.channelDefaultValues("CollectivePersonFile", "successRecords"),
                fileName: $scope.vc.channelDefaultValues("CollectivePersonFile", "fileName")
            };
            //ViewState - Group: Group1820
            $scope.vc.createViewState({
                id: "G_LOADCOLNIE_561908",
                hasId: true,
                componentStyle: [],
                label: 'Group1820',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CollectivePersonFile, Attribute: fileName
            $scope.vc.createViewState({
                id: "VA_4965WEUNXYQPSHI_453908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_CARGARAHR_95357",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.viewState.VA_4965WEUNXYQPSHI_453908.disableUpload = false;
            $scope.vc.viewState.uploadVisible = true;
            $scope.vc.uploaders.VA_4965WEUNXYQPSHI_453908 = {
                maxSizeInMB: 10,
                relativePath: null,
                confirmUpload: false,
                visualAttributeModel: 'vc.model.CollectivePersonFile.fileName',
                fileUploadAPI: null
            };
            $scope.vc.createViewState({
                id: "VA_VABUTTONSFBIETG_385908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_CARGARNQG_59092",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONEHPSTNT_850908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_LIMPIAREZ_65308",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CollectiveProcessProgress = {
                progress: $scope.vc.channelDefaultValues("CollectiveProcessProgress", "progress")
            };
            //ViewState - Group: Group1598
            $scope.vc.createViewState({
                id: "G_LOADCOLIPC_406908",
                hasId: true,
                componentStyle: [],
                label: 'Group1598',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONUKAXPIV_480908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_PROCESARR_48223",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2594",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_216908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_PORCENTAR_13762",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_690908",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Group: Group1645
            $scope.vc.createViewState({
                id: "G_LOADCOLLRS_754908",
                hasId: true,
                componentStyle: [],
                label: 'Group1645',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CollectivePersonRecord = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    surname: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "surname", '')
                    },
                    secondSurname: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "secondSurname", '')
                    },
                    firstName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "firstName", '')
                    },
                    secondName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "secondName", '')
                    },
                    birthDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "birthDate", '')
                    },
                    birthEntity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "birthEntity", '')
                    },
                    birthEntityDesc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "birthEntityDesc", '')
                    },
                    gender: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "gender", '')
                    },
                    streetAddress: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "streetAddress", '')
                    },
                    numberIntAddress: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "numberIntAddress", '')
                    },
                    numberExtAddress: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "numberExtAddress", '')
                    },
                    colonyAddress: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "colonyAddress", '')
                    },
                    cpAddress: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "cpAddress", '')
                    },
                    email: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "email", '')
                    },
                    cellPhoneNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "cellPhoneNumber", '')
                    },
                    officeId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "officeId", '')
                    },
                    officeDesc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "officeDesc", '')
                    },
                    curp: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "curp", '')
                    },
                    rfc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "rfc", '')
                    },
                    collectiveName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "collectiveName", '')
                    },
                    clientLevel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "clientLevel", '')
                    },
                    economicActivity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "economicActivity", '')
                    },
                    monthSales: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "monthSales", '')
                    },
                    numberChildren: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "numberChildren", '')
                    },
                    periodicity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "periodicity", '')
                    },
                    officialLogin: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "officialLogin", '')
                    },
                    observations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectivePersonRecord", "observations", '')
                    }
                }
            });
            $scope.vc.model.CollectivePersonRecord = new kendo.data.DataSource({
                pageSize: 15,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_COLLECON_8718';
                            var queryRequest = $scope.vc.getRequestQuery_Q_COLLECON_8718();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_8718_49718',
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
                                            'pageSize': 15
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
                    model: $scope.vc.types.CollectivePersonRecord
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8718_49718").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_COLLECON_8718 = $scope.vc.model.CollectivePersonRecord;
            $scope.vc.trackers.CollectivePersonRecord = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CollectivePersonRecord);
            $scope.vc.model.CollectivePersonRecord.bind('change', function(e) {
                $scope.vc.trackers.CollectivePersonRecord.track(e);
            });
            $scope.vc.grids.QV_8718_49718 = {};
            $scope.vc.grids.QV_8718_49718.queryId = 'Q_COLLECON_8718';
            $scope.vc.viewState.QV_8718_49718 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8718_49718.column = {};
            $scope.vc.grids.QV_8718_49718.editable = false;
            $scope.vc.grids.QV_8718_49718.events = {
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
                    $scope.vc.trackers.CollectivePersonRecord.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_8718_49718.selectedRow = e.model;
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
                excelExport: function(e) {
                    $scope.vc.exportGrid(e, 'QV_8718_49718', this.dataSource);
                },
                excel: {
                    fileName: 'QV_8718_49718.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_8718_49718.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_8718_49718");
                    $scope.vc.hideShowColumns("QV_8718_49718", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8718_49718.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8718_49718.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8718_49718.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8718_49718 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8718_49718 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8718_49718.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8718_49718.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8718_49718.column.surname = {
                title: 'CLCOL.LBL_CLCOL_APELLIDNR_11089',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNQE_150908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT18_SURNAMEE520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.surname.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNQE_150908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.surname.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.surname.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.secondSurname = {
                title: 'CLCOL.LBL_CLCOL_APELLIDET_18074',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRFL_349908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT41_SECONDRM520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.secondSurname.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRFL_349908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.secondSurname.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.secondSurname.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.firstName = {
                title: 'CLCOL.LBL_CLCOL_PRIMERNEE_77429',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBIQ_134908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT87_FIRSTNEM520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.firstName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBIQ_134908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.firstName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.firstName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.secondName = {
                title: 'CLCOL.LBL_CLCOL_SEGUNDOOM_20350',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQWA_995908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT89_SECONDEE520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.secondName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQWA_995908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.secondName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.secondName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.birthDate = {
                title: 'CLCOL.LBL_CLCOL_FECHANAIM_57340',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMTB_557908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT47_BIRTHDTT520 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.birthDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMTB_557908",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.birthDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_8718_49718.column.birthDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.birthEntity = {
                title: 'CLCOL.LBL_CLCOL_FEDERALIC_36582',
                titleArgs: {},
                tooltip: '',
                width: 210,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRQK_205908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT86_BIRTHNYF520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.birthEntity.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRQK_205908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.birthEntity.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.birthEntity.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.birthEntityDesc = {
                title: 'CLCOL.LBL_CLCOL_FEDERALIC_36582',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFHJ_805908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT24_BIRTHDCS520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.birthEntityDesc.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFHJ_805908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.birthEntityDesc.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.birthEntityDesc.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.gender = {
                title: 'CLCOL.LBL_CLCOL_GENERONST_40494',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNBC_274908',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXNBC_274908 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXNBC_274908.data([{
                code: 'M',
                value: 'MASCULINO'
            }, {
                code: 'F',
                value: 'FEMENINO'
            }, {
                code: 'X',
                value: 'No Existe'
            }]);
            $scope.vc.grids.QV_8718_49718.AT53_GENDERBB520 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.gender.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNBC_274908",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_8718_49718.column.gender.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXNBC_274908",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_8718_49718.column.gender.template",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.gender.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.streetAddress = {
                title: 'CLCOL.LBL_CLCOL_CALLEDOIL_97002',
                titleArgs: {},
                tooltip: '',
                width: 160,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXONO_827908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT15_STREETRD520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.streetAddress.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXONO_827908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.streetAddress.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.streetAddress.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.numberIntAddress = {
                title: 'CLCOL.LBL_CLCOL_NMEROINOT_76981',
                titleArgs: {},
                tooltip: '',
                width: 160,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWHA_685908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT94_NUMBERRS520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.numberIntAddress.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWHA_685908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.numberIntAddress.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.numberIntAddress.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.numberExtAddress = {
                title: 'CLCOL.LBL_CLCOL_NMEROEXCM_32141',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDED_602908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT13_NUMBERAT520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.numberExtAddress.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDED_602908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.numberExtAddress.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.numberExtAddress.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.colonyAddress = {
                title: 'CLCOL.LBL_CLCOL_COLONIACL_27969',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGHY_375908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT56_COLONYSE520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.colonyAddress.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGHY_375908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.colonyAddress.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.colonyAddress.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.cpAddress = {
                title: 'CLCOL.LBL_CLCOL_CPDOMICII_38750',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPKP_595908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT57_CPADDRSE520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.cpAddress.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPKP_595908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.cpAddress.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.cpAddress.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.email = {
                title: 'CLCOL.LBL_CLCOL_CORREOELC_87577',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHFJ_423908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT32_EMAILJQI520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.email.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHFJ_423908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.email.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.email.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.cellPhoneNumber = {
                title: 'CLCOL.LBL_CLCOL_NMEROCERU_24065',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNEC_933908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT29_CELLPHRU520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.cellPhoneNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNEC_933908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.cellPhoneNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.cellPhoneNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.officeId = {
                title: 'CLCOL.LBL_CLCOL_OFFICINTI_46418',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTID_132908',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXTID_132908 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXTID_132908',
                            'cl_oficina',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXTID_132908'];
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
            $scope.vc.grids.QV_8718_49718.AT66_OFFICEII520 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.officeId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTID_132908",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_8718_49718.column.officeId.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXTID_132908",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_8718_49718.column.officeId.template",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.officeId.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.officeDesc = {
                title: 'CLCOL.LBL_CLCOL_OFFICINTI_46418',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXEH_734908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT40_OFFICECC520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.officeDesc.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXEH_734908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.officeDesc.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.officeDesc.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.curp = {
                title: 'CLCOL.LBL_CLCOL_CURPGZXSD_75358',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXWE_826908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT43_CURPWUPS520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.curp.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXWE_826908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.curp.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.curp.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.rfc = {
                title: 'CLCOL.LBL_CLCOL_RFCFJBAIQ_39679',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNSI_337908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT99_RFCLWVZN520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.rfc.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNSI_337908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.rfc.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.rfc.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.collectiveName = {
                title: 'CLCOL.LBL_CLCOL_TIPOMEROC_96222',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZTN_260908',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXZTN_260908 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXZTN_260908',
                            'cl_tipo_mercado',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXZTN_260908'];
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
            $scope.vc.grids.QV_8718_49718.AT85_COLLECMT520 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.collectiveName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZTN_260908",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_8718_49718.column.collectiveName.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXZTN_260908",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_8718_49718.column.collectiveName.template",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.collectiveName.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'placeholder': "'{{'CLCOL.LBL_CLCOL_NOEXISTEE_99131'|translate}}'",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.clientLevel = {
                title: 'CLCOL.LBL_CLCOL_NIVELCLNE_44467',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTZJ_455908',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXTZJ_455908 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXTZJ_455908',
                            'cl_nivel_cliente_colectivo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXTZJ_455908'];
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
            $scope.vc.grids.QV_8718_49718.AT89_CLIENTLL520 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.clientLevel.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTZJ_455908",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_8718_49718.column.clientLevel.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXTZJ_455908",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_8718_49718.column.clientLevel.template",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.clientLevel.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'placeholder': "'{{'CLCOL.LBL_CLCOL_NOEXISTEE_99131'|translate}}'",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.economicActivity = {
                title: 'CLCOL.LBL_CLCOL_ACTIVIDOA_10737',
                titleArgs: {},
                tooltip: '',
                width: 170,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTJF_831908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT84_ECONOMYA520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.economicActivity.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTJF_831908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.economicActivity.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.economicActivity.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.monthSales = {
                title: 'CLCOL.LBL_CLCOL_VENTASMUE_30172',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXINH_363908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT68_MONTHSAS520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.monthSales.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXINH_363908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.monthSales.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.monthSales.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.numberChildren = {
                title: 'CLCOL.LBL_CLCOL_NMEROHIOS_27639',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYXW_521908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT85_NUMBERIH520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.numberChildren.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYXW_521908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.numberChildren.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.numberChildren.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.periodicity = {
                title: 'CLCOL.LBL_CLCOL_PERIODIDD_39663',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAMY_408908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT60_PERIODCI520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.periodicity.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAMY_408908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.periodicity.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.periodicity.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.officialLogin = {
                title: 'CLCOL.LBL_CLCOL_OFICIALNC_11494',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWAR_385908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT87_OFFICIAL520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.officialLogin.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWAR_385908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.officialLogin.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.officialLogin.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8718_49718.column.observations = {
                title: 'CLCOL.LBL_CLCOL_OBSERVAOO_48603',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDWZ_163908',
                element: []
            };
            $scope.vc.grids.QV_8718_49718.AT69_OBSERVNI520 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8718_49718.column.observations.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDWZ_163908",
                        'data-validation-code': "{{vc.viewState.QV_8718_49718.column.observations.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8718_49718.column.observations.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'surname',
                    title: '{{vc.viewState.QV_8718_49718.column.surname.title|translate:vc.viewState.QV_8718_49718.column.surname.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.surname.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.surname.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT18_SURNAMEE520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.surname.style' ng-bind='vc.getStringColumnFormat(dataItem.surname, \"QV_8718_49718\", \"surname\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.surname.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.surname.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.surname.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'secondSurname',
                    title: '{{vc.viewState.QV_8718_49718.column.secondSurname.title|translate:vc.viewState.QV_8718_49718.column.secondSurname.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.secondSurname.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.secondSurname.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT41_SECONDRM520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.secondSurname.style' ng-bind='vc.getStringColumnFormat(dataItem.secondSurname, \"QV_8718_49718\", \"secondSurname\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.secondSurname.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.secondSurname.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.secondSurname.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'firstName',
                    title: '{{vc.viewState.QV_8718_49718.column.firstName.title|translate:vc.viewState.QV_8718_49718.column.firstName.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.firstName.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.firstName.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT87_FIRSTNEM520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.firstName.style' ng-bind='vc.getStringColumnFormat(dataItem.firstName, \"QV_8718_49718\", \"firstName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.firstName.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.firstName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.firstName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'secondName',
                    title: '{{vc.viewState.QV_8718_49718.column.secondName.title|translate:vc.viewState.QV_8718_49718.column.secondName.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.secondName.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.secondName.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT89_SECONDEE520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.secondName.style' ng-bind='vc.getStringColumnFormat(dataItem.secondName, \"QV_8718_49718\", \"secondName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.secondName.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.secondName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.secondName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'birthDate',
                    title: '{{vc.viewState.QV_8718_49718.column.birthDate.title|translate:vc.viewState.QV_8718_49718.column.birthDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.birthDate.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.birthDate.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT47_BIRTHDTT520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.birthDate.style' ng-bind='vc.getStringColumnFormat(dataItem.birthDate, \"QV_8718_49718\", \"birthDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.birthDate.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.birthDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.birthDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'birthEntity',
                    title: '{{vc.viewState.QV_8718_49718.column.birthEntity.title|translate:vc.viewState.QV_8718_49718.column.birthEntity.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.birthEntity.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.birthEntity.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT86_BIRTHNYF520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.birthEntity.style' ng-bind='vc.getStringColumnFormat(dataItem.birthEntity, \"QV_8718_49718\", \"birthEntity\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.birthEntity.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.birthEntity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.birthEntity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'birthEntityDesc',
                    title: '{{vc.viewState.QV_8718_49718.column.birthEntityDesc.title|translate:vc.viewState.QV_8718_49718.column.birthEntityDesc.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.birthEntityDesc.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.birthEntityDesc.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT24_BIRTHDCS520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.birthEntityDesc.style' ng-bind='vc.getStringColumnFormat(dataItem.birthEntityDesc, \"QV_8718_49718\", \"birthEntityDesc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.birthEntityDesc.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.birthEntityDesc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.birthEntityDesc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'gender',
                    title: '{{vc.viewState.QV_8718_49718.column.gender.title|translate:vc.viewState.QV_8718_49718.column.gender.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.gender.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.gender.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT53_GENDERBB520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.gender.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXNBC_274908.get(dataItem.gender).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.gender.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.gender.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.gender.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'streetAddress',
                    title: '{{vc.viewState.QV_8718_49718.column.streetAddress.title|translate:vc.viewState.QV_8718_49718.column.streetAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.streetAddress.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.streetAddress.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT15_STREETRD520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.streetAddress.style' ng-bind='vc.getStringColumnFormat(dataItem.streetAddress, \"QV_8718_49718\", \"streetAddress\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.streetAddress.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.streetAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.streetAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'numberIntAddress',
                    title: '{{vc.viewState.QV_8718_49718.column.numberIntAddress.title|translate:vc.viewState.QV_8718_49718.column.numberIntAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.numberIntAddress.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.numberIntAddress.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT94_NUMBERRS520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.numberIntAddress.style' ng-bind='vc.getStringColumnFormat(dataItem.numberIntAddress, \"QV_8718_49718\", \"numberIntAddress\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.numberIntAddress.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.numberIntAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.numberIntAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'numberExtAddress',
                    title: '{{vc.viewState.QV_8718_49718.column.numberExtAddress.title|translate:vc.viewState.QV_8718_49718.column.numberExtAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.numberExtAddress.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.numberExtAddress.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT13_NUMBERAT520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.numberExtAddress.style' ng-bind='vc.getStringColumnFormat(dataItem.numberExtAddress, \"QV_8718_49718\", \"numberExtAddress\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.numberExtAddress.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.numberExtAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.numberExtAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'colonyAddress',
                    title: '{{vc.viewState.QV_8718_49718.column.colonyAddress.title|translate:vc.viewState.QV_8718_49718.column.colonyAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.colonyAddress.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.colonyAddress.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT56_COLONYSE520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.colonyAddress.style' ng-bind='vc.getStringColumnFormat(dataItem.colonyAddress, \"QV_8718_49718\", \"colonyAddress\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.colonyAddress.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.colonyAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.colonyAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'cpAddress',
                    title: '{{vc.viewState.QV_8718_49718.column.cpAddress.title|translate:vc.viewState.QV_8718_49718.column.cpAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.cpAddress.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.cpAddress.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT57_CPADDRSE520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.cpAddress.style' ng-bind='vc.getStringColumnFormat(dataItem.cpAddress, \"QV_8718_49718\", \"cpAddress\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.cpAddress.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.cpAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.cpAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'email',
                    title: '{{vc.viewState.QV_8718_49718.column.email.title|translate:vc.viewState.QV_8718_49718.column.email.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.email.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.email.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT32_EMAILJQI520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.email.style' ng-bind='vc.getStringColumnFormat(dataItem.email, \"QV_8718_49718\", \"email\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.email.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.email.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.email.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'cellPhoneNumber',
                    title: '{{vc.viewState.QV_8718_49718.column.cellPhoneNumber.title|translate:vc.viewState.QV_8718_49718.column.cellPhoneNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.cellPhoneNumber.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.cellPhoneNumber.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT29_CELLPHRU520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.cellPhoneNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.cellPhoneNumber, \"QV_8718_49718\", \"cellPhoneNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.cellPhoneNumber.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.cellPhoneNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.cellPhoneNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'officeId',
                    title: '{{vc.viewState.QV_8718_49718.column.officeId.title|translate:vc.viewState.QV_8718_49718.column.officeId.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.officeId.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.officeId.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT66_OFFICEII520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.officeId.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXTID_132908.get(dataItem.officeId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.officeId.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.officeId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.officeId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'officeDesc',
                    title: '{{vc.viewState.QV_8718_49718.column.officeDesc.title|translate:vc.viewState.QV_8718_49718.column.officeDesc.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.officeDesc.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.officeDesc.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT40_OFFICECC520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.officeDesc.style' ng-bind='vc.getStringColumnFormat(dataItem.officeDesc, \"QV_8718_49718\", \"officeDesc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.officeDesc.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.officeDesc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.officeDesc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'curp',
                    title: '{{vc.viewState.QV_8718_49718.column.curp.title|translate:vc.viewState.QV_8718_49718.column.curp.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.curp.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.curp.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT43_CURPWUPS520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.curp.style' ng-bind='vc.getStringColumnFormat(dataItem.curp, \"QV_8718_49718\", \"curp\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.curp.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.curp.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.curp.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'rfc',
                    title: '{{vc.viewState.QV_8718_49718.column.rfc.title|translate:vc.viewState.QV_8718_49718.column.rfc.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.rfc.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.rfc.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT99_RFCLWVZN520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.rfc.style' ng-bind='vc.getStringColumnFormat(dataItem.rfc, \"QV_8718_49718\", \"rfc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.rfc.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.rfc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.rfc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'collectiveName',
                    title: '{{vc.viewState.QV_8718_49718.column.collectiveName.title|translate:vc.viewState.QV_8718_49718.column.collectiveName.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.collectiveName.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.collectiveName.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT85_COLLECMT520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.collectiveName.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXZTN_260908.get(dataItem.collectiveName).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.collectiveName.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.collectiveName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.collectiveName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'clientLevel',
                    title: '{{vc.viewState.QV_8718_49718.column.clientLevel.title|translate:vc.viewState.QV_8718_49718.column.clientLevel.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.clientLevel.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.clientLevel.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT89_CLIENTLL520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.clientLevel.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXTZJ_455908.get(dataItem.clientLevel).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.clientLevel.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.clientLevel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.clientLevel.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'economicActivity',
                    title: '{{vc.viewState.QV_8718_49718.column.economicActivity.title|translate:vc.viewState.QV_8718_49718.column.economicActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.economicActivity.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.economicActivity.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT84_ECONOMYA520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.economicActivity.style' ng-bind='vc.getStringColumnFormat(dataItem.economicActivity, \"QV_8718_49718\", \"economicActivity\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.economicActivity.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.economicActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.economicActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'monthSales',
                    title: '{{vc.viewState.QV_8718_49718.column.monthSales.title|translate:vc.viewState.QV_8718_49718.column.monthSales.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.monthSales.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.monthSales.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT68_MONTHSAS520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.monthSales.style' ng-bind='vc.getStringColumnFormat(dataItem.monthSales, \"QV_8718_49718\", \"monthSales\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.monthSales.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.monthSales.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.monthSales.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'numberChildren',
                    title: '{{vc.viewState.QV_8718_49718.column.numberChildren.title|translate:vc.viewState.QV_8718_49718.column.numberChildren.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.numberChildren.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.numberChildren.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT85_NUMBERIH520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.numberChildren.style' ng-bind='vc.getStringColumnFormat(dataItem.numberChildren, \"QV_8718_49718\", \"numberChildren\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.numberChildren.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.numberChildren.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.numberChildren.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'periodicity',
                    title: '{{vc.viewState.QV_8718_49718.column.periodicity.title|translate:vc.viewState.QV_8718_49718.column.periodicity.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.periodicity.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.periodicity.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT60_PERIODCI520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.periodicity.style' ng-bind='vc.getStringColumnFormat(dataItem.periodicity, \"QV_8718_49718\", \"periodicity\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.periodicity.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.periodicity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.periodicity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'officialLogin',
                    title: '{{vc.viewState.QV_8718_49718.column.officialLogin.title|translate:vc.viewState.QV_8718_49718.column.officialLogin.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.officialLogin.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.officialLogin.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT87_OFFICIAL520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.officialLogin.style' ng-bind='vc.getStringColumnFormat(dataItem.officialLogin, \"QV_8718_49718\", \"officialLogin\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.officialLogin.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.officialLogin.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.officialLogin.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8718_49718.columns.push({
                    field: 'observations',
                    title: '{{vc.viewState.QV_8718_49718.column.observations.title|translate:vc.viewState.QV_8718_49718.column.observations.titleArgs}}',
                    width: $scope.vc.viewState.QV_8718_49718.column.observations.width,
                    format: $scope.vc.viewState.QV_8718_49718.column.observations.format,
                    editor: $scope.vc.grids.QV_8718_49718.AT69_OBSERVNI520.control,
                    template: "<span ng-class='vc.viewState.QV_8718_49718.column.observations.style' ng-bind='vc.getStringColumnFormat(dataItem.observations, \"QV_8718_49718\", \"observations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8718_49718.column.observations.style",
                        "title": "{{vc.viewState.QV_8718_49718.column.observations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8718_49718.column.observations.hidden
                });
            }
            $scope.vc.viewState.QV_8718_49718.toolbar = {}
            $scope.vc.grids.QV_8718_49718.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_8718_49718.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Group: Group1395
            $scope.vc.createViewState({
                id: "G_LOADCOLPVE_896908",
                hasId: true,
                componentStyle: [],
                label: 'Group1395',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2865",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_988908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_TOTALZBHC_93262",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_989908",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2523",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2457",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_347908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_REGISTRSS_16117",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_366908",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2747",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2107",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_547908",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_REGISTREO_79233",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_901908",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CLCOLIQAJNDTG_333_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CLCOLIQAJNDTG_333_CANCEL",
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
                    $scope.vc.catalogs.VA_TEXTINPUTBOXTID_132908.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXZTN_260908.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXTZJ_455908.read();
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
                $scope.vc.render('VC_LOADCOLLEV_719333');
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
    var cobisMainModule = cobis.createModule("VC_LOADCOLLEV_719333", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CLCOL"]);
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
        $routeProvider.when("/VC_LOADCOLLEV_719333", {
            templateUrl: "VC_LOADCOLLEV_719333_FORM.html",
            controller: "VC_LOADCOLLEV_719333_CTRL",
            labelId: "CLCOL.LBL_CLCOL_ALTAMASES_71742",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CLCOL');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LOADCOLLEV_719333?" + $.param(search);
            }
        });
        VC_LOADCOLLEV_719333(cobisMainModule);
    }]);
} else {
    VC_LOADCOLLEV_719333(cobisMainModule);
}