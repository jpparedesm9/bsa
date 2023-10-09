package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@IdClass(ProductAdministratorId.class)
@Table(name = "vcc_product_admin", schema = "cob_pac")
@NamedQueries({
		@NamedQuery(name = "ProductAdministrator.getProductAdministratorByRole", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO(pm.idRole, pm.idProduct, pm.visible, pm.encrypted, pm.roleName, dpm.mnemonic, dpm.name, dpm.description, dpm.parent)"
				+ " from ProductAdministrator pm left join pm.defaultProductManager dpm"
				+ " where pm.idRole = :rolCode"),
		@NamedQuery(name = "ProductAdministrator.getAllRolesProductAdministrator", query = "select distinct pm.idRole, pm.roleName " 
				+ " from ProductAdministrator pm"),
				@NamedQuery(name = "ProductAdministrator.getProductAdministratorByDTOid", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO(pm.idRole, pm.idProduct, pm.visible, pm.encrypted, pm.roleName, dpm.mnemonic, dpm.name, dpm.description, dpm.parent)"
						+ " from ProductAdministrator pm left join pm.defaultProductManager dpm"
						+ " where pm.idProduct = :idProduct")})
@NamedNativeQueries({ @NamedNativeQuery(name = "ProductAdministrator.delete", query = "delete from cob_pac..vcc_product_admin where pr_rol_id = ?1") })

/** 
 * Class used to access the database using JPA
 * related table: vcc_product_admin bdd: cob_pac
 * @author dcumbal
 */
public class ProductAdministrator {
	/** Role code */
	@Id
	@Column(name = "pr_rol_id")
	private Integer idRole;
	
	/** Product code */
	@Id
	@Column(name = "prd_id")
	private Double idProduct;
    
	/** Flag indicating whether this is visible*/
	@Column(name = "pr_isvisible")
	private Byte visible;
	
	/** Flag indicating whether encryption*/
	@Column(name = "pr_isencrypted")
	private Byte encrypted;
	
	/** Role name  */
	@Column(name = "pr_rol_name")
	private String roleName;
    
	/** Product mnemonic */
	@Transient
	private String mnemonic;
	
	/** Product name */
	@Transient
	private String name;
	
	/** Product description */
	@Transient
	private String description;
	
	/** Code of the parent node in the hierarchy tree */
	@Transient
	private Double parent;

	/** Property to declare the join with entity DefaultProductAdministrator */
	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "prd_id", referencedColumnName = "prd_id") })
	private DefaultProductAdministrator defaultProductManager;

	public Integer getIdRole() {
		return idRole;
	}

	public void setIdRole(Integer idRole) {
		this.idRole = idRole;
	}

	public Double getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(Double idProduct) {
		this.idProduct = idProduct;
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

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
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

	public DefaultProductAdministrator getDefaultProductManager() {
		return defaultProductManager;
	}

	public void setDefaultProductManager(
			DefaultProductAdministrator defaultProductManager) {
		this.defaultProductManager = defaultProductManager;
	}

	public ProductAdministrator() {

	}

	public ProductAdministrator(Integer idRole, Double idProduct, Byte visible,
			Byte encrypted, String roleName, String mnemonic, String name,
			String description, Double parent) {
		super();
		this.idRole = idRole;
		this.idProduct = idProduct;
		this.visible = visible;
		this.encrypted = encrypted;
		this.roleName = roleName;
		this.mnemonic = mnemonic;
		this.name = name;
		this.description = description;
		this.parent = parent;
	}

	public ProductAdministrator(Integer idRole, String roleName) {
		super();
		this.idRole = idRole;
		this.roleName = roleName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idProduct == null) ? 0 : idProduct.hashCode());
		result = prime * result + ((idRole == null) ? 0 : idRole.hashCode());
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
		ProductAdministrator other = (ProductAdministrator) obj;
		if (idProduct == null) {
			if (other.idProduct != null)
				return false;
		} else if (!idProduct.equals(other.idProduct))
			return false;
		if (idRole == null) {
			if (other.idRole != null)
				return false;
		} else if (!idRole.equals(other.idRole))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProductManager [idRole=" + idRole + ", idProduct=" + idProduct
				+ ", visible=" + visible + ", encrypted=" + encrypted
				+ ", roleName=" + roleName + ", mnemonic=" + mnemonic
				+ ", name=" + name + ", description=" + description
				+ ", parent=" + parent + "]";
	}

}
