package cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto;

/**
 * Created by pclavijo on 27/06/2017.
 */
public class DirectDebitMandateResponse {
    private String recordType;
    private String sequenceNumber;
    private String transactionCode;
    private String currencyCode;
    private String amount;
    private String futureUse1;
    private String transactionType;
    private String collectionDate;
    private String recipientBank;
    private String customerAccountType;
    private String customerAccountNumber;
    private String customerName;
    private String serviceReference;
    private String serviceOwnerName;
    private String taxAmount;
    private String referenceNumber;
    private String referenceLegend;
    private String result;
    private String futureUse2;

    public String getRecordType() {
        return recordType;
    }

    public void setRecordType(String recordType) {
        this.recordType = recordType;
    }

    public String getSequenceNumber() {
        return sequenceNumber;
    }

    public void setSequenceNumber(String sequenceNumber) {
        this.sequenceNumber = sequenceNumber;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getFutureUse1() {
        return futureUse1;
    }

    public void setFutureUse1(String futureUse1) {
        this.futureUse1 = futureUse1;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getCollectionDate() {
        return collectionDate;
    }

    public void setCollectionDate(String collectionDate) {
        this.collectionDate = collectionDate;
    }

    public String getRecipientBank() {
        return recipientBank;
    }

    public void setRecipientBank(String recipientBank) {
        this.recipientBank = recipientBank;
    }

    public String getCustomerAccountType() {
        return customerAccountType;
    }

    public void setCustomerAccountType(String customerAccountType) {
        this.customerAccountType = customerAccountType;
    }

    public String getCustomerAccountNumber() {
        return customerAccountNumber;
    }

    public void setCustomerAccountNumber(String customerAccountNumber) {
        this.customerAccountNumber = customerAccountNumber;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getServiceReference() {
        return serviceReference;
    }

    public void setServiceReference(String serviceReference) {
        this.serviceReference = serviceReference;
    }

    public String getServiceOwnerName() {
        return serviceOwnerName;
    }

    public void setServiceOwnerName(String serviceOwnerName) {
        this.serviceOwnerName = serviceOwnerName;
    }

    public String getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(String taxAmount) {
        this.taxAmount = taxAmount;
    }

    public String getReferenceNumber() {
        return referenceNumber;
    }

    public void setReferenceNumber(String referenceNumber) {
        this.referenceNumber = referenceNumber;
    }

    public String getReferenceLegend() {
        return referenceLegend;
    }

    public void setReferenceLegend(String referenceLegend) {
        this.referenceLegend = referenceLegend;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getFutureUse2() {
        return futureUse2;
    }

    public void setFutureUse2(String futureUse2) {
        this.futureUse2 = futureUse2;
    }

    @Override
    public String toString() {
        return "DirectDebitMandateResponse{" +
                "recordType='" + recordType + '\'' +
                ", sequenceNumber='" + sequenceNumber + '\'' +
                ", transactionCode='" + transactionCode + '\'' +
                ", currencyCode='" + currencyCode + '\'' +
                ", amount='" + amount + '\'' +
                ", futureUse1='" + futureUse1 + '\'' +
                ", transactionType='" + transactionType + '\'' +
                ", collectionDate='" + collectionDate + '\'' +
                ", recipientBank='" + recipientBank + '\'' +
                ", customerAccountType='" + customerAccountType + '\'' +
                ", customerAccountNumber='" + customerAccountNumber + '\'' +
                ", customerName='" + customerName + '\'' +
                ", serviceReference='" + serviceReference + '\'' +
                ", serviceOwnerName='" + serviceOwnerName + '\'' +
                ", taxAmount='" + taxAmount + '\'' +
                ", referenceNumber='" + referenceNumber + '\'' +
                ", referenceLegend='" + referenceLegend + '\'' +
                ", result='" + result + '\'' +
                ", futureUse2='" + futureUse2 + '\'' +
                '}';
    }
}
