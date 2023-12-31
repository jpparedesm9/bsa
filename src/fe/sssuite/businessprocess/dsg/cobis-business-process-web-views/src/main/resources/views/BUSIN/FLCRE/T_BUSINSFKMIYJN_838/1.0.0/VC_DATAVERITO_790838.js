//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.dataverificationquestionscompound = designerEvents.api.dataverificationquestionscompound || designer.dsgEvents();

function VC_DATAVERITO_790838(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DATAVERITO_790838_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DATAVERITO_790838_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_BUSINSFKMIYJN_838",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DATAVERITO_790838",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_BUSINSFKMIYJN_838",
        designerEvents.api.dataverificationquestionscompound,
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
                vcName: 'VC_DATAVERITO_790838'
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
                    taskId: 'T_BUSINSFKMIYJN_838',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    MemberQuestion: "MemberQuestion",
                    Context: "Context",
                    OriginalHeader: "OriginalHeader",
                    GeneralData: "GeneralData"
                },
                entities: {
                    MemberQuestion: {
                        nameMember: 'AT12_NAMEMEER636',
                        codeMember: 'AT62_CODEMEEM636',
                        answer: 'AT65_ANSWERJA636',
                        _pks: [],
                        _entityId: 'EN_MEMBERQSO_636',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        amountApproved: 'AT10_AMOUNTPP762',
                        amountRequested: 'AT37_AMOUNTUE762',
                        cycleNumber: 'AT60_CYCLENEM762',
                        synchronize: 'AT88_SYNCHRZZ762',
                        enable: 'AT91_ENABLEZV762',
                        ApplicationSubject: 'AT_CON762ACAO34',
                        Application: 'AT_CON762APCI65',
                        Bookmark: 'AT_CON762BKAK11',
                        CustomerId: 'AT_CON762CSTE68',
                        RequestId: 'AT_CON762EUTD32',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        TaskSubject: 'AT_CON762TSUT41',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OriginalHeader: {
                        maximumAmount: 'AT13_MAXIMUOM477',
                        amountRequestedOriginal: 'AT20_AMOUNTGE477',
                        frequency: 'AT28_FREQUENC477',
                        bCBlackListsClient: 'AT74_BCBLACLS477',
                        amountDisbursed: 'AT94_AMOUNTSS477',
                        termInd: 'AT94_TERMINDD477',
                        stageflux: 'AT_RIG477AGFX85',
                        RejectionExcuse: 'AT_RIG477AONC36',
                        ReasonRefinancing: 'AT_RIG477AONN01',
                        AmountApproved: 'AT_RIG477AUPR26',
                        CityCredit: 'AT_RIG477CIDI98',
                        Country: 'AT_RIG477COTR74',
                        CreditTarget: 'AT_RIG477CRET05',
                        IsWarrantyDestination: 'AT_RIG477DSIN93',
                        CreditSector: 'AT_RIG477EDCT30',
                        RejectionReason: 'AT_RIG477EIEA32',
                        CreditLineValid: 'AT_RIG477EVAL88',
                        Office: 'AT_RIG477FICE32',
                        OfficerName: 'AT_RIG477FNME01',
                        HousingCount: 'AT_RIG477GCUN35',
                        InitialDate: 'AT_RIG477IALT55',
                        IsDebtorOwner: 'AT_RIG477IBTO19',
                        ActivityNumber: 'AT_RIG477IIMB92',
                        ApplicationNumber: 'AT_RIG477IOUR00',
                        CityCode: 'AT_RIG477ITCE46',
                        ClientSector: 'AT_RIG477LIEN42',
                        AmountAprobed: 'AT_RIG477MICI25',
                        AmountCalculated: 'AT_RIG477MNLA18',
                        NumberLine: 'AT_RIG477NMLN54',
                        PaymentFrequency: 'AT_RIG477NQUE49',
                        OpNumberBank: 'AT_RIG477NRAK86',
                        OfficerId: 'AT_RIG477OERD27',
                        Province: 'AT_RIG477OINC84',
                        AmountRequestedML: 'AT_RIG477ONTD67',
                        AmountRequested: 'AT_RIG477OQUE10',
                        ProductType: 'AT_RIG477PEOE42',
                        PortfolioType: 'AT_RIG477POLY58',
                        Quota: 'AT_RIG477QUOA32',
                        Agreement: 'AT_RIG477REEM93',
                        CodeAgreement: 'AT_RIG477REET12',
                        IDRequested: 'AT_RIG477RQSD66',
                        ProductFIE: 'AT_RIG477RUCE24',
                        StatusRequested: 'AT_RIG477SAUT78',
                        Score: 'AT_RIG477SCOR35',
                        ScoreType: 'AT_RIG477SOET77',
                        TermLimit: 'AT_RIG477TEIM91',
                        Term: 'AT_RIG477TERM59',
                        ActivityDestination: 'AT_RIG477TETI07',
                        Type: 'AT_RIG477TYPE69',
                        CurrencyRequested: 'AT_RIG477URQT91',
                        UserL: 'AT_RIG477USRL75',
                        RequestLine: 'AT_RIG477UTIN05',
                        Expromission: 'AT_RIG477XSIN84',
                        TypeRequest: 'AT_RIG477YPRU27',
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    GeneralData: {
                        loanType: 'AT14_LOANTYPP921',
                        sectorNeg: 'AT59_SECTORNN921',
                        paymentFrecuencyName: 'AT61_PAYMENNR921',
                        vinculado: 'AT71_VINCULAA921',
                        symbolCurrency: 'AT74_SYMBOLCN921',
                        productTypeName: 'AT79_PRODUCYN921',
                        mnemonicCurrency: 'AT95_MNEMONYR921',
                        Amount: 'AT_GEN921AMON22',
                        DateValueHome: 'AT_GEN921DAUE83',
                        OperationType: 'AT_GEN921PANE17',
                        Rate: 'AT_GEN921RATE77',
                        ValueEndDate: 'AT_GEN921UEDE21',
                        Currency: 'AT_GEN921UREC40',
                        ExpirationFirstQuota: 'AT_GEN921XNSA49',
                        _pks: [],
                        _entityId: 'EN_GENERADAT921',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_MEMBEREN_7029 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_MEMBEREN_7029 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MEMBEREN_7029_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MEMBEREN_7029_filters;
                    parametersAux = {
                        codeMember: filters.codeMember
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MEMBERQSO_636',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MEMBEREN_7029',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['codeMember'] = this.filters.codeMember;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_MEMBEREN_7029_filters = {};
            var defaultValues = {
                MemberQuestion: {},
                Context: {},
                OriginalHeader: {},
                GeneralData: {}
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
                $scope.vc.execute("temporarySave", VC_DATAVERITO_790838, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DATAVERITO_790838, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DATAVERITO_790838, data, function() {});
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
            $scope.vc.viewState.VC_DATAVERITO_790838 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_DATAVERITO_790838",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_OJENZSZTLL_173838",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: HeaderForm
            $scope.vc.createViewState({
                id: "VC_KTQPLKPQZB_156939",
                hasId: true,
                componentStyle: [],
                label: 'HeaderForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1594
            $scope.vc.createViewState({
                id: "G_HEADERZBOW_963263",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1594',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_HEADERZBOW_963263-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_XBUVOPTLIE_155838",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: QuestionMemberTask
            $scope.vc.createViewState({
                id: "VC_GVTYBPZGUQ_204860",
                hasId: true,
                componentStyle: [],
                label: 'QuestionMemberTask',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1670
            $scope.vc.createViewState({
                id: "G_QUESTIOBKM_883304",
                hasId: true,
                componentStyle: [],
                label: 'Group1670',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.MemberQuestion = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    codeMember: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberQuestion", "codeMember", 0)
                    },
                    nameMember: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberQuestion", "nameMember", '')
                    },
                    answer: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberQuestion", "answer", 0)
                    }
                }
            });
            $scope.vc.model.MemberQuestion = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_MEMBEREN_7029';
                            var queryRequest = $scope.vc.getRequestQuery_Q_MEMBEREN_7029();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7029_28177',
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
                    model: $scope.vc.types.MemberQuestion
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7029_28177").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MEMBEREN_7029 = $scope.vc.model.MemberQuestion;
            $scope.vc.trackers.MemberQuestion = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.MemberQuestion);
            $scope.vc.model.MemberQuestion.bind('change', function(e) {
                $scope.vc.trackers.MemberQuestion.track(e);
                $scope.vc.grids.QV_7029_28177.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_7029_28177 = {};
            $scope.vc.grids.QV_7029_28177.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_7029_28177) && expandedRowUidActual !== expandedRowUid_QV_7029_28177) {
                    var gridWidget = $('#QV_7029_28177').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_7029_28177 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_7029_28177 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_7029_28177 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_7029_28177);
                }
                expandedRowUid_QV_7029_28177 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_7029_28177', args);
                if (angular.isDefined($scope.vc.grids.QV_7029_28177.view)) {
                    $scope.vc.grids.QV_7029_28177.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_7029_28177.customView)) {
                    $scope.vc.grids.QV_7029_28177.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_7029_28177'/>"
            };
            $scope.vc.grids.QV_7029_28177.queryId = 'Q_MEMBEREN_7029';
            $scope.vc.viewState.QV_7029_28177 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7029_28177.column = {};
            var expandedRowUid_QV_7029_28177;
            $scope.vc.grids.QV_7029_28177.editable = false;
            $scope.vc.grids.QV_7029_28177.events = {
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
                    $scope.vc.trackers.MemberQuestion.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7029_28177.selectedRow = e.model;
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
                    $scope.vc.grids.QV_7029_28177.events.moveRowDetailIcon(e);
                    $scope.vc.grids.QV_7029_28177.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    $scope.vc.validateForm();
                },
                moveRowDetailIcon: function(e) {
                    var index;
                    var grid = e.sender;
                    grid.tbody.on('mousedown', 'a,button,input[type="button"],td.k-hierarchy-cell', function(evnt) {
                        evnt.stopImmediatePropagation();
                        evnt.stopPropagation();
                    });
                    var numColumns = grid.columns.length + 1; //se suma uno por el detalle de grid
                    var numColumnsVisible = $("#QV_7029_28177 > .k-grid-header colgroup col").length;
                    var diff = numColumns - numColumnsVisible;
                    index = grid.element.find("th.k-header[data-role='droptarget']").index();
                    if (index != -1) {
                        $("#QV_7029_28177 th.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("th", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_7029_28177 td.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("td", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_7029_28177 .k-hierarchy-col").each(function() {
                            $(this).insertAfter($("col", this.parentNode).eq(grid.columns.length - diff));
                        });
                    } else {
                        index = grid.tbody.find('tr:first>td:last').index();
                        if (index === -1) {
                            index = grid.element.find('tr>th:last').index();
                        }
                        if (index > 0) {
                            $("#QV_7029_28177 .k-hierarchy-cell").each(function() {
                                var element = $(this).siblings().eq(index - 1);
                                if (angular.isDefined(element) && angular.isDefined(element[0])) {
                                    $(this).insertAfter(element);
                                }
                            });
                            $("#QV_7029_28177 .k-hierarchy-col").each(function() {
                                var element = $(this).siblings().eq(index - 1 - diff);
                                if (angular.isDefined(element) && angular.isDefined(element[0])) {
                                    $(this).insertAfter(element);
                                }
                            });
                        }
                    }
                },
                evalVisibilityOfGridRowDetailIcon: function(dataSource) {
                    var dataView = dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        var args = {
                            nameEntityGrid: "MemberQuestion",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_7029_28177", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_7029_28177", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.grids.QV_7029_28177.events.moveRowDetailIcon(e);
                    $scope.vc.gridDataBound("QV_7029_28177");
                    $scope.vc.hideShowColumns("QV_7029_28177", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7029_28177.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7029_28177.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7029_28177.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7029_28177 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7029_28177 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_7029_28177.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_7029_28177 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                },
                detailExpand: function(e) {
                    $(e.detailRow.find(".k-hierarchy-cell")).insertAfter($("td:last", e.detailRow));
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7029_28177.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7029_28177.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7029_28177.column.codeMember = {
                title: 'BUSIN.LBL_BUSIN_CDIGOQFXJ_21155',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDIP_639304',
                element: []
            };
            $scope.vc.grids.QV_7029_28177.AT62_CODEMEEM636 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7029_28177.column.codeMember.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDIP_639304",
                        'data-validation-code': "{{vc.viewState.QV_7029_28177.column.codeMember.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7029_28177.column.codeMember.format",
                        'k-decimals': "vc.viewState.QV_7029_28177.column.codeMember.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7029_28177.column.codeMember.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7029_28177.column.nameMember = {
                title: 'BUSIN.LBL_BUSIN_CLIENTEPK_21523',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNIJ_504304',
                element: []
            };
            $scope.vc.grids.QV_7029_28177.AT12_NAMEMEER636 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7029_28177.column.nameMember.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNIJ_504304",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_7029_28177.column.nameMember.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7029_28177.column.nameMember.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7029_28177.column.answer = {
                title: 'BUSIN.DLB_BUSIN_RESULTADO_06672',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZGU_106304',
                element: []
            };
            $scope.vc.grids.QV_7029_28177.AT65_ANSWERJA636 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7029_28177.column.answer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZGU_106304",
                        'data-validation-code': "{{vc.viewState.QV_7029_28177.column.answer.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7029_28177.column.answer.format",
                        'k-decimals': "vc.viewState.QV_7029_28177.column.answer.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7029_28177.column.answer.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7029_28177.columns.push({
                    field: 'codeMember',
                    title: '{{vc.viewState.QV_7029_28177.column.codeMember.title|translate:vc.viewState.QV_7029_28177.column.codeMember.titleArgs}}',
                    width: $scope.vc.viewState.QV_7029_28177.column.codeMember.width,
                    format: $scope.vc.viewState.QV_7029_28177.column.codeMember.format,
                    editor: $scope.vc.grids.QV_7029_28177.AT62_CODEMEEM636.control,
                    template: "<span ng-class='vc.viewState.QV_7029_28177.column.codeMember.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.codeMember, \"QV_7029_28177\", \"codeMember\"):kendo.toString(#=codeMember#, vc.viewState.QV_7029_28177.column.codeMember.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7029_28177.column.codeMember.style",
                        "title": "{{vc.viewState.QV_7029_28177.column.codeMember.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7029_28177.column.codeMember.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7029_28177.columns.push({
                    field: 'nameMember',
                    title: '{{vc.viewState.QV_7029_28177.column.nameMember.title|translate:vc.viewState.QV_7029_28177.column.nameMember.titleArgs}}',
                    width: $scope.vc.viewState.QV_7029_28177.column.nameMember.width,
                    format: $scope.vc.viewState.QV_7029_28177.column.nameMember.format,
                    editor: $scope.vc.grids.QV_7029_28177.AT12_NAMEMEER636.control,
                    template: "<span ng-class='vc.viewState.QV_7029_28177.column.nameMember.style' ng-bind='vc.getStringColumnFormat(dataItem.nameMember, \"QV_7029_28177\", \"nameMember\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7029_28177.column.nameMember.style",
                        "title": "{{vc.viewState.QV_7029_28177.column.nameMember.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7029_28177.column.nameMember.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7029_28177.columns.push({
                    field: 'answer',
                    title: '{{vc.viewState.QV_7029_28177.column.answer.title|translate:vc.viewState.QV_7029_28177.column.answer.titleArgs}}',
                    width: $scope.vc.viewState.QV_7029_28177.column.answer.width,
                    format: $scope.vc.viewState.QV_7029_28177.column.answer.format,
                    editor: $scope.vc.grids.QV_7029_28177.AT65_ANSWERJA636.control,
                    template: "<span ng-class='vc.viewState.QV_7029_28177.column.answer.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.answer, \"QV_7029_28177\", \"answer\"):kendo.toString(#=answer#, vc.viewState.QV_7029_28177.column.answer.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7029_28177.column.answer.style",
                        "title": "{{vc.viewState.QV_7029_28177.column.answer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7029_28177.column.answer.hidden
                });
            }
            $scope.vc.viewState.QV_7029_28177.toolbar = {}
            $scope.vc.grids.QV_7029_28177.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BUSINSFKMIYJN_838_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BUSINSFKMIYJN_838_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TBUSINSF_3N8",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TBUSINSF_SSU",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SINCRONIZ_41027",
                enabled: designer.constants.mode.None
            });
            $scope.vc.model.Context = {
                amountApproved: $scope.vc.channelDefaultValues("Context", "amountApproved"),
                amountRequested: $scope.vc.channelDefaultValues("Context", "amountRequested"),
                cycleNumber: $scope.vc.channelDefaultValues("Context", "cycleNumber"),
                synchronize: $scope.vc.channelDefaultValues("Context", "synchronize"),
                enable: $scope.vc.channelDefaultValues("Context", "enable"),
                ApplicationSubject: $scope.vc.channelDefaultValues("Context", "ApplicationSubject"),
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject")
            };
            $scope.vc.model.OriginalHeader = {
                maximumAmount: $scope.vc.channelDefaultValues("OriginalHeader", "maximumAmount"),
                amountRequestedOriginal: $scope.vc.channelDefaultValues("OriginalHeader", "amountRequestedOriginal"),
                frequency: $scope.vc.channelDefaultValues("OriginalHeader", "frequency"),
                bCBlackListsClient: $scope.vc.channelDefaultValues("OriginalHeader", "bCBlackListsClient"),
                amountDisbursed: $scope.vc.channelDefaultValues("OriginalHeader", "amountDisbursed"),
                termInd: $scope.vc.channelDefaultValues("OriginalHeader", "termInd"),
                stageflux: $scope.vc.channelDefaultValues("OriginalHeader", "stageflux"),
                RejectionExcuse: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionExcuse"),
                ReasonRefinancing: $scope.vc.channelDefaultValues("OriginalHeader", "ReasonRefinancing"),
                AmountApproved: $scope.vc.channelDefaultValues("OriginalHeader", "AmountApproved"),
                CityCredit: $scope.vc.channelDefaultValues("OriginalHeader", "CityCredit"),
                Country: $scope.vc.channelDefaultValues("OriginalHeader", "Country"),
                CreditTarget: $scope.vc.channelDefaultValues("OriginalHeader", "CreditTarget"),
                IsWarrantyDestination: $scope.vc.channelDefaultValues("OriginalHeader", "IsWarrantyDestination"),
                CreditSector: $scope.vc.channelDefaultValues("OriginalHeader", "CreditSector"),
                RejectionReason: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionReason"),
                CreditLineValid: $scope.vc.channelDefaultValues("OriginalHeader", "CreditLineValid"),
                Office: $scope.vc.channelDefaultValues("OriginalHeader", "Office"),
                OfficerName: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerName"),
                HousingCount: $scope.vc.channelDefaultValues("OriginalHeader", "HousingCount"),
                InitialDate: $scope.vc.channelDefaultValues("OriginalHeader", "InitialDate"),
                IsDebtorOwner: $scope.vc.channelDefaultValues("OriginalHeader", "IsDebtorOwner"),
                ActivityNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityNumber"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ApplicationNumber"),
                CityCode: $scope.vc.channelDefaultValues("OriginalHeader", "CityCode"),
                ClientSector: $scope.vc.channelDefaultValues("OriginalHeader", "ClientSector"),
                AmountAprobed: $scope.vc.channelDefaultValues("OriginalHeader", "AmountAprobed"),
                AmountCalculated: $scope.vc.channelDefaultValues("OriginalHeader", "AmountCalculated"),
                NumberLine: $scope.vc.channelDefaultValues("OriginalHeader", "NumberLine"),
                PaymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "PaymentFrequency"),
                OpNumberBank: $scope.vc.channelDefaultValues("OriginalHeader", "OpNumberBank"),
                OfficerId: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerId"),
                Province: $scope.vc.channelDefaultValues("OriginalHeader", "Province"),
                AmountRequestedML: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequestedML"),
                AmountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequested"),
                ProductType: $scope.vc.channelDefaultValues("OriginalHeader", "ProductType"),
                PortfolioType: $scope.vc.channelDefaultValues("OriginalHeader", "PortfolioType"),
                Quota: $scope.vc.channelDefaultValues("OriginalHeader", "Quota"),
                Agreement: $scope.vc.channelDefaultValues("OriginalHeader", "Agreement"),
                CodeAgreement: $scope.vc.channelDefaultValues("OriginalHeader", "CodeAgreement"),
                IDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "IDRequested"),
                ProductFIE: $scope.vc.channelDefaultValues("OriginalHeader", "ProductFIE"),
                StatusRequested: $scope.vc.channelDefaultValues("OriginalHeader", "StatusRequested"),
                Score: $scope.vc.channelDefaultValues("OriginalHeader", "Score"),
                ScoreType: $scope.vc.channelDefaultValues("OriginalHeader", "ScoreType"),
                TermLimit: $scope.vc.channelDefaultValues("OriginalHeader", "TermLimit"),
                Term: $scope.vc.channelDefaultValues("OriginalHeader", "Term"),
                ActivityDestination: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityDestination"),
                Type: $scope.vc.channelDefaultValues("OriginalHeader", "Type"),
                CurrencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "CurrencyRequested"),
                UserL: $scope.vc.channelDefaultValues("OriginalHeader", "UserL"),
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine"),
                Expromission: $scope.vc.channelDefaultValues("OriginalHeader", "Expromission"),
                TypeRequest: $scope.vc.channelDefaultValues("OriginalHeader", "TypeRequest")
            };
            $scope.vc.model.GeneralData = {
                loanType: $scope.vc.channelDefaultValues("GeneralData", "loanType"),
                sectorNeg: $scope.vc.channelDefaultValues("GeneralData", "sectorNeg"),
                paymentFrecuencyName: $scope.vc.channelDefaultValues("GeneralData", "paymentFrecuencyName"),
                vinculado: $scope.vc.channelDefaultValues("GeneralData", "vinculado"),
                symbolCurrency: $scope.vc.channelDefaultValues("GeneralData", "symbolCurrency"),
                productTypeName: $scope.vc.channelDefaultValues("GeneralData", "productTypeName"),
                mnemonicCurrency: $scope.vc.channelDefaultValues("GeneralData", "mnemonicCurrency"),
                Amount: $scope.vc.channelDefaultValues("GeneralData", "Amount"),
                DateValueHome: $scope.vc.channelDefaultValues("GeneralData", "DateValueHome"),
                OperationType: $scope.vc.channelDefaultValues("GeneralData", "OperationType"),
                Rate: $scope.vc.channelDefaultValues("GeneralData", "Rate"),
                ValueEndDate: $scope.vc.channelDefaultValues("GeneralData", "ValueEndDate"),
                Currency: $scope.vc.channelDefaultValues("GeneralData", "Currency"),
                ExpirationFirstQuota: $scope.vc.channelDefaultValues("GeneralData", "ExpirationFirstQuota")
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
                $scope.vc.render('VC_DATAVERITO_790838');
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
    var cobisMainModule = cobis.createModule("VC_DATAVERITO_790838", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_DATAVERITO_790838", {
            templateUrl: "VC_DATAVERITO_790838_FORM.html",
            controller: "VC_DATAVERITO_790838_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DATAVERITO_790838?" + $.param(search);
            }
        });
        VC_DATAVERITO_790838(cobisMainModule);
    }]);
} else {
    VC_DATAVERITO_790838(cobisMainModule);
}