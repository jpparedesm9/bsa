package com.cobiscorp.cobis.wrrnt.commons.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;

public class Function {
	private static final ILogger logger = LogFactory
			.getLogger(Function.class);

	private Function() {

	}



	private static String getSpsMessages(List<Message> messages) {
		String messagesString = Constant.VALUEEMPTY;
		// StringBuilder messagesString = new
		// StringBuilder(Parameter.EMPTY_VALUE)

		try {
			if (messages != null) {
				for (Message message : messages) {
					messagesString = messagesString.concat(" ").concat(
							message.getMessage());
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
							.showSuccessMsg("WRRNT.LBL_WRRNT_LATRANSAI_60445");
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
					if (logger.isDebugEnabled()) {
						logger.logDebug(" ERROR EN EJECUCION: ");
					}
				}
			}

		} catch (Exception ex) {
			logger.logError(ex);
		}
	}


	public static Date convertStringToFullDate(String stringDate, String format) {
		Date date = null;
		SimpleDateFormat formatDate;

		try {
				formatDate = new SimpleDateFormat(format);
				date = formatDate.parse(stringDate);
			
		} catch (Exception ex) {
			logger.logError("ERROR: ",ex);
		}
			
		return date;
	}


	
	public static Calendar dateToCalendar(Date date){ 
		  Calendar calendar = Calendar.getInstance();
		  calendar.setTime(date);
		  return calendar;
		}

}
