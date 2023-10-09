package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ConsolidatePenalizationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.PenalizationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SourceFundingRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SourceFundingResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.SourceFunding;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SourceFundingManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(SourceFundingManagement.class);
	private ConsolidatePenalizationResponse consolidatePenalizationResponse;
	private PenalizationResponse[] penalizationList;

	public PenalizationResponse[] getPenalizationResponse() {
		return this.penalizationList;
	}

	public ConsolidatePenalizationResponse getConsolidatePenalizationResponse() {
		return this.consolidatePenalizationResponse;
	}

	public SourceFundingManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	// Busca las Todas Fuentes de Financiamiento
	public SourceFundingResponse[] searchSourceFunding(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTOException = new ServiceRequestTO();
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHSOURCEFUNDING, serviceRequestTOException);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("LISTA DE LAS FUENTES DE FINANCIAMIENTO - cr_fuente_financiamiento");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			SourceFundingResponse[] sourceFundingList = (SourceFundingResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNSOURCEFUNDINGRESPONSE);
			return sourceFundingList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;

	}

	//Retorna las posibles Fuentes de Financiamiento con la informacion del tramite 
	public SourceFundingResponse[] getSourceFunding(int idTramite, int tasa, ICommonEventArgs arg1, BehaviorOption options) {
		SourceFundingRequest sourceFundingRequest = new SourceFundingRequest();
		sourceFundingRequest.setTramite(idTramite);
		sourceFundingRequest.setTasa(tasa);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.getData().put(RequestName.INSOURCEFUNDINGREQUEST, sourceFundingRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADSOURCEFUNDING, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("ApplicationResponse recuperados para Tramite - " + idTramite);
				logger.logDebug("ApplicationResponse recuperados para Tasa - " + tasa);
			}

			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			SourceFundingResponse[] sourceFundingList = (SourceFundingResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNSOURCEFUNDINGRESPONSE);
			return sourceFundingList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

}
