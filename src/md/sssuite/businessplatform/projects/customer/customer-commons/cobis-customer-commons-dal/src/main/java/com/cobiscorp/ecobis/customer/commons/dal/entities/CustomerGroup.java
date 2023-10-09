package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@IdClass(CustomerGroupId.class)
@Table(name = "cl_cliente_grupo", schema = "cobis")
@NamedQueries({
		@NamedQuery(name = "CustomerGroup.getGroupMembers", query = "SELECT new com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO(b.code, b.documentId, b.name, b.firstSurname, b.secondSurname, b.subtype, b.passport, b.entailment, dt.descriptionDocument, b.linkUpType, b.cycleNumber, a.role)"
				+ " FROM  CustomerGroup a left join a.customer b left join b.documentT dt" + " WHERE  a.groupCode  = :groupcode and a.status = 'V'"),
		@NamedQuery(name = "CustomerGroup.getGroupsByCustomer", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName)"
				+ " from CustomerGroup cg join cg.economicGroup gr " + " WHERE cg.customerCode = :customerCode"),
		@NamedQuery(name = "CustomerGroup.getCodeGroupMembersByCustomer", query = "SELECT a.groupCode FROM CustomerGroup a WHERE a.customerCode = :customerCode") })
/**
 * Class used to access the database using JPA
 * related table: cl_cliente_grupo, bdd: cobis
 * @author bbuendia
 *
 */
public class CustomerGroup {

	@Id
	@Column(name = "cg_ente")
	private Integer customerCode;

	@Id
	@Column(name = "cg_grupo")
	private Integer groupCode;

	@Column(name = "cg_usuario")
	private String login;

	@Column(name = "cg_terminal")
	private String terminal;

	@Column(name = "cg_oficial")
	private Integer official;

	@Column(name = "cg_fecha_reg")
	private Date registrationDate;

	@Column(name = "cg_incluir")
	private String include;

	@Column(name = "cg_tipo_relacion")
	private String relationshipType;

	@Column(name = "cg_rol")
	private String role;

	@Column(name = "cg_estado")
	private String status;

	@OneToMany(mappedBy = "groupCustomer")
	private List<Customer> customer;

	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "cg_grupo", referencedColumnName = "gr_grupo") })
	private EconomicGroup economicGroup;

	public CustomerGroup() {
	}

	public Integer getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(Integer customerCode) {
		this.customerCode = customerCode;
	}

	public Integer getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(Integer groupCode) {
		this.groupCode = groupCode;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getTerminal() {
		return terminal;
	}

	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}

	public Integer getOfficial() {
		return official;
	}

	public void setOfficial(Integer official) {
		this.official = official;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public String getInclude() {
		return include;
	}

	public void setInclude(String include) {
		this.include = include;
	}

	public String getRelationshipType() {
		return relationshipType;
	}

	public void setRelationshipType(String relationshipType) {
		this.relationshipType = relationshipType;
	}

	public List<Customer> getCustomer() {
		return customer;
	}

	public void setCustomer(List<Customer> customer) {
		this.customer = customer;
	}

	public EconomicGroup getEconomicGroup() {
		return economicGroup;
	}

	public void setEconomicGroup(EconomicGroup economicGroup) {
		this.economicGroup = economicGroup;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
