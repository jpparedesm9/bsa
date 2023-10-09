package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.HashMap;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.creditfacility.dto.CreditLineRequest;
import cobiscorp.ecobis.creditfacility.dto.CreditLineResponse;
import cobiscorp.ecobis.creditfacility.dto.DistributionLineRequest;
import cobiscorp.ecobis.creditfacility.dto.DistributionLineResponse;
import cobiscorp.ecobis.creditfacility.dto.RiskResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.DataCreditLine;
import com.cobiscorp.cobis.busin.model.DistributionEntity;
import com.cobiscorp.cobis.busin.model.Totales;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.CatalogDto;

public class CreditFacilityManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(CreditFacilityManagement.class);

	public CreditFacilityManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	/**
	 * Crea la operacion de linea de credito
	 */
	public CreditLineResponse createCreditFacilityOperation(CreditLineRequest clRequest, ICommonEventArgs arg1) {
		logger.logDebug("Invoca al Servicio Create del SG");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inCreditLineRequest", clRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.CreditLineServices.Create", serviceRequestTO);
		if (serviceResponse != null) {
			if (serviceResponse.isResult()) {
				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
				logger.logDebug("REcupera getValue output>>>" + serviceItemsResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output"));
				HashMap<String, String> outputs = (HashMap<String, String>) serviceItemsResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				logger.logDebug("en java esta como CreditLineResponse, con 3 responses");
				CreditLineResponse response3 = (CreditLineResponse) serviceItemsResponseTO.getValue("returnCreditLineResponse3");
				logger.logDebug("tramite>>" + outputs.get("@o_tramite"));
				response3.setTramite(Integer.parseInt(outputs.get("@o_tramite")));
				return response3;

			} else {
				for (Message message : serviceResponse.getMessages()) {
					arg1.getMessageManager().showErrorMsg(message.getMessage());
				}

			}
		}
		return null;

	}

	public void updateCreditFacilityOperation(CreditLineRequest clRequest, ICommonEventArgs arg1) {

		logger.logDebug("Invoca al Servicio Update del SG");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inCreditLineRequest", clRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.CreditLineServices.UpdateCreditLine", serviceRequestTO);

		if (serviceResponse != null) {

			for (Message message : serviceResponse.getMessages()) {
				arg1.getMessageManager().showErrorMsg(message.getMessage());
			}

		}
		logger.logDebug("Termina Servicio Update del SG");
	}

	public boolean validateCreditLine(CreditLineRequest creditLineRequest, ICommonEventArgs arg1) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		String validaLinea = null;
		serviceRequestTO.addValue("inCreditLineRequest", creditLineRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.CreditLineServices.ValidateCreditLine", serviceRequestTO);
		if (serviceResponse != null) {

			if (serviceResponse.isResult()) {
				ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
				HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTo.getValue("com.cobiscorp.cobis.cts.service.response.output");
				logger.logDebug("validateCreditLine: " + serviceResponseTo.getValue("com.cobiscorp.cobis.cts.service.response.output"));
				validaLinea = outputs.get("@o_valida_linea");
				logger.logDebug("validaLinea: " + validaLinea);
			} else {

				arg1.setSuccess(false);
			}

			for (Message message : serviceResponse.getMessages()) {
				arg1.getMessageManager().showErrorMsg(message.getMessage());
			}

			return validaLinea == null || "N".equals(validaLinea) ? false : true;

		}

		return false;

	}

	public void createDistribution(DistributionLineRequest distributionRequest) {
		logger.logDebug("Invoca al Servicio del SG createDistribution");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put("inDistributionRequest", distributionRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.DistributionLineServices.CreateDistribution", serviceRequestTO);
		logger.logDebug("serviceResponse.isResult() es>>" + serviceResponse.isResult());
		if (serviceResponse.isResult()) {
			logger.logDebug("obteniendo getData>>>");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			logger.logDebug("REcupera isSuccess>>>" + serviceItemsResponseTO.isSuccess());
			logger.logDebug("DATA>>" + serviceItemsResponseTO.getData());
		}
	}

	public DistributionLineResponse[] findDistributionByLineNumber(int numeroLinea, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("Invoca al Servicio del SG findDistributionByLineNumber");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DistributionLineRequest request = new DistributionLineRequest();
		request.setLinea(numeroLinea);
		request.setOperacion("S");
		serviceRequestTO.getData().put("inDistributionLineRequest", request);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.DistributionLineServices.SearchDistributionLine", serviceRequestTO);

		logger.logDebug(">>>resultado de invocacion>>" + serviceResponse.isResult());

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

			logger.logDebug(">>>data de invocacion>>" + serviceResponseTO.getData());

			return (DistributionLineResponse[]) serviceResponseTO.getValue("returnDistributionLineResponse");
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return null;
		}
	}

	public DistributionLineResponse[] findDistributionByLineNumber(int numeroLinea) {
		logger.logDebug("Invoca al Servicio del SG findDistributionByLineNumber");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DistributionLineRequest request = new DistributionLineRequest();
		request.setLinea(numeroLinea);
		request.setOperacion("S");
		serviceRequestTO.getData().put("inDistributionLineRequest", request);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.DistributionLineServices.SearchDistributionLine", serviceRequestTO);

		logger.logDebug(">>>resultado de invocacion>>" + serviceResponse.isResult());

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

			logger.logDebug(">>>data de invocacion>>" + serviceResponseTO.getData());

			return (DistributionLineResponse[]) serviceResponseTO.getValue("returnDistributionLineResponse");
		} else {
			return null;
		}
	}

	public void loadDistributions(int numeroLinea, DynamicRequest entities, ICommonEventArgs arg1) {
		DistributionLineResponse[] distributions = findDistributionByLineNumber(numeroLinea, arg1, new BehaviorOption(true));
		// DataEntityList distributionEntities=new DataEntityList();
		DataEntityList distributionEntities = new DataEntityList();

		if (distributions != null) {
			for (DistributionLineResponse distribution : distributions) {
				DataEntity dataEntity = new DataEntity();
				// recuperar nombre de moneda
				dataEntity.set(DistributionEntity.MONEDA, "" + distribution.getMoneda());
				dataEntity.set(DistributionEntity.MONTO, distribution.getMonto());
				// no se pinta pero da problemas si no se manda al front end
				dataEntity.set(DistributionEntity.DESCRIPCION, distribution.getDescripcionProducto());
				dataEntity.set(DistributionEntity.PRODUCTO, distribution.getProducto());
				dataEntity.set(DistributionEntity.DESCRIPCIONOPERACION, distribution.getDescripcionOperacion());
				dataEntity.set(DistributionEntity.TIPOOPERACION, distribution.getOperacion());
				dataEntity.set(DistributionEntity.RIESGO, distribution.getRiesgo());
				dataEntity.set(DistributionEntity.OBSERVACION, distribution.getCondicionEspecial());
				dataEntity.set(DistributionEntity.DESCRIPCIONRIESGO, distribution.getDescripcionRiesgo());
				dataEntity.set(DistributionEntity.DESCRIPCIONMONEDA, distribution.getDescripcionMoneda());
				distributionEntities.add(dataEntity);
			}
			entities.setEntityList(DistributionEntity.ENTITY_NAME, distributionEntities);
		}
	}

	public void loadCreditLine(ApplicationResponse applicationResponse, int codigoTramite, DynamicRequest entities, ICommonEventArgs arg1) throws Exception {
		try {
			DataEntity dataCreditLine = entities.getEntity(DataCreditLine.ENTITY_NAME);
			dataCreditLine.set(DataCreditLine.TRAMITE, String.valueOf(codigoTramite));
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			CatalogManagement catalogManagement = new CatalogManagement(this.getServiceIntegration());

			//dataCreditLine.set(DataCreditLine.LINEA, applicationResponse.getLine() == null ? 0 : Integer.valueOf(applicationResponse.getLine()));
			int oficina = applicationResponse.getOffice() == null ? 0 : applicationResponse.getOffice();
			String descripcionOficina = applicationResponse.getOfficeDescriptionTr() == null ? "" : applicationResponse.getOfficeDescriptionTr();
			dataCreditLine.set(DataCreditLine.OFICINA, String.valueOf(oficina));

			//String oficial = applicationResponse.getUserName() == null ? "" : applicationResponse.getUserName();
			int idOficial = applicationResponse.getOfficer() == null ? 0 : applicationResponse.getOfficer();
			dataCreditLine.set(DataCreditLine.OFICIAL, String.valueOf(idOficial));

			//dataCreditLine.set(DataCreditLine.FECHAINICIO, applicationResponse.getLineStartDate() == null ? null : applicationResponse.getLineStartDate().getTime());
			//dataCreditLine.set(DataCreditLine.FECHAVENCIMIENTO, applicationResponse.getLineExpirationDate() == null ? null : applicationResponse.getLineExpirationDate().getTime());

			String ciudad = applicationResponse.getCity() == null ? "" : String.valueOf(applicationResponse.getCity());
			//String descripcionCiudad = applicationResponse.getCityDestination() == null ? "" : applicationResponse.getCityDestination();
			//dataCreditLine.set(DataCreditLine.CIUDAD, descripcionCiudad);

			dataCreditLine.set(DataCreditLine.CODIGOCLIENTE, applicationResponse.getClient() == null ? 0 : applicationResponse.getClient());
			dataCreditLine.set(DataCreditLine.NRODIAS, applicationResponse.getDaysNumber() == null ? 0 : applicationResponse.getDaysNumber());
			//dataCreditLine.set(DataCreditLine.MONTO, applicationResponse.getAmount() == null ? null : applicationResponse.getAmount());
			dataCreditLine.set(DataCreditLine.MONEDA, applicationResponse.getMoney() == null ? "0" : String.valueOf(applicationResponse.getMoney()));
			//dataCreditLine.set(DataCreditLine.ROTATIVA, applicationResponse.getRotating() == null ? 'N' : applicationResponse.getRotating().charAt(0));
			dataCreditLine.set(DataCreditLine.SECTOR, applicationResponse.getSector());

			if (applicationResponse.getSector() != null && !"".equals(applicationResponse.getSector())) {
				String portfolioType = applicationResponse.getSector();
				logger.logDebug("applicationResponse.getSector()" + applicationResponse.getSector());
				for (CatalogDto catalogDto : queryStoredProcedureManagement.getSegmentListByPortfolioType(portfolioType, arg1, new BehaviorOption(true))) {
					if (applicationResponse.getSector().trim().equals(catalogDto.getCode().trim())) {
						dataCreditLine.set(DataCreditLine.SECTORDESC, catalogDto.getName());
					}
				}
			}

			dataCreditLine.set(DataCreditLine.DESCRIPCIONMONEDA, applicationResponse.getSymbolCurrency());

		} catch (Exception ex) {
			logger.logDebug("Error in loadCreditLine: " + ex);
			throw ex;
		}
	}

	public RiskResponse[] loadRisk(int codigoTramite, int codCliente, ICommonEventArgs arg1, DynamicRequest entities) throws Exception {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		CreditLineRequest creditLineRequest = new CreditLineRequest();

		try {
			creditLineRequest.setTramite(codigoTramite);
			creditLineRequest.setCliente(codCliente);
			serviceRequestTO.getData().put("inCreditLineRequest", creditLineRequest);
			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "CreditFacility.RiskServices.SearchRisk", serviceRequestTO);
			RiskResponse riskResponse2 = null;
			RiskResponse[] riskResponses = null;
			if (serviceResponse != null) {

				if (serviceResponse.isResult()) {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					riskResponses = (RiskResponse[]) serviceResponseTO.getValue("returnRiskResponse");
					riskResponse2 = (RiskResponse) serviceResponseTO.getValue("returnRiskResponse2");

					DataEntity riskEntity = entities.getEntity(Totales.ENTITY_NAME);
					logger.logDebug("riskResponse2.getTotalFinal()" + riskResponse2.getTotalFinal());
					riskEntity.set(Totales.TOTALFINAL, riskResponse2.getTotalFinal());
					// dataCreditLine.set(DataCreditLine.TRAMITE,
					// String.valueOf(riskResponse.getTramite()));

					// dataCreditLine.set(DataCreditLine.CODIGOCLIENTE,
					// creditLineResponse.getCliente() == null ? 0 :
					// Integer.valueOf(creditLineResponse.getCliente()));
				} else {

					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}
				}

			}
			return riskResponses;
		} catch (Exception ex) {
			logger.logDebug("Error in loadRiskLine: " + ex);
			throw ex;
		}
	}

}
