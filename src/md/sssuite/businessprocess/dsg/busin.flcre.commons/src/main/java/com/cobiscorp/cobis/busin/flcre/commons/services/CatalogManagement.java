package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ItemResponse;
import cobiscorp.ecobis.systemconfiguration.dto.CatalogResponse;
import cobiscorp.ecobis.systemconfiguration.dto.CurrencyRequest;
import cobiscorp.ecobis.systemconfiguration.dto.CurrencyResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import cobiscorp.ecobis.systemconfiguration.dto.TableRequest;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class CatalogManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(CatalogManagement.class);

	public CatalogManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CatalogResponse[] getAllItemsByTable(String tableName, ICommonEventArgs arg1, BehaviorOption options) {
		List<CatalogResponse> catalogResponseList = new ArrayList<CatalogResponse>();
		boolean hasValue = false;
		String nextValue = "";

		// Primera ejecucion
		CatalogResponse[] catalogResponseArray = this.getItemsByTable(0, tableName, null, arg1, options);
		if (catalogResponseArray != null) {
			for (CatalogResponse item : catalogResponseArray) {
				catalogResponseList.add(item);
			}
			hasValue = true;
		}
		// Siguientes ejecuciones
		while (catalogResponseArray != null && catalogResponseArray.length == 20) {
			nextValue = catalogResponseArray[catalogResponseArray.length - 1].getCode();
			catalogResponseArray = this.getItemsByTable(1, tableName, nextValue, arg1, options);
			if (catalogResponseArray != null) {
				for (CatalogResponse item : catalogResponseArray) {
					catalogResponseList.add(item);
				}
			}
		}
		if (hasValue) {
			return catalogResponseList.toArray(new CatalogResponse[catalogResponseList.size()]);
		}
		return null;
	}

	private CatalogResponse[] getItemsByTable(int mode, String tableName, String nextCode, ICommonEventArgs arg1, BehaviorOption options) {
		TableRequest tableDTO = new TableRequest();
		tableDTO.setMode(mode);
		tableDTO.setName(tableName);
		if (Validate.Strings.isNotNullOrEmpty(nextCode)) {
			tableDTO.setNextCode(nextCode);
		}

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inTableRequest", tableDTO);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "SystemConfiguration.CatalogManagement.Search", serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Productos recuperados para - ca_toperacion");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (CatalogResponse[]) serviceItemsResponseTO.getValue("returnCatalogResponse");
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public ParameterResponse getParameter(int mode, String parameterNemonic, String productNemonic, ICommonEventArgs arg1, BehaviorOption options) {
		ParameterRequest parameterRequest = new ParameterRequest();
		parameterRequest.setMode(mode);
		parameterRequest.setParameterNemonic(parameterNemonic);
		parameterRequest.setProductNemonic(productNemonic);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPARAMETERREQUEST, parameterRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.PARAMETERMANAGEMENT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Parametro recuperados para Mode:" + mode + " parameterNemonic:" + parameterNemonic + " productNemonic:" + productNemonic);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ParameterResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNPARAMETERRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public ParameterResponse getParameter(String parameterNemonic, String productNemonic, ICommonEventArgs arg1, BehaviorOption options) {
		return getParameter(4, parameterNemonic, productNemonic, arg1, options);
	}

	public ItemResponse[] getLoanStatus(ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETSTATUS, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Estados del credito recuperados exitosamente");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ItemResponse[]) serviceItemsResponseTO.getValue(ReturnName.ITEMRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public ParameterResponse parameterFixedIncomeResponse(int mode, String nemonic, String productNemonico, ICommonEventArgs arg1, BehaviorOption options) {
		ParameterRequest parameterFixedIncomeRequest = new ParameterRequest();
		ParameterResponse outParameterFixedIncomeResponse = new ParameterResponse();
		ParameterResponse parameterFixedIncomeResponse = new ParameterResponse();
		parameterFixedIncomeRequest.setMode(4);
		parameterFixedIncomeRequest.setParameterNemonic(nemonic);
		parameterFixedIncomeRequest.setProductNemonic(productNemonico);
		ServiceRequestTO serviceFixedIncomeRequestTO = new ServiceRequestTO();
		serviceFixedIncomeRequestTO.getData().put(RequestName.INPARAMETERREQUEST, parameterFixedIncomeRequest);
		serviceFixedIncomeRequestTO.getData().put(ReturnName.OUTPARAMETERESPONSE, outParameterFixedIncomeResponse);
		ServiceResponse serviceFixedIncomeResponse = execute(getServiceIntegration(), logger, ServiceId.PARAMETERMANAGEMENT, serviceFixedIncomeRequestTO);

		if (serviceFixedIncomeResponse.isResult()) {
			ServiceResponseTO serviceFixedIncomeResponseTO = (ServiceResponseTO) serviceFixedIncomeResponse.getData();
			parameterFixedIncomeResponse = (ParameterResponse) serviceFixedIncomeResponseTO.getValue(ReturnName.RETURNPARAMETERRESPONSE);
			return parameterFixedIncomeResponse;
		} else {
			MessageManagement.show(serviceFixedIncomeResponse, arg1, options);
		}
		return null;
	}

	// Parametros para las pantallas de asignacion del oficial para usarlos como datos
	// de comparacion el la pestana de Otros datos del credito
	public void loadInitActivityObject(DynamicRequest entities, IDataEventArgs arg1) {
		logger.logDebug("Inicio - loadInitActivityObject");
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		ParameterResponse parameterDtoNAVEC = this.getParameter("NAVEC", "CRE", arg1, new BehaviorOption(false, false));
		ParameterResponse parameterDtoOBCRE = this.getParameter("OBCRE", "CRE", arg1, new BehaviorOption(false, false));

		// NINGUNA ACTIVIDAD ECONOMICA - parametro para comparar en el loadCatalogo
		if (parameterDtoOBCRE != null) {
			if (parameterDtoOBCRE.getParameterValue() != null) {
				context.set(Context.FLAG1, parameterDtoOBCRE.getParameterValue().trim());
			}
		}

		// ObJETO DE CREDITO - parametro para comparar en el loadCatalogo
		if (parameterDtoNAVEC != null) {
			if (parameterDtoNAVEC.getParameterValue() != null) {
				context.set(Context.FLAG2, parameterDtoNAVEC.getParameterValue().trim());
			}
		}
	}

	@SuppressWarnings("unused")
	public List<?> getCurrencyByProduct(String bankingProductID, ILoadCatalogDataEventArgs args) {
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		if (logger.isDebugEnabled()) {
			logger.logDebug(":>:>CatalogManagement.getCurrencyByProduct:>:>");
		}
		try {
			/*
			 * if (false){//!bankingProductID != "") { CurrencyRequest currencyRequest = new CurrencyRequest(); currencyRequest.setMode(0); currencyRequest.setCurrency(0); currencyRequest.setProduct(bankingProductID); ServiceRequestTO
			 * serviceRequestTO = new ServiceRequestTO(); ServiceResponseTO serviceResponseTO = new ServiceResponseTO(); ServiceResponse serviceResponse = new ServiceResponse();
			 * 
			 * serviceRequestTO.addValue(RequestName.INCURRENCYREQUEST, currencyRequest);
			 * 
			 * serviceResponse = execute(getServiceIntegration(),logger,ServiceId.SERVICEGETCURRENCYBYPRODUCT, serviceRequestTO);
			 * 
			 * if(serviceResponse.isResult()){ serviceResponseTO= (ServiceResponseTO) serviceResponse.getData();
			 * 
			 * CurrencyResponse[] currenciesResponse = (CurrencyResponse[]) serviceResponseTO.getValue(ReturnName.RETURNCURRENCYRESPONSE);
			 * 
			 * for (CurrencyResponse currencyResponse : currenciesResponse) { ItemDTO itemDTO = new ItemDTO(); itemDTO.setCode(currencyResponse.getCode().toString()); itemDTO.setValue(currencyResponse.getDescription1()); if (logger.isDebugEnabled())
			 * { logger.logDebug(":>:>Interceptor -> cl_moneda:>" + itemDTO.getCode() + ":>:>"); } listItemDTO.add(itemDTO); } } } else {
			 */
			// catalogo de moneda
			CatalogManagement catalogManagement = new CatalogManagement(super.getServiceIntegration());
			CatalogResponse[] allItemsByTable = catalogManagement.getAllItemsByTable("cl_moneda", args, new BehaviorOption());
			if (allItemsByTable != null) {
				for (CatalogResponse item : allItemsByTable) {
					ItemDTO itemDTO = new ItemDTO();
					itemDTO.setCode(item.getCode().trim());
					itemDTO.setValue(item.getValue().trim());
					itemDTO.setAttributes(Arrays.asList(" "));
					if (logger.isDebugEnabled()) {
						logger.logDebug(":>:>cl_moneda:>" + itemDTO.getCode() + ":>:>");
					}
					listItemDTO.add(itemDTO);
				}
			}
			// }
			return listItemDTO;
		} catch (Exception e) {
			logger.logError(":>:>CatalogManagement.getCurrencyByProduct -> Error: " + e.getMessage());
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finish Service :>:>CatalogManagement.getCurrencyByProduct:>:>");

			}
		}
		return listItemDTO;
	}

	public Integer getValueQuestionnaireResponse(String typeProduct, IExecuteCommandEventArgs args) {
		logger.logDebug("---->Ingresa a CatalogManagement - getValueQuestionnaireResponse - Otro");
		CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());

		Integer param = null;

		if (typeProduct.equals("GRUPAL")) {
			ParameterResponse parameterResponseGRP = catalogMngmnt.getParameter(4, "RVDGR", Mnemonic.MODULE, args, new BehaviorOption(true));
			if (parameterResponseGRP != null) {
				logger.logDebug("---->>>>>> GRUPAL parametro: " + parameterResponseGRP.getParameterValue());
				param = Integer.parseInt(parameterResponseGRP.getParameterValue());
			}
		} else if (typeProduct.equals("INDIVIDUAL")) {
			ParameterResponse parameterResponseIND = catalogMngmnt.getParameter(4, "RVDIN", Mnemonic.MODULE, args, new BehaviorOption(true));
			if (parameterResponseIND != null) {
				logger.logDebug("---->>>>>> INDIVIDUAL parametro: " + parameterResponseIND.getParameterValue());
				param = Integer.parseInt(parameterResponseIND.getParameterValue());
			}
		}
		logger.logDebug("---->>>>>> GRUPAL parametro-param: " + param);
		if (param == 1) {
			logger.logDebug("---->>>>>> GRUPAL parametro-param: " + param + " No existe parámetro para comparar el resultado");
			logger.logDebug("---->>>>>> GRUPAL parametro-param: Nota: EL sp devuelve 1 puede ser que el valor debe ser 1 o no exista el registro");
			param = null;
		}
		return param;

	}
}
