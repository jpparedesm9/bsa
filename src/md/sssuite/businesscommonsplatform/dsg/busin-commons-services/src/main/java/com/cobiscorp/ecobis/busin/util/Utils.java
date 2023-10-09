package com.cobiscorp.ecobis.busin.util;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRowColumnData;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;

/**
 * @author srojas
 * 
 */
public class Utils {

	private static ILogger logger = LogFactory.getLogger(Utils.class);

	public static String getStringRowDataValue(IResultSetRowColumnData rowColumnData) {

		try {
			if (rowColumnData != null && rowColumnData.getValue() != null) {

				String value = rowColumnData.getValue();

				if (value.contains("&amp;")) {
					value = getReplaceString(value);
				}
				return value;
			}
			return null;
		} catch (Exception e) {
			logger.logError(e);
			return null;
		}
	}

	/**
	 * Se verifica la existencia de caracteres especiales incluidos por el CTS y
	 * se los remueve del String para entregar data modificada como respuesta
	 * del servicio.
	 * 
	 * @param value
	 *            String con caracteres especiales.
	 * @return String modificado
	 */
	private static String getReplaceString(String value) {

		if (value != null && value.contains("&amp;")) {
			value = getReplaceString(value.replace("&amp;", "&"));
		} else if (value != null && value.contains("&lt;")) {
			value = getReplaceString(value.replace("&lt;", "<"));
		} else if (value != null && value.contains("&gt;")) {
			value = getReplaceString(value.replace("&gt;", ">"));
		} else if (value != null && value.contains("&quot;")) {
			value = getReplaceString(value.replace("&quot;", "\\"));
		} else if (value != null && value.contains("&apos;")) {
			value = getReplaceString(value.replace("&apos;", "'"));
		}

		return value;
	}

	public static Integer getIntegerRowDataValue(IResultSetRowColumnData rowColumnData) {
		try {
			if (rowColumnData != null && rowColumnData.getValue() != null) {
				return Integer.valueOf(rowColumnData.getValue());
			}
			return 0;

		} catch (NumberFormatException e) {
			logger.logError(e);
			return null;
		}
	}

	public static BigDecimal getBigDecimalRowDataValue(IResultSetRowColumnData rowColumnData) {

		try {
			if (rowColumnData != null && rowColumnData.getValue() != null) {
				return BigDecimal.valueOf(Double.valueOf(rowColumnData.getValue().replace(",", ".")));
			}
			return BigDecimal.valueOf(0.0);

		} catch (NumberFormatException e) {
			logger.logError(e);
			return null;
		}
	}

