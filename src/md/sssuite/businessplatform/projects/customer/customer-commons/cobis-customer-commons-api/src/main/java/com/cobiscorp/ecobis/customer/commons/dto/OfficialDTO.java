package com.cobiscorp.ecobis.customer.commons.dto;

/**
 * Class to transfer officer information 
 * @author dcumbal
 *
 */
public class OfficialDTO {
	/** Official code */
	private Integer officialId;
	
	/** Officer code */
	private Integer officialName;
	
	/**  Officer name */
	private String officerName;

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

	public void setOfficerName(String officerName) {
		this.officerName = officerName;
	}

	public OfficialDTO() {
	}

	public OfficialDTO(Integer officialId, Integer officialName) {
		this.officialId = officialId;
		this.officialName = officialName;
	}

	public OfficialDTO(Integer officialId, Integer officialName,
			String officerName) {
		this.officialId = officialId;
		this.officialName = officialName;
		this.officerName = officerName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((officialId == null) ? 0 : officialId.hashCode());
		result = prime * result
				+ ((officialName == null) ? 0 : officialName.hashCode());
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
		OfficialDTO other = (OfficialDTO) obj;
		if (officialId == null) {
			if (other.officialId != null)
				return false;
		} else if (!officialId.equals(other.officialId))
			return false;
		if (officialName == null) {
			if (other.officialName != null)
				return false;
		} else if (!officialName.equals(other.officialName))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "OfficialDTO [officialId=" + officialId + ", officialName="
				+ officialName + ", officerName=" + officerName + "]";
	}

}
