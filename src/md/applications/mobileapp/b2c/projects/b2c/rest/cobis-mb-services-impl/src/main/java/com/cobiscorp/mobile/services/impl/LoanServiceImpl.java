package com.cobiscorp.mobile.services.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.ServletException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import com.cobiscorp.mobile.services.impl.utils.*;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.ReferencePolicy;
import org.apache.felix.scr.annotations.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.admintoken.dto.DataTokenRequest;
import com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser;
import com.cobiscorp.mobile.converter.DateConverter;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.BaseResponse;
import com.cobiscorp.mobile.model.ClientInformation;
import com.cobiscorp.mobile.model.ClientLoans;
import com.cobiscorp.mobile.model.ClientLoansDetails;
import com.cobiscorp.mobile.model.ClientLoansInfo;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.CreditlineDetail;
import com.cobiscorp.mobile.model.CreditlineInfo;
import com.cobiscorp.mobile.model.DisbursementRequest;
import com.cobiscorp.mobile.model.ElavonRequest;
import com.cobiscorp.mobile.model.ElavonResponse;
import com.cobiscorp.mobile.model.KYCFormRequestLocal;
import com.cobiscorp.mobile.model.LoanInfoRequest;
import com.cobiscorp.mobile.model.OperationCreateRequest;
import com.cobiscorp.mobile.model.OperationCreateResponse;
import com.cobiscorp.mobile.model.SimulationRequest;
import com.cobiscorp.mobile.model.SimulationResponse;
import com.cobiscorp.mobile.model.TransactionInfo;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;
import com.cobiscorp.mobile.service.interfaces.ILoanService;

import cobiscorp.ecobis.businesstoconsumer.dto.KycFormRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.OperationResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.PaymentRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.QueryLoansRequest;
import cobiscorp.ecobis.businesstoconsumer.dto.QueryLoansResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.QueryTransactionResponse;
import cobiscorp.ecobis.businesstoconsumer.dto.OnboardingOperationRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.individualloan.dto.DisburseCreditGenerateResponse;
import cobiscorp.ecobis.individualloan.dto.DisburseCreditLineRequest;
import cobiscorp.ecobis.individualloan.dto.DisburseCreditLineResponse;
import cobiscorp.ecobis.individualloan.dto.DisbursementRequestDTO;
import cobiscorp.ecobis.individualloan.dto.LcrQueryDetailResponse;
import cobiscorp.ecobis.individualloan.dto.LcrQueryHeaderResponse;
import cobiscorp.ecobis.individualloan.dto.LcrQueryRequest;
import cobiscorp.ecobis.individualloan.dto.SimulationRequestDTO;
import cobiscorp.ecobis.individualloan.dto.SimulationResponseDTO;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

