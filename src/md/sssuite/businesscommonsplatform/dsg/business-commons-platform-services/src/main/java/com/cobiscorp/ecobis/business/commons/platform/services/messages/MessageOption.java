package com.cobiscorp.ecobis.business.commons.platform.services.messages;

import com.cobiscorp.designer.common.MessageLevel;

public class MessageOption {
	private boolean successFalse;
	private String resourceCode;
	private MessageLevel level;

	public MessageOption(String resourceCode) {
		this(resourceCode, MessageLevel.SUCCESS, false);
	}

	public MessageOption(String resourceCode, MessageLevel level) {
		this(resourceCode, level, false);
	}

	public MessageOption(String resourceCode, MessageLevel level, boolean putSuccess) {
		this.successFalse = putSuccess;
		this.level = level;
		this.resourceCode = resourceCode;
	}

	public MessageLevel getLevel() {
		return level;
	}

	public void setLevel(MessageLevel level) {
		this.level = level;
	}

	public boolean isSuccessFalse() {
		return successFalse;
	}

	public void setSuccessFalse(boolean successFalse) {
		this.successFalse = successFalse;
	}

	public String getResourceCode() {
		return resourceCode;
	}

	public void setResourceCode(String resourceCode) {
		this.resourceCode = resourceCode;
	}

}
