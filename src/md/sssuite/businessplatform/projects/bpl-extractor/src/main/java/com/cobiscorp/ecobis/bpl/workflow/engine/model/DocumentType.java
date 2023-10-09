package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * The persistent class for the wf_paso database table.
 * 
 */
@Entity
@Table(name = "wf_tipo_documento", schema = "cob_workflow")
public class DocumentType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "td_codigo_tipo_doc")
	private Integer idDocumentType;

	@Column(name = "td_nombre_tipo_doc")
	private String documentTypeName;

	@Column(name = "td_tipo_doc")
	private String documentType;

	@Column(name = "td_vigencia_doc")
	private String docValidity;

	@Column(name = "td_categoria_doc")
	private String docCategory;

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idDocumentType == null) ? 0 : idDocumentType.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DocumentType other = (DocumentType) obj;
		if (idDocumentType == null) {
			if (other.idDocumentType != null)
				return false;
		} else if (!idDocumentType.equals(other.idDocumentType))
			return false;
		return true;
	}

	public Integer getIdDocumentType() {
		return idDocumentType;
	}

	public void setIdDocumentType(Integer idDocumentType) {
		this.idDocumentType = idDocumentType;
	}

	public String getDocumentTypeName() {
		return documentTypeName;
	}

	public void setDocumentTypeName(String documentTypeName) {
		this.documentTypeName = documentTypeName;
	}

	public String getDocumentType() {
		return documentType;
	}

	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}

	public String getDocValidity() {
		return docValidity;
	}

	public void setDocValidity(String docValidity) {
		this.docValidity = docValidity;
	}

	public String getDocCategory() {
		return docCategory;
	}

	public void setDocCategory(String docCategory) {
		this.docCategory = docCategory;
	}

}