package com.cobis.gestionasesores.data.mappers;

import com.bayteq.libcore.util.ConvertUtils;
import com.cobis.gestionasesores.data.models.MonthlyPayment;
import com.cobis.gestionasesores.data.models.SimulationData;
import com.cobis.gestionasesores.data.models.requests.SimulateRequest;
import com.cobis.gestionasesores.data.models.requests.SimulationInfo;
import com.cobis.gestionasesores.data.models.requests.SimulationRow;
import com.cobis.gestionasesores.utils.DateUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by User on 09/08/2017.
 */

public final class SimulationMapper {

    public static SimulateRequest toSimulationRequest(SimulationData simulationData) {
        SimulationInfo info = new SimulationInfo();
        info.setAmount(simulationData.getAmount());
        info.setFrequency(simulationData.getFrequency());
        info.setInitialDate(DateUtils.formatDateForService(simulationData.getDate()));
        info.setTerm(ConvertUtils.tryToInt(simulationData.getTerm(), 0));
        info.setType(simulationData.getCreditType());

        SimulateRequest request = new SimulateRequest();
        request.setSimulation(info);
        request.setOnline(true);
        return request;
    }

    public static List<MonthlyPayment> toMonthlyPayment(List<SimulationRow> amortizationTable) {
        List<MonthlyPayment> monthlyPayments = new ArrayList<>();
        for (SimulationRow row : amortizationTable) {
            monthlyPayments.add(fromRowRemote(row));
        }
        return monthlyPayments;
    }

    private static MonthlyPayment fromRowRemote(SimulationRow row) {
        MonthlyPayment monthlyPayment = new MonthlyPayment();
        monthlyPayment.setBalance(row.getBalance());
        monthlyPayment.setDate(new Date(DateUtils.parseDateFromService(row.getDate())));
        monthlyPayment.setInteresIva(row.getIva());
        monthlyPayment.setPeriod(row.getDividend());
        monthlyPayment.setInteres(row.getInterest());
        monthlyPayment.setAmortization(row.getTotal() - row.getInterest() - row.getIva());
        monthlyPayment.setPayment((int) Math.ceil(row.getTotal()));
        return monthlyPayment;
    }
}
