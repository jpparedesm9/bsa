package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "vcc_pro_admin_default", schema = "cob_pac")
@NamedQueries({
		@NamedQuery(name = "DefaultProductAdministrator.getAllProductAdministratorDefault", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO(dpm.idProduct, dpm.idDtoFk, dpm.mnemonic, dpm.name, dpm.description, dpm.parent, dpm.order)"
				+ " from DefaultProductAdministrator dpm "),
		@NamedQuery(name = "DefaultProductAdministrator.getAllProductAdministratorDefaultDinamic", query = "select dpm from DefaultProductAdministrator dpm where dpm.parent = -1 order by dpm.idProduct"),
		@NamedQuery(name = "DefaultProductAdministrator.getAllProductAdministratorDefaultDinamicByType", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO(dpm.idProduct, dpm.idDtoFk, dpm.mnemonic, dpm.name, dpm.description, dpm.parent, dpm.typeClient, dpm.order) from DefaultProductAdministrator dpm inner join dpm.conditionDefaultProductParent dpmp where dpm.typeClient =:typeClient and dpmp.typeClient =:typeClientParent and dpmp.parent =:parent"),
		@NamedQuery(name = "DefaultProductAdministrator.getAllProductAdministratorDefaultDinamicByNullType", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO(dpm.idProduct, dpm.idDtoFk, dpm.mnemonic, dpm.name, dpm.description, dpm.parent, dpm.typeClient, dpm.order) from DefaultProductAdministrator dpm inner join dpm.conditionDefaultProductParent dpmp where dpm.typeClient is null and dpmp.typeClient =:typeClientParent and dpmp.parent =:parent"),
		@NamedQuery(name = "DefaultProductAdministrator.getByParent", query = "select dpm.dtosProductManager.dtoId from DefaultProductAdministrator dpm where dpm.conditionDefaultProductParent.mnemonic =:mnemonic"),
		@NamedQuery(name = "DefaultProductAdministrator.deleteDefaultProductAdministratorById", query = "delete from DefaultProductAdministrator dpm where dpm.idProduct=:idProduct"),
		@NamedQuery(name = "DefaultProductAdministrator.updateDefaultProductAdministratorById", query = "update DefaultProductAdministrator dpm set dpm.idDTOFk =:entity.idDTOFk, dpm.mnemonic=:entity.mnemonic, "
				+ " dpm.name=:entity.name, dpm.description=:entity.description, dpm.parent=:entity.parent, dpm.typeClient =:entity.typeClient, dpm.order:=entity.order where dpm.idProduct=:entity.idProduct"),
		@NamedQuery(name = "DefaultProductAdministrator.getProductAdministratorDefaultDinamicByParent", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO(dpm.idProduct, dpm.idDtoFk, dpm.mnemonic, dpm.name, dpm.description, dpm.parent, dpm.typeClient, dpm.order)"
				+ " from DefaultProductAdministrator dpm where dpm.parent = :parent order by dpm.order "), 
		@NamedQuery(name = "DefaultProductAdministrator.getProductAdministratorDefaultByIdProduct", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO(dpm.idProduct, dpm.idDtoFk, dpm.mnemonic, dpm.name, dpm.description, dpm.parent, dpm.typeClient, dpm.order) from DefaultProductAdministrator dpm where dpm.idProduct = :idProduct ")})
/**
 * Class used to access the database using JPA
 * related table: vcc_pro_admin_default bdd: cob_pac
 * @author bbuendia
 *
 */
public class DefaultProductAdministrator {

	/** Product code */
	@Id
	@Column(name = "prd_id")
	private Double idProduct;

	/** Id DTO */
	@Column(name = "dto_id_fk")
	private Integer idDtoFk;

	/** Product mnemonic */
	@Column(name = "prd_mnemonic")
	private String mnemonic;

	/** Product name */
	@Column(name = "prd_name")
	private String name;

	/** Product description */
	@Column(name = "prd_description")
	private String description;

	/** Code of the parent node in the hierarchy tree */
	@Column(name = "prd_parent")
	private Double parent;

	@Column(name = "prd_type_client")
	private String typeClient;

	@Column(name = "prd_order")
	private Integer order;

	/** Role code */
	@Transient
	private Integer idRol;

	/** Flag indicating whether this is visible */
	@Transient
	private Byte visible;

	/** Flag indicating whether encryption */
	@Transient
	private Byte encrypted;

	/** Role description */
	@Transient
	private String defaultRoleDescription;

	// bi-directional many-to-one association to conditionDefaultProductParent
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "prd_parent")
	private DefaultProductAdministrator conditionDefaultProductParent;

	// bi-directional many-to-one association to conditionDefaultProductParent
	@OneToMany(mappedBy = "conditionDefaultProductParent", fetch = FetchType.EAGER)
	private List<DefaultProductAdministrator> conditionDefaultProductSons;

	/** Property to declare the join with entity ProductAdministrator */
	@OneToMany(mappedBy = "defaultProductManager")
	private List<ProductAdministrator> productManager;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "dto_id_fk", referencedColumnName = "dto_id")
	private Dtos dtosProductManager;

	public DefaultProductAdministrator getConditionDefaultProductParent() {
		return conditionDefaultProductParent;
	}

	public void setConditionDefaultProductParent(DefaultProductAdministrator conditionDefaultProductParent) {
		this.conditionDefaultProductParent = conditionDefaultProductParent;
	}

	public List<DefaultProductAdministrator> getConditionDefaultProductSons() {
		return conditionDefaultProductSons;
	}

	public void setConditionDefaultProductSons(List<DefaultProductAdministrator> conditionDefaultProductSons) {
		this.conditionDefaultProductSons = conditionDefaultProductSons;
	}

	public Dtos getDtosProductManager() {
		return dtosProductManager;
	}

	public void setDtosProductManager(Dtos dtosProductManager) {
		this.dtosProductManager = dtosProductManager;
	}

	public Double getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(Double idProduct) {
		this.idProduct = idProduct;
	}

	public String getMnemonic() {
		return mnemonic;
	}

	public void setMnemonic(String mnemonic) {
		this.mnemonic = mnemonic;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getParent() {
		return parent;
	}

	public void setParent(Double parent) {
		this.parent = parent;
	}

	public Integer getIdRol() {
		return idRol;
	}

	public void setIdRol(Integer idRol) {
		this.idRol = idRol;
	}

	public Byte getVisible() {
		return visible;
	}

	public void setVisible(Byte visible) {
		this.visible = visible;
	}

	public Byte getEncrypted() {
		return encrypted;
	}

	public void setEncrypted(Byte encrypted) {
		this.encrypted = encrypted;
	}

	public String getDefaultRoleDescription() {
		return defaultRoleDescription;
	}

	public String getTypeClient() {
		return typeClient;
	}

	public void setTypeClient(String typeClient) {
		this.typeClient = typeClient;
	}

	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	public Integer getIdDtoFk() {
		return idDtoFk;
	}

	public void setIdDtoFk(Integer idDtoFk) {
		this.idDtoFk = idDtoFk;
	}

	public void setDefaultRoleDescription(String defaultRoleDescription) {
		this.defaultRoleDescription = defaultRoleDescription;
	}

	public List<ProductAdministrator> getProductManager() {
		return productManager;
	}

	public void setProductManager(List<ProductAdministrator> productManager) {
		this.productManager = productManager;
	}

	public DefaultProductAdministrator() {

	}

	public DefaultProductAdministrator(Double idProduct, Integer idDtoFk, String mnemonic, String name, String description, Double parent,
			Integer order) {
		this.idProduct = idProduct;
		this.mnemonic = mnemonic;
		this.name = name;
		this.description = description;
		this.parent = parent;
		this.encrypted = 0;
		this.visible = 1;
		this.idRol = -1;
		this.defaultRoleDescription = "ROL_DEFAULT_VCC";
		this.order = order;
		this.idDtoFk = idDtoFk;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idProduct == null) ? 0 : idProduct.hashCode());
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
		DefaultProductAdministrator other = (DefaultProductAdministrator) obj;
		if (idProduct == null) {
			if (other.idProduct != null)
				return false;
		} else if (!idProduct.equals(other.idProduct))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DefaultProductManeger [idProduct=" + idProduct + ", mnemonic=" + mnemonic + ", name=" + name + ", description=" + description
				+ ", parent=" + parent + ", idRol=" + idRol + ", visible=" + visible + ", encrypted=" + encrypted + ", defaultRoleDescription="
				+ defaultRoleDescription + ", conditionDefaultProductSons=" + conditionDefaultProductSons + conditionDefaultProductSons + ", order="
				+ order + ", idDtoFk=" + idDtoFk + "]";
	}

}
