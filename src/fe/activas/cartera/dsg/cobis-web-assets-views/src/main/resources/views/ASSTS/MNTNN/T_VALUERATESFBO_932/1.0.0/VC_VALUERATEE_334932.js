//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.valuerates = designerEvents.api.valuerates || designer.dsgEvents();

function VC_VALUERATEE_334932(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_VALUERATEE_334932_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_VALUERATEE_334932_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_VALUERATESFBO_932",
            taskVersion: "1.0.0",
            viewContainerId: "VC_VALUERATEE_334932",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_VALUERATESFBO_932",
        designerEvents.api.valuerates,
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
                vcName: 'VC_VALUERATEE_334932'
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
                    taskId: 'T_VALUERATESFBO_932',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    TypeRates: "TypeRates",
                    Rates: "Rates",
                    ServerParameter: "ServerParameter"
                },
                entities: {
                    TypeRates: {
                        identifier: 'AT14_IDENTIIE478',
                        description: 'AT98_DESCRIPN478',
                        clase: 'AT89_CLASECUE478',
                        ratePit: 'AT45_RATEPITT478',
                        _pks: [],
                        _entityId: 'EN_VALUERATE_478',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Rates: {
                        referenceValue: 'AT14_REFEREUV494',
                        value: 'AT69_VALUEMQK494',
                        portfolioClass: 'AT61_PORTFOSO494',
                        typePoints: 'AT17_TYPEPONS494',
                        numberDecimals: 'AT26_NUMBERMI494',
                        signDefault: 'AT86_SIGNODEA494',
                        valueDeafult: 'AT25_VALUEDET494',
                        lockedDefault: 'AT65_LOCKEDLL494',
                        signMin: 'AT96_SIGNMINN494',
                        valueMin: 'AT61_VALUEMIN494',
                        lockedMin: 'AT43_LOCKEDMI494',
                        signMax: 'AT87_SIGNMAXX494',
                        valueMax: 'AT57_VALUEMXA494',
                        lockedMax: 'AT80_LOCKEDXX494',
                        rateType: 'AT48_RATETYPE494',
                        clase: 'AT78_CLASEUBE494',
                        _pks: [],
                        _entityId: 'EN_RATESTIRW_494',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ServerParameter: {
                        loanBankID: 'AT83_LOANBADD884',
                        selectedRow: 'AT50_SELECTED884',
                        amount: 'AT64_AMOUNTCK884',
                        condonationPercentage: 'AT30_CONDONIE884',
                        flag: 'AT69_FLAGHWCK884',
                        refresGridFlag: 'AT58_REFRESRG884',
                        refresGrid2Flag: 'AT81_REFRESAD884',
                        _pks: [],
                        _entityId: 'EN_SERVERPRA_884',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_RATESEXU_5693 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_RATESEXU_5693 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RATESEXU_5693_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_RATESEXU_5693_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RATESTIRW_494',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RATESEXU_5693',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_RATESEXU_5693_filters = {};
            $scope.vc.queryProperties.Q_TYPERASE_1722 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_TYPERASE_1722 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TYPERASE_1722_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_TYPERASE_1722_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_VALUERATE_478',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TYPERASE_1722',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_TYPERASE_1722_filters = {};
            var defaultValues = {
                TypeRates: {},
                Rates: {},
                ServerParameter: {}
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
                $scope.vc.execute("temporarySave", VC_VALUERATEE_334932, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_VALUERATEE_334932, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_VALUERATEE_334932, data, function() {});
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
            $scope.vc.viewState.VC_VALUERATEE_334932 = {
                style: []
            }
            //ViewState - Group: Group1755
            $scope.vc.createViewState({
                id: "G_VALUERATST_602476",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOTASAA_68977",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.TypeRates = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    identifier: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TypeRates", "identifier", ''),
                        validation: {
                            identifierRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TypeRates", "description", ''),
                        validation: {
                            descriptionRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    clase: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TypeRates", "clase", ''),
                        validation: {
                            claseRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    ratePit: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TypeRates", "ratePit", ''),
                        validation: {
                            ratePitRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.TypeRates = new kendo.data.DataSource({
                pageSize: 4,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_TYPERASE_1722();
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
                            nameEntityGrid: 'TypeRates',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_1722_99596', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.TypeRates
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1722_99596").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TYPERASE_1722 = $scope.vc.model.TypeRates;
            $scope.vc.trackers.TypeRates = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.TypeRates);
            $scope.vc.model.TypeRates.bind('change', function(e) {
                $scope.vc.trackers.TypeRates.track(e);
            });
            $scope.vc.grids.QV_1722_99596 = {};
            $scope.vc.grids.QV_1722_99596.queryId = 'Q_TYPERASE_1722';
            $scope.vc.viewState.QV_1722_99596 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1722_99596.column = {};
            $scope.vc.grids.QV_1722_99596.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_1722_99596.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.TypeRates(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_TYPERATESMALA_545",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_TYPERATEDA_850545',
                        title: ''
                    };
                    $scope.vc.beforeOpenGridDialog("QV_1722_99596", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    $scope.vc.grids.QV_1722_99596.selectedRow = dataItem;
                    var rowIndex = grid.dataSource.indexOf(dataItem);
                    var row = grid.tbody.find(">tr:not(.k-grouping-row)").eq(rowIndex);
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        isNew: false,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_TYPERATESMALA_545",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_TYPERATEDA_850545',
                        title: ''
                    };
                    $scope.vc.beforeOpenGridDialog("QV_1722_99596", dialogParameters);
                },
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_1722_99596");
                    $scope.vc.hideShowColumns("QV_1722_99596", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1722_99596.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1722_99596.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1722_99596.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1722_99596 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1722_99596 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_1722_99596.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_1722_99596.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_1722_99596.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "TypeRates",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_1722_99596", args);
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
            $scope.vc.grids.QV_1722_99596.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1722_99596.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1722_99596.column.identifier = {
                title: 'ASSTS.LBL_ASSTS_IDENTIFCR_66965',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXJPR_423476',
                element: []
            };
            $scope.vc.viewState.QV_1722_99596.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPNI_65857',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXDHV_388476',
                element: []
            };
            $scope.vc.viewState.QV_1722_99596.column.clase = {
                title: 'ASSTS.LBL_ASSTS_CLASEBNBK_90328',
                titleArgs: {},
                tooltip: '',
                width: 25,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXNWQ_921476',
                element: []
            };
            $scope.vc.viewState.QV_1722_99596.column.ratePit = {
                title: 'ASSTS.LBL_ASSTS_TASAPITGY_32459',
                titleArgs: {},
                tooltip: '',
                width: 30,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZYD_294476',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1722_99596.columns.push({
                    field: 'identifier',
                    title: '{{vc.viewState.QV_1722_99596.column.identifier.title|translate:vc.viewState.QV_1722_99596.column.identifier.titleArgs}}',
                    width: $scope.vc.viewState.QV_1722_99596.column.identifier.width,
                    format: $scope.vc.viewState.QV_1722_99596.column.identifier.format,
                    template: "<span ng-class='vc.viewState.QV_1722_99596.column.identifier.style' ng-bind='vc.getStringColumnFormat(dataItem.identifier, \"QV_1722_99596\", \"identifier\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1722_99596.column.identifier.style",
                        "title": "{{vc.viewState.QV_1722_99596.column.identifier.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1722_99596.column.identifier.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1722_99596.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_1722_99596.column.description.title|translate:vc.viewState.QV_1722_99596.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_1722_99596.column.description.width,
                    format: $scope.vc.viewState.QV_1722_99596.column.description.format,
                    template: "<span ng-class='vc.viewState.QV_1722_99596.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_1722_99596\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1722_99596.column.description.style",
                        "title": "{{vc.viewState.QV_1722_99596.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1722_99596.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1722_99596.columns.push({
                    field: 'clase',
                    title: '{{vc.viewState.QV_1722_99596.column.clase.title|translate:vc.viewState.QV_1722_99596.column.clase.titleArgs}}',
                    width: $scope.vc.viewState.QV_1722_99596.column.clase.width,
                    format: $scope.vc.viewState.QV_1722_99596.column.clase.format,
                    template: "<span ng-class='vc.viewState.QV_1722_99596.column.clase.style' ng-bind='vc.getStringColumnFormat(dataItem.clase, \"QV_1722_99596\", \"clase\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1722_99596.column.clase.style",
                        "title": "{{vc.viewState.QV_1722_99596.column.clase.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1722_99596.column.clase.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1722_99596.columns.push({
                    field: 'ratePit',
                    title: '{{vc.viewState.QV_1722_99596.column.ratePit.title|translate:vc.viewState.QV_1722_99596.column.ratePit.titleArgs}}',
                    width: $scope.vc.viewState.QV_1722_99596.column.ratePit.width,
                    format: $scope.vc.viewState.QV_1722_99596.column.ratePit.format,
                    template: "<span ng-class='vc.viewState.QV_1722_99596.column.ratePit.style' ng-bind='vc.getStringColumnFormat(dataItem.ratePit, \"QV_1722_99596\", \"ratePit\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1722_99596.column.ratePit.style",
                        "title": "{{vc.viewState.QV_1722_99596.column.ratePit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1722_99596.column.ratePit.hidden
                });
            }
            $scope.vc.viewState.QV_1722_99596.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_1722_99596.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_1722_99596.column.cmdEdition = {};
            $scope.vc.viewState.QV_1722_99596.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_1722_99596.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "TypeRates",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_1722_99596.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_1722_99596.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_VALUERATST_602476.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_1722_99596.events.customEdit($event, \"#:entity#\", grids.QV_1722_99596)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_1722_99596.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_1722_99596.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_VALUERATST_602476.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_1722_99596.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_1722_99596.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_1722_99596.toolbar = [{
                "name": "create",
                "entity": "TypeRates",
                "text": "",
                "template": "<button id = 'QV_1722_99596_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_1722_99596.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_VALUERATST_602476.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_1722_99596.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Group: Group2983
            $scope.vc.createViewState({
                id: "G_VALUERAESS_300476",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TASASWEXW_63256",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Rates = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    portfolioClass: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "portfolioClass", '')
                    },
                    signDefault: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "signDefault", '')
                    },
                    valueDeafult: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "valueDeafult", 0)
                    },
                    signMin: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "signMin", '')
                    },
                    valueMin: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "valueMin", 0)
                    },
                    signMax: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "signMax", '')
                    },
                    valueMax: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "valueMax", 0)
                    },
                    referenceValue: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "referenceValue", '')
                    },
                    typePoints: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "typePoints", '')
                    },
                    numberDecimals: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Rates", "numberDecimals", 0)
                    }
                }
            });
            $scope.vc.model.Rates = new kendo.data.DataSource({
                pageSize: 4,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_RATESEXU_5693();
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
                            nameEntityGrid: 'Rates',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5693_54772', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Rates
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5693_54772").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RATESEXU_5693 = $scope.vc.model.Rates;
            $scope.vc.trackers.Rates = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Rates);
            $scope.vc.model.Rates.bind('change', function(e) {
                $scope.vc.trackers.Rates.track(e);
            });
            $scope.vc.grids.QV_5693_54772 = {};
            $scope.vc.grids.QV_5693_54772.queryId = 'Q_RATESEXU_5693';
            $scope.vc.viewState.QV_5693_54772 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5693_54772.column = {};
            $scope.vc.grids.QV_5693_54772.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_5693_54772.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.Rates(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_RATESMODALKUB_953",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_RATESMODAL_789953',
                        title: 'ASSTS.LBL_ASSTS_DETALLEAE_70070',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_5693_54772", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    $scope.vc.grids.QV_5693_54772.selectedRow = dataItem;
                    var rowIndex = grid.dataSource.indexOf(dataItem);
                    var row = grid.tbody.find(">tr:not(.k-grouping-row)").eq(rowIndex);
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        isNew: false,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_RATESMODALKUB_953",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_RATESMODAL_789953',
                        title: 'ASSTS.LBL_ASSTS_DETALLEAE_70070',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_5693_54772", dialogParameters);
                },
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_5693_54772");
                    $scope.vc.hideShowColumns("QV_5693_54772", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5693_54772.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5693_54772.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5693_54772.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5693_54772 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5693_54772 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_5693_54772.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_5693_54772.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_5693_54772.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Rates",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_5693_54772", args);
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
            $scope.vc.grids.QV_5693_54772.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5693_54772.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5693_54772.column.portfolioClass = {
                title: 'ASSTS.LBL_ASSTS_SECTORYDN_72932',
                titleArgs: {},
                tooltip: '',
                width: 40,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDPU_105476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.signDefault = {
                title: 'ASSTS.LBL_ASSTS_SIGDEFEOC_85304',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKJK_302476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.valueDeafult = {
                title: 'ASSTS.LBL_ASSTS_VALDEFEOO_14049',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAYP_243476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.signMin = {
                title: 'ASSTS.LBL_ASSTS_SIGMINIMO_52027',
                titleArgs: {},
                tooltip: '',
                width: 60,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMNM_532476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.valueMin = {
                title: 'ASSTS.LBL_ASSTS_VALMINIMO_80016',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXGJ_686476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.signMax = {
                title: 'ASSTS.LBL_ASSTS_SIGMAXIOM_73301',
                titleArgs: {},
                tooltip: '',
                width: 60,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUQS_969476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.valueMax = {
                title: 'ASSTS.LBL_ASSTS_VALMXIMOO_58863',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOWX_809476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.referenceValue = {
                title: 'ASSTS.LBL_ASSTS_REFERENCI_47355',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYSN_932476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.typePoints = {
                title: 'ASSTS.LBL_ASSTS_TIPOPUNOS_62324',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIDK_995476',
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.numberDecimals = {
                title: 'ASSTS.LBL_ASSTS_NUMDECIEE_20117',
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
                componentId: 'VA_TEXTINPUTBOXYOK_680476',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'portfolioClass',
                    title: '{{vc.viewState.QV_5693_54772.column.portfolioClass.title|translate:vc.viewState.QV_5693_54772.column.portfolioClass.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.portfolioClass.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.portfolioClass.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.portfolioClass.style' ng-bind='vc.getStringColumnFormat(dataItem.portfolioClass, \"QV_5693_54772\", \"portfolioClass\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5693_54772.column.portfolioClass.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.portfolioClass.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.portfolioClass.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'signDefault',
                    title: '{{vc.viewState.QV_5693_54772.column.signDefault.title|translate:vc.viewState.QV_5693_54772.column.signDefault.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.signDefault.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.signDefault.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.signDefault.style' ng-bind='vc.getStringColumnFormat(dataItem.signDefault, \"QV_5693_54772\", \"signDefault\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5693_54772.column.signDefault.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.signDefault.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.signDefault.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'valueDeafult',
                    title: '{{vc.viewState.QV_5693_54772.column.valueDeafult.title|translate:vc.viewState.QV_5693_54772.column.valueDeafult.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.valueDeafult.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.valueDeafult.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.valueDeafult.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueDeafult, \"QV_5693_54772\", \"valueDeafult\"):kendo.toString(#=valueDeafult#, vc.viewState.QV_5693_54772.column.valueDeafult.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5693_54772.column.valueDeafult.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.valueDeafult.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.valueDeafult.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'signMin',
                    title: '{{vc.viewState.QV_5693_54772.column.signMin.title|translate:vc.viewState.QV_5693_54772.column.signMin.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.signMin.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.signMin.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.signMin.style' ng-bind='vc.getStringColumnFormat(dataItem.signMin, \"QV_5693_54772\", \"signMin\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5693_54772.column.signMin.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.signMin.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.signMin.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'valueMin',
                    title: '{{vc.viewState.QV_5693_54772.column.valueMin.title|translate:vc.viewState.QV_5693_54772.column.valueMin.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.valueMin.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.valueMin.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.valueMin.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueMin, \"QV_5693_54772\", \"valueMin\"):kendo.toString(#=valueMin#, vc.viewState.QV_5693_54772.column.valueMin.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5693_54772.column.valueMin.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.valueMin.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.valueMin.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'signMax',
                    title: '{{vc.viewState.QV_5693_54772.column.signMax.title|translate:vc.viewState.QV_5693_54772.column.signMax.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.signMax.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.signMax.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.signMax.style' ng-bind='vc.getStringColumnFormat(dataItem.signMax, \"QV_5693_54772\", \"signMax\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5693_54772.column.signMax.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.signMax.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.signMax.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'valueMax',
                    title: '{{vc.viewState.QV_5693_54772.column.valueMax.title|translate:vc.viewState.QV_5693_54772.column.valueMax.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.valueMax.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.valueMax.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.valueMax.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueMax, \"QV_5693_54772\", \"valueMax\"):kendo.toString(#=valueMax#, vc.viewState.QV_5693_54772.column.valueMax.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5693_54772.column.valueMax.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.valueMax.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.valueMax.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'referenceValue',
                    title: '{{vc.viewState.QV_5693_54772.column.referenceValue.title|translate:vc.viewState.QV_5693_54772.column.referenceValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.referenceValue.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.referenceValue.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.referenceValue.style' ng-bind='vc.getStringColumnFormat(dataItem.referenceValue, \"QV_5693_54772\", \"referenceValue\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5693_54772.column.referenceValue.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.referenceValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.referenceValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'typePoints',
                    title: '{{vc.viewState.QV_5693_54772.column.typePoints.title|translate:vc.viewState.QV_5693_54772.column.typePoints.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.typePoints.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.typePoints.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.typePoints.style' ng-bind='vc.getStringColumnFormat(dataItem.typePoints, \"QV_5693_54772\", \"typePoints\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5693_54772.column.typePoints.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.typePoints.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.typePoints.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5693_54772.columns.push({
                    field: 'numberDecimals',
                    title: '{{vc.viewState.QV_5693_54772.column.numberDecimals.title|translate:vc.viewState.QV_5693_54772.column.numberDecimals.titleArgs}}',
                    width: $scope.vc.viewState.QV_5693_54772.column.numberDecimals.width,
                    format: $scope.vc.viewState.QV_5693_54772.column.numberDecimals.format,
                    template: "<span ng-class='vc.viewState.QV_5693_54772.column.numberDecimals.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numberDecimals, \"QV_5693_54772\", \"numberDecimals\"):kendo.toString(#=numberDecimals#, vc.viewState.QV_5693_54772.column.numberDecimals.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5693_54772.column.numberDecimals.style",
                        "title": "{{vc.viewState.QV_5693_54772.column.numberDecimals.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5693_54772.column.numberDecimals.hidden
                });
            }
            $scope.vc.viewState.QV_5693_54772.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_5693_54772.column.cmdEdition = {};
            $scope.vc.viewState.QV_5693_54772.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_5693_54772.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Rates",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_5693_54772.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5693_54772.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_VALUERAESS_300476.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_5693_54772.events.customEdit($event, \"#:entity#\", grids.QV_5693_54772)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_5693_54772.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5693_54772.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_VALUERAESS_300476.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_5693_54772.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_5693_54772.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_5693_54772.toolbar = [{
                "name": "create",
                "entity": "Rates",
                "text": "",
                "template": "<button id = 'QV_5693_54772_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_5693_54772.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_VALUERAESS_300476.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_5693_54772.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            $scope.vc.model.ServerParameter = {
                loanBankID: $scope.vc.channelDefaultValues("ServerParameter", "loanBankID"),
                selectedRow: $scope.vc.channelDefaultValues("ServerParameter", "selectedRow"),
                amount: $scope.vc.channelDefaultValues("ServerParameter", "amount"),
                condonationPercentage: $scope.vc.channelDefaultValues("ServerParameter", "condonationPercentage"),
                flag: $scope.vc.channelDefaultValues("ServerParameter", "flag"),
                refresGridFlag: $scope.vc.channelDefaultValues("ServerParameter", "refresGridFlag"),
                refresGrid2Flag: $scope.vc.channelDefaultValues("ServerParameter", "refresGrid2Flag")
            };
            //ViewState - Group: Group2620
            $scope.vc.createViewState({
                id: "G_VALUERASET_210476",
                hasId: true,
                componentStyle: [],
                label: 'Group2620',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ServerParameter, Attribute: flag
            $scope.vc.createViewState({
                id: "VA_FLAGOBWXTOSONWQ_358476",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: ServerParameter, Attribute: refresGridFlag
            $scope.vc.createViewState({
                id: "VA_REFRESGRIDFLGAA_521476",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: ServerParameter, Attribute: refresGrid2Flag
            $scope.vc.createViewState({
                id: "VA_REFRESGRID2FLGA_953476",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_VALUERATESFBO_932_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_VALUERATESFBO_932_CANCEL",
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
                $scope.vc.render('VC_VALUERATEE_334932');
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
    var cobisMainModule = cobis.createModule("VC_VALUERATEE_334932", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_VALUERATEE_334932", {
            templateUrl: "VC_VALUERATEE_334932_FORM.html",
            controller: "VC_VALUERATEE_334932_CTRL",
            labelId: "ASSTS.LBL_ASSTS_VALORESIP_53552",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_VALUERATEE_334932?" + $.param(search);
            }
        });
        VC_VALUERATEE_334932(cobisMainModule);
    }]);
} else {
    VC_VALUERATEE_334932(cobisMainModule);
}