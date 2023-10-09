package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity

@Table(name = "vcc_services", schema = "cob_pac")
@NamedQueries({
		@NamedQuery(name = "Services.getServices", query = "select s from Services s")})

/** 
 * Class used to access the database using JPA
 * related table: vcc_services bdd: cob_pac
 * @author mcabay
 */
public class Services {
	/** Role code */
	@Id
	@Column(name = "ser_id")
	private String serviceId;
	
	
	@Column(name = "ser_description")
	private String serviceDescription;

	/*@OneToMany(mappedBy = "dtosServices", fetch = FetchType.EAGER)
	private List<Dtos> dtos;*/
	
	
	/** Property to declare the join with entity DefaultProductAdministrator */
	/*@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ser_id", referencedColumnName = "ser_id")*/
	//private Services services;

	@Override
	public String toString() {
		return "Services [serviceId=" + serviceId + ", serviceDescription="
				+ serviceDescription + "]";
	}

	/*public List<Dtos> getDtos() {
		return dtos;
	}

	public void setDtos(List<Dtos> dtos) {
		this.dtos = dtos;
	}*/

	/*public Services getServices() {
		return services;
	}

	public void setServices(Services services) {
		this.services = services;
	}*/

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
		result = prime
				* result
				+ ((serviceDescription == null) ? 0 : serviceDescription
						.hashCode());
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
		Services other = (Services) obj;
		if (serviceDescription == null) {
			if (other.serviceDescription != null)
				return false;
		} else if (!serviceDescription.equals(other.serviceDescription))
			return false;
		if (serviceId == null) {
			if (other.serviceId != null)
				return false;
		} else if (!serviceId.equals(other.serviceId))
			return false;
		return true;
	}

}
