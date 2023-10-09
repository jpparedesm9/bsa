package com.cobiscorp.ecobis.clientviewer.admin.dto;

import java.io.Serializable;

/**
 * DTO that obtains information from services, dtos and properties
 * 
 * @author mcabay
 * 
 */
public class PropertiesDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer propertieId;
	private String name;
	private String text;
	private Boolean grouping;
	private Boolean visibleSumaryDetail;
	private Boolean visibleSumaryGroup;
	private Boolean filterInProcess;
	private Boolean primaryKey;
	private String width;
	private String format;
	private Boolean detailSection;
	private String type;
	private Integer order;
	private String style;
	private Integer dtoId;

	public PropertiesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public PropertiesDTO(Integer propertieId, String name, String text, Boolean grouping, Boolean visibleSumaryDetail, Boolean visibleSumaryGroup,
			Boolean filterInProcess, Boolean primaryKey, String width, String format, Boolean detailSection, String type, Integer order, String style) {
		this.propertieId = propertieId;
		this.name = name;
		this.text = text;
		this.grouping = grouping;
		this.visibleSumaryDetail = visibleSumaryDetail;
		this.visibleSumaryGroup = visibleSumaryGroup;
		this.filterInProcess = filterInProcess;
		this.primaryKey = primaryKey;
		this.width = width;
		this.format = format;
		this.detailSection = detailSection;
		this.type = type;
		this.order = order;
		this.style = style;
	}

	public PropertiesDTO(Integer propertieId, String name, String text, Boolean grouping, Boolean visibleSumaryDetail, Boolean visibleSumaryGroup,
			Boolean filterInProcess, Boolean primaryKey, String width, String format, Boolean detailSection, String type, Integer order, String style,Integer dtoId) {
		this.propertieId = propertieId;
		this.name = name;
		this.text = text;
		this.grouping = grouping;
		this.visibleSumaryDetail = visibleSumaryDetail;
		this.visibleSumaryGroup = visibleSumaryGroup;
		this.filterInProcess = filterInProcess;
		this.primaryKey = primaryKey;
		this.width = width;
		this.format = format;
		this.detailSection = detailSection;
		this.type = type;
		this.order = order;
		this.style = style;
		this.dtoId = dtoId;
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
		result = prime * result + ((propertieId == null) ? 0 : propertieId.hashCode());
		return result;
	}

	/**
	 * @return the dtoId
	 */
	public Integer getDtoId() {
		return dtoId;
	}

	/**
	 * @param dtoId
	 *            the dtoId to set
	 */
	public void setDtoId(Integer dtoId) {
		this.dtoId = dtoId;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PropertiesDTO other = (PropertiesDTO) obj;
		if (propertieId == null) {
			if (other.propertieId != null)
				return false;
		} else if (!propertieId.equals(other.propertieId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "PropertiesDTO [propertieId=" + propertieId + ", name=" + name + ", text=" + text + ", grouping=" + grouping
				+ ", visibleSumaryDetail=" + visibleSumaryDetail + ", visibleSumaryGroup=" + visibleSumaryGroup + ", filterInProcess="
				+ filterInProcess + ", primaryKey=" + primaryKey + ", width=" + width + ", format=" + format + ", detailSection=" + detailSection
				+ ", type=" + type + ", style=" + style + ", order=" + order + "]";
	}

}
