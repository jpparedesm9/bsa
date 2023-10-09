package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.RetentionResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.MethodsRetention;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class AddQueryEvents extends BaseEvent implements IExecuteQuery {

	public AddQueryEvents(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	private static final ILogger logger = LogFactory
			.getLogger(AddQueryEvents.class);

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,
			IExecuteQueryEventArgs args) {
		DataEntityList loanList = new DataEntityList();
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("EXECUTE QUERY METODO RETENCION");
			}
			ServiceRequestTO request = new ServiceRequestTO();

			ServiceResponse response = this.execute(logger,
					Parameter.PROCESSSEARCHRETENTION, request);
			loanList = loansResponse(response, args);
			
		} catch (Exception ex) {
			manageException(ex, logger);
			args.getMessageManager().showErrorMsg(
					"ASSTS.MSG_ASSTS_NOSEPUDEP_50106");
		}
		return  loanList.getDataList();
	}

	private DataEntityList loansResponse(ServiceResponse response, IExecuteQueryEventArgs args) {

		DataEntityList listaRetentionResponse = new DataEntityList();
		try {

			if (logger.isDebugEnabled()) {
				logger.logDebug("EXECUTE QUERY METODO MAPEA DATOS");
			}

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (resultado.isSuccess()) {

					RetentionResponse[] itemsResponseArray = (RetentionResponse[]) resultado
							.getValue("returnRetentionResponse");

					listaRetentionResponse.clear();

					for (RetentionResponse r : itemsResponseArray) {
						DataEntity item = new DataEntity();
						item.set(MethodsRetention.PRODUCT, r.getProduct());
						
						item.set(MethodsRetention.DESCRIPTION,
								r.getDescription());
						
						item.set(MethodsRetention.CATEGORY, r.getCategory());
						item.set(MethodsRetention.REVERSEPRO,
								r.getProductReverse());
						item.set(MethodsRetention.CURRENCYRETENTION,
								r.getCurrency());
						item.set(MethodsRetention.DISBURSEMENT,
								r.getDisbursement());

						item.set(MethodsRetention.PAYMENT, r.getPayment());
						item.set(MethodsRetention.RETENTIONDAYS,
								r.getRetentionDays());

						item.set(MethodsRetention.VALUECODE, r.getValueCode());
						item.set(MethodsRetention.PAYMENTAUT, r.getPaymentAut());

						item.set(MethodsRetention.CURRENCYRETENTION,
								r.getCurrency());

						item.set(MethodsRetention.PAYMENTATX, r.getPaymentATX());

						item.set(MethodsRetention.DESCCURRENCY,
								r.getDescCurrency());
						
						item.set(MethodsRetention.DESCCOBIS, r.getDescPcobis());

						item.set(MethodsRetention.REVERSEPRO,
								r.getProductReverse());

						item.set(MethodsRetention.AFFECTATION,
								r.getAffectation());

						item.set(MethodsRetention.ACTIVEPASSIVE,
								r.getActivePasive());

						item.set(MethodsRetention.STATE, r.getState());

						item.set(MethodsRetention.BANKINSTRUMENT,
								r.getBankInstrument());

						item.set(MethodsRetention.BANKSERVICES,
								r.getBankDescription());
						
						listaRetentionResponse.add(item);
					}
					if (logger.isDebugEnabled()) {
						logger.logDebug("listaRetentionResponse size: "
								+ listaRetentionResponse.size());
						logger.logDebug("listaRetentionResponse: "
								+ listaRetentionResponse.getDataList());
					}
					return listaRetentionResponse;
				}

			}

			else {
				args.setSuccess(false);
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);
				args.getMessageManager().showErrorMsg(mensaje);
			}
		} catch (Exception ex) {
			logger.logError("ERROR: ", ex);

		}
		return listaRetentionResponse;

	}
}
