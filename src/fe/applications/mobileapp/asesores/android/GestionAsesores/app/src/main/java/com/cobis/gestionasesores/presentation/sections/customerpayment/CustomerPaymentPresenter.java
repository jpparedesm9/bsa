package com.cobis.gestionasesores.presentation.sections.customerpayment;

import com.cobis.gestionasesores.data.models.CustomerPayment;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.domain.usecases.GetSectionDataUseCase;
import com.cobis.gestionasesores.domain.usecases.SaveSectionUseCase;
import com.cobis.gestionasesores.presentation.sections.SectionPresenter;

/**
 * Created by bqtdesa02 on 6/9/2017.
 */

public class CustomerPaymentPresenter extends SectionPresenter implements CustomerPaymentContract.CustomerPaymentPresenter {
    private CustomerPaymentContract.CustomerPaymentView mView;
    private Section mSection;
    private int mPersonId;
    private double mOtherIncome;
    private double mMonthlyIncome = 0.0;
    private double mMonthlyBusinessExpenses = 0.0;
    private double mMonthlyFamilyExpenses = 0.0;

    public CustomerPaymentPresenter(CustomerPaymentContract.CustomerPaymentView view,
                                    int personId,
                                    Section section,
                                    double otherIncome,
                                    GetSectionDataUseCase getSectionDataUseCase,
                                    SaveSectionUseCase saveSectionUseCase) {
        super(view, saveSectionUseCase,getSectionDataUseCase);
        mView = view;
        mSection = section;
        mPersonId = personId;
        mOtherIncome = otherIncome;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
       loadSection(mPersonId,mSection);
    }


    @Override
    public void onClickFinish(CustomerPayment customerPayment) {
        if (validateCustomerPayment(customerPayment)) {
            mSection.setSectionData(customerPayment);
            saveSection(mPersonId,mSection);
        }
    }

    @Override
    public void onMonthlyIncomeChange(double monthlyIncome) {
        mMonthlyIncome = monthlyIncome;
        updatePaymentCapacity();
    }

    @Override
    public void onMonthlyBusinessExpensesChange(double expenses) {
        mMonthlyBusinessExpenses = expenses;
        updatePaymentCapacity();
    }

    @Override
    public void onMonthlyFamilyExpensesChange(double expenses) {
        mMonthlyFamilyExpenses = expenses;
        updatePaymentCapacity();
    }

    private void updatePaymentCapacity() {
        double paymentCapacity = mOtherIncome + mMonthlyIncome - mMonthlyBusinessExpenses - mMonthlyFamilyExpenses;
        mView.setPaymentCapacity(paymentCapacity);
    }


    private boolean validateCustomerPayment(CustomerPayment customerPayment) {
        boolean isValid = true;
        mView.clearErrors();
        if (customerPayment.getMonthlyIncome() == 0.0) {
            isValid = false;
            mView.showMonthlyIncomeError();
        }

        if (customerPayment.getMonthlyBusinessExpenses() == 0.0) {
            isValid = false;
            mView.showMonthlyBusinessExpensesError();
        }

        if (customerPayment.getMonthlyFamilyExpenses() <= 0.0) {
            isValid = false;
            mView.showMonthlyFamilyExpensesError();
        }

        return isValid;
    }

    @Override
    public void onSectionLoaded(Section section) {
        mSection = section;
        CustomerPayment customerPayment = (CustomerPayment) mSection.getSectionData();
        mView.setOtherIncome(mOtherIncome);
        if (customerPayment != null) {
            mView.setCustomerPayment(customerPayment);
        }else {
            //this is done to show other income and not depend on text watchers
            updatePaymentCapacity();
        }
    }
}
