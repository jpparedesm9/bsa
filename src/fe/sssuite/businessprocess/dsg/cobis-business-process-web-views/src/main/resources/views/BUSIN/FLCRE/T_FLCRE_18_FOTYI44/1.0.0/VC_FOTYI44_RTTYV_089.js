<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.infocredentitymanagement = designerEvents.api.infocredentitymanagement || designer.dsgEvents();

function VC_FOTYI44_RTTYV_089(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_FOTYI44_RTTYV_089_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_FOTYI44_RTTYV_089_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_18_FOTYI44",
            taskVersion: "1.0.0",
            viewContainerId: "VC_FOTYI44_RTTYV_089",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_18_FOTYI44",
        designerEvents.api.infocredentitymanagement,
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
                vcName: 'VC_FOTYI44_RTTYV_089'
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
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_18_FOTYI44',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    InfocredEntity: "InfocredEntity"
                },
                entities: {
                    InfocredEntity: {
                        DocumentType: 'AT_INF893CETY54',
                        FullName: 'AT_INF893LNME23',
                        Source: 'AT_INF893SRCE25',
                        Role: 'AT_INF893ROLE80',
                        RequestIdLoanId: 'AT_INF893SDNI86',
                        CustomerId: 'AT_INF893UTEI15',
                        _pks: [],
                        _entityId: 'EN_INFOCDTIT893',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_IRENTYQR_5951 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_IRENTYQR_5951 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_IRENTYQR_5951 = {
                mainEntityPk: {
                    entityId: 'EN_INFOCDTIT893',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_IRENTYQR_5951',
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
                InfocredEntity: {}
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
            $scope.vc.viewState.VC_FOTYI44_RTTYV_089 = {
                style: []
            }
            //ViewState - Container: Formulario de la vista InfocredEntityView
            $scope.vc.createViewState({
                id: "VC_FOTYI44_RTTYV_089",
                hasId: true,
                componentStyle: "",
                label: 'Formulario de la vista InfocredEntityView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Panel para InfocredEntityView
            $scope.vc.createViewState({
                id: "VC_FOTYI44_ELREE_544",
                hasId: true,
                componentStyle: "",
                label: 'Panel para InfocredEntityView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor
            $scope.vc.createViewState({
                id: "GR_IFOCREEYEW02_94",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel para InfocredEntityGrid
            $scope.vc.createViewState({
                id: "GR_IFOCREEYEW02_95",
                hasId: true,
                componentStyle: "",
                label: 'Panel para InfocredEntityGrid',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.InfocredEntity = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    FullName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfocredEntity", "FullName", '')
                    },
                    RequestIdLoanId: {
                        type: "number",
                        editable: true
                    },
                    Role: {
                        type: "string",
                        editable: true
                    },
                    Source: {
                        type: "string",
                        editable: true
                    },
                    DocumentType: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.InfocredEntity = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_IRENTYQR_5951', function(data) {
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
                    model: $scope.vc.types.InfocredEntity
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_IRENT5951_45").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_IRENTYQR_5951 = $scope.vc.model.InfocredEntity;
            $scope.vc.trackers.InfocredEntity = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.InfocredEntity);
            $scope.vc.model.InfocredEntity.bind('change', function(e) {
                $scope.vc.trackers.InfocredEntity.track(e);
            });
            $scope.vc.grids.QV_IRENT5951_45 = {};
            $scope.vc.grids.QV_IRENT5951_45.queryId = 'Q_IRENTYQR_5951';
            $scope.vc.viewState.QV_IRENT5951_45 = {
                style: undefined
            };
            $scope.vc.viewState.QV_IRENT5951_45.column = {};
            $scope.vc.grids.QV_IRENT5951_45.events = {
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
                    $scope.vc.trackers.InfocredEntity.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_IRENT5951_45.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_IRENT5951_45");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_IRENT5951_45.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_IRENT5951_45.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_IRENT5951_45.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "InfocredEntity",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_IRENT5951_45", args);
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
            $scope.vc.grids.QV_IRENT5951_45.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_IRENT5951_45.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_IRENT5951_45.column.FullName = {
                title: 'BUSIN.DLB_BUSIN_LJRXITRFW_70117',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IFOCREEYEW0295_LNME478',
                element: []
            };
            $scope.vc.grids.QV_IRENT5951_45.AT_INF893LNME23 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_IRENT5951_45.column.FullName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IFOCREEYEW0295_LNME478",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_IRENT5951_45.column.FullName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_IFOCREEYEW02_94,0",
                        'ng-disabled': "!vc.viewState.QV_IRENT5951_45.column.FullName.enabled",
                        'ng-class': "vc.viewState.QV_IRENT5951_45.column.FullName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_IRENT5951_45.column.RequestIdLoanId = {
                title: 'RequestIdLoanId',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_IRENT5951_45.column.Role = {
                title: 'Role',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_IRENT5951_45.column.Source = {
                title: 'Source',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_IRENT5951_45.column.DocumentType = {
                title: 'DocumentType',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_IRENT5951_45.columns.push({
                    field: 'FullName',
                    title: '{{vc.viewState.QV_IRENT5951_45.column.FullName.title|translate:vc.viewState.QV_IRENT5951_45.column.FullName.titleArgs}}',
                    width: $scope.vc.viewState.QV_IRENT5951_45.column.FullName.width,
                    format: $scope.vc.viewState.QV_IRENT5951_45.column.FullName.format,
                    editor: $scope.vc.grids.QV_IRENT5951_45.AT_INF893LNME23.control,
                    template: "<span ng-class='vc.viewState.QV_IRENT5951_45.column.FullName.element[dataItem.uid].style'>#if (FullName !== null) {# #=FullName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_IRENT5951_45.column.FullName.style",
                        "title": "{{vc.viewState.QV_IRENT5951_45.column.FullName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_IRENT5951_45.column.FullName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_IRENT5951_45.column.VA_IFOCREEYEW0295_CETY643 = {
                    tooltip: 'BUSIN.DLB_BUSIN_ESRARINOD_66891',
                    imageId: 'glyphicon glyphicon-download-alt',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                };
                $scope.vc.grids.QV_IRENT5951_45.columns.push({
                    command: {
                        name: "VA_IFOCREEYEW0295_CETY643",
                        entity: "InfocredEntity",
                        text: "{{'DSGNR.SYS_DSGNR_LBLESTETQ_00024'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'cb-btn-custom-boton-registrar':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_IFOCREEYEW0295_CETY643\", " + "vc.viewState.QV_IRENT5951_45.column.VA_IFOCREEYEW0295_CETY643.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_IRENT5951_45.column.VA_IFOCREEYEW0295_CETY643.enabled' " + "data-ng-click = 'vc.grids.QV_IRENT5951_45.events.customRowClick($event, \"VA_IFOCREEYEW0295_CETY643\", \"#:entity#\", \"QV_IRENT5951_45\")' " + "title = \"{{vc.viewState.QV_IRENT5951_45.column.VA_IFOCREEYEW0295_CETY643.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_IRENT5951_45.column.VA_IFOCREEYEW0295_CETY643.imageId'></span>" + "</a>"
                    },
                    width: 30,
                    attributes: {
                        "class": "btn-toolbar"
                    }
                });
            }
            $scope.vc.viewState.QV_IRENT5951_45.toolbar = {}
            $scope.vc.grids.QV_IRENT5951_45.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_18_FOTYI44_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_18_FOTYI44_CANCEL",
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
                $scope.vc.render('VC_FOTYI44_RTTYV_089');
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
    var cobisMainModule = cobis.createModule("VC_FOTYI44_RTTYV_089", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_FOTYI44_RTTYV_089", {
            templateUrl: "VC_FOTYI44_RTTYV_089_FORM.html",
            controller: "VC_FOTYI44_RTTYV_089_CTRL",
            label: "Formulario de la vista InfocredEntityView",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_FOTYI44_RTTYV_089?" + $.param(search);
            }
        });
        VC_FOTYI44_RTTYV_089(cobisMainModule);
    }]);
} else {
    VC_FOTYI44_RTTYV_089(cobisMainModule);
}