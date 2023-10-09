//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ProspectComposite
task.onCloseModalEvent = function(entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;

    if (onCloseModalEventArgs.closedViewContainerId == 'VC_CONFIRMMGG_786394') {
        let option = onCloseModalEventArgs.result === null ? 2 : onCloseModalEventArgs.result.option;
        if (option === 1) {

            onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONUBNHVJA_668739', 'save', undefined, true, false, 'VC_PROSPECTMI_213684', false);


        } else {
		    //(accion, padre, hijo-del la misma pantalla compuesta)
		    onCloseModalEventArgs.commons.api.vc.clickTab(onCloseModalEventArgs, 'VC_VUWWUPIBAH_277684', 'VC_ODXEZDWELG_370723', true);
			
		    $("#VC_ODXEZDWELG_370723_tab").prop("class","active"); // a que opcion debe ir
			$("#VC_OHGJMSCFAL_971769_tab").removeClass("active"); // quitar el color de la opcion donde estaba
			$("#VC_RIZJHPLTPZ_320966_tab").removeClass("active"); // quitar el color de la opcion donde estaba

            return;
        }
    }

    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ADDRESSITS_306302') {
        if (onCloseModalEventArgs.result.resultArgs !== null) {

            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                    onCloseModalEventArgs.commons.api.grid.addRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.data);
                } else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }

        }
    }
};