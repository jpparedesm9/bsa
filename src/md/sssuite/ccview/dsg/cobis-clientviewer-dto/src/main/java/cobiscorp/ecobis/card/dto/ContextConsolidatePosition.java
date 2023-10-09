package cobiscorp.ecobis.card.dto;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.OwnWarrantyTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.WarrantyTmpDTO;

public class ContextConsolidatePosition {

	private List<SummaryDebtsDTO> debtsLoans = new ArrayList<SummaryDebtsDTO>();
	private List<SummaryCreditsDTO> credits = new ArrayList<SummaryCreditsDTO>();
	private List<WarrantyTmpDTO> warranties = new ArrayList<WarrantyTmpDTO>();
	private List<OwnWarrantyTmpDTO> promissoryNotes = new ArrayList<OwnWarrantyTmpDTO>();

	public List<SummaryDebtsDTO> getDebtsLoans() {
		return debtsLoans;
	}

	public void setDebtsLoans(List<SummaryDebtsDTO> debtsLoans) {
		this.debtsLoans = debtsLoans;
	}

	public List<SummaryCreditsDTO> getCredits() {
		return credits;
	}

	public void setCredits(List<SummaryCreditsDTO> credits) {
		this.credits = credits;
	}

	public List<WarrantyTmpDTO> getWarranties() {
		return warranties;
	}

	public void setWarranties(List<WarrantyTmpDTO> warranties) {
		this.warranties = warranties;
	}

	public List<OwnWarrantyTmpDTO> getPromissoryNotes() {
		return promissoryNotes;
	}

	public void setPromissoryNotes(List<OwnWarrantyTmpDTO> promissoryNotes) {
		this.promissoryNotes = promissoryNotes;
	}
}
