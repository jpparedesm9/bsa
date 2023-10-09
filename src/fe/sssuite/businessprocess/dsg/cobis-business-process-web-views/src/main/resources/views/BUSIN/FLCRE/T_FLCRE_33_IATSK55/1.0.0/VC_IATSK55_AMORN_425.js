<!-- Development by Designer Generator v 1.7.0 - release ART 7.2 05/09/2014 -->
<!---->

var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.amortizationtask = designerEvents.api.amortizationtask || {
    initData: {},
    initDataCallback: {},
    changeInitData: {},
    executeCommand: {},
    executeCommandCallback: {},
    executeCrudCallback: {},
    validateTransaction: {},
    callTransaction: {},
    showResult: {},
    closeModalEvent: {},
    change: {},
    changeCallback: {},
    loadCatalog: {},
    executeQuery: {},
    textInputButtonEvent: {},
    textInputButtonCloseModalEvent: {},
    gridRowInserting: {},
    gridRowUpdating: {},
    gridRowDeleting: {},
    gridRowSelecting: {},
    gridRowCommand: {},
    gridRowCommandCallback: {},
    gridCommand: {},
    gridBeforeEnterInLineRow: {},
    gridAfterLeaveInLineRow: {},
    beforeOpenGridDialog: {},
    afterCloseGridDialog: {},
    textInputButtonEventGrid: {},
    textInputButtonCloseModalEventGrid: {}
};

