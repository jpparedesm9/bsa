    //Start signature to callBack event to VC_OIIRL51_CNLTO_343
    task.initDataCallback.VC_OIIRL51_CNLTO_343 = function(entities, initDataEventArgs) {
        entities.EntidadInfo.oficina = entities.EntidadInfo.oficina == null || entities.EntidadInfo.oficina == '' || entities.EntidadInfo.oficina == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code + "" : entities.EntidadInfo.oficina;
        task.loadTaskHeader(entities, initDataEventArgs);
        /*var parentParameters = initDataEventArgs.commons.api.parentVc.model;*/
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        var sectionrender = parentParameters.Task.urlParams.RENDER_SECTION;
        /* if (sectionrender == 'S') {
             task.renderConfigurationFieldByProduct(entities, initDataEventArgs);
         }
         if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Reestructuration) {
             if (entities.generalData.productReest != undefined && entities.generalData.productReest != null && entities.generalData.productReest == entities.OriginalHeader.ProductType) {
                 initDataEventArgs.commons.api.vc.loadCatalog('VA_ORIAHEADER8602_URQT595', false, false, true, null);
             }
         }*/ //SMO no existe en grupales
        var viewState = initDataEventArgs.commons.api.viewState; //SMO se agrega de grupales
        task.change.VA_ORIAHEADER8608_ALTA466(entities, initDataEventArgs);
        entities.OriginalHeader.CurrencyRequested="0";
        /* // lanzar loadCatalog en destinoEconomico
         if (entities.EntidadInfo.destinoEconomico !== 'N00000000' && entities.EntidadInfo.destinoEconomico !== null) {
             initDataEventArgs.config = {};
             initDataEventArgs.config.filterType = "contains";
             initDataEventArgs.config.maxRecords = 20;
             var fil = [];
             fil.push({
                 value: entities.EntidadInfo.destinoEconomico
             });
             initDataEventArgs.filters = {
                 filters: fil
             };

             initDataEventArgs.commons.api.vc.loadCatalog("VA_ORIAHEADER8605_MIUS039", false, initDataEventArgs.filters, initDataEventArgs.config, 0);
         }*/ //SMO no existe en grupales
        //SMO se agrega de grupales
        //validaciÃ³n para mostrar el combo grupal en caso de que el prodcuto sea microcrÃ©dito
        /*if(entities.OriginalHeader.subTypeId != entities.generalData.subtypeProductId){
        	BUSIN.API.hide(viewState,['VA_GRUPALKFSXRLTTA_514W91']);
        }*/
        //Se cambia el sufijo de la moneda de acuerdo a la ingresada por el usuario
        viewState.suffix('VA_ORIAHEADER8602_OQUE134', entities.generalData.symbolCurrency);
        viewState.suffix('VA_ORIAHEADER8602_MICI826', entities.generalData.symbolCurrency);
        //Para que el campo tenga un valor
        if (entities.OriginalHeader.AmountRequested == null || entities.OriginalHeader.AmountRequested == 0 || entities.OriginalHeader.AmountRequested == 'undefined') {
            entities.OriginalHeader.AmountRequested = 0 //entities.OriginalHeader.AmountAprobed;
        }
        //Se oculta la pestaña de aval 
        var hideAux = ['VC_ZVXQIUJDIP_665L51']
        BUSIN.API.hide(viewState, hideAux);
        
        if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
            //Campos que se visualizan para tramite individual
            //'Plazo compuesto','plazo numero','plazo descripcion'
            var ctrsIndiHide = ['VA_ORIAHEADER8602_FICE546', 'VA_TERMLJXTQBYRQKU_619R86', 'VA_GRACESXJNMOZNOH_634R86',
                'VA_GRACESXJNMOZNOH_634R86', 'VA_TEXTINPUTBOXLZA_843R86', 'VA_7694PEJSETHIYUL_239R86',
                'VA_PAYMENTFREQUECN_439R86', 'CM_TFLCRE_8_TCR'];
            var ctrsIndiShow = ['VA_VACOMPOSITEMXIH_497R86', 'VA_TERMINDTMTELITU_695R86',       'VA_FREQUENCYLTUZDL_595R86',
                'VA_ISPARTNERZBPHXB_883R86', 'VC_ZVXQIUJDIP_665L51', 'VC_OIIRL51_TBRMT_122',
                'VA_PREVIOUSCREDUOT_690R86', 'VA_INSURANCEPACKEG_674R86','VA_TERMMEDICALAISS_991R86'];
            // se añade el control (VC_OIIRL51_TBRMT_122) porque se pierde el foco  y esto da como resultado que al iniciar la pagina se muestre primero la del aval
            var ctrsIndiDisable = ['VA_EJECUTIVOZUEHTQ_752W91', 'VA_ISPARTNERZBPHXB_883R86']
            BUSIN.API.hide(viewState, ctrsIndiHide);
            BUSIN.API.show(viewState, ctrsIndiShow);
			
			// Se agrega porque como resultado del caso 185234, se direccionaba a la pestaña de AVAL, ya que en el show cambia a la pestaña del aval
             initDataEventArgs.commons.api.vc.clickTab(initDataEventArgs, 'VC_OIIRL51_SNNMB_699', 'VC_OIIRL51_TBRMT_122', false);
            $("#VC_OIIRL51_TBRMT_122_tab").prop("class","active");
            $("#VC_ZVXQIUJDIP_665L51_tab").removeClass("active");
			
            BUSIN.API.disable(viewState, ctrsIndiDisable);
        } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
            var ctrsIndiDisable = ['VA_PAYMENTFREQUECN_439R86']
            var ctrsGrpHide =['VA_TERMINDTMTELITU_695R86','VA_FREQUENCYLTUZDL_595R86'];
            var ctrsGrpShow = ['VA_TERMLJXTQBYRQKU_619R86','VA_GRACESXJNMOZNOH_634R86','VA_PAYMENTFREQUECN_439R86'];
            BUSIN.API.hide(viewState, ctrsGrpHide);
            BUSIN.API.show(viewState, ctrsGrpShow);
            BUSIN.API.disable(viewState, ctrsIndiDisable);
        } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
            var ctrsRevHide =['VA_TERMINDTMTELITU_695R86','VA_FREQUENCYLTUZDL_595R86','VA_TERMLJXTQBYRQKU_619R86',
                              'VA_GRACESXJNMOZNOH_634R86', 'VA_PAYMENTFREQUECN_439R86'];
            var ctrsRevShow = ['VA_7694PEJSETHIYUL_239R86'];
            BUSIN.API.hide(viewState, ctrsRevHide);
            BUSIN.API.show(viewState, ctrsRevShow);
        }
        
        //SRO. Se comenta 147999
        //MTA Se deshabilita la pantalla de ingresos si el móvil está usando
        /*if (entities.Context.TaskSubject == 'INGRESAR SOLICITUD') { // VALIDACION SOLO PARA LA ETAPA DE INGRESO DE SOLICITUD
            var botonSincronizar = ['CM_TFLCRE_8_TCR']
            if (entities.Context.enable == "N") { //SE DESHABILITA LA PANTALLA PORQUE ESTAN UTILIZANDO EL MÓVIL
                var hideIngreso = ['VC_OIIRL51_SNNMB_699'] //grid vertical    
                BUSIN.API.disable(viewState, hideIngreso);
                BUSIN.API.hide(viewState, botonSincronizar);
            } else { //SE HABILITA LA PANTALLA
                BUSIN.API.enable(viewState, hideIngreso);
                BUSIN.API.hide(viewState, botonSincronizar); //PARA GRUPALES EL BOTON NO ESTA VISIBLE
                if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) { //SOLO PARA INDIVIDUALES EL BOTON SE MUESTRA
                    BUSIN.API.show(viewState, botonSincronizar);
                }
            }
        }*/ 
        
        var botonSincronizar = ['CM_TFLCRE_8_TCR']
        if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) { //SOLO PARA INDIVIDUALES EL BOTON SE MUESTRA
                    BUSIN.API.show(viewState, botonSincronizar);
        }
        if (entities.OriginalHeader.previousCreditAmount == null) {
            entities.OriginalHeader.previousCreditAmount = 0;
        }

        if (entities.ApplicationInfoAux.colectivo == undefined || entities.ApplicationInfoAux.colectivo == null || "" == entities.ApplicationInfoAux.colectivo.trim()) {
            var disableCollective = ['VA_NIVELCOLECTIOVO_641R86','VA_INGRESOSMENSUUE_680R86'];   
            BUSIN.API.disable(viewState, disableCollective);
        }
    };