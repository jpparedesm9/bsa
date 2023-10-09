package com.cobis.cloud.sofom.service.oxxo.dto;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import com.cobis.cloud.sofom.service.oxxo.utils.OxxoConstants;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(propOrder = { "auth", "amount", "messageTicket", "account", "code", "errorDesc" })
@XmlRootElement(name = "OLS")
public class OlsPagoResponse {

	// Datos de Salida
	private String auth = "";
	private String amount = "";
	private String messageTicket = "";
	private String account = "";
	private String code;
	private String errorDesc;

	@XmlAttribute(name = "version")
	private String version = OxxoConstants.VERSION;

	public OlsPagoResponse() {
	}

	public OlsPagoResponse(String messageTicket, String account, String code, String errorDesc) {
		super();
		this.messageTicket = messageTicket;
		this.account = account;
		this.code = code;
		this.errorDesc = errorDesc;
	}

	public OlsPagoResponse(String code, String errorDesc) {
		super();
		this.code = code;
		this.errorDesc = errorDesc;
	}

	public String getErrorDesc() {
		return errorDesc;
	}

	public void setErrorDesc(String errorDesc) {
		this.errorDesc = errorDesc;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	@Override
	public String toString() {
		return "OlsPagoResponse [auth=" + auth + ", amount=" + amount + ", messageTicket=" + messageTicket + ", account=" + account + ", code=" + code + ", errorDesc=" + errorDesc
				+ "]";
	}

}
