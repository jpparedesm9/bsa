package com.cobiscorp.cobis.loans.loansgroup.commons.constants;

public interface ServiceId {
	// GROUP SERVICES
	final static String INSERT_GROUP = "LoanGroup.GroupMaintenance.CreateGroup";
	final static String UPDATE_GROUP = "LoanGroup.GroupMaintenance.UpdateGroup";
	final static String SEARCH_GROUP = "LoanGroup.GroupMaintenance.SearchGroup";
	final static String INSERT_MEMBER = "LoanGroup.MemberMaintenance.CreateMember";//cob_pac..sp_miembro_grupo_busin - opcion I
	final static String UPDATE_MEMBER = "LoanGroup.MemberMaintenance.UpdateMember";//cob_pac..sp_miembro_grupo_busin - opcion U
	final static String DELETE_MEMBER = "LoanGroup.MemberMaintenance.DeleteMember";//cob_pac..sp_miembro_grupo_busin - opcion D
	final static String SEARCH_MEMBER = "LoanGroup.MemberMaintenance.SearchMember";//cob_pac..sp_miembro_grupo_busin - opcion S
	final static String QUERY_MEMBER = "CustomerDataManagementService.CustomerManagement.ReadDataCustomer";
	final static String UPDATE_RENAPO_MEMBER = "CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO"; 
	final static String SEARCH_OFFICIALS = "CustomerDataManagementService.OfficialManagement.SearchOfficials";
	final static String INSERT_AMOUNT = "LoanGroup.GroupLoanAmountMaintenance.CreateLoanAmount";
	final static String SEARCH_AMOUNT = "LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount";
	final static String SEARCH_AMOUNT_RENOVATION = "LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation";
	final static String CALC_AMOUNT = "LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount";
	final static String UPDATE_AMOUNT = "LoanGroup.GroupLoanAmountMaintenance.UpdateLoanAmount";
	final static String SERVICEGETPROCESSEDNUMBER = "BusinessProcess.LoanRequest.CreditOperation.GetProcessedNumber";
	final static String SERVICEREADAPPLICATION = "Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication";// cob_cartera..sp_qry_oper_sol_wf,Q
	final static String SERVICE_QUERY_MEMBER = "LoanGroup.MemberMaintenance.QueryMember";//cob_pac..sp_miembro_grupo_busin - opcion Q
	final static String SERVICE_QUERY_CALIFICATION_MENBER = "LoanGroup.MemberMaintenance.QueryCustomer";//cob_pac..sp_miembro_grupo_busin - opcion L
}
