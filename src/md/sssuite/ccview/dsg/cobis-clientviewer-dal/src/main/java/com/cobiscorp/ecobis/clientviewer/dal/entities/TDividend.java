package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
// @IdClass(ScoreId.class)
@Table(name = "ca_tdividendo", schema = "cob_cartera")
public class TDividend {

	@Id
	@Column(name = "td_tdividendo")
	private String tdividend;

	@Column(name = "td_descripcion")
	private String tDescription;

	@Column(name = "td_estado")
	private String tStatus;

	@Column(name = "td_factor")
	private Integer tFactor;

	public String getTdividend() {
		return tdividend;
	}

	public void setTdividend(String tdividend) {
		this.tdividend = tdividend;
	}

	public String gettDescription() {
		return tDescription;
	}

	public void settDescription(String tDescription) {
		this.tDescription = tDescription;
	}

	public String gettStatus() {
		return tStatus;
	}

	public void settStatus(String tStatus) {
		this.tStatus = tStatus;
	}

	public Integer gettFactor() {
		return tFactor;
	}

	public void settFactor(Integer tFactor) {
		this.tFactor = tFactor;
	}

}
