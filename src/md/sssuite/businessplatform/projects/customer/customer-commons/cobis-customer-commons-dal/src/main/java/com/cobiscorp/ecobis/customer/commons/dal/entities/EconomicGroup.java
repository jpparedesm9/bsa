package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "cl_grupo", schema = "cobis")
@NamedQueries({
		@NamedQuery(name = "Group.getGroup", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, "
				+ "gr.groupRepresentative, re.fullName, gr.groupOfficial, fu.functionaryName)"
				+ " from EconomicGroup gr left join gr.representative re left join gr.officialEntity oe left join oe.functionary fu"
				+ " where gr.groupId >= :groupId order by gr.groupId"),
		@NamedQuery(name = "Group.getGroupValue", query = ""
				+ "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, gr.groupRepresentative, "
				+ " re.fullName, gr.groupOfficial, fu.functionaryName, gr.groupType, gr.type) "
				+ " from EconomicGroup gr left join gr.representative re left join gr.officialEntity oe left join oe.functionary fu "
				+ " where gr.groupName like :groupName "
				+ " order by gr.groupName "),
		@NamedQuery(name = "Group.getGroupByName", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, gr.groupRepresentative, "
				+ " re.fullName, gr.groupOfficial, fu.functionaryName, gr.groupType, gr.type) "
				+ " from EconomicGroup gr left join gr.representative re left join gr.officialEntity oe left join oe.functionary fu "
				+ " where gr.groupName like :groupName "
				+ " and gr.type = :type"
				+ " order by gr.groupName "),
		@NamedQuery(name = "Group.getSolidarityGroupByName", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, gm.customerCode, "
				+ " c.fullName, gr.groupOfficial, fu.functionaryName, gr.groupType, gr.type) "
				+ " from EconomicGroup gr left join gr.groupMembers gm left join gm.customer c left join gr.officialEntity oe left join oe.functionary fu "
				+ " where gr.groupName like :groupName "
				+ " and gr.type = :type"
				+ " and gm.role = 'P'"
				+ " order by gr.groupName "),
		@NamedQuery(name = "Group.getNextGroupByName", query = ""
				+ "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, gr.groupRepresentative, "
				+ " re.fullName, gr.groupOfficial, fu.functionaryName, gr.groupType, gr.type) "
				+ " from EconomicGroup gr left join gr.representative re left join gr.officialEntity oe left join oe.functionary fu "
				+ " where gr.groupName like :groupName "
				+ " and gr.type = :type"
				+ " and gr.groupName > :lastValue " 
				+ " order by gr.groupName "),
		@NamedQuery(name = "Group.getNextSolidarityGroupByName", query = ""
				+ "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, gm.customerCode, "
				+ " c.fullName, gr.groupOfficial, fu.functionaryName, gr.groupType, gr.type) "
				+ " from EconomicGroup gr left join gr.groupMembers gm left join gm.customer c left join gr.officialEntity oe left join oe.functionary fu "
				+ " where gr.groupName like :groupName "
				+ " and gr.type = :type"
				+ " and gm.role = 'P'"
				+ " and gr.groupName > :lastValue " 
				+ " order by gr.groupName "),
		@NamedQuery(name = "Group.getGroupByCode", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, gr.groupRepresentative, "
				+ " re.fullName, gr.groupOfficial, fu.functionaryName, gr.groupType, gr.type) "
				+ " from EconomicGroup gr left join gr.representative re left join gr.officialEntity oe left join oe.functionary fu "
				+ " where gr.groupId = :groupCode "
				+ " and gr.type = :type"),
		@NamedQuery(name = "Group.getSolidarityGroupByCode", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO(gr.groupId, gr.groupName, gm.customerCode, "
				+ " c.fullName, gr.groupOfficial, fu.functionaryName, gr.groupType, gr.type) "
				+ " from EconomicGroup gr left join gr.groupMembers gm left join gm.customer c left join gr.officialEntity oe left join oe.functionary fu "
				+ " where gr.groupId = :groupCode "
				+ " and gr.type = :type" + " and gm.role = 'P'"),
		@NamedQuery(name = "Group.getGroupDetail", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO "
				+ "(gr.groupId, gr.groupName, gr.groupOfficial, gr.groupRepresentative,  re.name, re.firstSurname, re.secondSurname, "
				+ "re.documentId, gr.registrationDate, gr.modifiedDate, re.passport, gr.groupInclude, gr.groupType, gr.consecutiveCode, gr.state, gr.substitute, gr.cycleNumber, gr.type)"
				+ " from EconomicGroup gr left join gr.representative re "
				+ " where gr.groupId = :groupCode"
				+ " and gr.type = :type"),
		@NamedQuery(name = "Group.getSolidarityGroupDetail", query = "select new com.cobiscorp.ecobis.customer.commons.dto.EconomicGroupDTO "
				+ "(gr.groupId, gr.groupName, gr.groupOfficial, re.code,  re.name, re.firstSurname, re.secondSurname , re.documentId, gr.registrationDate, "
				+ " gr.modifiedDate, re.passport, gr.groupInclude, gr.groupType, gr.consecutiveCode, gr.state, gr.substitute, gr.cycleNumber, " 
				+ " gr.type, gr.meetingAddress,	gr.meetingDay, gr.meetingHour, gr.branchOffice, gr.score)"
				+ " from EconomicGroup gr left join gr.representative re "
				+ " where gr.groupId = :groupCode"
				+ " and gr.type = :type"),
		@NamedQuery(name = "Group.getNameGroup", query = "select eg.groupName from EconomicGroup eg where eg.groupId =:groupId"),
		@NamedQuery(name = "Group.countGroup", query = "select count(eg.groupId) from EconomicGroup eg where eg.groupId = :groupId"),
		@NamedQuery(name = "Group.getGroupMembers", query = "SELECT new com.cobiscorp.ecobis.customer.commons.dto.CustomerDTO(r.code, r.documentId, r.name, r.firstSurname, r.secondSurname," 
				+" r.subtype, r.passport, r.entailment, dt.descriptionDocument, r.linkUpType, eg.cycleNumber, '')"
				+ " FROM  EconomicGroup eg left join eg.representative r left join r.documentT dt"
				+ " WHERE  eg.groupId  = :groupcode" 
				+ " and eg.type = 'G'") })
@NamedNativeQueries({ @NamedNativeQuery(name = "Group.getGroupLike", query = "select gr_grupo, gr_nombre, gr_representante, en_nomlar, gr_oficial, substring(fu_nombre, 1, 30) from cl_grupo, cl_ente, cl_funcionario, cc_oficial where "
		+ "en_ente =* gr_representante and convert(varchar(10),gr_grupo) like ?1 and gr_oficial *= oc_oficial and oc_funcionario  *= fu_funcionario order by gr_grupo") })
/**
 * Class used to access the database using JPA
 * related table: cl_grupo, bdd: cobis
 * @author bbuendia
 *
 */
public class EconomicGroup {

	@Id
	@Column(name = "gr_grupo")
	private Integer groupId;
	@Column(name = "gr_nombre")
	private String groupName;
	@Column(name = "gr_representante")
	private Integer groupRepresentative;
	@Column(name = "gr_oficial")
	private Integer groupOfficial;
	@Column(name = "gr_fecha_registro")
	private Date registrationDate;
	@Column(name = "gr_fecha_modificacion")
	private Date modifiedDate;
	@Column(name = "gr_incluir")
	private String groupInclude;
	@Column(name = "gr_tipo_grupo")
	private String groupType;
	@Column(name = "gr_consec_tipo")
	private Integer consecutiveCode;
	@Column(name = "gr_estado")
	private String state;
	@Column(name = "gr_suplente")
	private Integer substitute;
	@Column(name = "gr_tipo")
	private String type;
	@Column(name = "gr_num_ciclo")
	private Integer cycleNumber;
	@Column(name = "gr_dir_reunion")
	private String meetingAddress;
	@Column(name = "gr_dia_reunion")
	private String meetingDay;
	@Column(name = "gr_hora_reunion")
	private Date meetingHour;
	@Column(name = "gr_sucursal")
	private String branchOffice;
	@Column(name = "gr_comportamiento_pago")
	private String score;

	@Transient
	private String nomlar;
	@Transient
	private String representativeName;
	@Transient
	private String firstSurnameRepresentative;
	@Transient
	private String secondSurnameRepresentative;
	@Transient
	private String functionaryName;
	@Transient
	private String functionaryNameSubstitute;
	@Transient
	private String representativeGroupDocumentId;
	@Transient
	private String representativeGroupPassport;
	@Transient
	private String lastValue;

	@ManyToOne
	@JoinColumn(name = "gr_oficial", referencedColumnName = "oc_oficial")
	private Official officialEntity;

	@OneToOne(mappedBy = "economicGroup")
	private Customer representative;

	@OneToMany(mappedBy = "economicGroup", fetch = FetchType.LAZY)
	private List<CustomerGroup> groupMembers;

	public EconomicGroup() {
	}

	public EconomicGroup(Integer groupId, String groupName, Integer groupRepresentative, Integer official, String financialGroup, String internalGroup, Customer representative,
			Official officialEntity) {
		this.groupId = groupId;
		this.groupName = groupName;
		this.groupRepresentative = groupRepresentative;
		this.groupOfficial = official;
		this.representative = representative;
		this.officialEntity = officialEntity;
	}

	public EconomicGroup(Integer groupId, String groupName, Integer groupRepresentative, String nomLar, Integer official, String functionaryName, String financialGroup,
			String internalGroup) {
		this.groupId = groupId;
		this.groupName = groupName;
		this.groupRepresentative = groupRepresentative;
		this.nomlar = nomLar;
		this.groupOfficial = official;
		this.functionaryName = functionaryName != null ? functionaryName.substring(0, 29) : functionaryName;
	}

	public EconomicGroup(Integer groupId, String groupName, Integer groupRepresentative, String nomLar, Integer official, String functionaryName) {
		this.groupId = groupId;
		this.groupName = groupName;
		this.groupRepresentative = groupRepresentative;
		this.nomlar = nomLar;
		this.groupOfficial = official;
		this.functionaryName = functionaryName != null ? functionaryName.substring(0, 29) : functionaryName;
	}

	public EconomicGroup(Integer groupId, String groupName, Integer groupOfficial, Integer groupRepresentative, String representativeName, String firstSurnameRepresentative,
			String secondSurnameRepresentative, String representativeGroupDocumentId, Date registrationDate, Date modifiedDate, String representativeGroupPassport,
			String groupInclude, String groupType, Integer consecutiveCode, String financialGroup, String internalGroup, String state, Integer substitute) {
		this.groupId = groupId;
		this.groupName = groupName;
		this.groupRepresentative = groupRepresentative;
		this.groupOfficial = groupOfficial;
		this.registrationDate = registrationDate;
		this.modifiedDate = modifiedDate;
		this.groupInclude = groupInclude;
		this.groupType = groupType;
		this.consecutiveCode = consecutiveCode;
		this.state = state;
		this.substitute = substitute;
		this.representativeGroupDocumentId = representativeGroupDocumentId;
		this.representativeGroupPassport = representativeGroupPassport;
		this.representativeName = representativeName;
		this.firstSurnameRepresentative = firstSurnameRepresentative;
		this.secondSurnameRepresentative = secondSurnameRepresentative;
		this.nomlar = firstSurnameRepresentative + ' ' + secondSurnameRepresentative + ' ' + representativeName;
	}

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Integer getGroupRepresentative() {
		return groupRepresentative;
	}

	public void setGroupRepresentative(Integer groupRepresentative) {
		this.groupRepresentative = groupRepresentative;
	}

	public Integer getGroupOfficial() {
		return groupOfficial;
	}

	public void setGroupOfficial(Integer official) {
		this.groupOfficial = official;
	}

	public String getNomlar() {
		return nomlar;
	}

	public void setNomlar(String nomlar) {
		this.nomlar = nomlar;
	}

	public String getFunctionaryName() {
		return functionaryName;
	}

	public void setFunctionaryName(String functionaryName) {
		this.functionaryName = functionaryName;
	}

	public Official getOfficialEntity() {
		return officialEntity;
	}

	public void setOfficialEntity(Official officialEntity) {
		this.officialEntity = officialEntity;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}

	public String getGroupInclude() {
		return groupInclude;
	}

	public void setGroupInclude(String groupInclude) {
		this.groupInclude = groupInclude;
	}

	public String getGroupType() {
		return groupType;
	}

	public void setGroupType(String groupType) {
		this.groupType = groupType;
	}

	public Integer getConsecutiveCode() {
		return consecutiveCode;
	}

	public void setConsecutiveCode(Integer consecutiveCode) {
		this.consecutiveCode = consecutiveCode;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getSubstitute() {
		return substitute;
	}

	public void setSubstitute(Integer substitute) {
		this.substitute = substitute;
	}

	public String getFunctionaryNameSubstitute() {
		return functionaryNameSubstitute;
	}

	public void setFunctionaryNameSubstitute(String substituteFunctionaryName) {
		this.functionaryNameSubstitute = substituteFunctionaryName;
	}

	public String getRepresentativeGroupDocumentId() {
		return representativeGroupDocumentId;
	}

	public void setRepresentativeGroupDocumentId(String representativeGroupDocumentId) {
		this.representativeGroupDocumentId = representativeGroupDocumentId;
	}

	public String getRepresentativeGroupPassport() {
		return representativeGroupPassport;
	}

	public void setRepresentativeGroupPassport(String representativeGroupPassport) {
		this.representativeGroupPassport = representativeGroupPassport;
	}

	public Customer getRepresentative() {
		return representative;
	}

	public void setRepresentative(Customer representative) {
		this.representative = representative;
	}

	public String getRepresentativeName() {
		return representativeName;
	}

	public void setRepresentativeName(String representativeName) {
		this.representativeName = representativeName;
	}

	public String getFirstSurnameRepresentative() {
		return firstSurnameRepresentative;
	}

	public void setFirstSurnameRepresentative(String firstSurnameRepresentative) {
		this.firstSurnameRepresentative = firstSurnameRepresentative;
	}

	public String getSecondSurnameRepresentative() {
		return secondSurnameRepresentative;
	}

	public void setSecondSurnameRepresentative(String secondSurnameRepresentative) {
		this.secondSurnameRepresentative = secondSurnameRepresentative;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<CustomerGroup> getGroupMembers() {
		return groupMembers;
	}

	public void setGroupMembers(List<CustomerGroup> groupMembers) {
		this.groupMembers = groupMembers;
	}

	public Integer getCycleNumber() {
		return cycleNumber;
	}

	public void setCycleNumber(Integer cycleNumber) {
		this.cycleNumber = cycleNumber;
	}

	public String getMeetingAddress() {
		return meetingAddress;
	}

	public void setMeetingAddress(String meetingAddress) {
		this.meetingAddress = meetingAddress;
	}

	public String getMeetingDay() {
		return meetingDay;
	}

	public void setMeetingDay(String meetingDay) {
		this.meetingDay = meetingDay;
	}

	public Date getMeetingHour() {
		return meetingHour;
	}

	public void setMeetingHour(Date meetingHour) {
		this.meetingHour = meetingHour;
	}

	public String getBranchOffice() {
		return branchOffice;
	}

	public void setBranchOffice(String branchOffice) {
		this.branchOffice = branchOffice;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((groupId == null) ? 0 : groupId.hashCode());
		result = prime * result + ((groupName == null) ? 0 : groupName.hashCode());
		result = prime * result + ((groupRepresentative == null) ? 0 : groupRepresentative.hashCode());
		result = prime * result + ((groupOfficial == null) ? 0 : groupOfficial.hashCode());
		result = prime * result + ((officialEntity == null) ? 0 : officialEntity.hashCode());
		result = prime * result + ((representative == null) ? 0 : representative.hashCode());
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
		EconomicGroup other = (EconomicGroup) obj;
		if (groupId == null) {
			if (other.groupId != null)
				return false;
		} else if (!groupId.equals(other.groupId))
			return false;
		if (groupName == null) {
			if (other.groupName != null)
				return false;
		} else if (!groupName.equals(other.groupName))
			return false;
		if (groupRepresentative == null) {
			if (other.groupRepresentative != null)
				return false;
		} else if (!groupRepresentative.equals(other.groupRepresentative))
			return false;
		if (groupOfficial == null) {
			if (other.groupOfficial != null)
				return false;
		} else if (!groupOfficial.equals(other.groupOfficial))
			return false;
		if (officialEntity == null) {
			if (other.officialEntity != null)
				return false;
		} else if (!officialEntity.equals(other.officialEntity))
			return false;
		if (representative == null) {
			if (other.representative != null)
				return false;
		} else if (!representative.equals(other.representative))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "EconomicGroup [groupId=" + groupId + ", groupName=" + groupName + ", groupRepresentative=" + groupRepresentative + ", groupOfficial=" + groupOfficial
				+ ", registrationDate=" + registrationDate + ", modifiedDate=" + modifiedDate + ", groupInclude=" + groupInclude + ", groupType=" + groupType
				+ ", consecutiveCode=" + consecutiveCode + ", state=" + state + ", substitute=" + substitute + ", nomlar=" + nomlar + ", representativeName=" + representativeName
				+ ", firstSurnameRepresentative=" + firstSurnameRepresentative + ", secondSurnameRepresentative=" + secondSurnameRepresentative + ", functionaryName="
				+ functionaryName + ", functionaryNameSubstitute=" + functionaryNameSubstitute + ", representativeGroupDocumentId=" + representativeGroupDocumentId
				+ ", representativeGroupPassport=" + representativeGroupPassport + "]";
	}

}
