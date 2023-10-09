
/* variables locales de T_GENERALINANNN_443*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_GENERALINFFHA_866*/

/* variables locales de T_AMORTIZATIOON_261*/

/* variables locales de T_GENERALINAOIT_347*/

/* variables locales de T_LOANWARRANTYT_123*/

/* variables locales de T_LOANDEBTORUIG_168*/

/* variables locales de T_ITEMSLOANSUXI_712*/

/* variables locales de T_RATESPTSITVKK_186*/

/* variables locales de T_PAYMENTUTOUGP_714*/

/* variables locales de T_REFINANCEDALA_857*/

/* variables locales de T_ASSTSVFPWPEPY_749*/

(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.querygeneralinformationmain;
    

    //"TaskId": "T_GENERALINANNN_443"
task.loadChart = function(entities, args){
    angular.forEach(entities.SummaryLoanStatus.data(), function (loanStatus) {
        loanStatus.statusAmortization = args.commons.api.viewState.translate(loanStatus.statusAmortization).toUpperCase();
    });

    var nav = args.commons.api.navigation;
    nav.customAddress = {
        id: "leftChart",
        url: "/ASSTS/QERYS/CHARTS/views/leftChart.html",
        useMinification: false
    };
    //CALL TO CONTROLLER
    nav.scripts = [{module: "ChartGeneralInfo", files: ["/ASSTS/QERYS/CHARTS/controllers/LeftChartCtrl.js"]}];
    nav.customDialogParameters = {};		
    nav.registerCustomView('G_GENERALOLN_670344');
};


    	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QueryGeneralInformationMain
    task.initData.VC_GENERALITN_743443 = function (entities, initDataEventArgs){
        var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;
        entities.LoanInstancia.groupSummary=parameters.parameters.groupSummary;
		commons.execServer = true;		
        
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QueryGeneralInformationMain
    task.initDataCallback.VC_GENERALITN_743443 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var api = initDataEventArgs.commons.api;		
		
		(entities.ColumnsDataValue.col30 == null) ? api.vc.viewState.VA_TEXTINPUTBOXYLL_293203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXYLL_293203.visible = true;
		(entities.ColumnsDataValue.col70 == null) ? api.vc.viewState.VA_TEXTINPUTBOXCLV_313203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXCLV_313203.visible = true;
		(entities.ColumnsDataValue.col82 == null) ? api.vc.viewState.VA_TEXTINPUTBOXFHY_331203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXFHY_331203.visible = true;
		(entities.ColumnsDataValue.col91 == null) ? api.vc.viewState.VA_TEXTINPUTBOXXCX_878203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXXCX_878203.visible = true;
		(entities.ColumnsDataValue.col11 == null) ? api.vc.viewState.VA_COL11DMRXFYBTRJ_832203.visible = false :  api.vc.viewState.VA_COL11DMRXFYBTRJ_832203.visible = true;
		(entities.ColumnsDataValue.col89 == null) ? api.vc.viewState.VA_TEXTINPUTBOXOZJ_807203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXOZJ_807203.visible = true;
		(entities.ColumnsDataValue.col3 == null || entities.ColumnsDataValue.col1 == undefined) ? api.vc.viewState.VA_TEXTINPUTBOXCEU_727203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXCEU_727203.visible = true;			
		(entities.ColumnsDataValue.col74 == null) ? api.vc.viewState.VA_TEXTINPUTBOXZST_196203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXZST_196203.visible = true;	
		(entities.ColumnsDataValue.col4 == null) ? api.vc.viewState.VA_TEXTINPUTBOXKKT_290203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXKKT_290203.visible = true;	
		(entities.ColumnsDataValue.col63 == null) ? api.vc.viewState.VA_TEXTINPUTBOXQVD_784203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXQVD_784203.visible = true;					
		(entities.ColumnsDataValue.col28 == null) ? api.vc.viewState.VA_TEXTINPUTBOXFUR_725203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXFUR_725203.visible = true;	
		(entities.ColumnsDataValue.col127 == null) ? api.vc.viewState.VA_TEXTINPUTBOXXAE_419203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXXAE_419203.visible = true;	
		(entities.ColumnsDataValue.col96 == null) ? api.vc.viewState.VA_TEXTINPUTBOXNUC_515203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXNUC_515203.visible = true;			
		(entities.ColumnsDataValue.col116 == null) ? api.vc.viewState.VA_TEXTINPUTBOXMIJ_255203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXMIJ_255203.visible = true;	
		(entities.ColumnsDataValue.col148 == null) ? api.vc.viewState.VA_COL148YHTMQIFBH_165203.visible = false :  api.vc.viewState.VA_COL148YHTMQIFBH_165203.visible = true;	
		(entities.ColumnsDataValue.col98 == null) ? api.vc.viewState.VA_COL98VYAYLZCUKZ_984203.visible = false :  api.vc.viewState.VA_COL98VYAYLZCUKZ_984203.visible = true;	
		(entities.ColumnsDataValue.col149 == null) ? api.vc.viewState.VA_COL149ECRVIIDXJ_360203.visible = false :  api.vc.viewState.VA_COL149ECRVIIDXJ_360203.visible = true;	
		(entities.ColumnsDataValue.col94 == null) ? api.vc.viewState.VA_TEXTINPUTBOXTXW_844203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXTXW_844203.visible = true;	
		(entities.ColumnsDataValue.col150 == null) ? api.vc.viewState.VA_COL150TJUVFKMWM_571203.visible = false :  api.vc.viewState.VA_COL150TJUVFKMWM_571203.visible = true;	
		(entities.ColumnsDataValue.col16 == null) ? api.vc.viewState.VA_TEXTINPUTBOXVHS_357203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXVHS_357203.visible = true;	
		(entities.ColumnsDataValue.col151 == null) ? api.vc.viewState.VA_COL151XEUXPLAEA_433203.visible = false :  api.vc.viewState.VA_COL151XEUXPLAEA_433203.visible = true;					
		(entities.ColumnsDataValue.col17 == null) ? api.vc.viewState.VA_TEXTINPUTBOXVBB_693203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXVBB_693203.visible = true;	
		(entities.ColumnsDataValue.col138 == null) ? api.vc.viewState.VA_TEXTINPUTBOXWVS_331203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXWVS_331203.visible = true;	
		(entities.ColumnsDataValue.col13 == null) ? api.vc.viewState.VA_TEXTINPUTBOXLAA_716203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXLAA_716203.visible = true;	
		(entities.ColumnsDataValue.col139 == null) ? api.vc.viewState.VA_TEXTINPUTBOXEUN_350203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXEUN_350203.visible = true;	
		(entities.ColumnsDataValue.col71 == null) ? api.vc.viewState.VA_TEXTINPUTBOXPCU_828203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXPCU_828203.visible = true;			
		(entities.ColumnsDataValue.col100 == null) ? api.vc.viewState.VA_TEXTINPUTBOXVBP_896203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXVBP_896203.visible = true;	
		(entities.ColumnsDataValue.col102 == null) ? api.vc.viewState.VA_COL102IZHQPGLGQ_823203.visible = false :  api.vc.viewState.VA_COL102IZHQPGLGQ_823203.visible = true;	
		(entities.ColumnsDataValue.col103 == null) ? api.vc.viewState.VA_TEXTINPUTBOXSFC_390203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXSFC_390203.visible = true;
		(entities.ColumnsDataValue.col88 == null) ? api.vc.viewState.VA_TEXTINPUTBOXZSP_614203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXZSP_614203.visible = true;								
		(entities.ColumnsDataValue.col93 == null) ? api.vc.viewState.VA_TEXTINPUTBOXXQS_367203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXXQS_367203.visible = true;	
		(entities.ColumnsDataValue.col106 == null) ? api.vc.viewState.VA_TEXTINPUTBOXDFL_233203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXDFL_233203.visible = true;	
		(entities.ColumnsDataValue.col10 == null) ? api.vc.viewState.VA_TEXTINPUTBOXLDN_789203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXLDN_789203.visible = true;	
		(entities.ColumnsDataValue.col144 == null) ? api.vc.viewState.VA_TEXTINPUTBOXPRC_818203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXPRC_818203.visible = true;	
		(entities.ColumnsDataValue.col92 == null) ? api.vc.viewState.VA_TEXTINPUTBOXAYN_905203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXAYN_905203.visible = true;					
		(entities.ColumnsDataValue.col146 == null) ? api.vc.viewState.VA_COL146AYXFKCRYI_168203.visible = false :  api.vc.viewState.VA_COL146AYXFKCRYI_168203.visible = true;			
		(entities.ColumnsDataValue.col128 == null) ? api.vc.viewState.VA_TEXTINPUTBOXHNK_820203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXHNK_820203.visible = true;	
		(entities.ColumnsDataValue.col136 == null) ? api.vc.viewState.VA_TEXTINPUTBOXMWQ_662203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXMWQ_662203.visible = true;	
		(entities.ColumnsDataValue.col132 == null) ? api.vc.viewState.VA_TEXTINPUTBOXYAE_738203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXYAE_738203.visible = true;			
		(entities.ColumnsDataValue.col137 == null) ? api.vc.viewState.VA_TEXTINPUTBOXPRR_754203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXPRR_754203.visible = true;		
		(entities.ColumnsDataValue.col14 == null) ? api.vc.viewState.VA_TEXTINPUTBOXFJI_119203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXFJI_119203.visible = true;							
		(entities.ColumnsDataValue.col37 == null) ? api.vc.viewState.VA_TEXTINPUTBOXSJD_345203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXSJD_345203.visible = true;	
		(entities.ColumnsDataValue.col38 == null) ? api.vc.viewState.VA_TEXTINPUTBOXLZX_625203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXLZX_625203.visible = true;	
		(entities.ColumnsDataValue.col140 == null) ? api.vc.viewState.VA_TEXTINPUTBOXZYM_339203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXZYM_339203.visible = true;	
		(entities.ColumnsDataValue.col141 == null) ? api.vc.viewState.VA_TEXTINPUTBOXTAU_538203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXTAU_538203.visible = true;			
		(entities.ColumnsDataValue.col119 == null) ? api.vc.viewState.VA_TEXTINPUTBOXWQL_188203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXWQL_188203.visible = true;	
		(entities.ColumnsDataValue.col133 == null) ? api.vc.viewState.VA_TEXTINPUTBOXQNT_219203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXQNT_219203.visible = true;
		(entities.ColumnsDataValue.col95 == null) ? api.vc.viewState.VA_TEXTINPUTBOXXYN_505203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXXYN_505203.visible = true;	
		(entities.ColumnsDataValue.col97 == null) ? api.vc.viewState.VA_TEXTINPUTBOXGBW_313203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXGBW_313203.visible = true;	
		(entities.ColumnsDataValue.col134 == null) ? api.vc.viewState.VA_TEXTINPUTBOXKJW_728203.visible = false :  api.vc.viewState.VA_TEXTINPUTBOXKJW_728203.visible = true;	
		(entities.ColumnsDataValue.col32 == null) ? api.vc.viewState.VA_COL32CDFPUYWBGD_758203.visible = false :  api.vc.viewState.VA_COL32CDFPUYWBGD_758203.visible = true;	
		(entities.ColumnsDataValue.col46 == null) ? api.vc.viewState.VA_COL46RBGZXOSXUD_578203.visible = false :  api.vc.viewState.VA_COL46RBGZXOSXUD_578203.visible = true;	
		(entities.ColumnsDataValue.col33 == null) ? api.vc.viewState.VA_COL33GXLNAEOZIW_513203.visible = false :  api.vc.viewState.VA_COL33GXLNAEOZIW_513203.visible = true;	
		(entities.ColumnsDataValue.col54 == null) ? api.vc.viewState.VA_COL54TKWEEBKVXN_134203.visible = false :  api.vc.viewState.VA_COL54TKWEEBKVXN_134203.visible = true;	
		(entities.ColumnsDataValue.col44 == null) ? api.vc.viewState.VA_COL44RQKRIFDDCK_361203.visible = false :  api.vc.viewState.VA_COL44RQKRIFDDCK_361203.visible = true;					
		(entities.ColumnsDataValue.col49 == null) ? api.vc.viewState.VA_COL49ZEUCHXHDSZ_263203.visible = false :  api.vc.viewState.VA_COL49ZEUCHXHDSZ_263203.visible = true;	
		(entities.ColumnsDataValue.col81 == null) ? api.vc.viewState.VA_COL81JBFTYRSPYI_282203.visible = false :  api.vc.viewState.VA_COL81JBFTYRSPYI_282203.visible = true;	
		(entities.ColumnsDataValue.col111 == null) ? api.vc.viewState.VA_COL111PZXDZUYUC_787203.visible = false :  api.vc.viewState.VA_COL111PZXDZUYUC_787203.visible = true;	
		(entities.ColumnsDataValue.col113 == null) ? api.vc.viewState.VA_COL113YQSWHDUHL_890203.visible = false :  api.vc.viewState.VA_COL113YQSWHDUHL_890203.visible = true;	
		(entities.ColumnsDataValue.col48 == null) ? api.vc.viewState.VA_COL48UDRRPRVRAD_844203.visible = false :  api.vc.viewState.VA_COL48UDRRPRVRAD_844203.visible = true;	
		(entities.ColumnsDataValue.col53 == null) ? api.vc.viewState.VA_COL53CZDOJNOMFT_346203.visible = false :  api.vc.viewState.VA_COL53CZDOJNOMFT_346203.visible = true;	
		(entities.ColumnsDataValue.col112 == null) ? api.vc.viewState.VA_COL112OCPGNLXFG_495203.visible = false :  api.vc.viewState.VA_COL112OCPGNLXFG_495203.visible = true;					
		(entities.ColumnsDataValue.col80 == null) ? api.vc.viewState.VA_COL80ASFOWXJRDC_132203.visible = false :  api.vc.viewState.VA_COL80ASFOWXJRDC_132203.visible = true;	
		(entities.ColumnsDataValue.col35 == null) ? api.vc.viewState.VA_COL35HREVITBWJO_552203.visible = false :  api.vc.viewState.VA_COL35HREVITBWJO_552203.visible = true;	
		(entities.ColumnsDataValue.col34 == null) ? api.vc.viewState.VA_COL34HWLCGTUDDY_405203.visible = false :  api.vc.viewState.VA_COL34HWLCGTUDDY_405203.visible = true;	
		(entities.ColumnsDataValue.col77 == null) ? api.vc.viewState.VA_COL77JLESNGFECP_839203.visible = false :  api.vc.viewState.VA_COL77JLESNGFECP_839203.visible = true;	
		(entities.ColumnsDataValue.col18 == null) ? api.vc.viewState.VA_COL18MPQAUPJEQF_886203.visible = false :  api.vc.viewState.VA_COL18MPQAUPJEQF_886203.visible = true;					
		(entities.ColumnsDataValue.col22 == null) ? api.vc.viewState.VA_COL22GPNCCEADAN_455203.visible = false :  api.vc.viewState.VA_COL22GPNCCEADAN_455203.visible = true;	
		(entities.ColumnsDataValue.col23 == null) ? api.vc.viewState.VA_COL23ZUQVNTSTGF_643203.visible = false :  api.vc.viewState.VA_COL23ZUQVNTSTGF_643203.visible = true;	
		(entities.ColumnsDataValue.col24 == null) ? api.vc.viewState.VA_COL24NFMYARIPPW_188203.visible = false :  api.vc.viewState.VA_COL24NFMYARIPPW_188203.visible = true;	
		(entities.ColumnsDataValue.col25 == null) ? api.vc.viewState.VA_COL25RWYMCMPQKL_227203.visible = false :  api.vc.viewState.VA_COL25RWYMCMPQKL_227203.visible = true;		
        
      
		/*if(entities.ColumnsDataValue.col156 == 'S'){
              api.vc.viewState.label('VA_5034UOFCASVGKTK_993612', loan.operationType+"-PROMOCION")
        }*/
		//LOAD CHART
		task.loadChart(entities, initDataEventArgs);
     
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: QueryGeneralInformationMain
    task.render = function (entities, renderEventArgs){
        ASSETS.Header.setDataStyle("VC_GENERALITN_743443", "VC_PBXJORPCKR_929443", entities, renderEventArgs);	
        if(entities.ColumnsDataValue.col56 == 'S'){
              api.viewState.label(loan.operationType+"-PROMOCION");
        }				
		
		ASSETS.Amortization.showTableAmortization(entities, renderEventArgs);  
		ASSETS.Amortization.CapitalBalance(entities.Amortization.data());
		ASSETS.Amortization.resizeGrid("QV_8237_80795");
		// STYLES CHART
		renderEventArgs.commons.api.grid.title("QV_6100_21620", "statusAmortization", "", null, null);
        $("#QV_6100_21620 tbody .ng-scope:nth-child(3)").css("font-weight", "bold");
        $("#QV_6100_21620 tbody .ng-scope:nth-child(5)").css("font-weight", "bold");
        
        
        renderEventArgs.commons.api.grid.hideColumn('QV_1439_82210', 'sequentialQuery');
        renderEventArgs.commons.api.grid.hideColumn('QV_1439_82210', 'sequentialIdentity');
        
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
     try{
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.api.vc.closeDialog();
            var subModuleId = "CMMNS",
            taskId = "T_LOANSEARCHSWA_959",
            vcId = "VC_LOANSEARHC_144959",
            parameters = '', 
            label = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_BSQUEDASS_55923');
            ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);
     }
    catch(err){
        ASSETS.Utils.managerException(err);
    }
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONWVITZRQ_108612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
         ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
         return true;
    };

	//gridRowSelecting QueryView: QV_8237_80795
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_8237_80795 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        //Open Modal
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        nav.label = gridRowSelectingEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_DESGLOSCO_45546');
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'MNTNN',
            taskId: 'T_AMORTIZATIDTE_881',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_AMORTIZATE_895881'
        };
        nav.queryParameters = {
            mode: 2
        };
        nav.modalProperties = {
            size: 'lg',
            callFromGrid: false
        };        
        nav.customDialogParameters = {
            dividend: gridRowSelectingEventArgs.rowData.share,
            loanBankID: entities.Loan.loanBankID
        };        
        nav.openModalWindow('QV_8237_80795', gridRowSelectingEventArgs.rowData);
        
    };

	//gridRowSelecting QueryView: QV_1941_28530
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1941_28530 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };

	//gridRowSelecting QueryView: QV_6719_92672
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_6719_92672 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };

	//gridRowSelecting QueryView: QV_7536_43842
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_7536_43842 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };

	//gridRowSelecting QueryView: QV_7625_68514
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_7625_68514 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };

	//undefined Entity: 
    task.executeQuery.Q_PAYMENUM_1439 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridRowSelecting QueryView: undefined
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_1439_82210 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;        
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        var idForQuery ;
            
        if(entities.LoanInstancia.groupSummary == "N"){
            idForQuery=gridRowSelectingEventArgs.rowData.paymentId;
        }else{
            idForQuery=gridRowSelectingEventArgs.rowData.sequentialQuery;
        }
		
		nav.label = gridRowSelectingEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_DETALLEAG_48048');
        nav.address = {
			moduleId: 'ASSTS',
			subModuleId: 'QERYS',
			taskId: 'T_PAYMENTDETMFP_722',
			taskVersion: '1.0.0',
			viewContainerId: 'VC_PAYMENTDEE_475722'
        };
        nav.queryParameters = {
			mode : gridRowSelectingEventArgs.commons.constants.mode.Update
        };
        nav.modalProperties = {
			size: 'lg'
        };
        nav.customDialogParameters = {
			sequentialIns: idForQuery, 
            groupSummary: entities.LoanInstancia.groupSummary, 
			loanBankID: entities.Loan.loanBankID
        };		
        nav.openModalWindow("QV_1439_82210", gridRowSelectingEventArgs.modelRow);
        };

	//gridRowSelecting QueryView: QV_1949_60600
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1949_60600 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        
    };

	//undefined Entity: 
    task.executeQuery.Q_TRANSACC_2353 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridRowSelecting QueryView: QV_2353_40892
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_2353_40892 = function (entities,gridRowSelectingEventArgs) {
               gridRowSelectingEventArgs.commons.execServer = false;        
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
		
		nav.label = "Detalle de Transaccion";
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'QERYS',
            taskId: 'T_ASSTSCJVXOOMB_486',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_TRANSACTDE_986486'
        };

        nav.queryParameters = {
			mode : gridRowSelectingEventArgs.commons.constants.mode.Update
        };
        nav.modalProperties = {
			size: 'lg'
        };
        nav.customDialogParameters = {
			idTrx: gridRowSelectingEventArgs.rowData.transactionId, 
            trxType: gridRowSelectingEventArgs.rowData.transactionType, 
			loanBankID: entities.Loan.loanBankID
        };		
        nav.openModalWindow("QV_2353_40892", gridRowSelectingEventArgs.modelRow);
};



}));