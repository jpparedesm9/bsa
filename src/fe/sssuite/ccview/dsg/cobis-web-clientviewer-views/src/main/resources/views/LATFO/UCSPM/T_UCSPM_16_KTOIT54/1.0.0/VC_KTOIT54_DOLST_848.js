<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskdtolist = designerEvents.api.taskdtolist || designer.dsgEvents();

function VC_KTOIT54_DOLST_848(cobisMainModule) {
    cobisMainModule.routeProvider.when("/VC_MAMIE85_TIETT_934", {
        templateUrl: "${contextPath}/cobis/web/views/LATFO/UCSPM/T_UCSPM_03_MAMIE85/1.0.0/VC_MAMIE85_TIETT_934_FORM.html",
        controller: "VC_MAMIE85_TIETT_934_CTRL",
        label: "DTO Maintaining",
        resolve: {
            dependencies: function($q, $rootScope) {
                var deferred = $q.defer();
                var taskPath = "${contextPath}/cobis/web/views/LATFO/UCSPM/T_UCSPM_03_MAMIE85/1.0.0/";
                var coreScript = taskPath + "VC_MAMIE85_TIETT_934.js";
                $script(coreScript, function() {
                    var customScript = taskPath + "VC_MAMIE85_TIETT_934_CUSTOM.js";
                    $script(customScript, function() {
                        $rootScope.$apply(function() {
                            deferred.resolve();
                        });
                    });
                });
                return deferred.promise;
            }
        }
    });
    cobisMainModule.controllerProvider.register("VC_KTOIT54_DOLST_848_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_KTOIT54_DOLST_848_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            moduleId: "LATFO",
            subModuleId: "UCSPM",
            taskId: "T_UCSPM_16_KTOIT54",
            taskVersion: "1.0.0",
            viewContainerId: "VC_KTOIT54_DOLST_848",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LATFO/UCSPM/T_UCSPM_16_KTOIT54",
        designerEvents.api.taskdtolist,
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
                vcName: 'VC_KTOIT54_DOLST_848'
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
                    moduleId: 'LATFO',
                    subModuleId: 'UCSPM',
                    taskId: 'T_UCSPM_16_KTOIT54',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    DTOS: "DTOS"
                },
                entities: {
                    DTOS: {
                        mnemonic: 'AT_VCC773NNIC24',
                        isList: 'AT_VCC773ILIS60',
                        parent: 'AT_VCC773DAET08',
                        serIdFk: 'AT_VCC773IDFK41',
                        name: 'AT_VCC773ONAE12',
                        dtoId: 'AT_VCC773DTOI22',
                        description: 'AT_VCC773TEIT99',
                        text: 'AT_VCC773DOET74',
                        order: 'AT_VCC773DRER76',
                        parentName: 'AT_VCC773PAME64',
                        _pks: ['dtoId'],
                        _entityId: 'EN_VCCDTOSKF773',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DETALETO_2498 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_DETALETO_2498 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_DETALETO_2498 = {
                mainEntityPk: {
                    entityId: 'EN_VCCDTOSKF773',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_DETALETO_2498',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {};
                    }
                }
            };
            defaultValues = {
                DTOS: {}
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
            }
            $scope.vc.executeCRUDQuery = function(queryId, loadInModel) {
                var queryRequest = $scope.vc.request.qr[queryId];
                return $scope.vc.CRUDExecuteQueryId(queryRequest, loadInModel);
            }
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
            $scope.vc.viewState.VC_KTOIT54_DOLST_848 = {
                style: []
            }
            //ViewState - Group: Lista DTOs
            $scope.vc.createViewState({
                id: "GR_DTOLISTTJE03_02",
                hasId: true,
                componentStyle: "",
                label: 'Lista DTOs',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DTOS = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    dtoId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DTOS", "dtoId", 0),
                        validation: {
                            dtoIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    name: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DTOS", "name", '')
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DTOS", "description", '')
                    },
                    parentName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DTOS", "parentName", '')
                    }
                }
            });;
            $scope.vc.model.DTOS = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_DETALETO_2498', function(data) {
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
                    model: $scope.vc.types.DTOS
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_DETAL2498_88").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DETALETO_2498 = $scope.vc.model.DTOS;
            $scope.vc.trackers.DTOS = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DTOS);
            $scope.vc.model.DTOS.bind('change', function(e) {
                $scope.vc.trackers.DTOS.track(e);
            });
            $scope.vc.grids.QV_DETAL2498_88 = {};
            $scope.vc.grids.QV_DETAL2498_88.queryId = 'Q_DETALETO_2498';
            $scope.vc.viewState.QV_DETAL2498_88 = {
                style: undefined
            };
            $scope.vc.viewState.QV_DETAL2498_88.column = {};
            $scope.vc.grids.QV_DETAL2498_88.events = {
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_DETAL2498_88");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_DETAL2498_88.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_DETAL2498_88.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_DETAL2498_88.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "DTOS",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_DETAL2498_88", args);
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
            $scope.vc.grids.QV_DETAL2498_88.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_DETAL2498_88.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_DETAL2498_88.column.dtoId = {
                title: 'LATFO.DLB_LATFO_IDRFDFYBK_73505',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_DTOLISTTJE0302_DTOI329',
                element: []
            };
            $scope.vc.viewState.QV_DETAL2498_88.column.name = {
                title: 'LATFO.DLB_LATFO_NOMBREUEK_16852',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DTOLISTTJE0302_ONAE112',
                element: []
            };
            $scope.vc.viewState.QV_DETAL2498_88.column.description = {
                title: 'LATFO.DLB_LATFO_DSCRIPCIN_18036',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DTOLISTTJE0302_TEIT325',
                element: []
            };
            $scope.vc.viewState.QV_DETAL2498_88.column.parentName = {
                title: 'LATFO.DLB_LATFO_PADREZGGL_83471',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DTOLISTTJE0302_PAME244',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DETAL2498_88.columns.push({
                    field: 'dtoId',
                    title: '{{vc.viewState.QV_DETAL2498_88.column.dtoId.title|translate:vc.viewState.QV_DETAL2498_88.column.dtoId.titleArgs}}',
                    width: $scope.vc.viewState.QV_DETAL2498_88.column.dtoId.width,
                    format: $scope.vc.viewState.QV_DETAL2498_88.column.dtoId.format,
                    template: "<span ng-class='vc.viewState.QV_DETAL2498_88.column.dtoId.element[dataItem.uid].style' ng-bind='kendo.toString(#=dtoId#, vc.viewState.QV_DETAL2498_88.column.dtoId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DETAL2498_88.column.dtoId.style",
                        "title": "{{vc.viewState.QV_DETAL2498_88.column.dtoId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DETAL2498_88.column.dtoId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DETAL2498_88.columns.push({
                    field: 'name',
                    title: '{{vc.viewState.QV_DETAL2498_88.column.name.title|translate:vc.viewState.QV_DETAL2498_88.column.name.titleArgs}}',
                    width: $scope.vc.viewState.QV_DETAL2498_88.column.name.width,
                    format: $scope.vc.viewState.QV_DETAL2498_88.column.name.format,
                    template: "<span ng-class='vc.viewState.QV_DETAL2498_88.column.name.element[dataItem.uid].style'>#if (name !== null) {# #=name# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DETAL2498_88.column.name.style",
                        "title": "{{vc.viewState.QV_DETAL2498_88.column.name.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DETAL2498_88.column.name.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DETAL2498_88.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_DETAL2498_88.column.description.title|translate:vc.viewState.QV_DETAL2498_88.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_DETAL2498_88.column.description.width,
                    format: $scope.vc.viewState.QV_DETAL2498_88.column.description.format,
                    template: "<span ng-class='vc.viewState.QV_DETAL2498_88.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DETAL2498_88.column.description.style",
                        "title": "{{vc.viewState.QV_DETAL2498_88.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DETAL2498_88.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DETAL2498_88.columns.push({
                    field: 'parentName',
                    title: '{{vc.viewState.QV_DETAL2498_88.column.parentName.title|translate:vc.viewState.QV_DETAL2498_88.column.parentName.titleArgs}}',
                    width: $scope.vc.viewState.QV_DETAL2498_88.column.parentName.width,
                    format: $scope.vc.viewState.QV_DETAL2498_88.column.parentName.format,
                    template: "<span ng-class='vc.viewState.QV_DETAL2498_88.column.parentName.element[dataItem.uid].style'>#if (parentName !== null) {# #=parentName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DETAL2498_88.column.parentName.style",
                        "title": "{{vc.viewState.QV_DETAL2498_88.column.parentName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DETAL2498_88.column.parentName.hidden
                });
            }
            $scope.vc.viewState.QV_DETAL2498_88.toolbar = {
                CEQV_201_QV_DETAL2498_88_068: {
                    visible: true
                },
                CEQV_201_QV_DETAL2498_88_392: {
                    visible: true
                },
                CEQV_201_QV_DETAL2498_88_349: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_DETAL2498_88.toolbar = [{
                "name": "CEQV_201_QV_DETAL2498_88_068",
                "template": "<button id='CEQV_201_QV_DETAL2498_88_068' ng-show='vc.viewState.QV_DETAL2498_88.toolbar.CEQV_201_QV_DETAL2498_88_068.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_DETAL2498_88_068\",\"DTOS\")' class='btn btn-default cb-grid-image-button cb-btn-custom-nuevo' title=\"{{'LATFO.DLB_LATFO_NUEVOFIIQ_43380'|translate}}\"><span class='glyphicon glyphicon-plus-sign'></span></button>"
            }, {
                "name": "CEQV_201_QV_DETAL2498_88_392",
                "template": "<button id='CEQV_201_QV_DETAL2498_88_392' ng-show='vc.viewState.QV_DETAL2498_88.toolbar.CEQV_201_QV_DETAL2498_88_392.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_DETAL2498_88_392\",\"DTOS\")' class='btn btn-default cb-grid-image-button cb-btn-custom-editar' title=\"{{'LATFO.DLB_LATFO_EDITARYPV_83471'|translate}}\"><span class='glyphicon glyphicon-pencil'></span></button>"
            }, {
                "name": "CEQV_201_QV_DETAL2498_88_349",
                "template": "<button id='CEQV_201_QV_DETAL2498_88_349' ng-show='vc.viewState.QV_DETAL2498_88.toolbar.CEQV_201_QV_DETAL2498_88_349.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_DETAL2498_88_349\",\"DTOS\")' class='btn btn-default cb-grid-image-button cb-btn-custom-eliminar' title=\"{{'LATFO.DLB_LATFO_ELIMINARE_71309'|translate}}\"><span class='glyphicon glyphicon-remove'></span></button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_UCSPM_16_KTOIT54_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_UCSPM_16_KTOIT54_CANCEL",
                componentStyle: "",
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
                $scope.vc.render('VC_KTOIT54_DOLST_848');
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
    var cobisMainModule = cobis.createModule("VC_KTOIT54_DOLST_848", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LATFO"]);
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
        $routeProvider.when("/VC_KTOIT54_DOLST_848", {
            templateUrl: "VC_KTOIT54_DOLST_848_FORM.html",
            controller: "VC_KTOIT54_DOLST_848_CTRL",
            label: "DTOSList",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LATFO');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_KTOIT54_DOLST_848?" + $.param(search);
            }
        });
        VC_KTOIT54_DOLST_848(cobisMainModule);
    }]);
} else {
    VC_KTOIT54_DOLST_848(cobisMainModule);
}