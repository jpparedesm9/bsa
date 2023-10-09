package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the bpl_rule database table.
 * 
 */

@Entity
@Table(name = "bpl_rule_exceptions", schema = "cob_pac")
@NamedQuery(name = "RuleException.getAllExceptions", query = "select re from RuleException re where re.idConditionRuleResult = :id")
public class RuleException implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "re_id_exception")
	private int id;

	@Column(name = "cr_id_result")
	private int idConditionRuleResult;

	@Column(name = "re_id_customer")
	private int idCustomer;

	@Column(name = "re_id_card")
	private String idCard;

	@Column(name = "re_date_before")
	private Date dateBefore;

	@Column(name = "re_date_after")
	private Date dateAfter;

	@Column(name = "re_status")
	private String status;

	@Column(name = "re_result")
	private String result;

	@Column(name = "re_result_1")
	private String result1;

	@Column(name = "re_result_2")
	private String result2;

	@Column(name = "re_result_3")
	private String result3;

	@Column(name = "re_result_4")
	private String result4;
	
	@Column(name = "re_product")
	private String product;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdCustomer() {
		return idCustomer;
	}

	public void setIdCustomer(int idCustomer) {
		this.idCustomer = idCustomer;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public Date getDateBefore() {
		return dateBefore;
	}

	public void setDateBefore(Date dateBefore) {
		this.dateBefore = dateBefore;
	}

	public Date getDateAfter() {
		return dateAfter;
	}

	public void setDateAfter(Date dateAfter) {
		this.dateAfter = dateAfter;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public RuleException() {

	}

	public int getIdConditionRuleResult() {
		return idConditionRuleResult;
	}

	public void setIdConditionRuleResult(int idConditionRuleResult) {
		this.idConditionRuleResult = idConditionRuleResult;
	}

	public String getResult1() {
		return result1;
	}

	public void setResult1(String result1) {
		this.result1 = result1;
	}

	public String getResult2() {
		return result2;
	}

	public void setResult2(String result2) {
		this.result2 = result2;
	}

	public String getResult3() {
		return result3;
	}

	public void setResult3(String result3) {
		this.result3 = result3;
	}

	public String getResult4() {
		return result4;
	}

	public void setResult4(String result4) {
		this.result4 = result4;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}
}