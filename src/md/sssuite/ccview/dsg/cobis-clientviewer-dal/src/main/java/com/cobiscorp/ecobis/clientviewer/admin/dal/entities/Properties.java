package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "vcc_properties", schema = "cob_pac")
@NamedQueries({ @NamedQuery(name = "Properties.getPropertiesByDtoId", query = "select p from Properties p order by p.order"),
		        @NamedQuery(name = "Properties.getPropertiesById", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO(p.propertieId, p.name, p.text, p.grouping, p.visibleSumaryDetail, p.visibleSumaryGroup, p.filterInProcess, p.primaryKey, p.width, p.format, p.detailSection, p.type, p.order, p.style, p.dtoId) from Properties p where p.propertieId = :propertieId order by p.order"),
		        @NamedQuery(name = "Properties.getPropertiesByDto", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.PropertiesDTO(p.propertieId, p.name, p.text, p.grouping, p.visibleSumaryDetail, p.visibleSumaryGroup, p.filterInProcess, p.primaryKey, p.width, p.format, p.detailSection, p.type, p.order, p.style, p.dtoId) from Properties p where p.dtoId = :dtoId order by p.order")})
/** 
 * Class used to access the database using JPA
 * related table: vcc_product_admin bdd: cob_pac
 * @author mcabay
 */
public class Properties {
	/** Role code */
	@Id
	@Column(name = "pr_id")
	private Integer propertieId;

	@Column(name = "pr_name")
	private String name;

	@Column(name = "pr_text")
	private String text;

	@Column(name = "pr_grouping")
	private Boolean grouping;

	@Column(name = "pr_visiblesumarydetail")
	private Boolean visibleSumaryDetail;

	@Column(name = "pr_visiblesumarygroup")
	private Boolean visibleSumaryGroup;

	@Column(name = "pr_filterinprocess")
	private Boolean filterInProcess;

	@Column(name = "pr_primarykey")
	private Boolean primaryKey;

	@Column(name = "pr_width")
	private String width;

	@Column(name = "pr_format")
	private String format;

	@Column(name = "pr_detailsection")
	private Boolean detailSection;

	@Column(name = "pr_type")
	private String type;

	@Column(name = "dto_id_fk")
	private Integer dtoId;

	@Column(name = "pr_order")
	private Integer order;

	@Column(name = "pr_style")
	private String style;

	@ManyToOne
	@JoinColumn(name = "dto_id_fk", referencedColumnName = "dto_id")
	private Dtos dtoProperties;

	public Dtos getDtoProperties() {
		return dtoProperties;
	}

	public void setDtoProperties(Dtos dtoProperties) {
		this.dtoProperties = dtoProperties;
	}

	public Integer getPropertieId() {
		return propertieId;
	}

	public void setPropertieId(Integer propertieId) {
		this.propertieId = propertieId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Boolean getGrouping() {
		return grouping;
	}

	public void setGrouping(Boolean grouping) {
		this.grouping = grouping;
	}

	public Boolean getVisibleSumaryDetail() {
		return visibleSumaryDetail;
	}

	public void setVisibleSumaryDetail(Boolean visibleSumaryDetail) {
		this.visibleSumaryDetail = visibleSumaryDetail;
	}

	public Boolean getVisibleSumaryGroup() {
		return visibleSumaryGroup;
	}

	public void setVisibleSumaryGroup(Boolean visibleSumaryGroup) {
		this.visibleSumaryGroup = visibleSumaryGroup;
	}

	public Boolean getFilterInProcess() {
		return filterInProcess;
	}

	public void setFilterInProcess(Boolean filterInProcess) {
		this.filterInProcess = filterInProcess;
	}

	public Boolean getPrimaryKey() {
		return primaryKey;
	}

	public void setPrimaryKey(Boolean primaryKey) {
		this.primaryKey = primaryKey;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public Boolean getDetailSection() {
		return detailSection;
	}

	public void setDetailSection(Boolean detailSection) {
		this.detailSection = detailSection;
	}

	public Integer getDtoId() {
		return dtoId;
	}

	public void setDtoId(Integer dtoId) {
		this.dtoId = dtoId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((detailSection == null) ? 0 : detailSection.hashCode());
		result = prime * result + ((dtoId == null) ? 0 : dtoId.hashCode());
		result = prime * result
				+ ((dtoProperties == null) ? 0 : dtoProperties.hashCode());
		result = prime * result
				+ ((filterInProcess == null) ? 0 : filterInProcess.hashCode());
		result = prime * result + ((format == null) ? 0 : format.hashCode());
		result = prime * result
				+ ((grouping == null) ? 0 : grouping.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result
				+ ((primaryKey == null) ? 0 : primaryKey.hashCode());
		result = prime * result
				+ ((propertieId == null) ? 0 : propertieId.hashCode());
		result = prime * result + ((text == null) ? 0 : text.hashCode());
		result = prime
				* result
				+ ((visibleSumaryDetail == null) ? 0 : visibleSumaryDetail
						.hashCode());
		result = prime
				* result
				+ ((visibleSumaryGroup == null) ? 0 : visibleSumaryGroup
						.hashCode());
		result = prime * result + ((width == null) ? 0 : width.hashCode());
		result = prime * result + ((order == null) ? 0 : order.hashCode());
		result = prime * result + ((style == null) ? 0 : style.hashCode());
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
		Properties other = (Properties) obj;
		if (detailSection == null) {
			if (other.detailSection != null)
				return false;
		} else if (!detailSection.equals(other.detailSection))
			return false;
		if (dtoId == null) {
			if (other.dtoId != null)
				return false;
		} else if (!dtoId.equals(other.dtoId))
			return false;
		if (dtoProperties == null) {
			if (other.dtoProperties != null)
				return false;
		} else if (!dtoProperties.equals(other.dtoProperties))
			return false;
		if (filterInProcess == null) {
			if (other.filterInProcess != null)
				return false;
		} else if (!filterInProcess.equals(other.filterInProcess))
			return false;
		if (format == null) {
			if (other.format != null)
				return false;
		} else if (!format.equals(other.format))
			return false;
		if (grouping == null) {
			if (other.grouping != null)
				return false;
		} else if (!grouping.equals(other.grouping))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (primaryKey == null) {
			if (other.primaryKey != null)
				return false;
		} else if (!primaryKey.equals(other.primaryKey))
			return false;
		if (propertieId == null) {
			if (other.propertieId != null)
				return false;
		} else if (!propertieId.equals(other.propertieId))
			return false;
		if (text == null) {
			if (other.text != null)
				return false;
		} else if (!text.equals(other.text))
			return false;
		if (visibleSumaryDetail == null) {
			if (other.visibleSumaryDetail != null)
				return false;
		} else if (!visibleSumaryDetail.equals(other.visibleSumaryDetail))
			return false;
		if (visibleSumaryGroup == null) {
			if (other.visibleSumaryGroup != null)
				return false;
		} else if (!visibleSumaryGroup.equals(other.visibleSumaryGroup))
			return false;
		if (width == null) {
			if (other.width != null)
				return false;
		} else if (!width.equals(other.width))
			return false;
		if (order == null) {
			if (other.order != null)
				return false;
		} else if (!order.equals(other.order))
			return false;
		if (style == null) {
			if (other.style != null)
				return false;
		} else if (!style.equals(other.style))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Properties [propertieId=" + propertieId + ", name=" + name
				+ ", text=" + text + ", grouping=" + grouping
				+ ", visibleSumaryDetail=" + visibleSumaryDetail
				+ ", visibleSumaryGroup=" + visibleSumaryGroup
				+ ", filterInProcess=" + filterInProcess + ", primaryKey="
				+ primaryKey + ", width=" + width + ", format=" + format
				+ ", detailSection=" + detailSection + ", dtoId=" + dtoId
				+ ", dtoProperties=" + dtoProperties + ", type=" + type
				+ ", order=" + order + ", style=" + style + "]";
	}

}
