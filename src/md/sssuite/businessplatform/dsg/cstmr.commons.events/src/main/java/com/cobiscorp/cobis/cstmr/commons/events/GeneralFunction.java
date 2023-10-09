package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;

public abstract class GeneralFunction {
	private static final ILogger LOGGER = LogFactory
			.getLogger(GeneralFunction.class);

	private GeneralFunction() {

	}

	public static Calendar convertDateToCalendar(Date date) {
		Calendar calendar = Calendar.getInstance();
		try {
			calendar.setTime(date);
		} catch (Exception ex) {
			LOGGER.logError(ex);
		}
		return calendar;
	}

	public static Date convertCalendarToDate(Calendar calendar) {
		Date date = null;

		try {
			date = calendar.getTime();
		} catch (Exception ex) {
			LOGGER.logError(ex);
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
			LOGGER.logError(ex);
		}
		return stringDate;
	}

	private static String getSpsMessages(List<Message> messages) {
		String messagesString = Parameter.EMPTY_VALUE;

		try {
			if (messages != null) {
				for (Message message : messages) {
					messagesString = messagesString.concat(" ").concat(
							message.getMessage());
				}
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(" MENSAJES: ".concat(messagesString));
				}
			}
		} catch (Exception ex) {
			LOGGER.logError(ex);
			messagesString = ex.getMessage();
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(messagesString);
		}
		return messagesString;
	}

	public static Boolean setMessage(List<String> listMessages,
			String stringMessage) {
		Boolean result = false;
		List<String> listMessagesIn = listMessages;
		try {
			if (!Parameter.EMPTY_VALUE.equals(stringMessage)) {
				if (listMessagesIn == null) {
					listMessagesIn = new ArrayList<String>();
				}

				listMessagesIn.add(stringMessage);
			}

			result = true;
		} catch (Exception ex) {
			LOGGER.logError("Dio un error inesperado");
			LOGGER.logError(ex);
		}

		return result;
	}

	private static String getValidationMessages(List<String> messages) {
		String messagesString = Parameter.EMPTY_VALUE;

		try {
			if (messages != null) {
				for (String message : messages) {
					messagesString = messagesString.concat(" ").concat(
							message.trim());
				}

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(" MENSAJES: " + messagesString);
				}
			}
		} catch (Exception ex) {
			LOGGER.logError(ex);
			messagesString = ex.getMessage();
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(messagesString);
		}

		return messagesString;
	}

	public static String getMessageError(List<Message> messages,
			List<String> listMessages) {
		String messageServer = getSpsMessages(messages).trim();
		String messageValidation = getValidationMessages(listMessages).trim();

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("messageServer:" + messageServer + "|");
			LOGGER.logDebug("messageValidation:" + messageValidation + "|");
		}

		if (!Parameter.EMPTY_VALUE.equals(messageServer))
			return messageServer;
		else
			return messageValidation;
	}

	public static void handleResponse(Object args, ServiceResponse response,
			String message) {
		try {
			if (message != null) {
				((ICommonEventArgs) args).getMessageManager().showSuccessMsg(
						message);

			} else {
				if (response != null && response.isResult()) {
					((ICommonEventArgs) args).setSuccess(true);
					// LA TRANSACCION SE REALIZO EXITOSAMENTE
					((ICommonEventArgs) args).getMessageManager()
							.showSuccessMsg("ASSTS.MSG_ASSTS_LATRANSLO_19347");
				} else {
					((ICommonEventArgs) args).setSuccess(false);
					if (response != null) {
						((ICommonEventArgs) args).getMessageManager()
								.showErrorMsg(
										getSpsMessages(response.getMessages()));
					} else {
						((ICommonEventArgs) args).getMessageManager()
								.showErrorMsg("Ocurrio un error inesperado.");
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug(" ERROR EN EJECUCION: ");
					}
				}
			}

		} catch (Exception ex) {
			LOGGER.logError(ex);
		}
	}

	public static Boolean writeResult(Map<String, Object> result, Object args) {
		Boolean resultado = false;

		String mensaje = GeneralFunction.getMessageError(
				(List<Message>) result.get(Parameter.MESSAGESERVERLIST),
				(List<String>) result.get(Parameter.MESSAGEVALIDATIONLIST));

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("INICIO EVENTO (writeResult)");
			LOGGER.logDebug(mensaje);
		}

		if (!Parameter.EMPTY_VALUE.equals(mensaje)) {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("antes");
			}

			((ICommonEventArgs) args).getMessageManager().showErrorMsg(mensaje);
		} else {
			resultado = true;
			mensaje = Parameter.SUCCESSFUL_TRANSACTION;

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("else");
				LOGGER.logDebug(mensaje);
			}

			if (((DataEntityList) result.get(Parameter.RESULTLIST)) != null
					&& ((DataEntityList) result.get(Parameter.RESULTLIST))
							.isEmpty()) {
				mensaje = Parameter.MISSING_RECORDS;
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("1-->");
			}

			if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("2-->");
				}

				((ICommonEventArgs) args).getMessageManager().showSuccessMsg(
						mensaje);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("3-->");
				}

			}
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("FIN EVENTO (writeResult)");
			LOGGER.logDebug(mensaje);
		}

		((ICommonEventArgs) args).setSuccess(resultado);
		return resultado;
	}

	public static Boolean writeResult(Map<String, Object> result,
			Parameter.TYPEEXECUTION typeExecution,
			ILoadCatalogDataEventArgs args) {
		Boolean resultado = false;

		String mensaje = GeneralFunction.getMessageError(
				(List<Message>) result.get(Parameter.MESSAGESERVERLIST),
				(List<String>) result.get(Parameter.MESSAGEVALIDATIONLIST));

		if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
			args.getMessageManager().showErrorMsg(mensaje);
		} else {
			resultado = true;
			if (typeExecution != Parameter.TYPEEXECUTION.SEARCH) {
				mensaje = Parameter.SUCCESSFUL_TRANSACTION;
			}

			if (((DataEntityList) result.get(Parameter.RESULTLIST)).isEmpty()) {
				mensaje = Parameter.MISSING_RECORDS;
			}

			if (!Parameter.EMPTY_VALUE.equals(mensaje)) {
				args.getMessageManager().showSuccessMsg(mensaje);
			}
		}

		((ICommonEventArgs) args).setSuccess(resultado);
		return resultado;
	}

	public static Boolean evalueResponse(ServiceResponse response,
			Map<String, Object> result) {
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

	public static void writeLog(ILogger LOGGER, Object message,
			Parameter.LEVELDEBUG level) {
		if (LOGGER.isDebugEnabled()) {
			switch (level) {
			case DEBUG:
				LOGGER.logDebug(message);
				break;
			case ERROR:
				LOGGER.logError(message);
				break;
			default:
				LOGGER.logInfo(message);
				break;
			}
		}
	}
}
