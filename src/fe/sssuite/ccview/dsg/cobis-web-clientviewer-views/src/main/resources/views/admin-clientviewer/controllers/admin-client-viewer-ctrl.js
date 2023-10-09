(function () {
    'use strict';

    var app = cobis.createModule(cobis.modules.ADMCLIENTVIEWER, ["oc.lazyLoad", cobis.modules.ADMCLIENTVIEWER, 'ui.bootstrap', "designerModule", "ngResource"]);

    app.config(["$controllerProvider", "$compileProvider", "$routeProvider", "$filterProvider",
        function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
            app.controllerProvider = $controllerProvider;
            app.compileProvider = $compileProvider;
            app.routeProvider = $routeProvider;
            app.filterProvider = $filterProvider;
    }]);

    app.controller("adminclientviewer.clientViewerController", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams', 'adminclientviewer.clientViewerService',
  function ($scope, $rootScope, $filter, $modal, $routeParams, adminClientViewerService) {

            $scope.orientationv = "vertical";
            $scope.orientationh = "horizontal";
            $scope.rol = "";
            $scope.rolesAssociatesDS = [];
            $scope.roleConfigDS = [];
            $scope.defaultConfigDS = [];
            $scope.items = [];
            $scope.itemsRol = [];
            $scope.itemProduct = {};
            $scope.isVisibleBtnAddRole = false;
            $scope.imageRemoveRole = "";
            $scope.imageSelectRole = "";
            $scope.idRole = 0;

            $scope.roleColumns = [
                {
                    field: "removeRole",
                    title: " ",
                    template: "<button class=\"btn btn-default btn-sm\" ng-click=\"removeRole(-1)\"><span class=\"glyphicon glyphicon-remove\" title=\"{{'ADMCLIENTVIEWER.LABELS.LBL_REMOVE_ROLE' | translate}}\"></span></button>",
                    width: "10px"
                },
                {
                    field: "selectRole",
                    title: " ",
                    template: "<button class=\"btn btn-default btn-sm\" ng-click=\"selectRole(-1)\"><span class=\"glyphicon glyphicon-ok\" title=\"{{'ADMCLIENTVIEWER.LABELS.LBL_SELECT_ROLE' | translate}}\"></span></button>",
                    width: "10px"
                },
                {
                    field: "roleName",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_ROLE_DESCRIPTION'),
                    width: "100px"
                }
            ];


            // Function that gathers IDs of checked nodes
            function checkedNodeIds(node, checkedNodes) {
                if (node.checked) {
                    checkedNodes.push(node.id);
                }
                for (var i = 0; i < node.items.length; i++) {
                    if (node.items[i].checked) {
                        checkedNodes.push(node.items[i].id);
                    }

                    if (node.items[i].hasChildren) {
                        checkedNodeIds(node.items[i].children.view(), checkedNodes);
                    }
                }
            };

            $scope.pageImage = function (typeImage) {
                var baseImageDir = "../../assets/commons/img/";
                var directionImage;

                switch (typeImage) {
                case "remove_role":
                    directionImage = baseImageDir + "add.png";
                    break;
                case "select_role":
                    directionImage = baseImageDir + "add.png";
                    break;
                default:
                    directionImage = baseImageDir + "add.png";
                }

                return directionImage;
            };

            $scope.titleToolTip = function (type, isEnabled) {
                var title;

                switch (type) {
                case 0: //Visible
                    if (isEnabled == 1) {
                        title = $filter('translate')('ADMCLIENTVIEWER.TITLES.TIT_VISIBLE');
                    } else {
                        title = $filter('translate')('ADMCLIENTVIEWER.TITLES.TIT_INVISIBLE');
                    }
                    break;
                case 1: //Encrypted
                    if (isEnabled == 1) {
                        title = $filter('translate')('ADMCLIENTVIEWER.TITLES.TIT_ENCRYPTED');
                    } else {
                        title = $filter('translate')('ADMCLIENTVIEWER.TITLES.TIT_DECRYPTED');
                    }
                    break;
                default: //Visible
                    if (isEnabled == 1) {
                        title = $filter('translate')('ADMCLIENTVIEWER.TITLES.TIT_VISIBLE');
                    } else {
                        title = $filter('translate')('ADMCLIENTVIEWER.TITLES.TIT_INVISIBLE');
                    }
                }

                return title;
            };

            $scope.labelSection = function (section) {

                var labelSection = '';

                labelSection += section;

                var nameSection = $filter('translate')(labelSection);

                return nameSection;
            };

            // show checked node IDs on datasource change
            $scope.onCheck = function (dataItem) {
                var checkedNodes = [];

                //var treeView = $("#treewProducts").data("kendoTreeView");

                checkedNodeIds(dataItem, checkedNodes);

            };

            $scope.treewOptions = {
                checkboxes: {
                    //template: "<input type='checkbox' name='checkedVisible[#= item.id #]' value='true' />",
                    checkChildren: true
                },
                dataSource: $scope.treewData
                //check: onCheck
            };


            $scope.getTreeProducts = function (item) {
                var i = 0;
                $scope.treeData = [];
                $scope.treewData = null;

                var ID_ROOT = 0;

                //Se recupera el listado plano de todos los productos
                //var resultRoleConfig = adminClientViewerService.defaultConfigurationVCC();
                //resultRoleConfig.then(function(data){

                var allProducts = adminClientViewerService.queryConfigurationVCC(item);
                allProducts.then(function (data) {

                    //Si se pudo recuperar productos bancarios se arma el arbol de productos
                    if (data != null && data.length >= 0) {
                        var roleConfig = data;

                        //Identificacion del nodo raiz para ubicar a sus hijos a n niveles
                        for (i = 0; i < roleConfig.length; i++) {
                            if (roleConfig[i].idProduct == ID_ROOT) {
                                //Se crea el nodo raiz para el arbol en base al objeto recuperado del servicio
                                //var node={id:roleConfig[i].id, name:roleConfig[i].name, text:roleConfig[i].name,expanded: true, isvisible : (roleConfig[i].isvisible == 1) ? "checked" : "unchecked"  , isencrypted : (roleConfig[i].isencrypted == 1) ? "checked" : "unchecked"};
                                var node = {
                                    id: roleConfig[i].idProduct,
                                    name: roleConfig[i].name,
                                    text: $scope.labelSection(roleConfig[i].name),
                                    expanded: true,
                                    isvisible: (roleConfig[i].visible == 1) ? "checked" : "unchecked",
                                    isencrypted: (roleConfig[i].encrypted == 1) ? "checked" : "unchecked",
                                    rol: roleConfig[i].idRole,
                                    iconvisible: (roleConfig[i].visible == 1) ? "glyphicon glyphicon-eye-open" : "glyphicon glyphicon-eye-close",
                                    iconencrypted: (roleConfig[i].encrypted == 1) ? "fa fa-lock" : "fa fa-unlock",
                                    titvisible: $scope.titleToolTip(0, roleConfig[i].visible),
                                    titencrypted: $scope.titleToolTip(1, roleConfig[i].encrypted)
                                };

                                //Se recupera recursivamente los nodos hijos
                                node.items = $scope.ProductChilds(roleConfig, ID_ROOT);

                                //Se agrega el nodo raiz con sus hijos para retornado
                                $scope.treeData.push(node);

                            }
                        }

                        $scope.treewData = new kendo.data.HierarchicalDataSource({
                            data: $scope.treeData
                        });


                    }

                });
            };

            $scope.treeItemTemplate = "<button type='button' name='buttonVisible[#= item.id #]' class='btn btn-default btn-xs' ng-click='parameterizeVisibility(#= item.id # , #= item.rol #, #= (item.isvisible == 'checked') ? 1 : 0 # , #= (item.isencrypted == 'checked') ? 1 : 0 #,dataItem)'><span title = '#= item.titvisible #' class='#= item.iconvisible #'></span></button> <button type='button' name='buttonEncrypted[#= item.id #]' class='btn btn-default btn-xs' ng-click='parameterizedEncryption(#= item.id # , #= item.rol #, #= (item.isvisible == 'checked') ? 1 : 0 # , #= (item.isencrypted == 'checked') ? 1 : 0 #,dataItem)'><span title = '#= item.titencrypted #' class='#= item.iconencrypted #'></span></button> {{dataItem.text}}";

            /*        
        $scope.treeItemTemplate="<input type='checkbox' name='checkedVisible[#= item.id #]'  #= item.isvisible # ng-click='parameterizeVisibility(#= item.id # , #= item.rol #, #= (item.isvisible == 'checked') ? 1 : 0 # , #= (item.isencrypted == 'checked') ? 1 : 0 #)'/>  <input type='checkbox' name='checkedEncrypted[#= item.id #]'  #= item.isencrypted # ng-click='parameterizedEncryption(#= item.id # , #= item.rol #, #= (item.isvisible == 'checked') ? 1 : 0 # , #= (item.isencrypted == 'checked') ? 1 : 0 #)' /> {{dataItem.text}}";
*/

            //$scope.getTreeProducts();

            //Metodo que permite recuperar los nodos hijos en base al id del padre y de la lista de nodos totales recuperados del servicio
            $scope.ProductChilds = function (allProducts, idParent) {
                var i = 0;
                var childList = new Array();

                //Se buscan los nodos hijos en base al id del padre
                for (i = 0; i < allProducts.length; i++) {
                    if (allProducts[i].parent == idParent) {
                        //Se crea un nodo para agregar al arbol de productos en base al objeto recuperado por el servicio
                        //var node={id:allProducts[i].id, name:allProducts[i].name, text:allProducts[i].name,expanded: true, isvisible : (allProducts[i].isvisible == 1) ? "checked" : "unchecked", isencrypted : (allProducts[i].isencrypted == 1) ? "checked" : "unchecked" };
                        var node = {
                            id: allProducts[i].idProduct,
                            name: allProducts[i].name,
                            text: $scope.labelSection(allProducts[i].name),
                            expanded: true,
                            isvisible: (allProducts[i].visible == 1) ? "checked" : "unchecked",
                            isencrypted: (allProducts[i].encrypted == 1) ? "checked" : "unchecked",
                            rol: allProducts[i].idRole,
                            iconvisible: (allProducts[i].visible == 1) ? "glyphicon glyphicon-eye-open" : "glyphicon glyphicon-eye-close",
                            iconencrypted: (allProducts[i].encrypted == 1) ? "fa fa-lock" : "fa fa-unlock",
                            titvisible: $scope.titleToolTip(0, allProducts[i].visible),
                            titencrypted: $scope.titleToolTip(1, allProducts[i].encrypted)
                        };

                        //[{text:"Procesos",items:[{text:"SOLICITUD DE AHORRO VOLUNTARIO",url:"debts-tpl.html"},{text:"SOLICITUD OPERACION ORIGINAL",url:"debts-tpl.html"},{text:"SOLICITUD REFINANCIAMIENTO",url:"debts-tpl.html"},{text:"SOLICITUD RESTRUCTURACION",url:"debts-tpl.html"}]}];


                        //Se agrega en la lista de hijos
                        childList.push(node);

                        //Se buscan los hijos del nodo actual y se los agrega como hijos en la propiedad items
                        node.items = $scope.ProductChilds(allProducts, allProducts[i].idProduct);
                    }
                }

                //Se retorna la lista de nodos hijos
                return childList;

            };

            $scope.initData = function () {

                $scope.treeData = [];
                $scope.treewData = null;

                $scope.imageRemoveRole = $scope.pageImage("remove_role");
                $scope.imageSelectRole = $scope.pageImage("remove_role");

                $scope.searchRolesConfig();
                $scope.searchRolesAssoc();
            };

            $scope.blockScreen = function () {
                $.blockUI({
                    message: $('<div>Procesando..</div>'),
                    css: {
                        border: 'none',
                        backgroundColor: '#000',
                        opacity: .5,
                        color: '#fff'
                    }
                });
            };

            $scope.unblockScreen = function () {
                $.unblockUI();
            };


            $scope.validateTreeview = function (dataItem, type) {
                var nodeParent = dataItem;

                if (nodeParent != null) {
                    var nodeProductParent = [];

                    var isvisible = (nodeParent.isvisible == 'checked') ? 1 : 0;
                    var isencrypted = (nodeParent.isencrypted == 'checked') ? 1 : 0;

                    if (type == 0) {
                        nodeProductParent = {
                            idRole: nodeParent.rol,
                            idProduct: nodeParent.id,
                            visibleProduct: (isvisible == 1 ? 0 : 1),
                            encryptedProduct: (isencrypted)
                        };
                    } else {
                        nodeProductParent = {
                            idRole: nodeParent.rol,
                            idProduct: nodeParent.id,
                            visibleProduct: (isvisible),
                            encryptedProduct: (isencrypted == 1 ? 0 : 1)
                        };
                    }

                }
                $scope.itemProduct = nodeProductParent;
                $scope.updateConfig();
                if (nodeParent.items.length > 0) {
                    console.log("Root Padre de " + nodeParent.items.length + " hijos ");

                    for (var i = 0; i < nodeParent.items.length; i++) {
                        $scope.validateTreeview1(nodeParent.items[i], i, type, nodeProductParent.visibleProduct, nodeProductParent.encryptedProduct);
                    };
                } else {
                    console.log("Root No es Padre ");
                }
            };

            $scope.validateTreeview1 = function (node, index, type, visibleProduct, encryptedProduct) {
                var nodeChild = node;

                if (nodeChild != null) {
                    var nodeProductChild = [];
                    var isvisible = (nodeChild.isvisible == 'checked') ? 1 : 0;
                    var isencrypted = (nodeChild.isencrypted == 'checked') ? 1 : 0;

                    if (type == 0) {
                        nodeProductChild = {
                            idRole: nodeChild.rol,
                            idProduct: nodeChild.id,
                            visibleProduct: (visibleProduct == 1 ? 1 : 0),
                            encryptedProduct: (encryptedProduct)
                        };
                    } else {
                        nodeProductChild = {
                            idRole: nodeChild.rol,
                            idProduct: nodeChild.id,
                            visibleProduct: (visibleProduct),
                            encryptedProduct: (encryptedProduct == 1 ? 1 : 0)
                        };
                    }
                }
                $scope.itemProduct = nodeProductChild;
                $scope.updateConfig();
                if (nodeChild.items.length > 0) {
                    console.log("Child " + index + " es Padre de " + nodeChild.items.length + " hijos ");

                    for (var j = 0; j < nodeChild.items.length; j++) {
                        $scope.validateTreeview1(nodeChild.items[j], j, type, nodeProductChild.visibleProduct, nodeProductChild.encryptedProduct);
                    };
                } else {
                    console.log("Child " + index + " No es Padre ");
                }
            };



            $scope.parameterizedEncryption = function (idProduct, idRole, isVisible, isEncrypted, dataItem) {
                $scope.validateTreeview(dataItem, 1);
            };

            $scope.parameterizeVisibility = function (idProduct, idRole, isVisible, isEncrypted, dataItem) {
                $scope.validateTreeview(dataItem, 0);
            };

            $scope.searchRolesConfig = function () {
                var resultRoles = adminClientViewerService.getAllRoleConfigurationVCC();
                resultRoles.then(function (data) {
                    $scope.roleConfigDS = [];

                    for (var i = 0; i < data.length; i++) {
                        var temp = {};
                        temp.removeRole = "";
                        temp.selectRole = "";
                        temp.roleName = data[i].roleName;
                        temp.idRole = data[i].idRole;

                        cobis.userContext.setValue(temp.roleName, temp.idRole);

                        $scope.roleConfigDS.push(temp);
                    };

                    cobis.userContext.setValue("ROLESCONFIGURATIONVCC", data);
                });
            };

            $scope.searchRolesAssoc = function () {
                var resultRolesConfig = adminClientViewerService.getAllRoleAssociatesVCC();
                resultRolesConfig.then(function (data) {
                    $scope.rolesAssociatesDS = data.data.returnRole;
                    cobis.userContext.setValue("ROLESASSOCIATESVCC", data.data.returnRole);
                });
            };

            $scope.selectConfigurationDefault = function () {
                $scope.blockScreen();
                var resultDefaultConfig = adminClientViewerService.defaultConfigurationVCC();
                resultDefaultConfig.then(function (data) {
                    $scope.defaultConfigDS = data;
                    cobis.userContext.setValue("DEFAULTCONFIGURATIONVCC", data);
                    if ($scope.defaultConfigDS.length = 0) {
                        alert($scope.defaultConfigDS.length);
                    };
                }).then(function (data) {
                    $scope.unblockScreen();
                });
                $scope.unblockScreen();
            };

            $scope.removeConfig = function (idRol) {
                var delConfig = false;

                var config = adminClientViewerService.deleteConfigurationVCC(idRol);

                config.then(function (data) {
                    for (var i = 0; $scope.roleConfigDS.length - 1; i++) {
                        if ($scope.roleConfigDS[i].idRole == $scope.idRole) {
                            $scope.roleConfigDS.splice(i, 1);
                            $scope.isVisibleBtnAddRole = false;
                            delConfig = true;
                            break;
                        }
                    };
                });

                $('#kRole').data('kendoGrid').dataSource.read();
                $('#kRole').data('kendoGrid').refresh();
                
                $scope.treeData = [];
                $scope.treewData = null;

                return delConfig;
            };

            $scope.removeRole = function (idRole) {
                $scope.blockScreen();

                if (idRole == -1) {
                    var roleName = $(this).closest("td");
                    idRole = cobis.userContext.getValue(roleName.prevObject[0].dataItem.roleName);

                    if (idRole == null || idRole == undefined || $.trim(idRole) == "") {
                        idRole = roleName.prevObject[0].dataItem.idRole;
                    }
                }

                if (idRole != '') {
                    var textConfirmRemoval = $filter('translate')("COMMONS.MESSAGES.MSG_CONFIRM_REMOVAL");
                    var confirmRemoval = confirm(textConfirmRemoval);
                    if (confirmRemoval) {
                        $scope.idRole = idRole;
                        var resultDel = $scope.removeConfig(idRole);
                        if (resultDel) {
                            $scope.isVisibleBtnAddRole = false;
                        }
                    }
                };


                $scope.unblockScreen();
            };

            $scope.selectRole = function (idRole) {
                $scope.blockScreen();

                if (idRole == -1) {
                    var roleName = $(this).closest("td");
                    idRole = cobis.userContext.getValue(roleName.prevObject[0].dataItem.roleName);

                    if (idRole == null || idRole == undefined || $.trim(idRole) == "") {
                        idRole = roleName.prevObject[0].dataItem.idRole;
                    }

                    $scope.idRole = idRole;
                }

                //se envía a recargar la pantalla cuando el id es nulo
                if (idRole == null || idRole == undefined || $.trim(idRole) == "") {
                    $scope.initData();
                } else {
                    $scope.getTreeProducts(idRole);
                }
                $scope.unblockScreen();
            };

            $scope.click = function (dataItem) {
                alert(dataItem.text);
            };

            $scope.saveConfig = function (newRol) {
                var insert = false;
                var idRol = newRol.idRole;
                var nameRol = newRol.roleName;
                newRol.removeRole = "";
                newRol.selectRole = "";

                var config = adminClientViewerService.insertConfigurationVCC(idRol, nameRol);

                config.then(function (data) {
                    $scope.roleConfigDS.push($scope.newRol);
                    //$scope.getTreeProducts($scope.newRol.idRole);
                    $scope.isVisibleBtnAddRole = false;
                    insert = true;
                });

                return insert;
            };

            $scope.addRole = function () {
                $scope.blockScreen();
                $scope.searchRolesAssoc();
                $scope.isVisibleBtnAddRole = true;
                $scope.unblockScreen();
            };

            $scope.addRoleGrid = function () {
                $scope.blockScreen();
                $scope.isVisibleBtnAddRole = true;
                var combobox = $("#cmbRoles").data("kendoComboBox");
                var dataItem = combobox.dataItem();
                if (dataItem) {
                    $scope.newRol = {
                        idRole: dataItem.rol,
                        roleName: dataItem.descripcion
                    };
                    var insert = $scope.saveConfig($scope.newRol);
                    if (insert) {
                        $scope.isVisibleBtnAddRole = false;
                    }

                };

                //$('#kRole').data('kendoGrid').dataSource.read();
                //$('#kRole').data('kendoGrid').refresh();

                $scope.initData();
                
                $scope.treeData = [];
                $scope.treewData = null;

                $scope.unblockScreen();
            };


            $scope.removeRoleGrid = function () {
                //deleteConfigurationVCC
                $scope.isVisibleBtnAddRole = false;
            };

            $scope.updateConfig = function () {
                var saveConfig = false;

                var config = adminClientViewerService.updateConfigurationVCC($scope.itemProduct);
                config.then(function (data) {
                    $scope.getTreeProducts($scope.idRole);
                    $scope.itemProduct = {};
                    saveConfig = true;
                });

            };
      }]);
}());