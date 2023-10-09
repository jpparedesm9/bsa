package com.cobiscorp.ecobis.clientviewer.admin.dto;

import java.io.Serializable;
import java.util.List;

/**
 * DTO that obtains information from Management Content Section
 * 
 * @author ecarrion
 * 
 */
public class ManagementContentSectionDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer code;
	private String name;
	private String description;
	private String urlTemplate;
	private List<ManagementContentSectionRoleDTO> lstManagementContentSectionRoleDTO;

	public ManagementContentSectionDTO(Integer code, String name,
			String description, String urlTemplate) {
		this.code = code;
		this.name = name;
		this.description = description;
		this.urlTemplate = urlTemplate;
	}

	public ManagementContentSectionDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrlTemplate() {
		return urlTemplate;
	}

	public void setUrlTemplate(String urlTemplate) {
		this.urlTemplate = urlTemplate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public List<ManagementContentSectionRoleDTO> getLstManagementContentSectionRoleDTO() {
		return lstManagementContentSectionRoleDTO;
	}

	public void setLstManagementContentSectionRoleDTO(
			List<ManagementContentSectionRoleDTO> lstManagementContentSectionRoleDTO) {
		this.lstManagementContentSectionRoleDTO = lstManagementContentSectionRoleDTO;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result
				+ ((urlTemplate == null) ? 0 : urlTemplate.hashCode());
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
		ManagementContentSectionDTO other = (ManagementContentSectionDTO) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (urlTemplate == null) {
			if (other.urlTemplate != null)
				return false;
		} else if (!urlTemplate.equals(other.urlTemplate))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ManagementContentSectionDTO [code=" + code + ", name=" + name
				+ ", description=" + description + ", urlTemplate="
				+ urlTemplate + "]";
	}

}
