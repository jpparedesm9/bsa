package com.cobiscorp.ecobis.customer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@NamedQuery(name="BusinessSegment.getBusinessSegment",query="SELECT new com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse(bs.code,bs.description,bs.line,bs.status) FROM BusinessSegment bs WHERE bs.line = :Idline")

@Entity
@Table(name="cl_segmento_neg", schema="cobis")

public class BusinessSegment {
  public BusinessSegment(){
	  
  }
  
  @Id
	@Column(name = "sn_codigo")
	private String code;
	
	@Column(name = "sn_descripcion")
	private String description;
	
	@Column(name = "sn_linea")
	private String line;
	
	@Column(name = "sn_estado")
	private String status;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLine() {
		return line;
	}

	public void setLine(String line) {
		this.line = line;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
  
	
}
