package com.cobiscorp.ecobis.customer.commons.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cl_funcionario", schema = "cobis")
/**
 * Class used to access the database using JPA
 * related table: cl_funcionario bdd: cobis
 * @author bbuendia
 *
 */
public class Functionary {

	@Id
	@Column(name = "fu_funcionario")
	private Integer functionaryId;

	@Column(name = "fu_nombre")
	private String functionaryName;

	@Column(name = "fu_login")
	private String functionaryLogin;

	@OneToOne(mappedBy = "functionary")
	private Official official;

	public Integer getFunctionaryId() {
		return functionaryId;
	}

	public void setFunctionaryId(Integer functionaryId) {
		this.functionaryId = functionaryId;
	}

	public String getFunctionaryName() {
		return functionaryName;
	}

	public void setFunctionaryName(String functionaryName) {
		this.functionaryName = functionaryName;
	}

	public String getFunctionaryLogin() {
		return functionaryLogin;
	}

	public void setFunctionaryLogin(String functionaryLogin) {
		this.functionaryLogin = functionaryLogin;
	}

	public Official getOfficial() {
		return official;
	}

	public void setOfficial(Official official) {
		this.official = official;
	}

	public Functionary() {
	}

	public Functionary(Integer functionaryId, String functionaryName) {
		this.functionaryId = functionaryId;
		this.functionaryName = functionaryName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((functionaryId == null) ? 0 : functionaryId.hashCode());
		result = prime * result
				+ ((functionaryName == null) ? 0 : functionaryName.hashCode());
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
		Functionary other = (Functionary) obj;
		if (functionaryId == null) {
			if (other.functionaryId != null)
				return false;
		} else if (!functionaryId.equals(other.functionaryId))
			return false;
		if (functionaryName == null) {
			if (other.functionaryName != null)
				return false;
		} else if (!functionaryName.equals(other.functionaryName))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Functionary [functionaryId=" + functionaryId
				+ ", functionaryName=" + functionaryName + "]";
	}

}
