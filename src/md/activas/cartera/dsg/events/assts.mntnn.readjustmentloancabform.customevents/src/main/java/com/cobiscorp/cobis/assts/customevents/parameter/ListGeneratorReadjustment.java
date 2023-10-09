package com.cobiscorp.cobis.assts.customevents.parameter;

import cobiscorp.ecobis.assets.cloud.dto.ReadjustmentLoanResponse;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.events.ReadjustmentLoanCommandEvents;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.common.BaseEvent;

public class ListGeneratorReadjustment extends BaseEvent {

	public ListGeneratorReadjustment(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentLoanCommandEvents.class);

	public DataEntityList listGeneratorReadjustmentLoan(ServiceResponse response) {
		DataEntityList lista = null;

		try {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				ReadjustmentLoanResponse[] clResponse = (ReadjustmentLoanResponse[]) resultado
						.getValue("returnReadjustmentLoanResponse");

				if (logger.isDebugEnabled()) {
					logger.logInfo("Respuesta servicio " + clResponse);
				}

				lista = new DataEntityList();
				for (ReadjustmentLoanResponse r : clResponse) {
					DataEntity item = new DataEntity();
					item.set(ReadjustmentLoanCab.DATE, GeneralFunction
							.convertStringToDate(r.getDate(),
									Parameter.TYPEDATEFORMAT.DDMMYYYY));
					item.set(ReadjustmentLoanCab.MANTCUOTA,
							r.getMaintenanceFee());
					item.set(ReadjustmentLoanCab.SECUENCIAL, r.getSecuencial());
					item.set(ReadjustmentLoanCab.DESAGIO, r.getDesagio());
					lista.add(item);
				}
			}
		} catch (Exception e) {
			this.manageException(e, logger);
		}

		return lista;
	}
}
