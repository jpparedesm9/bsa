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
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;
import com.cobiscorp.ecobis.external.services.bl.IExternalService;

public class DebitCardHisManagerImpl extends ServiceBase implements IExternalService {

	private static ILogger logger = LogFactory.getLogger(DebitCardHisManagerImpl.class);
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public Object executeService(Object... values) {
		List<SummaryOtherDTO> summaryDebitCards = new ArrayList<SummaryOtherDTO>();
		try {
			logger.logDebug("Starts execute in DebitCardManagerImpl");
			List<CardData> debitCards = getDebitCardsByCustomer((Integer) values[0]);
			for (CardData debitCard : debitCards) {
				SummaryOtherDTO summaryOther = new SummaryOtherDTO();
				summaryOther.setAmount(debitCard.getSaldoDisponible());
				summaryOther.setAmountML(debitCard.getLimiteAprobado());
				summaryOther.setOperationTypeDescription(debitCard.getDescripcion());
				summaryOther.setNumberOperation(String.valueOf(debitCard.getNumeroTarjeta()));
				summaryOther.setSubTypeId(debitCard.getCodigoTarjeta());
				summaryOther.setCurrencyDesc(debitCard.getMoneda());
				summaryOther.setProduct(debitCard.getMarca());
				summaryOther.setSubType(debitCard.getTipoTarjeta());
				summaryOther.setWarrantyClass(debitCard.getEstado());
				summaryOther.setDateVTCRegistry(debitCard.getFechaExpira() == null ? null : debitCard.getFechaExpira().getTime());
				summaryOther.setInsurance(debitCard.getSeguro());
				summaryOther.setOffice(debitCard.getOficina());
				summaryOther.setAssociateAcount(debitCard.getCuentaAsociada());
				if (debitCard.getFechaCancela() != null) {
					summaryOther.setCancellationDate(debitCard.getFechaCancela().getTime());
				}
				summaryDebitCards.add(summaryOther);
			}
		} catch (BusinessException be) {
			logger.logError(be);
			throw be;

		} catch (Exception e) {
			logger.logError(e);
			throw new BusinessException(7300039, "Ocurrió un error al consultar el histórco de las Tarjetas de Débito");
		} finally {
			logger.logDebug("Finish execute in DebitCardManagerImpl");

		}

		return summaryDebitCards;
	}

	private List<CardData> getDebitCardsByCustomer(Integer customer) {
		try {
			logger.logInfo("Ejecuta Consulta de Tarjetas de Débito por Cliente");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();						
			CardInformation cardInf = new CardInformation();
			cardInf.setCustomer(customer.intValue());
			cardInf.setCategoria("D");
			cardInf.setOperacion("S"); // Operacion S = Todas las operaciones.
			serviceRequestTO.getData().put("inCardInformation", cardInf);
			ServiceResponse serviceResponse = execute(this.serviceIntegration, logger, "Card.CardManagement.getCardsByCustomer", serviceRequestTO);
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			CardData[] arrCardDataDTO = (CardData[]) serviceResponseTO.getValue("returnCardData");
			List<CardData> lstCardDataDTO = new ArrayList<CardData>(Arrays.asList(arrCardDataDTO));
			if (logger.isDebugEnabled()) {
				logger.logDebug("CardResponse de Débito size:" + lstCardDataDTO.size());
			} 
			return lstCardDataDTO;
		} catch (Exception e) {
			logger.logError(e);
			logger.logError("Ocurrió un error al consultar el Histórico de Tarjetas de Débito");
			return new ArrayList<CardData>();
		} finally {
			logger.logDebug("Finaliza Consulta de Tarjetas de Débito por Cliente");
		}
	}

	public ICTSServiceIntegration getServiceIntegration() {
		return serviceIntegration;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

}
