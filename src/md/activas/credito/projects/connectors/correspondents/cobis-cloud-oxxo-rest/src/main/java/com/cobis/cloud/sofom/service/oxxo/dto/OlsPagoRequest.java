package com.cobis.cloud.sofom.service.oxxo.dto;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import com.cobis.cloud.sofom.service.oxxo.anotations.DataType;
import com.cobis.cloud.sofom.service.oxxo.anotations.OxxoValidation;

@XmlRootElement(name = "OLS")
@XmlType(propOrder = { "token", "client", "tranDate", "cashMachine", "entryMode", "cashierId", "ticket", "account", "amount", "folio", "adminDate", "store", "partial" })
public class OlsPagoRequest {

	// Datos de Entrada
	//Validaciones Requerido, tipo de dato, dimension
	//@OxxoValidation(required = true, dataType = DataType.ALFANUMERICO_NUMERICO_ESPECIAL, maxlength = 15)
	private String token;
	@OxxoValidation(required = true, dataType = DataType.ALFANUMERICO_NUMERICO_ESPECIAL, maxlength = 37)
	private String client;
	@OxxoValidation(required = true, dataType = DataType.NUMERICO, maxlength = 14, date = true)
	private String tranDate;
	@OxxoValidation(required = false, dataType = DataType.NUMERICO, maxlength = 2)
	private int cashMachine;
	@OxxoValidation(required = false, dataType = DataType.ALFANUMERICO, maxlength = 3)
	private String entryMode;
	@OxxoValidation(required = false, dataType = DataType.ALFANUMERICO, maxlength = 13)
	private String cashierId;
	@OxxoValidation(required = true, dataType = DataType.NUMERICO, maxlength = 10)
	private int ticket;
	@OxxoValidation(required = false, dataType = DataType.ALFANUMERICO_NUMERICO_ESPECIAL, maxlength = 30)
	private String account;
	@OxxoValidation(required = true, dataType = DataType.NUMERICO, maxlength = 12)
	private String amount;
	@OxxoValidation(required = true, dataType = DataType.NUMERICO, maxlength = 10)
	private String folio;
	@OxxoValidation(required = true, dataType = DataType.NUMERICO, maxlength = 8)
	private String adminDate;
	@OxxoValidation(required = true, dataType = DataType.ALFANUMERICO, maxlength = 10)
	private String store;
	@OxxoValidation(required = true, dataType = DataType.ALFANUMERICO, maxlength = 1)
	private String partial;

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getTranDate() {
		return tranDate;
	}

	public void setTranDate(String tranDate) {
		this.tranDate = tranDate;
	}

	public int getCashMachine() {
		return cashMachine;
	}

	public void setCashMachine(int cashMachine) {
		this.cashMachine = cashMachine;
	}

	public String getEntryMode() {
		return entryMode;
	}

	public void setEntryMode(String entryMode) {
		this.entryMode = entryMode;
	}

	public String getCashierId() {
		return cashierId;
	}

	public void setCashierId(String cashierId) {
		this.cashierId = cashierId;
	}

	public int getTicket() {
		return ticket;
	}

	public void setTicket(int ticket) {
		this.ticket = ticket;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getFolio() {
		return folio;
	}

	public void setFolio(String folio) {
		this.folio = folio;
	}

	public String getAdminDate() {
		return adminDate;
	}

	public void setAdminDate(String adminDate) {
		this.adminDate = adminDate;
	}

	public String getStore() {
		return store;
	}

	public void setStore(String store) {
		this.store = store;
	}

	public String getPartial() {
		return partial;
	}

	public void setPartial(String partial) {
		this.partial = partial;
	}

	@Override
	public String toString() {
		return "OlsPagoRequest [token=" + token + ", client=" + client + ", tranDate=" + tranDate + ", cashMachine=" + cashMachine + ", entryMode=" + entryMode + ", cashierId="
				+ cashierId + ", ticket=" + ticket + ", account=" + account + ", amount=" + amount + ", folio=" + folio + ", adminDate=" + adminDate + ", store=" + store
				+ ", partial=" + partial + "]";
	}

}
