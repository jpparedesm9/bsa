package com.cobiscorp.ecobis.clientviewer.admin.dto;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * DTO that obtains information from services, dtos and properties 
 * @author mcabay
 *
 */
public class ServicesDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String serviceId;
	private String serviceDescription;
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getServiceDescription() {
		return serviceDescription;
	}
	public void setServiceDescription(String serviceDescription) {
		this.serviceDescription = serviceDescription;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((serviceId == null) ? 0 : serviceId.hashCode());
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
		ServicesDTO other = (ServicesDTO) obj;
		if (serviceId == null) {
			if (other.serviceId != null)
				return false;
		} else if (!serviceId.equals(other.serviceId))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "ServicesDTO [serviceId=" + serviceId + ", serviceDescription="
				+ serviceDescription + "]";
	}
	
}
