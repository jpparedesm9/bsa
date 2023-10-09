package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "cl_tipo_documento", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "DocumentType.getDescription", query = "select dt.descriptionDocument from DocumentType dt where dt.idDocument = :code") })
/**
 * Class used to access the database using JPA
 * related table: cl_tipo_documento, bdd: cobis
 * @author bbuendia
 *
 */
public class DocumentType {
	
	@Id
	@Column(name = "td_codigo")
    private String idDocument;
	
	@Column (name = "td_descripcion")
	private String descriptionDocument;
	
	@OneToMany(mappedBy = "documentT")
	private List<Customer> customer;
	
	public DocumentType(){
				
	}

	public DocumentType(String idDocument, String descriptionDocument) {
		this.idDocument = idDocument;
		this.descriptionDocument = descriptionDocument;
	}

	public String getIdDocument() {
		return idDocument;
	}

	public void setIdDocument(String idDocument) {
		this.idDocument = idDocument;
	}

	public String getDescriptionDocument() {
		return descriptionDocument;
	}

	public void setDescriptionDocument(String descriptionDocument) {
		this.descriptionDocument = descriptionDocument;
	}	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idDocument == null) ? 0 : idDocument.hashCode());
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
		DocumentType other = (DocumentType) obj;
		if (idDocument == null) {
			if (other.idDocument != null)
				return false;
		} else if (!idDocument.equals(other.idDocument))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DocumentType [idDocument=" + idDocument
				+ ", descriptionDocument=" + descriptionDocument + "]";
	}

	
	

}
