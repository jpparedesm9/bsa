//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.groupcomposite = designerEvents.api.groupcomposite || designer.dsgEvents();

function VC_GROUPCOMOS_387974(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_GROUPCOMOS_387974_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_GROUPCOMOS_387974_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "LOANS",
            subModuleId: "GROUP",
            taskId: "T_GROUPCOMPOIET_974",
            taskVersion: "1.0.0",
            viewContainerId: "VC_GROUPCOMOS_387974",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_GROUPCOMPOIET_974",
        designerEvents.api.groupcomposite,
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
                vcName: 'VC_GROUPCOMOS_387974'
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
                    moduleId: 'LOANS',
                    subModuleId: 'GROUP',
                    taskId: 'T_GROUPCOMPOIET_974',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Amount: "Amount",
                    Credit: "Credit",
                    Group: "Group",
                    Member: "Member",
                    Context: "Context"
                },
                entities: {
                    Amount: {
                        authorizedAmount: 'AT29_AUTHORZE937',
                        creditBureau: 'AT31_CREDITER937',
                        cycleParticipation: 'AT31_CYCLEPCN937',
                        voluntarySavings: 'AT36_VOLUNTNI937',
                        increment: 'AT41_INCREMTT937',
                        memberId: 'AT45_MEMBERID937',
                        amount: 'AT51_AMOUNTUQ937',
                        secuential: 'AT52_SECUENIA937',
                        resultAmount: 'AT58_RESULTNN937',
                        memberName: 'AT62_MEMBERNN937',
                        riskLevel: 'AT66_RISKLEVV937',
                        checkRenapo: 'AT69_CHECKREP937',
                        groupId: 'AT70_GROUPIDD937',
                        safeReport: 'AT71_SAFERERR937',
                        oldOperation: 'AT73_OLDOPENI937',
                        credit: 'AT83_CREDITGM937',
                        safePackage: 'AT91_SAFEPACA937',
                        proposedMaximumSaving: 'AT92_PROPOSNG937',
                        oldBalance: 'AT96_OLDBALCC937',
                        _pks: [],
                        _entityId: 'EN_MONTOSVSY_937',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Credit: {
                        office: 'AT11_OFFICEGM386',
                        subtype: 'AT26_SUBTYPEE386',
                        linked: 'AT37_LINKEDMA386',
                        term: 'AT40_TERMUMMV386',
                        category: 'AT42_CATEGORY386',
                        businessSector: 'AT45_BUSINESC386',
                        officeName: 'AT45_OFFICEAN386',
                        operationNumber: 'AT48_OPERATNI386',
                        customerId: 'AT63_CUSTOMIR386',
                        isRenovation: 'AT63_ISRENONN386',
                        applicationNumber: 'AT65_APPLICUR386',
                        approvedAmount: 'AT70_APPROVMO386',
                        nemonicCurrency: 'AT70_MNEMONER386',
                        nameActivity: 'AT71_NAMEACIY386',
                        percentageWarranty: 'AT71_PERCENWA386',
                        paymentFrecuencyName: 'AT75_PAYMENEE386',
                        creditCode: 'AT76_CREDITCC386',
                        productType: 'AT85_PRODUCTP386',
                        amountRequested: 'AT87_AMOUNTEE386',
                        warrantyAmount: 'AT90_WARRANUT386',
                        paymentFrecuency: 'AT94_PAYMENEE386',
                        _pks: [],
                        _entityId: 'EN_CREDITAUT_386',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Group: {
                        hasGroupAccount: 'AT18_HASGROOA452',
                        meetingAddress: 'AT24_MEETINSD452',
                        nextVisitDate: 'AT28_NEXTVIAA452',
                        state: 'AT34_STATENKY452',
                        titular2Name: 'AT36_TITULARN452',
                        groupOffice: 'AT42_GROUPOFE452',
                        titularClient2: 'AT44_TITULAIE452',
                        userName: 'AT44_USERNAMM452',
                        addressMember: 'AT49_ADDRESSS452',
                        day: 'AT52_DAYBKCTB452',
                        constitutionDate: 'AT58_CONSTIAI452',
                        updateGroup: 'AT61_UPDATEPR452',
                        nameGroup: 'AT63_NAMEGROU452',
                        cycleNumber: 'AT65_CYCLENEU452',
                        payment: 'AT65_PAYMENTT452',
                        groupAccount: 'AT66_GROUPATO452',
                        otherPlace: 'AT67_OTHERPAC452',
                        titularClient1: 'AT70_TITULAEE452',
                        operation: 'AT71_OPERATIN452',
                        hasLiquidGar: 'AT73_HASLIQIU452',
                        time: 'AT77_TIMEBDBX452',
                        code: 'AT87_CODEJXPZ452',
                        titular1Name: 'AT87_TITULAR1452',
                        hasIndividualAccount: 'AT90_HASINDAT452',
                        officer: 'AT91_OFFICERR452',
                        _pks: [],
                        _entityId: 'EN_GROUPWBWL_452',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Member: {
                        customerId: 'AT13_CUSTOMDE444',
                        qualification: 'AT16_QUALIFCA444',
                        hasIndividualAccountAux: 'AT17_HASINDUC444',
                        membershipDate: 'AT17_MEMBERIT444',
                        points: 'AT19_POINTSIA444',
                        savingVoluntary: 'AT20_SAVINGTY444',
                        groupId: 'AT27_GROUPIDD444',
                        state: 'AT29_STATEVDB444',
                        creditCode: 'AT40_CREDITCE444',
                        role: 'AT43_ROLEQVSE444',
                        riskLevel: 'AT45_RISKLEVE444',
                        qualificationId: 'AT49_QUALIFIN444',
                        secuential: 'AT51_SECUENIT444',
                        roleId: 'AT64_ROLEDPKV444',
                        level: 'AT65_LEVELGWK444',
                        checkRenapo: 'AT66_CHECKRPN444',
                        disconnectionDate: 'AT74_DISCONOI444',
                        ctaIndividual: 'AT77_CTAINDAA444',
                        numberCyclePersonGroup: 'AT85_NUMBERSO444',
                        stateId: 'AT91_STATEIDD444',
                        operation: 'AT92_OPERATIO444',
                        meetingPlace: 'AT94_MEETINAA444',
                        customer: 'AT96_CUSTOMER444',
                        _pks: [],
                        _entityId: 'EN_MEMBERWLM_444',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        channel: 'AT24_CHANNELL800',
                        _pks: [],
                        _entityId: 'EN_CONTEXTVM_800',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_MEMBERZI_7978 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_MEMBERZI_7978 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MEMBERZI_7978_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MEMBERZI_7978_filters;
                    parametersAux = {
                        groupId: filters.groupId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MEMBERWLM_444',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MEMBERZI_7978',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['groupId'] = this.filters.groupId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_MEMBERZI_7978_filters = {};
            $scope.vc.queryProperties.Q_AMOUNTKL_6248 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_AMOUNTKL_6248 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AMOUNTKL_6248_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_AMOUNTKL_6248_filters;
                    parametersAux = {
                        memberId: filters.memberId,
                        safeReport: filters.safeReport
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MONTOSVSY_937',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AMOUNTKL_6248',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['memberId'] = this.filters.memberId;
                            this.parameters['safeReport'] = this.filters.safeReport;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_AMOUNTKL_6248_filters = {};
            var defaultValues = {
                Amount: {},
                Credit: {},
                Group: {},
                Member: {},
                Context: {}
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
                $scope.vc.execute("temporarySave", VC_GROUPCOMOS_387974, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_GROUPCOMOS_387974, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_GROUPCOMOS_387974, data, function() {});
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
            $scope.vc.viewState.VC_GROUPCOMOS_387974 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_GROUPCOMOS_387974",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MANTENIRE_72786",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_TBIRSNCYWS_502974",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: HeaderGroup
            $scope.vc.createViewState({
                id: "VC_COXHZZKDCZ_373728",
                hasId: true,
                componentStyle: [],
                label: 'HeaderGroup',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1894
            $scope.vc.createViewState({
                id: "G_HEADERGUOP_223993",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1894',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_HEADERGUOP_223993-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                channel: $scope.vc.channelDefaultValues("Context", "channel")
            };
            //ViewState - Group: Group1265
            $scope.vc.createViewState({
                id: "G_HEADERGURU_374993",
                hasId: true,
                componentStyle: [],
                label: 'Group1265',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer1270",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PXLAAVTEYF_485974",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GroupForm
            $scope.vc.createViewState({
                id: "VC_MQTFHWQRXJ_599520",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GRUPOSEWT_91429",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Group = {
                hasGroupAccount: $scope.vc.channelDefaultValues("Group", "hasGroupAccount"),
                meetingAddress: $scope.vc.channelDefaultValues("Group", "meetingAddress"),
                nextVisitDate: $scope.vc.channelDefaultValues("Group", "nextVisitDate"),
                state: $scope.vc.channelDefaultValues("Group", "state"),
                titular2Name: $scope.vc.channelDefaultValues("Group", "titular2Name"),
                groupOffice: $scope.vc.channelDefaultValues("Group", "groupOffice"),
                titularClient2: $scope.vc.channelDefaultValues("Group", "titularClient2"),
                userName: $scope.vc.channelDefaultValues("Group", "userName"),
                addressMember: $scope.vc.channelDefaultValues("Group", "addressMember"),
                day: $scope.vc.channelDefaultValues("Group", "day"),
                constitutionDate: $scope.vc.channelDefaultValues("Group", "constitutionDate"),
                updateGroup: $scope.vc.channelDefaultValues("Group", "updateGroup"),
                nameGroup: $scope.vc.channelDefaultValues("Group", "nameGroup"),
                cycleNumber: $scope.vc.channelDefaultValues("Group", "cycleNumber"),
                payment: $scope.vc.channelDefaultValues("Group", "payment"),
                groupAccount: $scope.vc.channelDefaultValues("Group", "groupAccount"),
                otherPlace: $scope.vc.channelDefaultValues("Group", "otherPlace"),
                titularClient1: $scope.vc.channelDefaultValues("Group", "titularClient1"),
                operation: $scope.vc.channelDefaultValues("Group", "operation"),
                hasLiquidGar: $scope.vc.channelDefaultValues("Group", "hasLiquidGar"),
                time: $scope.vc.channelDefaultValues("Group", "time"),
                code: $scope.vc.channelDefaultValues("Group", "code"),
                titular1Name: $scope.vc.channelDefaultValues("Group", "titular1Name"),
                hasIndividualAccount: $scope.vc.channelDefaultValues("Group", "hasIndividualAccount"),
                officer: $scope.vc.channelDefaultValues("Group", "officer")
            };
            //ViewState - Group: Group1369
            $scope.vc.createViewState({
                id: "G_GROUPWKOIS_460725",
                hasId: true,
                componentStyle: [],
                label: 'Group1369',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: code
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGKH_387725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CDIGOBGIA_29707",
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: nameGroup
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQKV_915725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_NOMBREDEL_71895",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: groupOffice
            $scope.vc.createViewState({
                id: "VA_5477JBWRUUXKGYZ_479725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SUCURSALL_92833",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_5477JBWRUUXKGYZ_479725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_5477JBWRUUXKGYZ_479725', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_5477JBWRUUXKGYZ_479725'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_5477JBWRUUXKGYZ_479725");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Group, Attribute: state
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGPY_589725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_ESTADOIKH_14850",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXGPY_589725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXGPY_589725', 'cl_estado_ambito', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXGPY_589725'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXGPY_589725");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Group, Attribute: constitutionDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDBVXWGU_529725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_FECHADEON_20508",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: officer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXNBX_864725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_OFICIALPP_48476",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXNBX_864725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXNBX_864725', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXNBX_864725'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Group, Attribute: addressMember
            $scope.vc.createViewState({
                id: "VA_8723IIAMUFLQPPL_567725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DIRECCIDT_21959",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: otherPlace
            $scope.vc.createViewState({
                id: "VA_9330BRACKQSJMLZ_312725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_OTROLUGAA_91030",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: meetingAddress
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLLT_362725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DIRECCINR_95137",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: hasGroupAccount
            $scope.vc.createViewState({
                id: "VA_9596VHOLMQOEFOI_924725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TIENEUNAL_24954",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: groupAccount
            $scope.vc.createViewState({
                id: "VA_1940KQURTPVEVBJ_839725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CUENTAGPP_81835",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1391",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: titular1Name
            $scope.vc.createViewState({
                id: "VA_5634HKMSQGZFPUQ_212725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TITULAR11_75053",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: titular2Name
            $scope.vc.createViewState({
                id: "VA_4103IWRALHJMDZX_523725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TITULAR22_98361",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2474",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: hasIndividualAccount
            $scope.vc.createViewState({
                id: "VA_1778TBFOWZJSSYZ_913725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TIENECUII_93177",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2815",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2894",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2732",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: day
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPBI_949725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DAREUNINN_57023",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXPBI_949725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXPBI_949725', 'ad_dia_semana', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXPBI_949725'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                        }, {
                            filterType: 'startswith'
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
            //ViewState - Entity: Group, Attribute: time
            $scope.vc.createViewState({
                id: "VA_DATEFIELDPXOFDO_933725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_HORAREUIN_21270",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2498",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: payment
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXEPD_109725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_COMPORTPP_53225",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: cycleNumber
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXRNK_976725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_NRODECIOL_83110",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: hasLiquidGar
            $scope.vc.createViewState({
                id: "VA_HASLIQUIDGARNFF_564725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_USARGARRT_64298",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_HASLIQUIDGARNFF_564725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_HASLIQUIDGARNFF_564725");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONPDPCKGB_382725",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: MemberForm
            $scope.vc.createViewState({
                id: "VC_ZFXQOGVCIH_421740",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_INTEGRANE_36500"
            });
            //ViewState - Group: Group1357
            $scope.vc.createViewState({
                id: "G_MEMBERIDUM_459848",
                hasId: true,
                componentStyle: [],
                label: 'Group1357',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Member = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "secuential", 0),
                        validation: {
                            secuentialRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "customerId", 0),
                        validation: {
                            customerIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    customer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "customer", '')
                    },
                    role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "role", '')
                    },
                    checkRenapo: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "checkRenapo", '')
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "state", '')
                    },
                    qualification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "qualification", '')
                    },
                    savingVoluntary: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "savingVoluntary", 0)
                    },
                    meetingPlace: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "meetingPlace", '')
                    },
                    qualificationId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "qualificationId", ''),
                        validation: {
                            qualificationIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    riskLevel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "riskLevel", '')
                    },
                    groupId: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Member = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_MEMBERZI_7978';
                            var queryRequest = $scope.vc.getRequestQuery_Q_MEMBERZI_7978();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7978_25243',
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Member',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7978_25243', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Member
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7978_25243").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MEMBERZI_7978 = $scope.vc.model.Member;
            $scope.vc.trackers.Member = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Member);
            $scope.vc.model.Member.bind('change', function(e) {
                $scope.vc.trackers.Member.track(e);
            });
            $scope.vc.grids.QV_7978_25243 = {};
            $scope.vc.grids.QV_7978_25243.queryId = 'Q_MEMBERZI_7978';
            $scope.vc.viewState.QV_7978_25243 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7978_25243.column = {};
            $scope.vc.grids.QV_7978_25243.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_7978_25243.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.Member(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "LOANS",
                        subModuleId: "GROUP",
                        taskId: "T_MEMBERQZIZWFM_852",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MEMBERLFPC_722852',
                        title: 'LOANS.LBL_LOANS_INTEGRANE_36500',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7978_25243", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
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
                        moduleId: "LOANS",
                        subModuleId: "GROUP",
                        taskId: "T_MEMBERQZIZWFM_852",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MEMBERLFPC_722852',
                        title: 'LOANS.LBL_LOANS_INTEGRANE_36500',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7978_25243", dialogParameters);
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'Member',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_7978_25243", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7978_25243");
                    $scope.vc.hideShowColumns("QV_7978_25243", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7978_25243.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7978_25243.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7978_25243.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7978_25243 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7978_25243 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7978_25243.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7978_25243.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7978_25243.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7978_25243.column.secuential = {
                title: 'LOANS.LBL_LOANS_SECUENCII_16384',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXJUD_372848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.customerId = {
                title: 'LOANS.LBL_LOANS_IDCLIENEE_21093',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXUBZ_786848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.customer = {
                title: 'LOANS.LBL_LOANS_CLIENTEMZ_77659',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUEX_348848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.role = {
                title: 'LOANS.LBL_LOANS_ROLOSKZGW_63791',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHNF_499848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.checkRenapo = {
                title: 'LOANS.LBL_LOANS_RENAPOBAV_65578',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEYR_376848',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXEYR_376848 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXEYR_376848',
                            'cl_respuesta_renapo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXEYR_376848'];
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
            $scope.vc.viewState.QV_7978_25243.column.state = {
                title: 'LOANS.LBL_LOANS_ESTADOIKH_14850',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTLH_430848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.qualification = {
                title: 'LOANS.LBL_LOANS_NIVELDERI_38662',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXIW_997848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.savingVoluntary = {
                title: 'savingVoluntary',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFSC_118848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.meetingPlace = {
                title: 'meetingPlace',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJPQ_319848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.qualificationId = {
                title: 'LOANS.LBL_LOANS_BURCRDIOT_58082',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXNGX_485848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.riskLevel = {
                title: 'LOANS.LBL_LOANS_NIVELRIGS_61993',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCGW_716848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_7978_25243.column.secuential.title|translate:vc.viewState.QV_7978_25243.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.secuential.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.secuential.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.secuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_7978_25243\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_7978_25243.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7978_25243.column.secuential.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_7978_25243.column.customerId.title|translate:vc.viewState.QV_7978_25243.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.customerId.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.customerId.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_7978_25243\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_7978_25243.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7978_25243.column.customerId.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'customer',
                    title: '{{vc.viewState.QV_7978_25243.column.customer.title|translate:vc.viewState.QV_7978_25243.column.customer.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.customer.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.customer.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.customer.style' ng-bind='vc.getStringColumnFormat(dataItem.customer, \"QV_7978_25243\", \"customer\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.customer.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.customer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.customer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'role',
                    title: '{{vc.viewState.QV_7978_25243.column.role.title|translate:vc.viewState.QV_7978_25243.column.role.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.role.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.role.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.role.style' ng-bind='vc.getStringColumnFormat(dataItem.role, \"QV_7978_25243\", \"role\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.role.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'checkRenapo',
                    title: '{{vc.viewState.QV_7978_25243.column.checkRenapo.title|translate:vc.viewState.QV_7978_25243.column.checkRenapo.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.checkRenapo.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.checkRenapo.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.checkRenapo.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXEYR_376848.get(dataItem.checkRenapo).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.checkRenapo.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.checkRenapo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.checkRenapo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_7978_25243.column.state.title|translate:vc.viewState.QV_7978_25243.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.state.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.state.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_7978_25243\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.state.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'qualification',
                    title: '{{vc.viewState.QV_7978_25243.column.qualification.title|translate:vc.viewState.QV_7978_25243.column.qualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.qualification.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.qualification.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.qualification.style' ng-bind='vc.getStringColumnFormat(dataItem.qualification, \"QV_7978_25243\", \"qualification\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.qualification.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.qualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.qualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'savingVoluntary',
                    title: '{{vc.viewState.QV_7978_25243.column.savingVoluntary.title|translate:vc.viewState.QV_7978_25243.column.savingVoluntary.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.savingVoluntary.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.savingVoluntary.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.savingVoluntary.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.savingVoluntary, \"QV_7978_25243\", \"savingVoluntary\"):kendo.toString(#=savingVoluntary#, vc.viewState.QV_7978_25243.column.savingVoluntary.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7978_25243.column.savingVoluntary.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.savingVoluntary.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.savingVoluntary.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'meetingPlace',
                    title: '{{vc.viewState.QV_7978_25243.column.meetingPlace.title|translate:vc.viewState.QV_7978_25243.column.meetingPlace.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.meetingPlace.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.meetingPlace.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.meetingPlace.style' ng-bind='vc.getStringColumnFormat(dataItem.meetingPlace, \"QV_7978_25243\", \"meetingPlace\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.meetingPlace.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.meetingPlace.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.meetingPlace.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'qualificationId',
                    title: '{{vc.viewState.QV_7978_25243.column.qualificationId.title|translate:vc.viewState.QV_7978_25243.column.qualificationId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.qualificationId.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.qualificationId.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.qualificationId.style' ng-bind='vc.getStringColumnFormat(dataItem.qualificationId, \"QV_7978_25243\", \"qualificationId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.qualificationId.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.qualificationId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.qualificationId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'riskLevel',
                    title: '{{vc.viewState.QV_7978_25243.column.riskLevel.title|translate:vc.viewState.QV_7978_25243.column.riskLevel.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.riskLevel.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.riskLevel.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.riskLevel.style' ng-bind='vc.getStringColumnFormat(dataItem.riskLevel, \"QV_7978_25243\", \"riskLevel\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.riskLevel.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.riskLevel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.riskLevel.hidden
                });
            }
            $scope.vc.viewState.QV_7978_25243.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.cmdEdition = {};
            $scope.vc.viewState.QV_7978_25243.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7978_25243.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Member",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_7978_25243.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7978_25243.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_MEMBERIDUM_459848.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customEdit($event, \"#:entity#\", grids.QV_7978_25243)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_7978_25243.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7978_25243.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_MEMBERIDUM_459848.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7978_25243.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848 = {
                    tooltip: '',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848)) {
                    $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848 = {};
                }
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.hidden = false;
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'VA_GRIDROWCOMMMAAA_212848',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMAAA_212848",
                        entity: "Member",
                        text: "{{'LOANS.LBL_LOANS_RELACINBA_97272'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmaaa':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMAAA_212848\", " + "vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.enabled || vc.viewState.G_MEMBERIDUM_459848.disabled' " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customRowClick($event, \"VA_GRIDROWCOMMMAAA_212848\", \"#:entity#\", \"QV_7978_25243\")' " + "title = \"{{vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.tooltip|translate}}\" " + "href = '\\#'>" + "#: text #" + "</a>"
                    },
                    width: 150,
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848 = {
                    tooltip: '',
                    imageId: 'fa fa-search',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848)) {
                    $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848 = {};
                }
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.hidden = false;
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'VA_GRIDROWCOMMMNNA_977848',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNNA_977848",
                        entity: "Member",
                        text: "{{'LOANS.LBL_LOANS_LUPABHFLY_45644'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'cb-btn-custom-vagridrowcommmnna':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNNA_977848\", " + "vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.enabled || vc.viewState.G_MEMBERIDUM_459848.disabled' " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customRowClick($event, \"VA_GRIDROWCOMMMNNA_977848\", \"#:entity#\", \"QV_7978_25243\")' " + "title = \"{{vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.imageId'></span>" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.hidden
                });
            }
            $scope.vc.viewState.QV_7978_25243.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_7978_25243.toolbar = [{
                "name": "create",
                "entity": "Member",
                "text": "",
                "template": "<button id = 'QV_7978_25243_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_7978_25243.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_MEMBERIDUM_459848.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }]; //ViewState - Container: AmountForm
            $scope.vc.createViewState({
                id: "VC_GKVZJPXOPE_499678",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MONTOSHZR_10878",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1285
            $scope.vc.createViewState({
                id: "G_AMOUNTGUDN_676190",
                hasId: true,
                componentStyle: [],
                label: 'Group1285',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Amount = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "secuential", 0)
                    },
                    cycleParticipation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "cycleParticipation", '')
                    },
                    memberName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "memberName", '')
                    },
                    oldOperation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "oldOperation", '')
                    },
                    oldBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "oldBalance", 0)
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "amount", 0)
                    },
                    resultAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "resultAmount", 0)
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "groupId", 0)
                    },
                    credit: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "credit", 0)
                    },
                    authorizedAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "authorizedAmount", 0)
                    },
                    voluntarySavings: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "voluntarySavings", 0)
                    },
                    proposedMaximumSaving: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "proposedMaximumSaving", 0)
                    },
                    increment: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "increment", 0)
                    },
                    creditBureau: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "creditBureau", '')
                    },
                    riskLevel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "riskLevel", '')
                    },
                    checkRenapo: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "checkRenapo", '')
                    },
                    safePackage: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "safePackage", '')
                    },
                    safeReport: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "safeReport", '')
                    },
                    memberId: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Amount = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_AMOUNTKL_6248';
                            var queryRequest = $scope.vc.getRequestQuery_Q_AMOUNTKL_6248();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6248_19660',
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
                    model: $scope.vc.types.Amount
                },
                aggregate: [{
                    field: "oldBalance",
                    aggregate: "sum"
                }, {
                    field: "amount",
                    aggregate: "sum"
                }, {
                    field: "authorizedAmount",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6248_19660").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AMOUNTKL_6248 = $scope.vc.model.Amount;
            $scope.vc.trackers.Amount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Amount);
            $scope.vc.model.Amount.bind('change', function(e) {
                $scope.vc.trackers.Amount.track(e);
            });
            $scope.vc.grids.QV_6248_19660 = {};
            $scope.vc.grids.QV_6248_19660.queryId = 'Q_AMOUNTKL_6248';
            $scope.vc.viewState.QV_6248_19660 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6248_19660.column = {};
            $scope.vc.grids.QV_6248_19660.editable = false;
            $scope.vc.grids.QV_6248_19660.events = {
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
                    $scope.vc.trackers.Amount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6248_19660.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6248_19660");
                    $scope.vc.hideShowColumns("QV_6248_19660", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6248_19660.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6248_19660.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6248_19660.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6248_19660 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6248_19660 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6248_19660.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6248_19660.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6248_19660.column.secuential = {
                title: 'LOANS.LBL_LOANS_SECUENCLL_73798',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEIC_598190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT52_SECUENIA937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.secuential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEIC_598190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.secuential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.secuential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.cycleParticipation = {
                title: 'LOANS.LBL_LOANS_PARTICIAA_71360',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVGT_319190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT31_CYCLEPCN937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.cycleParticipation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVGT_319190",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.cycleParticipation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.cycleParticipation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.memberName = {
                title: 'LOANS.LBL_LOANS_CLIENTEMZ_77659',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSTP_229190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT62_MEMBERNN937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.memberName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSTP_229190",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.memberName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.memberName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.oldOperation = {
                title: 'LOANS.LBL_LOANS_OPERACINE_31340',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEGC_307190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT73_OLDOPENI937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.oldOperation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEGC_307190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.oldOperation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.oldOperation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.oldBalance = {
                title: 'LOANS.LBL_LOANS_SALDOOPIC_42293',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZJX_828190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT96_OLDBALCC937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.oldBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZJX_828190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.oldBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.oldBalance.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.oldBalance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.oldBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.amount = {
                title: 'LOANS.LBL_LOANS_MONTOSOOI_45840',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSRP_129190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT51_AMOUNTUQ937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSRP_129190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.amount.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.amount.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.resultAmount = {
                title: 'LOANS.LBL_LOANS_MONTOREDA_17914',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCZP_884190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT58_RESULTNN937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.resultAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCZP_884190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.resultAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.resultAmount.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.resultAmount.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.resultAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWOA_550190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT70_GROUPIDD937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWOA_550190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.credit = {
                title: 'credit',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYGF_110190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT83_CREDITGM937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.credit.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYGF_110190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.credit.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.credit.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.credit.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.credit.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.authorizedAmount = {
                title: 'LOANS.LBL_LOANS_MONTOAURO_71217',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLEH_921190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT29_AUTHORZE937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.authorizedAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLEH_921190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.authorizedAmount.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.authorizedAmount.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.authorizedAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.voluntarySavings = {
                title: 'LOANS.LBL_LOANS_AHORROVOA_67689',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUPR_288190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT36_VOLUNTNI937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.voluntarySavings.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUPR_288190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.voluntarySavings.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.voluntarySavings.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.voluntarySavings.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving = {
                title: 'LOANS.LBL_LOANS_MONTOMXOT_70313',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWXN_691190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT92_PROPOSNG937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.proposedMaximumSaving.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWXN_691190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.increment = {
                title: 'LOANS.LBL_LOANS_INCREMEOO_12075',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAFW_332190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT41_INCREMTT937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.increment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAFW_332190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.increment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.increment.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.increment.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.increment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.creditBureau = {
                title: 'LOANS.LBL_LOANS_NIVELDERI_38662',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGCR_987190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT31_CREDITER937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.creditBureau.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGCR_987190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.creditBureau.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.creditBureau.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.riskLevel = {
                title: 'LOANS.LBL_LOANS_NIVELDERI_38662',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNPT_791190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT66_RISKLEVV937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.riskLevel.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNPT_791190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.riskLevel.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.riskLevel.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.checkRenapo = {
                title: 'checkRenapo',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBIK_156190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT69_CHECKREP937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.checkRenapo.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBIK_156190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.checkRenapo.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.checkRenapo.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.safePackage = {
                title: 'LOANS.LBL_LOANS_PAQUETEGU_42007',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYVS_120190',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXYVS_120190 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXYVS_120190', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXYVS_120190'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
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
            $scope.vc.grids.QV_6248_19660.AT91_SAFEPACA937 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.safePackage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYVS_120190",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_6248_19660.column.safePackage.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXYVS_120190",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_6248_19660.column.safePackage.template",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.safePackage.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.safeReport = {
                title: 'safeReport',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHQM_979190',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXHQM_979190 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_6248_19660.AT71_SAFERERR937 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.safeReport.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHQM_979190",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_6248_19660.column.safeReport.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXHQM_979190",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_6248_19660.column.safeReport.template",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.safeReport.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.memberId = {
                title: 'memberId',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_6248_19660.column.secuential.title|translate:vc.viewState.QV_6248_19660.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.secuential.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.secuential.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT52_SECUENIA937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.secuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_6248_19660\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_6248_19660.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.secuential.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'cycleParticipation',
                    title: '{{vc.viewState.QV_6248_19660.column.cycleParticipation.title|translate:vc.viewState.QV_6248_19660.column.cycleParticipation.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.cycleParticipation.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.cycleParticipation.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT31_CYCLEPCN937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.cycleParticipation.style' ng-bind='vc.getStringColumnFormat(dataItem.cycleParticipation, \"QV_6248_19660\", \"cycleParticipation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.cycleParticipation.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.cycleParticipation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.cycleParticipation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'memberName',
                    title: '{{vc.viewState.QV_6248_19660.column.memberName.title|translate:vc.viewState.QV_6248_19660.column.memberName.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.memberName.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.memberName.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT62_MEMBERNN937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.memberName.style' ng-bind='vc.getStringColumnFormat(dataItem.memberName, \"QV_6248_19660\", \"memberName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.memberName.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.memberName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.memberName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'oldOperation',
                    title: '{{vc.viewState.QV_6248_19660.column.oldOperation.title|translate:vc.viewState.QV_6248_19660.column.oldOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.oldOperation.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.oldOperation.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT73_OLDOPENI937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.oldOperation.style' ng-bind='vc.getStringColumnFormat(dataItem.oldOperation, \"QV_6248_19660\", \"oldOperation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.oldOperation.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.oldOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.oldOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'oldBalance',
                    title: '{{vc.viewState.QV_6248_19660.column.oldBalance.title|translate:vc.viewState.QV_6248_19660.column.oldBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.oldBalance.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.oldBalance.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT96_OLDBALCC937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.oldBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.oldBalance, \"QV_6248_19660\", \"oldBalance\"):kendo.toString(#=oldBalance#, vc.viewState.QV_6248_19660.column.oldBalance.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.oldBalance.sum, $scope.vc.viewState.QV_6248_19660.column.oldBalance.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.oldBalance.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.oldBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.oldBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_6248_19660.column.amount.title|translate:vc.viewState.QV_6248_19660.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.amount.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.amount.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'amount', $scope.vc.grids.QV_6248_19660.AT51_AMOUNTUQ937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'amount', "<span ng-class='vc.viewState.QV_6248_19660.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_6248_19660\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_6248_19660.column.amount.format)'></span>"),
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.amount.sum, $scope.vc.viewState.QV_6248_19660.column.amount.format);
                        return "<div class='' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.amount.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'resultAmount',
                    title: '{{vc.viewState.QV_6248_19660.column.resultAmount.title|translate:vc.viewState.QV_6248_19660.column.resultAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.resultAmount.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.resultAmount.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT58_RESULTNN937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.resultAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.resultAmount, \"QV_6248_19660\", \"resultAmount\"):kendo.toString(#=resultAmount#, vc.viewState.QV_6248_19660.column.resultAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.resultAmount.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.resultAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.resultAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_6248_19660.column.groupId.title|translate:vc.viewState.QV_6248_19660.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.groupId.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.groupId.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT70_GROUPIDD937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_6248_19660\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_6248_19660.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.groupId.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'credit',
                    title: '{{vc.viewState.QV_6248_19660.column.credit.title|translate:vc.viewState.QV_6248_19660.column.credit.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.credit.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.credit.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT83_CREDITGM937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.credit.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.credit, \"QV_6248_19660\", \"credit\"):kendo.toString(#=credit#, vc.viewState.QV_6248_19660.column.credit.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.credit.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.credit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.credit.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'authorizedAmount',
                    title: '{{vc.viewState.QV_6248_19660.column.authorizedAmount.title|translate:vc.viewState.QV_6248_19660.column.authorizedAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'authorizedAmount', $scope.vc.grids.QV_6248_19660.AT29_AUTHORZE937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'authorizedAmount', "<span ng-class='vc.viewState.QV_6248_19660.column.authorizedAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.authorizedAmount, \"QV_6248_19660\", \"authorizedAmount\"):kendo.toString(#=authorizedAmount#, vc.viewState.QV_6248_19660.column.authorizedAmount.format)'></span>"),
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.authorizedAmount.sum, $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.format);
                        return "<div class='' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.authorizedAmount.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.authorizedAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'voluntarySavings',
                    title: '{{vc.viewState.QV_6248_19660.column.voluntarySavings.title|translate:vc.viewState.QV_6248_19660.column.voluntarySavings.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.voluntarySavings.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.voluntarySavings.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'voluntarySavings', $scope.vc.grids.QV_6248_19660.AT36_VOLUNTNI937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'voluntarySavings', "<span ng-class='vc.viewState.QV_6248_19660.column.voluntarySavings.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.voluntarySavings, \"QV_6248_19660\", \"voluntarySavings\"):kendo.toString(#=voluntarySavings#, vc.viewState.QV_6248_19660.column.voluntarySavings.format)'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.voluntarySavings.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.voluntarySavings.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.voluntarySavings.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'proposedMaximumSaving',
                    title: '{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.title|translate:vc.viewState.QV_6248_19660.column.proposedMaximumSaving.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'proposedMaximumSaving', $scope.vc.grids.QV_6248_19660.AT92_PROPOSNG937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'proposedMaximumSaving', "<span ng-class='vc.viewState.QV_6248_19660.column.proposedMaximumSaving.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.proposedMaximumSaving, \"QV_6248_19660\", \"proposedMaximumSaving\"):kendo.toString(#=proposedMaximumSaving#, vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format)'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'increment',
                    title: '{{vc.viewState.QV_6248_19660.column.increment.title|translate:vc.viewState.QV_6248_19660.column.increment.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.increment.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.increment.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'increment', $scope.vc.grids.QV_6248_19660.AT41_INCREMTT937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'increment', "<span ng-class='vc.viewState.QV_6248_19660.column.increment.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.increment, \"QV_6248_19660\", \"increment\"):kendo.toString(#=increment#, vc.viewState.QV_6248_19660.column.increment.format)'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.increment.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.increment.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.increment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'creditBureau',
                    title: '{{vc.viewState.QV_6248_19660.column.creditBureau.title|translate:vc.viewState.QV_6248_19660.column.creditBureau.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.creditBureau.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.creditBureau.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'creditBureau', $scope.vc.grids.QV_6248_19660.AT31_CREDITER937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'creditBureau', "<span ng-class='vc.viewState.QV_6248_19660.column.creditBureau.style' ng-bind='vc.getStringColumnFormat(dataItem.creditBureau, \"QV_6248_19660\", \"creditBureau\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.creditBureau.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.creditBureau.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.creditBureau.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'riskLevel',
                    title: '{{vc.viewState.QV_6248_19660.column.riskLevel.title|translate:vc.viewState.QV_6248_19660.column.riskLevel.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.riskLevel.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.riskLevel.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'riskLevel', $scope.vc.grids.QV_6248_19660.AT66_RISKLEVV937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'riskLevel', "<span ng-class='vc.viewState.QV_6248_19660.column.riskLevel.style' ng-bind='vc.getStringColumnFormat(dataItem.riskLevel, \"QV_6248_19660\", \"riskLevel\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.riskLevel.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.riskLevel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.riskLevel.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'checkRenapo',
                    title: '{{vc.viewState.QV_6248_19660.column.checkRenapo.title|translate:vc.viewState.QV_6248_19660.column.checkRenapo.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.checkRenapo.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.checkRenapo.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT69_CHECKREP937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.checkRenapo.style' ng-bind='vc.getStringColumnFormat(dataItem.checkRenapo, \"QV_6248_19660\", \"checkRenapo\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.checkRenapo.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.checkRenapo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.checkRenapo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'safePackage',
                    title: '{{vc.viewState.QV_6248_19660.column.safePackage.title|translate:vc.viewState.QV_6248_19660.column.safePackage.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.safePackage.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.safePackage.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'safePackage', $scope.vc.grids.QV_6248_19660.AT91_SAFEPACA937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'safePackage', "<span ng-class='vc.viewState.QV_6248_19660.column.safePackage.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXYVS_120190.get(dataItem.safePackage).value'> </span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.safePackage.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.safePackage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.safePackage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'safeReport',
                    title: '{{vc.viewState.QV_6248_19660.column.safeReport.title|translate:vc.viewState.QV_6248_19660.column.safeReport.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.safeReport.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.safeReport.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT71_SAFERERR937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.safeReport.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXHQM_979190.get(dataItem.safeReport).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.safeReport.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.safeReport.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.safeReport.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190 = {
                    tooltip: '',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190)) {
                    $scope.vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190 = {};
                }
                $scope.vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190.hidden = false;
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'VA_GRIDROWCOMMMDAD_387190',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMDAD_387190",
                        entity: "Amount",
                        text: "{{'LOANS.LBL_LOANS_DETALLEAA_16727'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmdad':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMDAD_387190\", " + "vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190.enabled || vc.viewState.G_AMOUNTGUDN_676190.disabled' " + "data-ng-click = 'vc.grids.QV_6248_19660.events.customRowClick($event, \"VA_GRIDROWCOMMMDAD_387190\", \"#:entity#\", \"QV_6248_19660\")' " + "title = \"{{vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190.tooltip|translate}}\" " + "href = '\\#'>" + "#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.VA_GRIDROWCOMMMDAD_387190.hidden
                });
            }
            $scope.vc.viewState.QV_6248_19660.toolbar = {}
            $scope.vc.grids.QV_6248_19660.toolbar = [];
            $scope.vc.model.Credit = {
                office: $scope.vc.channelDefaultValues("Credit", "office"),
                subtype: $scope.vc.channelDefaultValues("Credit", "subtype"),
                linked: $scope.vc.channelDefaultValues("Credit", "linked"),
                term: $scope.vc.channelDefaultValues("Credit", "term"),
                category: $scope.vc.channelDefaultValues("Credit", "category"),
                businessSector: $scope.vc.channelDefaultValues("Credit", "businessSector"),
                officeName: $scope.vc.channelDefaultValues("Credit", "officeName"),
                operationNumber: $scope.vc.channelDefaultValues("Credit", "operationNumber"),
                customerId: $scope.vc.channelDefaultValues("Credit", "customerId"),
                isRenovation: $scope.vc.channelDefaultValues("Credit", "isRenovation"),
                applicationNumber: $scope.vc.channelDefaultValues("Credit", "applicationNumber"),
                approvedAmount: $scope.vc.channelDefaultValues("Credit", "approvedAmount"),
                nemonicCurrency: $scope.vc.channelDefaultValues("Credit", "nemonicCurrency"),
                nameActivity: $scope.vc.channelDefaultValues("Credit", "nameActivity"),
                percentageWarranty: $scope.vc.channelDefaultValues("Credit", "percentageWarranty"),
                paymentFrecuencyName: $scope.vc.channelDefaultValues("Credit", "paymentFrecuencyName"),
                creditCode: $scope.vc.channelDefaultValues("Credit", "creditCode"),
                productType: $scope.vc.channelDefaultValues("Credit", "productType"),
                amountRequested: $scope.vc.channelDefaultValues("Credit", "amountRequested"),
                warrantyAmount: $scope.vc.channelDefaultValues("Credit", "warrantyAmount"),
                paymentFrecuency: $scope.vc.channelDefaultValues("Credit", "paymentFrecuency")
            };
            //ViewState - Group: Group1180
            $scope.vc.createViewState({
                id: "G_AMOUNTIXUH_522190",
                hasId: true,
                componentStyle: [],
                label: 'Group1180',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Credit, Attribute: creditCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXZSH_356190",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONNPVXIJW_123190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GUARDARLI_67841",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONAICSAKZ_975190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_RBUREOYXZ_41352",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Credit, Attribute: warrantyAmount
            $scope.vc.createViewState({
                id: "VA_WARRANTYAMOUNTN_792190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MONTOGATN_84974",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONGPPUIHN_830190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SINCRONVZ_73628",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_GROUPCOMPOIET_974_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_GROUPCOMPOIET_974_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TGROUPCO_IRO",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GUARDARLI_67841",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_TGROUPCO_2A7",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SINCRONMZ_54211",
                enabled: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TGROUPCO_62P",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_REGISTRST_98098",
                enabled: designer.constants.mode.All
            });
            //ViewState - Command: Command4
            $scope.vc.createViewState({
                id: "CM_TGROUPCO_O3P",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SINCRONMZ_54211",
                enabled: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXEYR_376848.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXYVS_120190.read();
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
                $scope.vc.render('VC_GROUPCOMOS_387974');
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
    var cobisMainModule = cobis.createModule("VC_GROUPCOMOS_387974", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_GROUPCOMOS_387974", {
            templateUrl: "VC_GROUPCOMOS_387974_FORM.html",
            controller: "VC_GROUPCOMOS_387974_CTRL",
            labelId: "LOANS.LBL_LOANS_MANTENIRE_72786",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_GROUPCOMOS_387974?" + $.param(search);
            }
        });
        VC_GROUPCOMOS_387974(cobisMainModule);
    }]);
} else {
    VC_GROUPCOMOS_387974(cobisMainModule);
}