package com.cobiscorp.cobis.busin.warrantiescreation.custonevents.events;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.GuaranteeManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.FieldByProductValues;
import com.cobiscorp.cobis.busin.model.CustomerSearch;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.WarrantyGeneral;
import com.cobiscorp.cobis.busin.model.WarrantySituation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;

public class ExecuteSaveWarranty extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteSaveWarranty.class);

	
	public ExecuteSaveWarranty(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Inicio ExecuteSaveWarranty -> saveWarranty....");
				
		DataEntityList wCustomersList = entities.getEntityList(CustomerSearch.ENTITY_NAME);
		DataEntity wGeneralData = entities.getEntity(WarrantyGeneral.ENTITY_NAME);
		DataEntity wSituation = entities.getEntity(WarrantySituation.ENTITY_NAME);
			
		try {
			if (wGeneralData != null) {	
				String format = "MM/dd/yyyy";
				Date fechaproceso = null;
				String processDate = ServerParamUtil.getProcessDate();
				SimpleDateFormat dateFormat = new SimpleDateFormat(format);
				fechaproceso = dateFormat.parse(processDate);

				if(wSituation.get(WarrantySituation.CONSTITUTION) != null &&
						wSituation.get(WarrantySituation.CONSTITUTION).after(fechaproceso)){
					arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_ESGEVIDAA_09146");
					arg1.setSuccess(false);
					return;
				}else if(wSituation.get(WarrantySituation.LASTVALUATION) != null &&  
						wSituation.get(WarrantySituation.LASTVALUATION).after(fechaproceso) ){
					arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_VIDAEPPRS_37656");
					arg1.setSuccess(false);
					return;
				}				
			}
			if (wCustomersList == null || wCustomersList.size() == 0) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Error -> ExecuteSaveWarranty : La garant�a no tiene clientes asociados");
				arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_VIACRCLLA_74179");
				arg1.setSuccess(false);
				return;
			}

			//Validaci�n de deudores del tr�mite - No pueden ser garantes
			int indexEnd = -1;
			int numeroTramite = 0;
			int guarantorCode = 0;
			String guarantor = "";
			numeroTramite = Integer.parseInt(wGeneralData.get(WarrantyGeneral.TRAMITNUMBER));
			guarantor = wGeneralData.get(WarrantyGeneral.GUARANTOR);
			
			if(guarantor != null){
				indexEnd = guarantor.indexOf("-");
			    if (indexEnd > 0) {
			    	guarantorCode = Integer.parseInt(guarantor.substring(0, indexEnd).trim());
			    };
			}
			
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("---->Recupera los deudores en base al tramite");
			
			DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
			DataEntityList debtors = debManagement.getDebtorsEntityList(numeroTramite, arg1, new BehaviorOption(true));
			if (debtors != null) {
				for(DataEntity wDebtor: debtors){
					if(guarantorCode == wDebtor.get(DebtorGeneral.CUSTOMERCODE)){
						arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_EGERURANT_60995");
						arg1.setSuccess(false);
						return;
					}
				}
			} else {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
				return;
			}
   
			
			GuaranteeManagement guaranteeMngmnt = new GuaranteeManagement(super.getServiceIntegration());
			boolean saveisOk = guaranteeMngmnt.saveWarranty(entities, arg1);
				
			if (saveisOk) {	
				//Asociar clientes a la garant�a
				int contador = 1;
				for (DataEntity wCustomer : wCustomersList) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("saveWarranty -> Cliente: "+ wCustomer.get(CustomerSearch.CUSTOMERID));				
					guaranteeMngmnt.saveCustomerCollateral(wCustomer, entities, arg1, new BehaviorOption(true), contador);
					contador = contador + 1;
				}
				
				//seccion de datos adicionales				
				saveDataRenderSection(entities,arg1,"S");
			}
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_EXECUTE_SAVE, e, arg1, LOGGER);
		}
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida saveWarranty -> ExecuteSaveWarranty");
	}
	
	
	private void saveDataRenderSection(DynamicRequest entities, IExecuteCommandEventArgs args, String isNew) {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---->Ingresa al método saveDataRenderSection");
			}
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(super.getServiceIntegration());			
			// lista de valores render que se carga en el initData de la pantalla
			ArrayList<FieldByProductValues> valuesList = new ArrayList<FieldByProductValues>();
			// values render se cargo en evento
			DataEntity warrantiesGeneral=entities.getEntity(WarrantyGeneral.ENTITY_NAME);					
			
			DataEntityList valuesFieldByProduct = entities.getEntityList("Values");
			
			if(valuesFieldByProduct.getDataList().size()>0){	
				if(LOGGER.isDebugEnabled()){
					LOGGER.logDebug("valuesFieldByProduct---> " + valuesFieldByProduct.getDataList().size());
				}
				DataEntity bankingProduct = entities.getEntity(OriginalHeader.ENTITY_NAME);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("----------->Coloca valores en valuesList");
				}
				String bankingProductId = "";
				String request = "";
				if (valuesFieldByProduct.size() > 0) {
					for (DataEntity d : valuesFieldByProduct) {
						FieldByProductValues fpv = new FieldByProductValues();
						fpv.setField(d.get(com.cobiscorp.cobis.busin.model.FieldByProductValues.FIELDID).longValue());
						fpv.setProduct(d.get(com.cobiscorp.cobis.busin.model.FieldByProductValues.PRODUCTID));
						fpv.setRequest(d.get(com.cobiscorp.cobis.busin.model.FieldByProductValues.REQUESTID));
						fpv.setValue(d.get(com.cobiscorp.cobis.busin.model.FieldByProductValues.VALUE));
						fpv.setRegisterId(warrantiesGeneral.get(WarrantyGeneral.EXTERNALCODE));
						valuesList.add(fpv);
						bankingProductId=fpv.getProduct();
						request =  fpv.getRequest();
					}
				}		
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("----------->valuesList" + valuesList.size() + " bankingProductId+ " + bankingProductId + "request "+request);
					LOGGER.logDebug("entidad warrantiesGeneral"+warrantiesGeneral.getData());
				}			
				
				HashMap<String, String> map = new HashMap<String,String>();			
				LOGGER.logDebug("TEST_1");			
				map.put("filial", warrantiesGeneral.get(WarrantyGeneral.FILIAL).toString());
				map.put("sucursal", "1");
				map.put("tipoCust", warrantiesGeneral.get(WarrantyGeneral.WARRANTYTYPE).toString());
				map.put("codId", warrantiesGeneral.get(WarrantyGeneral.CODE).toString());
				map.put("documentNumber", warrantiesGeneral.get(WarrantyGeneral.EXTERNALCODE));
				map.put("isNew", isNew);
				
				if(LOGGER.isDebugEnabled()){
					LOGGER.logDebug("servicio para bankingProductManager" + bankingProductManager);					
				}				
				
				if(!bankingProductManager.insertListFieldByProductWarranties(args, bankingProductId, request,valuesList,map)){
					args.setSuccess(true);
					args.getMessageManager().showInfoMsg("BUSIN.DLB_BUSIN_EVISDTOCO_26748");
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("---->DATOS ADICIONALES NO SE PUDIERON COMPLETAR");
					}
				}				
				
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("---->args.isSuccess()"+args.isSuccess());    
				}
				
			}else{
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("---->NO EXISTE CAMPOS ADICIONALES....");
				}
			}
			
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---->Finaliza el método saveDataRenderSection  -- args.isSuccess()"+args.isSuccess());
			}
		} catch (Exception e) {
			LOGGER.logError("--->Error en el métodosaveDataRenderSection",e);
		}
	}

}
