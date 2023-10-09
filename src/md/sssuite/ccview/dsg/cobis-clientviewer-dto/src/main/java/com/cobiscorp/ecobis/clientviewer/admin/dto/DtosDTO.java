package com.cobiscorp.ecobis.clientviewer.admin.dto;

import java.io.Serializable;
import java.util.List;

/**
 * DTO that obtains information from services, dtos and properties
 * 
 * @author mcabay
 * 
 */
public class DtosDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private int dtoId;
	private String dtoName;
	private String dtoText;
	private String dtoDescription;
	private List<PropertiesDTO> properties;
	private List<DtosDTO> dtoList;
	private String serviceId;
	private String mnemonic;
	private Boolean isList;
	private Integer dtoOrder;
	private Integer dtoParent;
	private String dtoNameParent;

	public DtosDTO(int dtoId, String dtoName, String dtoText, String dtoDescription, List<PropertiesDTO> properties, String serviceId,
			String mnemonic, Boolean isList, Integer dtoOrder) {
		this.dtoId = dtoId;
		this.dtoName = dtoName;
		this.dtoText = dtoText;
		this.dtoDescription = dtoDescription;
		this.properties = properties;
		this.serviceId = serviceId;
		this.isList = isList;
		this.mnemonic = mnemonic;
		this.dtoOrder = dtoOrder;
	}
	
	public DtosDTO(Integer dtoId, String serviceId, String dtoName, String dtoText, String dtoDescription, Integer dtoParent, Boolean isList,
			String mnemonic, Integer dtoOrder, String dtoNameParent) {
		this.dtoId = dtoId;
		this.dtoName = dtoName;
		this.dtoText = dtoText;
		this.dtoDescription = dtoDescription;
		this.serviceId = serviceId;
		this.isList = isList;
		this.dtoOrder = dtoOrder;
		this.mnemonic = mnemonic;
		this.dtoParent = dtoParent;
		this.dtoNameParent =dtoNameParent;
	}

	public DtosDTO(Integer dtoId, String serviceId, String dtoName, String dtoText, String dtoDescription, Integer dtoParent, Boolean isList,
			String mnemonic, Integer dtoOrder) {
		this.dtoId = dtoId;
		this.dtoName = dtoName;
		this.dtoText = dtoText;
		this.dtoDescription = dtoDescription;
		this.serviceId = serviceId;
		this.isList = isList;
		this.dtoOrder = dtoOrder;
		this.mnemonic = mnemonic;
		this.dtoParent = dtoParent;
	}

	public DtosDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Boolean getIsList() {
		return isList;
	}

	public void setIsList(Boolean isList) {
		this.isList = isList;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public List<DtosDTO> getDtoList() {
		return dtoList;
	}

	public void setDtoList(List<DtosDTO> dtos) {
		this.dtoList = dtos;
	}

	public List<PropertiesDTO> getProperties() {
		return properties;
	}

	public void setProperties(List<PropertiesDTO> properties) {
		this.properties = properties;
	}

	public int getDtoId() {
		return dtoId;
	}

	public void setDtoId(int dtoId) {
		this.dtoId = dtoId;
	}

	public String getDtoName() {
		return dtoName;
	}

	public void setDtoName(String dtoName) {
		this.dtoName = dtoName;
	}

	public String getDtoText() {
		return dtoText;
	}

	public void setDtoText(String dtoText) {
		this.dtoText = dtoText;
	}

	public String getDtoDescription() {
		return dtoDescription;
	}

	public void setDtoDescription(String dtoDescription) {
		this.dtoDescription = dtoDescription;
	}

	public String getMnemonic() {
		return mnemonic;
	}

	public void setMnemonic(String mnemonic) {
		this.mnemonic = mnemonic;
	}

	public Integer getDtoOrder() {
		return dtoOrder;
	}

	public void setDtoOrder(Integer dtoOrder) {
		this.dtoOrder = dtoOrder;
	}

	/**
	 * @return the dtoParent
	 */
	public Integer getDtoParent() {
		return dtoParent;
	}

	/**
	 * @param dtoParent
	 *            the dtoParent to set
	 */
	public void setDtoParent(Integer dtoParent) {
		this.dtoParent = dtoParent;
	}

	/**
	 * @return the dtoNameParent
	 */
	public String getDtoNameParent() {
		return dtoNameParent;
	}

	/**
	 * @param dtoNameParent
	 *            the dtoNameParent to set
	 */
	public void setDtoNameParent(String dtoNameParent) {
		this.dtoNameParent = dtoNameParent;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + dtoId;
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
		DtosDTO other = (DtosDTO) obj;
		if (dtoId != other.dtoId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DtosDTO [dtoId=" + dtoId + ", dtoName=" + dtoName + ", dtoText=" + dtoText + ", dtoDescription=" + dtoDescription + ", properties="
				+ properties + ", dtoList=" + dtoList + ", serviceId=" + serviceId + ", dtoOrder=" + dtoOrder + "]";
	}

}
