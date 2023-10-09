package com.cobis.cloud.lcr.b2b.service.dto;

public class RevolvingDocumentResponse {

	private int id_inst_proc;
	private int codigo_tipo_doc;
	private String nombre_doc;

	public int getId_inst_proc() {
		return id_inst_proc;
	}

	public void setId_inst_proc(int id_inst_proc) {
		this.id_inst_proc = id_inst_proc;
	}

	public int getCodigo_tipo_doc() {
		return codigo_tipo_doc;
	}

	public void setCodigo_tipo_doc(int codigo_tipo_doc) {
		this.codigo_tipo_doc = codigo_tipo_doc;
	}

	public String getNombre_doc() {
		return nombre_doc;
	}

	public void setNombre_doc(String nombre_doc) {
		this.nombre_doc = nombre_doc;
	}

	@Override
	public String toString() {
		return "RevolvingDocumentResponse [id_inst_proc=" + id_inst_proc + ", codigo_tipo_doc=" + codigo_tipo_doc + ", nombre_doc=" + nombre_doc + "]";
	}

}
