package com.cobiscorp.ecobis.fpm.portfolio.model;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


@Entity
@Table(name="ca_rubro_op",schema="cob_cartera")
@IdClass(ItemsOperationPortfolioIdDef.class)
@NamedQueries({
	@NamedQuery(name="ItemsOperationPorfolioDef.FindSpecificItemOperation",query="select iopd from ItemsOperationPortfolioDef iopd" +
			" where iopd.operation = :operation and  iopd.reference = :reference")
	})
public class ItemsOperationPortfolioDef {
	@Id
	@Column(name="ro_operacion")
	private int operation;
	@Id
	@Column(name="ro_concepto")
	private String concept;
	
	@Column(name="ro_referencial")
	private String reference;
	
	public ItemsOperationPortfolioDef() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ItemsOperationPortfolioDef(int operation, String concept,
			String reference) {
		super();
		this.operation = operation;
		this.concept = concept;
		this.reference = reference;
	}

	public int getOperation() {
		return operation;
	}

	public void setOperation(int operation) {
		this.operation = operation;
	}

	public String getConcept() {
		return concept;
	}

	public void setConcept(String concept) {
		this.concept = concept;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((concept == null) ? 0 : concept.hashCode());
		result = prime * result + operation;
		result = prime * result
				+ ((reference == null) ? 0 : reference.hashCode());
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
		ItemsOperationPortfolioDef other = (ItemsOperationPortfolioDef) obj;
		if (concept == null) {
			if (other.concept != null)
				return false;
		} else if (!concept.equals(other.concept))
			return false;
		if (operation != other.operation)
			return false;
		if (reference == null) {
			if (other.reference != null)
				return false;
		} else if (!reference.equals(other.reference))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ItemsOperationPortfolioDef [operation=" + operation
				+ ", concept=" + concept + ", reference=" + reference + "]";
	}
	
	
	
	

}
