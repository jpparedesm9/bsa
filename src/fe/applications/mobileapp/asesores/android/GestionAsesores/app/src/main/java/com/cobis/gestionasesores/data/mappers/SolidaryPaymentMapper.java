package com.cobis.gestionasesores.data.mappers;

import com.cobis.gestionasesores.data.models.SolidarityMember;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.requests.PaymentRequest;
import com.cobis.gestionasesores.data.models.requests.PaymentRequestCustomer;
import com.cobis.gestionasesores.data.models.requests.PaymentRequestData;
import com.cobis.gestionasesores.data.models.responses.SolidarityPaymentCustomerData;
import com.cobis.gestionasesores.data.models.responses.SolidarityPaymentData;
import com.cobis.gestionasesores.data.models.responses.SolidarityPaymentResponseItem;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.ArrayList;
import java.util.List;

public class SolidaryPaymentMapper {

    public static List<SolidarityPayment> responseToSolidarityPayment(List<SolidarityPaymentResponseItem> response) {
        List<SolidarityPayment> result = null;
        if (response != null) {
            result = new ArrayList<>();
            for (SolidarityPaymentResponseItem res : response) {
                SolidarityPaymentData entity = res.getEntity().getSolidarityPaymentData();
                SolidarityPayment data = new SolidarityPayment();
                data.setName(entity.getGroupName());
                data.setServerId(entity.getGroupId());
                data.setCycle(entity.getGroupCycle());
                data.setDate(DateUtils.parseDateFromService(entity.getApplicationDate()));
                data.setCreditAmount(entity.getGroupAmount());
                data.setRate(entity.getRate());
                data.setTerm(entity.getTerm());
                data.setGuaranteeBalance(entity.getLiquidCollateralBalance());
                data.setOverduePayments(entity.getLatePayments());
                data.setNextDueDate(DateUtils.parseDateFromService(entity.getNextDueDate()));
                data.setPaymentDue(entity.getAmountChargeWholePayment());
                data.setDebitAccount(entity.isDebitsSavingAccounts());
                data.setMembers(fromRemote(res.getEntity().getSolidarityPaymentCustomerData()));
                result.add(data);
            }
        }
        return result;
    }

    private static List<SolidarityMember> fromRemote(List<SolidarityPaymentCustomerData> data){
        List<SolidarityMember> result = new ArrayList<>();
        for (SolidarityPaymentCustomerData customerData: data){
            SolidarityMember member = new SolidarityMember();
            member.setId(customerData.getCustomerId());
            member.setName(customerData.getCustomerName());
            member.setPaymentAmount(customerData.getAmountPayWholePayment());
            member.setOwedAmount(customerData.getDueBalance());
            result.add(member);
        }
        return result;
    }

    public static PaymentRequest paymentToRequest(SolidarityPayment solidarityPayment, boolean isSync) {
        PaymentRequestData data = new PaymentRequestData();
        data.setGroupId(solidarityPayment.getServerId());

        double groupAmount = 0;

        for (SolidarityMember member: solidarityPayment.getMembers()){
            groupAmount += member.getPaymentAmount();
        }

        data.setGroupAmount(groupAmount);
        data.setDebitsSavingAccounts(solidarityPayment.isDebitAccount());

        PaymentRequest paymentRequest = new PaymentRequest();
        paymentRequest.setSolidarityPaymentCustomerData(customerToRequest(solidarityPayment.getMembers()));
        paymentRequest.setSolidarityPaymentData(data);
        paymentRequest.setOnline(!isSync);
        return paymentRequest;
    }

    public static List<PaymentRequestCustomer> customerToRequest(List<SolidarityMember> members){
        List<PaymentRequestCustomer> result = new ArrayList<>();
        for(SolidarityMember member:members){
            result.add(new PaymentRequestCustomer(member.getId(),member.getPaymentAmount()));
        }
        return result;
    }
}
