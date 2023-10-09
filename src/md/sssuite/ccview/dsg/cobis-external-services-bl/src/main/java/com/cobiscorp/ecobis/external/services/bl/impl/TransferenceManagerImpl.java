package com.cobiscorp.ecobis.external.services.bl.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cobiscorp.ecobis.comext.dto.Transference;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;
import com.cobiscorp.ecobis.external.services.bl.IExternalService;

public class TransferenceManagerImpl extends ServiceBase implements IExternalService {
	private static ILogger logger = LogFactory.getLogger(TransferenceManagerImpl.class);
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Object executeService(Object... values) {
		List<SummaryOtherDTO> summaryDrafts = new ArrayList<SummaryOtherDTO>();
		try {
			logger.logDebug("Starts execute in TransferenceManagerImpl");
			List<Transference> transfers = getTransferences((Integer) values[0]);

			for (Transference transference : transfers) {
				SummaryOtherDTO summaryOther = new SummaryOtherDTO();
				summaryOther.setAmount(transference.getAmount());
				summaryOther.setCurrencyDesc(transference.getCurrencyName());
				summaryOther.setClient(transference.getClientId());
				summaryOther.setOperationType(transference.getOperationType());
				summaryOther.setNumberOperation(String.valueOf(transference.getCount()));
				summaryDrafts.add(summaryOther);
			}
		} catch (BusinessException be) {
			logger.logError(be);
			throw be;

		} catch (Exception e) {
			logger.logError(e);

			throw new BusinessException(7300043, "Ocurrió un error al consultar las Transferencias");
		} finally {
			logger.logDebug("Finish execute in TransferenceManagerImpl");

		}

		return summaryDrafts;
	}

	private List<Transference> getTransferences(Integer clientId) {
		try {
			logger.logInfo("Ejecuta Consulta de Transferences por Cliente o Beneficiario");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			Transference transference = new Transference();
			transference.setClientId(clientId);
			serviceRequestTO.addValue("inTransference", transference);
			ServiceResponse serviceResponse = execute(this.serviceIntegration, logger, "Comext.Query.ComextQuery.QueryAnnualTransferenceByClient", serviceRequestTO);

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			Transference[] transferenceDTO = (Transference[]) serviceResponseTO.getValue("returnTransference");
			List<Transference> lstTransferenceDTO = new ArrayList<Transference>(Arrays.asList(transferenceDTO));

			if (logger.isDebugEnabled()) {
				logger.logDebug("Transference response size:" + lstTransferenceDTO.size());
			}

			return lstTransferenceDTO;
		} catch (Exception e) {
			logger.logError(e);
			logger.logError("Ocurrió un error al consultar las Transferencias");
			return new ArrayList<Transference>();
		} finally {
			logger.logDebug("Finaliza Consulta de Transferences por Cliente");
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
