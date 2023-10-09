package com.cobis.gestionasesores.domain.businesslogic;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.FrequencyType;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.models.MonthlyPayment;
import com.cobis.gestionasesores.data.models.SimulationData;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by mnaunay on 11/09/2017.
 */

public final class SimulationOperation {

    /**
     * Allows compute amortization table
     *
     * @param parameter Simulation paramters
     * @return List of the values computed
     */
    public List<MonthlyPayment> compute(SimulationData parameter) {
        double IVA = BankAdvisorApp.getInstance().getConfig().getDouble(Parameters.IVA) / 100;
        int paymentsInOneMonth = 0;
        int paymentsNumber = 0;
        int daysToNextPay = 0;

        double rate = 0;
        double rateIva = 0;
        int term = ConvertUtils.tryToInt(parameter.getTerm(), 0);

        //Variables in function of frequency
        switch (parameter.getFrequency()) {
            case FrequencyType.WEEKLY:
                paymentsInOneMonth = 4;
                daysToNextPay = 7;
                break;
            case FrequencyType.BIWEEKLY:
                paymentsInOneMonth = 2;
                daysToNextPay = 15;
                break;
            case FrequencyType.MONTHLY:
                paymentsInOneMonth = 1;
                daysToNextPay = 30;
                break;
            default:
                paymentsInOneMonth = 1;
                daysToNextPay = 30;
                break;
        }

        paymentsNumber = paymentsInOneMonth * term;
        rate = daysToNextPay * ((parameter.getInterest() / 100.0) / 360.0);
        rateIva = rate * (1 + IVA);

        double paymentDouble = parameter.getAmount() *
                (
                        (rateIva *
                                Math.pow((1 + rateIva), paymentsNumber)
                        )
                                /
                                (Math.pow((1 + rateIva), paymentsNumber) - 1)
                );
        double payment = Math.ceil(paymentDouble);

        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(parameter.getDate());

        //FirsLine. using the Total amount.
        List<MonthlyPayment> monthlyPayments = new ArrayList<>();
        double balance = parameter.getAmount();
        double interest = balance * rate;
        double interestIva = interest * IVA;
        double amort = payment - interest - interestIva;

        Date date = new Date(parameter.getDate());
        date = addDaysToADate(date, daysToNextPay);

        MonthlyPayment monthlyPayment1 = new MonthlyPayment();
        monthlyPayment1.setPeriod(1);
        monthlyPayment1.setBalance(balance);
        monthlyPayment1.setDate(date);
        monthlyPayment1.setInteres(interest);
        monthlyPayment1.setInteresIva(interestIva);
        monthlyPayment1.setAmortization(amort);
        monthlyPayment1.setPayment(payment);

        monthlyPayments.add(monthlyPayment1);

        //Content of the table. top the line n-1
        for (int i = 0; i < paymentsNumber - 2; i++) {
            balance = monthlyPayments.get(i).getBalance() - monthlyPayments.get(i).getAmortization();
            interest = balance * rate;
            interestIva = interest * IVA;
            amort = payment - interest - interestIva;
            date = addDaysToADate(monthlyPayments.get(i).getDate(), daysToNextPay);

            MonthlyPayment monthlyPayment = new MonthlyPayment();
            monthlyPayment.setPeriod(i + 2);
            monthlyPayment.setBalance(balance);
            monthlyPayment.setDate(date);
            monthlyPayment.setInteres(interest);
            monthlyPayment.setInteresIva(interestIva);
            monthlyPayment.setAmortization(amort);
            monthlyPayment.setPayment(payment);

            monthlyPayments.add(monthlyPayment);
        }

        //LastLine. adjust to make it 0.
        balance = monthlyPayments.get(paymentsNumber - 2).getBalance() - monthlyPayments.get(paymentsNumber - 2).getAmortization();
        interest = balance * rate;
        interestIva = interest * IVA;
        amort = balance;
        payment = amort + interest + interestIva;
        date = addDaysToADate(monthlyPayments.get(paymentsNumber - 2).getDate(), daysToNextPay);
        MonthlyPayment monthlyPayment = new MonthlyPayment();

        monthlyPayment.setPeriod(paymentsNumber);
        monthlyPayment.setBalance(balance);
        monthlyPayment.setDate(date);
        monthlyPayment.setInteres(interest);
        monthlyPayment.setInteresIva(interestIva);
        monthlyPayment.setAmortization(amort);
        monthlyPayment.setPayment(payment);

        monthlyPayments.add(monthlyPayment);

        return monthlyPayments;
    }

    private Date addDaysToADate(Date date, int days) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_YEAR, days);
        return calendar.getTime();
    }
}
