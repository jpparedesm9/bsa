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

public class CreditCardContingentsManagerImpl extends ServiceBase implements IExternalService {
	private static ILogger logger = LogFactory.getLogger(CreditCardContingentsManagerImpl.class);

	@Override
	public Object executeService(Object... values) {
		List<SummaryDebtsDTO> summaryDebtsDTOs = new ArrayList<SummaryDebtsDTO>();
		try {
			logger.logDebug("CreditCardManagerImpl CONTINGENTS --> Customer id:" + (Integer) values[0]);
			List<CardData> creditCards = CreditCardManagerImpl.getCreditCardsContingents((Integer) values[0]);

			for (CardData cardData : creditCards) {
				SummaryDebtsDTO summaryDebt = new SummaryDebtsDTO();
				summaryDebt.setAvailable(cardData.getSaldoDisponible());
				summaryDebt.setAmount(cardData.getLimiteAprobado());
				summaryDebt.setState(cardData.getEstado());
				summaryDebt.setProduct("CRE");
				summaryDebt.setTradeMark(cardData.getMarca());
				summaryDebt.setNumberOperation(cardData.getCodigoLinea());
				summaryDebt.setLineNumber(cardData.getCodigoLinea());
				summaryDebt.setOperationType(cardData.getTipoTarjeta()); // se cambia por solicitud de FIE
				summaryDebt.setDescriptionType(cardData.getMarca()); // se cambia por solicitud de FIE
				summaryDebt.setExpirationDate(cardData.getFechaExpira() == null ? null : cardData.getFechaExpira().getTime());
				summaryDebt.setCurrencyId(Integer.parseInt(cardData.getMoneda()));
				summaryDebt.setTypeCon(cardData.getCodigoTarjeta());
				summaryDebt.setAmounLocalMoney(cardData.getSaldoDisponible());
				summaryDebt.setCurrencyDescription(cardData.getMonedaDesc());
				summaryDebt.setProductType("TCR");
				summaryDebtsDTOs.add(summaryDebt);
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