@Component
@Service({ ILoanService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class LoanServiceImpl extends ServiceBase implements ILoanService {
	private static final String B2C = "B2C";

	private static final String SUCCESS = "success";

	private static final String UTF8 = "UTF-8";

	private static final String MESSAGGEERROR = "El monto a pagar debe ser un valor entre los límites máximo y mínimo de pago";
	private static final String ERRMSM = "Error en la información proporcionada al someter la solicitud de autorización.";
	private static final String DENMSM = "Transacción rechazada por el banco emisor.";

	private static final String TAGTXTERR = "CENTEROFPAYMENTS/nb_error";
	private static final String TAGNUMERR = "CENTEROFPAYMENTS/cd_error";
	private static final String TAGRESP = "CENTEROFPAYMENTS/response";
	private static final String TAGREFERENCE = "CENTEROFPAYMENTS/reference";
	private static final String TAGAMOUNT = "CENTEROFPAYMENTS/amount";
	private static final String TAGFOLPAY = "CENTEROFPAYMENTS/foliocpagos";
	private static final String TAGIDURL = "CENTEROFPAYMENTS/id_url";
	private static final String TAGURL = "P_RESPONSE/nb_url";
	private static final String TAGCDRES = "P_RESPONSE/cd_response";
	private static final String TAGNBRES = "P_RESPONSE/nb_response";

	private static final String DESCERR = "nb_response";
	private static final String STATUSERR = "cd_response";

	private static final String ERROR = "error";
	private static final String DENIED = "denied";
	private static final String APPROVED = "approved";

	private static final String ELAVON = "ELAVON";
	private static final int TIMEOUT = 30000;

	@Reference(bind = "setAdminTokenUser", unbind = "unsetAdminTokenUser", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IAdminTokenUser adminTokenUser;

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(name = "cacheManager", referenceInterface = ICacheManager.class, bind = "setCacheManager", unbind = "unsetCacheManager", cardinality = ReferenceCardinality.MANDATORY_UNARY, policy = ReferencePolicy.DYNAMIC)
	private ICacheManager cacheManager;

	@Reference(bind = "setConfigurationService", unbind = "unsetConfigurationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IConfigurationService configurationService;

	private ILogger LOGGER = LogFactory.getLogger(LoanServiceImpl.class);
	private static final String className = "[LoanServiceImpl]";

	@Override
	public CreditlineInfo getCreditInfo(String loanId, String cobisSessionId) throws MobileServiceException {
		CreditlineInfo info = new CreditlineInfo();

		LcrQueryRequest lcrQueryRequest = new LcrQueryRequest();
		lcrQueryRequest.setLoanId(loanId);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inLcrQueryRequest", lcrQueryRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, "IndividualLoan.Queries.QueryLcrInfo", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				LcrQueryHeaderResponse[] headers = (LcrQueryHeaderResponse[]) serviceResponseTO.getData().get("returnLcrQueryHeaderResponse");
				if (headers != null && headers.length > 0) {

					LOGGER.logDebug(String.format("LineaCredito-getLcrAmount:" + headers[0].getLcrAmount()));
					LOGGER.logDebug(String.format("Utilizado-getLcrUsedAmount:" + headers[0].getLcrUsedAmount()));
					LOGGER.logDebug(String.format("Disponible-getLcrAvailableAmount:" + headers[0].getLcrAvailableAmount()));

					info.setLineaCredito(headers[0].getLcrAmount());
					info.setDisponible(headers[0].getLcrAvailableAmount());
					info.setPagoMinimo(headers[0].getMinimiumPayment());
					info.setPagoSinIntereses(headers[0].getFullPayment());
					info.setReferenciaDePago(headers[0].getPaymentReferenceNumber());
					info.setFechaPago(DateConverter.calendarToFormattedString(headers[0].getPaymentDate()));
					info.setUltimoAcceso(DateConverter.calendarToDateTimeString(headers[0].getLastLoginDate()));
					info.setUtilizado(headers[0].getLcrUsedAmount());
					info.setConvenio(headers[0].getAgreement());
					info.setPrestamo(headers[0].getLoan());
					info.setInstanciaProceso(headers[0].getProcesInstance());
					info.setPorcentajeCumpl(headers[0].getCompliancePercentage());

					LcrQueryDetailResponse[] details = (LcrQueryDetailResponse[]) serviceResponseTO.getData().get("returnLcrQueryDetailResponse");
					if (details != null) {
						for (LcrQueryDetailResponse detail : details) {
							info.getDetails()
									.add(new CreditlineDetail(detail.getTrnText(), detail.getTrnAmount(), DateConverter.calendarToFormattedString(detail.getTrnDate()), detail.getTrnStatus()));
						}
					}
				}
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
		return info;
	}

	public void storeDisburse(String loanId, BigDecimal amount, BigDecimal tax, BigDecimal commission, BigDecimal capitalBalance, String customerId, String phone) throws MobileServiceException {
		DataTokenRequest dataIn = new DataTokenRequest();
		dataIn.setLogin(customerId);
		dataIn.setChannel(Constants.CHANNEL);
		dataIn.setClientPhoneNumber(phone);
		dataIn.setClientId(Integer.valueOf(customerId));

		ICache cache = cacheManager.getCache(DEFAULT_CACHE_NAME);
		cache.put(loanId, amount);
		cache.put("tax", tax);
		cache.put("commission", commission);
		cache.put("capitalBalance", capitalBalance);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(String.format("==========> stored disburse for customer %1$s and loan %2$s", customerId, loanId));
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public TransactionInfo applyDisburse(String loanId, String clientId, String login, String password, String cobisSessionId) throws MobileServiceException {
		DisburseCreditLineResponse response = null;
		TransactionInfo transactionInfo = new TransactionInfo();

		KeepSecurity keepSecurity = new KeepSecurity(null, Activator.getPrivateKey().toString().toCharArray());
		String decryptedPass = keepSecurity.decrypt(password);
		boolean isValidPassword = adminTokenUser.isValidPasword(clientId, decryptedPass, login, Constants.CHANNEL);

		if (!isValidPassword) {
			throw new MobileServiceException("La clave es incorrecta");
		}

		ICache cache = cacheManager.getCache(DEFAULT_CACHE_NAME);
		BigDecimal amount = (BigDecimal) cache.get(loanId);

		DisburseCreditLineRequest disburseCreditLineRequest = new DisburseCreditLineRequest();

		disburseCreditLineRequest.setAmount(amount);
		disburseCreditLineRequest.setLoanId(loanId);
		disburseCreditLineRequest.setChannel(B2C);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inDisburseCreditLineRequest", disburseCreditLineRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, "IndividualLoan.DisbursementManagement.DisburseRevolvingCreditLine", cobisSessionId, serviceRequestTO);
			if (serviceResponseTO.isSuccess()) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("=============== init applyDisburse ================");
					LOGGER.logDebug(">>>> response data " + serviceResponseTO.getData());
					LOGGER.logDebug("=============== end applyDisburse ================");
				}

				if (serviceResponseTO.getData() != null) {
					response = (DisburseCreditLineResponse) serviceResponseTO.getData().get("returnDisburseCreditLineResponse");
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
						transactionInfo.setMonto(response.getAmount());
						transactionInfo.setComision(response.getComission());
						transactionInfo.setNumeroCuenta(response.getAccount());
					}
				}
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				String msg = applicationResponse.get("@o_msg").toString();
				if (msg != null && !msg.trim().isEmpty()) {
					throw new MobileServiceException(msg);
				} else {
					cache.remove(loanId);
				}
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			LOGGER.logError("Error en applyDisburse ", e);
			throw new MobileServiceException(e);
		}
		return transactionInfo;
	}

	public TransactionInfo applyGenerateReference(String loanId, String clientId, String login, String password, String cobisSessionId) throws MobileServiceException {
		DisburseCreditGenerateResponse response = null;
		TransactionInfo transactionInfo = new TransactionInfo();

		KeepSecurity keepSecurity = new KeepSecurity(null, Activator.getPrivateKey().toString().toCharArray());
		String decryptedPass = keepSecurity.decrypt(password);
		boolean isValidPassword = adminTokenUser.isValidPasword(clientId, decryptedPass, login, Constants.CHANNEL);

		if (!isValidPassword) {
			throw new MobileServiceException("La clave es incorrecta");
		}

		ICache cache = cacheManager.getCache(DEFAULT_CACHE_NAME);
		BigDecimal amount = (BigDecimal) cache.get(loanId);
		BigDecimal tax = (BigDecimal) cache.get("tax");
		BigDecimal commission = (BigDecimal) cache.get("commission");
		BigDecimal capitalBalance = (BigDecimal) cache.get("capitalBalance");

		DisburseCreditLineRequest disburseCreditLineRequest = new DisburseCreditLineRequest();

		disburseCreditLineRequest.setAmount(amount);
		disburseCreditLineRequest.setLoanId(loanId);
		disburseCreditLineRequest.setTax(tax);
		disburseCreditLineRequest.setCommission(commission);
		disburseCreditLineRequest.setCapitalBalance(capitalBalance);
		disburseCreditLineRequest.setChannel(B2C);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue("inDisburseCreditLineRequest", disburseCreditLineRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, "IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine", cobisSessionId, serviceRequestTO);
			if (serviceResponseTO.isSuccess()) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("=============== init applyGenerateReference ================");
					LOGGER.logDebug(">>>> response data " + serviceResponseTO.getData());
					LOGGER.logDebug(">>>> response data " + serviceResponseTO.getData().get("returnDisburseCreditLineResponse"));
					LOGGER.logDebug(">>>> response data " + serviceResponseTO.getData().get("returnDisburseCreditGenerateResponse"));
					LOGGER.logDebug("=============== end applyGenerateReference ================");
				}
				if (serviceResponseTO.getData() != null) {
					response = (DisburseCreditGenerateResponse) serviceResponseTO.getData().get("returnDisburseCreditGenerateResponse");
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
						transactionInfo.setNombreSocio(response.getPartner());
						transactionInfo.setReferencia(response.getReference());
					}
				}
				Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				String msg = applicationResponse.get("@o_msg").toString();
				if (msg != null && !msg.trim().isEmpty()) {
					throw new MobileServiceException(msg);
				} else {
					cache.remove(loanId);
					cache.remove("tax");
					cache.remove("commission");
					cache.remove("capitalBalance");
				}
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}

		} catch (Exception e) {
			LOGGER.logError("Error en applyDisburse ", e);
			throw new MobileServiceException(e);
		}

		return transactionInfo;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	public void setCacheManager(ICacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	public void unsetCacheManager(ICacheManager cacheManager) {
		this.cacheManager = null;
	}

	public void setAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = adminTokenUser;
	}

	public void unsetAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = null;
	}

	public void setConfigurationService(IConfigurationService configurationService) {
		this.configurationService = configurationService;
	}

	public void unsetConfigurationService(IConfigurationService configurationService) {
		this.configurationService = null;
	}

	@Override
	public ClientInformation getLoansInfo(LoanInfoRequest loanInfoRequest, String cobisSessionId) throws MobileServiceException {
		ClientInformation wClientInformation = new ClientInformation();
		List<ClientLoansInfo> listInfo = new ArrayList<ClientLoansInfo>();

		QueryLoansRequest queryLoansRequest = new QueryLoansRequest();
		queryLoansRequest.setCustomerId(loanInfoRequest.getCustomerId());
		queryLoansRequest.setOption(loanInfoRequest.getOption());
		queryLoansRequest.setOperation(loanInfoRequest.getOperation());
		queryLoansRequest.setTypeOperation(loanInfoRequest.getProductType());
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("getCustomerId = " + loanInfoRequest.getCustomerId());
			LOGGER.logDebug("getOption = " + loanInfoRequest.getOption());
			LOGGER.logDebug("getOperation = " + loanInfoRequest.getOperation());
			LOGGER.logDebug("getProductType = " + loanInfoRequest.getProductType());
		}

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inQueryLoansRequest", queryLoansRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, "BusinessToConsumer.OperationsInfo.QueryLoans", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				QueryLoansResponse[] loansResponse = (QueryLoansResponse[]) serviceResponseTO.getData().get("returnQueryLoansResponse");
				QueryTransactionResponse[] detailsLoansResponse = (QueryTransactionResponse[]) serviceResponseTO.getData().get("returnQueryTransactionResponse");
				OperationResponse[] inforResponse = (OperationResponse[]) serviceResponseTO.getData().get("returnOperationResponse");
				LinkedHashMap<Integer, ClientLoansInfo> mapClientLoansInfo = new LinkedHashMap<Integer, ClientLoansInfo>();

				getLoans(mapClientLoansInfo, loansResponse);
				getLoanDetails(mapClientLoansInfo, detailsLoansResponse);
				listInfo = getAllCustomerLoans(mapClientLoansInfo);

				wClientInformation.setCustomerId(loanInfoRequest.getCustomerId());
				if ("E".equals(loanInfoRequest.getOption())) {
					wClientInformation.setUltimoAcceso(DateConverter.calendarToFormattedString(inforResponse[0].getExpirationPaymentDate()));
				} else {
					wClientInformation.setUltimoAcceso(DateConverter.calendarToDateTimeStringAmPm(inforResponse[0].getExpirationPaymentDate()));
				}
				wClientInformation.setMailAddress(inforResponse[0].getEmailAddress());

				wClientInformation.setBusinessPartner(inforResponse[0].getBusinessPartner());

				wClientInformation.setListClientLoansInfo(listInfo);

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Ultimo Acceso: " + wClientInformation.getUltimoAcceso());
					LOGGER.logDebug("El cliente es socio comercial: " + wClientInformation.getBusinessPartner());
				}
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}

		return wClientInformation;
	}

	private List<ClientLoansInfo> getAllCustomerLoans(LinkedHashMap<Integer, ClientLoansInfo> mapClientLoansInfo) {
		List<ClientLoansInfo> listClientLoansInfos = new ArrayList<ClientLoansInfo>();
		for (ClientLoansInfo value : mapClientLoansInfo.values()) {
			listClientLoansInfos.add(value);
		}
		return listClientLoansInfos;
	}

	private void getLoans(LinkedHashMap<Integer, ClientLoansInfo> mapClientLoansInfo, QueryLoansResponse[] loansResponse) {
		ClientLoansInfo clientLoansInfo;
		ClientLoans clientLoans;
		List<ClientLoans> listClientLoans;

		for (QueryLoansResponse loanResponse : loansResponse) {
			clientLoans = new ClientLoans();
			clientLoans.setLabel(loanResponse.getLabel());
			clientLoans.setValue(loanResponse.getValue());

			listClientLoans = new ArrayList<ClientLoans>();
			listClientLoans.add(clientLoans);

			clientLoansInfo = new ClientLoansInfo();
			clientLoansInfo.setOperation(loanResponse.getOperation());
			clientLoansInfo.setAllowPayment(loanResponse.getAllowPayment());
			clientLoansInfo.setAllowDispersal(loanResponse.getAllowDispersal());
			clientLoansInfo.setProductName(loanResponse.getOperationType());

			clientLoansInfo.setShowAnotherValue(loanResponse.getAllowPayment());
			if (loanResponse.getBank() != null) {
				clientLoansInfo.setBank(loanResponse.getBank().trim());
			}
			clientLoansInfo.setInstProc(loanResponse.getInstProc());

			clientLoansInfo.setListClientLoans(listClientLoans);
			clientLoansInfo.setListClientLoansDetails(new ArrayList<ClientLoansDetails>());

			if (mapClientLoansInfo.containsKey(loanResponse.getOperation())) {
				mapClientLoansInfo.get(loanResponse.getOperation()).getListClientLoans().add(clientLoans);
			} else {
				mapClientLoansInfo.put(loanResponse.getOperation(), clientLoansInfo);
			}
		}
	}

	private void getLoanDetails(LinkedHashMap<Integer, ClientLoansInfo> mapClientLoansInfo, QueryTransactionResponse[] detailsLoansResponse) {
		ClientLoansInfo clientLoansInfo;
		ClientLoansDetails clientLoansDetails;
		List<ClientLoansDetails> listClientLoansDetails;

		for (QueryTransactionResponse detailLoansResponse : detailsLoansResponse) {
			clientLoansDetails = new ClientLoansDetails();
			clientLoansDetails.setMovementType(detailLoansResponse.getMovementType());
			clientLoansDetails.setMovementValue(detailLoansResponse.getMovementValue());
			clientLoansDetails.setMovementDate(detailLoansResponse.getMovementDate());
			clientLoansDetails.setTrnState(detailLoansResponse.getTrnState());

			listClientLoansDetails = new ArrayList<ClientLoansDetails>();
			listClientLoansDetails.add(clientLoansDetails);

			clientLoansInfo = new ClientLoansInfo();
			clientLoansInfo.setOperation(detailLoansResponse.getOperation());
			clientLoansInfo.setListClientLoansDetails(listClientLoansDetails);

			if (mapClientLoansInfo.containsKey(detailLoansResponse.getOperation())) {
				mapClientLoansInfo.get(detailLoansResponse.getOperation()).getListClientLoansDetails().add(clientLoansDetails);
			}
		}
	}

	@Override
	public ElavonResponse getPayLeague(ElavonRequest elavonRequest, String cobisSessionId) throws MobileServiceException {
		ElavonResponse elavonResponse = new ElavonResponse();
		// Esta implementación utiliza URLConnection
		StringBuffer responseBuffer = null;
		HttpsURLConnection conn = null;
		OutputStreamWriter writer = null;
		BufferedReader reader = null;

		try {
			String xml = WebPayXMLConverter.buildXML(elavonRequest, serviceIntegration, cobisSessionId);
			boolean validar = ValidateXmlXsd.validate(xml);
			if (!validar) {
				throw new MobileServiceException("Error al validar el XML");
			}
			ParameterServiceImpl parameterService = new ParameterServiceImpl();
			parameterService.setServiceIntegration(serviceIntegration);
			ParameterSearchResponse dat0WebPay = parameterService.searchParameter("WPPDAT", "CLI", cobisSessionId);
			ParameterSearchResponse protocoloWebPay = parameterService.searchParameter("WPPPRO", "CLI", cobisSessionId);
			ParameterSearchResponse dominioWebPay = parameterService.searchParameter("WPPDOM", "CLI", cobisSessionId);
			ParameterSearchResponse puertoWebPay = parameterService.searchParameter("WPPPRT", "CLI", cobisSessionId);
			ParameterSearchResponse bodyWebPay = parameterService.searchParameter("WPPUBO", "CLI", cobisSessionId);
			ParameterSearchResponse key1WebPay = parameterService.searchParameter("WPPKE1", "CLI", cobisSessionId);
			ParameterSearchResponse key2WebPay = parameterService.searchParameter("WPPKE2", "CLI", cobisSessionId);
			ParameterSearchResponse minAmount = parameterService.searchParameter("WPPMOM", "CLI", cobisSessionId);

			String key = key1WebPay.getCharValue().trim() + key2WebPay.getCharValue().trim(); // se completa el key
			String urlCompleta = protocoloWebPay.getCharValue() + dominioWebPay.getCharValue() + String.valueOf(puertoWebPay.getIntValue()) + bodyWebPay.getCharValue();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(className + "Llave para WPP: " + key);
				LOGGER.logDebug(className + "XML a enviar a WPP: " + xml);
			}
			if (elavonRequest.getAmount() < minAmount.getFloatValue() || elavonRequest.getAmount() > elavonRequest.getMaximumPayment()) {
				LOGGER.logDebug("Pago supera monto existoso......");
				throw new MobileServiceException(MESSAGGEERROR);
			}

			String encryptedString = AESCrypto.encrypt(xml, key);

			String encodedString = URLEncoder.encode("<pgs><data0>" + dat0WebPay.getCharValue() + "</data0><data>" + encryptedString + "</data></pgs>", UTF8);
			String postParam = "xml=" + encodedString;
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(className + "Iniciando Conexión WebPay PLUS");
				LOGGER.logDebug(className + "Url a llamar: " + urlCompleta);
				LOGGER.logDebug(className + "Request ServicioWebPay: " + postParam);
			}
			URL url = new URL(urlCompleta);
			conn = (HttpsURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setConnectTimeout(TIMEOUT);
			conn.setReadTimeout(TIMEOUT);
			conn.connect();
			writer = new OutputStreamWriter(conn.getOutputStream());
			writer.write(postParam);
			writer.flush();

			String line;
			reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			responseBuffer = new StringBuffer("");
			while ((line = reader.readLine()) != null) {
				responseBuffer.append(line);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(className + "Finalizando Conexión WebPay PLUS");
				LOGGER.logDebug(className + "Respuesta encriptada: " + responseBuffer.toString());
			}
			int responseCode = conn.getResponseCode();
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("conn.getResponseCode() ==> " + conn.getResponseCode());
			}
			if (responseCode >= 400) {
				throw new MobileServiceException("ResponseCode Error: " + responseCode);
			}
			String decryptedString = AESCrypto.decrypt(responseBuffer.toString(), key);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("decryptedString ==> " + decryptedString);
			}

			if (!validateXmlSchema(decryptedString)) {
				throw new MobileServiceException("XML no valido: " + decryptedString);
			}

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new InputSource(new StringReader(decryptedString)));

			String nodeLatLng = getNodeListTxt(document, TAGURL);

			String nodeStatus = getNodeListTxt(document, TAGCDRES);
			if (nodeStatus != null && !SUCCESS.equals(nodeStatus)) {
				String nodeTxtStatus = getNodeListTxt(document, TAGNBRES);
				throw new MobileServiceException("Error: " + nodeTxtStatus);
			}

			elavonResponse.setLoanId(elavonRequest.getLoanId());
			elavonResponse.setUrlPayLeague(nodeLatLng);
		} catch (ProtocolException e) {
			LOGGER.logError("Error al ingresar a URL WebPay PLUS: ", e);
			throw new MobileServiceException(e);
		} catch (SAXException e) {
			LOGGER.logError("Error al generar XML: ", e);
			throw new MobileServiceException(e);
		} catch (ServletException e) {
			LOGGER.logError("Error al validar XML: " + e);
			throw new MobileServiceException(e);
		} catch (Exception e) {
			LOGGER.logError("Error en conexión con WebPay PLUS: ", e);
			throw new MobileServiceException(e);
		} finally {
			if (conn != null)
				conn.disconnect();

			if (writer != null)
				try {
					writer.close();
				} catch (IOException e) {
					LOGGER.logError(className + "Error al cerrar la conexión con WebPay PLUS: ", e);
					throw new MobileServiceException(e);
				}
			if (reader != null)
				try {
					reader.close();
				} catch (IOException e) {
					LOGGER.logError(className + "Error al cerrar la conexión con WebPay PLUS: ", e);
					throw new MobileServiceException(e);
				}
		}
		return elavonResponse;
	}

	@Override
	public String getEndPointElavon(String endPointRequest) throws MobileServiceException {
		try {

			String cobisSessionId = getCobisSessionId(serviceIntegration, LOGGER);

			endPointRequest = endPointRequest.replaceAll("\n", "");
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("endPointRequest ==> " + endPointRequest);
				LOGGER.logDebug("Se obtiene el sessionID" + endPointRequest);
			}

			ParameterServiceImpl parameterService = new ParameterServiceImpl();
			parameterService.setServiceIntegration(serviceIntegration);
			ParameterSearchResponse key1WebPay = parameterService.searchParameter("WPPKE1", "CLI", cobisSessionId);
			ParameterSearchResponse key2WebPay = parameterService.searchParameter("WPPKE2", "CLI", cobisSessionId);

			String key = key1WebPay.getCharValue() + key2WebPay.getCharValue(); // se completa el key

			// endPointRequest = URLDecoder.decode(endPointRequest, UTF8);
			String decryptedString = AESCrypto.decrypt(endPointRequest, key);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(className + " Desencriptado de Respuesta: " + decryptedString);
			}

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.parse(new InputSource(new StringReader(decryptedString)));

			if (validateTrxResponse(document)) {
				applyPayment(document, cobisSessionId);
			}

		} catch (UnsupportedEncodingException e) {
			LOGGER.logError("EndPointElavon - Error al decodificar cadena EndPoint: ", e);
			throw new MobileServiceException(e);
		} catch (SAXException e) {
			LOGGER.logError("EndPointElavon - Error al generar XML: ", e);
			throw new MobileServiceException(e);
		} catch (IOException e) {
			LOGGER.logError("EndPointElavon - Error al obtener el Document: ", e);
			throw new MobileServiceException(e);
		} catch (ParserConfigurationException e) {
			LOGGER.logError("EndPointElavon - Error al obtener el DocumentBuilder: ", e);
			throw new MobileServiceException(e);
		} catch (MobileServiceException e) {
			LOGGER.logError("EndPointElavon - Error al obtener la respuesta:", e);
			throw new MobileServiceException(e);
		} catch (Exception e) {
			LOGGER.logError("EndPointElavon - Error al obtener el pago:", e);
			throw new MobileServiceException(e);
		}
		return endPointRequest;
	}

	private boolean validateTrxResponse(Document document) throws MobileServiceException {
		if (document != null) {

			String resp = getNodeListTxt(document, TAGRESP);
			String numError = getNodeListTxt(document, TAGNUMERR);
			String txtError = getNodeListTxt(document, TAGTXTERR);

			if (APPROVED.equals(resp)) {
				return true;
			} else if (DENIED.equals(resp)) {
				LOGGER.logError(DENMSM);
				LOGGER.logError(numError + " : " + txtError);
				throw new MobileServiceException(DENMSM);
			} else if (ERROR.equals(resp)) {
				LOGGER.logError(ERRMSM);
				LOGGER.logError(numError + " : " + txtError);
				throw new MobileServiceException(ERRMSM);
			}
		}
		return false;
	}

	private void applyPayment(Document aDocument, String cobisSessionId) throws MobileServiceException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("LoanServiceImpl.applyPayment - INI");
			LOGGER.logDebug("LoanServiceImpl.applyPayment - serviceIntegration=" + serviceIntegration);
		}

		PaymentRequest paymentRequest = mappingPaymentRequest(aDocument);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inPaymentRequest", paymentRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, "BusinessToConsumer.OperationsInfo.ApplyPayment", cobisSessionId, serviceRequest);
			if (!serviceResponseTO.isSuccess()) {
				LOGGER.logDebug("Imprimir serviceResponseTO toString: " + serviceResponseTO.toString());
				LOGGER.logDebug("Imprimir serviceResponseTO getMessages.toString: " + serviceResponseTO.getMessages().toString());
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}

	}

	private PaymentRequest mappingPaymentRequest(Document aDocument) throws MobileServiceException {
		PaymentRequest paymentRequest = new PaymentRequest();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("mappingPaymentRequest - INI");
			LOGGER.logDebug("this.configurationService = " + this.configurationService);
		}
		String amountNode;
		String referenceNode;
		String paymentFolio;
		String urlId;
		String amountStrCents = null;
		try {
			amountNode = getNodeListTxt(aDocument, TAGAMOUNT);
			referenceNode = getNodeListTxt(aDocument, TAGREFERENCE);
			paymentFolio = getNodeListTxt(aDocument, TAGFOLPAY);
			urlId = getNodeListTxt(aDocument, TAGIDURL);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("mappingPaymentRequest - INI");
				LOGGER.logDebug("Cantidad es: " + amountNode);
				LOGGER.logDebug("Referencia es: " + referenceNode);
				LOGGER.logDebug("FolioCPago es: " + paymentFolio);
				LOGGER.logDebug("UrlId es: " + urlId);
			}
			if (amountNode != null) {
				double amountDouble = Double.valueOf(amountNode);
				amountStrCents = String.valueOf(Math.round(amountDouble * 100));
			}

			paymentRequest.setCorrespondent(ELAVON);
			paymentRequest.setReference(referenceNode);
			paymentRequest.setPaymentAmount(amountStrCents);
			paymentRequest.setTrnIdCorrespondent(paymentFolio);
			paymentRequest.setFile(B2C);
			String date = this.configurationService.getProcessDate(101);
			date = date.replace("/", "");
			paymentRequest.setPaymentDate(date);

		} catch (Exception e) {
			LOGGER.logError("Error en mappingPaymentRequest: ", e);
			throw new MobileServiceException(e);
		}
		return paymentRequest;
	}

	private String getNodeListTxt(Document document, String tagName) throws MobileServiceException {
		XPathFactory xpathFactory = XPathFactory.newInstance();
		XPath xpath = xpathFactory.newXPath();

		String resp;
		try {
			NodeList response = (NodeList) xpath.evaluate(tagName, document, XPathConstants.NODESET);
			resp = response.item(0).getTextContent();
		} catch (XPathExpressionException e) {
			LOGGER.logError("Error al obtener el nodo " + tagName + ": ", e);
			throw new MobileServiceException(e);
		}
		return resp;

	}

	public boolean validateXmlSchema(String strValue) {
		if (strValue != null && strValue.contains(STATUSERR) && strValue.contains(DESCERR)) {
			return true;
		}
		return false;
	}

	@Override
	public SimulationResponse simulate(SimulationRequest simulationRequest, String sessionId) throws MobileServiceException {
		SimulationResponse sr = new SimulationResponse();
		ServiceRequestTO requestTo = new ServiceRequestTO();
		ServiceResponseTO response = new ServiceResponseTO();
		SimulationRequestDTO simulationRequestDto = new SimulationRequestDTO();
		SimulationResponseDTO[] simulationResponseDto;
		try {
			LOGGER.logDebug(">>>>>>>>>>>metodo simulate ");
			LOGGER.logDebug(">>>>>>>>>>>metodo simulate -- llamar al servicio");

			simulationRequestDto.setAmount(simulationRequest.getAmount());
			simulationRequestDto.setClient(simulationRequest.getClient());
			simulationRequestDto.setCurrency(simulationRequest.getCurrency());
			simulationRequestDto.setIniDate(simulationRequest.getIniDate());
			simulationRequestDto.setOperationType(simulationRequest.getOperationType());
			simulationRequestDto.setPeriodicity(simulationRequest.getPeriodicity());
			simulationRequestDto.setRate(simulationRequest.getRate());
			simulationRequestDto.setTerm(simulationRequest.getTerm());

			requestTo.addValue("inSimulationRequestDTO", simulationRequestDto);
			response = execute(serviceIntegration, LOGGER, "IndividualLoan.OnBoarding.SimulationTableAmortization", sessionId, requestTo);

			if (response.isSuccess()) {
				simulationResponseDto = (SimulationResponseDTO[]) response.getData().get("returnSimulationResponseDTO");
				sr.setAmountPay(simulationResponseDto[0].getAmountPay());
				LOGGER.logInfo("Response sr:" + sr.getAmountPay());
				return sr;
			} else {
				LOGGER.logInfo("Response simulation false");
				manageResponseError(response, LOGGER);
				return null;
			}

		} catch (Exception e) {
			throw new MobileServiceException(e);
		}

	}

	@Override
	public OperationCreateResponse createOperation(OperationCreateRequest operationCreateRequest, String cobisSessionId) throws MobileServiceException {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(">>>>>>>>>>>metodo createOperation ");
				LOGGER.logDebug(">>>>>>>>>>>metodo createOperation -- llamar al servicio");
			}

			ServiceRequestTO requestTo = new ServiceRequestTO();
			ServiceResponseTO response = new ServiceResponseTO();
			OperationCreateResponse operationCreateResponse = new OperationCreateResponse();
			OnboardingOperationRequest onboardingOperationRequest = new OnboardingOperationRequest();

			onboardingOperationRequest.setType('O');
			onboardingOperationRequest.setCustomerId(operationCreateRequest.getClient());
			onboardingOperationRequest.setOperationType(operationCreateRequest.getOperationType());
			onboardingOperationRequest.setMoney(operationCreateRequest.getCurrency());
			onboardingOperationRequest.setProcessDate(operationCreateRequest.getIniDate());
			onboardingOperationRequest.setAmount(operationCreateRequest.getAmountMax());
			onboardingOperationRequest.setTerm(operationCreateRequest.getTerm());
			onboardingOperationRequest.setFrequency(operationCreateRequest.getPeriodicity());
			onboardingOperationRequest.setRate(Double.valueOf(operationCreateRequest.getRate()));
			onboardingOperationRequest.setApprovedAmount(operationCreateRequest.getAmount());
			onboardingOperationRequest.setOnLine('N');
			onboardingOperationRequest.setExternal('N');
			onboardingOperationRequest.setFromWeb('N');

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("PMO parametros q van al SG setCustomerId: " + operationCreateRequest.getClient());
				LOGGER.logDebug("PMO parametros q van al SG setOperationType: " + operationCreateRequest.getOperationType());
				LOGGER.logDebug("PMO parametros q van al SG setMoney: " + operationCreateRequest.getCurrency());
				LOGGER.logDebug("PMO parametros q van al SG setProcessDate: " + operationCreateRequest.getIniDate());
				LOGGER.logDebug("PMO parametros q van al SG setAmount: " + operationCreateRequest.getAmount());
				LOGGER.logDebug("PMO parametros q van al SG setTerm: " + operationCreateRequest.getTerm());
				LOGGER.logDebug("PMO parametros q van al SG setFrequency: " + operationCreateRequest.getPeriodicity());
				LOGGER.logDebug("PMO parametros q van al SG setRate: " + operationCreateRequest.getRate());
				LOGGER.logDebug("PMO parametros q van al SG setApprovedAmount: " + onboardingOperationRequest.getApprovedAmount());
			}

			requestTo.addValue("inOnboardingOperationRequest", onboardingOperationRequest);
			response = execute(serviceIntegration, LOGGER, "BusinessToConsumer.OnboardingCreditManagement.CreateOperation", cobisSessionId, requestTo);

			if (response.isSuccess()) {
				Map<String, Object> customerResponse = (Map<String, Object>) response.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("PMO parametros de salida @o_banco: " + Utils.getOutputs(customerResponse, "@o_banco"));
					LOGGER.logDebug("PMO parametros de salida @o_tramite: " + Utils.getOutputs(customerResponse, "@o_tramite"));
					LOGGER.logDebug("PMO parametros de salida @o_fecha_ini: " + Utils.getOutputs(customerResponse, "@o_fecha_ini"));
					LOGGER.logDebug("PMO parametros de salida @o_fecha_fin: " + Utils.getOutputs(customerResponse, "@o_fecha_fin"));
				}

				operationCreateResponse.setBank(Utils.getOutputs(customerResponse, "@o_banco").toString());
				operationCreateResponse.setOperation(Integer.parseInt(Utils.getOutputs(customerResponse, "@o_tramite").toString()));
				operationCreateResponse.setFechaIni(Utils.getOutputs(customerResponse, "@o_fecha_ini").toString());
				operationCreateResponse.setFechaFin(Utils.getOutputs(customerResponse, "@o_fecha_fin").toString());
				return operationCreateResponse;
			} else {
				LOGGER.logInfo("Response generateDisbursement false");
				manageResponseError(response, LOGGER);
				return null;
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	@Override
	public ServiceResponseTO generateDisbursement(DisbursementRequest disbursementRequest, String cobisSessionId) throws MobileServiceException {
		try {
			LOGGER.logDebug(">>>>>>>>>>>metodo generateDisbursement ");
			LOGGER.logDebug(">>>>>>>>>>>metodo generateDisbursement -- llamar al servicio");

			ServiceRequestTO requestTo = new ServiceRequestTO();
			ServiceResponseTO response = new ServiceResponseTO();
			DisbursementRequestDTO disbursementRequestDTO = new DisbursementRequestDTO();

			disbursementRequestDTO.setTramite(disbursementRequest.getIdTramit());

			requestTo.addValue("inDisbursementRequestDTO", disbursementRequestDTO);
			response = execute(serviceIntegration, LOGGER, "IndividualLoan.DisbursementManagement.DisbursementOperation", cobisSessionId, requestTo);

			if (response.isSuccess()) {
				return response;
			} else {
				LOGGER.logInfo("Response generateDisbursement false");
				manageResponseError(response, LOGGER);
				return null;
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	@Override
	public ServiceResponseTO saveKYCForm(KYCFormRequestLocal kycFormRequestLocal, String cobisSessionId) throws MobileServiceException {
		try {
			LOGGER.logDebug(">>>>>>>>>>>metodo saveKYCForm ");
			LOGGER.logDebug(">>>>>>>>>>>metodo saveKYCForm -- llamar al servicio");
			BaseResponse baseResponse = new BaseResponse();

			ServiceRequestTO requestTo = new ServiceRequestTO();
			ServiceResponseTO response = new ServiceResponseTO();

			KycFormRequest kycFormRequest = new KycFormRequest();
			kycFormRequest.setAccept(kycFormRequestLocal.getAccept());
			kycFormRequest.setClientId(kycFormRequestLocal.getClientId());

			for (int i = 0; i < kycFormRequestLocal.getQuestions().length; i++) {
				LOGGER.logDebug(">>>>>>>>>>>metodo saveKYCForm For ");
				LOGGER.logDebug(">>>>>>>>>>>metodo saveKYCForm -- Ingreso de datos");
				kycFormRequest.setType(kycFormRequestLocal.getQuestions()[i].getType());
				kycFormRequest.setAnswer(kycFormRequestLocal.getQuestions()[i].getAnswer());
				requestTo.addValue("inKycFormRequest", kycFormRequest);
				response = execute(serviceIntegration, LOGGER, "BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm", cobisSessionId, requestTo);
				LOGGER.logDebug(">>>>>>>>>>>Consumo del servicio" + response);
			}

			if (response.isSuccess()) {
				return response;

			} else {
				LOGGER.logInfo("Response saveKYCForm false");
				manageResponseError(response, LOGGER);
				return null;
			}

		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

}
