package com.cobis.gestionasesores.presentation.member.moreinformation;

import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

/**
 * Created by bqtdesa02 on 9/29/2017.
 */

public interface MemberInformationContract {

    interface View extends BaseView<Presenter>{
        void showMemberInformation(Member member);
        void drawRiskLevel(String riskLevel);
    }

    interface Presenter extends BasePresenter{

    }
}
