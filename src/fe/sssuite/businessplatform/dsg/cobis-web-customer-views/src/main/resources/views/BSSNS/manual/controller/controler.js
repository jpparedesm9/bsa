(function (window) {
  "use strict";

  var app = cobis.createModule(
    cobis.modules.CUSTOMER,
    [
      "oc.lazyLoad",
      cobis.modules.CONTAINER,
      "ui.bootstrap",
      "designerModule",
      "ngResource"
    ],
    ["DSGNR", "customer"]
  );

  app.config(function (
    $controllerProvider,
    $compileProvider,
    $routeProvider,
    $filterProvider
  ) {
    app.controllerProvider = $controllerProvider;
    app.compileProvider = $compileProvider;
    app.routeProvider = $routeProvider;
    app.filterProvider = $filterProvider;
  });

  app.controller("formControllerQuestion", [
    "$scope",
    "$compile",
    "$rootScope",
    "$filter",
    "$modal",
    "$routeParams",
    "designer",
    "dsgnrCommons",
    "customer.queryBussinesCustomer",
    "$parse",
    function (
      $scope,
      $compile,
      $rootScope,
      $filter,
      $modal,
      $routeParams,
      designer,
      dsgnrCommons,
      queryBussinesCustomer,
      $parse
    ) {
      //begin//
      $scope.vc = designer.initCustomViewContainer('GeneralBusinessInformation');
      $scope.datePlaceHolder = 'dd/MM/yyyy'; //Se debería recuperar del servidor
      $scope.dateFormat = 'dd/MM/yyyy'; //Se deberia recuperar del servidor
      var api = new dsgnrCommons.API($scope.vc),
        nav = api.navigation;
      $scope.customerId = (angular.isDefined(nav.getCustomDialogParameters()) && nav.getCustomDialogParameters() !== null) ? nav.getCustomDialogParameters().customerId : 0;
	  $scope.stage =(angular.isDefined(nav.getCustomDialogParameters()) && nav.getCustomDialogParameters() !== null) ? nav.getCustomDialogParameters().task : 0;
	  $scope.processInstance =(angular.isDefined(nav.getCustomDialogParameters()) && nav.getCustomDialogParameters() !== null) ? nav.getCustomDialogParameters().processInstance : 0;
      $rootScope.gridNumbers = 0;

      $scope.numberMessagesPreventDefault = 0;
	  $scope.isPending = false;
      //Tipos de controles
      /*
        M : moneda
        C : combo
        T : tabla
        F : fecha
        N : numeros
      */

      $scope.getComboDataSource = function (idSection, idQuestion) {
        var data = $rootScope.result.section[idSection].questions[idQuestion].values;
        if (angular.isDefined(data) && data != null) {
          var comboBoxConfig = {
            dataSource: data,
            dataTextField: "value",
            dataValueField: "code",
			      optionLabel: {
				        value: "",
				        code: ""
			      }
          }
          return comboBoxConfig;
        } else {
          console.log("Error al cargar la data del combo");
        }

      };

      $scope.getComboDataSourceGrid = function (idSection, idQuestion, idColumn) {
        var data = $rootScope.result.section[idSection].questions[idQuestion].tableQuestion[idColumn].values;
        if (angular.isDefined(data) && data != null) {
          var comboBoxConfig = {
            dataSource: data
          }
          return comboBoxConfig.dataSource;
        } else {
          console.log("Error al cargar la data del combo");
        }
      };

      //Carge sections
      $scope.loadSections = function () {
        try {
          $scope.showLoading();
          var list = queryBussinesCustomer.queryCustomer($scope.customerId, $scope.stage, $scope.processInstance);

          list.then(function (data) {
            //Vaiable principal
            $rootScope.result = data;

            //Generar Variables Scope
            for (var i = 0; i < $rootScope.result.section.length; i++) {
              for (var j = 0; j < $rootScope.result.section[i].questions.length; j++) {
                if ($rootScope.result.section[i].questions[j].type !== "T") {
                  $scope["s" + $rootScope.result.section[i].idSection + "q" + $rootScope.result.section[i].questions[j].idQuestion] = $rootScope.result.section[i].questions[j].answer;
                }
              }
            }
            $scope.hideLoading();
          }).catch(function (error) {
            if (error.messages.length > 0) {
              error.messages.forEach(function (item, index) {
                cobis.getMessageManager().showMessagesError(item.message);
              });

            }
            $scope.vc.parentVc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"
            $scope.hideLoading();
          });
        } catch (e) {
          console.log("Error en la carga de datos" + e);
        }

      }

      $scope.getColumns = function (idSection, idQuestion,enabled) {
        var gridData = $rootScope.result.section[idSection].questions[idQuestion].tableQuestion;
        var columns = [];
        if (gridData != undefined) {
          for (var i = 0; i < gridData.length; i++) {
            var column = {
              field: gridData[i].label.replace(/ /g, ""),
              title: gridData[i].label,
              type: gridData[i].type

            };

            //Si el tipo es un ComboBox
            if (gridData[i].type === "C") {
              $scope["idColumnS" + idSection + "Q" + idQuestion] = i;
              $scope["fieldNameS" + idSection + "Q" + idQuestion] = gridData[i].label.replace(/ /g, "");
              column["template"] = function (dataItem) {
                return $scope.getDescriptionComboBox(idSection, idQuestion, $scope["idColumnS" + idSection + "Q" + idQuestion], $scope["fieldNameS" + idSection + "Q" + idQuestion], dataItem);
              };
            }

            //Template personalizado de grid
            if (gridData[i].type !== null) {
              column["editor"] = function (container, options) {
                var columnTemplateGrid = $scope.columnTemplate(idSection, idQuestion, container, options);
              }

            }

            //Formato columnas
            if (gridData[i].type !== null && gridData[i].type !== "C" && gridData[i].type !== "T") {
              column["format"] = $scope.getColumnFormat(gridData[i].type);
            }

            columns.push(column);
          }
		  if(enabled!=='N'){
			  //Columna de edicion
			  columns.push({
				command: [{
				  name: "edit",
				  text: "",
				  click: function (e) {
					console.log("Ingresa edit");
				  }
				}, {
				  name: "destroy",
				  text: "",
				  click: function (e) {
					console.log("Ingresa eliminar");
				  }
				}],
				width: "70px"
			  });
		  }

          //Columna id
          columns.push({
            hidden: true,
            field: "id",
            title: "id"
          });
        }
        return columns;

      };

      $scope.getDescriptionComboBox = function (idSection, idQuestion, idColumn, fieldName, dataItem) {
        var selectValue = dataItem[fieldName];
        var description = null;
        var dataSourceComboBox = $rootScope.result.section[idSection].questions[idQuestion].tableQuestion[idColumn].values;
        if (angular.isDefined(selectValue) && selectValue != null) {
          dataSourceComboBox.forEach(function (item, index) {
            if (angular.isDefined(selectValue.code) && angular.isDefined(item.code)) {
              if (selectValue.code === item.code) {
                description = item.value;
              }
            } else if (selectValue === item.code) {
              description = item.value;
            }
          });
        } else {
          dataSourceComboBox.forEach(function (item, index) {
            if (angular.isDefined(selectValue) && selectValue !== null) {
              if (angular.isDefined(selectValue.code)) {
                if (selectValue.code === item.code)
                  description = item.value;
              } else if (selectValue === item.code) {
                description = item.value;
              }
            }
          });
        }

        return description;
      };

      $scope.getDataSource = function (idSection, idQuestion, enabled) {
        var gridData = $rootScope.result.section[idSection].questions[idQuestion].tableQuestion;
        var idQuestionGrid = $rootScope.result.section[idSection].questions[idQuestion].idQuestion;
        var answerGrid = $rootScope.result.answerWithTable !== null ? $rootScope.result.answerWithTable : null;
        var columns = $scope.getColumns(idSection, idQuestion, enabled);

        //Definir modelo grid
        var definitionFields = {};

        for (var i = 0; i < columns.length; i++) {
          var typeFields = {
            type: null
          };
          if (!columns[i].command && columns[i].type === "N" || columns[i].type === "M") {
            typeFields.type = "number";
            definitionFields[columns[i].field] = typeFields;
          } else if (!columns[i].command && columns[i].type === "F") {
            typeFields.type = "date";
            definitionFields[columns[i].field] = typeFields;

          } else if (!columns[i].command && columns[i].field === "id"){
            typeFields.type = "number";
            definitionFields[columns[i].field] = typeFields;
          } else if (!columns[i].command) {
            typeFields.type = "string";
            definitionFields[columns[i].field] = typeFields;
          } 

        }


        if (answerGrid != null) {


          //Datasource por grid
          var rowData = [];

          for (var j = 0; j < answerGrid.length; j++) {
            if (answerGrid[j].idQuestion === idQuestionGrid && answerGrid[j].rowList !== null) {

              for (var k = 0; k < answerGrid[j].rowList.length; k++) {
                var item = {};
                answerGrid[j].rowList[k].columns.forEach(function (element, index) {
                  if (!columns[index].command) {
                    item[columns[index].field.replace(/ /g, "")] = element.answerDesc;
                  }

                });
                item["id"] = k+1;
                rowData.push(item);
              }
            }
          }
          $scope["grid.s" + idSection + "q" + idQuestion] = rowData;

          var data = new kendo.data.DataSource({
            data: $scope["grid.s" + idSection + "q" + idQuestion],
            schema: {
              model: {
                id: "id",
                fields: definitionFields
              }
            },
            pageSize: 10
          });

          return data;
        }
        return new kendo.data.DataSource({
          data: [],
          schema: {
            model: {
              id: "id",
              fields: definitionFields
            }
          },
		  transport: {
				read: function(e) {
				  if(angular.isDefined(e.data.id)){
					e.success(e.data);
				  }else{
					 e.success();
				  }
				},
				update: function(e) {
					e.success(e.data);
				},
				create: function(e){
					if(angular.isDefined(e.data)){
						var item = e.data;
						if(angular.isDefined(e.data.TIPODEINGRESO)){
							var grid = $("#vaS2Q19").data("kendoGrid");
						}else{
							var grid = $("#vaS3Q20").data("kendoGrid");
						}														
						if(grid!=null){					
							item.id = grid.dataSource.data().length;
						}else{
							item.id=1;
						}
						e.success(item);
					}
				},
				destroy: function (e) {
					e.success(e.data);
				}
			},	  
          pageSize: 10
        });
      };

      $scope.columnTemplate = function (idSection, idQuestion, container, columnOptions) {
        var dataGrid = $rootScope.result.section[idSection].questions[idQuestion].tableQuestion;
        var elementAux = "";
        for (var i = 0; i < dataGrid.length; i++) {
          if (columnOptions != null && columnOptions !== null && columnOptions.field === dataGrid[i].label.replace(/ /g, "")) {
            switch (dataGrid[i].type) {
              case 'C':
                $('<input required name="' + columnOptions.field + '" data-required-msg="' + cobis.translate("BSSNS.MSG_BSSNS_CAMPOREDR_21366") + '" />').appendTo(container)
                  .kendoDropDownList({
                    autoBind: true,
                    dataTextField: "value",
                    dataValueField: "code",
                    dataSource: $scope.getComboDataSourceGrid(idSection, idQuestion, i),
                    optionLabel: {
                      value: "Seleccione",
                      code: ""
                    }
                  });

                break;
              case 'M':
                elementAux = '<input required data-required-msg="' + cobis.translate("BSSNS.MSG_BSSNS_CAMPOREDR_21366") + '" name="' + columnOptions.field + '" kendo-numeric-text-box  k-format="\'c\'" k-decimals="3" k-min="0" k-max="9999999999"/>';
                container.append(elementAux);
                break;
              case 'N':
                elementAux = '<input required data-required-msg="' + cobis.translate("BSSNS.MSG_BSSNS_CAMPOREDR_21366") + '" name="' + columnOptions.field + '" kendo-numeric-text-box  k-format="\'n\'" k-decimals="0" k-min="0" k-max="9999999999"/>';
                container.append(elementAux);
                break;
              case 'F':
                elementAux = '<input required data-required-msg="' + cobis.translate("BSSNS.MSG_BSSNS_CAMPOREDR_21366") + '" name="' + columnOptions.field + '" kendo-ext-date-picker  placeholder="' + scope.datePlaceHolder + '" date-input=true date-format="' + scope.dateFormat + '"/>';
                container.append(elementAux);
                break;
            }
          }
        }

      };

      $scope.getColumnGridType = function (idSection, idQuestion, propertyName) {
        var gridData = $rootScope.result.section[idSection].questions[idQuestion].tableQuestion;
        if (gridData != null && angular.isDefined(gridData)) {
          return gridData[idQuestion].type;
        } else {
          return null;
        }
      }

      $scope.createGrid = function (idSection, idQuestion, enabled) {
        var data = {
          columns: $scope.getColumns(idSection, idQuestion, enabled),
          dataSource: $scope.getDataSource(idSection, idQuestion, enabled),
          toolbar: $scope.getToolbar(enabled),
          editable: $scope.getEnabledGrid(enabled),
          autoBind: true,
          pageable: true,
          scrollable: true,
          dataBound: function(e) {
            $scope.gridEvents.preventEdit();
          }	  
        }

        return data;
      };
	  
	  $scope.getToolbar = function(enabled){
		  if(enabled==='N'){
			  return [];
		  }else{
			  return [{name: "create"}];
		  }

	  }

	  $scope.getEnabledGrid = function(enabled){
		  if(enabled==='N'){
			return false;
		  }else{
			  return {createAt: "top",
					mode: "inline",
					create: true,
					update: true,
					destroy: true,
					createAt: "bottom"
				  }
		  }
	  }

      $scope.gridEvents = {
        preventEdit: function (e) {
          //Buscar grids
          var grids = $("#principal").find(".k-grid");
          if(grids.length > 0 && $rootScope.gridNumbers == grids.length ){
            var test = 0;
            for(var i = 0; i< grids.length ;i++){
              $(".k-grid").on("mousedown", ".k-button:not('.k-grid-cancel,.k-grid-update')", function(e) {
                var grid = $(this).closest(".k-grid");
                var editRow = grid.find(".k-grid-edit-row");				

                if (editRow.length > 0 && $scope.numberMessagesPreventDefault===0) {
					$scope.isPending = true;
                      $scope.numberMessagesPreventDefault++;
                     cobis.showMessageWindow.confirm(cobis.translate("BSSNS.MSG_BSSNS_PORFAVOAI_96782"), cobis.translate("BSSNS.MSG_BSSNS_MENSAJESU_49015"), [cobis.translate("BSSNS.MSG_BSSNS_ACEPTARAI_46209")]).done(function (resp) {
                      if(resp.buttonIndex === 0){
                        e.preventDefault();
                        if($scope.numberMessagesPreventDefault>=1){
                          $scope.numberMessagesPreventDefault=0;
                        }

                      }
                    });
                }
              });
				$(".k-grid").on("mousedown",".k-button:not('.k-grid-cancel,.k-grid-edit,.k-grid-delete,.k-grid-add')",function(e) {
					var grid = $(this).closest(".k-grid");					
					$scope.validateData(grid,e);
				});
				$(".k-grid").on("keydown",".k-button:not('.k-grid-cancel,.k-grid-edit,.k-grid-delete,.k-grid-add')",function(e) {
					var grid = $(this).closest(".k-grid");					
					$scope.validateData(grid,e);
				});
            };
          }
        }
      };
	  $scope.validateData = function (grid, e){
			var editRow = grid.find(".k-grid-edit-row");
			var gridK = grid.data("kendoGrid");
			$scope.isPending = false;
			if(angular.isDefined(editRow[0])){
				var gridId = grid[0].id;
				var section = grid[0].id.substring(grid[0].id.indexOf("S")+1,grid[0].id.indexOf("Q"));
				var question = grid[0].id.substring(grid[0].id.indexOf("Q")+1,grid[0].id.length);
				var rowIndex = editRow[0].rowIndex;
				var row = {};
				var repeated='';
				var rows = null;
				
				for(var i=0; i <$rootScope.result.section.length; i++){
					if($rootScope.result.section[i].idSection==section){
						for(var j=0; j<$rootScope.result.section[i].questions.length; j++){
							if($rootScope.result.section[i].questions[j].idQuestion==question){
								rows = $rootScope.result.section[i].questions[j].rows;
								repeated = $rootScope.result.section[i].questions[j].repeated;
							}
						}
					}
				}
				var data = gridK.dataSource.data();
				if(rows != null && rows > 0){
					if(data.length > rows){
						cobis.getMessageManager().showMessagesError("Solo se permiten "+rows+" registros en esta pregunta",null, 6000, false);
						gridK.cancelRow();
						return;
					}
				}
				if(repeated ==='N'){							
					row = data[rowIndex];
					for(var i=0; i<data.length;i++){
						if(i!=rowIndex){							
							if(angular.isDefined(row.TIPODEINGRESO) && row.TIPODEINGRESO===data[i].TIPODEINGRESO){
								cobis.getMessageManager().showMessagesError("Ya existe un registro de este tipo",null, 6000, false);
								gridK.cancelChanges();
							}else if(angular.isDefined(row.TIPODEGASTO) && row.TIPODEGASTO===data[i].TIPODEGASTO){
								cobis.getMessageManager().showMessagesError("Ya existe un registro de este tipo",null, 6000, false);
								gridK.cancelChanges();
							}
						}
					}		
				}

			}
	  };

      $scope.getColumnFormat = function (columnType) {
        //Moneda
        if (columnType === "M") {
          return "{0:c}";
        } else if (columnType === "N") { //numero
          return "{0:n}";
        } else if (columnType === "F") { //fecha
          return "{0: dd-MM-yyyy}";
        }
      };


      //Funcion guardar por seccion
      $scope.saveBySection = function () {
        var validator = $("#principal").data("kendoValidator");
		if($scope.isPending){
			cobis.getMessageManager().showMessagesError("Existen Datos Pendientes de Confirmar",null, 6000, false);
		}
        if (validator.validate()&& !$scope.isPending) {		  
          //Loading
          $scope.showLoading();

          var numberSections = $rootScope.result.section.length;
          //Objeto de respuesta
          var resultObject = {
            customerId: $scope.customerId,
            formId: $rootScope.result.idForm, //$rootScope.idForm
            formVersion: $rootScope.result.version, //$rootScope.formVersion
            processInstance: $scope.vc.parentVc.parentVc.model.Task.processInstanceIdentifier,
            answerData: []
          };

          //Recorrer secciones
          for (var i = 0; i < numberSections; i++) {
            //Numero de preguntas por seccion
            var numberQuestion = $rootScope.result.section[i].questions.length;
            for (var j = 0; j < numberQuestion; j++) {
              //Objeto Aux General
              var resultObjectAux = {
                answer: {
                  idAnswer: null,
                  answerDesc: null,
                  answerType: null
                },
                question: {
                  idQuestion: null,
                  type: null
                }
              };

              //Objeto Aux Grid
              var resultObjectAuxGrid = {
                answer: {
                  idAnswer: null,
                  answerDesc: null,
                  rowList: null
                },
                question: {
                  idQuestion: null,
                  type: null
                }
              }

              if ($rootScope.result.section[i].questions[j].type !== "T") {
                var value = $("#vaS" + $rootScope.result.section[i].idSection + "Q" + $rootScope.result.section[i].questions[j].idQuestion).length > 0 ? $("#vaS" + $rootScope.result.section[i].idSection + "Q" + $rootScope.result.section[i].questions[j].idQuestion)[0].value : null;
                //Seteo de propiedades de pregunta
                resultObjectAux.answer.answerDesc = value;
                resultObjectAux.answer.answerType = $rootScope.result.section[i].questions[j].type;
                resultObjectAux.question.idQuestion = $rootScope.result.section[i].questions[j].idQuestion;
                resultObjectAux.question.type = $rootScope.result.section[i].questions[j].type;
                //Agregar respuesta a objeto final
                resultObject.answerData.push(resultObjectAux);
              } else {
                //Implementacion guardado de grid
                var grid = $("#vaS" + $rootScope.result.section[i].idSection + "Q" + $rootScope.result.section[i].questions[j].idQuestion).length > 0 ? $("#vaS" + $rootScope.result.section[i].idSection + "Q" + $rootScope.result.section[i].questions[j].idQuestion).data("kendoGrid") : null;
                var dataSource = grid.dataSource.data();
                var columns = grid.columns;
                var row = [];

                for (var k = 0; k < dataSource.length; k++) {
                  var columnId = 0;
                  //Objeto filas grid
                  var columnRowList = {
                    columns: []
                  }

                  dataSource[k].forEach(function (element, index) {
                    //Objeto columnas Grid
                    var columnGrid = {
                      column: null,
                      answerDesc: null,
                      anwserType: null
                    }
                    if (index !== "id") {
                      columnGrid.column = columnId + 1;
                      if (angular.isDefined(element.code)) {
                        columnGrid.answerDesc = element.code;
                      } else {
                        columnGrid.answerDesc = element;
                      }
                      columnGrid.anwserType = columns[columnId].type;
                      columnRowList.columns.push(columnGrid);
					  columnId++;
                    }
                  })
                  row.push(columnRowList);

                }
                resultObjectAuxGrid.answer.rowList = row;
                resultObjectAuxGrid.question.idQuestion = $rootScope.result.section[i].questions[j].idQuestion;
                resultObjectAuxGrid.question.type = $rootScope.result.section[i].questions[j].type;

                //Agregar respuesta a objeto final
                resultObject.answerData.push(resultObjectAuxGrid)
              }

            }

          }

          queryBussinesCustomer.saveCustomer(resultObject).then(function (response) {
            if (response.result) {
			  if(response.message !="0"){
				cobis.getMessageManager().showMessagesInformation(response.message, null, 6000, false);
			  }
              cobis.getMessageManager().showMessagesSuccess("BSSNS.MSG_BSSNS_INACINXSV_68841", null, 6000, false);
              $scope.vc.parentVc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"
            } else {
              cobis.getMessageManager().showMessagesError("BSSNS.MSG_BSSNS_ERRORALIC_44303", null, 6000, false);
              $scope.vc.parentVc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"
            }
            $scope.hideLoading();
          }).catch(function (error) {
            if (error.messages.length > 0) {
              error.messages.forEach(function (item, index) {
                cobis.getMessageManager().showMessagesError(item.message);
              });

            }
            cobis.getMessageManager().showMessagesError("BSSNS.MSG_BSSNS_ERRORALIC_44303", null, 6000, false);
            $scope.vc.parentVc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"
            $scope.hideLoading();
          });
        } else if(!$scope.isPending) { //Fin If guardar
          cobis.getMessageManager().showMessagesError("BSSNS.MSG_BSSNS_EXISTENCE_98580", null, 6000, false);
        }

      };

      $scope.showLoading = function () {
        cobis.showMessageWindow.loading(true);
      }

      $scope.hideLoading = function () {
        cobis.showMessageWindow.loading(false);
      }
    }
  ]);

  window.cobisMainModule = app;
})(window);