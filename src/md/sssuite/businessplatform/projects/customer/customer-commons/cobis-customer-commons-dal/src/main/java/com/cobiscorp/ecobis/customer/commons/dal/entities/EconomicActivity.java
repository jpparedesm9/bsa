package com.cobiscorp.ecobis.customer.commons.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "cl_actividad_economica", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "EconomicActivity.getEconomicActivitiesByCustomer", query = "SELECT new com.cobiscorp.ecobis.customer.commons.dto.EconomicActivityDTO(ea.sequential,"
		+ "e.code,a.description,sa.description, ea.description, s.description, ss.description, ea.main)"
		+ " from EconomicActivity ea left join ea.entity e join ea.activity a join ea.subActivity sa join ea.sector s join ea.subSector ss"
		+ " where e.code = :customerCode ") })
/**
 * Class used to access the database using JPA
 * related table: cl_actividad_economica, bdd: cobis
 *
 */
public class EconomicActivity {

	@Id
	@Column(name = "ae_secuencial")
	private Integer sequential;

	@Column(name = "ae_ente")
	private Integer idEntity;

	@ManyToOne
	@JoinColumn(name = "ae_ente", referencedColumnName = "en_ente")
	private Customer entity;

	@Column(name = "ae_actividad")
	private String idActivity;

	@ManyToOne
	@JoinColumn(name = "ae_actividad", referencedColumnName = "ac_codigo")
	private Activity activity;

	@Column(name = "ae_subactividad")
	private String idSubActivity;

	@ManyToOne
	@JoinColumn(name = "ae_subactividad", referencedColumnName = "se_codigo")
	private SubActivity subActivity ;
	
	@Column(name = "ae_desc_actividad")
	private String description;
	
	@Column(name = "ae_sector")
	private String idSector;

	@ManyToOne
	@JoinColumn(name = "ae_sector", referencedColumnName = "se_codigo")
	private EconomicSector sector;
	
	@Column(name = "ae_subsector")
	private String idSubSector;

	@ManyToOne
	@JoinColumn(name = "ae_subsector", referencedColumnName = "se_codigo")
	private SubSector subSector;

	@Column(name = "ae_principal")
	private String main;

	public EconomicActivity() {
	}

	public EconomicActivity(Integer sequential, Integer idEntity,
			String nameEntity, String idActivity, String descActivity,
			String idSector, String descSector, String idSubActivity,
			String SubActivity, String descSubActivity, String description,
			String idSubSector, String descSubSector, String main) {
		this.sequential = sequential;
		this.entity = new Customer();
		this.entity.setName(nameEntity);
		this.idActivity = idActivity;
		this.activity = new Activity();
		this.activity.setDescription(descActivity);
		this.idSubActivity = idSubActivity;
		this.subActivity = new SubActivity();
		this.subActivity.setDescription(descSubActivity);
		this.description = description;
		this.idSector = idSector;
		this.sector = new EconomicSector();
		this.sector.setDescription(descSector);	
		//this.subActivity = subActivity;		
		this.idSubSector = idSubSector;
		this.subSector = new SubSector();
		this.subSector.setDescription(descSubSector);
		this.main = main;
	}

	public int getSequential() {
		return sequential;
	}

	public void setSequential(int sequential) {
		this.sequential = sequential;
	}

	public Customer getEntity() {
		return entity;
	}

	public void setEntity(Customer entity) {
		this.entity = entity;
	}

	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}
	
	public SubActivity getSubActivity() {
		return subActivity;
	}

	public void setSubActivity(SubActivity subActivity) {
		this.subActivity = subActivity;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public EconomicSector getSector() {
		return sector;
	}

	public void setSector(EconomicSector sector) {
		this.sector = sector;
	}

	public SubSector getSubSector() {
		return subSector;
	}

	public void setSubSector(SubSector subSector) {
		this.subSector = subSector;
	}

	public String getMain() {
		return main;
	}

	public void setMain(String main) {
		this.main = main;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((sequential == null) ? 0 : sequential.hashCode());
		result = prime * result
				+ ((idEntity == null) ? 0 : idEntity.hashCode());
		result = prime * result
				+ ((idActivity == null) ? 0 : idActivity.hashCode());
		result = prime * result
				+ ((idSubActivity == null) ? 0 : idSubActivity.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result
				+ ((idSector == null) ? 0 : idSector.hashCode());
		result = prime * result
				+ ((idSubSector == null) ? 0 : idSubSector.hashCode());
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
		EconomicActivity other = (EconomicActivity) obj;
		if (sequential == null) {
			if (other.sequential != null)
				return false;
		} else if (!sequential.equals(other.sequential))
			return false;
		if (idEntity == null) {
			if (other.idEntity != null)
				return false;
		} else if (!idEntity.equals(other.idEntity))
			return false;
		if (idActivity == null) {
			if (other.idActivity != null)
				return false;
		} else if (!idActivity.equals(other.idActivity))
			return false;
		if (idSubActivity == null) {
			if (other.idSubActivity != null)
				return false;
		} else if (!idSubActivity.equals(other.idSubActivity))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (idSector == null) {
			if (other.idSector != null)
				return false;
		} else if (!idSector.equals(other.idSector))
			return false;
		if (idSubSector == null) {
			if (other.idSubSector != null)
				return false;
		} else if (!idSubSector.equals(other.idSubSector))
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
		return "Activity [sequential=" + sequential + ", idEntity=" + idEntity
				+ ", idActivity=" + idActivity + ", idSubActivity=" + idSubActivity + ", description"+ description
				+ ", idSector=" + idSector + ", idSubSector=" + idSubSector
				+ ", main=" + main + "]";
	}
}
