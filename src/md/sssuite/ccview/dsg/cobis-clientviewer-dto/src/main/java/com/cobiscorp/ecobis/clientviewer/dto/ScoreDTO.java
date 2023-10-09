package com.cobiscorp.ecobis.clientviewer.dto;

import java.util.Date;

public class ScoreDTO {
	/**
	 * DTO which is used to obtain the score of the customer
	 * 
	 * @author aandy
	 */

	private Integer scoreCustomer;
	private Integer idCustomer;
	private Date changeDate;

	public ScoreDTO(Integer idCustomer, Integer scoreCustomer, Date changeDate) {
		super();
		this.setIdCustomer(idCustomer);
		this.setScoreCustomer(scoreCustomer);
		this.setChangeDate(changeDate);
	}

	public ScoreDTO() {

	}

	public Integer getScoreCustomer() {
		return scoreCustomer;
	}

	public void setScoreCustomer(Integer scoreCustomer) {
		this.scoreCustomer = scoreCustomer;
	}

	public Integer getIdCustomer() {
		return idCustomer;
	}

	public void setIdCustomer(Integer idCustomer) {
		this.idCustomer = idCustomer;
	}

	public Date getChangeDate() {
		return changeDate;
	}

	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}

}