	public static Calendar getCalendarRowDataValue(IResultSetRowColumnData rowColumnData, String dateFormat) {

		try {
			Calendar calendar = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);

			if (rowColumnData != null && rowColumnData.getValue() != null) {
				calendar.setTime(sdf.parse(rowColumnData.getValue()));
				return calendar;
			}
		} catch (ParseException e) {
			logger.logError("ParseException in getCalendarRowDataValue, " + e);
			return null;
		} catch (Exception ex) {
			logger.logError("Exception in getCalendarRowDataValue, " + ex);
			return null;
		}
		return null;
	}

	public static Boolean getBooleanRowDataValue(IResultSetRowColumnData rowColumnData) {
		try {
			if (rowColumnData != null && rowColumnData.getValue() != null) {
				return Boolean.valueOf(rowColumnData.getValue());
			}
			return null;
		} catch (Exception e) {
			logger.logError(e);
			return null;
		}
	}

	public static Boolean getBooleanNumberRowDataValue(IResultSetRowColumnData rowColumnData) {
		try {
			if (rowColumnData != null && rowColumnData.getValue() != null) {
				return (Integer.valueOf(rowColumnData.getValue().trim())) != 0;
			}
			return null;
		} catch (NumberFormatException e) {
			logger.logError(e);
			return null;
		}
	}

	public static int getDataType(String parameter) {
		try {

			String[] arrayParameters = parameter.split("~");
			String dataTypeRequest = arrayParameters[1];

			if (dataTypeRequest.equalsIgnoreCase("I2")) {
				return ICTSTypes.SQLINT2;
			} else if (dataTypeRequest.equalsIgnoreCase("I4")) {
				return ICTSTypes.SQLINT4;
			} else if (dataTypeRequest.equalsIgnoreCase("D")) {
				return ICTSTypes.SQLDECIMAL;
			} else if (dataTypeRequest.equalsIgnoreCase("C")) {
				return ICTSTypes.SQLCHAR;
			} else {
				return ICTSTypes.SQLVARCHAR;
			}
		} catch (Exception e) {
			logger.logError(e);
			return 0;
		}
	}

	public static String getParameter(String parameter) {
		try {
			String[] arrayParameters = parameter.split("~");
			return arrayParameters[0];
		} catch (Exception e) {
			logger.logError(e);
			return null;
		}
	}

	public static IProcedureRequest setHeaderParams(IProcedureRequest wProcedureRequest) {

		Context wContext = ContextManager.getContext();

		if (wProcedureRequest != null) {
			wProcedureRequest.addFieldInHeader("isFormatterEnabled", ICOBISTS.HEADER_STRING_TYPE, "false");
			wProcedureRequest.addFieldInHeader("SPExecutorServiceFactoryFilter", ICOBISTS.HEADER_STRING_TYPE, "(service.impl=transactional)");
			CobisSession wSession = (CobisSession) wContext.getSession();
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getSession().getSessionId());
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_CONTEXT_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getContextId());
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_BACK_END_ID, ICOBISTS.HEADER_STRING_TYPE, wContext.getSession().getBackEndId());
			wProcedureRequest.addFieldInHeader(ICOBISTS.HEADER_TARGET_ID, ICOBISTS.HEADER_STRING_TYPE, "central");

			wProcedureRequest.addInputParam("@s_srv", ICTSTypes.SQLVARCHAR, wSession.getServer()); // "wSrv"
			wProcedureRequest.addInputParam("@s_lsrv", ICTSTypes.SQLVARCHAR, wSession.getServer()); // "wSrv"
			wProcedureRequest.addInputParam("@s_user ", ICTSTypes.SQLVARCHAR, wSession.getUser()); // "wUser"
			wProcedureRequest.addInputParam("@s_term", ICTSTypes.SQLVARCHAR, wSession.getTerminal()); // "wTerm"
			wProcedureRequest.addInputParam("@s_date", ICTSTypes.SQLDATETIME, wContext.getProcessDate()); // wDate
			wProcedureRequest.addInputParam("@s_sesn", ICTSTypes.SQLINT4, wContext.getSequencial()); // Integer.toString(sequentialTransaction)
			wProcedureRequest.addInputParam("@s_ssn", ICTSTypes.SQLINT4, wContext.getSequencial()); // Integer.toString(sequentialTransaction)
			wProcedureRequest.addInputParam("@s_ofi", ICTSTypes.SQLINT4, wSession.getOffice()); // "1"
			wProcedureRequest.addInputParam("@s_lsrv", ICTSTypes.SQLVARCHAR, wSession.getServer());
		}
		return wProcedureRequest;
	}

	public static ServiceResponseTO getErrorMessage(IProcedureResponse responseError, ServiceResponseTO serviceResponseTO) {
		serviceResponseTO.setSuccess(false);
		Collection<IMessageBlock> messages = responseError.getMessages();
		MessageTO newMessage;

		for (IMessageBlock message : messages) {
			newMessage = new MessageTO(message.getMessageText());
			newMessage.setCode(String.valueOf(message.getMessageNumber()));
			serviceResponseTO.addMessage(newMessage);
		}
		return serviceResponseTO;
	}

	public static void logErrorMessage(IProcedureResponse responseError) {
		Collection<IMessageBlock> messages = responseError.getMessages();
		for (IMessageBlock message : messages) {
			logger.logError(message.getMessageText());
		}
	}

	/**
	 * Permite añadir el registro si el valor es difrenete de NULL
	 * 
	 * @param iProcedureRequest
	 * @param field
	 * @param dataType
	 * @param value
	 */
	public static void validateRegistry(IProcedureRequest iProcedureRequest, String field, int dataType, Object value) {

		String valueParam = "";
		if (iProcedureRequest != null && field != null && value != null) {
			if (value instanceof String) {
				valueParam = value.toString();
			}
			iProcedureRequest.addInputParam(field.trim(), dataType, valueParam);
		}
	}
}
