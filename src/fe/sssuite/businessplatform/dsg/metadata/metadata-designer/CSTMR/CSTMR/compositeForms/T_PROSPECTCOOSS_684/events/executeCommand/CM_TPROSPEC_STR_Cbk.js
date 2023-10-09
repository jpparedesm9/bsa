//Start signature to Callback event to CM_TPROSPEC_STR
task.executeCommandCallback.CM_TPROSPEC_STR = function(entities, executeCommandCallbackEventArgs) {
//here your code
    var  controls = [];
    
     if(executeCommandCallbackEventArgs.success ){  
         if(entities.NaturalPerson.riskLevel!='ROJO' && entities.NaturalPerson.santanderCode!=null){
            executeCommandCallbackEventArgs.commons.api.viewState.show('CM_TPROSPEC_T8S',true);
            executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_STR',true); 
        } /*else {  //se envia en el java
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError('CSTMR.LBL_CSTMR_ELNIVELUT_98836',true);
        }*/
         
         if ( entities.NaturalPerson.bioRenapoResult == 'S'){
            controls =  [
                'VA_TEXTINPUTBOXBFT_518739','VA_TEXTINPUTBOXWXT_116739','VA_TEXTINPUTBOXVEC_991739','VA_TEXTINPUTBOXBXR_146739',                      
                'VA_TEXTINPUTBOXFGQ_850739','VA_DOCUMENTTYPEFZR_461739','VA_TEXTINPUTBOXNJK_823739','VA_DATEFIELDEXOTID_585739',
                'VA_EMAILVIWJAKIOCI_922739','VA_TEXTINPUTBOXGXM_696739','VA_DATEFIELDKWUZZN_303739','VA_TEXTINPUTBOXJOG_550739',
                'VA_TEXTINPUTBOXECU_912739','VA_TEXTINPUTBOXHWM_415739','VA_TEXTINPUTBOXVJE_867739','VA_TEXTINPUTBOXNVW_269739',
                'VA_TEXTINPUTBOXDTF_989739','VA_TEXTINPUTBOXDFU_862739','VA_TEXTINPUTBOXDYK_693739','VA_TEXTINPUTBOXXGF_770739',
                'VA_DATEFIELDKPKNOQ_427739','VA_BIRTHDATEHFEDFC_460739','VA_TEXTINPUTBOXTMT_413739','VA_TEXTINPUTBOXBNS_113739',
                'VA_TEXTINPUTBOXKUG_213739','VA_TEXTINPUTBOXNLL_783739','VA_TEXTINPUTBOXDXR_200739','CM_TPROSPEC_MT4',
                'VA_TEXTINPUTBOXXTK_742739','VA_EMAILADDRESSOAU_817739','VA_GENDERCODEVBBDG_772739', 'VA_9419JJQLECKWUON_319739',
                'VA_COUNTYOFBIRTHHH_490739','VA_COUNTRYOFBIRHTH_170739'];
             executeCommandCallbackEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MT4',true); 
             LATFO.UTILS.disableFields(executeCommandCallbackEventArgs, controls, true);
        }
         
     }
       
	   //Reporte
    if (entities.Context.generateReport) {
	     var nameReport = entities.Context.nameReport;
	     var tittle = "";	
         if(entities.Context.printReport){
			 var args = [['report.module', 'customer'],['report.name', nameReport],['idCustomer',entities.NaturalPerson.personSecuential]];	
			 if(nameReport === 'BuroCreditoHistorico'){
				 tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTETI_28269');
			}else if(nameReport === 'BuroCreditoInternoExterno'){
				tittle = cobis.translate('CSTMR.LBL_CSTMR_REPORTEEI_96019');
			}
			LATFO.UTILS.generarReporte(nameReport, args, tittle); 
		 }else{
			 executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesInfo('CSTMR.MSG_CSTMR_ELREPOREE_57555');
         }       
        if(entities.ScannedDocumentsDetail.data().length != 0){
            for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                if(entities.ScannedDocumentsDetail.data()[i].uploaded === false){
                    executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("No est\u00e1n cargados todos los documentos");
                }
            }
        }
     }
};