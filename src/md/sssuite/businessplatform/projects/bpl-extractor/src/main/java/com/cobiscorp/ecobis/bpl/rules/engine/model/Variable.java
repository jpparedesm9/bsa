package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the wf_variable database table.
 * 
 */
@Entity
@Table(name = "wf_variable", schema = "cob_workflow")
public class Variable implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "vb_codigo_variable")
	private short codigoVariable;

	@Column(name = "vb_desc_variable")
	private String descVariable;

	@Column(name = "vb_abrev_variable")
	private String abreviaturaVariable;

	@Column(name = "vb_nombre_variable")
	private String nombreVariable;

	@Column(name = "vb_tipo_datos")
	private String tipoDatos;

	@Column(name = "vb_val_variable")
	private String valVariable;

	@Column(name = "vb_type")
	private String tipoVariable;

	@Column(name = "vb_subType")
	private String subTipoVariable;

	@Column(name = "vb_catalogo")
	private String catalogo;

	@Column(name = "vb_value_min")
	private String valueMin;

	@Column(name = "vb_value_operator")
	private String valueOperator;

	@Column(name = "vb_value_max")
	private String valueMax;

	@Column(name = "vb_id_programa")
	private int idPrograma;

	// bi-directional many-to-one association to Programa
	@ManyToOne(fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "vb_id_programa", insertable = false, updatable = false)
	private Programa programa;

	@Column(name = "vb_seudo_catalogo")
	private int idSeudoCatalogo;

	// bi-directional many-to-one association to Programa
	@ManyToOne(fetch = FetchType.EAGER, optional = true)
	@JoinColumn(name = "vb_seudo_catalogo", insertable = false, updatable = false)
	private Programa seudoCatalogo;

	// bi-directional many-to-one association to ConditionRule
	@OneToMany(mappedBy = "variable", cascade = CascadeType.ALL)
	private List<ConditionRule> conditionRules;

	// bi-directional many-to-one association to ConditionRule
	@OneToMany(mappedBy = "variable", cascade = CascadeType.ALL)
	private List<ConditionRule> variableProcess;

	public Variable() {
	}

	public Variable(short codigoVariable, String descVariable, String abreviaturaVariable, String nombreVariable) {
		this.codigoVariable = codigoVariable;
		this.descVariable = descVariable;
		this.abreviaturaVariable = abreviaturaVariable;
		this.nombreVariable = nombreVariable;
	}

	public short getCodigoVariable() {
		return this.codigoVariable;
	}

	public void setCodigoVariable(short codigoVariable) {
		this.codigoVariable = codigoVariable;
	}

	public String getDescVariable() {
		return this.descVariable;
	}

	public void setDescVariable(String descVariable) {
		this.descVariable = descVariable;
	}

	public String getNombreVariable() {
		return this.nombreVariable;
	}

	public void setNombreVariable(String nombreVariable) {
		this.nombreVariable = nombreVariable;
	}

	public String getTipoDatos() {
		return this.tipoDatos;
	}

	public void setTipoDatos(String tipoDatos) {
		this.tipoDatos = tipoDatos;
	}

	public String getValVariable() {
		return this.valVariable;
	}

	public void setValVariable(String valVariable) {
		this.valVariable = valVariable;
	}

	public Programa getPrograma() {
		return this.programa;
	}

	public void setPrograma(Programa programa) {
		this.programa = programa;
	}

	public void setTipoVariable(String tipoVariable) {
		this.tipoVariable = tipoVariable;
	}

	public String getTipoVariable() {
		return tipoVariable;
	}

	public void setSubTipoVariable(String subTipoVariable) {
		this.subTipoVariable = subTipoVariable;
	}

	public String getSubTipoVariable() {
		return subTipoVariable;
	}

	public void setCatalogo(String catalogo) {
		this.catalogo = catalogo;
	}

	public String getCatalogo() {
		return catalogo;
	}

	public void setSeudoCatalogo(Programa seudoCatalogo) {
		this.seudoCatalogo = seudoCatalogo;
	}

	public Programa getSeudoCatalogo() {
		return seudoCatalogo;
	}

	public String getValueMin() {
		return valueMin;
	}

	public void setValueMin(String valueMin) {
		this.valueMin = valueMin;
	}

	public String getValueOperator() {
		return valueOperator;
	}

	public void setValueOperator(String valueOperator) {
		this.valueOperator = valueOperator;
	}

	public String getValueMax() {
		return valueMax;
	}

	public void setValueMax(String valueMax) {
		this.valueMax = valueMax;
	}

	public List<ConditionRule> getConditionRules() {
		return this.conditionRules;
	}

	public void setConditionRules(List<ConditionRule> conditionRules) {
		this.conditionRules = conditionRules;
	}

	public void setVariableProcess(List<ConditionRule> variableProcess) {
		this.variableProcess = variableProcess;
	}

	public List<ConditionRule> getVariableProcess() {
		return variableProcess;
	}

	public String getAbreviaturaVariable() {
		return this.abreviaturaVariable;
	}

	public void setAbreviaturaVariable(String abreviaturaVariable) {
		this.abreviaturaVariable = abreviaturaVariable;
	}

	/**
	 * @return the idPrograma
	 */
	public int getIdPrograma() {
		return idPrograma;
	}

	/**
	 * @param idPrograma
	 *            the idPrograma to set
	 */
	public void setIdPrograma(int idPrograma) {
		this.idPrograma = idPrograma;
	}

	/**
	 * @return the idSeudoCatalogo
	 */
	public int getIdSeudoCatalogo() {
		return idSeudoCatalogo;
	}

	/**
	 * @param idSeudoCatalogo
	 *            the idSeudoCatalogo to set
	 */
	public void setIdSeudoCatalogo(int idSeudoCatalogo) {
		this.idSeudoCatalogo = idSeudoCatalogo;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Variable [codigoVariable=" + codigoVariable + ", descVariable=" + descVariable + ", abreviaturaVariable=" + abreviaturaVariable
				+ ", nombreVariable=" + nombreVariable + ", tipoDatos=" + tipoDatos + ", valVariable=" + valVariable + ", tipoVariable="
				+ tipoVariable + ", subTipoVariable=" + subTipoVariable + ", catalogo=" + catalogo + ", valueMin=" + valueMin + ", valueOperator="
				+ valueOperator + ", valueMax=" + valueMax + ", programa=" + programa + ", seudoCatalogo=" + seudoCatalogo + ", conditionRules="
				+ conditionRules + ", variableProcess=" + variableProcess + "]";
	}

}