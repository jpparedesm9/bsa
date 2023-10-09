package com.cobiscorp.cobis.busin.view.customevents.events;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditDataList;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.HeaderGuaranteesTicket;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogCreditLineValidByCustomer extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadCatalogCreditLineValidByCustomer.class);

	public LoadCatalogCreditLineValidByCustomer(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {

		if (args.getParameters().getTaskId().equals("T_FLCRE_19_KARAI97")) {
 
			DataEntity headerGuaranteeSticket = entities.getEntity(HeaderGuaranteesTicket.ENTITY_NAME);

			List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
			boolean flagPrintFE = false; // para imprimir logs en la pantalla
			int idCliente = 0;

			idCliente = headerGuaranteeSticket.get(HeaderGuaranteesTicket.CUSTOMERID);
			LOGGER.logInfo("Obtengo el id cliente en el loadcatalog" + idCliente);
			
			try{
				if (idCliente != 0) { // Encontro un cliente deudor Valido

					ApplicationRequest applicationRequest = new ApplicationRequest();
					ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
					ServiceResponse serviceResponse = new ServiceResponse();
					ServiceResponseTO serviceResponseTO = new ServiceResponseTO();

					applicationRequest.setClient(idCliente);				
					serviceRequestTO.getData().put(RequestName.INAPPLICATIONREQUEST, applicationRequest);				
					serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.SEARCHGETCREDITLINEDATABYCUSTOMER, serviceRequestTO);
					if (serviceResponse.isResult()) {
						if (flagPrintFE)
							MessageManagement.show(args, new MessageOption("TmpNoTomarEnCuenta->lgu->inicio->serviceResponse is result true", MessageLevel.INFO, true));
						if (flagPrintFE)
							MessageManagement.show(args, new MessageOption("TmpNoTomarEnCuenta->lgu->2", MessageLevel.INFO, true));
						serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
						LineCreditData[] list = (LineCreditData[]) serviceResponseTO.getValue("returnLineCreditData");

						for (LineCreditData lineCreditData : list) {

							ItemDTO itemDTO = new ItemDTO();
							itemDTO.setCode(String.valueOf(lineCreditData.getCreditLine()));
							itemDTO.setValue(lineCreditData.getCreditLine());
							if (lineCreditData.getAmount() == null) {
								lineCreditData.setAmount(new BigDecimal(0));
							}
							if (lineCreditData.getAmountAvailable() == null) {
								lineCreditData.setAmountAvailable(new BigDecimal(0));
							}
							if (lineCreditData.getCurrency() == null) {
								lineCreditData.setCurrency(0);
							}
							if (lineCreditData.getDescriptionCurrency() == null) {
								lineCreditData.setDescriptionCurrency("");
							}
							LOGGER.logInfo("1.................DESCRIPCION DE LA MONEDA...................................." + lineCreditData.getDescriptionCurrency());
							itemDTO.setAttributes(Arrays.asList(lineCreditData.getAmount(), lineCreditData.getAmountAvailable(), lineCreditData.getDescriptionCurrency()));
							listItemDTO.add(itemDTO);
						}
					} else {
						LOGGER.logInfo("serviceResponse.isResult()==false");
					}
				}
				return listItemDTO;
			} catch (Exception e) {
				ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_CREDITLINE, e, args, LOGGER);
			}
			return listItemDTO;
		} else {
			List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
			
			try{
				boolean flagPrintFE = false; // para imprimir logs en la pantalla
				int idCliente = 0;

				DataEntityList dataEntityList = new DataEntityList();
				dataEntityList = entities.getEntityList(DebtorGeneral.ENTITY_NAME);
				if(dataEntityList!=null){
					entities.setEntityList(DebtorGeneral.ENTITY_NAME, dataEntityList);
					for (DataEntity dataEntity : dataEntityList) {
						if ("D".equals(dataEntity.get(DebtorGeneral.ROLE))) {
							idCliente = dataEntity.get(DebtorGeneral.CUSTOMERCODE);
						}
					}
				}
				if (idCliente != 0) { // Encontro un cliente deudor Valido
					LOGGER.logDebug("Entra id!=0");
					ApplicationRequest applicationRequest = new ApplicationRequest();
					ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
					ServiceResponse serviceResponse = new ServiceResponse();
					ServiceResponseTO serviceResponseTO = new ServiceResponseTO();

					applicationRequest.setClient(idCliente);
					LineCreditDataList out = new LineCreditDataList();
					serviceRequestTO.getData().put(RequestName.INAPPLICATIONREQUEST, applicationRequest);
					serviceRequestTO.getData().put("outLineCreditDataList", out);
					serviceResponse = execute(getServiceIntegration(), LOGGER, ServiceId.SEARCHGETCREDITLINEDATABYCUSTOMER, serviceRequestTO);
					if (serviceResponse.isResult()) {
						LOGGER.logDebug("--Trae data");
						if (flagPrintFE)
							MessageManagement.show(args, new MessageOption("TmpNoTomarEnCuenta->lgu->inicio->serviceResponse is result true", MessageLevel.INFO, true));
						if (flagPrintFE)
							MessageManagement.show(args, new MessageOption("TmpNoTomarEnCuenta->lgu->2", MessageLevel.INFO, true));
						serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
						
						LineCreditData[] list = null;
						if((LineCreditData[]) serviceResponseTO.getValue("returnLineCreditData") != null)
							list = (LineCreditData[]) serviceResponseTO.getValue("returnLineCreditData");
						else
							list = new LineCreditData[0];
						
						LOGGER.logDebug("LineCreditData: " + serviceResponseTO.getValue("returnLineCreditData"));
						for (LineCreditData lineCreditData : list) {
							LOGGER.logDebug("getCode: "+ lineCreditData.getCode());
							LOGGER.logDebug("getDescriptionCurrency: "+ lineCreditData.getDescriptionCurrency());
							LOGGER.logDebug("getCreditCode: "+ lineCreditData.getCreditCode());
							LOGGER.logDebug("getCreditLine: "+ lineCreditData.getCreditLine());
							ItemDTO itemDTO = new ItemDTO();
							itemDTO.setCode(String.valueOf(lineCreditData.getCreditLine()));
							itemDTO.setValue(lineCreditData.getCreditLine());
							if (lineCreditData.getAmount() == null) {
								lineCreditData.setAmount(new BigDecimal(0));
							}
							if (lineCreditData.getAmountAvailable() == null) {
								lineCreditData.setAmountAvailable(new BigDecimal(0));
							}
							if (lineCreditData.getDescriptionCurrency() == null) {
								lineCreditData.setDescriptionCurrency("");
							}
							itemDTO.setAttributes(Arrays.asList(lineCreditData.getAmount(), lineCreditData.getAmountAvailable(), lineCreditData.getDescriptionCurrency()));
							listItemDTO.add(itemDTO);
						}
					} else {
						LOGGER.logInfo("serviceResponse.isResult()==false");
					}
				}
				return listItemDTO;
			} catch (Exception e) {
				ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CATALOG_CREDITLINE, e, args, LOGGER);
			}
			return listItemDTO;
		}
	}
}
