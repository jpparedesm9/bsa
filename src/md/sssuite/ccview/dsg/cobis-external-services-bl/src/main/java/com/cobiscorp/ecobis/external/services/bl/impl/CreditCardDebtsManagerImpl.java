package com.cobiscorp.ecobis.external.services.bl.impl;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.card.dto.CardData;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.external.services.bl.IExternalService;

public class CreditCardDebtsManagerImpl extends ServiceBase implements IExternalService {
	private static ILogger logger = LogFactory.getLogger(CreditCardDebtsManagerImpl.class);

	@Override
	public Object executeService(Object... values) {
		List<SummaryDebtsDTO> summaryDebtsDTOs = new ArrayList<SummaryDebtsDTO>();
		try {
			logger.logDebug("CreditCardManagerImpl DEBTS --> Customer id:" + (Integer) values[0]);
			List<CardData> creditCards = CreditCardManagerImpl.getCreditCardsDebts((Integer) values[0]);

			for (CardData cardData : creditCards) {
				SummaryDebtsDTO summaryDebt = new SummaryDebtsDTO();
				summaryDebt.setAvailable(cardData.getMontoUtilizado());
				summaryDebt.setAmount(cardData.getLimiteAprobado());
				summaryDebt.setState(cardData.getEstado());
				summaryDebt.setProduct("CCA");
				summaryDebt.setTradeMark(cardData.getMarca());
				summaryDebt.setNumberOperation(String.valueOf(cardData.getCodigoLinea()));
				summaryDebt.setOperationType(cardData.getTipoTarjeta());
				summaryDebt.setDescriptionType(cardData.getMarca());
				summaryDebt.setExpirationDate(cardData.getFechaExpira() == null ? null : cardData.getFechaExpira().getTime());
				summaryDebt.setCurrencyId(Integer.parseInt(cardData.getMoneda()));
				summaryDebt.setTypeCon(cardData.getCodigoTarjeta());
				summaryDebt.setAmounLocalMoney(cardData.getMontoUtilizado());
				summaryDebt.setCurrencyDescription(cardData.getMonedaDesc());
				summaryDebtsDTOs.add(summaryDebt);
				summaryDebt.setProductType("TCR");
			}
		} catch (BusinessException be) {
			logger.logError(be);
			throw be;

		} catch (Exception e) {
			logger.logError(e);
			throw new BusinessException(7300038, "Ocurrió un error al consultar las Tarjetas de Crédito");
		} finally {
			logger.logDebug("Finish execute in CreditCardContingentsManagerImpl");
		}
		return summaryDebtsDTOs;
	}
}
