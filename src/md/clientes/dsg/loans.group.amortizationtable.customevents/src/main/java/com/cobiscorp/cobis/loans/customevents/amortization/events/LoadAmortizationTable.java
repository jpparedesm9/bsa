package com.cobiscorp.cobis.loans.customevents.amortization.events;

import java.util.Calendar;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.AmortizationTable;
import com.cobiscorp.cobis.loans.model.Amount;
import com.cobiscorp.cobis.loans.model.Item;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.ReadLoanAmortizationTableRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadLoanAmortizationTableResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReadLoanAmortizationTableResponseTable;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LoadAmortizationTable extends BaseEvent implements IInitDataEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(LoadAmortizationTable.class);

	public LoadAmortizationTable(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		LOGGER.logInfo("Inicia carga de Tabla de Amortizacion Operacion anterior");
		try {
			amortizationQuery(entities);
		} catch (Exception e) {
			LOGGER.logError("ERROR AL CARGAR TABLA DE AMORTIZACION",e);
			args.getMessageManager().showErrorMsg("Error al cargar Tabla de Amortización");
		}
	}

	private void amortizationQuery(DynamicRequest entities) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingresa amortizationQuery >>>");
		}
		ServiceRequestTO request = new ServiceRequestTO();		

		DataEntity amount = entities.getEntity(Amount.ENTITY_NAME);
		
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("OPERACION: ");
			LOGGER.logDebug(amount.get(Amount.OLDOPERATION));
		}

		ReadLoanAmortizationTableRequest amortRequest = new ReadLoanAmortizationTableRequest();

		amortRequest.setBank(amount.get(Amount.OLDOPERATION));

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("inReadLoanAmortizationTableRequest>>>>: ");
		}

		request.addValue("inReadLoanAmortizationTableRequest", amortRequest);

		ServiceResponse response = this.execute(getServiceIntegration(), LOGGER,
				"Loan.LoansQueries.ReadLoanAmortizationTableSearch", request);

		// llena la entidad de rubros
		itemsReponse(entities, response);

		// LLena la entidad de Amortizacion
		amortReponse(entities, response);
	}

	public void itemsReponse(DynamicRequest entities, ServiceResponse response) {
		try {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logInfo("resultado>>>>>" + resultado.toString());
				}

				ReadLoanAmortizationTableResponse[] itemsResponseArray = (ReadLoanAmortizationTableResponse[]) resultado
						.getValue("returnReadLoanAmortizationTableResponse");

				DataEntityList listaItem = new DataEntityList();
				for (ReadLoanAmortizationTableResponse r : itemsResponseArray) {
					DataEntity item = new DataEntity();
					item.set(Item.CONCEPT, r.getConcept());
					item.set(Item.DESCRIPTION, r.getDescription());

					listaItem.add(item);
				}
				entities.setEntityList(Item.ENTITY_NAME, listaItem);
			}
		} catch (Exception e) {
			LOGGER.logError(e);
		}

	}

	public void amortReponse(DynamicRequest entities, ServiceResponse response) {
		try {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

				ReadLoanAmortizationTableResponseTable[] amortResponseArray = (ReadLoanAmortizationTableResponseTable[]) resultado
						.getValue("returnReadLoanAmortizationTableResponseTable");

				DataEntityList lista = new DataEntityList();
				for (ReadLoanAmortizationTableResponseTable amorrespont : amortResponseArray) {
					DataEntity item = new DataEntity();
					item.set(AmortizationTable.DIVIDEND, amorrespont.getDividend());
					item.set(AmortizationTable.EXPIRATIONDATE, convertCalendarToDate(amorrespont.getExpirationDate()));
					item.set(AmortizationTable.BALANCE, amorrespont.getBalance());
					item.set(AmortizationTable.ITEM1, amorrespont.getItem1());
					item.set(AmortizationTable.ITEM1, amorrespont.getItem1());
					item.set(AmortizationTable.ITEM2, amorrespont.getItem2());
					item.set(AmortizationTable.ITEM3, amorrespont.getItem3());
					item.set(AmortizationTable.ITEM4, amorrespont.getItem4());
					item.set(AmortizationTable.ITEM5, amorrespont.getItem5());
					item.set(AmortizationTable.ITEM6, amorrespont.getItem6());
					item.set(AmortizationTable.ITEM7, amorrespont.getItem7());
					item.set(AmortizationTable.ITEM8, amorrespont.getItem8());
					item.set(AmortizationTable.ITEM9, amorrespont.getItem9());
					item.set(AmortizationTable.ITEM10, amorrespont.getItem10());
					item.set(AmortizationTable.ITEM11, amorrespont.getItem11());
					item.set(AmortizationTable.ITEM12, amorrespont.getItem12());
					item.set(AmortizationTable.ITEM13, amorrespont.getItem13());
					item.set(AmortizationTable.FEE, amorrespont.getShareValue());
					lista.add(item);
				}

				entities.setEntityList(AmortizationTable.ENTITY_NAME, lista);
			}
		} catch (Exception e) {
			LOGGER.logError(e);
		}
	}

	private static Date convertCalendarToDate(Calendar calendar) {
		Date date = null;

		try {
			date = calendar.getTime();
		} catch (Exception ex) {
			LOGGER.logError(ex);
		}
		return date;
	}
}
