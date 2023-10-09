package com.cobiscorp.ecobis.bpl.cobis.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the wf_actividad database table.
 * 
 */
@Entity
@Table(name = "an_component", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "Component.findByName", query = "select c from Component c where c.name=:name"),
	@NamedQuery(name = "Component.findMaxId", query = "select max(c.idComponent) from Component c")})
public class Component implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "co_id")
	private Integer idComponent;

	@Column(name = "co_mo_id")
	private Integer idModule;

	@Column(name = "co_name")
	private String name;

	@Column(name = "co_class")
	private String className;

	@Column(name = "co_namespace")
	private String namespace;

	@Column(name = "co_ct_id")
	private String ct;

	@Column(name = "co_arguments")
	private String arguments;

	@Column(name = "co_prod_name")
	private String nameProduct;

	public Component() {
	}

	/**
	 * @return the idComponent
	 */
	public Integer getIdComponent() {
		return idComponent;
	}

	/**
	 * @param idComponent
	 *            the idComponent to set
	 */
	public void setIdComponent(Integer idComponent) {
		this.idComponent = idComponent;
	}

	/**
	 * @return the idModule
	 */
	public Integer getIdModule() {
		return idModule;
	}

	/**
	 * @param idModule
	 *            the idModule to set
	 */
	public void setIdModule(Integer idModule) {
		this.idModule = idModule;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the className
	 */
	public String getClassName() {
		return className;
	}

	/**
	 * @param className
	 *            the className to set
	 */
	public void setClassName(String className) {
		this.className = className;
	}

	/**
	 * @return the namespace
	 */
	public String getNamespace() {
		return namespace;
	}

	/**
	 * @param namespace
	 *            the namespace to set
	 */
	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}

	/**
	 * @return the ct
	 */
	public String getCt() {
		return ct;
	}

	/**
	 * @param ct
	 *            the ct to set
	 */
	public void setCt(String ct) {
		this.ct = ct;
	}

	/**
	 * @return the arguments
	 */
	public String getArguments() {
		return arguments;
	}

	/**
	 * @param arguments
	 *            the arguments to set
	 */
	public void setArguments(String arguments) {
		this.arguments = arguments;
	}

	/**
	 * @return the nameProduct
	 */
	public String getNameProduct() {
		return nameProduct;
	}

	/**
	 * @param nameProduct
	 *            the nameProduct to set
	 */
	public void setNameProduct(String nameProduct) {
		this.nameProduct = nameProduct;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdComponent() == null ? super.hashCode() : this.getIdComponent().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof Component)) {
			return false;
		}
		Component entity = (Component) object;
		if ((this.getIdComponent() == null && entity.getIdComponent() != null)
				|| (this.getIdComponent() != null && !this.getIdComponent().equals(entity.getIdComponent()))) {
			return false;
		}
		return true;
	}
}