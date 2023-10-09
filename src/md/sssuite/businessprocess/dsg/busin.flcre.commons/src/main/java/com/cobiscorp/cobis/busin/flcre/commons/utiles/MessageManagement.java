package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import java.util.ArrayList;
import java.util.List;
import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.MessageLevel;

public class MessageManagement {

	public static void show(ServiceResponse serviceResponse, ICommonEventArgs args, BehaviorOption options) {
		if (options.showMessage() && serviceResponse.getMessages() != null) {
			for (Message message : serviceResponse.getMessages()) {
				args.getMessageManager().showMessage(options.getLevel(), Integer.parseInt(message.getCode()), message.getMessage(), null, true);
			}
		}
		if (options.isSuccessFalse())
			args.setSuccess(false);
	}

	@SuppressWarnings("unchecked")
	public static void show(ServiceResponseTO serviceResponse, ICommonEventArgs args, BehaviorOption options) {
		if (options.showMessage() && serviceResponse.getMessages() != null) {
			List<MessageTO> errorMessages = new ArrayList<MessageTO>();
			errorMessages = serviceResponse.getMessages();
			for (MessageTO message : errorMessages) {
				args.getMessageManager().showMessage(options.getLevel(), Integer.parseInt(message.getCode()), message.getMessage(), null, true);
			}
		}
		if (options.isSuccessFalse())
			args.setSuccess(false);
	}

	public static void show(ICommonEventArgs args, MessageOption options) {
		if (options.getLevel().equals(MessageLevel.ERROR)) {
			args.getMessageManager().showErrorMsg(options.getResourceCode());
		} else if (options.getLevel().equals(MessageLevel.SUCCESS)) {
			args.getMessageManager().showSuccessMsg(options.getResourceCode());
		} else if (options.getLevel().equals(MessageLevel.INFO)) {
			args.getMessageManager().showInfoMsg(options.getResourceCode());
		}
		if (options.isSuccessFalse())
			args.setSuccess(false);
	}
	
	public String raiseException(ServiceResponse serviceResponse) {
		if (serviceResponse != null && serviceResponse.getMessages() != null) {
			StringBuffer errors = new StringBuffer();
			for (Message message : serviceResponse.getMessages()) {
				errors.append("Error ");
				errors.append(message.getCode());
				errors.append(": ");
				errors.append(message.getMessage());
				errors.append("\n");
			}
			return errors.toString();
		}
		return "";
	}
}
