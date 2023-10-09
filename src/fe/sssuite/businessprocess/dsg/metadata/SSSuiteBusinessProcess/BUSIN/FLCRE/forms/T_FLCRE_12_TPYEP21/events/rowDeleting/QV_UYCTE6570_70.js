//gridRowDeleting QueryView: GridCategoryPlan
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_UYCTE6570_70 = function (entities, gridRowDeletingEventArgs) {
		var categories = angular.copy(entities.Category.data());
		categories.push(gridRowDeletingEventArgs.rowData);
		var num_cap= 0, num_int= 0, num_mora = 0;
		var execute = false;
		categories.forEach(function (item){
			switch(item.ConceptType){
				case 'C':
					num_cap++;
				break;
				case 'I':
					num_int++;
				break;
				case 'M':
					num_mora++;
				break;
				default:
				break;
			}
		});
		
		if(num_cap > 1 && gridRowDeletingEventArgs.rowData.ConceptType == 'C'){
			execute = true;			
		}else if(num_int > 1 && gridRowDeletingEventArgs.rowData.ConceptType =='I'){
			execute = true;
		}else if(num_mora > 1 && gridRowDeletingEventArgs.rowData.ConceptType =='M'){
			execute = true;
		}else if(gridRowDeletingEventArgs.rowData.ConceptType!='C' && gridRowDeletingEventArgs.rowData.ConceptType !='I' && gridRowDeletingEventArgs.rowData.ConceptType !='M'){
			execute = true;
		}
		else{
			//entities.Category.data(categories);		
			gridRowDeletingEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_MGERRCAPA_66886');
			gridRowDeletingEventArgs.commons.execServer = false;
			gridRowDeletingEventArgs.cancel = true;
			return false;
		}
		
		if(execute){
			gridRowDeletingEventArgs.commons.execServer = true;
			gridRowDeletingEventArgs.commons.serverParameters.Category = true;
			gridRowDeletingEventArgs.commons.serverParameters.PaymentPlanHeader = true;
			//gridRowDeletingEventArgs.cancel = true;
			return false;
		}
    };