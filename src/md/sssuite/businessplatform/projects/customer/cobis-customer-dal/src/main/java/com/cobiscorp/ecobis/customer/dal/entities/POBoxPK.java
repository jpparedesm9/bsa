package com.cobiscorp.ecobis.customer.dal.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

public class POBoxPK implements Serializable{

	private static final long serialVersionUID = 1L;

		@Id
	    @Column(name="cs_ente")
	    private Integer entity;
	    
	    @Id
	    @Column(name="cs_casilla")
		private Integer box;


		public Integer getEntity() {
			return entity;
		}

		public void setEntity(Integer entity) {
			this.entity = entity;
		}

		public Integer getBox() {
			return box;
		}

		public void setBox(Integer box) {
			this.box = box;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result
					+ ((entity == null) ? 0 : entity.hashCode());
			result = prime * result
					+ ((box == null) ? 0 : box.hashCode());
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
			POBoxPK other = (POBoxPK) obj;
			if (entity == null) {
				if (other.entity != null)
					return false;
			} else if (!entity.equals(other.entity))
				return false;
			if (box == null) {
				if (other.box != null)
					return false;
			} else if (!box.equals(other.box))
				return false;
			return true;
		}

		
	    

}
