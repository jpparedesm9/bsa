package com.cobiscorp.cobis.notifier.dispatcher.sms.dto;

import java.util.List;

public class SmsResponse {

	private TemplateSms templateSms;
	private List<DataSms> dataSms;

	public TemplateSms getTemplateSms() {
		return templateSms;
	}

	public void setTemplateSms(TemplateSms templateSms) {
		this.templateSms = templateSms;
	}

	public List<DataSms> getDataSms() {
		return dataSms;
	}

	public void setDataSms(List<DataSms> dataSms) {
		this.dataSms = dataSms;
	}

	@Override
	public String toString() {
		return "SmsRequest [templateSms=" + templateSms + ", dataSms=" + dataSms + "]";
	}

}
