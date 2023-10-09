// () View: View of [object Object]
  //Evento changeGroup : Evento change para pestañas, collapsible y accordion.
  task.changeGroup.GR_VWPAYMENLA26_10 = function (entities, changedGroupEventArgs){
		var viewState = changedGroupEventArgs.commons.api.vc.viewState;
        changedGroupEventArgs.commons.execServer = false;
        // changedGroupEventArgs.commons.serverParameters.entityName = true;
        if((changedGroupEventArgs.commons.item.id === 'GR_VWPAYMENLA26_13') && (changedGroupEventArgs.commons.item.isOpen === true)){
			viewState.CM_TPYEP21MTE89.visible = false;
        }else if((changedGroupEventArgs.commons.item.id === 'GR_VWPAYMENLA26_12') && (changedGroupEventArgs.commons.item.isOpen === true)){
			viewState.CM_TPYEP21MTE89.visible = true;
		}else if((changedGroupEventArgs.commons.item.id === 'GR_VWPAYMENLA26_20') && (changedGroupEventArgs.commons.item.isOpen === true)){
			viewState.CM_TPYEP21MTE89.visible = true;
			var numberItems = entities.AmortizationTableItem.data().length;
			task.setScrollAmortizationTable(numberItems, changedGroupEventArgs.commons.api);			
		}
  };