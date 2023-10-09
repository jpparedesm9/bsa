package com.cobiscorp.ecobis.clientviewer.dto;

/**
 * DTO which is used in the method prepareProductsData 
 * @author bbuendia
 *
 */
public class PrepareDataDTO {

	private String spid;
	private String sesn;

	public PrepareDataDTO() {
	}

	public PrepareDataDTO(String spid, String sesn) {
		super();
		this.spid = spid;
		this.sesn = sesn;
	}

	public String getSpid() {
		return spid;
	}

	public void setSpid(String spid) {
		this.spid = spid;
	}

	public String getSesn() {
		return sesn;
	}

	public void setSesn(String sesn) {
		this.sesn = sesn;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((sesn == null) ? 0 : sesn.hashCode());
		result = prime * result + ((spid == null) ? 0 : spid.hashCode());
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
		PrepareDataDTO other = (PrepareDataDTO) obj;
		if (sesn == null) {
			if (other.sesn != null)
				return false;
		} else if (!sesn.equals(other.sesn))
			return false;
		if (spid == null) {
			if (other.spid != null)
				return false;
		} else if (!spid.equals(other.spid))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "PrepareDataResponse [spid=" + spid + ", sesn=" + sesn + "]";
	}
}
