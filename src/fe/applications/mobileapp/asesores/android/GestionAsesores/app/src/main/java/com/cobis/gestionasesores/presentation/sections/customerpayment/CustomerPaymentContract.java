package com.cobis.gestionasesores.presentation.sections.customerpayment;

import com.cobis.gestionasesores.data.models.CustomerPayment;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.sections.SectionViewBase;

/**
 * Created by bqtdesa02 on 6/9/2017.
 */

public interface CustomerPaymentContract {

    interface CustomerPaymentView extends SectionViewBase, BaseView<CustomerPaymentPresenter>{
        void setCustomerPayment(CustomerPayment customerPayment);
        void setOtherIncome(double otherIncome);
        void clearErrors();
        void showMonthlyIncomeError();
        void showMonthlyBusinessExpensesError();
        void showMonthlyFamilyExpensesError();
        void setPaymentCapacity(double paymentCapacity);
    }

    interface CustomerPaymentPresenter extends BasePresenter{
        void onClickFinish(CustomerPayment customerPayment);
        void onMonthlyIncomeChange(double monthlyIncome);
        void onMonthlyBusinessExpensesChange(double expenses);
        void onMonthlyFamilyExpensesChange(double expenses);
    }
}