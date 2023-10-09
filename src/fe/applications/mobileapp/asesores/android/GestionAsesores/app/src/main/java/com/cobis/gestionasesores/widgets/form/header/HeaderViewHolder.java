package com.cobis.gestionasesores.widgets.form.header;

import android.view.View;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.widgets.form.QuestionAdapter;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by Jose on 8/19/2017.
 */

public class HeaderViewHolder extends QuestionAdapter.QuestionViewHolder {

    @BindView(R.id.text_header)
    TextView mHeaderText;

    public HeaderViewHolder(View itemView) {
        super(itemView);
        ButterKnife.bind(this, itemView);
    }

    @Override
    public void onBind(Question question, QuestionAdapter.QuestionListener questionListener, boolean showAnswers) {
        mHeaderText.setText(question.getQuestion());
    }

    @Override
    public void showError(boolean showError) {
    }

    @Override
    public void showGeoReference(boolean shouldShow) {
    }
}
