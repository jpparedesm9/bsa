package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
//@IdClass(ScoreId.class)
@Table(name = "cr_his_calif", schema = "cob_credito")

@NamedQueries({ @NamedQuery(name = "Score.getScoreCustomer", 
query = " select  new com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO(s.idCustomer, s.scoreCustomer, s.changeDate) "
+ " from Score s "
+ " where s.idCustomer = :idCustomer "
+ " and s.changeDate = (select max(s1.changeDate) from Score s1 where s1.idCustomer = :idCustomer) ") })

/**
 * Class used to access the database using JPA
 * related table: cr_his_calif bdd: cob_credito
 * @author aandy
 *
 */

public class Score {
	
	@Id
	@Column(name = "hc_ente")
	private Integer idCustomer;
	
	//@Id
	@Column(name = "hc_historia")
	private Integer scoreHistory;
	
	@Column(name = "hc_calificacion")
	private Integer scoreCustomer;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "hc_fecha_cambio")
	private Date changeDate;

	private String scoreDescription;
	
	public Integer getIdCustomer() {
		return idCustomer;
	}

	public void setIdCustomer(Integer idCustomer) {
		this.idCustomer = idCustomer;
	}

	public Integer getScoreHistory() {
		return scoreHistory;
	}

	public void setScoreHistory(Integer scoreHistory) {
		this.scoreHistory = scoreHistory;
	}

	public Integer getScoreCustomer() {
		return scoreCustomer;
	}

	public void setScoreCustomer(Integer scoreCustomer) {
		this.scoreCustomer = scoreCustomer;
	}

	public Date getChangeDate() {
		return changeDate;
	}

	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}

	public String getScoreDescription() {
		return scoreDescription;
	}

	public void setScoreDescription(String scoreDescription) {
		this.scoreDescription = scoreDescription;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((changeDate == null) ? 0 : changeDate.hashCode());
		result = prime * result
				+ ((idCustomer == null) ? 0 : idCustomer.hashCode());
		result = prime * result
				+ ((scoreCustomer == null) ? 0 : scoreCustomer.hashCode());
		result = prime
				* result
				+ ((scoreDescription == null) ? 0 : scoreDescription.hashCode());
		result = prime * result
				+ ((scoreHistory == null) ? 0 : scoreHistory.hashCode());
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
		Score other = (Score) obj;
		if (changeDate == null) {
			if (other.changeDate != null)
				return false;
		} else if (!changeDate.equals(other.changeDate))
			return false;
		if (idCustomer == null) {
			if (other.idCustomer != null)
				return false;
		} else if (!idCustomer.equals(other.idCustomer))
			return false;
		if (scoreCustomer == null) {
			if (other.scoreCustomer != null)
				return false;
		} else if (!scoreCustomer.equals(other.scoreCustomer))
			return false;
		if (scoreDescription == null) {
			if (other.scoreDescription != null)
				return false;
		} else if (!scoreDescription.equals(other.scoreDescription))
			return false;
		if (scoreHistory == null) {
			if (other.scoreHistory != null)
				return false;
		} else if (!scoreHistory.equals(other.scoreHistory))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Score [idCustomer=" + idCustomer + ", scoreHistory="
				+ scoreHistory + ", scoreCustomer=" + scoreCustomer
				+ ", changeDate=" + changeDate + "]";
	}
	
	
	
}
