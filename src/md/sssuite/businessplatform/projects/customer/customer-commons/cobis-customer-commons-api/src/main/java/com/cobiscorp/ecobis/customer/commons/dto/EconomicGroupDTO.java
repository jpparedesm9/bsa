package com.cobiscorp.ecobis.customer.commons.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO used in the methods: getGroupByName, getGroupById and getGroupDetail.
 * 
 * @author bbuendia
 * 
 */
public class EconomicGroupDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer groupId;
	private String groupName;
	private Integer groupRepresentative;
	private Integer groupOfficial;
	private Date registrationDate;
	private Date modifiedDate;
	private String groupInclude;
	private String groupType;
	private String type;
	private Integer consecutiveCode;
	private String state;
	private Integer substitute;
	private String nomlar;
	private String representativeName;
	private String firstSurnameRepresentative;
	private String secondSurnameRepresentative;
	private String functionaryName;
	private String functionaryNameSubstitute;
	private String representativeGroupDocumentId;
	private String representativeGroupPassport;
	private Integer cycleNumber;
	private String meetingAddress;
	private String meetingDay;
	private Date meetingHour;
	private String branchOffice;
	private String score;

	public EconomicGroupDTO() {
	}

	public EconomicGroupDTO(Integer groupId, String groupName, Integer groupRepresentative, String nomLar, Integer official, String functionaryName, String groupType, String type) {
		this.groupId = groupId;
		this.groupName = groupName;
		this.groupRepresentative = groupRepresentative;
		this.nomlar = nomLar;
		this.groupOfficial = official;
		this.functionaryName = functionaryName;
		this.groupType = groupType;
		this.type = type;
	}

	public EconomicGroupDTO(Integer groupId, String groupName, Integer groupRepresentative, String nomLar, Integer official, String functionaryName) {
		this.groupId = groupId;
		this.groupName = groupName;
		this.groupRepresentative = groupRepresentative;
		this.nomlar = nomLar;
		this.groupOfficial = official;
		this.functionaryName = functionaryName;
	}

	public EconomicGroupDTO(Integer groupId, String groupName) {
		this.groupId = groupId;
		this.groupName = groupName;
	}

	public EconomicGroupDTO(Integer groupId, String groupName, Integer groupOfficial, Integer groupRepresentative, String representativeName, String firstSurnameRepresentative,
			String secondSurnameRepresentative, String representativeGroupDocumentId, Date registrationDate, Date modifiedDate, String representativeGroupPassport,
			String groupInclude, String groupType, Integer consecutiveCode, String state, Integer substitute, Integer cycleNumber, String type) {
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
		this.cycleNumber = cycleNumber;
		this.type = type;
	}

	// Constructor para Grupo Solidario
	public EconomicGroupDTO(Integer groupId, String groupName, Integer groupOfficial, Integer groupRepresentative, String representativeName, String firstSurnameRepresentative,
			String secondSurnameRepresentative, String representativeGroupDocumentId, Date registrationDate, Date modifiedDate, String representativeGroupPassport,
			String groupInclude, String groupType, Integer consecutiveCode, String state, Integer substitute, Integer cycleNumber, String type, String meetingAddress,
			String meetingDay, Date meetingHour, String branchOffice, String score) {
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
		this.cycleNumber = cycleNumber;
		this.type = type;
		this.meetingAddress = meetingAddress;
		this.meetingDay = meetingDay;
		this.meetingHour = meetingHour;
		this.branchOffice = branchOffice;
		this.score = score;
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

	public void setGroupOfficial(Integer groupOfficial) {
		this.groupOfficial = groupOfficial;
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

	public String getNomlar() {
		return nomlar;
	}

	public void setNomlar(String nomlar) {
		this.nomlar = nomlar;
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

	public String getFunctionaryName() {
		return functionaryName;
	}

	public void setFunctionaryName(String functionaryName) {
		this.functionaryName = functionaryName;
	}

	public String getFunctionaryNameSubstitute() {
		return functionaryNameSubstitute;
	}

	public void setFunctionaryNameSubstitute(String functionaryNameSubstitute) {
		this.functionaryNameSubstitute = functionaryNameSubstitute;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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
		EconomicGroupDTO other = (EconomicGroupDTO) obj;
		if (groupId == null) {
			if (other.groupId != null)
				return false;
		} else if (!groupId.equals(other.groupId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "EconomicGroupDTO [groupId=" + groupId + ", groupName=" + groupName + ", groupRepresentative=" + groupRepresentative + ", groupOfficial=" + groupOfficial
				+ ", registrationDate=" + registrationDate + ", modifiedDate=" + modifiedDate + ", groupInclude=" + groupInclude + ", groupType=" + groupType
				+ ", consecutiveCode=" + consecutiveCode + ", state=" + state + ", substitute=" + substitute + ", nomlar=" + nomlar + ", representativeName=" + representativeName
				+ ", firstSurnameRepresentative=" + firstSurnameRepresentative + ", secondSurnameRepresentative=" + secondSurnameRepresentative + ", functionaryName="
				+ functionaryName + ", functionaryNameSubstitute=" + functionaryNameSubstitute + ", representativeGroupDocumentId=" + representativeGroupDocumentId
				+ ", representativeGroupPassport=" + representativeGroupPassport + "]";
	}
}
