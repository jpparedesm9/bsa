package com.cobiscorp.cobis.assets.commons.constants;

public interface ServiceId {
	// GROUP SERVICES
	final static String QUERY_MEMBERS 			= "Loan.QueryDocuments.QueryMembers";//cob_credito..sp_busca_doc - opcion U
	final static String QUERY_DOCUMENTS 		= "Loan.QueryDocuments.QueryDocuments";//cob_credito..sp_busca_doc - opcion Q-D
	final static String QUERY_DOCUMENTS_IND 	= "Loan.QueryDocuments.QueryDocumentsInd";//cob_credito..sp_busca_doc opcion=P
	final static String QUERY_DOCUMENTS_CREDIT 	= "Loan.QueryDocuments.QueryDocumentsCredit";//cob_credito..sp_busca_doc opcion=F
	final static String QUERY_CYCLES 			= "Loan.QueryDocuments.QueryCycles";//cob_credito..sp_busca_doc - opcion C
	
	//Candidatos a credito LCR
	final static String QUERY_CANDIDATES		= "Loan.RevolvingManagement.QueryCreditCandidates";//cob_cartera..sp_candidatos_lcr - opcion Q
	final static String OFFICER_CANDIDATES		= "Loan.RevolvingManagement.OfficerCreditCandidates";//cob_cartera..sp_candidatos_lcr - opcion O
	final static String UPDATE_CANDIDATES		= "Loan.RevolvingManagement.UpdateCreditCandidates";//cob_cartera..sp_candidatos_lcr - opcion U
	final static String ACTIONS_CANDIDATES		= "Loan.RevolvingManagement.ActionsCreditCandidates";//cob_cartera..sp_candidatos_lcr - opcion A

	final static String UPDATE_DOCUMENTS        = "LoanGroup.ScannedDocuments.UpdateScannedDocuments";//cob_credito..sp_documento_digitalizado - opcion U
	final static String SEARCH_DOCUMENTS        = "LoanGroup.ScannedDocuments.QueryScannedDocuments";//cob_credito..sp_documento_digitalizado - opcion Q

}
