package com.cobiscorp.cobis.busin.flcre.commons.dto;

import com.cobiscorp.designer.common.MessageLevel;

public class BehaviorOption {
	private boolean showMessage;
	private boolean successFalse;
	private boolean showMessageException;
	private int codeException;
	private MessageLevel level;

	public BehaviorOption() {
		this(true, false, MessageLevel.ERROR, true, 0);
	}

	public BehaviorOption(boolean putSuccess) {
		this(true, putSuccess, MessageLevel.ERROR, true, 0);
	}

	public BehaviorOption(boolean showMessage, boolean putSuccess) {
		this(showMessage, putSuccess, MessageLevel.ERROR, true, 0);
	}

	public BehaviorOption(boolean showMessage, boolean putSuccess, MessageLevel level) {
		this(showMessage, putSuccess, level, true, 0);
	}

	public BehaviorOption(boolean showMessage, boolean putSuccess, MessageLevel level, boolean showMessageException) {
		this(showMessage, putSuccess, level, showMessageException, 0);
	}

	public BehaviorOption(boolean showMessage, boolean putSuccess, MessageLevel level, boolean showMessageException, int codeException) {
		this.showMessage = showMessage;
		this.successFalse = putSuccess;
		this.level = level;
		this.showMessageException = showMessageException;
		this.codeException = codeException;
	}

	public boolean showMessage() {
		return showMessage;
	}

	public void setShowMessage(boolean arg) {
		this.showMessage = arg;
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

	public boolean showMessageException() {
		return showMessageException;
	}

	public void setShowMessageException(boolean showMessageException) {
		this.showMessageException = showMessageException;
	}

	public int getCodeException() {
		return codeException;
	}

	public void setCodeException(int codeException) {
		this.codeException = codeException;
	}

}
