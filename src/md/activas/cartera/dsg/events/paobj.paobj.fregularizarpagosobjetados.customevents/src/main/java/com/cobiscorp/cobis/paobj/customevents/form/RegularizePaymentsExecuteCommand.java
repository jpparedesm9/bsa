package com.cobiscorp.cobis.paobj.customevents.form;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.cobiscorp.cobis.assets.commons.constants.RequestName;
import com.cobiscorp.cobis.assets.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.paobj.model.DatosRegularizarPagos;
import com.cobiscorp.cobis.paobj.model.ResultadoPagosObjetados;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.regularizepayments.dto.InsertRegularizedPaymentsRequest;
import cobiscorp.ecobis.regularizepayments.dto.RegularizePaymentRequest;

public class RegularizePaymentsExecuteCommand extends BaseEvent implements IExecuteCommand {
	private static final ILogger logger = LogFactory.getLogger(RegularizePaymentsExecuteCommand.class);

	public RegularizePaymentsExecuteCommand(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		DataEntityList grid = entities.getEntityList(ResultadoPagosObjetados.ENTITY_NAME);
		DataEntity paymentMethod = entities.getEntity(DatosRegularizarPagos.ENTITY_NAME);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceRequestTO regularizeServiceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		ServiceResponse regularizeServiceResponse;

		try {
			RegularizePaymentRequest regularizePaymentRequest = new RegularizePaymentRequest();
			String paymentMethodCode = paymentMethod.get(DatosRegularizarPagos.FORMAPAGO);
			if (logger.isDebugEnabled())
				logger.logDebug("paymentMethod == null : " + (paymentMethod == null));

			if (logger.isDebugEnabled())
				logger.logDebug("getData() : " + (paymentMethod.getData()));

			int numSeleccionados = 0;

			for (DataEntity item : grid) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(
							"- ResultadoPagosObjetados.IDPRESTAMO = " + item.get(ResultadoPagosObjetados.IDPRESTAMO));
					logger.logDebug(
							"- ResultadoPagosObjetados.SELECCIONAR = " + item.get(ResultadoPagosObjetados.SELECCIONAR));

					logger.logDebug("- ResultadoPagosObjetados.IDPAGO = " + item.get(ResultadoPagosObjetados.IDPAGO));
					logger.logDebug("- ResultadoPagosObjetados.TIPOPRESTAMO = "
							+ item.get(ResultadoPagosObjetados.TIPOPRESTAMO));
					logger.logDebug(
							"- ResultadoPagosObjetados.MONTOPAGADO = " + item.get(ResultadoPagosObjetados.MONTOPAGADO));
					logger.logDebug("- ResultadoPagosObjetados.FECHA = " + item.get(ResultadoPagosObjetados.FECHA));
					logger.logDebug(
							"- ResultadoPagosObjetados.IDPRESTAMO = " + item.get(ResultadoPagosObjetados.IDPRESTAMO));
					logger.logDebug(
							"- ResultadoPagosObjetados.SELECCIONAR = " + item.get(ResultadoPagosObjetados.SELECCIONAR));
				}

				if (item.get(ResultadoPagosObjetados.SELECCIONAR) != null) {
					numSeleccionados++;
				}
			}

			if (logger.isDebugEnabled()) {
				logger.logDebug("grid.size() : " + (grid.size()));
				logger.logDebug("numSeleccionados : " + (numSeleccionados));
			}

