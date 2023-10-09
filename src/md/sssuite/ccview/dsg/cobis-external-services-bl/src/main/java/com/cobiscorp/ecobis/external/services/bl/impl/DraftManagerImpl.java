package com.cobiscorp.ecobis.external.services.bl.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cobiscorp.ecobis.bankingservices.dto.Remittance;
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

public class DraftManagerImpl extends ServiceBase implements IExternalService {
	private static ILogger logger = LogFactory.getLogger(DraftManagerImpl.class);
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Object executeService(Object... values) {
		logger.logDebug("Starts execute in DraftManagerImpl -->" + values[0] + "-->" + values[1]);
		List<SummaryOtherDTO> summaryDrafts = new ArrayList<SummaryOtherDTO>();
		try {
			List<Remittance> remittances = getDrafts((Integer) values[0]);
			for (Remittance remittance : remittances) {
				SummaryOtherDTO summaryOther = new SummaryOtherDTO();
				summaryOther.setAmount(remittance.getAmount());
				summaryOther.setCurrencyDesc(remittance.getCurrencyDescription());
				summaryOther.setBeneficiary(String.valueOf(remittance.getBeneficiaryId()));
				summaryOther.setClient(remittance.getClientId());
				summaryOther.setNumberOperation(String.valueOf(remittance.getCount()));
				summaryOther.setStatus(remittance.getStatus());
				summaryDrafts.add(summaryOther);
			}
		} catch (BusinessException be) {
			logger.logError(be);
			throw be;

		} catch (Exception e) {
			logger.logError(e);
			throw new BusinessException(7300041, "Ocurrió un error al consultar los Giros");
		} finally {
			logger.logDebug("Finish execute in DraftManagerImpl");

		}

		return summaryDrafts;
	}

	private List<Remittance> getDrafts(Integer customer) {
		try {
			logger.logInfo("Ejecuta Consulta de drafts por Cliente");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();			
			Remittance remittance = new Remittance();
			remittance.setClientId(customer);
			serviceRequestTO.getData().put("inRemittance", remittance);
			ServiceResponse serviceResponse = execute(this.serviceIntegration, logger, "BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary", serviceRequestTO);

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			Remittance[] draftDTO = (Remittance[]) serviceResponseTO.getValue("returnRemittance");
			List<Remittance> lstDraftsDTO = new ArrayList<Remittance>(Arrays.asList(draftDTO));
			if (logger.isDebugEnabled()) {
				logger.logDebug("Drafts response size:" + lstDraftsDTO.size());
			}
			return lstDraftsDTO;
		} catch (Exception e) {
			logger.logError(e);
			logger.logError("Ocurrió un error al consultar los Giros");
			return new ArrayList<Remittance>();
		} finally {
			logger.logDebug("Finaliza Consulta de Giros por Cliente");
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
