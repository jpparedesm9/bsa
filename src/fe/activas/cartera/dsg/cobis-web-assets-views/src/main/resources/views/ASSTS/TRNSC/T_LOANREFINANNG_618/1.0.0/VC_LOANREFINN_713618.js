//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.loanrefinancing = designerEvents.api.loanrefinancing || designer.dsgEvents();

function VC_LOANREFINN_713618(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LOANREFINN_713618_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LOANREFINN_713618_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "TRNSC",
            taskId: "T_LOANREFINANNG_618",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LOANREFINN_713618",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_LOANREFINANNG_618",
        designerEvents.api.loanrefinancing,
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
                vcName: 'VC_LOANREFINN_713618'
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
                    subModuleId: 'TRNSC',
                    taskId: 'T_LOANREFINANNG_618',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    RefinanceLoans: "RefinanceLoans",
                    RefinanceLoansItems: "RefinanceLoansItems",
                    RefinanceDetailLoans: "RefinanceDetailLoans",
                    RefinanceTransaction: "RefinanceTransaction",
                    LoanInstancia: "LoanInstancia"
                },
                entities: {
                    Loan: {
                        numProcedure: 'AT10_NUMPROUE882',
                        quotaCredit: 'AT12_QUOTACEE882',
                        statusID: 'AT12_STATUSID882',
                        lastProcessDate: 'AT19_LASTPRED882',
                        balanceDue: 'AT21_BALANCDD882',
                        category: 'AT23_CATEGOYR882',
                        operationTypeID: 'AT23_OPERATDP882',
                        codCurrency: 'AT24_CODMONDD882',
                        newStatusID: 'AT25_NEWSTATT882',
                        isDisbursment: 'AT26_ISDISBTU882',
                        migratedOper: 'AT33_MIGRATEO882',
                        loanID: 'AT37_LOANIDFI882',
                        officeID: 'AT37_OFFICEID882',
                        currencyName: 'AT39_CURRENYY882',
                        startDate: 'AT39_STARTDEE882',
                        loanBankID: 'AT42_LOANBADK882',
                        idType: 'AT48_IDTYPEBH882',
                        endDate: 'AT50_ENDDATEE882',
                        identityCardNumber: 'AT56_IDCARDUU882',
                        desOperationType: 'AT57_DESOPETI882',
                        redesCont: 'AT58_REDESCTN882',
                        newStatus: 'AT59_NEWSTASS882',
                        group: 'AT62_GROUPTNG882',
                        previousOper: 'AT65_PREVIOPU882',
                        status: 'AT66_STATUSOB882',
                        clientID: 'AT68_CLIENTII882',
                        operationType: 'AT70_OPERATPP882',
                        clientName: 'AT71_CLIENTNA882',
                        disbursementDate: 'AT76_DISBURTS882',
                        expirationDate: 'AT76_EXPIRAEE882',
                        officer: 'AT77_OFFICERR882',
                        nextPayment: 'AT85_NEXTPAMT882',
                        effectiveAnualRate: 'AT90_EFFECTAU882',
                        amount: 'AT91_AMOUNTMO882',
                        adjustment: 'AT94_ADJUSTNT882',
                        officerID: 'AT95_OFFICEID882',
                        office: 'AT96_OFFICEPU882',
                        feeEndDate: 'AT99_FEEENDED882',
                        _pks: [],
                        _entityId: 'EN_LOANKYMRI_882',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RefinanceLoans: {
                        loan: 'AT67_LOANWAUS582',
                        line: 'AT78_LINEUGLL582',
                        initialAmount: 'AT34_INITIAAA582',
                        totalToRefinance: 'AT94_TOTALTCA582',
                        totalBalance: 'AT16_TOTALBCN582',
                        currencyCode: 'AT55_CURRENDE582',
                        quotation: 'AT54_QUOTATNO582',
                        transactionID: 'AT25_TRANSANC582',
                        officialID: 'AT85_OFFICIDL582',
                        originalTerm: 'AT35_ORIGINAT582',
                        capitalBalance: 'AT89_CAPITABA582',
                        interestBalance: 'AT86_INTEREAA582',
                        defaultBalance: 'AT59_DEFAULCN582',
                        otherConceptsBalance: 'AT25_OTHERCAA582',
                        residualTerm: 'AT97_RESIDURR582',
                        loanStatus: 'AT33_LOANSTUA582',
                        currencyType: 'AT34_CURRENCP582',
                        overdueFees: 'AT30_OVERDUSE582',
                        _pks: [],
                        _entityId: 'EN_REFINANLC_582',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RefinanceLoansItems: {
                        concept: 'AT91_CONCEPTT289',
                        conceptStatus: 'AT78_CONCEPTS289',
                        previowsDuty: 'AT21_PREVIOTS289',
                        quotaStatus: 'AT41_QUOTASAT289',
                        _pks: [],
                        _entityId: 'EN_REFINANOM_289',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RefinanceDetailLoans: {
                        loanNumber: 'AT19_LOANNUEE273',
                        currencyCode: 'AT80_CURRENEE273',
                        currencyName: 'AT81_CURRENAE273',
                        loanTypeCode: 'AT26_LOANTYEE273',
                        loanTypeName: 'AT69_LOANTYMA273',
                        loanAmount: 'AT78_LOANAMOU273',
                        amountToCancel: 'AT66_AMOUNTCC273',
                        deliverCustomer: 'AT98_DELIVECS273',
                        observations: 'AT13_OBSERVST273',
                        _pks: [],
                        _entityId: 'EN_REFINANLA_273',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RefinanceTransaction: {
                        refinanceTransactionint: 'AT47_REFINATN637',
                        _pks: [],
                        _entityId: 'EN_REFINANCC_637',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanInstancia: {
                        idInstancia: 'AT74_IDINSTAA482',
                        idOptionMenu: 'AT59_IDOPTINM482',
                        errorValidation: 'AT62_ERRORVAA482',
                        _pks: [],
                        _entityId: 'EN_LOANINSTC_482',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_REFINANE_6687 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_REFINANE_6687 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_REFINANE_6687_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_REFINANE_6687_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_REFINANOM_289',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_REFINANE_6687',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_REFINANE_6687_filters = {};
            $scope.vc.queryProperties.Q_REFINACL_2890 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_REFINACL_2890 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_REFINACL_2890_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_REFINACL_2890_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_REFINANLC_582',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_REFINACL_2890',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_REFINACL_2890_filters = {};
            var defaultValues = {
                Loan: {},
                RefinanceLoans: {},
                RefinanceLoansItems: {},
                RefinanceDetailLoans: {},
                RefinanceTransaction: {},
                LoanInstancia: {}
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
                $scope.vc.execute("temporarySave", VC_LOANREFINN_713618, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LOANREFINN_713618, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LOANREFINN_713618, data, function() {});
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
            $scope.vc.viewState.VC_LOANREFINN_713618 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_LOANREFINN_713618",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_AUCLUAIEKU_127618",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_EEJGZEPGLJ_115316",
                hasId: true,
                componentStyle: [],
                label: 'LoanHeaderInfoForm',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Loan = {
                numProcedure: $scope.vc.channelDefaultValues("Loan", "numProcedure"),
                quotaCredit: $scope.vc.channelDefaultValues("Loan", "quotaCredit"),
                statusID: $scope.vc.channelDefaultValues("Loan", "statusID"),
                lastProcessDate: $scope.vc.channelDefaultValues("Loan", "lastProcessDate"),
                balanceDue: $scope.vc.channelDefaultValues("Loan", "balanceDue"),
                category: $scope.vc.channelDefaultValues("Loan", "category"),
                operationTypeID: $scope.vc.channelDefaultValues("Loan", "operationTypeID"),
                codCurrency: $scope.vc.channelDefaultValues("Loan", "codCurrency"),
                newStatusID: $scope.vc.channelDefaultValues("Loan", "newStatusID"),
                isDisbursment: $scope.vc.channelDefaultValues("Loan", "isDisbursment"),
                migratedOper: $scope.vc.channelDefaultValues("Loan", "migratedOper"),
                loanID: $scope.vc.channelDefaultValues("Loan", "loanID"),
                officeID: $scope.vc.channelDefaultValues("Loan", "officeID"),
                currencyName: $scope.vc.channelDefaultValues("Loan", "currencyName"),
                startDate: $scope.vc.channelDefaultValues("Loan", "startDate"),
                loanBankID: $scope.vc.channelDefaultValues("Loan", "loanBankID"),
                idType: $scope.vc.channelDefaultValues("Loan", "idType"),
                endDate: $scope.vc.channelDefaultValues("Loan", "endDate"),
                identityCardNumber: $scope.vc.channelDefaultValues("Loan", "identityCardNumber"),
                desOperationType: $scope.vc.channelDefaultValues("Loan", "desOperationType"),
                redesCont: $scope.vc.channelDefaultValues("Loan", "redesCont"),
                newStatus: $scope.vc.channelDefaultValues("Loan", "newStatus"),
                group: $scope.vc.channelDefaultValues("Loan", "group"),
                previousOper: $scope.vc.channelDefaultValues("Loan", "previousOper"),
                status: $scope.vc.channelDefaultValues("Loan", "status"),
                clientID: $scope.vc.channelDefaultValues("Loan", "clientID"),
                operationType: $scope.vc.channelDefaultValues("Loan", "operationType"),
                clientName: $scope.vc.channelDefaultValues("Loan", "clientName"),
                disbursementDate: $scope.vc.channelDefaultValues("Loan", "disbursementDate"),
                expirationDate: $scope.vc.channelDefaultValues("Loan", "expirationDate"),
                officer: $scope.vc.channelDefaultValues("Loan", "officer"),
                nextPayment: $scope.vc.channelDefaultValues("Loan", "nextPayment"),
                effectiveAnualRate: $scope.vc.channelDefaultValues("Loan", "effectiveAnualRate"),
                amount: $scope.vc.channelDefaultValues("Loan", "amount"),
                adjustment: $scope.vc.channelDefaultValues("Loan", "adjustment"),
                officerID: $scope.vc.channelDefaultValues("Loan", "officerID"),
                office: $scope.vc.channelDefaultValues("Loan", "office"),
                feeEndDate: $scope.vc.channelDefaultValues("Loan", "feeEndDate")
            };
            //ViewState - Group: Group2443
            $scope.vc.createViewState({
                id: "G_LOANHEADOD_564612",
                hasId: true,
                componentStyle: [],
                label: 'Group2443',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_143612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1657
            $scope.vc.createViewState({
                id: "G_LOANHEADRO_349612",
                hasId: true,
                componentStyle: [],
                label: 'Group1657',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: loanBankID
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_867612",
                componentStyle: [],
                labelImageId: "",
                label: "ASSTS.LBL_ASSTS_PRSTAMOFK_44930",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVITZRQ_108612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-info-sign",
                label: "ASSTS.LBL_ASSTS_MASINACIN_18792",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONORYJAMS_468612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-search",
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1848
            $scope.vc.createViewState({
                id: "G_LOANHEAINF_340612",
                hasId: true,
                componentStyle: [],
                label: 'Group1848',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_5034UOFCASVGKTK_993612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOCRDOO_69382",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: balanceDue
            $scope.vc.createViewState({
                id: "VA_2463BHBNLZPKLMU_865612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOEXBB_70535",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: status
            $scope.vc.createViewState({
                id: "VA_3853RRTWBIRUGHQ_533612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOEAI_33340",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: office
            $scope.vc.createViewState({
                id: "VA_7292SEAHPRAXOKC_868612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_QYSEYRQEPI_611618",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: RefinanceLoans
            $scope.vc.createViewState({
                id: "VC_SCIADDUTKF_461386",
                hasId: true,
                componentStyle: [],
                label: 'RefinanceLoans',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1208
            $scope.vc.createViewState({
                id: "G_REFINANLCC_149881",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1208',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1975
            $scope.vc.createViewState({
                id: "G_REFINANNAA_790881",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRSTAMORA_59340",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RefinanceLoans = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    loan: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "loan", '')
                    },
                    line: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "line", '')
                    },
                    initialAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "initialAmount", 0)
                    },
                    totalToRefinance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "totalToRefinance", 0)
                    },
                    totalBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "totalBalance", 0)
                    },
                    currencyCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "currencyCode", 0)
                    },
                    quotation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "quotation", 0)
                    }
                }
            });
            $scope.vc.model.RefinanceLoans = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_REFINACL_2890();
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
                    model: $scope.vc.types.RefinanceLoans
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2890_45043").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_REFINACL_2890 = $scope.vc.model.RefinanceLoans;
            $scope.vc.trackers.RefinanceLoans = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RefinanceLoans);
            $scope.vc.model.RefinanceLoans.bind('change', function(e) {
                $scope.vc.trackers.RefinanceLoans.track(e);
            });
            $scope.vc.grids.QV_2890_45043 = {};
            $scope.vc.grids.QV_2890_45043.queryId = 'Q_REFINACL_2890';
            $scope.vc.viewState.QV_2890_45043 = {
                style: undefined
            };
            $scope.vc.viewState.QV_2890_45043.column = {};
            $scope.vc.grids.QV_2890_45043.editable = false;
            $scope.vc.grids.QV_2890_45043.events = {
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
                    $scope.vc.trackers.RefinanceLoans.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_2890_45043.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_2890_45043");
                    $scope.vc.hideShowColumns("QV_2890_45043", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2890_45043.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2890_45043.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_2890_45043.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2890_45043 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2890_45043 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_2890_45043.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_2890_45043.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_2890_45043.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "RefinanceLoans",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_2890_45043", args);
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
            $scope.vc.grids.QV_2890_45043.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2890_45043.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2890_45043.column.loan = {
                title: 'ASSTS.LBL_ASSTS_NOOPERAOC_23583',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXALW_956881',
                element: []
            };
            $scope.vc.grids.QV_2890_45043.AT67_LOANWAUS582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2890_45043.column.loan.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXALW_956881",
                        'maxlength': 16,
                        'data-validation-code': "{{vc.viewState.QV_2890_45043.column.loan.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2890_45043.column.loan.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2890_45043.column.line = {
                title: 'ASSTS.LBL_ASSTS_LNEAWPTLE_75914',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXETM_405881',
                element: []
            };
            $scope.vc.grids.QV_2890_45043.AT78_LINEUGLL582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2890_45043.column.line.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXETM_405881",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_2890_45043.column.line.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2890_45043.column.line.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2890_45043.column.initialAmount = {
                title: 'ASSTS.LBL_ASSTS_MONTOORGI_46642',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUBE_349881',
                element: []
            };
            $scope.vc.grids.QV_2890_45043.AT34_INITIAAA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2890_45043.column.initialAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUBE_349881",
                        'data-validation-code': "{{vc.viewState.QV_2890_45043.column.initialAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2890_45043.column.initialAmount.format",
                        'k-decimals': "vc.viewState.QV_2890_45043.column.initialAmount.decimals",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2890_45043.column.initialAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2890_45043.column.totalToRefinance = {
                title: 'ASSTS.LBL_ASSTS_TOTALRENN_38363',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVQU_400881',
                element: []
            };
            $scope.vc.grids.QV_2890_45043.AT94_TOTALTCA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2890_45043.column.totalToRefinance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVQU_400881",
                        'data-validation-code': "{{vc.viewState.QV_2890_45043.column.totalToRefinance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2890_45043.column.totalToRefinance.format",
                        'k-decimals': "vc.viewState.QV_2890_45043.column.totalToRefinance.decimals",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2890_45043.column.totalToRefinance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2890_45043.column.totalBalance = {
                title: 'ASSTS.LBL_ASSTS_SALDOTOLL_54355',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCEP_986881',
                element: []
            };
            $scope.vc.grids.QV_2890_45043.AT16_TOTALBCN582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2890_45043.column.totalBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCEP_986881",
                        'data-validation-code': "{{vc.viewState.QV_2890_45043.column.totalBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2890_45043.column.totalBalance.format",
                        'k-decimals': "vc.viewState.QV_2890_45043.column.totalBalance.decimals",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2890_45043.column.totalBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2890_45043.column.currencyCode = {
                title: 'ASSTS.LBL_ASSTS_MONEDATUB_92849',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIGO_683881',
                element: []
            };
            $scope.vc.grids.QV_2890_45043.AT55_CURRENDE582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2890_45043.column.currencyCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIGO_683881",
                        'data-validation-code': "{{vc.viewState.QV_2890_45043.column.currencyCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2890_45043.column.currencyCode.format",
                        'k-decimals': "vc.viewState.QV_2890_45043.column.currencyCode.decimals",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2890_45043.column.currencyCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2890_45043.column.quotation = {
                title: 'ASSTS.LBL_ASSTS_COTIZACNN_31924',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLYL_557881',
                element: []
            };
            $scope.vc.grids.QV_2890_45043.AT54_QUOTATNO582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2890_45043.column.quotation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLYL_557881",
                        'data-validation-code': "{{vc.viewState.QV_2890_45043.column.quotation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2890_45043.column.quotation.format",
                        'k-decimals': "vc.viewState.QV_2890_45043.column.quotation.decimals",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2890_45043.column.quotation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2890_45043.columns.push({
                    field: 'loan',
                    title: '{{vc.viewState.QV_2890_45043.column.loan.title|translate:vc.viewState.QV_2890_45043.column.loan.titleArgs}}',
                    width: $scope.vc.viewState.QV_2890_45043.column.loan.width,
                    format: $scope.vc.viewState.QV_2890_45043.column.loan.format,
                    editor: $scope.vc.grids.QV_2890_45043.AT67_LOANWAUS582.control,
                    template: "<span ng-class='vc.viewState.QV_2890_45043.column.loan.style' ng-bind='vc.getStringColumnFormat(dataItem.loan, \"QV_2890_45043\", \"loan\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2890_45043.column.loan.style",
                        "title": "{{vc.viewState.QV_2890_45043.column.loan.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2890_45043.column.loan.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2890_45043.columns.push({
                    field: 'line',
                    title: '{{vc.viewState.QV_2890_45043.column.line.title|translate:vc.viewState.QV_2890_45043.column.line.titleArgs}}',
                    width: $scope.vc.viewState.QV_2890_45043.column.line.width,
                    format: $scope.vc.viewState.QV_2890_45043.column.line.format,
                    editor: $scope.vc.grids.QV_2890_45043.AT78_LINEUGLL582.control,
                    template: "<span ng-class='vc.viewState.QV_2890_45043.column.line.style' ng-bind='vc.getStringColumnFormat(dataItem.line, \"QV_2890_45043\", \"line\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2890_45043.column.line.style",
                        "title": "{{vc.viewState.QV_2890_45043.column.line.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2890_45043.column.line.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2890_45043.columns.push({
                    field: 'initialAmount',
                    title: '{{vc.viewState.QV_2890_45043.column.initialAmount.title|translate:vc.viewState.QV_2890_45043.column.initialAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_2890_45043.column.initialAmount.width,
                    format: $scope.vc.viewState.QV_2890_45043.column.initialAmount.format,
                    editor: $scope.vc.grids.QV_2890_45043.AT34_INITIAAA582.control,
                    template: "<span ng-class='vc.viewState.QV_2890_45043.column.initialAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.initialAmount, \"QV_2890_45043\", \"initialAmount\"):kendo.toString(#=initialAmount#, vc.viewState.QV_2890_45043.column.initialAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2890_45043.column.initialAmount.style",
                        "title": "{{vc.viewState.QV_2890_45043.column.initialAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2890_45043.column.initialAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2890_45043.columns.push({
                    field: 'totalToRefinance',
                    title: '{{vc.viewState.QV_2890_45043.column.totalToRefinance.title|translate:vc.viewState.QV_2890_45043.column.totalToRefinance.titleArgs}}',
                    width: $scope.vc.viewState.QV_2890_45043.column.totalToRefinance.width,
                    format: $scope.vc.viewState.QV_2890_45043.column.totalToRefinance.format,
                    editor: $scope.vc.grids.QV_2890_45043.AT94_TOTALTCA582.control,
                    template: "<span ng-class='vc.viewState.QV_2890_45043.column.totalToRefinance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.totalToRefinance, \"QV_2890_45043\", \"totalToRefinance\"):kendo.toString(#=totalToRefinance#, vc.viewState.QV_2890_45043.column.totalToRefinance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2890_45043.column.totalToRefinance.style",
                        "title": "{{vc.viewState.QV_2890_45043.column.totalToRefinance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2890_45043.column.totalToRefinance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2890_45043.columns.push({
                    field: 'totalBalance',
                    title: '{{vc.viewState.QV_2890_45043.column.totalBalance.title|translate:vc.viewState.QV_2890_45043.column.totalBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_2890_45043.column.totalBalance.width,
                    format: $scope.vc.viewState.QV_2890_45043.column.totalBalance.format,
                    editor: $scope.vc.grids.QV_2890_45043.AT16_TOTALBCN582.control,
                    template: "<span ng-class='vc.viewState.QV_2890_45043.column.totalBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.totalBalance, \"QV_2890_45043\", \"totalBalance\"):kendo.toString(#=totalBalance#, vc.viewState.QV_2890_45043.column.totalBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2890_45043.column.totalBalance.style",
                        "title": "{{vc.viewState.QV_2890_45043.column.totalBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2890_45043.column.totalBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2890_45043.columns.push({
                    field: 'currencyCode',
                    title: '{{vc.viewState.QV_2890_45043.column.currencyCode.title|translate:vc.viewState.QV_2890_45043.column.currencyCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_2890_45043.column.currencyCode.width,
                    format: $scope.vc.viewState.QV_2890_45043.column.currencyCode.format,
                    editor: $scope.vc.grids.QV_2890_45043.AT55_CURRENDE582.control,
                    template: "<span ng-class='vc.viewState.QV_2890_45043.column.currencyCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.currencyCode, \"QV_2890_45043\", \"currencyCode\"):kendo.toString(#=currencyCode#, vc.viewState.QV_2890_45043.column.currencyCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2890_45043.column.currencyCode.style",
                        "title": "{{vc.viewState.QV_2890_45043.column.currencyCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2890_45043.column.currencyCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2890_45043.columns.push({
                    field: 'quotation',
                    title: '{{vc.viewState.QV_2890_45043.column.quotation.title|translate:vc.viewState.QV_2890_45043.column.quotation.titleArgs}}',
                    width: $scope.vc.viewState.QV_2890_45043.column.quotation.width,
                    format: $scope.vc.viewState.QV_2890_45043.column.quotation.format,
                    editor: $scope.vc.grids.QV_2890_45043.AT54_QUOTATNO582.control,
                    template: "<span ng-class='vc.viewState.QV_2890_45043.column.quotation.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.quotation, \"QV_2890_45043\", \"quotation\"):kendo.toString(#=quotation#, vc.viewState.QV_2890_45043.column.quotation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2890_45043.column.quotation.style",
                        "title": "{{vc.viewState.QV_2890_45043.column.quotation.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2890_45043.column.quotation.hidden
                });
            }
            $scope.vc.viewState.QV_2890_45043.toolbar = {}
            $scope.vc.grids.QV_2890_45043.toolbar = [];
            //ViewState - Group: Group2901
            $scope.vc.createViewState({
                id: "G_REFINANCAE_644881",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RUBROSCLP_83562",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RefinanceLoansItems = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoansItems", "concept", '')
                    },
                    conceptStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoansItems", "conceptStatus", '')
                    },
                    previowsDuty: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoansItems", "previowsDuty", '')
                    },
                    quotaStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoansItems", "quotaStatus", '')
                    }
                }
            });
            $scope.vc.model.RefinanceLoansItems = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_REFINANE_6687();
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
                    model: $scope.vc.types.RefinanceLoansItems
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6687_51127").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_REFINANE_6687 = $scope.vc.model.RefinanceLoansItems;
            $scope.vc.trackers.RefinanceLoansItems = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RefinanceLoansItems);
            $scope.vc.model.RefinanceLoansItems.bind('change', function(e) {
                $scope.vc.trackers.RefinanceLoansItems.track(e);
            });
            $scope.vc.grids.QV_6687_51127 = {};
            $scope.vc.grids.QV_6687_51127.queryId = 'Q_REFINANE_6687';
            $scope.vc.viewState.QV_6687_51127 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6687_51127.column = {};
            $scope.vc.grids.QV_6687_51127.editable = false;
            $scope.vc.grids.QV_6687_51127.events = {
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
                    $scope.vc.trackers.RefinanceLoansItems.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6687_51127.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6687_51127");
                    $scope.vc.hideShowColumns("QV_6687_51127", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6687_51127.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6687_51127.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6687_51127.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6687_51127 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6687_51127 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6687_51127.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6687_51127.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6687_51127.column.concept = {
                title: 'ASSTS.LBL_ASSTS_CONCEPTOO_16181',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPBU_986881',
                element: []
            };
            $scope.vc.grids.QV_6687_51127.AT91_CONCEPTT289 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6687_51127.column.concept.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPBU_986881",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_6687_51127.column.concept.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6687_51127.column.concept.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6687_51127.column.conceptStatus = {
                title: 'ASSTS.LBL_ASSTS_ESTADOCOT_53322',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMRT_873881',
                element: []
            };
            $scope.vc.grids.QV_6687_51127.AT78_CONCEPTS289 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6687_51127.column.conceptStatus.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMRT_873881",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_6687_51127.column.conceptStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6687_51127.column.conceptStatus.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6687_51127.column.previowsDuty = {
                title: 'ASSTS.LBL_ASSTS_OBLIGANRR_23695',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYKF_264881',
                element: []
            };
            $scope.vc.grids.QV_6687_51127.AT21_PREVIOTS289 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6687_51127.column.previowsDuty.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYKF_264881",
                        'maxlength': 24,
                        'data-validation-code': "{{vc.viewState.QV_6687_51127.column.previowsDuty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6687_51127.column.previowsDuty.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6687_51127.column.quotaStatus = {
                title: 'ASSTS.LBL_ASSTS_ESTADOCAO_43748',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPBQ_251881',
                element: []
            };
            $scope.vc.grids.QV_6687_51127.AT41_QUOTASAT289 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6687_51127.column.quotaStatus.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPBQ_251881",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_6687_51127.column.quotaStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "CollapsibleLayout,G_REFINANLCC_149881,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6687_51127.column.quotaStatus.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6687_51127.columns.push({
                    field: 'concept',
                    title: '{{vc.viewState.QV_6687_51127.column.concept.title|translate:vc.viewState.QV_6687_51127.column.concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_6687_51127.column.concept.width,
                    format: $scope.vc.viewState.QV_6687_51127.column.concept.format,
                    editor: $scope.vc.grids.QV_6687_51127.AT91_CONCEPTT289.control,
                    template: "<span ng-class='vc.viewState.QV_6687_51127.column.concept.style' ng-bind='vc.getStringColumnFormat(dataItem.concept, \"QV_6687_51127\", \"concept\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6687_51127.column.concept.style",
                        "title": "{{vc.viewState.QV_6687_51127.column.concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6687_51127.column.concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6687_51127.columns.push({
                    field: 'conceptStatus',
                    title: '{{vc.viewState.QV_6687_51127.column.conceptStatus.title|translate:vc.viewState.QV_6687_51127.column.conceptStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_6687_51127.column.conceptStatus.width,
                    format: $scope.vc.viewState.QV_6687_51127.column.conceptStatus.format,
                    editor: $scope.vc.grids.QV_6687_51127.AT78_CONCEPTS289.control,
                    template: "<span ng-class='vc.viewState.QV_6687_51127.column.conceptStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.conceptStatus, \"QV_6687_51127\", \"conceptStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6687_51127.column.conceptStatus.style",
                        "title": "{{vc.viewState.QV_6687_51127.column.conceptStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6687_51127.column.conceptStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6687_51127.columns.push({
                    field: 'previowsDuty',
                    title: '{{vc.viewState.QV_6687_51127.column.previowsDuty.title|translate:vc.viewState.QV_6687_51127.column.previowsDuty.titleArgs}}',
                    width: $scope.vc.viewState.QV_6687_51127.column.previowsDuty.width,
                    format: $scope.vc.viewState.QV_6687_51127.column.previowsDuty.format,
                    editor: $scope.vc.grids.QV_6687_51127.AT21_PREVIOTS289.control,
                    template: "<span ng-class='vc.viewState.QV_6687_51127.column.previowsDuty.style' ng-bind='vc.getStringColumnFormat(dataItem.previowsDuty, \"QV_6687_51127\", \"previowsDuty\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6687_51127.column.previowsDuty.style",
                        "title": "{{vc.viewState.QV_6687_51127.column.previowsDuty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6687_51127.column.previowsDuty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6687_51127.columns.push({
                    field: 'quotaStatus',
                    title: '{{vc.viewState.QV_6687_51127.column.quotaStatus.title|translate:vc.viewState.QV_6687_51127.column.quotaStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_6687_51127.column.quotaStatus.width,
                    format: $scope.vc.viewState.QV_6687_51127.column.quotaStatus.format,
                    editor: $scope.vc.grids.QV_6687_51127.AT41_QUOTASAT289.control,
                    template: "<span ng-class='vc.viewState.QV_6687_51127.column.quotaStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.quotaStatus, \"QV_6687_51127\", \"quotaStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6687_51127.column.quotaStatus.style",
                        "title": "{{vc.viewState.QV_6687_51127.column.quotaStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6687_51127.column.quotaStatus.hidden
                });
            }
            $scope.vc.viewState.QV_6687_51127.toolbar = {}
            $scope.vc.grids.QV_6687_51127.toolbar = [];
            $scope.vc.model.RefinanceDetailLoans = {
                loanNumber: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "loanNumber"),
                currencyCode: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "currencyCode"),
                currencyName: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "currencyName"),
                loanTypeCode: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "loanTypeCode"),
                loanTypeName: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "loanTypeName"),
                loanAmount: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "loanAmount"),
                amountToCancel: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "amountToCancel"),
                deliverCustomer: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "deliverCustomer"),
                observations: $scope.vc.channelDefaultValues("RefinanceDetailLoans", "observations")
            };
            //ViewState - Group: Group2215
            $scope.vc.createViewState({
                id: "G_REFINANASL_130881",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DATOSLAEE_51137",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2360",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_975881",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TOTALLAAC_72481",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceDetailLoans, Attribute: loanAmount
            $scope.vc.createViewState({
                id: "VA_LOANAMOUNTTKXCD_133881",
                componentStyle: [],
                label: '',
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2546",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2491",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_799881",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TOTALPRTO_69722",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceDetailLoans, Attribute: amountToCancel
            $scope.vc.createViewState({
                id: "VA_AMOUNTTOCANCELL_703881",
                componentStyle: [],
                label: '',
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2678",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2798",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2778",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATORTRMM_125881",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2198",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2170",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_584881",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ENTREGACA_60626",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceDetailLoans, Attribute: deliverCustomer
            $scope.vc.createViewState({
                id: "VA_DELIVERCUSTOEER_870881",
                componentStyle: [],
                label: '',
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2150",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: RefinanceDetailLoans, Attribute: observations
            $scope.vc.createViewState({
                id: "VA_OBSERVATIONSLWS_588881",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OBSERVAOO_32947",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANREFINANNG_618_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANREFINANNG_618_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TLOANREF_1NA",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RENOVARSX_85761",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.RefinanceTransaction = {
                refinanceTransactionint: $scope.vc.channelDefaultValues("RefinanceTransaction", "refinanceTransactionint")
            };
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
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
                $scope.vc.render('VC_LOANREFINN_713618');
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
    var cobisMainModule = cobis.createModule("VC_LOANREFINN_713618", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_LOANREFINN_713618", {
            templateUrl: "VC_LOANREFINN_713618_FORM.html",
            controller: "VC_LOANREFINN_713618_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LOANREFINN_713618?" + $.param(search);
            }
        });
        VC_LOANREFINN_713618(cobisMainModule);
    }]);
} else {
    VC_LOANREFINN_713618(cobisMainModule);
}