function VC_IATSK55_AMORN_425(cobisMainModule) {


    cobisMainModule.controllerProvider.register("VC_IATSK55_AMORN_425_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);

    cobisMainModule.controllerProvider.register("VC_IATSK55_AMORN_425_CTRL", ["$scope", "$location", "$document", "$parse", "designer", "cobisMessage", "$filter", "$modal", cobis.modules.CONTAINER + ".preferencesService", "$q",

    function($scope, $location, $document, $parse, designer, cobisMessage, $filter, $modal, preferencesService, $q) {

        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT)) {
            $scope.dateFormat = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT);
        } else {
            $scope.dateFormat = 'yyyy/MM/dd';
        }

        $scope.designer = designer;

        $scope.validatorOptions = validatorOptions;

        $scope.vc = designer.initViewContainer({
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_33_IATSK55",
            taskVersion: "1.0.0",
            viewContainerId: "VC_IATSK55_AMORN_425"
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_33_IATSK55",
        designerEvents.api.amortizationtask);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;

        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
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
                vcName: 'VC_IATSK55_AMORN_425'
            }
            $scope.vc.pk = $location.search().pk;
            $scope.vc.mode = parseInt($location.search().mode || designer.constants.mode.Insert);
            $scope.vc.args.pk = $location.search().pk;
            $scope.vc.args.mode = $scope.vc.mode;
            if (cobis.userContext.getValue(cobis.constant.USER_NAME)) {
                $scope.vc.args.user = cobis.userContext.getValue(cobis.constant.USER_NAME);
            } else {
                $scope.vc.args.user = "UserOutContainer";
            }
            $scope.vc.args.channel = $location.search().channel;



            $scope.vc.metadata = {
                taskPk: {
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_33_IATSK55',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    AmortizationTableEntity: "AmortizationTableEntity",
                    DatosTablaAmortizacion: "DatosTablaAmortizacion",
                    DatosGeneralesOperacion: "DatosGeneralesOperacion"
                },
                entities: {
                    AmortizationTableEntity: {
                        QuotaNumber: 'AT_MOR556QTAB08',
                        ExpirationDate: 'AT_MOR556ETIN60',
                        CapitalBalance: 'AT_MOR556ITBC69',
                        Capital: 'AT_MOR556TRST77',
                        Interest: 'AT_MOR556RERI41',
                        Entry1: 'AT_MOR556ERY138',
                        Entry2: 'AT_MOR556TRY251',
                        Entry3: 'AT_MOR556ETRY48',
                        Entry4: 'AT_MOR556ENR456',
                        Entry5: 'AT_MOR556ERY505',
                        Entry6: 'AT_MOR556TRY607',
                        Entry7: 'AT_MOR556ENT661',
                        Entry8: 'AT_MOR556ETRY75',
                        Entry9: 'AT_MOR556ETRY65',
                        Entry10: 'AT_MOR556ETR614',
                        Quota: 'AT_MOR556QUOT48',
                        _pks: ['QuotaNumber'],
                        _entityId: 'EN_MORAITALY556',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DatosTablaAmortizacion: {
                        Amount: 'AT_DAT619AONT11',
                        InterestRate: 'AT_DAT619RATE37',
                        Tea: 'AT_DAT619TEAK10',
                        StartDate: 'AT_DAT619SRTA77',
                        FinishDate: 'AT_DAT619NHDA13',
                        AmortizationType: 'AT_DAT619AINE41',
                        CapitalInstallment: 'AT_DAT619PTAS28',
                        CalculationBase: 'AT_DAT619CATI38',
                        TermType: 'AT_DAT619TERE00',
                        Term: 'AT_DAT619TERM03',
                        InstallmentType: 'AT_DAT619ISLE94',
                        CapitalPeriod: 'AT_DAT619ATAE45',
                        InterestPeriod: 'AT_DAT619NTES65',
                        CapitalGracePeriod: 'AT_DAT619IGAD04',
                        InterestGracePeriod: 'AT_DAT619NTSP49',
                        LowerInstallmentInterest: 'AT_DAT619LOIT44',
                        ApplyFor: 'AT_DAT619YFOR64',
                        AvoidHolidays: 'AT_DAT619HDAY35',
                        FixedPaymentDate: 'AT_DAT619IXET22',
                        MonthNonPayment: 'AT_DAT619OPYN23',
                        DaysGraceArrears: 'AT_DAT619YGMR41',
                        Day: 'AT_DAT619DAYG88',
                        _pks: [],
                        _entityId: 'EN_DATOBMRTA619',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DatosGeneralesOperacion: {
                        OperationType: 'AT_DTT506ANYP68',
                        Executive: 'AT_DTT506OFCL04',
                        OfficeCod: 'AT_DTT506OFIC26',
                        Operation: 'AT_DTT506ACON09',
                        Currency: 'AT_DTT506MONY35',
                        ExchangeRate: 'AT_DTT506QUOT83',
                        FinishDate: 'AT_DTT506EXDE44',
                        AmountApproved: 'AT_DTT506UNTP86',
                        Amount: 'AT_DTT506AMUN88',
                        Status: 'AT_DTT506STEN03',
                        ClientCod: 'AT_DTT506ENTD15',
                        ClientName: 'AT_DTT506LINE95',
                        ApplicationNumber: 'AT_DTT506ITNR31',
                        DisbursementAmount: 'AT_DTT506ETMT15',
                        DisbursementDate: 'AT_DTT506BMEE18',
                        InstallmentDueDate: 'AT_DTT506NSLD59',
                        NextPaymentDate: 'AT_DTT506PATT18',
                        BalanceDue: 'AT_DTT506AACU83',
                        CreditLine: 'AT_DTT506EILE36',
                        _pks: ['Operation'],
                        _entityId: 'EN_DTTBLOIZA506',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };

            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};

            $scope.vc.queryProperties.Q_OTAOABLR_0659 = {
                autoCrud: true
            };

            $scope.vc.queries.Q_OTAOABLR_0659 = new kendo.data.DataSource();

            $scope.vc.request.qr.Q_OTAOABLR_0659 = {
                mainEntityPk: {
                    entityId: 'EN_MORAITALY556',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_OTAOABLR_0659',
                    version: '1.0.0'
                },
                parameters: {},
                updateParameters: function() {
                    this.parameters = {};
                }
            };

            defaultValues = {
                AmortizationTableEntity: {},
                DatosTablaAmortizacion: {},
                DatosGeneralesOperacion: {}
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
                $scope.vc.CRUDExecuteQueryId(queryRequest, loadInModel);
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

            //ViewState - Container: Operation Data
            $scope.vc.viewState.VC_IATSK55_OPTND_119 = {
                style: {
                    success: false,
                    fail: false,
                    none: true
                },
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: true
            };
            //ViewState - Group: OperationData
            $scope.vc.viewState.GR_SALMORTZAN47_02 = {
                style: {
                    success: false,
                    fail: false,
                    none: true
                },
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };
            $scope.vc.model.DatosGeneralesOperacion = {
                OperationType: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "OperationType"),
                Executive: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Executive"),
                OfficeCod: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "OfficeCod"),
                Operation: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Operation"),
                Currency: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Currency"),
                ExchangeRate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ExchangeRate"),
                FinishDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "FinishDate"),
                AmountApproved: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "AmountApproved"),
                Amount: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Amount"),
                Status: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "Status"),
                ClientCod: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ClientCod"),
                ClientName: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ClientName"),
                ApplicationNumber: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "ApplicationNumber"),
                DisbursementAmount: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "DisbursementAmount"),
                DisbursementDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "DisbursementDate"),
                InstallmentDueDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "InstallmentDueDate"),
                NextPaymentDate: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "NextPaymentDate"),
                BalanceDue: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "BalanceDue"),
                CreditLine: $scope.vc.channelDefaultValues("DatosGeneralesOperacion", "CreditLine")
            };




            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Operation
            $scope.vc.viewState.VA_SALMORTZAN4702_ACON145 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: OperationType
            $scope.vc.viewState.VA_SALMORTZAN4702_ANYP378 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_SALMORTZAN4702_ANYP378 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SALMORTZAN4702_ANYP378', 'ca_toperacion', function(response) {
                            if (response.data['RESULTVA_SALMORTZAN4702_ANYP378'] != null) {
                                options.success(response.data['RESULTVA_SALMORTZAN4702_ANYP378']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Executive
            $scope.vc.viewState.VA_SALMORTZAN4702_OFCL184 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: OfficeCod
            $scope.vc.viewState.VA_SALMORTZAN4702_OFIC376 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_SALMORTZAN4702_OFIC376 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SALMORTZAN4702_OFIC376', 'cl_oficina', function(response) {
                            if (response.data['RESULTVA_SALMORTZAN4702_OFIC376'] != null) {
                                options.success(response.data['RESULTVA_SALMORTZAN4702_OFIC376']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Currency
            $scope.vc.viewState.VA_SALMORTZAN4702_MONY891 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_SALMORTZAN4702_MONY891 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SALMORTZAN4702_MONY891', 'cl_moneda', function(response) {
                            if (response.data['RESULTVA_SALMORTZAN4702_MONY891'] != null) {
                                options.success(response.data['RESULTVA_SALMORTZAN4702_MONY891']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Entity: DatosGeneralesOperacion, Attribute: ExchangeRate
            $scope.vc.viewState.VA_SALMORTZAN4702_QUOT209 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: FinishDate
            $scope.vc.viewState.VA_SALMORTZAN4702_EXDE132 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: AmountApproved
            $scope.vc.viewState.VA_SALMORTZAN4702_UNTP022 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Amount
            $scope.vc.viewState.VA_SALMORTZAN4702_AMUN972 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: Status
            $scope.vc.viewState.VA_SALMORTZAN4702_STEN510 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: ClientCod
            $scope.vc.viewState.VA_SALMORTZAN4702_ENTD109 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosGeneralesOperacion, Attribute: ClientName
            $scope.vc.viewState.VA_SALMORTZAN4702_LINE716 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Container: Amortization Data
            $scope.vc.viewState.VC_IATSK55_TZOND_757 = {
                style: {
                    success: false,
                    fail: false,
                    none: true
                },
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: true
            };
            //ViewState - Group: TablaAmortizacion
            $scope.vc.viewState.GR_VIDAOMOZCN64_02 = {
                style: {
                    success: false,
                    fail: false,
                    none: true
                },
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };
            $scope.vc.model.DatosTablaAmortizacion = {
                Amount: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "Amount"),
                InterestRate: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "InterestRate"),
                Tea: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "Tea"),
                StartDate: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "StartDate"),
                FinishDate: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "FinishDate"),
                AmortizationType: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "AmortizationType"),
                CapitalInstallment: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "CapitalInstallment"),
                CalculationBase: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "CalculationBase"),
                TermType: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "TermType"),
                Term: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "Term"),
                InstallmentType: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "InstallmentType"),
                CapitalPeriod: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "CapitalPeriod"),
                InterestPeriod: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "InterestPeriod"),
                CapitalGracePeriod: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "CapitalGracePeriod"),
                InterestGracePeriod: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "InterestGracePeriod"),
                LowerInstallmentInterest: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "LowerInstallmentInterest"),
                ApplyFor: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "ApplyFor"),
                AvoidHolidays: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "AvoidHolidays"),
                FixedPaymentDate: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "FixedPaymentDate"),
                MonthNonPayment: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "MonthNonPayment"),
                DaysGraceArrears: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "DaysGraceArrears"),
                Day: $scope.vc.channelDefaultValues("DatosTablaAmortizacion", "Day")
            };




            //ViewState - Entity: DatosTablaAmortizacion, Attribute: Amount
            $scope.vc.viewState.VA_VIDAOMOZCN6402_AONT460 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: InterestRate
            $scope.vc.viewState.VA_VIDAOMOZCN6402_RATE527 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: Tea
            $scope.vc.viewState.VA_VIDAOMOZCN6402_TEAK414 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: StartDate
            $scope.vc.viewState.VA_VIDAOMOZCN6402_SRTA729 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: FinishDate
            $scope.vc.viewState.VA_VIDAOMOZCN6402_NHDA988 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: AmortizationType
            $scope.vc.viewState.VA_VIDAOMOZCN6402_AINE080 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_VIDAOMOZCN6402_AINE080 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIDAOMOZCN6402_AINE080', 'ca_tipo_amortizacion', function(response) {
                            if (response.data['RESULTVA_VIDAOMOZCN6402_AINE080'] != null) {
                                options.success(response.data['RESULTVA_VIDAOMOZCN6402_AINE080']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Entity: DatosTablaAmortizacion, Attribute: CapitalInstallment
            $scope.vc.viewState.VA_VIDAOMOZCN6402_PTAS926 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: CalculationBase
            $scope.vc.viewState.VA_VIDAOMOZCN6402_CATI798 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_VIDAOMOZCN6402_CATI798 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIDAOMOZCN6402_CATI798', 'ca_base_calculo', function(response) {
                            if (response.data['RESULTVA_VIDAOMOZCN6402_CATI798'] != null) {
                                options.success(response.data['RESULTVA_VIDAOMOZCN6402_CATI798']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Entity: DatosTablaAmortizacion, Attribute: TermType
            $scope.vc.viewState.VA_VIDAOMOZCN6402_TERE199 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_VIDAOMOZCN6402_TERE199 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIDAOMOZCN6402_TERE199', 'ca_tdividendo', function(response) {
                            if (response.data['RESULTVA_VIDAOMOZCN6402_TERE199'] != null) {
                                options.success(response.data['RESULTVA_VIDAOMOZCN6402_TERE199']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Entity: DatosTablaAmortizacion, Attribute: Term
            $scope.vc.viewState.VA_VIDAOMOZCN6402_TERM881 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: InstallmentType
            $scope.vc.viewState.VA_VIDAOMOZCN6402_ISLE406 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_VIDAOMOZCN6402_ISLE406 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIDAOMOZCN6402_ISLE406', 'ca_tdividendo', function(response) {
                            if (response.data['RESULTVA_VIDAOMOZCN6402_ISLE406'] != null) {
                                options.success(response.data['RESULTVA_VIDAOMOZCN6402_ISLE406']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Entity: DatosTablaAmortizacion, Attribute: CapitalPeriod
            $scope.vc.viewState.VA_VIDAOMOZCN6402_ATAE004 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: InterestPeriod
            $scope.vc.viewState.VA_VIDAOMOZCN6402_NTES066 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: CapitalGracePeriod
            $scope.vc.viewState.VA_VIDAOMOZCN6402_IGAD714 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: InterestGracePeriod
            $scope.vc.viewState.VA_VIDAOMOZCN6402_NTSP205 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: ApplyFor
            $scope.vc.viewState.VA_VIDAOMOZCN6402_YFOR167 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.catalogs.VA_VIDAOMOZCN6402_YFOR167 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIDAOMOZCN6402_YFOR167', 'ca_distribuye_gracia', function(response) {
                            if (response.data['RESULTVA_VIDAOMOZCN6402_YFOR167'] != null) {
                                options.success(response.data['RESULTVA_VIDAOMOZCN6402_YFOR167']);
                            } else {
                                options.error();
                            }
                        });
                    }
                },
                serverFiltering: true
            });

            //ViewState - Group: DataSelection
            $scope.vc.viewState.GR_VIDAOMOZCN64_03 = {
                style: {
                    success: false,
                    fail: false,
                    none: true
                },
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: FixedPaymentDate
            $scope.vc.viewState.VA_VIDAOMOZCN6403_IXET745 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: Day
            $scope.vc.viewState.VA_VIDAOMOZCN6403_DAYG367 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: MonthNonPayment
            $scope.vc.viewState.VA_VIDAOMOZCN6403_OPYN316 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Entity: DatosTablaAmortizacion, Attribute: AvoidHolidays
            $scope.vc.viewState.VA_VIDAOMOZCN6403_HDAY789 = {
                readonly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };


            //ViewState - Container: Amortization Table
            $scope.vc.viewState.VC_IATSK55_TITIE_716 = {
                style: {
                    success: false,
                    fail: false,
                    none: true
                },
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: true
            };
            //ViewState - Group: AmortizationTable
            $scope.vc.viewState.GR_AMIZATONEW90_02 = {
                style: {
                    success: false,
                    fail: false,
                    none: true
                },
                disabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                visible: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)
            };

            $scope.vc.types.AmortizationTableEntity = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },

                    QuotaNumber: {
                        type: "number",
                        editable: true

                    },


                    ExpirationDate: {
                        type: "date",
                        editable: true

                    },


                    CapitalBalance: {
                        type: "number",
                        editable: true

                    },


                    Capital: {
                        type: "number",
                        editable: true

                    },


                    Interest: {
                        type: "number",
                        editable: true

                    },


                    Entry1: {
                        type: "number",
                        editable: true

                    },


                    Entry2: {
                        type: "number",
                        editable: true

                    },


                    Entry3: {
                        type: "number",
                        editable: true

                    },


                    Entry4: {
                        type: "number",
                        editable: true

                    },


                    Entry5: {
                        type: "number",
                        editable: true

                    },


                    Entry6: {
                        type: "number",
                        editable: true

                    },


                    Entry7: {
                        type: "number",
                        editable: true

                    },


                    Entry8: {
                        type: "number",
                        editable: true

                    },


                    Entry9: {
                        type: "number",
                        editable: true

                    },


                    Entry10: {
                        type: "number",
                        editable: true

                    },


                    Quota: {
                        type: "number",
                        editable: true

                    }

                }
            });


            $scope.vc.model.AmortizationTableEntity = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        options.success([]);
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
                    model: $scope.vc.types.AmortizationTableEntity
                },
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $scope.grids.QV_OTAOA0659_11.cancelChanges();
                    }
                }
            });

            $scope.vc.trackers.AmortizationTableEntity = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AmortizationTableEntity);
            $scope.vc.model.AmortizationTableEntity.bind('change', function(e) {
                $scope.vc.trackers.AmortizationTableEntity.track(e);


            });


            $scope.vc.grids.QV_OTAOA0659_11 = {};

            $scope.vc.grids.QV_OTAOA0659_11.queryId = 'Q_OTAOABLR_0659';


            $scope.vc.viewState.QV_OTAOA0659_11 = {};
            $scope.vc.viewState.QV_OTAOA0659_11.column = [];

            $scope.vc.grids.QV_OTAOA0659_11.events = {
                customRowClick: function(e, controlId, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.AmortizationTableEntity.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_OTAOA0659_11.selectedRow = e.model;

                },
                dataBound: function(e) {
                    var grid = e.sender;
                    grid.tbody.on('mousedown', 'a,button,input[type="button"]', function(evnt) {
                        evnt.stopImmediatePropagation();
                    });
                    $scope.vc.gridDataBound("QV_OTAOA0659_11");
                }

            };

            //Comandos de registros del Grid	
            $scope.vc.grids.QV_OTAOA0659_11.columns = [];

            //Controles de edicion en linea del Grid

            $scope.vc.viewState.QV_OTAOA0659_11.column.QuotaNumber = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556QTAB08 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 4,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.QuotaNumber.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.ExpirationDate = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETIN60 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'kendo-ext-date-picker': "",
                        placeholder: "{{dateFormat}}",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.ExpirationDate.enabled"
                    });
                    textInput.appendTo(container);

                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.CapitalBalance = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ITBC69 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.CapitalBalance.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Capital = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556TRST77 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Capital.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Interest = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556RERI41 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Interest.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry1 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ERY138 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry1.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry2 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556TRY251 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry2.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry3 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETRY48 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry3.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry4 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ENR456 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry4.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry5 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ERY505 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry5.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry6 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556TRY607 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry6.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry7 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ENT661 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry7.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry8 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETRY75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry8.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry9 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETRY65 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry9.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Entry10 = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETR614 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Entry10.enabled"
                    });
                    textInput.appendTo(container);
                }
            };

            $scope.vc.viewState.QV_OTAOA0659_11.column.Quota = {
                enabled: true,
                hidden: false
            };

            $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556QUOT48 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        name: options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        maxlength: 19,
                        type: "number",
                        'kendo-numeric-text-box': "",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_OTAOA0659_11.column.Quota.enabled"
                    });
                    textInput.appendTo(container);
                }
            };


            //Creacion de columnas del Grid
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'QuotaNumber',
                title: $filter('translate')('BUSIN.DLB_BUSIN_NMEDECOUA_54306'),
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556QTAB08.control
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'ExpirationDate',
                format: '{0:d}',
                title: $filter('translate')('BUSIN.DLB_BUSIN_VNCIMIENO_31170'),
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETIN60.control,
                template: "<span class='ng-binding'>#=kendo.toString(new Date(ExpirationDate),\"d\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'CapitalBalance',
                title: $filter('translate')('BUSIN.DLB_BUSIN_SALDOVJUB_71615'),
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ITBC69.control,
                template: "<span class='ng-binding'>#=kendo.toString(CapitalBalance,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Capital',
                title: $filter('translate')('BUSIN.DLB_BUSIN_CAPITALLU_87951'),
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556TRST77.control,
                template: "<span class='ng-binding'>#=kendo.toString(Capital,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Interest',
                title: $filter('translate')('BUSIN.DLB_BUSIN_INTERSVQG_79957'),
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556RERI41.control,
                template: "<span class='ng-binding'>#=kendo.toString(Interest,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry1',
                title: 'Entry1',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ERY138.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry1,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry2',
                title: 'Entry2',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556TRY251.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry2,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry3',
                title: 'Entry3',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETRY48.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry3,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry4',
                title: 'Entry4',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ENR456.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry4,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry5',
                title: 'Entry5',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ERY505.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry5,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry6',
                title: 'Entry6',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556TRY607.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry6,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry7',
                title: 'Entry7',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ENT661.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry7,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry8',
                title: 'Entry8',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETRY75.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry8,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry9',
                title: 'Entry9',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETRY65.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry9,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Entry10',
                title: 'Entry10',
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556ETR614.control,
                template: "<span class='ng-binding'>#=kendo.toString(Entry10,\"c\")#</span>"
            });
            $scope.vc.grids.QV_OTAOA0659_11.columns.push({
                field: 'Quota',
                title: $filter('translate')('BUSIN.DLB_BUSIN_CUOTAGDBT_09143'),
                editor: $scope.vc.grids.QV_OTAOA0659_11.AT_MOR556QUOT48.control,
                template: "<span class='ng-binding'>#=kendo.toString(Quota,\"c\")#</span>"
            });


            $scope.vc.grids.QV_OTAOA0659_11.toolbar = [];

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

        $scope._initGrids = function() {
            for (var gridN in $scope.vc.grids) {
                var queryId = $scope.vc.grids[gridN].queryId;
                var queryRequest = $scope.vc.request.qr[queryId];
                if (queryId && queryRequest) {
                    if ($scope.vc.model[designer.utils.metadata.findEntityNameById($scope.vc.metadata, queryRequest.mainEntityPk.entityId)].total() == 0) {
                        if ($scope.vc.queryProperties[queryId].autoCrud) {
                            $scope.vc.CRUDExecuteQueryId(queryRequest, true);
                        } else {
                            queryRequest.queryPk.queryId, queryRequest.updateParameters();
                            $scope.vc.executeQuery(gridN, queryRequest.queryPk.queryId, queryRequest.parameters, queryRequest.mainEntityPk.entityId, true);
                        }
                    }
                }
            }
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

        $scope._initPage_ProcessData = function(page) {
            if ($scope.vc.isModal($scope) || (!page.hasTemporaryData && !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode))) {
                //llenado de grids
                $scope._initGrids();
                return page;
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
                $scope.vc.render('VC_IATSK55_AMORN_425');
            }
            return page;
        };

        $scope._prepareThreadLifeCycle = function(page) {
            var deferrer = $q.defer();
            setTimeout(function() {
                deferrer.resolve(page);
            }, 0);
            return deferrer.promise;
        };

        $scope._runLifeCycle = function(page, promise) {
            promise.then(

            function(page) {
                return $scope.vc.temporaryRead(page);
            })
                .then(

            function(page) {
                return $scope.vc.initData(page, $scope.vc);
            })
                .then(

            function(page) {
                return $scope._initPage_CRUDExecuteQueryEntities(page);
            })
                .then(

            function(page) {
                return $scope._initPage_ProcessData(page);
            })
                .then(

            function(page) {
                return $scope._initPage_InitializeTrackers(page);
            })
                .then(

            function(page) {
                return $scope._initPage_ChangeInitData(page);
            })
                .then(

            function(page) {
                return $scope._initPage_ProcessRender(page);
            });
        };

        if ($scope.vc.isModal($scope)) {
            $document.ready(function() {
                var threadLifeCycle = $scope._prepareThreadLifeCycle(page);
                if (threadLifeCycle) {
                    $scope._runLifeCycle(page, threadLifeCycle);
                }
            });
        } else {
            //con ngView no funciona el $document.ready se cambia por $viewContentLoaded
            $scope.$on('$viewContentLoaded', function() {
                if ($scope.vc.loaded) {
                    //Si se esta regresando de otra pantalla
                    $scope.vc.addChangeEvents($scope);
                    if ($scope.vc.dialogResponse || $scope.vc.customDialogResponse) {
                        $scope.vc.afterCloseGridDialog();
                    }
                } else {
                    //Si es la primera vez que se ejecuta la pantalla
                    var threadLifeCycle = $scope._prepareThreadLifeCycle(page);
                    if (threadLifeCycle) {
                        $scope._runLifeCycle(page, threadLifeCycle);
                    }
                }
            });
        }

    }]);
}

if (typeof cobisMainModule === "undefined") {

    var cobisMainModule = cobis.createModule("VC_IATSK55_AMORN_425", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);

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
        $routeProvider.when("/VC_IATSK55_AMORN_425", {
            templateUrl: "VC_IATSK55_AMORN_425_FORM.html",
            controller: "VC_IATSK55_AMORN_425_CTRL",
            labelId: "BUSIN.DLB_BUSIN_OTTIOTBLE_83895",
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_IATSK55_AMORN_425?" + $.param(search);
            }
        });
        VC_IATSK55_AMORN_425(cobisMainModule);
    }]);
} else {
    VC_IATSK55_AMORN_425(cobisMainModule);
}