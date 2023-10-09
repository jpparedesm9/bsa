package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Embeddable;
/**
 * Class that contains primary keys: "spid", "CLIENTE" and "CODIGO"
 * from the table: cr_gar_tmp
 * @author bbuendia
 *
 */
@Embeddable
public class WarrantyTmpId {
	private Integer spidWar;
	private Integer client;
	private String code;

	public WarrantyTmpId() {
	}

	public WarrantyTmpId(Integer spid, Integer client, String code) {
		this.spidWar = spid;
		this.client = client;
		this.code = code;
	}

	public Integer getSpid() {
		return spidWar;
	}

	public void setSpid(Integer spid) {
		this.spidWar = spid;
	}

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + client;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + spidWar;
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
		WarrantyTmpId other = (WarrantyTmpId) obj;
		if (client != other.client)
			return false;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (spidWar != other.spidWar)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "WarrantyTmpId [spid=" + spidWar + ", client=" + client + ", code="
				+ code + "]";
	}
}
