//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: CustomerComposite
task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
    onCloseModalEventArgs.commons.execServer = false;

    gridRow = -1;
    var isAccept;

    
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_CONFIRMMGG_786394') {        
        let option = onCloseModalEventArgs.result == null ? 2 : onCloseModalEventArgs.result.option;
        if (option === 1){
            onCloseModalEventArgs.commons.api.vc.executeCommand('CM_TCUSTOME_T26', 'save', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
        }else{
		    //(accion, padre, hijo-del la misma pantalla compuesta)
		    onCloseModalEventArgs.commons.api.vc.clickTab(onCloseModalEventArgs, 'VC_DDRWXFYTSU_498680', 'VC_KXWIBTYNCU_272226', true);

		    $("#VC_KXWIBTYNCU_272226_tab").prop("class","active"); // a que opcion debe ir
			$("#VC_FTDSYJBGDX_891186_tab").removeClass("active"); // Datos Demograficos - quitar el color de la opcion donde estaba
			$("#VC_GQKQIIYSWN_251604_tab").removeClass("active"); // Conyuge - quitar el color de la opcion donde estaba			
			$("#VC_HVDQINWTYF_467680_tab").removeClass("active"); // Documento digitalizados - quitar el color de la opcion donde estaba
			$("#VC_CFFKBKPJOS_961735_tab").removeClass("active"); // Capacidad de Pago - quitar el color de la opcion donde estaba
			$("#VC_BZHSCWLUJU_302769_tab").removeClass("active"); // Direcciones y correos electronicos - quitar el color de la opcion donde estaba
			$("#VC_RRLBYDXROB_523114_tab").removeClass("active"); // Negocios del Cliente - quitar el color de la opcion donde estaba
			$("#VC_QQHYLHYLXD_897494_tab").removeClass("active"); // Relacion entre Clientes - quitar el color de la opcion donde estaba
			$("#VC_XISAWPDNOD_912400_tab").removeClass("active"); // Datos Solicitud Complementaria - quitar el color de la opcion donde estaba			
            return;
        }
    }
    
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ECONOMICOU_167751') {
        if (typeof onCloseModalEventArgs.result === "boolean") {
            isAccept = onCloseModalEventArgs.result;
        }
        if (isAccept) {
            //Refrescar el grid 
            if (entities.Entity1.refreshGrid == null || entities.Entity1.refreshGrid == false) {
                entities.Entity1.refreshGrid = true;
            } else {
                entities.Entity1.refreshGrid = false;
            }
        }
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ADDRESSITS_306302') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                    onCloseModalEventArgs.commons.api.grid.addRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.data);
                }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
        onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    }
if (onCloseModalEventArgs.closedViewContainerId == 'VC_BUSINESSPP_740722') {
    if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('Business', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Business', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
      }
      onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);//Para que recuper la info de la base a pesar de que dio error
    }
    //Caso 155939
    /*if (onCloseModalEventArgs.closedViewContainerId == 'VC_REFERENCPP_688957') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {

                    onCloseModalEventArgs.commons.api.grid.addRow('References', onCloseModalEventArgs.result.resultArgs.data);

                }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('References', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
    }*/
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_REPLACEAII_570116') {
        if(onCloseModalEventArgs.result.resultArgs != null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    entities.NaturalPerson.accountIndividual = onCloseModalEventArgs.result.resultArgs.accountIndividual; 
                }
            }
        } else if(onCloseModalEventArgs.result.resultArgs === undefined){
            entities.NaturalPerson.accountIndividual = entities.Context.accountIndividual;
        }
    }
};