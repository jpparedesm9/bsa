package com.cobiscorp.cobis.notifier.dispatcher.sms.settings;

public class DefaultSenderSettings {

	private String originatingMsisdn;
	private boolean alwaysOverrideEnabled;

	public String getOriginatingMsisdn() {
		return originatingMsisdn;
	}

	public void setOriginatingMsisdn(String originatingMsisdn) {
		this.originatingMsisdn = originatingMsisdn;
	}

	public boolean isAlwaysOverrideEnabled() {
		return alwaysOverrideEnabled;
	}

	public void setAlwaysOverrideEnabled(boolean alwaysOverrideEnabled) {
		this.alwaysOverrideEnabled = alwaysOverrideEnabled;
	}

	@Override
	public String toString() {
		return "DefaultSenderSettings [originatingMsisdn=" + originatingMsisdn + ", alwaysOverrideEnabled="
				+ alwaysOverrideEnabled + "]";
	}
	

}
