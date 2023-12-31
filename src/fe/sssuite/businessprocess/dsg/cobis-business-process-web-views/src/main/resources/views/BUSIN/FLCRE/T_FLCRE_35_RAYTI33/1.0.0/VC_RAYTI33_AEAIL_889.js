<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.warrantymodifydetail = designerEvents.api.warrantymodifydetail || designer.dsgEvents();

function VC_RAYTI33_AEAIL_889(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RAYTI33_AEAIL_889_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RAYTI33_AEAIL_889_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_35_RAYTI33",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RAYTI33_AEAIL_889",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_35_RAYTI33",
        designerEvents.api.warrantymodifydetail,
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
                vcName: 'VC_RAYTI33_AEAIL_889'
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
                    taskId: 'T_FLCRE_35_RAYTI33',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Warranty: "Warranty"
                },
                entities: {
                    Warranty: {
                        CodeWarranty: 'AT_WAR710CODT71',
                        Type: 'AT_WAR710TYPE01',
                        Description: 'AT_WAR710CRII81',
                        InitialValue: 'AT_WAR710INTI51',
                        DateAppraisedValue: 'AT_WAR710ATAS35',
                        ValueApportionment: 'AT_WAR710PMET71',
                        ClassOpen: 'AT_WAR710CSSP76',
                        ValueAvailable: 'AT_WAR710VUAA77',
                        IdCustomer: 'AT_WAR710IDUO31',
                        NameGar: 'AT_WAR710AMER05',
                        State: 'AT_WAR710STAT86',
                        _pks: [],
                        _entityId: 'EN_WARRANTYB710',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_WANTYDIL_5919 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_WANTYDIL_5919 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_WANTYDIL_5919 = {
                mainEntityPk: {
                    entityId: 'EN_WARRANTYB710',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_WANTYDIL_5919',
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
                Warranty: {}
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
            $scope.vc.viewState.VC_RAYTI33_AEAIL_889 = {
                style: []
            }
            //ViewState - Container: WarrantyModify
            $scope.vc.createViewState({
                id: "VC_RAYTI33_AEAIL_889",
                hasId: true,
                componentStyle: "",
                label: 'WarrantyModify',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Panel - VWarrantyDetailView
            $scope.vc.createViewState({
                id: "VC_RAYTI33_ANERT_722",
                hasId: true,
                componentStyle: "",
                label: 'Panel - VWarrantyDetailView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor
            $scope.vc.createViewState({
                id: "GR_VWNDETAILW30_26",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel de Acordeón para Warranty
            $scope.vc.createViewState({
                id: "GR_VWNDETAILW30_61",
                hasId: true,
                componentStyle: "",
                label: 'Panel de Acorde\u00f3n para Warranty',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Warranty = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CodeWarranty: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "CodeWarranty", '')
                    },
                    Type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "Type", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "Description", '')
                    },
                    InitialValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "InitialValue", 0)
                    },
                    DateAppraisedValue: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "DateAppraisedValue", '')
                    },
                    ValueApportionment: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "ValueApportionment", 0)
                    },
                    ValueAvailable: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "ValueAvailable", 0)
                    },
                    State: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Warranty", "State", '')
                    },
                    NameGar: {
                        type: "string",
                        editable: true
                    },
                    IdCustomer: {
                        type: "string",
                        editable: true
                    },
                    ClassOpen: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.Warranty = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_WANTYDIL_5919', function(data) {
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Warranty',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_WANTY5919_76', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                                var argsAfterLeave = {
                                    inlineWorkMode: designer.constants.gridInlineWorkMode.Insert,
                                    nameEntityGrid: 'Warranty'
                                };
                                $scope.vc.gridAfterLeaveInLineRow('QV_WANTY5919_76', argsAfterLeave);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                        var argsAfterLeave = {
                            inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                            nameEntityGrid: 'Warranty'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_WANTY5919_76', argsAfterLeave);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Warranty',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_WANTY5919_76', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Warranty
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_WANTY5919_76").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_WANTYDIL_5919 = $scope.vc.model.Warranty;
            $scope.vc.trackers.Warranty = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Warranty);
            $scope.vc.model.Warranty.bind('change', function(e) {
                $scope.vc.trackers.Warranty.track(e);
            });
            $scope.vc.grids.QV_WANTY5919_76 = {};
            $scope.vc.grids.QV_WANTY5919_76.queryId = 'Q_WANTYDIL_5919';
            $scope.vc.viewState.QV_WANTY5919_76 = {
                style: undefined
            };
            $scope.vc.viewState.QV_WANTY5919_76.column = {};
            $scope.vc.grids.QV_WANTY5919_76.events = {
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
                    $scope.vc.trackers.Warranty.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_WANTY5919_76.selectedRow = e.model;
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
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'Warranty',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_WANTY5919_76", args, function() {
                        if (args.cancel) {
                            $("#QV_WANTY5919_76").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_WANTY5919_76");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_WANTY5919_76.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_WANTY5919_76.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_WANTY5919_76.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Warranty",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_WANTY5919_76", args);
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
            $scope.vc.grids.QV_WANTY5919_76.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_WANTY5919_76.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_WANTY5919_76.column.CodeWarranty = {
                title: 'BUSIN.DLB_BUSIN_DWARRANTY_01979',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_CODT683',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710CODT71 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.CodeWarranty.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_CODT683",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.CodeWarranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.CodeWarranty.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.CodeWarranty.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TYPEYLJIK_10770',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_TYPE104',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710TYPE01 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_TYPE104",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_CRII574',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710CRII81 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_CRII574",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.Description.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.InitialValue = {
                title: 'BUSIN.DLB_BUSIN_NITIALVLU_66179',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_INTI334',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710INTI51 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.InitialValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_INTI334",
                        'maxlength': 18,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.InitialValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_WANTY5919_76.column.InitialValue.format",
                        'k-decimals': "vc.viewState.QV_WANTY5919_76.column.InitialValue.decimals",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.InitialValue.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.InitialValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue = {
                title: 'BUSIN.DLB_BUSIN_VUATODATE_41694',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_ATAS145',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710ATAS35 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_ATAS145",
                        'maxlength': 60,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.ValueApportionment = {
                title: 'BUSIN.DLB_BUSIN_APPOIONEA_90622',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_PMET580',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710PMET71 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.ValueApportionment.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_PMET580",
                        'maxlength': 18,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.ValueApportionment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_WANTY5919_76.column.ValueApportionment.format",
                        'k-decimals': "vc.viewState.QV_WANTY5919_76.column.ValueApportionment.decimals",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.ValueApportionment.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.ValueApportionment.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.ValueAvailable = {
                title: 'BUSIN.DLB_BUSIN_VAEAAILAL_53568',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_VUAA272',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710VUAA77 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.ValueAvailable.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_VUAA272",
                        'maxlength': 18,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.ValueAvailable.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_WANTY5919_76.column.ValueAvailable.format",
                        'k-decimals': "vc.viewState.QV_WANTY5919_76.column.ValueAvailable.decimals",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.ValueAvailable.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.ValueAvailable.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.State = {
                title: 'BUSIN.DLB_BUSIN_STATUSUAS_80798',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWNDETAILW3061_STAT447',
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.AT_WAR710STAT86 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.State.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWNDETAILW3061_STAT447",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_WANTY5919_76.column.State.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VWNDETAILW30_26,0",
                        'ng-disabled': "!vc.viewState.QV_WANTY5919_76.column.State.enabled",
                        'ng-class': "vc.viewState.QV_WANTY5919_76.column.State.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.NameGar = {
                title: 'NameGar',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.IdCustomer = {
                title: 'IdCustomer',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_WANTY5919_76.column.ClassOpen = {
                title: 'ClassOpen',
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
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'CodeWarranty',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.CodeWarranty.title|translate:vc.viewState.QV_WANTY5919_76.column.CodeWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.CodeWarranty.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.CodeWarranty.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710CODT71.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.CodeWarranty.element[dataItem.uid].style'>#if (CodeWarranty !== null) {# #=CodeWarranty# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.CodeWarranty.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.CodeWarranty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.CodeWarranty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.Type.title|translate:vc.viewState.QV_WANTY5919_76.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.Type.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.Type.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710TYPE01.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.Type.element[dataItem.uid].style'>#if (Type !== null) {# #=Type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.Type.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.Description.title|translate:vc.viewState.QV_WANTY5919_76.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.Description.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.Description.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710CRII81.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.Description.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'InitialValue',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.InitialValue.title|translate:vc.viewState.QV_WANTY5919_76.column.InitialValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.InitialValue.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.InitialValue.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710INTI51.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.InitialValue.element[dataItem.uid].style' ng-bind='kendo.toString(#=InitialValue#, vc.viewState.QV_WANTY5919_76.column.InitialValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.InitialValue.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.InitialValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.InitialValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'DateAppraisedValue',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.title|translate:vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710ATAS35.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.element[dataItem.uid].style'>#if (DateAppraisedValue !== null) {# #=DateAppraisedValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.DateAppraisedValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'ValueApportionment',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.ValueApportionment.title|translate:vc.viewState.QV_WANTY5919_76.column.ValueApportionment.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.ValueApportionment.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.ValueApportionment.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710PMET71.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.ValueApportionment.element[dataItem.uid].style' ng-bind='kendo.toString(#=ValueApportionment#, vc.viewState.QV_WANTY5919_76.column.ValueApportionment.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.ValueApportionment.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.ValueApportionment.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.ValueApportionment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'ValueAvailable',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.ValueAvailable.title|translate:vc.viewState.QV_WANTY5919_76.column.ValueAvailable.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.ValueAvailable.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.ValueAvailable.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710VUAA77.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.ValueAvailable.element[dataItem.uid].style' ng-bind='kendo.toString(#=ValueAvailable#, vc.viewState.QV_WANTY5919_76.column.ValueAvailable.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.ValueAvailable.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.ValueAvailable.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.ValueAvailable.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_WANTY5919_76.columns.push({
                    field: 'State',
                    title: '{{vc.viewState.QV_WANTY5919_76.column.State.title|translate:vc.viewState.QV_WANTY5919_76.column.State.titleArgs}}',
                    width: $scope.vc.viewState.QV_WANTY5919_76.column.State.width,
                    format: $scope.vc.viewState.QV_WANTY5919_76.column.State.format,
                    editor: $scope.vc.grids.QV_WANTY5919_76.AT_WAR710STAT86.control,
                    template: "<span ng-class='vc.viewState.QV_WANTY5919_76.column.State.element[dataItem.uid].style'>#if (State !== null) {# #=State# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_WANTY5919_76.column.State.style",
                        "title": "{{vc.viewState.QV_WANTY5919_76.column.State.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_WANTY5919_76.column.State.hidden
                });
            }
            $scope.vc.viewState.QV_WANTY5919_76.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_WANTY5919_76.columns.push({
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_WANTY5919_76.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_WANTY5919_76.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_WANTY5919_76.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-show = 'vc.viewState.QV_WANTY5919_76.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_VWNDETAILW30_61.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_35_RAYTI33_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_35_RAYTI33_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Hide
            $scope.vc.createViewState({
                id: "CM_RAYTI33HIE19",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_STATUSUAS_80798",
                haslabelArgs: true,
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
                $scope.vc.render('VC_RAYTI33_AEAIL_889');
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
    var cobisMainModule = cobis.createModule("VC_RAYTI33_AEAIL_889", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_RAYTI33_AEAIL_889", {
            templateUrl: "VC_RAYTI33_AEAIL_889_FORM.html",
            controller: "VC_RAYTI33_AEAIL_889_CTRL",
            label: "WarrantyModify",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RAYTI33_AEAIL_889?" + $.param(search);
            }
        });
        VC_RAYTI33_AEAIL_889(cobisMainModule);
    }]);
} else {
    VC_RAYTI33_AEAIL_889(cobisMainModule);
}