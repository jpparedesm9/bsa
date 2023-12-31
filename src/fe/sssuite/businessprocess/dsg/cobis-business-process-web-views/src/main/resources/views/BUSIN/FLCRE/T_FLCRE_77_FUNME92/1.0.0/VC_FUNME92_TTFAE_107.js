<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tfuentefinanciamiento = designerEvents.api.tfuentefinanciamiento || designer.dsgEvents();

function VC_FUNME92_TTFAE_107(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_FUNME92_TTFAE_107_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_FUNME92_TTFAE_107_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_77_FUNME92",
            taskVersion: "1.0.0",
            viewContainerId: "VC_FUNME92_TTFAE_107",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_77_FUNME92",
        designerEvents.api.tfuentefinanciamiento,
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
                vcName: 'VC_FUNME92_TTFAE_107'
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
                    taskId: 'T_FLCRE_77_FUNME92',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    SourceFunding: "SourceFunding"
                },
                entities: {
                    SourceFunding: {
                        FundingSource: 'AT_OUR956NSOR58',
                        SectorActivity: 'AT_OUR956EORY19',
                        ObjectCredit: 'AT_OUR956OJEC51',
                        Currency: 'AT_OUR956CRNC74',
                        MinimunAmout: 'AT_OUR956NUNM30',
                        MaximunAmount: 'AT_OUR956MNAT44',
                        PaymentFrecuency: 'AT_OUR956ATNC43',
                        MaximunTerm: 'AT_OUR956IIRM65',
                        MinimunRate: 'AT_OUR956XMUT35',
                        MaximunRate: 'AT_OUR956MXAE20',
                        CodeSource: 'AT_OUR956COOC17',
                        _pks: [],
                        _entityId: 'EN_OURCFUNDN956',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_COURCUNG_4312 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_COURCUNG_4312 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_COURCUNG_4312 = {
                mainEntityPk: {
                    entityId: 'EN_OURCFUNDN956',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_COURCUNG_4312',
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
                SourceFunding: {}
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
            $scope.vc.viewState.VC_FUNME92_TTFAE_107 = {
                style: []
            }
            //ViewState - Group: Matriz
            $scope.vc.createViewState({
                id: "GR_IWSORCENIN87_04",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_UDFINIAME_09623",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.SourceFunding = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    FundingSource: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "FundingSource", ''),
                        validation: {
                            FundingSourceRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    SectorActivity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "SectorActivity", ''),
                        validation: {
                            SectorActivityRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    ObjectCredit: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "ObjectCredit", ''),
                        validation: {
                            ObjectCreditRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Currency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "Currency", ''),
                        validation: {
                            CurrencyRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    MinimunAmout: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "MinimunAmout", 0)
                    },
                    MaximunAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "MaximunAmount", 0)
                    },
                    PaymentFrecuency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "PaymentFrecuency", '')
                    },
                    MaximunTerm: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "MaximunTerm", 0)
                    },
                    MinimunRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "MinimunRate", 0)
                    },
                    MaximunRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceFunding", "MaximunRate", 0)
                    },
                    CodeSource: {
                        type: "number",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.SourceFunding = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_COURCUNG_4312', function(data) {
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
                            nameEntityGrid: 'SourceFunding',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_COURC4312_01', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.SourceFunding
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_COURC4312_01").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_COURCUNG_4312 = $scope.vc.model.SourceFunding;
            $scope.vc.trackers.SourceFunding = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.SourceFunding);
            $scope.vc.model.SourceFunding.bind('change', function(e) {
                $scope.vc.trackers.SourceFunding.track(e);
            });
            $scope.vc.grids.QV_COURC4312_01 = {};
            $scope.vc.grids.QV_COURC4312_01.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_COURC4312_01) && expandedRowUidActual !== expandedRowUid_QV_COURC4312_01) {
                    var gridWidget = $('#QV_COURC4312_01').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_COURC4312_01 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_COURC4312_01 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_COURC4312_01 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_COURC4312_01);
                }
                expandedRowUid_QV_COURC4312_01 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_COURC4312_01', args);
                if (angular.isDefined($scope.vc.grids.QV_COURC4312_01.view)) {
                    $scope.vc.grids.QV_COURC4312_01.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_COURC4312_01.customView)) {
                    $scope.vc.grids.QV_COURC4312_01.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_COURC4312_01'/>"
            };
            $scope.vc.grids.QV_COURC4312_01.queryId = 'Q_COURCUNG_4312';
            $scope.vc.viewState.QV_COURC4312_01 = {
                style: undefined
            };
            $scope.vc.viewState.QV_COURC4312_01.column = {};
            var expandedRowUid_QV_COURC4312_01;
            $scope.vc.grids.QV_COURC4312_01.events = {
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
                    $scope.vc.trackers.SourceFunding.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_COURC4312_01.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_COURC4312_01");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_COURC4312_01.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_COURC4312_01.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_COURC4312_01.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "SourceFunding",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_COURC4312_01", args);
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
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_COURC4312_01 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_COURC4312_01.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_COURC4312_01.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_COURC4312_01.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_COURC4312_01 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_COURC4312_01 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                detailExpand: function(e) {
                    $(e.detailRow.find(".k-hierarchy-cell")).insertAfter($("td:last", e.detailRow));
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_COURC4312_01.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_COURC4312_01.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_COURC4312_01.column.FundingSource = {
                title: 'BUSIN.DLB_BUSIN_ETDEFAAMI_27181',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_IWSORCENIN8704_NSOR931',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_IWSORCENIN8704_NSOR931 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_IWSORCENIN8704_NSOR931_values)) {
                            $scope.vc.catalogs.VA_IWSORCENIN8704_NSOR931_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_IWSORCENIN8704_NSOR931',
                                'ca_origen_fondo',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_IWSORCENIN8704_NSOR931'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_IWSORCENIN8704_NSOR931_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_NSOR931");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_IWSORCENIN8704_NSOR931_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_NSOR931");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956NSOR58 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.FundingSource.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_NSOR931",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_COURC4312_01.column.FundingSource.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_IWSORCENIN8704_NSOR931",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_COURC4312_01.column.FundingSource.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ETDEFAAMI_27181') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.FundingSource.validationCode}}",
                        'dsgrequired': "",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.SectorActivity = {
                title: 'BUSIN.DLB_BUSIN_CTDEACIDD_46781',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_IWSORCENIN8704_EORY405',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_IWSORCENIN8704_EORY405 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_IWSORCENIN8704_EORY405_values)) {
                            $scope.vc.catalogs.VA_IWSORCENIN8704_EORY405_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_IWSORCENIN8704_EORY405',
                                'cl_sector_economico',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_IWSORCENIN8704_EORY405'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_IWSORCENIN8704_EORY405_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_EORY405");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_IWSORCENIN8704_EORY405_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_EORY405");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956EORY19 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.SectorActivity.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_EORY405",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_COURC4312_01.column.SectorActivity.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_IWSORCENIN8704_EORY405",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_COURC4312_01.column.SectorActivity.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CTDEACIDD_46781') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.SectorActivity.validationCode}}",
                        'dsgrequired': "",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.ObjectCredit = {
                title: 'BUSIN.DLB_BUSIN_ETCREDITO_65642',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_IWSORCENIN8704_OJEC009',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_IWSORCENIN8704_OJEC009 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_IWSORCENIN8704_OJEC009_values)) {
                            $scope.vc.catalogs.VA_IWSORCENIN8704_OJEC009_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_IWSORCENIN8704_OJEC009',
                                'cr_objeto',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_IWSORCENIN8704_OJEC009'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_IWSORCENIN8704_OJEC009_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_OJEC009");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_IWSORCENIN8704_OJEC009_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_OJEC009");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956OJEC51 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.ObjectCredit.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_OJEC009",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_COURC4312_01.column.ObjectCredit.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_IWSORCENIN8704_OJEC009",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_COURC4312_01.column.ObjectCredit.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ETCREDITO_65642') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.ObjectCredit.validationCode}}",
                        'dsgrequired': "",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_IWSORCENIN8704_CRNC109',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_IWSORCENIN8704_CRNC109 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_IWSORCENIN8704_CRNC109_values)) {
                            $scope.vc.catalogs.VA_IWSORCENIN8704_CRNC109_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_IWSORCENIN8704_CRNC109',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_IWSORCENIN8704_CRNC109'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_IWSORCENIN8704_CRNC109_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_CRNC109");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_IWSORCENIN8704_CRNC109_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_CRNC109");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956CRNC74 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_CRNC109",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_COURC4312_01.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_IWSORCENIN8704_CRNC109",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_COURC4312_01.column.Currency.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_MONEDAQAQ_04700') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.Currency.validationCode}}",
                        'dsgrequired': "",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.MinimunAmout = {
                title: 'BUSIN.DLB_BUSIN_MONTOINIO_81578',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IWSORCENIN8704_NUNM003',
                element: []
            };
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956NUNM30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MinimunAmout.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_NUNM003",
                        'maxlength': 53,
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.MinimunAmout.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_COURC4312_01.column.MinimunAmout.format",
                        'k-decimals': "vc.viewState.QV_COURC4312_01.column.MinimunAmout.decimals",
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MinimunAmout.enabled",
                        'ng-class': "vc.viewState.QV_COURC4312_01.column.MinimunAmout.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.MaximunAmount = {
                title: 'BUSIN.DLB_BUSIN_MONTOMAXI_85573',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IWSORCENIN8704_MNAT429',
                element: []
            };
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956MNAT44 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MaximunAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_MNAT429",
                        'maxlength': 53,
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.MaximunAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_COURC4312_01.column.MaximunAmount.format",
                        'k-decimals': "vc.viewState.QV_COURC4312_01.column.MaximunAmount.decimals",
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MaximunAmount.enabled",
                        'ng-class': "vc.viewState.QV_COURC4312_01.column.MaximunAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.PaymentFrecuency = {
                title: 'BUSIN.DLB_BUSIN_FRUENCAPA_98048',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IWSORCENIN8704_ATNC995',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_IWSORCENIN8704_ATNC995 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_IWSORCENIN8704_ATNC995_values)) {
                            $scope.vc.catalogs.VA_IWSORCENIN8704_ATNC995_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_IWSORCENIN8704_ATNC995',
                                'ca_tdividendo',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_IWSORCENIN8704_ATNC995'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_IWSORCENIN8704_ATNC995_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_ATNC995");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_IWSORCENIN8704_ATNC995_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_COURC4312_01", "VA_IWSORCENIN8704_ATNC995");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956ATNC43 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_ATNC995",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_IWSORCENIN8704_ATNC995",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.template",
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.validationCode}}",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.MaximunTerm = {
                title: 'BUSIN.DLB_BUSIN_PAZOMAIMO_13951',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IWSORCENIN8704_IIRM502',
                element: []
            };
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956IIRM65 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MaximunTerm.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_IIRM502",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.MaximunTerm.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_COURC4312_01.column.MaximunTerm.format",
                        'k-decimals': "vc.viewState.QV_COURC4312_01.column.MaximunTerm.decimals",
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MaximunTerm.enabled",
                        'ng-class': "vc.viewState.QV_COURC4312_01.column.MaximunTerm.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.MinimunRate = {
                title: 'BUSIN.DLB_BUSIN_TASAMNIMA_01508',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IWSORCENIN8704_XMUT186',
                element: []
            };
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956XMUT35 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MinimunRate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_XMUT186",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.MinimunRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_COURC4312_01.column.MinimunRate.format",
                        'k-decimals': "vc.viewState.QV_COURC4312_01.column.MinimunRate.decimals",
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MinimunRate.enabled",
                        'ng-class': "vc.viewState.QV_COURC4312_01.column.MinimunRate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.MaximunRate = {
                title: 'BUSIN.DLB_BUSIN_TASAMXIMA_28676',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IWSORCENIN8704_MXAE798',
                element: []
            };
            $scope.vc.grids.QV_COURC4312_01.AT_OUR956MXAE20 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MaximunRate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IWSORCENIN8704_MXAE798",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_COURC4312_01.column.MaximunRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_COURC4312_01.column.MaximunRate.format",
                        'k-decimals': "vc.viewState.QV_COURC4312_01.column.MaximunRate.decimals",
                        'ng-disabled': "!vc.viewState.QV_COURC4312_01.column.MaximunRate.enabled",
                        'ng-class': "vc.viewState.QV_COURC4312_01.column.MaximunRate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_COURC4312_01.column.CodeSource = {
                title: 'CodigoFuenteFinanciamiento',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'FundingSource',
                    title: '{{vc.viewState.QV_COURC4312_01.column.FundingSource.title|translate:vc.viewState.QV_COURC4312_01.column.FundingSource.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.FundingSource.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.FundingSource.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956NSOR58.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.FundingSource.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_IWSORCENIN8704_NSOR931.get(dataItem.FundingSource).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.FundingSource.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.FundingSource.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.FundingSource.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'SectorActivity',
                    title: '{{vc.viewState.QV_COURC4312_01.column.SectorActivity.title|translate:vc.viewState.QV_COURC4312_01.column.SectorActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.SectorActivity.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.SectorActivity.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956EORY19.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.SectorActivity.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_IWSORCENIN8704_EORY405.get(dataItem.SectorActivity).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.SectorActivity.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.SectorActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.SectorActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'ObjectCredit',
                    title: '{{vc.viewState.QV_COURC4312_01.column.ObjectCredit.title|translate:vc.viewState.QV_COURC4312_01.column.ObjectCredit.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.ObjectCredit.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.ObjectCredit.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956OJEC51.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.ObjectCredit.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_IWSORCENIN8704_OJEC009.get(dataItem.ObjectCredit).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.ObjectCredit.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.ObjectCredit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.ObjectCredit.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_COURC4312_01.column.Currency.title|translate:vc.viewState.QV_COURC4312_01.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.Currency.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.Currency.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956CRNC74.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_IWSORCENIN8704_CRNC109.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.Currency.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'MinimunAmout',
                    title: '{{vc.viewState.QV_COURC4312_01.column.MinimunAmout.title|translate:vc.viewState.QV_COURC4312_01.column.MinimunAmout.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.MinimunAmout.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.MinimunAmout.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956NUNM30.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.MinimunAmout.element[dataItem.uid].style' ng-bind='kendo.toString(#=MinimunAmout#, vc.viewState.QV_COURC4312_01.column.MinimunAmout.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.MinimunAmout.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.MinimunAmout.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.MinimunAmout.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'MaximunAmount',
                    title: '{{vc.viewState.QV_COURC4312_01.column.MaximunAmount.title|translate:vc.viewState.QV_COURC4312_01.column.MaximunAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.MaximunAmount.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.MaximunAmount.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956MNAT44.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.MaximunAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=MaximunAmount#, vc.viewState.QV_COURC4312_01.column.MaximunAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.MaximunAmount.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.MaximunAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.MaximunAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'PaymentFrecuency',
                    title: '{{vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.title|translate:vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956ATNC43.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_IWSORCENIN8704_ATNC995.get(dataItem.PaymentFrecuency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.PaymentFrecuency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'MaximunTerm',
                    title: '{{vc.viewState.QV_COURC4312_01.column.MaximunTerm.title|translate:vc.viewState.QV_COURC4312_01.column.MaximunTerm.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.MaximunTerm.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.MaximunTerm.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956IIRM65.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.MaximunTerm.element[dataItem.uid].style' ng-bind='kendo.toString(#=MaximunTerm#, vc.viewState.QV_COURC4312_01.column.MaximunTerm.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.MaximunTerm.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.MaximunTerm.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.MaximunTerm.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'MinimunRate',
                    title: '{{vc.viewState.QV_COURC4312_01.column.MinimunRate.title|translate:vc.viewState.QV_COURC4312_01.column.MinimunRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.MinimunRate.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.MinimunRate.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956XMUT35.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.MinimunRate.element[dataItem.uid].style' ng-bind='kendo.toString(#=MinimunRate#, vc.viewState.QV_COURC4312_01.column.MinimunRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.MinimunRate.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.MinimunRate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.MinimunRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_COURC4312_01.columns.push({
                    field: 'MaximunRate',
                    title: '{{vc.viewState.QV_COURC4312_01.column.MaximunRate.title|translate:vc.viewState.QV_COURC4312_01.column.MaximunRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_COURC4312_01.column.MaximunRate.width,
                    format: $scope.vc.viewState.QV_COURC4312_01.column.MaximunRate.format,
                    editor: $scope.vc.grids.QV_COURC4312_01.AT_OUR956MXAE20.control,
                    template: "<span ng-class='vc.viewState.QV_COURC4312_01.column.MaximunRate.element[dataItem.uid].style' ng-bind='kendo.toString(#=MaximunRate#, vc.viewState.QV_COURC4312_01.column.MaximunRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_COURC4312_01.column.MaximunRate.style",
                        "title": "{{vc.viewState.QV_COURC4312_01.column.MaximunRate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_COURC4312_01.column.MaximunRate.hidden
                });
            }
            $scope.vc.viewState.QV_COURC4312_01.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_COURC4312_01.columns.push({
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_COURC4312_01.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_COURC4312_01.toolbar = {
                CEQV_201_QV_COURC4312_01_285: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_COURC4312_01.toolbar = [{
                "name": "CEQV_201_QV_COURC4312_01_285",
                "text": "{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}",
                "template": "<button id='CEQV_201_QV_COURC4312_01_285' ng-show='vc.viewState.QV_COURC4312_01.toolbar.CEQV_201_QV_COURC4312_01_285.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_COURC4312_01_285\",\"SourceFunding\")' class='btn btn-default cb-grid-button cb-btn-custom-nuevo'> #: text #</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_77_FUNME92_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_77_FUNME92_CANCEL",
                componentStyle: "",
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
                    $scope.vc.catalogs.VA_IWSORCENIN8704_NSOR931.read();
                    $scope.vc.catalogs.VA_IWSORCENIN8704_EORY405.read();
                    $scope.vc.catalogs.VA_IWSORCENIN8704_OJEC009.read();
                    $scope.vc.catalogs.VA_IWSORCENIN8704_CRNC109.read();
                    $scope.vc.catalogs.VA_IWSORCENIN8704_ATNC995.read();
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
                $scope.vc.render('VC_FUNME92_TTFAE_107');
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
    var cobisMainModule = cobis.createModule("VC_FUNME92_TTFAE_107", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_FUNME92_TTFAE_107", {
            templateUrl: "VC_FUNME92_TTFAE_107_FORM.html",
            controller: "VC_FUNME92_TTFAE_107_CTRL",
            label: "TFuenteFinanciamiento",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_FUNME92_TTFAE_107?" + $.param(search);
            }
        });
        VC_FUNME92_TTFAE_107(cobisMainModule);
    }]);
} else {
    VC_FUNME92_TTFAE_107(cobisMainModule);
}