			if (grid.size() > 0 && numSeleccionados > 0) {
				for (DataEntity gridValue : grid) {
					if (gridValue.get(ResultadoPagosObjetados.SELECCIONAR) == false) {
						continue;
					}

					InsertRegularizedPaymentsRequest insertRegularizedPaymentsRequest = new InsertRegularizedPaymentsRequest();

					if (logger.isDebugEnabled())
						logger.logDebug("Seteo de ");

					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

					String idOperacion = gridValue.get(ResultadoPagosObjetados.IDPRESTAMO);
					int idPago = Integer.parseInt(gridValue.get(ResultadoPagosObjetados.IDPAGO));
					String fechaValor = gridValue.get(ResultadoPagosObjetados.FECHA);
					double montoPago = gridValue.get(ResultadoPagosObjetados.MONTOPAGADO).doubleValue();
					String tipoOperacion = gridValue.get(ResultadoPagosObjetados.TIPOPRESTAMO);

					Date date = sdf.parse(fechaValor);
					Calendar cal = Calendar.getInstance();
					cal.setTime(date);

					if (logger.isDebugEnabled()) {
						logger.logDebug("idOperacion = " + idOperacion);
						logger.logDebug("idPago = " + idPago);
						logger.logDebug("tipoOperacion = " + tipoOperacion);
						logger.logDebug("montoPago = " + montoPago);
						logger.logDebug("fechaValor = " + fechaValor);
					}

					insertRegularizedPaymentsRequest.setIdOperacion(idOperacion);
					insertRegularizedPaymentsRequest.setIdPago(idPago);
					insertRegularizedPaymentsRequest.setFechaValor(cal);
					insertRegularizedPaymentsRequest.setMontoPago(montoPago);
					insertRegularizedPaymentsRequest.setTipoOperacion(tipoOperacion);

					serviceRequestTO.addValue(RequestName.INSERT_OBJETED_PAYMENTS_REQUEST,
							insertRegularizedPaymentsRequest);
					serviceResponse = this.execute(logger, ServiceId.INSERT_OBJETED_PAYMENTS, serviceRequestTO);

					if (logger.isDebugEnabled())
						logger.logDebug("serviceResponse.isResult() = " + serviceResponse.isResult());

					if (serviceResponse.isResult()) {
						ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
						if (logger.isDebugEnabled())
							logger.logDebug("serviceResponseTO.isSuccess() = " + serviceResponseTO.isSuccess());

						if (serviceResponseTO.isSuccess()) {

						}
					}

					if (logger.isDebugEnabled()) {
						logger.logDebug("ResultadoPagosObjetados.IDPRESTAMO = "
								+ gridValue.get(ResultadoPagosObjetados.IDPRESTAMO));
						logger.logDebug("ResultadoPagosObjetados.SELECCIONAR = "
								+ gridValue.get(ResultadoPagosObjetados.SELECCIONAR));

						logger.logDebug(
								"ResultadoPagosObjetados.IDPAGO = " + gridValue.get(ResultadoPagosObjetados.IDPAGO));
						logger.logDebug("ResultadoPagosObjetados.TIPOPRESTAMO = "
								+ gridValue.get(ResultadoPagosObjetados.TIPOPRESTAMO));
						logger.logDebug("ResultadoPagosObjetados.MONTOPAGADO = "
								+ gridValue.get(ResultadoPagosObjetados.MONTOPAGADO));
						logger.logDebug(
								"ResultadoPagosObjetados.FECHA = " + gridValue.get(ResultadoPagosObjetados.FECHA));
						logger.logDebug("ResultadoPagosObjetados.IDPRESTAMO = "
								+ gridValue.get(ResultadoPagosObjetados.IDPRESTAMO));
						logger.logDebug("ResultadoPagosObjetados.SELECCIONAR = "
								+ gridValue.get(ResultadoPagosObjetados.SELECCIONAR));
					}
				}

				// Operación R

				if (logger.isDebugEnabled())
					logger.logDebug("Inicia: Regularizacion");

				regularizePaymentRequest.setPaymentMethod(paymentMethodCode);

				// if (logger.isDebugEnabled())
				// logger.logDebug("DatosRegularizarPagos.FORMAPAGO = " + paymentMethodCode);

				regularizeServiceRequestTO.addValue(RequestName.REGULARIZE_PAYMENTS_REQUEST, regularizePaymentRequest);
				regularizeServiceResponse = this.execute(logger, ServiceId.REGULARIZE_PAYMENTS,
						regularizeServiceRequestTO);

				if (logger.isDebugEnabled())
					logger.logDebug("regularizeServiceResponse.isResult() = " + regularizeServiceResponse.isResult());

				if (regularizeServiceResponse.isResult()) {
					ServiceResponseTO regularizeServiceResponseTO = (ServiceResponseTO) regularizeServiceResponse
							.getData();
					if (logger.isDebugEnabled())
						logger.logDebug(
								"regularizeServiceResponseTO.isSuccess() = " + regularizeServiceResponseTO.isSuccess());

					if (regularizeServiceResponseTO.isSuccess())
						args.getMessageManager()
								.showSuccessMsg("Los pagos fueron regularizados de manera satisfactoria");
					else
						args.getMessageManager().showErrorMsg("Error al intentar regularizar los pagos objetados");
				}
			} else {
				args.getMessageManager().showErrorMsg("No hay pagos para regularizar.");
			}
		} catch (Exception e) {
			args.getMessageManager().showErrorMsg("Error: " + e.getMessage());
		}
	}

}
