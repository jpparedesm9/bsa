package cobiscorp.ecobis.cloud.sofom.operationsexecution.accountmanagement.batch.dto;

/**
 * Created by pclavijo on 27/06/2017.
 */
public class AccountsReceivableResponse {
    private String accountNumber;
    private String operationDate;
    private String operationHour;
    private String channel;
    private String conceptCode;
    private String concept;
    private String sign;
    private String amount;
    private String balance;
    private String bankPage;
    private String conceptCodeDescription;
    private String legend;
    private String interbankReference;
    private String blanks;
    private String initialBalance;
    private String finalBalance;
    private String customerReference;
    private String currency;
    private String operationNumber;

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getOperationDate() {
        return operationDate;
    }

    public void setOperationDate(String operationDate) {
        this.operationDate = operationDate;
    }

    public String getOperationHour() {
        return operationHour;
    }

    public void setOperationHour(String operationHour) {
        this.operationHour = operationHour;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getConceptCode() {
        return conceptCode;
    }

    public void setConceptCode(String conceptCode) {
        this.conceptCode = conceptCode;
    }

    public String getConcept() {
        return concept;
    }

    public void setConcept(String concept) {
        this.concept = concept;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }

    public String getBankPage() {
        return bankPage;
    }

    public void setBankPage(String bankPage) {
        this.bankPage = bankPage;
    }

    public String getConceptCodeDescription() {
        return conceptCodeDescription;
    }

    public void setConceptCodeDescription(String conceptCodeDescription) {
        this.conceptCodeDescription = conceptCodeDescription;
    }

    public String getLegend() {
        return legend;
    }

    public void setLegend(String legend) {
        this.legend = legend;
    }

    public String getInterbankReference() {
        return interbankReference;
    }

    public void setInterbankReference(String interbankReference) {
        this.interbankReference = interbankReference;
    }

    public String getBlanks() {
        return blanks;
    }

    public void setBlanks(String blanks) {
        this.blanks = blanks;
    }

    public String getInitialBalance() {
        return initialBalance;
    }

    public void setInitialBalance(String initialBalance) {
        this.initialBalance = initialBalance;
    }

    public String getFinalBalance() {
        return finalBalance;
    }

    public void setFinalBalance(String finalBalance) {
        this.finalBalance = finalBalance;
    }

    public String getCustomerReference() {
        return customerReference;
    }

    public void setCustomerReference(String customerReference) {
        this.customerReference = customerReference;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getOperationNumber() {
        return operationNumber;
    }

    public void setOperationNumber(String operationNumber) {
        this.operationNumber = operationNumber;
    }

    @Override
    public String toString() {
        return "AccountsReceivableResponse{" +
                "accountNumber='" + accountNumber + '\'' +
                ", operationDate='" + operationDate + '\'' +
                ", operationHour='" + operationHour + '\'' +
                ", channel='" + channel + '\'' +
                ", conceptCode='" + conceptCode + '\'' +
                ", concept='" + concept + '\'' +
                ", sign='" + sign + '\'' +
                ", amount='" + amount + '\'' +
                ", balance='" + balance + '\'' +
                ", bankPage='" + bankPage + '\'' +
                ", conceptCodeDescription='" + conceptCodeDescription + '\'' +
                ", legend='" + legend + '\'' +
                ", interbankReference='" + interbankReference + '\'' +
                ", blanks='" + blanks + '\'' +
                ", initialBalance='" + initialBalance + '\'' +
                ", finalBalance='" + finalBalance + '\'' +
                ", customerReference='" + customerReference + '\'' +
                ", currency='" + currency + '\'' +
                ", operationNumber='" + operationNumber + '\'' +
                '}';
    }
}
