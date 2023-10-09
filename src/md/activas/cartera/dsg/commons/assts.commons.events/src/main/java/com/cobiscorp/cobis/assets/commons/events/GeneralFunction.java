package com.cobiscorp.cobis.assets.commons.events;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;

public abstract class GeneralFunction {
	private static final ILogger logger = LogFactory.getLogger(GeneralFunction.class);

	private GeneralFunction() {

	}

	public static Calendar convertDateToCalendar(Date date) {
		Calendar calendar = Calendar.getInstance();

		try {
			if (date == null) {
				return null;
			}
			calendar.setTime(date);
		} catch (Exception ex) {
			logger.logError(ex);
		}
		return calendar;
	}

	public static Date convertCalendarToDate(Calendar calendar) {
		Date date = null;

		try {
			date = calendar.getTime();
		} catch (Exception ex) {
			logger.logError(ex);
		}
		return date;
	}

	public static String convertDateToString(Date date, boolean isServer) {
		String stringDate = Parameter.EMPTY_VALUE;
		SimpleDateFormat formatDate;

		try {
			if (isServer) {
				formatDate = new SimpleDateFormat(Parameter.DATEFORMATDB);
			} else {
				formatDate = new SimpleDateFormat(Parameter.DATEFORMAT);
			}
			stringDate = formatDate.format(date);
		} catch (Exception ex) {
			logger.logError(ex);
		}
		return stringDate;
	}

	public static Date convertStringToDate(String stringDate, Parameter.TYPEDATEFORMAT typeDateFormat) {

		Date date = null;
		SimpleDateFormat formatDate;

		try {
			switch (typeDateFormat) {
			case DDMMYYYY:
				formatDate = new SimpleDateFormat(Parameter.DATEFORMAT);
				break;
			case YYYYMMDD:
				formatDate = new SimpleDateFormat(Parameter.DATEFORMATDB);
				break;
			case MMDDYYYY:
			default:
				formatDate = new SimpleDateFormat(Parameter.DATEFORMATMMDDYYYY);
				break;
			}

			date = stringDate == null || "".equals(stringDate.trim()) ? null : formatDate.parse(stringDate);
		} catch (Exception ex) {
			logger.logError(ex);
		}
		return date;
	}

	public static int getDays(Date startDate, Date endDate) {
		long difference;
		double days = 0;

		try {
			difference = startDate.getTime() - endDate.getTime();
			days = Math.floor((double) difference / 86400000L);
		} catch (Exception ex) {
			logger.logError(ex);
		}
		return (int) days;
	}

