package com.cobiscorp.ecobis.external.services.bl.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.remittance.dto.RemittanceRequest;
import cobiscorp.ecobis.remittance.dto.RemittanceResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;
import com.cobiscorp.ecobis.external.services.bl.IExternalService;

public class RemittancesManagerImpl extends ServiceBase implements IExternalService {
	private static ILogger logger = LogFactory.getLogger(RemittancesManagerImpl.class);
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Object executeService(Object... values) {
		List<SummaryOtherDTO> summaryRemittances = new ArrayList<SummaryOtherDTO>();
		try {
			logger.logDebug("Starts execute in RemittancesManagerImpl");
			logger.logDebug("values[0]" + values[0]);
			List<RemittanceResponse> remittances = getRemittance(String.valueOf(values[0]));
			List<RemittanceResponse> remittancesDetail = getRemittanceDetail(String.valueOf(values[0]));

			if (remittances != null && !remittances.isEmpty()) {
				for (RemittanceResponse remittance : remittances) {
					logger.logDebug("remittance" + remittance);
					SummaryOtherDTO summaryOther = new SummaryOtherDTO();
					logger.logDebug("remittance.getCurrencyCode()" + remittance.getCurrencyCode());
					summaryOther.setCurrencyDesc(remittance.getCurrencyCode());
					logger.logDebug("remittance.getRemittanceAmount()" + remittance.getRemittanceAmount());
					summaryOther.setOperation(remittance.getRemittanceAmount());
					logger.logDebug("remittance.getTotalPayment()" + remittance.getTotalPayment());
					summaryOther.setBalance(remittance.getTotalPayment());

					List<Object> details = new ArrayList<Object>();
					if (remittancesDetail != null && !remittancesDetail.isEmpty()) {
						for (RemittanceResponse remittanceDetail : remittancesDetail) {
							logger.logDebug("remittancesDetail" + remittanceDetail);
							if (remittanceDetail.getCurrencyCode() != null && remittanceDetail.getCurrencyCode().equals(remittance.getCurrencyCode())) {
								SummaryOtherDTO summaryDetail = new SummaryOtherDTO();
								logger.logDebug("remittanceDetail.getRemittanceNumber()" + remittanceDetail.getRemittanceNumber());
								summaryDetail.setSequence(remittanceDetail.getRemittanceNumber());

								logger.logDebug("remittanceDetail.getCurrencyCode()" + remittanceDetail.getCurrencyCode());
								summaryDetail.setCurrencyDesc(remittanceDetail.getCurrencyCode());

								if (remittanceDetail.getShippingDate() != null) {
									logger.logError("remittanceDetail.getShippingDate()" + remittanceDetail.getShippingDate().toString());
									logger.logError("remittanceDetail.getShippingDate().getTime" + remittanceDetail.getShippingDate().getTime());
									summaryDetail.setDateAPRRegistry(remittanceDetail.getShippingDate().getTime());
								} else {
									summaryDetail.setShipmentDate(null);
								}

								logger.logDebug("remittanceDetail.getStatus()" + remittanceDetail.getStatus());
								summaryDetail.setStatus(remittanceDetail.getStatus());

								logger.logDebug("remittanceDetail.getPaymentValue()" + remittanceDetail.getPaymentValue());
								summaryDetail.setBalance(remittanceDetail.getPaymentValue());

								if (remittanceDetail.getPaymentDate() != null) {
									logger.logDebug("remittanceDetail.getPaymentDate()" + remittanceDetail.getPaymentDate());
									summaryDetail.setCancellationDate(remittanceDetail.getPaymentDate().getTime());
								} else {
									summaryDetail.setCancellationDate(null);
								}

								logger.logDebug("remittanceDetail.getRemittance()" + remittanceDetail.getRemittance());
								summaryDetail.setOperationType(remittanceDetail.getRemittance());
								details.add(summaryDetail);

							}

						}
					}
					summaryOther.setDetails(details);
					summaryRemittances.add(summaryOther);
				}
			}
		} catch (BusinessException be) {
			logger.logError(be);
			throw be;

		} catch (Exception e) {
			logger.logError(e);

			throw new BusinessException(7300042, "Ocurrió un error al consultar las remesas recibidas");
		} finally {
			logger.logDebug("Finish execute in RemittancesManagerImpl");

		}

		return summaryRemittances;
	}

	private List<RemittanceResponse> getRemittanceDetail(String clientId) {
		try {
			logger.logInfo("Ejecuta Consulta de Remesas por Cliente o Beneficiario");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			RemittanceRequest remittance = new RemittanceRequest();
			remittance.setIdentificationDocument(clientId);
			serviceRequestTO.addValue("inRemittanceRequest", remittance);
			ServiceResponse serviceResponse = execute(this.serviceIntegration, logger, "Remittance.RemittanceService.QueryRemittanceByClient", serviceRequestTO);

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			RemittanceResponse[] remittanceDTO = (RemittanceResponse[]) serviceResponseTO.getValue("returnRemittanceResponse");
			List<RemittanceResponse> lstRemittanceDTO = new ArrayList<RemittanceResponse>(Arrays.asList(remittanceDTO));

			if (logger.isDebugEnabled()) {
				logger.logDebug("Remittance response size:" + lstRemittanceDTO.size());
			}

			return lstRemittanceDTO;
		} catch (Exception e) {
			logger.logError(e);
			logger.logError("Ocurrió un error al consultar el detalle de las Remesas recibidas");
			return new ArrayList<RemittanceResponse>();
		} finally {
			logger.logDebug("Finaliza Consulta de Remesas por Cliente");
		}
	}

	private List<RemittanceResponse> getRemittance(String clientId) {
		try {
			logger.logInfo("Ejecuta Consulta de Remesas por Cliente o Beneficiario");
			List<RemittanceResponse> lstRemittanceDTO = new ArrayList<RemittanceResponse>();
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			RemittanceRequest remittance = new RemittanceRequest();
			remittance.setIdentificationDocument(clientId);
			serviceRequestTO.addValue("inRemittanceRequest", remittance);
			ServiceResponse serviceResponse = execute(this.serviceIntegration, logger, "Remittance.RemittanceService.GroupRemittanceByClient", serviceRequestTO);

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			RemittanceResponse[] remittanceDTO = serviceResponseTO.getValue("returnRemittanceResponse") == null ? null : (RemittanceResponse[]) serviceResponseTO
					.getValue("returnRemittanceResponse");
			if (remittanceDTO != null) {
				lstRemittanceDTO = new ArrayList<RemittanceResponse>(Arrays.asList(remittanceDTO));
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Remittance response size:" + lstRemittanceDTO.size());
			}

			return lstRemittanceDTO;
		} catch (Exception e) {
			logger.logError("Ocurrió un error al consultar las Remesas recibidas", e);
			return new ArrayList<RemittanceResponse>();
		} finally {
			logger.logDebug("Finaliza Consulta de Remesas por Cliente");
		}
	}

	/* Getters & Setters */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
