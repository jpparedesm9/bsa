package com.cobiscorp.cobis.paobj.customevents.view;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.assets.commons.constants.RequestName;
import com.cobiscorp.cobis.assets.commons.constants.ReturnName;
import com.cobiscorp.cobis.assets.commons.constants.ServiceId;
import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.regularizepayments.dto.PaymentMethodRequest;
import cobiscorp.ecobis.regularizepayments.dto.PaymentMethodResponse;

public class PaymentMethodLoadCatalog extends BaseEvent implements ILoadCatalog {
	private static final ILogger logger = LogFactory.getLogger(PaymentMethodLoadCatalog.class);

	public PaymentMethodLoadCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs arg1) {
		try {
			logger.logDebug("Inicio: PaymentMethodLoadCatalog.executeDataEvent");
			List<ItemDTO> lista = new ArrayList<ItemDTO>();
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponse serviceResponse;
			DataEntityList list = new DataEntityList();
			PaymentMethodRequest paymentMethodRequest = new PaymentMethodRequest();
			// paymentMethodRequest.setCreditLine(result.get(ResultadoPagosObjetados.));
			logger.logDebug("Seteo de setType(1)");
			paymentMethodRequest.setType(2);
			logger.logDebug("Seteo de setCurrency(0)");
			paymentMethodRequest.setCurrency(0);
			logger.logDebug("Seteo de setOperation(\"A\")");
			paymentMethodRequest.setOperation("A");
			logger.logDebug("Despues de Seteo de setOperation(\"A\")");
			logger.logDebug("super.getServiceIntegration() != null: " + (super.getServiceIntegration() != null));

			serviceRequestTO.addValue(RequestName.PAYMENT_METHOD_REQUEST, paymentMethodRequest);
			serviceResponse = this.execute(logger, ServiceId.QUERY_PAYMENT_METHODS, serviceRequestTO);

			if (serviceResponse.isResult()) {
				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
				if (serviceResponseTO.isSuccess()) {
					PaymentMethodResponse[] response = (PaymentMethodResponse[]) serviceResponseTO
							.getValue(ReturnName.PAYMENT_METHOD_RESPONSE);

					for (PaymentMethodResponse item : response) {

						if (!item.getDescription().trim().equals("OBJETADO")
								&& !item.getDescription().trim().equals("QUEBRANTO")) {
							ItemDTO itemDTO = new ItemDTO();
							itemDTO.setCode(item.getProduct());
							itemDTO.setValue(item.getDescription().trim());
							lista.add(itemDTO);
						}
					}
				}
			} else {
				String mensaje = GeneralFunction.getMessageError(serviceResponse.getMessages(), null);
				arg1.getMessageManager().showErrorMsg(mensaje);
			}
			return lista;
		} catch (Exception ex) {
			logger.logDebug("Exception--> " + ex);
		}
		return null;
	}

}