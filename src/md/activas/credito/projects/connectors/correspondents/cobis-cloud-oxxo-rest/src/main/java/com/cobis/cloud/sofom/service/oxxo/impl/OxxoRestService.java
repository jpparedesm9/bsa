package com.cobis.cloud.sofom.service.oxxo.impl;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobis.cloud.sofom.service.oxxo.OxxoService;
import com.cobis.cloud.sofom.service.oxxo.dto.Concept;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsConsultaRequest;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsConsultaResponse;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsPagoRequest;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsPagoResponse;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsReversaRequest;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsReversaResponse;
import com.cobis.cloud.sofom.service.oxxo.integration.IntegrationServiceOxxoConsulta;
import com.cobis.cloud.sofom.service.oxxo.integration.IntegrationServiceOxxoPay;
import com.cobis.cloud.sofom.service.oxxo.integration.IntegrationServiceOxxoReverse;
import com.cobis.cloud.sofom.service.oxxo.response.ComplementConsulta;
import com.cobis.cloud.sofom.service.oxxo.response.OlsResponseError;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoConstants;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoPrintObject;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoTransformMoney;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoValidator;
import com.cobiscorp.cobis.commons.exceptions.COBISException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

@Path("/")
@Component
@Service({ OxxoService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class OxxoRestService implements OxxoService {

	private static final ILogger LOGGER = LogFactory.getLogger(OxxoRestService.class);

	private IntegrationServiceOxxoConsulta integrationServiceOxxoConsulta;
	private IntegrationServiceOxxoPay integrationServiceOxxoPay;
	private IntegrationServiceOxxoReverse integrationServiceOxxoReverse;

	@Path("/public/{token}/consulta")
	@GET
	@Produces(MediaType.APPLICATION_XML)
	@Override
	public Response consulta(@PathParam("token") String token, @QueryParam("client") String client) {

		LOGGER.logDebug("Inicio metodo consulta");
		OlsConsultaResponse respuestaConsulta = new OlsConsultaResponse();
		ServiceResponseTO serviceResponseTO;

		OlsConsultaRequest olsConsultaRequest = new OlsConsultaRequest();
		olsConsultaRequest.setReferencia(client);
		olsConsultaRequest.setToken(token);

		LOGGER.logDebug("CONSULTA REQUEST: " + olsConsultaRequest.toString());
		try {

			serviceResponseTO = integrationServiceOxxoConsulta.consulta(olsConsultaRequest);

			LOGGER.logDebug("serviceResponseTO.isSuccess: " + serviceResponseTO.isSuccess());

			if (serviceResponseTO.isSuccess()) {
				LOGGER.logDebug("SERVICE RESPONSE TO:" + serviceResponseTO.getMessages());
				LOGGER.logDebug("SERVICE RESPONSE TO DATA " + serviceResponseTO.getData());
			} else {
				LOGGER.logError("SERVICE RESPONSE TO ERROR: " + serviceResponseTO.getMessages());
			}

			if (serviceResponseTO != null && serviceResponseTO.getData() != null && serviceResponseTO.getData().get(OxxoConstants.OUTPUT) != null) {

				LOGGER.logDebug("SERVICE RESPONSE TO CLASS OxxoRestService: " + serviceResponseTO.getData());
				Map<String, Object> outputs = (Map<String, Object>) serviceResponseTO.getData().get(OxxoConstants.OUTPUT);
				LOGGER.logDebug("OUTPUTS CONSULTA: " + outputs);

				if (outputs.get(OxxoConstants.OUT_CODIGO_ERROR) != null && OxxoConstants.ERROR_00.equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString())) {
					if (!OxxoValidator.validateResponse(outputs, OxxoConstants.QUERY_REQUIRED_FIELDS)) {
						respuestaConsulta.setCode(OxxoConstants.ERROR_27);
						respuestaConsulta.setMessage(OxxoConstants.DESC_ERROR_27);
						return Response.ok(OxxoPrintObject.transformObject(respuestaConsulta, LOGGER, "RESPUESTA CONSULTA DE PAGO")).build();
					}
					String partialReference = outputs.get(OxxoConstants.OUT_TIPO_TRAN) == null ? "" : outputs.get(OxxoConstants.OUT_TIPO_TRAN).toString();
					respuestaConsulta.setAccount(outputs.get(OxxoConstants.OUT_CUENTA) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CUENTA)).trim());
					respuestaConsulta.setName(outputs.get(OxxoConstants.OUT_NOMBRE) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_NOMBRE)).trim());
					respuestaConsulta.setStatus(outputs.get(OxxoConstants.OUT_STATUS) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_STATUS)).trim());
					respuestaConsulta.setPartial(outputs.get(OxxoConstants.OUT_PARTIAL) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_PARTIAL)).trim());

					List<Concept> concList = ComplementConsulta.queryOperation(outputs, partialReference);
					respuestaConsulta.setConcepts(concList);
					if (OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_SALDO_EXIGIBLE).toString()) == 0
							&& OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MAX).toString()) == 0
							&& OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MIN).toString()) == 0) {
						respuestaConsulta.setCode(OxxoConstants.ERROR_10);
						respuestaConsulta.setMessage(OxxoConstants.DESC_ERROR_10);
					} else {
						respuestaConsulta.setCode(OxxoConstants.ERROR_00);
						respuestaConsulta.setMessage(OxxoConstants.DESC_ERROR_00);
					}

				} else {
					respuestaConsulta.setCode(outputs.get(OxxoConstants.OUT_CODIGO_ERROR) == null ? "" : outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString());
					respuestaConsulta.setMessage(outputs.get(OxxoConstants.OUT_MENSAJE_ERROR) == null ? "" : outputs.get(OxxoConstants.OUT_MENSAJE_ERROR).toString());
				}

				LOGGER.logDebug(respuestaConsulta.toString());

			} else {
				LOGGER.logError("No trae output");
				return Response.serverError().build();
			}

		} catch (Exception e) {
			LOGGER.logError("Error al ejecutar el metodo consulta", e);
			return Response.serverError().build();
		}
		// IMPRESION DE LA TRAMA DE SALIDA DE LA CONSULTA

		return Response.ok(OxxoPrintObject.transformObject(respuestaConsulta, LOGGER, "RESPUESTA CONSULTA DE PAGO")).build();
	}

	@Path("/public/{token}/pay")
	@POST
	@Consumes(MediaType.APPLICATION_XML)
	@Produces(MediaType.APPLICATION_XML)
	public Response pay(@PathParam("token") String token, OlsPagoRequest olsPagoRequest) {

		LOGGER.logDebug("Inicio metodo pay");

		LOGGER.logDebug("TOKEN: " + token);
		LOGGER.logDebug("PAGO ENTRADA: " + olsPagoRequest.toString());

		OlsPagoResponse respuestaPago = new OlsPagoResponse();
		ServiceResponseTO serviceResponseTO;

		// Validación token de body contra queryparam
		if (!token.equals(olsPagoRequest.getToken())) {
			respuestaPago.setCode("02");
			respuestaPago.setErrorDesc("PARAMETRO TOKEN OBLIGATORIO Y NO INFORMADO");
			return Response.ok(OxxoPrintObject.transformObject(respuestaPago, LOGGER, "PAGO OXXO RESPONSE")).build();
		}

		OxxoPrintObject.marshalObject(olsPagoRequest, LOGGER, "PAGO OXXO REQUEST");
		OlsPagoResponse olsResp = OlsResponseError.errorPagoResponse(olsPagoRequest);

		LOGGER.logDebug("RESPUESTA METODO ERROR_PAGO_RESPONSE" + olsResp.getClass());
		LOGGER.logDebug("RESPUESTA OBJETO OLSRESP: " + olsResp.toString());
		try {

			if (olsResp.getCode() == null || "".equals(olsResp.getCode()) || olsResp == null) {

				olsPagoRequest.setToken(token);
				OlsPagoResponse pagoRes = validaConsultaPago(olsPagoRequest, token);
				LOGGER.logDebug("OBJETO PAGO_RES: " + pagoRes);

				if (pagoRes == null) {
					return Response.serverError().build();
				}
				if (!OxxoConstants.ERROR_00.equals(pagoRes.getCode())) {
					return Response.ok(OxxoPrintObject.transformObject(pagoRes, LOGGER, "PAGO OXXO RESPONSE")).build();
				}

				serviceResponseTO = integrationServiceOxxoPay.pago(olsPagoRequest);

				if (serviceResponseTO != null && serviceResponseTO.getData() != null && serviceResponseTO.getData().get(OxxoConstants.OUTPUT) != null) {
					LOGGER.logDebug("serviceResponseTO.getData(): " + serviceResponseTO.getData());
					Map<String, Object> outputs = (Map<String, Object>) serviceResponseTO.getData().get(OxxoConstants.OUTPUT);

					if ("00".equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR))) {

						if (!OxxoValidator.validateResponse(outputs, OxxoConstants.PAYMENT_REQUIRED_FIELDS)) {
							respuestaPago.setCode(OxxoConstants.ERROR_27);
							respuestaPago.setErrorDesc(OxxoConstants.DESC_ERROR_27);
							return Response.ok(OxxoPrintObject.transformObject(respuestaPago, LOGGER, "RESPUESTA PAGO")).build();
						}

						respuestaPago.setAuth(outputs.get(OxxoConstants.OUT_CODIGO_PAGO).toString() == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CODIGO_PAGO))
								.trim());
						respuestaPago.setAmount(String.valueOf(OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_RECIBIDO).toString())));
						respuestaPago.setMessageTicket(outputs.get(OxxoConstants.OUT_MENSAJE_TICKET).toString() == null ? "" : String.valueOf(
								outputs.get(OxxoConstants.OUT_MENSAJE_TICKET)).trim());
						respuestaPago.setAccount(outputs.get(OxxoConstants.OUT_CUENTA) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CUENTA)).trim());
						respuestaPago.setCode(outputs.get(OxxoConstants.OUT_CODIGO_ERROR) == null || "".equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString())
								|| "0".equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString()) ? OxxoConstants.ERROR_00 : String.valueOf(
								outputs.get(OxxoConstants.OUT_CODIGO_ERROR)).trim());

						respuestaPago.setErrorDesc(OxxoConstants.ERROR_00.equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString()) ? OxxoConstants.DESC_ERROR_00_1 : outputs
								.get(OxxoConstants.OUT_MENSAJE_ERROR).toString());
					} else {
						respuestaPago
								.setCode(outputs.get(OxxoConstants.OUT_CODIGO_ERROR) == null || "".equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString()) ? OxxoConstants.ERROR_17
										: String.valueOf(outputs.get(OxxoConstants.OUT_CODIGO_ERROR)).trim());

						respuestaPago
								.setErrorDesc(outputs.get(OxxoConstants.OUT_MENSAJE_ERROR) == null || "".equals(outputs.get(OxxoConstants.OUT_MENSAJE_ERROR).toString()) ? OxxoConstants.DESC_ERROR_17
										: String.valueOf(outputs.get(OxxoConstants.OUT_MENSAJE_ERROR)));
					}

					LOGGER.logDebug("OBJETO RESPUESTA_PAGO: " + respuestaPago.toString());
				} else {
					LOGGER.logError("No trae output");
					return Response.serverError().build();
				}

			} else {
				respuestaPago = OlsResponseError.errorPagoResponse(olsPagoRequest);
				LOGGER.logDebug("RESPUESTA PAGO: " + respuestaPago);
			}

		} catch (Exception e) {
			LOGGER.logError("Error al ejecutar el metodo pago", e);
			return Response.serverError().build();
		}

		return Response.ok(OxxoPrintObject.transformObject(respuestaPago, LOGGER, "PAGO OXXO RESPONSE")).build();
	}

	@Path("/public/{token}/reverse")
	@POST
	@Consumes(MediaType.APPLICATION_XML)
	@Produces(MediaType.APPLICATION_XML)
	public Response reverse(@PathParam("token") String token, OlsReversaRequest olsReversaRequest) {

		LOGGER.logDebug("Inicio metodo reverse");

		LOGGER.logDebug("TOKEN: " + token);
		LOGGER.logDebug("PAGO ENTREGA: " + olsReversaRequest.toString());
		OlsReversaResponse olsReversaResponse = new OlsReversaResponse();

		ServiceResponseTO serviceResponseTO;

		// Validación token de body contra queryparam
		if (!token.equals(olsReversaRequest.getToken())) {
			olsReversaResponse.setCode(OxxoConstants.ERROR_02);
			olsReversaResponse.setErrorDesc(OxxoConstants.DESC_ERROR_02);
			return Response.ok(OxxoPrintObject.transformObject(olsReversaResponse, LOGGER, "PAGO OXXO RESPONSE")).build();
		}

		OxxoPrintObject.marshalObject(olsReversaRequest, LOGGER, "REVERSA OXXO REQUEST");
		OlsReversaResponse olsResp = OlsResponseError.errorReverseResponse(olsReversaRequest);

		try {

			if (olsResp != null && olsResp.getCode() != null && "".equals(olsResp.getCode())) {
				olsReversaResponse = OlsResponseError.errorReverseResponse(olsReversaRequest);
				LOGGER.logDebug("RESPUESTA REVERSO: " + olsReversaResponse);
			} else {

				olsReversaRequest.setToken(token);
				serviceResponseTO = integrationServiceOxxoReverse.reverse(olsReversaRequest);

				if (serviceResponseTO != null && serviceResponseTO.getData() != null && serviceResponseTO.getData().get(OxxoConstants.OUTPUT) != null) {

					LOGGER.logDebug("Respuesta Final: " + serviceResponseTO.getData());

					Map<String, Object> outputs = (Map<String, Object>) serviceResponseTO.getData().get(OxxoConstants.OUTPUT);

					if (outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString().equals(OxxoConstants.ERROR_00) || "0".equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString())) {
						if (!OxxoValidator.validateResponse(outputs, OxxoConstants.PAYMENT_REQUIRED_FIELDS)) {
							olsReversaResponse.setCode(OxxoConstants.ERROR_27);
							olsReversaResponse.setErrorDesc(OxxoConstants.DESC_ERROR_27);
							return Response.ok(OxxoPrintObject.transformObject(olsReversaResponse, LOGGER, "RESPUESTA REVERSA DE PAGO")).build();
						}
						olsReversaResponse.setIdReverse(outputs.get(OxxoConstants.OUT_CODIGO_REVERSA) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CODIGO_REVERSA))
								.trim());
						olsReversaResponse.setAmount(String.valueOf(OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_RECIBIDO).toString())));
						olsReversaResponse.setAuth(outputs.get(OxxoConstants.OUT_CODIGO_PAGO) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CODIGO_PAGO)).trim());
						olsReversaResponse.setAccount(outputs.get(OxxoConstants.OUT_CUENTA) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CUENTA)).trim());
						olsReversaResponse.setCode("0".equals(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString()) ? OxxoConstants.ERROR_00 : outputs.get(
								OxxoConstants.OUT_CODIGO_ERROR).toString());
						olsReversaResponse.setErrorDesc("TRANSACCION APROBADA");
						olsReversaResponse.setMessageTicket(outputs.get(OxxoConstants.OUT_MENSAJE_TICKET) == null
								|| "".equals(String.valueOf(outputs.get(OxxoConstants.OUT_MENSAJE_TICKET)).trim()) ? "REVERSO APLICADO CORRECTAMENTE" : String.valueOf(
								outputs.get(OxxoConstants.OUT_MENSAJE_TICKET)).trim());
						LOGGER.logDebug(olsReversaResponse.toString());

					} else {
						olsReversaResponse.setIdReverse(outputs.get(OxxoConstants.OUT_CODIGO_REVERSA) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CODIGO_REVERSA))
								.trim());
						olsReversaResponse.setMessageTicket(outputs.get(OxxoConstants.OUT_MENSAJE_TICKET) == null ? "" : String.valueOf(
								outputs.get(OxxoConstants.OUT_MENSAJE_TICKET)).trim());
						olsReversaResponse.setAuth(outputs.get(OxxoConstants.OUT_CODIGO_PAGO) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CODIGO_PAGO)).trim());
						olsReversaResponse.setAccount(outputs.get(OxxoConstants.OUT_CUENTA) == null ? "" : String.valueOf(outputs.get(OxxoConstants.OUT_CUENTA)).trim());
						olsReversaResponse.setCode(outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString());
						olsReversaResponse.setErrorDesc(outputs.get(OxxoConstants.OUT_MENSAJE_ERROR).toString());
						LOGGER.logDebug(olsReversaResponse.toString());

					}

				} else {
					LOGGER.logError("No trae output");
					return Response.serverError().build();
				}
			}

		} catch (Exception e) {
			LOGGER.logError("Error al ejecutar el metodo pago", e);
			return Response.serverError().build();
		}

		return Response.ok(OxxoPrintObject.transformObject(olsReversaResponse, LOGGER, "PAGO OXXO RESPONSE")).build();
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationServiceOxxoConsulta = new IntegrationServiceOxxoConsulta(serviceIntegration);
		this.integrationServiceOxxoPay = new IntegrationServiceOxxoPay(serviceIntegration);
		this.integrationServiceOxxoReverse = new IntegrationServiceOxxoReverse(serviceIntegration);

	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationServiceOxxoConsulta = new IntegrationServiceOxxoConsulta(serviceIntegration);
		this.integrationServiceOxxoPay = new IntegrationServiceOxxoPay(serviceIntegration);
		this.integrationServiceOxxoReverse = new IntegrationServiceOxxoReverse(serviceIntegration);
	}

	private OlsPagoResponse validaConsultaPago(OlsPagoRequest olsPagoRequest, String token) throws COBISException {

		LOGGER.logDebug("Inicia el metodo validar consulta antes del Pago");
		LOGGER.logDebug("Inicia el metodo validaConsultaPago");
		OlsPagoResponse respuestaPago = null;
		ServiceResponseTO serviceResponseTO;

		// Se setea los valores de la consultaRequest
		OlsConsultaRequest olsConsultaRequest = new OlsConsultaRequest();
		olsConsultaRequest.setToken(token);
		olsConsultaRequest.setReferencia(olsPagoRequest.getClient());

		try {
			if (olsPagoRequest.getAmount() == null || Integer.parseInt(olsPagoRequest.getAmount()) == 0) {
				LOGGER.logDebug("No se permiten pagos con valor cero");
				respuestaPago = new OlsPagoResponse("", "", OxxoConstants.ERROR_16, OxxoConstants.DESC_ERROR_16);
				return respuestaPago;
			}

			// Se realiza la consulta antes de procesar el Pago
			serviceResponseTO = integrationServiceOxxoConsulta.consulta(olsConsultaRequest);

			if (serviceResponseTO != null && serviceResponseTO.getData() != null && serviceResponseTO.getData().get(OxxoConstants.OUTPUT) != null) {
				LOGGER.logDebug("serviceResponseTO Consulta: " + serviceResponseTO.getData());
				Map<String, Object> outputs = (Map<String, Object>) serviceResponseTO.getData().get(OxxoConstants.OUTPUT);

				LOGGER.logDebug("OUTPUTS CONSULTA: " + outputs);

				DecimalFormat df = new DecimalFormat("#.00"); // Formato a
																// dos
																// decimales

				if (outputs.get(OxxoConstants.OUT_CODIGO_ERROR) != null && outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString().equals(OxxoConstants.ERROR_00)) {

					if (OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_SALDO_EXIGIBLE).toString()) == 0
							&& OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MAX).toString()) == 0
							&& OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MIN).toString()) == 0) {
						respuestaPago = new OlsPagoResponse(OxxoConstants.ERROR_10, OxxoConstants.DESC_ERROR_10);

					} else {

						LOGGER.logDebug("Ingreso a validar los montos minimos y maximos");
						int maximo = OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MAX).toString());
						int minimo = OxxoTransformMoney.convertInt(outputs.get(OxxoConstants.OUT_MONTO_MIN).toString());

						if (Integer.parseInt(olsPagoRequest.getAmount()) < minimo) {
							LOGGER.logDebug("Ingreso a la validacion si el pago es menor al minimo");
							respuestaPago = new OlsPagoResponse(OxxoConstants.ERROR_16, "EL MONTO A PAGAR " + df.format(Double.parseDouble(olsPagoRequest.getAmount()) / 100)
									+ " ES MENOR AL MINIMO " + df.format((double) minimo / 100));
						} else if (Integer.parseInt(olsPagoRequest.getAmount()) > maximo) {
							LOGGER.logDebug("Ingreso a la validacion si el pago es mayor al maximo");
							respuestaPago = new OlsPagoResponse(OxxoConstants.ERROR_16, "EL MONTO A PAGAR " + df.format(Double.parseDouble(olsPagoRequest.getAmount()) / 100)
									+ " ES MAYOR AL MAXIMO  " + df.format((double) maximo / 100));
						} else {
							respuestaPago = new OlsPagoResponse((outputs.get(OxxoConstants.OUT_MENSAJE_TICKET) == null ? "" : outputs.get(OxxoConstants.OUT_MENSAJE_TICKET)
									.toString()), (outputs.get(OxxoConstants.OUT_CUENTA) == null ? "" : outputs.get(OxxoConstants.OUT_CUENTA).toString()), OxxoConstants.ERROR_00,
									OxxoConstants.DESC_ERROR_00);
						}
					}

				} else {
					LOGGER.logDebug("Si el codigo es diferente a 00");
					respuestaPago = new OlsPagoResponse((outputs.get(OxxoConstants.OUT_CODIGO_ERROR) == null ? "" : outputs.get(OxxoConstants.OUT_CODIGO_ERROR).toString()),
							(outputs.get(OxxoConstants.OUT_MENSAJE_ERROR) == null ? "" : outputs.get(OxxoConstants.OUT_MENSAJE_ERROR).toString()));
				}

			} else {
				respuestaPago = new OlsPagoResponse(OxxoConstants.ERROR_17, OxxoConstants.DESC_ERROR_17);
			}

		} finally {
			LOGGER.logDebug("Finaliza el metodo validar consulta antes del Pago");
		}

		return respuestaPago;
	}

}
