package com.cobis.cloud.sofom.service.oxxo.dto;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import com.cobis.cloud.sofom.service.oxxo.utils.OxxoConstants;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "account", "name", "address", "status", "reference", "partial", "concepts", "code", "message" })
@XmlRootElement(name = "OLS")
public class OlsConsultaResponse {

	// Datos de Salida
	private String account = "";
	private String name = "";
	private String address = "";
	private String status = "";
	private String reference = "";
	private String partial = "";

	@XmlElementWrapper(name = "concepts", required = true)
	@XmlElement(name = "concept")
	private List<Concept> concepts = new ArrayList<Concept>();

	private String code;
	private String message;

	@XmlAttribute(name = "version")
	private String version = OxxoConstants.VERSION;

	public List<Concept> getConcepts() {
		if (concepts.isEmpty()) {
			return new ArrayList<Concept>();
		} else {
			return concepts;
		}
	}

	public void setConcepts(List<Concept> concepts) {
		if (null == concepts) {
			this.concepts = new ArrayList<Concept>();
		} else {
			this.concepts = concepts;
		}
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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

	public String getName() {
		if (name.length() == 0) {
			return null;
		} else {
			return name;
		}
	}

	public void setName(String name) {
		if (null == name) {
			this.name = "";
		} else {
			this.name = name;
		}
	}

	public String getAddress() {
		if (address.length() == 0) {
			return null;
		} else {
			return address;
		}
	}

	public void setAddress(String address) {
		if (null == address) {
			this.address = "";
		} else {
			this.address = address;
		}
	}

	public String getStatus() {
		if (status.length() == 0) {
			return null;
		} else {
			return status;
		}
	}

	public void setStatus(String status) {
		if (null == status) {
			this.status = "";
		} else {
			this.status = status;
		}
	}

	public String getReference() {
		if (reference.length() == 0) {
			return null;
		} else {
			return reference;
		}
	}

	public void setReference(String reference) {
		if (null == reference) {
			this.reference = "";
		} else {
			this.reference = reference;
		}
	}

	public String getPartial() {
		if (partial.length() == 0) {
			return null;
		} else {
			return partial;
		}
	}

	public void setPartial(String partial) {
		if (null == partial) {
			this.partial = "";
		} else {
			this.partial = partial;
		}
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	@Override
	public String toString() {
		return "OlsConsultaResponse [account=" + account + ", name=" + name + ", address=" + address + ", status=" + status + ", reference=" + reference + ", partial=" + partial
				+ ", concepts=" + concepts + ", code=" + code + ", message=" + message + "]";
	}

}
