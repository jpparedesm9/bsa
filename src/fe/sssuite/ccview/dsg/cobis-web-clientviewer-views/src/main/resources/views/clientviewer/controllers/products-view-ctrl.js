(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER,'angular.filter']);
	
	

    app.controller('clientviewer.productsViewController', ['$scope',
   '$rootScope', '$filter', 'clientviewer.consolidatePositionService', 'clientviewer.queryClientViewerService',
      function ($scope, $rootScope, $filter, consolidatePositionService) {

            var scope = $rootScope;
            $scope.mainGridLoans = {};
            $scope.detailLoans = {};
            $scope.mainGridOverdrafts = {};
            $scope.detailOverdrafts = {};
            $scope.mainGridCurrentAccounts = {};
            $scope.detailCurrentAccounts = {};
            $scope.mainGridFixedTerms = {};
            $scope.detailFixedTerms = {};
            $scope.mainGridWarranties = {};
            $scope.detailWarranties = {};
            $scope.mainGridPromissoryNotes = {};
            $scope.detailPromissoryNotes = {};
            $scope.mainGridInsurancePolicy = {};
            $scope.detailInsurancePolicy = {};
            $scope.mainGridCredits = {};
            $scope.detailCredits = {};
            $scope.mainGridContingencies = {};
            $scope.detailContingencies = {};
            $scope.mainGridSavingAccounts = {};
            $scope.detailSavingAccounts = {};
            $scope.mainGridIndirectPortfolio = {};
            $scope.detailIndirectPortfolio = {};
            $scope.mainGridOthers = {};
            $scope.detailOthers = {};
            $scope.mainGridApplicationLoans = {};
            $scope.detailApplicationLoans = {};
            $scope.mainGridCreditPendings = {};
            $scope.detailCreditPendings = {};
            $scope.mainGridPendingGuarantees = {};
            $scope.detailPendingGuarantees = {};
            $scope.mainGridPromissoryNotePending = {};
            $scope.detailPromissoryNotePending = {};
            $scope.mainGridOtherComext = {};
            $scope.detailOtherComext = {};
            $scope.processes = {};
            $scope.detailOverdraftsMenu = [];
            $scope.dataSources = {};

            $scope.totales = $rootScope.totales;


            $scope.bankingProduct = function () {

                
            };

            $scope.bankingProduct();

            scope.$watch('typesOverdrafts', function (newValue, oldValue) {

                var newValueTemp = [];

                angular.forEach(newValue, function (value) {

                    if (newValueTemp.length == 0) {
                        newValueTemp.push(value)
                    } else {

                        var insert = true;

                        angular.forEach(newValueTemp, function (value2) {

                            if (value2.descriptionType == value.descriptionType && value2.product == value.product) {
                                insert = false;
                            }

                        });

                        if (insert) {
                            newValueTemp.push(value);
                        }
                    }

                });

                $scope.mainGridOverdrafts = {
                    dataSource: {
                        data: newValueTemp
                    },
                    detailTemplate: kendo.template($('#templateOverdrafts').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'descriptionType',
                            width: '900px'
                        }
                          ]
                };


                $scope.detailOverdrafts = function (dataItem) {

                    return {
                        dataSource: {
                            data: $rootScope.overdrafts.transport.data
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=product#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'numberOperation',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currencyDescription',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '130px'
                            },
                            {
                                field: 'usedAmount',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '130px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'rate',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RATE'),
                                width: '130px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'amountRisk',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RISK_ML'),
                                width: '130px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
                              ]
                    };
                };


            });

            scope.$watch('typesIndirectPortfolio', function (newValue, oldValue) {

                $scope.mainGridIndirectPortfolio = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateIndirectPortfolio').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'productDesc',
                            width: '900px'
                        }
                          ]
                };
                $scope.detailIndirectPortfolio = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.indirectPortfolio.transport.data,
                            filter: {
                                field: 'operationType',
                                operator: 'eq',
                                value: dataItem.operationType
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=operationType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'operation',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currencyDesc',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'amountOrigin',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'amountCapital',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_DISP'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'amountLosing',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_DISP_AMOUNT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'amountMl',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RISK_ML'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
                              ]
                    };
                };

            });

            scope.$watch('typesOtherComext', function (newValue, oldValue) {

                $scope.mainGridOtherComext = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateOtherComext').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'operationTypeDescription',
                            width: '900px'
                        }
                   ]
                };
                $scope.detailOtherComext = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.otherComext.transport.data,
                            filter: {
                                field: 'operationType',
                                operator: 'eq',
                                value: dataItem.operationType
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=operationType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'numberOperation',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPERATION'),
                                width: '200px'
                            }, //pendiente
                            {
                                field: 'currencyDesc',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '130px'
                            }, //pendiente
                            {
                                field: 'amount',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '100px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }, //pendiente
                            {
                                field: 'beneficiary',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BENEFICIARY'),
                                width: '150px'
                            },
                            {
                                field: 'amountML',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RISK_ML'),
                                width: '100px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
                       ]
                    };
                };
            });

            scope.$watch('typesApplicationLoans', function (newValue, oldValue) {

                $scope.mainGridApplicationLoans = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateApplicationLoans').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'productDesc',
                            width: '900px'
                        }

                ]
                };
                $scope.detailApplicationLoans = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.applicationLoans.transport.data,
                            filter: {
                                field: 'operationType',
                                operator: 'eq',
                                value: dataItem.operationType
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=operationType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'dateApt',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPERATION'),
                                width: '150px'
                            },
                            {
                                field: 'currencyDesc',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'stateConta',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_STATUS'),
                                width: '100px'
                            },
                            {
                                field: 'amountCapital',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
                    ]
                    };
                };
            });

            scope.$watch('typesCreditPendings', function (newValue, oldValue) {

                $scope.mainGridCreditPendings = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateCreditPendings').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'opTypeDescription',
                            width: '900px'
                        }

             ]
                };
                $scope.detailCreditPendings = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.creditPendings.transport.data,
                            filter: {
                                field: 'opTypeDescription',
                                operator: 'eq',
                                value: dataItem.opTypeDescription
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=product#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'openingDate',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPENING_DATE'),
                                width: '100px'
                            },
                            {
                                field: 'currencyDescription',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '100px'
                            },
                            {
                                field: 'status',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_STATUS'),
                                width: '100px'
                            },
                            {
                                field: 'available',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_DISP'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'limitApproved',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'riskAmount',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RISK_ML'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
                 ]
                    };
                };
            });

            scope.$watch('typesPendingGuarantees', function (newValue, oldValue) {

                $scope.mainGridPendingGuarantees = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templatePendingGuarantees').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'warrantyDescription',
                            width: '900px'
                        }
           ]
                };
                $scope.detailPendingGuarantees = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.pendingGuarantees.transport.data,
                            filter: {
                                field: 'warrantyType',
                                operator: 'eq',
                                value: dataItem.warrantyType
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=warrantyType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'code',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currency',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'actualValue',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_ACTUAL_VALUE'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'MRC',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_POR_MRC'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
               ]
                    };
                };

            });

            scope.$watch('typesPromissoryNotePending', function (newValue, oldValue) {

                $scope.mainGridPromissoryNotePending = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templatePromissoryNotePending').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'warrantyDescription',
                            width: '900px'
                        }

           ]
                };
                $scope.detailPromissoryNotePending = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.promissoryNotePending.transport.data,
                            filter: [{
                                field: 'warrantyType',
                                operator: 'eq',
                                value: dataItem.warrantyType
                            }, {
                                field: 'state',
                                operator: 'neq',
                                value: ''
                            }]
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=type_operation#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'code',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currency',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'actualValue',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_ACTUAL_VALUE'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'state',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_STATUS'),
                                width: '150px'
                            }
               ]
                    };
                };

            });

            scope.$watch('typesOthers', function (newValue, oldValue) {

                $scope.mainGridOthers = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateOthers').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'entity',
                            width: '900px'
                        }

           ]
                };
                $scope.detailOthers = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.others.transport.data,
                            filter: {
                                field: 'login',
                                operator: 'eq',
                                value: dataItem.login
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                /*
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\' style=\'z-index:1000\' role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\" style=\"overflow:inherit;\"><div ng-repeat=\"process in processes\"><div ng-repeat=\"proc in process.processes\"><li><a ng-click = "rootProcessClick(  process  , proc.flowId)">{{proc.processName}}</a></li></div></div></ul></li></ul></div>',*/
                                width: '50px'
                },
                            {
                                field: 'affiliateDate',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPENING_DATE'),
                                width: '100px'
                            },
                            {
                                field: 'profile',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '100px'
                            },
                            {
                                field: 'stateRegistry',
                                title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DESCRIPTION'),
                                width: '100px'
                            }
               ]
                    };
                };
            });

            scope.$watch('typesCurrentAccounts', function (newValue, oldValue) {

                $scope.mainGridCurrentAccounts = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateCurrentAccounts').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'product',
                            width: '900px'
                        }

                          ]
                };
                $scope.detailCurrentAccounts = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.currentAccounts.transport.data,
                            filter: {
                                field: 'typeDescription',
                                operator: 'eq',
                                value: dataItem.typeDescription
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=product#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'operationNumber',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currencyDescription',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'openingDate',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPENING_DATE'),
                                width: '100px'
                            },
                            {
                                field: 'balance',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_CONT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'available',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_DISP'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
                     ]
                    };
                };

            });

            scope.$watch('typesLoans', function (newValue, oldValue) {

                $scope.mainGridLoans = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateLoans').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'operationTypeDesc',
                            width: '900px'
                        }

                ]
                };
                $scope.detailLoans = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.loans.transport.data,
                            filter: {
                                field: 'operationType',
                                operator: 'eq',
                                value: dataItem.operationType
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=operationType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'operation',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            }, // pendiente
                            {
                                field: 'currencyDesc',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            }, // pendiente
                            {
                                field: 'amountOrigin',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }, // pendiente
                            {
                                field: 'amountTotal',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT_TOTAL'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }, // pendiente
                            {
                                field: 'amountLosing',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT_LOSING'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }, // pendiente
                            {
                                field: 'amountMl',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT_ML'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            } // pendiente
           ]
                    };
                };

            });

            scope.$watch('typesFixedTerms', function (newValue, oldValue) {

                $scope.mainGridFixedTerms = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateFixedTerms').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'product',
                            width: '900px'
                        }

                   ]
                };
                $scope.detailFixedTerms = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.fixedTerms.transport.data,
                            filter: {
                                field: 'typeDescription',
                                operator: 'eq',
                                value: dataItem.typeDescription
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=typeDescription#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'operationNumber',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currencyDescription',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'openingDate',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPENING_DATE'),
                                width: '150px'
                            },
                            {
                                field: 'balance',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_CONT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'available',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_DISP'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
              ]
                    };
                };
            });

            scope.$watch('typesWarranties', function (newValue, oldValue) {

                $scope.mainGridWarranties = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateWarranties').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'warrantyDescription',
                            width: '900px'
                        }

                ]
                };
                $scope.detailWarranties = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.warranties.transport.data,
                            filter: [{
                                field: 'warrantyType',
                                operator: 'eq',
                                value: dataItem.warrantyType
                            }, {
                                field: 'state',
                                operator: 'neq',
                                value: ''
                            }]
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=warrantyType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'code',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currency',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'actualValue',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_ACTUAL_VALUE'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'mrc',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_POR_MRC'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
           ]
                    };
                };
            });

            scope.$watch('typesPromissoryNotes', function (newValue, oldValue) {

                $scope.mainGridPromissoryNotes = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templatePromissoryNotes').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'warrantyDescription',
                            width: '900px'
                        }

             ]
                };
                $scope.detailPromissoryNotes = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.promissoryNotes.transport.data,
                            filter: {
                                field: 'warrantyType',
                                operator: 'eq',
                                value: dataItem.warrantyType
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=warrantyType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'code',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currency',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'actualValue',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_ACTUAL_VALUE'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'state',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_STATUS'),
                                width: '100px'
                            }
        ]
                    };
                };

            });
            scope.$watch('typesInsurancePolicy', function (newValue, oldValue) {

                $scope.mainGridInsurancePolicy = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateInsurancePolicy').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'warrantyDescription',
                            width: '900px'
                        }

          ]
                };
                $scope.detailInsurancePolicy = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.insurancePolicy.transport.data,
                            filter: {
                                field: 'warrantyType',
                                operator: 'eq',
                                value: dataItem.warrantyType
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=warrantyType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'policy_number',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            }, //pendiente
                            {
                                field: 'type_policy',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            }, //pendiente
                            {
                                field: 'number_guaranteed',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_ACTUAL_VALUE'),
                                width: '150px'
                            }, //pendiente
                            {
                                field: 'date_vto',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_STATUS'),
                                width: '100px'
                            }, //pendiente
                            {
                                field: 'state',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_STATUS'),
                                width: '100px'
                            } //pendiente
     ]
                    };
                };

            });

            scope.$watch('typesCredits', function (newValue, oldValue) {

                $scope.mainGridCredits = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateCredits').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'opTypeDescription',
                            width: '900px'
                        }

       ]
                };
                $scope.detailCredits = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.productsCredits,
                            filter: [{
                                field: 'opTypeDescription',
                                operator: 'eq',
                                value: dataItem.opTypeDescription
                            }, {
                                field: 'lineNumber',
                                operator: 'neq',
                                value: ' '
                            }]
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'CRE\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId, proc.creditLine, \'CRE\')">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px',
								height: '100px'
                },
                            {
                                field: 'lineNumber',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currencyDescription',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '100px'
                            },
                            {
                                field: 'openingDate',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPENING_DATE'),
                                width: '100px'
                            },
                            {
                                field: 'available',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_DISP'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'usedAmount',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'riskAmount',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RISK_ML'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
  ]
                    };
                };

            });
            scope.$watch('typesContingencies', function (newValue, oldValue) {

                $scope.mainGridContingencies = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateContingencies').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'opTypeDescription',
                            width: '900px'
                        }

    ]
                };
                $scope.detailContingencies = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.contingencies.transport.data,
                            filter: {
                                field: 'operationType',
                                operator: 'eq',
                                value: dataItem.type_operation
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=operationType#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },
                            {
                                field: 'numberOperation',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currency',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'amount',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_ACTUAL_VALUE'),
                                width: '150px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'beneficiary',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BENEFICIARY'),
                                width: '200px'
                            },
                            {
                                field: 'amountRisk',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RISK_ML'),
                                width: '200px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
]
                    };
                };
            });

            scope.$watch('typesSavingAccounts', function (newValue, oldValue) {

                $scope.mainGridSavingAccounts = {
                    dataSource: {
                        data: newValue
                    },
                    detailTemplate: kendo.template($('#templateSavingAccounts').html()),
                    dataBound: function () {
                        this.expandRow(this.tbody.find('tr.k-master-row').first());
                    },
                    columns: [
                        {
                            field: 'product',
                            width: '900px'
                        }

                              ]
                };
                $scope.detailSavingAccounts = function (dataItem) {
                    return {
                        dataSource: {
                            data: $rootScope.savingAccounts.transport.data,
                            filter: {
                                field: 'typeDescription',
                                operator: 'eq',
                                value: dataItem.typeDescription
                            }
                        },
                        columns: [
                            {
                                field: 'image',
                                title: ' ',
                                template: '<div class=\'btn-group\'><button type=\'button\'  class=\'btn btn-default dropdown-toggle  btn-xs \' data-toggle=\'dropdown\'> <span class=\'caret\'></span> </button> <ul class=\'dropdown-menu\'  role=\'menu\'> <li class=\'dropdown-submenu\'><a> Procesos </a><ul class=\"dropdown-menu\"><li ng-repeat=\"process in processes\"><a ng-if=\"\'#=typeDescription#\' == process.id\" ng-repeat=\"proc in process.processes\" ng-click = "rootProcessClick(  dataItem  , proc.flowId)">{{proc.processName}}</a></li></ul></li></ul></div>',
                                width: '50px'
                },

                            {
                                field: 'operationNumber',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_NUMBER_OPERATION'),
                                width: '200px'
                            },
                            {
                                field: 'currencyDescription',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
                                width: '150px'
                            },
                            {
                                field: 'openingDate',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPENING_DATE'),
                                width: '150px'
                            },
                            {
                                field: 'balance',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_CONT'),
                                width: '200px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            },
                            {
                                field: 'available',
                                title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_BALANCE_DISP'),
                                width: '100px',
                                format: '{0:n}',
                                attributes: {
                                    style: 'text-align:right;'
                                }
                            }
                                  ]
                    };

                };
            });



                        }]);
}());