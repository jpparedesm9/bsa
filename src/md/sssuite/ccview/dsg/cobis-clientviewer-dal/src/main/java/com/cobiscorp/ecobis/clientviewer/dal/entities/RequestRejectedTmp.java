package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@IdClass(RequestRejectedTmpId.class)
@Table(name = "cr_soli_rechazadas_tmp", schema = "cob_credito")
@NamedQueries({ 
		@NamedQuery(name = "RequestRejectedTmp.getRequestRejected", query = "select new com.cobiscorp.ecobis.clientviewer.dto.RequestRejectedTmpDTO(r.numberIdentifier, r.operationNumber, r.dateLoad, r.dateRejected, r.reason, r.user, r.module) from RequestRejectedTmp r where r.spidReqReject = :spid   ORDER BY r.dateRejected DESC")
		})
public class RequestRejectedTmp {

	@Id
	@Column(name = "spid")
	private Integer spidReqReject;

	@Id
	@Column(name = "numero_id")
	private String numberIdentifier;

	@Id
	@Column(name = "numero_operacion")
	private String operationNumber;

	@Column(name = "fecha_carga")
	private String dateLoad;

	@Column(name = "fecha_rechazo")
	private String dateRejected;

	@Column(name = "motivo")
	private String reason;

	@Column(name = "usuario")
	private String user;
	
	@Column(name = "modulo")
	private String module;

	public RequestRejectedTmp() {
		super();
	}

	public Integer getSpidReqReject() {
		return spidReqReject;
	}

	public void setSpidReqReject(Integer spidReqReject) {
		this.spidReqReject = spidReqReject;
	}

	public String getNumberIdentifier() {
		return numberIdentifier;
	}

	public void setNumberIdentifier(String numberIdentifier) {
		this.numberIdentifier = numberIdentifier;
	}

	public String getOperationNumber() {
		return operationNumber;
	}

	public void setOperationNumber(String operationNumber) {
		this.operationNumber = operationNumber;
	}

	public String getDateLoad() {
		return dateLoad;
	}

	public void setDateLoad(String dateLoad) {
		this.dateLoad = dateLoad;
	}

	public String getDateRejected() {
		return dateRejected;
	}

	public void setDateRejected(String dateRejected) {
		this.dateRejected = dateRejected;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}
	
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((numberIdentifier == null) ? 0 : numberIdentifier.hashCode());
		result = prime * result + ((operationNumber == null) ? 0 : operationNumber.hashCode());
		result = prime * result + ((spidReqReject == null) ? 0 : spidReqReject.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RequestRejectedTmp other = (RequestRejectedTmp) obj;
		if (numberIdentifier == null) {
			if (other.numberIdentifier != null)
				return false;
		} else if (!numberIdentifier.equals(other.numberIdentifier))
			return false;
		if (operationNumber == null) {
			if (other.operationNumber != null)
				return false;
		} else if (!operationNumber.equals(other.operationNumber))
			return false;
		if (spidReqReject == null) {
			if (other.spidReqReject != null)
				return false;
		} else if (!spidReqReject.equals(other.spidReqReject))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "RequestRejectedTmp [spidReqReject=" + spidReqReject + ", numberIdentifier=" + numberIdentifier + ", operationNumber=" + operationNumber + ", dateLoad=" + dateLoad
				+ ", dateRejected=" + dateRejected + ", reason=" + reason + ", user=" + user + ", module=" + module + "]";
	}
}
