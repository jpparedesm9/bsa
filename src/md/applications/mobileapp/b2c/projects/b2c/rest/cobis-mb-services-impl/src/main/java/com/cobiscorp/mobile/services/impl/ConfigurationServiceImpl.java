package com.cobiscorp.mobile.services.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.BankGeolocation;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.GeneralParameters;
import com.cobiscorp.mobile.model.Notification;
import com.cobiscorp.mobile.model.TablaComision;
import com.cobiscorp.mobile.model.TransactionInfo;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;

import cobiscorp.ecobis.businesstoconsumer.dto.ExecuteMessageRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.ExecuteMessageResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.QueryMessagesRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.QueryMessagesResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.individualloan.dto.GeneralParameterDetailResponse;
import cobiscorp.ecobis.individualloan.dto.GeneralParameterHeaderResponse;
import cobiscorp.ecobis.individualloan.dto.GeneralParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.DateRequest;
import cobiscorp.ecobis.systemconfiguration.dto.DateResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.*;

@Component
@Service({ IConfigurationService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class ConfigurationServiceImpl extends ServiceBase implements IConfigurationService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setAdminTokenUser", unbind = "unsetAdminTokenUser", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IAdminTokenUser adminTokenUser;

	private ILogger logger = LogFactory.getLogger(ConfigurationServiceImpl.class);

	@Override
	public GeneralParameters getGeneralParameters(String cobisSessionId, String loanId, Integer customerId) throws MobileServiceException {
		GeneralParameters parameters = null;

		GeneralParameterRequest generalParametersRequest = new GeneralParameterRequest();
		generalParametersRequest.setLoanId(loanId);
		generalParametersRequest.setCustomerId(customerId);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inGeneralParameterRequest", generalParametersRequest);
		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, logger, "IndividualLoan.Queries.QueryGeneralParameters", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				GeneralParameterHeaderResponse[] headerResponse = (GeneralParameterHeaderResponse[]) serviceResponseTO.getData().get("returnGeneralParameterHeaderResponse");
				if (headerResponse != null && headerResponse.length > 0) {
					GeneralParameterHeaderResponse header = headerResponse[0];
					parameters = new GeneralParameters();
					parameters.setPorcentajeIva(header.getIvaRate());
					parameters.setMontoMinDis(header.getMinAmountDisp());
					GeneralParameterDetailResponse[] details = (GeneralParameterDetailResponse[]) serviceResponseTO.getData().get("returnGeneralParameterDetailResponse");
					for (GeneralParameterDetailResponse detail : details) {
						parameters.addTablaComisionItem(new TablaComision(detail.getRankEnd(), detail.getRankStart(), detail.getCommissionRate(), detail.getOperator()));
					}
				}
			} else {
				manageResponseError(serviceResponseTO, logger);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}

		return parameters;
	}

	@Override
	public List<Notification> getNotifications(String cobisSessionId, Integer customerId) throws MobileServiceException {
		List<Notification> notifications = new ArrayList<Notification>();

		QueryMessagesRequest queryMessagesRequest = new QueryMessagesRequest();
		queryMessagesRequest.setCustomerId(customerId);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inQueryMessagesRequest", queryMessagesRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, logger, "BusinessToConsumer.MessageManagement.QueryMessages", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				QueryMessagesResponse[] messages = (QueryMessagesResponse[]) serviceResponseTO.getData().get("returnQueryMessagesResponse");
				if (logger.isDebugEnabled()) {
					logger.logDebug("============= notifications for user =============");
					logger.logDebug(messages);
					logger.logDebug(messages.length);
				}
				if (messages != null && messages.length > 0) {
					for (QueryMessagesResponse message : messages) {
						Notification notification = new Notification();
						notification.setId(message.getMessageId().toString());
						notification.setType(message.getAnswerType());
						notification.setDescription(message.getText());
						notification.setNeedsOtp(message.getOtp());
						notification.setNegativeButton(message.getNegativeButton());
						notification.setPositiveButton(message.getPositiveButton());
						notification.setShowTransaction("S".equals(message.getShowTransaction()) ? true : false);
						notifications.add(notification);
					}
				}
			} else {
				manageResponseError(serviceResponseTO, logger);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
		return notifications;
	}

	public TransactionInfo executeNotification(String cobisSessionId, com.cobiscorp.mobile.model.ExecuteMessageRequest request) throws MobileServiceException {
		ExecuteMessageResponse response = null;
		Notification notification = getNotification(cobisSessionId, request.getMessageId().toString(), request.getCustomerId());
		TransactionInfo transactionInfo = new TransactionInfo();
		if ("S".equals(notification.getNeedsOtp())) {
			boolean isValidPassword = adminTokenUser.isValidPasword(request.getClientId(), request.getPassword(), request.getLogin(), Constants.CHANNEL);

			if (!isValidPassword) {
				throw new MobileServiceException("La clave es incorrecta");
			}
		}

		ExecuteMessageRequest executeMessageRequest = new ExecuteMessageRequest();
		executeMessageRequest.setMessageId(request.getMessageId());
		executeMessageRequest.setCustomerId(request.getCustomerId());
		executeMessageRequest.setResponse(request.getResponse());

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inExecuteMessageRequest", executeMessageRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, logger, "BusinessToConsumer.MessageManagement.ExecuteMessage", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {

				if (serviceResponseTO.getData() != null) {
					response = (ExecuteMessageResponse) serviceResponseTO.getData().get("returnExecuteMessageResponse");
					if (response != null) {
					transactionInfo.setInstitucion(response.getInstitution());
					transactionInfo.setTipoOperacion(response.getOperationType());
					transactionInfo.setEstado(response.getStatus());
					transactionInfo.setFolio(response.getFolio());
					Calendar calendar = response.getOperationDate();
						SimpleDateFormat sdfFecha = new SimpleDateFormat("MMM dd,yyyy", new Locale("es", "es"));
					String fecha = sdfFecha.format(calendar.getTime());
					transactionInfo.setFecha(fecha);
						SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm", new Locale("es", "es"));
					String hora = sdfHora.format(response.getOperationHour().getTime());
					transactionInfo.setHora(hora);
					transactionInfo.setMensaje(response.getMessage());
				}
				}

				Integer responseCode = (Integer) serviceResponseTO.getData().get("com.cobiscorp.cobis.cts.service.response.return");
				if (logger.isDebugEnabled()) {
					logger.logDebug("============= init executeNotification ==============");
					logger.logDebug(serviceResponseTO.getData());
					logger.logDebug(">>>> response code " + responseCode);
					logger.logDebug("============= end executeNotification ==============");
				}
				if (responseCode > 0) {
					Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
					String msg = applicationResponse.get("@o_msg").toString();
					if (msg != null && !msg.trim().isEmpty()) {
						throw new MobileServiceException(msg);
					}
				}
			} else {
				manageResponseError(serviceResponseTO, logger);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
		return transactionInfo;
	}

	public Notification getNotification(String cobisSessionId, String messageId, Integer customerId) throws MobileServiceException {
		List<Notification> notifications = getNotifications(cobisSessionId, customerId);

		if (notifications.isEmpty()) {
			throw new MobileServiceException("No se encontraron notificaciones");
		} else {
			Notification notification = null;
			for (Notification n : notifications) {
				if (n.getId().equals(messageId)) {
					notification = n;
					break;
				}
			}
			if (notification == null) {
				throw new MobileServiceException(String.format("No se encontr\u00F3 la notificaci\u00F3n con id %1$s", messageId));
			}

			return notification;
		}
	}

	public String getParameterValue(String paramNemonic, String productNemonic, String cobisSessionId) throws MobileServiceException {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia Servicio getParameterValue");
		}
		ServiceRequestTO requestTO = new ServiceRequestTO();
		ParameterRequest param = new ParameterRequest();
		param.setParameterNemonic(paramNemonic);
		param.setProductNemonic(productNemonic);
		param.setMode(4);
		try {
			requestTO.addValue("inParameterRequest", param);
			ServiceResponseTO responseTO = execute(serviceIntegration, logger, "SystemConfiguration.ParameterManagement.ParameterManagement", cobisSessionId, requestTO);

			if (responseTO.isSuccess()) {
				ParameterResponse paramResp = (ParameterResponse) responseTO.getValue("returnParameterResponse");
				if (paramResp != null) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("Valor de Parametro: " + paramResp.getParameterValue());
					}
					return paramResp.getParameterValue();
				}

			} else {
				manageResponseError(responseTO, logger);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug(" Finaliza getParameterValue");
			}
		}
		return null;
	}

	public String getProcessDate(int dateFormat) throws MobileServiceException {
		if (logger.isDebugEnabled()) {
			logger.logDebug("getProcessDate ---> INI");
			logger.logDebug("getProcessDate --->" + dateFormat);
		}
		DateRequest dateRequestDTO = new DateRequest();
		try {
			dateRequestDTO.setDateFormat(dateFormat);
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.getData().put("inDateRequest", dateRequestDTO);
			ServiceResponseTO serviceResponse = execute(serviceIntegration, logger, "SystemConfiguration.ParameterManagement.ProcessDate", "", serviceRequestTO);
			if (serviceResponse.isSuccess()) {
				DateResponse dateResponse = (DateResponse) serviceResponse.getValue("returnDateResponse");
				return dateResponse.getProcessDate();
			}
			return null;
		} catch (MobileServiceException e) {
			throw new MobileServiceException(e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug(" Finaliza getProcessDate");
			}
		}
		// return null;
	}

	public ServiceResponseTO registerBankGeolocation(BankGeolocation aBankGeoloc) throws MobileServiceException {
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		// Ente ente = new Ente();
		BankGeolocationRequest wBanlGeoloc = new BankGeolocationRequest();
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia Servicio registerBankGeolocation");
		}
		wBanlGeoloc.setLogin(aBankGeoloc.getLogin());
		wBanlGeoloc.setTrxType(aBankGeoloc.getTrxType());
		wBanlGeoloc.setServiceType(aBankGeoloc.getServiceType());
		wBanlGeoloc.setLongitudePos(aBankGeoloc.getLongitudePos());
		wBanlGeoloc.setLatitudePos(aBankGeoloc.getLatitudePos());
		wBanlGeoloc.setAppName(aBankGeoloc.getChannel());

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inBankGeolocationRequest", wBanlGeoloc);
		try {
			serviceResponseTO = execute(serviceIntegration, logger,
					// "BusinessToConsumer.BankGeolocation.InsertBankGeolocation", cobisSessionId, serviceRequest);
					"BusinessToConsumer.BankGeolocation.InsertBankGeolocation", EMPTY_COBIS_SESSION_ID, serviceRequest);
			if (serviceResponseTO.isSuccess() && logger.isDebugEnabled()) {
				logger.logDebug("*******************> Se registra Geolocalizacion Bancaria");
			} else {
				manageResponseError(serviceResponseTO, logger);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza Servicio registerBankGeolocation");
		}
		return serviceResponseTO;
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration() {
		this.serviceIntegration = null;
	}

	public void setAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = adminTokenUser;
	}

	public void unsetAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = null;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
