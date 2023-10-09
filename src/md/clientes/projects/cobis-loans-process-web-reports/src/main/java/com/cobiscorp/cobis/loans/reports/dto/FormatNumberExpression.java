package com.cobiscorp.cobis.loans.reports.dto;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ConvertNumbersLetterRequest;
import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class FormatNumberExpression {
	private static final ILogger logger = LogFactory.getLogger(FormatNumberExpression.class);
	public static final String SERVICEREADCONVERT = "Businessprocess.Creditmanagement.ConvertManagment.ReadConvert"; // cob_comext..sp_conv_numero_letras
	public static final String INCONVERTLETTER = "inConvertNumbersLetterRequest";
	private BigDecimal value;
	private String integerLetterPart;
	private String decimalLetterPart;
	private String separator;
	private ICTSServiceIntegration serviceIntegration;
	private String sessionId;

	public FormatNumberExpression() {
		this(new BigDecimal(0));
	}

	public FormatNumberExpression(BigDecimal value) {
		this.value = value;
		this.separator = " ";
	}

	public FormatNumberExpression(BigDecimal value, String sessionId, ICTSServiceIntegration serviceIntegration) {
		this(value, " ", sessionId, serviceIntegration);
	}

	public FormatNumberExpression(BigDecimal value, String separator, String sessionId, ICTSServiceIntegration serviceIntegration) {
		this.value = value;
		this.separator = separator;
		this.setSessionId(sessionId);
		this.setServiceIntegration(serviceIntegration);
	}

	public void parse() {
		if (this.value != null) {
			String descritpionNominalRateDecimal = "";
			// REDONDEA A 2 DIGITOS
			BigDecimal nominalFixedRate = this.value.setScale(2, BigDecimal.ROUND_HALF_UP);
			// OBTIENE EN FORMATO DE TEXTO - SOLO LA PARTE ENTERA (opcion 3)
			String descritpionNominalFixedRate = this.getConvertNumbersLetterRequest(nominalFixedRate.doubleValue(), 3);
			// OBTIENE LA PARTE 'DECIMAL' Y LA PONE COMO ENTERA ENTERA
			BigDecimal decimalNominalFixedRate = nominalFixedRate.subtract(new BigDecimal(nominalFixedRate.longValue())).multiply(new BigDecimal(100));
			// OBTIENE EN FORMATO DE TEXTO - SOLO LA PARTE ENTERA (opcion 3)
			if (this.separator.equals(" ")) {
				if (decimalNominalFixedRate.intValue() >= 0 && decimalNominalFixedRate.intValue() < 10) {
					descritpionNominalRateDecimal = "0" + String.valueOf(decimalNominalFixedRate.intValue()) + "/100";
				} else {
					descritpionNominalRateDecimal = String.valueOf(decimalNominalFixedRate.intValue()) + "/100";
				}
			} else {
				descritpionNominalRateDecimal = this.getConvertNumbersLetterRequest(decimalNominalFixedRate.doubleValue(), 3);
			}

			this.integerLetterPart = descritpionNominalFixedRate;
			this.decimalLetterPart = descritpionNominalRateDecimal;
		} else {
			this.integerLetterPart = "";
			this.decimalLetterPart = "";
		}
	}

	public String getConvertNumbersLetterRequest(double cant, int option) {
		if (BigDecimal.ZERO.equals(BigDecimal.valueOf(cant))) {
			return "CERO";
		}
		ConvertNumbersLetterRequest dto = new ConvertNumbersLetterRequest();
		dto.setNumber(cant);
		dto.setOption(option);
		ServiceRequestTO serviceReportRequestTO = this.getHeaderRequest();
		serviceReportRequestTO.addValue(FormatNumberExpression.INCONVERTLETTER, dto);
		ServiceResponseTO serviceResponseConvert = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

		if (serviceResponseConvert.isSuccess()) {
			@SuppressWarnings({ "unchecked", "rawtypes" })
			Map<String, Object> applicationResponse = (Map) serviceResponseConvert.getValue("com.cobiscorp.cobis.cts.service.response.output");
			if (applicationResponse != null) {
				return applicationResponse.get("@o_letras").toString();
			}
		} else {
			seLogError(serviceResponseConvert);
		}
		return "";
	}

	private ServiceRequestTO getHeaderRequest() {
		ServiceRequest headerRequest = new ServiceRequest();
		headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, this.sessionId);
		ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
		serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
		serviceReportRequestTO.setSessionId(this.sessionId);
		serviceReportRequestTO.setServiceId(FormatNumberExpression.SERVICEREADCONVERT);
		return serviceReportRequestTO;
	}

	@SuppressWarnings("unchecked")
	public void seLogError(ServiceResponseTO serviceResponseTO) {
		logger.logDebug("FormatNumberExpression ->  FAIL SERVICE: " + serviceResponseTO);
		if (logger.isDebugEnabled()) {
			if (serviceResponseTO.getMessages() != null) {
				List<MessageTO> errorMessages = new ArrayList<MessageTO>();
				errorMessages = serviceResponseTO.getMessages();
				for (MessageTO message : errorMessages) {
					logger.logDebug("FormatNumberExpression -> Codigo: [" + message.getCode() + "], Detalle:" + message.getMessage());
				}
			}
		}
	}

	public BigDecimal getValue() {
		return this.value;
	}

	public void setValue(BigDecimal value) {
		this.value = value;
	}

	public String getSeparator() {
		return this.separator;
	}

	public void setSeparator(String separator) {
		this.separator = separator;
	}

	public ICTSServiceIntegration getServiceIntegration() {
		return serviceIntegration;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getIntegerLetterPart() {
		return this.integerLetterPart;
	}

	public String getDecimalLetterPart() {
		return this.decimalLetterPart;
	}

	public String getFullLetter() {
		String separatorTmp = " " + this.separator + " ";
		if (this.separator.trim().equals("")) {
			separatorTmp = " ";
		}
		return this.integerLetterPart + separatorTmp + this.decimalLetterPart;
	}

	public String getFullNumber() {
		DecimalFormat formato = new DecimalFormat("#,##0.00");
		return formato.format(this.value);
	}

}
