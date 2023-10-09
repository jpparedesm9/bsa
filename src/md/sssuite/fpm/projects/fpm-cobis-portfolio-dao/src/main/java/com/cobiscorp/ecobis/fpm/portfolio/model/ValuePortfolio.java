package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

@Entity
//@Table(name="ca_valor", schema="cob_cartera")
@Table(name="ca_valor_view", schema="cob_cartera")

@NamedQueries({
	@NamedQuery(name="ValuePortfolio.FindAll", query="Select vp from ValuePortfolio vp"),
	@NamedQuery(name="ValuePortfolio.FindByType", query="Select vp.type from ValuePortfolio vp where vp.type = :type")
})
public class ValuePortfolio {
	
	@Id
	@TableGenerator(name="ValuePortfolioGenerator", table="CL_SEQNOS_JAVA", schema="cobis", pkColumnName="TABLA", valueColumnName="SIGUIENTE", pkColumnValue="ca_valor", initialValue=1, allocationSize=100)
	@GeneratedValue(strategy=GenerationType.TABLE, generator="ValuePortfolioGenerator")
	@Column(name="va_tipo")
	private String type;
	@Column(name="va_descripcion")
	private String description;
	@Column(name="va_clase")
	private String vpClass;
	@Column(name="va_prime")
	private String prime;
	
	public ValuePortfolio(String type, String description, String vpClass,
			String prime) {
		this.type = type;
		this.description = description;
		this.vpClass = vpClass;
		this.prime = prime;
	}
	
	

	public ValuePortfolio(String vpClass, String prime) {
		this.vpClass = vpClass;
		this.prime = prime;
	}



	public ValuePortfolio() {
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getVpClass() {
		return vpClass;
	}

	public void setVpClass(String vpClass) {
		this.vpClass = vpClass;
	}

	public String getPrime() {
		return prime;
	}

	public void setPrime(String prime) {
		this.prime = prime;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ValuePortfolio other = (ValuePortfolio) obj;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	public String toString() {
		return "ValuePortfolio [type=" + type + ", description=" + description
				+ ", vpClass=" + vpClass + ", prime=" + prime + "]";
	}
}
