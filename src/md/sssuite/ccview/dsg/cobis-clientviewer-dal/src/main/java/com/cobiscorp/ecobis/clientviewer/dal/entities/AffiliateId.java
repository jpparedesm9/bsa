package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Embeddable;
/**
 * Class that contains primary keys: "af_ente_mis" and "af_login"
 * from the table: bv_afiliados_bv
 * @author bbuendia
 *
 */
@Embeddable
public class AffiliateId {

	private Integer entityMIS;
	private String login;

	public AffiliateId() {
	}

	public AffiliateId(Integer entityMIS, String login) {
		this.entityMIS = entityMIS;
		this.login = login;
	}

	public Integer getEntityMIS() {
		return entityMIS;
	}

	public void setEntityMIS(Integer entityMIS) {
		this.entityMIS = entityMIS;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + entityMIS;
		result = prime * result + ((login == null) ? 0 : login.hashCode());
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
		AffiliateId other = (AffiliateId) obj;
		if (entityMIS != other.entityMIS)
			return false;
		if (login == null) {
			if (other.login != null)
				return false;
		} else if (!login.equals(other.login))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "AffiliateId [entityMIS=" + entityMIS + ", login=" + login + "]";
	}
}
