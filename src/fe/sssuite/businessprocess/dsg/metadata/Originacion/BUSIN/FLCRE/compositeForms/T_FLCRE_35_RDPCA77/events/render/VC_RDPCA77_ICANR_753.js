//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ApprovedApplication
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = renderEventArgs.commons.api.viewState;	
		
		task.showButtons(renderEventArgs);
		
		//********Parametros
		//********Modo
		//Modo Consulta
		if(parentParameters.Task.urlParams.Modo==FLCRE.CONSTANTS.Mode.Query){			
		}
		//********Etapas
		//Aprobacion
		if(parentParameters.Task.urlParams.Etapa==FLCRE.CONSTANTS.Stage.Aprobacion){			
		}	
		
		//********Tramite
		//Refinanciamiento, Reestructuracion, Renovacion
		if(parentParameters.Task.urlParams.Tramite==FLCRE.CONSTANTS.RequestName.Refinancing
		||parentParameters.Task.urlParams.Tramite==FLCRE.CONSTANTS.RequestName.Renovation
		||parentParameters.Task.urlParams.Tramite==FLCRE.CONSTANTS.RequestName.Reestructuration
		){
			
		}
        
    };

task.showButtons = function(args){
		var api = args.commons.api;
		var parentParameters = args.commons.api.parentVc.customDialogParameters;
		//Boton Principal (Wizard)
		//initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
		//	initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
		//}
		
		//Boton Secundario 1 (Wizard)
		//(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
		//(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
		//(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
		//(Tiene una limitacion de 5 axecute commands)
		
		if(parentParameters.Task.urlParams.Modo!= undefined&&parentParameters.Task.urlParams.Modo!=null
		&&parentParameters.Task.urlParams.Modo==FLCRE.CONSTANTS.Mode.Query){
			args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		}else{
			args.commons.api.vc.parentVc.labelExecuteCommand1 = "Autorizar";
			args.commons.api.vc.parentVc.executeCommand1 = function(){
				args.commons.api.vc.executeCommand('CM_RDPCA77SAE65','Autorizar', undefined, true, false, 'VC_RDPCA77_ICANR_753', false);
			}	
		}		
	};