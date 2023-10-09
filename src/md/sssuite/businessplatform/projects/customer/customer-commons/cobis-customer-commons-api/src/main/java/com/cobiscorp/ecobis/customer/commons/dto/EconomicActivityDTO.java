package com.cobiscorp.ecobis.customer.commons.dto;

/**
 * Class to transfer officer information
 * 
 * @author dcumbal
 * 
 */
public class EconomicActivityDTO {
	private Integer sequential;
	private Integer entity;
	private String activity;
	private String subActivity;
	private String description;
	private String sector;
	private String subSector;
	private String main;

	public Integer getSequential() {
		return sequential;
	}

	public void setSequential(Integer sequential) {
		this.sequential = sequential;
	}

	public Integer getEntity() {
		return entity;
	}

	public void setEntity(Integer entity) {
		this.entity = entity;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public String getSubActivity() {
		return subActivity;
	}

	public void setSubActivity(String subActivity) {
		this.subActivity = subActivity;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public String getSubSector() {
		return subSector;
	}

	public void setSubSector(String subSector) {
		this.subSector = subSector;
	}

	public String getMain() {
		return main;
	}

	public void setMain(String main) {
		this.main = main;
	}

	public EconomicActivityDTO(Integer sequential, Integer entity,
			String activity, String subActivity, String description,
			String sector, String subSector, String main) {
		this.sequential = sequential;
		this.entity = entity;
		this.activity = activity;
		this.subActivity = subActivity;
		this.description = description;
		this.sector = sector;
		this.subSector = subSector;
		this.main = main;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((sequential == null) ? 0 : sequential.hashCode());
		result = prime * result + ((entity == null) ? 0 : entity.hashCode());
		result = prime * result
				+ ((activity == null) ? 0 : activity.hashCode());
		result = prime * result
				+ ((subActivity == null) ? 0 : subActivity.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((sector == null) ? 0 : sector.hashCode());
		result = prime * result
				+ ((subSector == null) ? 0 : subSector.hashCode());
		result = prime * result + ((main == null) ? 0 : main.hashCode());
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
		EconomicActivityDTO other = (EconomicActivityDTO) obj;
		if (sequential == null) {
			if (other.sequential != null)
				return false;
		} else if (!sequential.equals(other.sequential))
			return false;
		if (entity == null) {
			if (other.entity != null)
				return false;
		} else if (!entity.equals(other.entity))
			return false;
		if (activity == null) {
			if (other.activity != null)
				return false;
		} else if (!activity.equals(other.activity))
			return false;
		if (subActivity == null) {
			if (other.subActivity != null)
				return false;
		} else if (!subActivity.equals(other.subActivity))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (sector == null) {
			if (other.sector != null)
				return false;
		} else if (!sector.equals(other.sector))
			return false;
		if (subSector == null) {
			if (other.subSector != null)
				return false;
		} else if (!subSector.equals(other.subSector))
			return false;
		if (main == null) {
			if (other.main != null)
				return false;
		} else if (!main.equals(other.main))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "OfficialDTO [sequential=" + sequential + ", entity=" + entity
				+ ", activity=" + activity + ", subActivity=" + subActivity
				+ ", description=" + description + ", sector=" + sector
				+ ", subSector=" + subSector + ", main=" + main + "]";
	}

}
