//Entity: GuaranteesBtn
    //GuaranteesBtn. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_UARNTEESEW9610_0000924 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
		/*var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_35_RRCAI67','VC_RRCAI67_WACRI_884');
		nav.modalProperties = { size: 'lg' };
		nav.customDialogParameters = { maxRelation : task.getMaxPrelation(entities)};
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);*/
        FLCRE.UTILS.GUARANTEE.openFindGuarantee(entities,executeCommandEventArgs,{});
        
    };

task.getMaxPrelation = function(entities){
		var relations = [];
		entities.PersonalGuarantor.data().forEach(function(garPersonal){
			relations.push(garPersonal.relation);
		});
		entities.OtherWarranty.data().forEach(function(garOther){
			relations.push(garOther.relation);
		});
		relations.sort(function(elem1, elem2){
			return elem2-elem1;
		});
		return relations[0];
	};

//CloseModal Creacion de Garantias
	task.closeModalEvent.VC_RRCAI67_WACRI_884 = function(eventArgs){
		var response = eventArgs.result;	
		
		if(response!=null && response!=undefined){			
			if(response.Type != 'GARGPE'){
				var otherWarranties = eventArgs.commons.api.vc.model.OtherWarranty==undefined?[]:eventArgs.commons.api.vc.model.OtherWarranty.data();
				otherWarranties.forEach(function(otherWarrantyItem){
					if(otherWarrantyItem.CodeWarranty == response.CodeWarranty){
						otherWarrantyItem.CodeWarranty = response.CodeWarranty;
						otherWarrantyItem.Type= response.Type;
						otherWarrantyItem.Description= response.Description;
						otherWarrantyItem.InitialValue= response.InitialValue;
						otherWarrantyItem.DateAppraisedValue= response.DateAppraisedValue;
						otherWarrantyItem.ValueApportionment= response.ValueApportionment;
						otherWarrantyItem.ClassOpen= response.ClassOpen;
						otherWarrantyItem.ValueAvailable= response.ValueAvailable;
						otherWarrantyItem.IdCustomer= response.IdCustomer;
						otherWarrantyItem.NameGar= response.NameGar;
						otherWarrantyItem.State= response.State;
						otherWarrantyItem.Flag= response.Flag;
						otherWarrantyItem.IsNew= response.IsNew;
						otherWarrantyItem.ValueVNR= response.ValueVNR;
						otherWarrantyItem.RelationshipGuarantees= response.RelationshipGuarantees;
						otherWarrantyItem.isHeritage= response.isHeritage;
						otherWarrantyItem.relation= response.relation;
					}
				})
				eventArgs.commons.api.vc.model.OtherWarranty.data(otherWarranties);
			}else{
				var personalWarranties = eventArgs.commons.api.vc.model.PersonalGuarantor==undefined?[]:eventArgs.commons.api.vc.model.PersonalGuarantor.data();
				personalWarranties.forEach(function(personalWarrantyItem){
					if(personalWarrantyItem.CodeWarranty == response.CodeWarranty){
						personalWarrantyItem.CodeWarranty = response.CodeWarranty;
						personalWarrantyItem.Type = response.Type;
						personalWarrantyItem.Description = response.Description;
						personalWarrantyItem.GuarantorPrimarySecondary = response.GuarantorPrimarySecondary;
						personalWarrantyItem.ClassOpen = response.ClassOpen;
						personalWarrantyItem.IdCustomer = response.IdCustomer;
						personalWarrantyItem.State = response.State;
						personalWarrantyItem.DateCIC = response.DateCIC;
						personalWarrantyItem.isHeritage = response.isHeritage;
						personalWarrantyItem.CurrentValue = response.CurrentValue;
						personalWarrantyItem.Currency = response.Currency;
					}
				})
				eventArgs.commons.api.vc.model.PersonalGuarantor.data(personalWarranties);
			}
			//Set del campo HiddenInCompleted para poder continuar la tarea
			eventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		}
    };   