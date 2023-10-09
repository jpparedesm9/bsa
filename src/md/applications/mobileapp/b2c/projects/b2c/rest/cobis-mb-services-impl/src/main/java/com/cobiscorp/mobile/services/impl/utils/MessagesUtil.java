/**
 * 
 */
package com.cobiscorp.mobile.services.impl.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.regex.Pattern;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.model.BaseRequest;
import com.cobiscorp.mobile.model.BaseResponse;
import com.cobiscorp.mobile.model.Message;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

/**
 * @author fespinosa
 * 
 */
public class MessagesUtil {
	private static final String MSG_CODE_ERROR = "Mensaje de error codigo: ";
	/** Logger. */
	private static ILogger logger = LogFactory.getLogger(MessagesUtil.class);

	private static Map<String, ResourceBundle> resourceBundleMap = new HashMap<String, ResourceBundle>();

	public static String getMessage(String language, String code) {
		if (language == null) {
			language = Constants.LANG_ES_EC;
			logger.logInfo("No se indico la cultura en la petición enviada. Se toma la cultura por default ES-EC");
		}

		ResourceBundle resourceBundle = resourceBundleMap.get(language);
		if (resourceBundle == null && language.equals(Constants.LANG_ES_EC)) {
			language = "es";
			resourceBundle = resourceBundleMap.get(language);
		}
		if (resourceBundle == null && language.equals(Constants.LANG_EN_US)) {
			language = "en";
			resourceBundle = resourceBundleMap.get(language);
		}

		if (resourceBundle == null) {
			resourceBundle = ResourceBundle.getBundle("messages", new Locale(language), MessagesUtil.class.getClassLoader());
			resourceBundleMap.put(language, resourceBundle);
			logger.logInfo("Lenguage establecido: " + language);
		}

		try {
			return resourceBundle.getString(code);
		} catch (Exception e) {
			logger.logError(e);
			logger.logInfo("No existe un mensaje asociado al código " + code + ". Se envia el codigo: " + Constants.ERROR_MB_DEFAULT);
			return resourceBundle.getString(Constants.ERROR_MB_DEFAULT);
		}
	}

	public static void logMessages(Message message) {
		if (message != null && message.getMessage() != null) {
			logger.logInfo(MSG_CODE_ERROR + message.getCode() + " : " + message.getMessage());
		}
	}

	public static void logMessages(MessageTO[] messages) {
		if (messages != null) {
			for (MessageTO message : messages) {

				if (message != null) {
					logger.logInfo(MSG_CODE_ERROR + message.getCode() + " : " + message.getMessage());
				}
			}
		}
	}

	public static String getFirstCodeMessage(MessageTO[] messages) {
		if (messages != null && messages.length > 0) {
			return messages[0].getCode();
		}
		return null;
	}

	public static Map<String, String> getMessages(MessageTO[] messages) {
		if (messages != null) {
			for (MessageTO message : messages) {

				if (message != null) {

					logger.logInfo(MSG_CODE_ERROR + message.getCode() + " : " + message.getMessage());
				}
			}
		}
		return null;
	}

	public static String getMessageCode(String message) {
		if (message.indexOf('[') != -1 && message.indexOf(']') != -1) {
			return message.substring(message.indexOf('[') + 1, message.indexOf(']'));
		}
		return Constants.ERROR_MB_UNKNOWN;
	}

	public static String getMessageMessage(String message) {
		int indexSplit = message.lastIndexOf(']');
		if (indexSplit != -1) {
			if (indexSplit < message.length()) {
				indexSplit++;
			} else {
				return getMessage(Constants.LANG_ES_EC, Constants.ERROR_MB_UNKNOWN);
			}
			return message.substring(indexSplit, message.length());
		} else {
			return getMessage(Constants.LANG_ES_EC, "MB_ERR_000004");
		}
	}

	@SuppressWarnings("unchecked")
	public static Message getMessage(ServiceResponseTO responseTO, String language) {
		List<MessageTO> messages = responseTO.getMessages();
		Message message = null;
		for (MessageTO msg : messages) {
			logger.logDebug(msg.getCode() + " - " + msg.getMessage());
			String[] substrings = msg.getMessage().split(Pattern.quote("["));
			if (substrings.length > 1) {
				msg.setCode(substrings[1].substring(0, substrings[1].indexOf(']')));
				logger.logDebug("Codigo real de sp: " + msg.getCode());
			}
			if (!"0".equals(msg.getCode()) && message == null) {
				message = new Message();
				message.setCode(msg.getCode());
				message.setMessage(getMessage(language, msg.getCode()));
			}
		}
		return message;
	}

	public static void manageException(Exception e, BaseRequest request, BaseResponse response) {
		String methodName = e.getStackTrace()[0].getMethodName();
		if (logger.isDebugEnabled()) {
			logger.logDebug("Expception en metodo " + methodName);
		}
		logger.logError(e, e);
		response.setSuccess(false);
		Message messageResponse = new Message();
		messageResponse.setCode(Constants.ERROR_MB_SERVICE_NOT_AVAILABLE);
		messageResponse.setMessage(MessagesUtil.getMessage(request.getCulture(), Constants.ERROR_MB_SERVICE_NOT_AVAILABLE));
		response.setMessage(messageResponse);
	}

	/**
	 * Permite administrar mensajes que provinen desde los servicios *
	 * 
	 * @param responseService
	 * @param request
	 * @param response
	 */
	public static void manageMessagesServices(ServiceResponseTO responseTO, BaseRequest request, BaseResponse response) {
		response.setSuccess(false);
		Message messageResponse = MessagesUtil.getMessage(responseTO, request.getCulture());
		response.setMessage(messageResponse);
		MessagesUtil.logMessages(messageResponse);
	}
}
