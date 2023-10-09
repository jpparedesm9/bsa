package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class CaratulaContratoClausulaDTO {
	
	private String campo;
	private List<DatosOperacionDTO> datosOperacionDTO;

	public String getCampo() {
		return campo;
	}

	public void setCampo(String campo) {
		this.campo = campo;
	}

	public List<DatosOperacionDTO> getDatosOperacionDTO() {
		return datosOperacionDTO;
	}

	public void setDatosOperacionDTO(List<DatosOperacionDTO> datosOperacionDTO) {
		this.datosOperacionDTO = datosOperacionDTO;
	}
	

}
