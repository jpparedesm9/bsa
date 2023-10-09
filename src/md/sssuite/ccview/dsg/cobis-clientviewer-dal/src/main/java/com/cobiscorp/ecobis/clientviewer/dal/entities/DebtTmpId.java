package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "spid", "cliente" and "tramite"
 * from the table: cr_deud1_tmp
 * @author bbuendia
 *
 */
@Embeddable
public class DebtTmpId {

	private Integer spidDebt;
	private Integer client;
	private Integer processed;

	public DebtTmpId() {
	}

	public DebtTmpId(Integer spid, Integer client, Integer processed) {
		this.spidDebt = spid;
		this.client = client;
		this.processed = processed;
	}

	public Integer getSpid() {
		return spidDebt;
	}

	public void setSpid(Integer spid) {
		this.spidDebt = spid;
	}

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public Integer getProcessed() {
		return processed;
	}

	public void setProcessed(Integer processed) {
		this.processed = processed;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((client == null) ? 0 : client.hashCode());
		result = prime * result
				+ ((processed == null) ? 0 : processed.hashCode());
		result = prime * result + ((spidDebt == null) ? 0 : spidDebt.hashCode());
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
		DebtTmpId other = (DebtTmpId) obj;
		if (client == null) {
			if (other.client != null)
				return false;
		} else if (!client.equals(other.client))
			return false;
		if (processed == null) {
			if (other.processed != null)
				return false;
		} else if (!processed.equals(other.processed))
			return false;
		if (spidDebt == null) {
			if (other.spidDebt != null)
				return false;
		} else if (!spidDebt.equals(other.spidDebt))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DebtTmpId [spid=" + spidDebt + ", client=" + client
				+ ", processed=" + processed + "]";
	}

}
