package com.cobis.cloud.sofom.service.oxxo.dto;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import com.cobis.cloud.sofom.service.oxxo.utils.OxxoConstants;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(propOrder = { "idReverse", "amount", "auth", "account", "code", "errorDesc", "messageTicket" })
@XmlRootElement(name = "OLS")
public class OlsReversaResponse {

	// Datos de salida
	private String idReverse = "";
	private String amount = "";
	private String auth = "";
	private String account = "";
	private String code;
	private String errorDesc;
	private String messageTicket = "";

	@XmlAttribute(name = "version")
	private String version = OxxoConstants.VERSION;

	public String getIdReverse() {
		if (idReverse.length() == 0) {
			return null;
		} else {
			return idReverse;
		}
	}

	public void setIdReverse(String idReverse) {
		if (null == idReverse) {
			this.idReverse = "";
		} else {
			this.idReverse = idReverse;
		}
	}

	public String getAuth() {
		if (auth.length() == 0) {
			return null;
		} else {
			return auth;
		}
	}

	public void setAuth(String auth) {
		if (null == auth) {
			this.auth = "";
		} else {
			this.auth = auth;
		}
	}

	public String getAmount() {
		if (amount.length() == 0) {
			return null;
		} else {
			return amount;
		}
	}

	public void setAmount(String amount) {
		if (null == amount) {
			this.amount = "";
		} else {
			this.amount = amount;
		}
	}

	public String getAccount() {
		if (account.length() == 0) {
			return null;
		} else {
			return account;
		}
	}

	public void setAccount(String account) {
		if (null == account) {
			this.account = "";
		} else {
			this.account = account;
		}
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getErrorDesc() {
		return errorDesc;
	}

	public void setErrorDesc(String errorDesc) {
		this.errorDesc = errorDesc;
	}

	public String getMessageTicket() {
		if (messageTicket.length() == 0) {
			return null;
		} else {
			return messageTicket;
		}
	}

	public void setMessageTicket(String messageTicket) {
		if (null == messageTicket) {
			this.messageTicket = "";
		} else {
			this.messageTicket = messageTicket;
		}
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

}
