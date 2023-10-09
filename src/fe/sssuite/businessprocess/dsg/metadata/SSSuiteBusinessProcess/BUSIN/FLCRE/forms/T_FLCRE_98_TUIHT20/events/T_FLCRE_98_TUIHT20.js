//"TaskId": "T_FLCRE_98_TUIHT20"
var fechaCorte = new Date();

//Eventos manuales
	task.flowOrMassive = function (entities,args){		
		var viewState = args.commons.api.viewState;
		if(entities.generalData.parameterMassive){//por carga masiva
			BUSIN.API.GRID.hideCommandColumns('QV_URPUH4848_33', args.commons.api.vc.model.Punishment.data(), args.commons.api, 'VA_VIWPUISHMN4305_CTDT569');
			/*var commandsGrid=$("#QV_URPUH4848_33").data("kendoExtGrid");
			commandsGrid.hideColumn(10);*/
		}else{//por flujo
			args.commons.api.grid.hideToolBarButton('QV_URPUH4848_33', 'CEQV_201QV_URPUH4848_33_906');// boton importar																													
			var columnsToHide = ['selection'];
			BUSIN.API.GRID.hideColumns('QV_URPUH4848_33',columnsToHide,args.commons.api);			
			/*var commandsGrid=$("#QV_URPUH4848_33").data("kendoExtGrid");
			commandsGrid.hideColumn(11);*/
			
			BUSIN.API.GRID.hideCommandColumns('QV_URPUH4848_33', entities.Punishment.data(), args.commons.api, 'VA_GRIDROWCOMMMAAD_775N43');
			var ctrsToHide=['CM_TFLCRE_9_L85','CM_TFLCRE_9_2_8','CM_TFLCRE_9_342'];//
			BUSIN.API.hide(viewState,ctrsToHide);
			
		}
	};

//Evento closeModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: TPunishment
	task.closeModalEvent.uploadFile = function (resultObj){    
	//task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
		if(resultObj.vcId=="uploadFile"){
			resultObj.commons.api.vc.model.Operations = resultObj.result.operations;
			//envio a boton
			resultObj.commons.api.vc.executeCommand('CM_TFLCRE_9_98R','enviar', undefined, true, false, 'VC_TUIHT20_TIHNT_960', false);
		}
	};


      task.gridRowCommand.VA_CHECKBOXSNOAAAG_461_05 = function (entities, args) { 
      var viewState = args.commons.api.viewState;
	  BUSIN.API.disable(viewState,['CM_TFLCRE_9_342']);		  
	  args.commons.execServer = true;
        args.commons.serverParameters.Punishment = true;

	};
//Fin Eventos Manuales