package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "vcc_section_management_content", schema = "cob_pac")
@NamedQueries({
		@NamedQuery(name = "ManagementContentSection.getAllManagementContentSection", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionDTO(m.code, m.name, m.description, m.urlTemplate) from ManagementContentSection m"),
		@NamedQuery(name = "ManagementContentSection.deleteManagementContentSectionById", query = "delete from ManagementContentSection m where m.code=:code"),
		@NamedQuery(name = "ManagementContentSection.updateManagementContentSectionById", query = "update ManagementContentSection m set m.name=:name, "
				+ " m.description=:entity.description,  m.urlTemplate=url where m.code=:entity.code") })
/** 
 * Class used to access the database using JPA
 * related table: vcc_section_management_content bdd: cob_pac
 * @author ecarrion
 */
public class ManagementContentSection {

	@Id
	@Column(name = "sm_id")
	private Integer code;

	@Column(name = "sm_name")
	private String name;

	@Column(name = "sm_description")
	private String description;

	@Column(name = "sm_url_template")
	private String urlTemplate;

	@Column(name = "sm_type")
	private String type;

	/** Property to declare the join with entity ManagementContentSectionRol */
	@OneToMany(mappedBy = "managementContentSection")
	private List<ManagementContentSectionRole> lstManagementContentSectionRol;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
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

	public List<ManagementContentSectionRole> getLstManagementContentSectionRol() {
		return lstManagementContentSectionRol;
	}

	public void setLstManagementContentSectionRol(
			List<ManagementContentSectionRole> lstManagementContentSectionRol) {
		this.lstManagementContentSectionRol = lstManagementContentSectionRol;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		ManagementContentSection other = (ManagementContentSection) obj;
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
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ManagementContentSection [code=" + code + ", name=" + name
				+ ", description=" + description + ", urlTemplate="
				+ urlTemplate + ", type=" + type + "]";
	}
}