	public static Date getDate(Date startDate, int days) {

		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(startDate);
			calendar.add(Calendar.DAY_OF_YEAR, days);
		} catch (Exception ex) {
			logger.logError(ex);
		}
		return calendar.getTime();
	}

	public static Date maxDate(Date startDate, int year) {
		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(startDate);
			calendar.add(Calendar.YEAR, year);
		} catch (Exception ex) {
			logger.logError(ex);
		}

		return calendar.getTime();
	}

	public static String getSpsMessages(List<Message> messages) {
		String messagesString = Parameter.EMPTY_VALUE;
		// StringBuilder messagesString = new
		// StringBuilder(Parameter.EMPTY_VALUE)

		try {
			if (messages != null) {
				for (Message message : messages) {
					messagesString = messagesString.concat(" ").concat(message.getMessage());
				}
				if (logger.isDebugEnabled()) {
					logger.logDebug(" MENSAJES: ".concat(messagesString));
				}
			}
		} catch (Exception ex) {
			logger.logError(ex);
			messagesString = ex.getMessage();
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug(messagesString);
		}
		return messagesString;
	}

	public static Boolean setMessage(List<String> listMessages, String stringMessage) {
		Boolean result = false;
		List<String> listMessagesIn = listMessages;
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Ingreso al setMessage");
			}

			if (!Parameter.EMPTY_VALUE.equals(stringMessage)) {
				if (listMessagesIn == null) {
					listMessagesIn = new ArrayList<String>();
				}

				listMessagesIn.add(stringMessage);
			}

			result = true;
		} catch (Exception ex) {
			logger.logError("Dio un error inesperado");
			logger.logError(ex);
		}

		return result;
	}

	private static String getValidationMessages(List<String> messages) {
		String messagesString = Parameter.EMPTY_VALUE;

		try {
			if (messages != null) {
				for (String message : messages) {
					messagesString = messagesString.concat(" ").concat(message.trim());
				}

				if (logger.isDebugEnabled()) {
					logger.logDebug(" MENSAJES: " + messagesString);
				}
			}
		} catch (Exception ex) {
			logger.logError(ex);
			messagesString = ex.getMessage();
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug(messagesString);
		}

		return messagesString;
	}

	public static String getMessageError(List<Message> messages, List<String> listMessages) {
		String messageServer = getSpsMessages(messages).trim();
		String messageValidation = getValidationMessages(listMessages).trim();

		if (logger.isDebugEnabled()) {
			logger.logDebug("messageServer:" + messageServer + "|");
			logger.logDebug("messageValidation:" + messageValidation + "|");
		}

		if (!Parameter.EMPTY_VALUE.equals(messageServer))
			return messageServer;
		else
			return messageValidation;
	}

	public static void handleResponse(Object args, ServiceResponse response, String message) {
		try {
			if (message != null) {
				((ICommonEventArgs) args).getMessageManager().showSuccessMsg(message);

			} else {
				if (response != null && response.isResult()) {
					((ICommonEventArgs) args).setSuccess(true);
					// LA TRANSACCION SE REALIZO EXITOSAMENTE
					((ICommonEventArgs) args).getMessageManager().showSuccessMsg("ASSTS.MSG_ASSTS_LATRANSLO_19347");
				} else {
					((ICommonEventArgs) args).setSuccess(false);
					if (response != null) {
						((ICommonEventArgs) args).getMessageManager().showErrorMsg(getSpsMessages(response.getMessages()));
					} else {
						((ICommonEventArgs) args).getMessageManager().showErrorMsg("Ocurrio un error inesperado.");
					}
					if (logger.isDebugEnabled()) {
						logger.logDebug(" ERROR EN EJECUCION: ");
					}
				}
			}

		} catch (Exception ex) {
			logger.logError(ex);
		}
	}

	public static Boolean writeResult(Map<String, Object> result, Parameter.TYPEEXECUTION typeExecution, Object args) {
		Boolean resultado = false;

		String mensaje = GeneralFunction.getMessageError((List<Message>) result.get(Parameter.MESSAGESERVERLIST), (List<String>) result.get(Parameter.MESSAGEVALIDATIONLIST));

		if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
			((ICommonEventArgs) args).getMessageManager().showErrorMsg(mensaje);
		} else {
			resultado = true;
			if (typeExecution != Parameter.TYPEEXECUTION.SEARCH) {
				mensaje = Parameter.SUCCESSFUL_TRANSACTION;
			}

			if (((DataEntityList) result.get(Parameter.RESULTLIST)).isEmpty()) {
				mensaje = Parameter.MISSING_RECORDS;
			}

			if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
				((ICommonEventArgs) args).getMessageManager().showSuccessMsg(mensaje);
			}
		}

		((ICommonEventArgs) args).setSuccess(resultado);
		return resultado;
	}

	public static Boolean evalueResponse(ServiceResponse response, Map<String, Object> result) {
		Boolean resultado = true;
		if (response != null && response.isResult()) {
			result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
		} else {
			if (response != null) {
				result.put(Parameter.MESSAGESERVERLIST, response.getMessages());
			} else {
				resultado = false;
			}
		}
		return resultado;
	}

	public static void writeLog(ILogger logger, Object message, Parameter.LEVELDEBUG level) {
		if (logger.isDebugEnabled()) {
			switch (level) {
			case DEBUG:
				logger.logDebug(message);
				break;
			case ERROR:
				logger.logError(message);
				break;
			default:
				logger.logInfo(message);
				break;
			}
		}
	}

	public static Calendar DateToCalendar(Date date) {
		Calendar cal = null;
		try {
			DateFormat formatter = new SimpleDateFormat(Parameter.DATEFORMATMMDDYYYY);
			date = (Date) formatter.parse(date.toString());
			cal = Calendar.getInstance();
			cal.setTime(date);
		} catch (Exception e) {
			logger.logError("Exception: ",e);
		}
		return cal;
	}
}
