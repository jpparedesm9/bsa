package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "vcc_dtos", schema = "cob_pac")
@NamedQueries({
		@NamedQuery(name = "Dtos.getAllDtos", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO(d.dtoId, d.serviceId, d.dtoName, d.dtoText, d.dtoDescription, d.parent, d.isList, d.mnemonic, d.order ,dp.dtoDescription) from Dtos d left join d.dtosParent dp "),
		@NamedQuery(name = "Dtos.getByDefaultProductAdministrator", query = "select d from Dtos d INNER JOIN d.dtoManager dm where dm.conditionDefaultProductParent.mnemonic=:mnemonic"),
		@NamedQuery(name = "Dtos.getById", query = "select d from Dtos d where d.dtoId=:dtoId"),
		@NamedQuery(name = "Dtos.getAllDtosByParent", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO(d.dtoId, d.serviceId, d.dtoName, d.dtoText, d.dtoDescription, d.parent, d.isList, d.mnemonic, d.order) "
				+ "from Dtos d where d.parent =:parent order by order"),
		@NamedQuery(name = "Dtos.getDtoSectionById", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DtosDTO(d.dtoId, d.serviceId, d.dtoName, d.dtoText, d.dtoDescription, d.parent, d.isList, d.mnemonic, d.order) from Dtos d where d.dtoId = :idDto ") })
/** 
 }
 * Class used to access the database using JPA
 * related table: vcc_dtos bdd: cob_pac
 * @author mcabay
 */
public class Dtos {
	/** Role code */
	@Id
	@Column(name = "dto_id")
	private int dtoId;

	@Column(name = "dto_name")
	private String dtoName;

	@Column(name = "dto_text")
	private String dtoText;

	@Column(name = "dto_description")
	private String dtoDescription;

	@Column(name = "dto_parent")
	private Integer parent;

	@Column(name = "ser_id_fk")
	private String serviceId;

	@Column(name = "dto_is_list")
	private Boolean isList;

	@Column(name = "dto_mnemonic")
	private String mnemonic;

	@Column(name = "dto_order")
	private Integer order;

	@OneToMany(mappedBy = "dtosProductManager")
	private List<DefaultProductAdministrator> dtoManager;

	@OneToMany(mappedBy = "dtoProperties")
	private List<Properties> properties;

	// bi-directional many-to-one association to dtosParent
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "dto_parent")
	private Dtos dtosParent;

	// bi-directional many-to-one association to dtosParent
	@OneToMany(mappedBy = "dtosParent", fetch = FetchType.EAGER)
	private List<Dtos> dtosSons;

	public Boolean getIsList() {
		return isList;
	}

	public void setIsList(Boolean isList) {
		this.isList = isList;
	}

	public void setDtoId(int dtoId) {
		this.dtoId = dtoId;
	}

	/**
	 * @return the parent
	 */
	public Integer getParent() {
		return parent;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public List<DefaultProductAdministrator> getDtoManager() {
		return dtoManager;
	}

	public void setDtoManager(List<DefaultProductAdministrator> dtoManager) {
		this.dtoManager = dtoManager;
	}

	public Dtos getDtosParent() {
		return dtosParent;
	}

	public void setDtosParent(Dtos dtosParent) {
		this.dtosParent = dtosParent;
	}

	public List<Dtos> getDtosSons() {
		return dtosSons;
	}

	public void setDtosSons(List<Dtos> dtosSons) {
		this.dtosSons = dtosSons;
	}

	public void setParent(Integer parent) {
		this.parent = parent;
	}

	public String getDtoText() {
		return dtoText;
	}

	public void setDtoText(String dtoText) {
		this.dtoText = dtoText;
	}

	public Integer getDtoId() {
		return dtoId;
	}

	public void setDtoId(Integer dtoId) {
		this.dtoId = dtoId;
	}

	public String getDtoName() {
		return dtoName;
	}

	public void setDtoName(String dtoName) {
		this.dtoName = dtoName;
	}

	public String getDtoDescription() {
		return dtoDescription;
	}

	public void setDtoDescription(String dtoDescription) {
		this.dtoDescription = dtoDescription;
	}

	public List<Properties> getProperties() {
		return properties;
	}

	public void setProperties(List<Properties> properties) {
		this.properties = properties;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getMnemonic() {
		return mnemonic;
	}

	public void setMnemonic(String mnemonic) {
		this.mnemonic = mnemonic;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + dtoId;
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
		Dtos other = (Dtos) obj;
		if (dtoId != other.dtoId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Dtos [dtoId=" + dtoId + ", dtoName=" + dtoName + ", dtoText=" + dtoText + ", dtoDescription=" + dtoDescription + ", properties="
				+ properties + ", serviceId=" + serviceId + ", order=" + order + "]";
	}

}
