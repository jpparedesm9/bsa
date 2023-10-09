//Designer Generator v 6.1.1 - release SPR 2017-03 17/02/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.plazoFijoPorCliente = designerEvents.api.plazoFijoPorCliente || designer.dsgEvents();

function VC_BYLET28_DTBCT_453(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_BYLET28_DTBCT_453_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_BYLET28_DTBCT_453_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_94_BYLET28",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BYLET28_DTBCT_453",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_94_BYLET28",
        designerEvents.api.plazoFijoPorCliente,
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
                vcName: 'VC_BYLET28_DTBCT_453'
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
                    taskId: 'T_FLCRE_94_BYLET28',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CustomerSearch: "CustomerSearch",
                    FixedTermOperation: "FixedTermOperation",
                    AccountInfomation: "AccountInfomation",
                    WarrantyGeneral: "WarrantyGeneral"
                },
                entities: {
                    CustomerSearch: {
                        identificationType: 'AT19_IDENTIIE765',
                        warrantyType: 'AT45_WARRANPT765',
                        identification: 'AT77_IDENTINO765',
                        FlagCriteria: 'AT_CTM765CRTA11',
                        Customer: 'AT_CTM765CSER32',
                        CustomerId: 'AT_CTM765CTRD40',
                        TypeObject: 'AT_CTM765EBCT18',
                        OfficerId: 'AT_CTM765FCED82',
                        Flagexit: 'AT_CTM765LGET20',
                        Officer: 'AT_CTM765OFIE85',
                        Principal: 'AT_CTM765PRIL69',
                        Expromission: 'AT_CTM765RMII18',
                        Sector: 'AT_CTM765SCTR12',
                        TypeOperation: 'AT_CTM765TETI67',
                        TypeProcess: 'AT_CTM765TPOE49',
                        _pks: [],
                        _entityId: 'EN_CTMERSEAR765',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    FixedTermOperation: {
                        montoDisponible: 'AT_IXE808NIBL34',
                        numBanco: 'AT_IXE808NMBA77',
                        montoInicial: 'AT_IXE808NTOL65',
                        montoBloqueado: 'AT_IXE808OTAD89',
                        descripcion: 'AT_IXE808SRII09',
                        estado: 'AT_IXE808STAO01',
                        montoGarantia: 'AT_IXE808TARA35',
                        _pks: ['numBanco'],
                        _entityId: 'EN_IXEMOERON808',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    AccountInfomation: {
                        accountStatus: 'AT14_ACCOUNUS293',
                        description: 'AT78_DESCRINT293',
                        availableBalance: 'AT89_AVAILABL293',
                        accountBank: 'AT91_ACCOUNAN293',
                        _pks: [],
                        _entityId: 'EN_ACCOUNTOA_293',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    WarrantyGeneral: {
                        accountAho: 'AT34_ACCOUNTH527',
                        guarantortype: 'AT49_GUARANTO527',
                        balanceAvailable: 'AT79_BALANCIL527',
                        suitability: 'AT82_SUITABIT527',
                        appraisalValue: 'AT_ARA527AIUE66',
                        branchOffice: 'AT_ARA527BRNC47',
                        code: 'AT_ARA527CODE39',
                        coverage: 'AT_ARA527CVER40',
                        admissionDate: 'AT_ARA527DONA32',
                        fixedTermAmount: 'AT_ARA527DRMA89',
                        valueSource: 'AT_ARA527ESOE58',
                        externalCode: 'AT_ARA527EXTE36',
                        office: 'AT_ARA527FICE71',
                        filial: 'AT_ARA527FILL12',
                        fixedTerm: 'AT_ARA527IDER64',
                        initialValue: 'AT_ARA527ILAE17',
                        instruction: 'AT_ARA527INRT24',
                        currency: 'AT_ARA527MONY07',
                        mandatoryDocument: 'AT_ARA527NORM65',
                        warrantyType: 'AT_ARA527NTYY17',
                        currentValue: 'AT_ARA527NVLE38',
                        documentNumber: 'AT_ARA527OEBE33',
                        constitutionDate: 'AT_ARA527OSUI69',
                        percentageCoverage: 'AT_ARA527RAGO02',
                        guarantor: 'AT_ARA527RNTR34',
                        description: 'AT_ARA527RTIO86',
                        status: 'AT_ARA527STTU29',
                        tramitNumber: 'AT_ARA527TRMB60',
                        appraisalDate: 'AT_ARA527VADT05',
                        owner: 'AT_ARA527WNER42',
                        _pks: [],
                        _entityId: 'EN_ARANYGENL527',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_FDMYLINR_8126 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_FDMYLINR_8126 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_FDMYLINR_8126_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_FDMYLINR_8126_filters;
                    parametersAux = {
                        Operacion: filters.Operacion,
                        Descripcion: filters.Descripcion,
                        Estado: filters.Estado,
                        montoDisponible: filters.montoDisponible
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_IXEMOERON808',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_FDMYLINR_8126',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['Operacion'] = this.filters.Operacion;
                            this.parameters['Descripcion'] = this.filters.Descripcion;
                            this.parameters['Estado'] = this.filters.Estado;
                            this.parameters['montoDisponible'] = this.filters.montoDisponible;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_FDMYLINR_8126_filters = {};
            $scope.vc.queryProperties.Q_ACCOUNIO_6427 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_ACCOUNIO_6427 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ACCOUNIO_6427_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ACCOUNIO_6427_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ACCOUNTOA_293',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ACCOUNIO_6427',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_ACCOUNIO_6427_filters = {};
            var defaultValues = {
                CustomerSearch: {},
                FixedTermOperation: {},
                AccountInfomation: {},
                WarrantyGeneral: {}
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
                $scope.vc.execute("temporarySave", VC_BYLET28_DTBCT_453, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_BYLET28_DTBCT_453, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_BYLET28_DTBCT_453, data, function() {});
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
            $scope.vc.viewState.VC_BYLET28_DTBCT_453 = {
                style: []
            }
            //ViewState - Group: GrpPrincipal
            $scope.vc.createViewState({
                id: "GR_IEDMBENTEW96_14",
                hasId: true,
                componentStyle: [],
                label: 'GrpPrincipal',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CustomerSearch = {
                identificationType: $scope.vc.channelDefaultValues("CustomerSearch", "identificationType"),
                warrantyType: $scope.vc.channelDefaultValues("CustomerSearch", "warrantyType"),
                identification: $scope.vc.channelDefaultValues("CustomerSearch", "identification"),
                FlagCriteria: $scope.vc.channelDefaultValues("CustomerSearch", "FlagCriteria"),
                Customer: $scope.vc.channelDefaultValues("CustomerSearch", "Customer"),
                CustomerId: $scope.vc.channelDefaultValues("CustomerSearch", "CustomerId"),
                TypeObject: $scope.vc.channelDefaultValues("CustomerSearch", "TypeObject"),
                OfficerId: $scope.vc.channelDefaultValues("CustomerSearch", "OfficerId"),
                Flagexit: $scope.vc.channelDefaultValues("CustomerSearch", "Flagexit"),
                Officer: $scope.vc.channelDefaultValues("CustomerSearch", "Officer"),
                Principal: $scope.vc.channelDefaultValues("CustomerSearch", "Principal"),
                Expromission: $scope.vc.channelDefaultValues("CustomerSearch", "Expromission"),
                Sector: $scope.vc.channelDefaultValues("CustomerSearch", "Sector"),
                TypeOperation: $scope.vc.channelDefaultValues("CustomerSearch", "TypeOperation"),
                TypeProcess: $scope.vc.channelDefaultValues("CustomerSearch", "TypeProcess")
            };
            //ViewState - Group: Client_Grp
            $scope.vc.createViewState({
                id: "GR_IEDMBENTEW96_03",
                hasId: true,
                componentStyle: [],
                label: 'Client_Grp',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CustomerSearch, Attribute: CustomerId
            $scope.vc.createViewState({
                id: "VA_IEDMBENTEW9603_CTRD166",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CLIENTESU_28757",
                format: "########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CustomerSearch, Attribute: Customer
            $scope.vc.createViewState({
                id: "VA_IEDMBENTEW9603_CSER816",
                componentStyle: ["cb-without-border"],
                label: '',
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IEDMBENTEW9603_CSER816 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_IEDMBENTEW9603_CSER816', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_IEDMBENTEW9603_CSER816'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IEDMBENTEW9603_CSER816");
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
            //ViewState - Group: FixedTerm_Grp
            $scope.vc.createViewState({
                id: "GR_IEDMBENTEW96_04",
                hasId: true,
                componentStyle: [],
                label: 'FixedTerm_Grp',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.FixedTermOperation = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    numBanco: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("FixedTermOperation", "numBanco", '')
                    },
                    descripcion: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("FixedTermOperation", "descripcion", '')
                    },
                    estado: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("FixedTermOperation", "estado", '')
                    },
                    montoDisponible: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("FixedTermOperation", "montoDisponible", 0)
                    }
                }
            });
            $scope.vc.model.FixedTermOperation = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_FDMYLINR_8126();
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
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.FixedTermOperation
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_FDMYL8126_98").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_FDMYLINR_8126 = $scope.vc.model.FixedTermOperation;
            $scope.vc.trackers.FixedTermOperation = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.FixedTermOperation);
            $scope.vc.model.FixedTermOperation.bind('change', function(e) {
                $scope.vc.trackers.FixedTermOperation.track(e);
            });
            $scope.vc.grids.QV_FDMYL8126_98 = {};
            $scope.vc.grids.QV_FDMYL8126_98.queryId = 'Q_FDMYLINR_8126';
            $scope.vc.viewState.QV_FDMYL8126_98 = {
                style: undefined
            };
            $scope.vc.viewState.QV_FDMYL8126_98.column = {};
            $scope.vc.grids.QV_FDMYL8126_98.editable = false;
            $scope.vc.grids.QV_FDMYL8126_98.events = {
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
                    $scope.vc.trackers.FixedTermOperation.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_FDMYL8126_98.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_FDMYL8126_98");
                    $scope.vc.hideShowColumns("QV_FDMYL8126_98", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_FDMYL8126_98.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_FDMYL8126_98.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_FDMYL8126_98.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_FDMYL8126_98 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_FDMYL8126_98 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_FDMYL8126_98.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_FDMYL8126_98.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_FDMYL8126_98.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "FixedTermOperation",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        $scope.vc.gridRowSelecting("QV_FDMYL8126_98", args);
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
            $scope.vc.grids.QV_FDMYL8126_98.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_FDMYL8126_98.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_FDMYL8126_98.column.numBanco = {
                title: 'BUSIN.LBL_BUSIN_NMERODEZA_65006',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IEDMBENTEW9604_NMBA181',
                element: []
            };
            $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808NMBA77 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_FDMYL8126_98.column.numBanco.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IEDMBENTEW9604_NMBA181",
                        'maxlength': 24,
                        'data-validation-code': "{{vc.viewState.QV_FDMYL8126_98.column.numBanco.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,1",
                        'ng-class': "vc.viewState.QV_FDMYL8126_98.column.numBanco.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_FDMYL8126_98.column.descripcion = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IEDMBENTEW9604_SRII915',
                element: []
            };
            $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808SRII09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_FDMYL8126_98.column.descripcion.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IEDMBENTEW9604_SRII915",
                        'maxlength': 255,
                        'data-validation-code': "{{vc.viewState.QV_FDMYL8126_98.column.descripcion.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,1",
                        'ng-class': "vc.viewState.QV_FDMYL8126_98.column.descripcion.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_FDMYL8126_98.column.estado = {
                title: 'BUSIN.DLB_BUSIN_ESTADORJE_43391',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IEDMBENTEW9604_STAO892',
                element: []
            };
            $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808STAO01 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_FDMYL8126_98.column.estado.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_IEDMBENTEW9604_STAO892",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_FDMYL8126_98.column.estado.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,1",
                        'ng-class': "vc.viewState.QV_FDMYL8126_98.column.estado.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_FDMYL8126_98.column.montoDisponible = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_IEDMBENTEW9604_NIBL630',
                element: []
            };
            $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808NIBL34 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_FDMYL8126_98.column.montoDisponible.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_IEDMBENTEW9604_NIBL630",
                        'data-validation-code': "{{vc.viewState.QV_FDMYL8126_98.column.montoDisponible.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_FDMYL8126_98.column.montoDisponible.format",
                        'k-decimals': "vc.viewState.QV_FDMYL8126_98.column.montoDisponible.decimals",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,1",
                        'ng-class': "vc.viewState.QV_FDMYL8126_98.column.montoDisponible.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_FDMYL8126_98.columns.push({
                    field: 'numBanco',
                    title: '{{vc.viewState.QV_FDMYL8126_98.column.numBanco.title|translate:vc.viewState.QV_FDMYL8126_98.column.numBanco.titleArgs}}',
                    width: $scope.vc.viewState.QV_FDMYL8126_98.column.numBanco.width,
                    format: $scope.vc.viewState.QV_FDMYL8126_98.column.numBanco.format,
                    editor: $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808NMBA77.control,
                    template: "<span ng-class='vc.viewState.QV_FDMYL8126_98.column.numBanco.element[dataItem.uid].style'>#if (numBanco !== null) {# #=numBanco# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_FDMYL8126_98.column.numBanco.style",
                        "title": "{{vc.viewState.QV_FDMYL8126_98.column.numBanco.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_FDMYL8126_98.column.numBanco.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_FDMYL8126_98.columns.push({
                    field: 'descripcion',
                    title: '{{vc.viewState.QV_FDMYL8126_98.column.descripcion.title|translate:vc.viewState.QV_FDMYL8126_98.column.descripcion.titleArgs}}',
                    width: $scope.vc.viewState.QV_FDMYL8126_98.column.descripcion.width,
                    format: $scope.vc.viewState.QV_FDMYL8126_98.column.descripcion.format,
                    editor: $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808SRII09.control,
                    template: "<span ng-class='vc.viewState.QV_FDMYL8126_98.column.descripcion.element[dataItem.uid].style'>#if (descripcion !== null) {# #=descripcion# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_FDMYL8126_98.column.descripcion.style",
                        "title": "{{vc.viewState.QV_FDMYL8126_98.column.descripcion.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_FDMYL8126_98.column.descripcion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_FDMYL8126_98.columns.push({
                    field: 'estado',
                    title: '{{vc.viewState.QV_FDMYL8126_98.column.estado.title|translate:vc.viewState.QV_FDMYL8126_98.column.estado.titleArgs}}',
                    width: $scope.vc.viewState.QV_FDMYL8126_98.column.estado.width,
                    format: $scope.vc.viewState.QV_FDMYL8126_98.column.estado.format,
                    editor: $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808STAO01.control,
                    template: "<span ng-class='vc.viewState.QV_FDMYL8126_98.column.estado.element[dataItem.uid].style'>#if (estado !== null) {# #=estado# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_FDMYL8126_98.column.estado.style",
                        "title": "{{vc.viewState.QV_FDMYL8126_98.column.estado.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_FDMYL8126_98.column.estado.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_FDMYL8126_98.columns.push({
                    field: 'montoDisponible',
                    title: '{{vc.viewState.QV_FDMYL8126_98.column.montoDisponible.title|translate:vc.viewState.QV_FDMYL8126_98.column.montoDisponible.titleArgs}}',
                    width: $scope.vc.viewState.QV_FDMYL8126_98.column.montoDisponible.width,
                    format: $scope.vc.viewState.QV_FDMYL8126_98.column.montoDisponible.format,
                    editor: $scope.vc.grids.QV_FDMYL8126_98.AT_IXE808NIBL34.control,
                    template: "<span ng-class='vc.viewState.QV_FDMYL8126_98.column.montoDisponible.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.montoDisponible, \"QV_FDMYL8126_98\", \"montoDisponible\"):kendo.toString(#=montoDisponible#, vc.viewState.QV_FDMYL8126_98.column.montoDisponible.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_FDMYL8126_98.column.montoDisponible.style",
                        "title": "{{vc.viewState.QV_FDMYL8126_98.column.montoDisponible.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_FDMYL8126_98.column.montoDisponible.hidden
                });
            }
            $scope.vc.viewState.QV_FDMYL8126_98.toolbar = {}
            $scope.vc.grids.QV_FDMYL8126_98.toolbar = [];
            //ViewState - Group: Group1340
            $scope.vc.createViewState({
                id: "G_FIXEDTEYTE_555W96",
                hasId: true,
                componentStyle: [],
                label: 'Group1340',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.AccountInfomation = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    accountBank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountInfomation", "accountBank", '')
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountInfomation", "description", '')
                    },
                    accountStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountInfomation", "accountStatus", '')
                    },
                    availableBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AccountInfomation", "availableBalance", 0)
                    }
                }
            });
            $scope.vc.model.AccountInfomation = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_ACCOUNIO_6427();
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
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.AccountInfomation
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6427_29743").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ACCOUNIO_6427 = $scope.vc.model.AccountInfomation;
            $scope.vc.trackers.AccountInfomation = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AccountInfomation);
            $scope.vc.model.AccountInfomation.bind('change', function(e) {
                $scope.vc.trackers.AccountInfomation.track(e);
            });
            $scope.vc.grids.QV_6427_29743 = {};
            $scope.vc.grids.QV_6427_29743.queryId = 'Q_ACCOUNIO_6427';
            $scope.vc.viewState.QV_6427_29743 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6427_29743.column = {};
            $scope.vc.grids.QV_6427_29743.editable = false;
            $scope.vc.grids.QV_6427_29743.events = {
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
                    $scope.vc.trackers.AccountInfomation.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6427_29743.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6427_29743");
                    $scope.vc.hideShowColumns("QV_6427_29743", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6427_29743.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6427_29743.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_6427_29743.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6427_29743 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6427_29743 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_6427_29743.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_6427_29743.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_6427_29743.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "AccountInfomation",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        $scope.vc.gridRowSelecting("QV_6427_29743", args);
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
            $scope.vc.grids.QV_6427_29743.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6427_29743.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6427_29743.column.accountBank = {
                title: 'BUSIN.LBL_BUSIN_NMERODECO_83546',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKGA_593W96',
                element: []
            };
            $scope.vc.grids.QV_6427_29743.AT91_ACCOUNAN293 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6427_29743.column.accountBank.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKGA_593W96",
                        'data-validation-code': "{{vc.viewState.QV_6427_29743.column.accountBank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,2",
                        'ng-class': "vc.viewState.QV_6427_29743.column.accountBank.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6427_29743.column.description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXABE_623W96',
                element: []
            };
            $scope.vc.grids.QV_6427_29743.AT78_DESCRINT293 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6427_29743.column.description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXABE_623W96",
                        'data-validation-code': "{{vc.viewState.QV_6427_29743.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,2",
                        'ng-class': "vc.viewState.QV_6427_29743.column.description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6427_29743.column.accountStatus = {
                title: 'BUSIN.DLB_BUSIN_ESTADORJE_43391',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLYG_876W96',
                element: []
            };
            $scope.vc.grids.QV_6427_29743.AT14_ACCOUNUS293 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6427_29743.column.accountStatus.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLYG_876W96",
                        'data-validation-code': "{{vc.viewState.QV_6427_29743.column.accountStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,2",
                        'ng-class': "vc.viewState.QV_6427_29743.column.accountStatus.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6427_29743.column.availableBalance = {
                title: 'availableBalance',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBNC_479W96',
                element: []
            };
            $scope.vc.grids.QV_6427_29743.AT89_AVAILABL293 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6427_29743.column.availableBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBNC_479W96",
                        'data-validation-code': "{{vc.viewState.QV_6427_29743.column.availableBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6427_29743.column.availableBalance.format",
                        'k-decimals': "vc.viewState.QV_6427_29743.column.availableBalance.decimals",
                        'data-cobis-group': "GroupLayout,GR_IEDMBENTEW96_14,2",
                        'ng-class': "vc.viewState.QV_6427_29743.column.availableBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6427_29743.columns.push({
                    field: 'accountBank',
                    title: '{{vc.viewState.QV_6427_29743.column.accountBank.title|translate:vc.viewState.QV_6427_29743.column.accountBank.titleArgs}}',
                    width: $scope.vc.viewState.QV_6427_29743.column.accountBank.width,
                    format: $scope.vc.viewState.QV_6427_29743.column.accountBank.format,
                    editor: $scope.vc.grids.QV_6427_29743.AT91_ACCOUNAN293.control,
                    template: "<span ng-class='vc.viewState.QV_6427_29743.column.accountBank.element[dataItem.uid].style'>#if (accountBank !== null) {# #=accountBank# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6427_29743.column.accountBank.style",
                        "title": "{{vc.viewState.QV_6427_29743.column.accountBank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6427_29743.column.accountBank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6427_29743.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_6427_29743.column.description.title|translate:vc.viewState.QV_6427_29743.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_6427_29743.column.description.width,
                    format: $scope.vc.viewState.QV_6427_29743.column.description.format,
                    editor: $scope.vc.grids.QV_6427_29743.AT78_DESCRINT293.control,
                    template: "<span ng-class='vc.viewState.QV_6427_29743.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6427_29743.column.description.style",
                        "title": "{{vc.viewState.QV_6427_29743.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6427_29743.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6427_29743.columns.push({
                    field: 'accountStatus',
                    title: '{{vc.viewState.QV_6427_29743.column.accountStatus.title|translate:vc.viewState.QV_6427_29743.column.accountStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_6427_29743.column.accountStatus.width,
                    format: $scope.vc.viewState.QV_6427_29743.column.accountStatus.format,
                    editor: $scope.vc.grids.QV_6427_29743.AT14_ACCOUNUS293.control,
                    template: "<span ng-class='vc.viewState.QV_6427_29743.column.accountStatus.element[dataItem.uid].style'>#if (accountStatus !== null) {# #=accountStatus# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6427_29743.column.accountStatus.style",
                        "title": "{{vc.viewState.QV_6427_29743.column.accountStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6427_29743.column.accountStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6427_29743.columns.push({
                    field: 'availableBalance',
                    title: '{{vc.viewState.QV_6427_29743.column.availableBalance.title|translate:vc.viewState.QV_6427_29743.column.availableBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_6427_29743.column.availableBalance.width,
                    format: $scope.vc.viewState.QV_6427_29743.column.availableBalance.format,
                    editor: $scope.vc.grids.QV_6427_29743.AT89_AVAILABL293.control,
                    template: "<span ng-class='vc.viewState.QV_6427_29743.column.availableBalance.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.availableBalance, \"QV_6427_29743\", \"availableBalance\"):kendo.toString(#=availableBalance#, vc.viewState.QV_6427_29743.column.availableBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6427_29743.column.availableBalance.style",
                        "title": "{{vc.viewState.QV_6427_29743.column.availableBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6427_29743.column.availableBalance.hidden
                });
            }
            $scope.vc.viewState.QV_6427_29743.toolbar = {}
            $scope.vc.grids.QV_6427_29743.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_94_BYLET28_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_94_BYLET28_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancelar
            $scope.vc.createViewState({
                id: "CM_BYLET28CAE88",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CANCELARI_56591",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Seleccionar
            $scope.vc.createViewState({
                id: "CM_BYLET28LEO66",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SELECIOAR_14656",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.WarrantyGeneral = {
                accountAho: $scope.vc.channelDefaultValues("WarrantyGeneral", "accountAho"),
                guarantortype: $scope.vc.channelDefaultValues("WarrantyGeneral", "guarantortype"),
                balanceAvailable: $scope.vc.channelDefaultValues("WarrantyGeneral", "balanceAvailable"),
                suitability: $scope.vc.channelDefaultValues("WarrantyGeneral", "suitability"),
                appraisalValue: $scope.vc.channelDefaultValues("WarrantyGeneral", "appraisalValue"),
                branchOffice: $scope.vc.channelDefaultValues("WarrantyGeneral", "branchOffice"),
                code: $scope.vc.channelDefaultValues("WarrantyGeneral", "code"),
                coverage: $scope.vc.channelDefaultValues("WarrantyGeneral", "coverage"),
                admissionDate: $scope.vc.channelDefaultValues("WarrantyGeneral", "admissionDate"),
                fixedTermAmount: $scope.vc.channelDefaultValues("WarrantyGeneral", "fixedTermAmount"),
                valueSource: $scope.vc.channelDefaultValues("WarrantyGeneral", "valueSource"),
                externalCode: $scope.vc.channelDefaultValues("WarrantyGeneral", "externalCode"),
                office: $scope.vc.channelDefaultValues("WarrantyGeneral", "office"),
                filial: $scope.vc.channelDefaultValues("WarrantyGeneral", "filial"),
                fixedTerm: $scope.vc.channelDefaultValues("WarrantyGeneral", "fixedTerm"),
                initialValue: $scope.vc.channelDefaultValues("WarrantyGeneral", "initialValue"),
                instruction: $scope.vc.channelDefaultValues("WarrantyGeneral", "instruction"),
                currency: $scope.vc.channelDefaultValues("WarrantyGeneral", "currency"),
                mandatoryDocument: $scope.vc.channelDefaultValues("WarrantyGeneral", "mandatoryDocument"),
                warrantyType: $scope.vc.channelDefaultValues("WarrantyGeneral", "warrantyType"),
                currentValue: $scope.vc.channelDefaultValues("WarrantyGeneral", "currentValue"),
                documentNumber: $scope.vc.channelDefaultValues("WarrantyGeneral", "documentNumber"),
                constitutionDate: $scope.vc.channelDefaultValues("WarrantyGeneral", "constitutionDate"),
                percentageCoverage: $scope.vc.channelDefaultValues("WarrantyGeneral", "percentageCoverage"),
                guarantor: $scope.vc.channelDefaultValues("WarrantyGeneral", "guarantor"),
                description: $scope.vc.channelDefaultValues("WarrantyGeneral", "description"),
                status: $scope.vc.channelDefaultValues("WarrantyGeneral", "status"),
                tramitNumber: $scope.vc.channelDefaultValues("WarrantyGeneral", "tramitNumber"),
                appraisalDate: $scope.vc.channelDefaultValues("WarrantyGeneral", "appraisalDate"),
                owner: $scope.vc.channelDefaultValues("WarrantyGeneral", "owner")
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
                $scope.vc.render('VC_BYLET28_DTBCT_453');
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
    var cobisMainModule = cobis.createModule("VC_BYLET28_DTBCT_453", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_BYLET28_DTBCT_453", {
            templateUrl: "VC_BYLET28_DTBCT_453_FORM.html",
            controller: "VC_BYLET28_DTBCT_453_CTRL",
            label: "fixedTermCustVC",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_BYLET28_DTBCT_453?" + $.param(search);
            }
        });
        VC_BYLET28_DTBCT_453(cobisMainModule);
    }]);
} else {
    VC_BYLET28_DTBCT_453(cobisMainModule);
}