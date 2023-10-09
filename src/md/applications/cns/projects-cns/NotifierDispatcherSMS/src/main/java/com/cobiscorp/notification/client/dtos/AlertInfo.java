package com.cobiscorp.notification.client.dtos;

import java.util.ArrayList;
import java.util.List;

public class AlertInfo {
	private PartyKey partyKeys;
	private CardKey cardKeys;
	private AcctKey acctKeys;
	private String alertScheduleDt;
	private DeliveryInstruction deliveryInstruction;
	private String alertIdTemplate;
	private int idEvent;
	private String alertMsg;
	private PhoneNum phoneNum;
	private List<AlertData> alertData;
	
	public AlertInfo(){
		partyKeys = new PartyKey();
		cardKeys = new CardKey();
		acctKeys = new AcctKey();
		deliveryInstruction =new DeliveryInstruction();
		phoneNum=new PhoneNum();
		alertData = new ArrayList<AlertData>();
	}

	public PartyKey getPartyKeys() {
		return partyKeys;
	}

	public void setPartyKeys(PartyKey partyKeys) {
		this.partyKeys = partyKeys;
	}

	public CardKey getCardKeys() {
		return cardKeys;
	}

	public void setCardKeys(CardKey cardKeys) {
		this.cardKeys = cardKeys;
	}

	public AcctKey getAcctKeys() {
		return acctKeys;
	}

	public void setAcctKeys(AcctKey acctKeys) {
		this.acctKeys = acctKeys;
	}

	public String getAlertScheduleDt() {
		return alertScheduleDt;
	}

	public void setAlertScheduleDt(String alertScheduleDt) {
		this.alertScheduleDt = alertScheduleDt;
	}

	public DeliveryInstruction getDeliveryInstruction() {
		return deliveryInstruction;
	}

	public void setDeliveryInstruction(DeliveryInstruction deliveryInstruction) {
		this.deliveryInstruction = deliveryInstruction;
	}

	public String getAlertIdTemplate() {
		return alertIdTemplate;
	}

	public void setAlertIdTemplate(String alertIdTemplate) {
		this.alertIdTemplate = alertIdTemplate;
	}

	public int getIdEvent() {
		return idEvent;
	}

	public void setIdEvent(int idEvent) {
		this.idEvent = idEvent;
	}

	public String getAlertMsg() {
		return alertMsg;
	}

	public void setAlertMsg(String alertMsg) {
		this.alertMsg = alertMsg;
	}

	public PhoneNum getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(PhoneNum phoneNum) {
		this.phoneNum = phoneNum;
	}

	public List<AlertData> getAlertData() {
		return alertData;
	}

	public void setAlertData(List<AlertData> alertData) {
		this.alertData = alertData;
	}
	
	
	
}
