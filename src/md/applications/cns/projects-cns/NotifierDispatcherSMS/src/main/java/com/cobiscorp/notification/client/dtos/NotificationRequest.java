package com.cobiscorp.notification.client.dtos;

import java.text.SimpleDateFormat;
import java.util.Date;

public class NotificationRequest {
	private AlertInfo alertInfo;

	private static final SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy kk:mm:ss");

	public NotificationRequest(String partyIdMask, String partyId, String cardNum, String acctId) throws Exception {
		if (!hasValue(partyIdMask) && !hasValue(partyId) && !hasValue(cardNum) && !hasValue(acctId)) {
			throw new Exception("Se debe proporcionar uno de los valores partyIdMask,partyId,cardNum,acctId");
		}
		alertInfo = new AlertInfo();
		alertInfo.getPartyKeys().setPartyId(partyId);
		alertInfo.getPartyKeys().setPartyIdMask(partyIdMask);
		alertInfo.getCardKeys().setCardNum(cardNum);
		alertInfo.getAcctKeys().setAcctId(acctId);
		alertInfo.getDeliveryInstruction().setDeliveryMethod(1);
	}

	private boolean hasValue(String value) {
		if (value != null && !value.trim().isEmpty()) {
			return true;
		}
		return false;
	}

	public void setAlertScheduleDt(Date date) {
		String alertScheduleDt = sdf.format(date);
		alertInfo.setAlertScheduleDt(alertScheduleDt);
	}

	/*
	 * public void setDeliveryInstruction(int deliveryMethod){
	 * alertInfo.getDeliveryInstruction().setDeliveryMethod(deliveryMethod); }
	 */
	public void setAlertIdTemplate(String alertIdTemplate) {
		alertInfo.setAlertIdTemplate(alertIdTemplate);
	}

	public void setIdEvent(int idEvent) {
		alertInfo.setIdEvent(idEvent);
	}

	public void setAlertMsg(String alertMsg) {
		alertInfo.setAlertMsg(alertMsg);
	}

	public void sePhoneNum(String phone) {
		alertInfo.getPhoneNum().setPhone(phone);
	}

	public void addAlertData(String key, String value, String type) {
		AlertData alertData = new AlertData();
		alertData.setAlertDataKey(key);
		alertData.setAlertDataValue(value);
		alertData.setAlertDataType(type);
		alertInfo.getAlertData().add(alertData);
	}

	public AlertInfo getAlertInfo() {
		return alertInfo;
	}

	public void setAlertInfo(AlertInfo alertInfo) {
		this.alertInfo = alertInfo;
	}

}
