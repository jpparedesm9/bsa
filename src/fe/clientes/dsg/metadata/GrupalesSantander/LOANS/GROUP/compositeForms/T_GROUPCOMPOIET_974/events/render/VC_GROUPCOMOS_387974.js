//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: GroupComposite
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    renderEventArgs.commons.api.viewState.disable('G_MEMBERIDUM_459848', true);
    //renderEventArgs.commons.api.viewState.disable('G_AMOUNTGUDN_676190', true);
    var viewState = renderEventArgs.commons.api.viewState;		
	var api = renderEventArgs.commons.api;
    var parentVc = renderEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = customDialogParameters;
    if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        if (stage == LOANS.CONSTANTS.Stage.INGRESO || stage == LOANS.CONSTANTS.Stage.APROBAR ) { //****EN ETAPA DE INGRESO
            viewState.disable('VC_MQTFHWQRXJ_599520'); // Se deshabilita la parte de grupo
            //api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla
            if (stage == 'APROBAR') {
				api.grid.hideToolBarButton('QV_7978_25243', 'create');
			}
           // task.hideButtonGridMember(renderEventArgs, 'Member', 'QV_7978_25243');
          //habilita las columnas de la grilla de montos y boton en montos
            renderEventArgs.commons.api.viewState.enable('VA_VABUTTONNPVXIJW_123190');
            renderEventArgs.commons.api.viewState.enable('VC_ZFXQOGVCIH_421740');
			api.grid.enabledColumn('QV_6248_19660','secuential');
			api.grid.enabledColumn('QV_6248_19660','memberName');
			api.grid.enabledColumn('QV_6248_19660','cycleParticipation');
			api.grid.enabledColumn('QV_6248_19660','amount');
			api.grid.enabledColumn('QV_6248_19660','authorizedAmount');
			api.grid.enabledColumn('QV_6248_19660','voluntarySavings');
			api.grid.disabledColumn('QV_6248_19660','proposedMaximumSaving');
            api.grid.disabledColumn('QV_6248_19660','increment');
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
            
        }
        if (stage =='CONSULTA') { //EN ETAPA DE Consulta
            viewState.disable('VC_MQTFHWQRXJ_599520'); // Se deshabilita la parte de grupo
            api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla
            task.hideButtonGridMember(renderEventArgs, 'Member', 'QV_7978_25243');
            //se desabilita las columnas de la grilla de montos y boton en montos
            renderEventArgs.commons.api.viewState.disable('VA_VABUTTONNPVXIJW_123190');
			api.grid.disabledColumn('QV_6248_19660','secuential');
			api.grid.disabledColumn('QV_6248_19660','memberName');
			api.grid.disabledColumn('QV_6248_19660','cycleParticipation');
			api.grid.disabledColumn('QV_6248_19660','amount');
			api.grid.disabledColumn('QV_6248_19660','authorizedAmount');
			api.grid.disabledColumn('QV_6248_19660','voluntarySavings');
			api.grid.disabledColumn('QV_6248_19660','proposedMaximumSaving');   
            api.grid.disabledColumn('QV_6248_19660','increment'); 
            api.grid.hideColumn('QV_6248_19660','safePackage');
            
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
         $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXLEH_921190']").prop("disabled", "disabled");
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXUPR_288190']").prop("disabled", "disabled");
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
             $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
        }
        
        if (stage == LOANS.CONSTANTS.Stage.ELIMINAR) { //****EN ETAPA DE ELIMINAR
            viewState.disable('VC_MQTFHWQRXJ_599520'); // Se deshabilita la parte de grupo
            api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla
            // task.hideButtonGridMember(renderEventArgs, 'Member', 'QV_7978_25243');
            // habilita las columnas de la grilla de montos y boton en montos
            renderEventArgs.commons.api.viewState.enable('VA_VABUTTONNPVXIJW_123190');
            renderEventArgs.commons.api.viewState.enable('VC_ZFXQOGVCIH_421740');
			api.grid.enabledColumn('QV_6248_19660','secuential');
			api.grid.enabledColumn('QV_6248_19660','memberName');
			api.grid.enabledColumn('QV_6248_19660','cycleParticipation');
			api.grid.enabledColumn('QV_6248_19660','amount');
			api.grid.enabledColumn('QV_6248_19660','authorizedAmount');
			api.grid.enabledColumn('QV_6248_19660','voluntarySavings');
			api.grid.disabledColumn('QV_6248_19660','proposedMaximumSaving');
            api.grid.hideColumn('QV_6248_19660','safePackage');
        }		
        
        if(stage=='APROBAR'){
            //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            api.grid.showColumn('QV_6248_19660','safePackage');
            cobis.showMessageWindow.loading(true);
        }
    }
    
        
    if(type == typeIngreso && typeOrigin != LOANS.CONSTANTS.TypeOrigin.FLUJO){ // MENU ETAPA DE INGRESO     
		viewState.disable('VA_TEXTINPUTBOXGPY_589725');
		viewState.disable('VC_ZFXQOGVCIH_421740',true);
	}
    if((parentParameters!=null) && (parentParameters!=undefined)){
        if(parentParameters.Task.urlParams.TIPO=="C"){ // ESPERA CANCELACION DE CREDITO ACTIVO     
            viewState.show('CM_TGROUPCO_IRO');
            viewState.disable('CM_TGROUPCO_IRO');
            renderEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
        }
    }
   
};