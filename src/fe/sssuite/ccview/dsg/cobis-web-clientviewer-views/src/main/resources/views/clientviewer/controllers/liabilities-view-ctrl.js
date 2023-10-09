(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [
   cobis.modules.CONTAINER, cobis.modules.CUSTOMER, 'ui.bootstrap']);

    //Controller for liabilities-view-tpl.html	
    app.controller("clientviewer.liabilitiesController", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams',
function ($scope, $rootScope, $filter, $modal, $routeParams) {
            $rootScope.spid = 0;

                $scope.currentAccountColumns = [
                    {
                        field: "typeDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE'),
                        width: "200px"
                    },
                    {
                        field: "operationNumber",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'),
                        width: "200px"
                    },
                    {
                        field: "rol",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_ROLE'),
                        width: "50px"
                    },
                    {
                        field: "openingDate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_OPEN_DATE'),
                        width: "130px"
                    },
                    {
                        field: "currencyDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CURRENCY'),
                        width: "100px"
                    },
                    {
                        field: "available",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AVAILABLE'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amount_pig",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNTH_PIG'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "retentions",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_RETENTION'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "blockades",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BLOCKADES'),
                        width: "80px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "rate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_RATE'),
                        width: "130px",
                        format: "{0:0.0000}"
                    },
                    {
                        field: "status",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_STATUS'),
                        width: "130px"
                    }];

                $scope.savingAccountsColumns = [
                    {
                        field: "typeDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE'),
                        width: "200px"
                    },
                    {
                        field: "operationNumber",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'),
                        width: "200px"
                    },
                    {
                        field: "rol",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_ROLE'),
                        width: "50px"
                    },
                    {
                        field: "openingDate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_OPEN_DATE'),
                        width: "130px"
                    },
                    {
                        field: "currencyDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CURRENCY'),
                        width: "100px"
                    },
                    {
                        field: "available",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AVAILABLE'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amount_pig",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNTH_PIG'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "retentions",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_RETENTION'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "blockades",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BLOCKADES'),
                        width: "80px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "overdraft_limit",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_OD_LIMIT'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "protests",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_PROTEST'),
                        width: "130px"
                    },
                    {
                        field: "rate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_RATE'),
                        width: "130px",
                        format: "{0:0.0000}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "status",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_STATUS'),
                        width: "130px"
                    }];

                $scope.fixedTermsColumns = [
                    {
                        field: "typeDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE'),
                        width: "200px"
                    },
                    {
                        field: "operationNumber",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'),
                        width: "200px"
                    },
                    {
                        field: "rol",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_ROLE'),
                        width: "50px"
                    },
                    {
                        field: "openingDate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_OPEN_DATE'),
                        width: "130px"
                    },
                    {
                        field: "expirationDate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_EXPIRATION_DATE'),
                        width: "130px"
                    },
                    {
                        field: "currencyDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CURRENCY'),
                        width: "100px"
                    },
                    {
                        field: "balance",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "pledgedAmount",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNTH_PIG'),
                        width: "200px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "rate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_RATE'),
                        width: "130px",
                        format: "{0:0.0000}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    }];

                $scope.currentAccount = {};
                $scope.isVisiblecurrentAccount = true;
                $scope.isVisibleSavingAccounts = true;
                $scope.isVisiblefixedTerms = true;

                //Use to format to date fields
                $scope.convertFields = function (data, type) {
                    var currentAc = data;
                    if (type == undefined) {
                        for (var i in currentAc) {
                            //new Date(currentAc[i].openingDate); 
                            var dateChange = new Date($filter('date')(parseInt(currentAc[i].openingDate.substring(6, 18), "dd/MM/yyyy"))).toLocaleDateString();
                            currentAc[i].openingDate = dateChange;
                        }
                    } else {
                        for (var i in currentAc) {
                            var dateChange = new Date($filter('date')(parseInt(currentAc[i].openingDate.substring(6, 18), "dd/MM/yyyy")));
                            currentAc[i].openingDate = dateChange.toLocaleDateString();
                            dateChange = new Date($filter('date')(parseInt(currentAc[i].expirationDate.substring(6, 18), "dd/MM/yyyy")));
                            currentAc[i].expirationDate = dateChange.toLocaleDateString();
                            if (currentAc[i].lastMovDate != null) {
                                dateChange = new Date($filter('date')(parseInt(currentAc[i].lastMovDate.substring(6, 18), "dd/MM/yyyy")));
                                currentAc[i].lastMovDate = dateChange.toLocaleDateString();
                            }
                        }
                    }

                    return currentAc;
                }


                $scope.currentAccount = new kendo.data.DataSource({
                    data: $scope.convertFields($rootScope.productsCurrentAccount),
                    schema: {
                        model: {
                            fields: {
                                typeDescription: {
                                    type: "string"
                                },
                                operationNumber: {
                                    type: "string"
                                },
                                rol: {
                                    type: "string"
                                },
                                openingDate: {
                                    type: "string"
                                },
                                expirationDate: {
                                    type: "string"
                                },
                                currencyDescription: {
                                    type: "string"
                                },
                                available: {
                                    type: "number"
                                },
                                amount_pig: {
                                    type: "number"
                                },
                                retentions: {
                                    type: "number"
                                },
                                blockades: {
                                    type: "number"
                                },
                                overdraft_limit: {
                                    type: "number"
                                },
                                protests: {
                                    type: "string"
                                },
                                rate: {
                                    type: "number"
                                },
                                status: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });

                $scope.savingAccounts = new kendo.data.DataSource({
                    data: $scope.convertFields($rootScope.productsSavingAccount),
                    schema: {
                        model: {
                            fields: {
                                typeDescription: {
                                    type: "string"
                                },
                                operationNumber: {
                                    type: "string"
                                },
                                rol: {
                                    type: "string"
                                },
                                openingDate: {
                                    type: "string"
                                },
                                currencyDescription: {
                                    type: "string"
                                },
                                available: {
                                    type: "number"
                                },
                                amount_pig: {
                                    type: "number"
                                },
                                retentions: {
                                    type: "number"
                                },
                                blockades: {
                                    type: "number"
                                },
                                rate: {
                                    type: "number"
                                },
                                status: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });

                $scope.fixedTerms = new kendo.data.DataSource({
                    data: $scope.convertFields($rootScope.productsFixedTerm, 'FT'),
                    schema: {
                        model: {
                            fields: {
                                typeDescription: {
                                    type: "string"
                                },
                                operationNumber: {
                                    type: "string"
                                },
                                rol: {
                                    type: "string"
                                },
                                openingDate: {
                                    type: "string"
                                },
                                expirationDate: {
                                    type: "string"
                                },
                                currencyDescription: {
                                    type: "string"
                                },
                                balance: {
                                    type: "number"
                                },
                                pledgedAmount: {
                                    type: "number"
                                },
                                rate: {
                                    type: "number"
                                }
                            }
                        }
                    }
                });

                $scope.isVisiblecurrentAccount = ($rootScope.productsCurrentAccount != null && $rootScope.productsCurrentAccount.length > 0);
                $scope.isVisibleSavingAccounts = ($rootScope.productsSavingAccount != null && $rootScope.productsSavingAccount.length > 0);
                $scope.isVisiblefixedTerms = ($rootScope.productsFixedTerm != null && $rootScope.productsFixedTerm.length > 0);
               

    }]);
}());