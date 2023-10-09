package com.cobiscorp.ecobis.external.services.bl.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cobiscorp.ecobis.card.dto.CardData;
import cobiscorp.ecobis.card.dto.CardInformation;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.external.services.bl.IExternalService;

public class CreditCardHisManagerImpl extends ServiceBase implements IExternalService {
	private static ILogger logger = LogFactory.getLogger(CreditCardHisManagerImpl.class);
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Object executeService(Object... values) {
		logger.logDebug("Starts execute in CreditCardManagerHisImpl");

		List<SummaryDebtsDTO> summaryDebtsDTOs = new ArrayList<SummaryDebtsDTO>();
		try {
			logger.logDebug("CreditCardManagerHisImpl --> Customer id:" + (Integer) values[0]);
			List<CardData> creditCards = getCreditCardsByCustomer((Integer) values[0]);

			for (CardData cardData : creditCards) {
				SummaryDebtsDTO summaryDebt = new SummaryDebtsDTO();
				summaryDebt.setAvailable(cardData.getSaldoDisponible());
				summaryDebt.setAmount(cardData.getLimiteAprobado());
				summaryDebt.setState(cardData.getEstado());
				summaryDebt.setProduct(cardData.getMarca());
				summaryDebt.setNumberOperation(String.valueOf(cardData.getNumeroTarjeta()));
				summaryDebt.setOperationType(cardData.getTipoTarjeta());
				summaryDebt.setDescriptionType(cardData.getDescripcion());
				summaryDebt.setExpirationDate(cardData.getFechaExpira() == null ? null : cardData.getFechaExpira().getTime());
				summaryDebt.setCurrencyDescription(cardData.getMoneda());
				summaryDebt.setTypeCon(cardData.getCodigoTarjeta());
				summaryDebt.setOffice(cardData.getOficina());
				summaryDebt.setAssociateAmount(cardData.getCuentaAsociada());
				summaryDebtsDTOs.add(summaryDebt);
			}
		} catch (BusinessException be) {
			logger.logError(be);
			throw be;

		} catch (Exception e) {
			logger.logError(e);
			throw new BusinessException(7300037, "Ocurrió un error al consultar el Histórico de Tarjetas de Crédito");
		} finally {
			logger.logDebug("Finish execute in CreditCardManagerImpl");
		}
		return summaryDebtsDTOs;
	}

	private List<CardData> getCreditCardsByCustomer(Integer customer) {
		try {
			logger.logInfo("Ejecuta Consulta de Tarjetas de Crédito  por Cliente");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();						
			CardInformation cardInf = new CardInformation();
			cardInf.setCustomer(customer.intValue());
			cardInf.setCategoria("C");
			cardInf.setOperacion("S"); // Operacion S = Todas las operaciones.
			serviceRequestTO.getData().put("inCardInformation", cardInf);
			ServiceResponse serviceResponse = execute(this.serviceIntegration, logger, "Card.CardManagement.getCardsByCustomer", serviceRequestTO);

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			CardData[] arrCardDataDTO = (CardData[]) serviceResponseTO.getValue("returnCardData");
			List<CardData> lstCardDataDTO = new ArrayList<CardData>(Arrays.asList(arrCardDataDTO));
			if (logger.isDebugEnabled())
				logger.logDebug("CardResponse de Crédito size:" + lstCardDataDTO.size());
			return lstCardDataDTO;
		} catch (Exception e) {
			logger.logError(e);
			logger.logError("Ocurrió un error al consultar el Histórico de Tarjetas de Crédito");
			return new ArrayList<CardData>();
		} finally {
			logger.logDebug("Finaliza Consulta de Tarjetas de Crédito por Cliente");
		}
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
