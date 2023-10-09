package com.cobiscorp.ecobis.cloud.service.dto.security;

public class Route {
	public int idEnte;
	public int idProceso;
	public int mode;

	public int getMode() {
		return mode;
	}

	public void setMode(int mode) {
		this.mode = mode;
	}

	public int getIdEnte() {
		return idEnte;
	}

	public void setIdEnte(int idEnte) {
		this.idEnte = idEnte;
	}

	public int getIdProceso() {
		return idProceso;
	}

	public void setIdProceso(int idProceso) {
		this.idProceso = idProceso;
	}

	public Route(int idEnte, int idProceso) {
		super();
		this.idEnte = idEnte;
		this.idProceso = idProceso;
	}

	public Route() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class Route {\n");
		sb.append("    idEnte: ").append(toIndentedString(idEnte)).append("\n");
		sb.append("    idProceso: ").append(toIndentedString(idProceso)).append("\n");
		sb.append("    mode: ").append(toIndentedString(mode)).append("\n");
		sb.append("}");
		return sb.toString();
	}

	/**
	 * Convert the given object to string with each line indented by 4 spaces (except the first line).
	 */
	private String toIndentedString(java.lang.Object o) {
		if (o == null) {
			return "null";
		}
		return o.toString().replace("\n", "\n    ");
	}

}
