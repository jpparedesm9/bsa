package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@IdClass(OfficialId.class)
@Table(name = "cc_oficial", schema = "cobis")
@NamedQueries({
	@NamedQuery(name="Official.getOfficial", query="select f.functionaryName, f.functionaryLogin from Official o left join o.functionary f where o.officialId = :officialId"),
	@NamedQuery(name = "Official.getOfficer", query = "select new com.cobiscorp.ecobis.customer.commons.dto.OfficialDTO(off.officialId, off.officialName, fu.functionaryName)"
			+ " from Official off left join off.functionary fu"
			+ " where off.officialId = :officialCode")
})
/**
 * Class used to access the database using JPA
 * related table: cc_oficial, bdd: cobis
 * @author bbuendia
 *
 */
public class Official {

	@Id
	@Column(name = "oc_oficial")
	private Integer officialId;

	@Id
	@Column(name = "oc_funcionario")
	private Integer officialName;

	@Transient
	private String officerName;

	@OneToMany(mappedBy = "officialEntity")
	private List<EconomicGroup> groups;

	@OneToOne
	@JoinColumn(name = "oc_funcionario", referencedColumnName = "fu_funcionario")
	private Functionary functionary;
	
	

	public Official() {
	}

	public Official(Integer officialId, Integer officialName) {
		this.officialId = officialId;
		this.officialName = officialName;
	}

	public Integer getOfficialId() {
		return officialId;
	}

	public void setOfficialId(Integer officialId) {
		this.officialId = officialId;
	}

	public Integer getOfficialName() {
		return officialName;
	}

	public void setOfficialName(Integer officialName) {
		this.officialName = officialName;
	}

	public String getOfficerName() {
		return officerName;
	}

	public void setOfficerName(String functionaryName) {
		this.officerName = functionaryName;
	}

	public Official(Integer officialId, Integer officialName, String officerName) {
		this.officialId = officialId;
		this.officialName = officialName;
		this.officerName = officerName;
	}

}
