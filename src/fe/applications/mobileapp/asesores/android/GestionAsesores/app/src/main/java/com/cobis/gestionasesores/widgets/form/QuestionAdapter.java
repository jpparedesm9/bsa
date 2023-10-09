package com.cobis.gestionasesores.widgets.form;

import android.support.annotation.Nullable;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.QuestionType;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.widgets.form.booleanquestion.BooleanViewHolder;
import com.cobis.gestionasesores.widgets.form.header.HeaderViewHolder;
import com.cobis.gestionasesores.widgets.form.singlechoice.SingleChoiceViewHolder;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Jose on 8/16/2017.
 */

public class QuestionAdapter extends RecyclerView.Adapter<QuestionAdapter.QuestionViewHolder> {

    private List<Question> mItems;
    private QuestionListener mListener;
    private List<Boolean> mIntereactive;

    public QuestionAdapter(QuestionListener listener) {
        mListener = listener;
        mItems = new ArrayList<>();
        mIntereactive = new ArrayList<>();
    }

    @Override
    public QuestionViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View rowView;
        switch (viewType) {
            case QuestionType.BOOLEAN:
                rowView = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_question_boolean, parent, false);
                return new BooleanViewHolder(rowView);
            case QuestionType.SINGLE_CHOICE:
                rowView = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_question_single_choice, parent, false);
                return new SingleChoiceViewHolder(rowView);
            case QuestionType.HEADER:
                rowView = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_question_header, parent, false);
                return new HeaderViewHolder(rowView);
            default:
                throw new RuntimeException("Question type not implemented: " + viewType);
        }
    }

    @Override
    public void onBindViewHolder(QuestionViewHolder holder, int position) {
        holder.bind(mItems.get(position), getValueByCode(mItems.get(position).getParent()), mQuestionListener, mIntereactive.get(position));
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    @Override
    public int getItemViewType(int position) {
        return mItems.get(position).getType();
    }

    public void setQuestions(List<Question> newQuestions) {
        mItems.clear();
        mItems.addAll(newQuestions);
        mIntereactive.clear();
        for (Question question : newQuestions){
            mIntereactive.add(!question.needGeo());
        }
        notifyDataSetChanged();
    }

    public List<Question> getQuestions() {
        return mItems;
    }

    @Nullable
    public String getValueByCode(String code) {
        if (code == null) return null;
        for (Question question : mItems) {
            if (code.equals(question.getCode())) {
                return question.getValue();
            }
        }
        return null;
    }

    public int getPositionByCode(String code) {
        if (code == null) return 0;
        for (int i = 0; i < mItems.size(); i++) {
            if (code.equals(mItems.get(i).getCode())) {
                return i;
            }
        }
        return 0;
    }


    public void setError(String code) {
        for (int i = 0; i < mItems.size(); i++) {
            if (code.equals(mItems.get(i).getCode())) {
                mItems.get(i).setError(true);
                notifyItemChanged(i);
            }
        }
    }

    public void clearErrors() {
        for (int i = 0; i < mItems.size(); i++) {
            mItems.get(i).setError(false);
        }
        notifyDataSetChanged();
    }

    public void updateQuestion(Question question) {
        for (int i = 0; i < mItems.size(); i++) {
            if (question.getCode().equals(mItems.get(i).getCode())) {
                mItems.set(i, question);
                notifyItemChanged(i);
            }
        }
    }

    private void manageActiveQuestions(Question parentQuestion) {
        String parentCode = parentQuestion.getCode();
        for (int i = 0; i < mItems.size(); i++) {
            Question question = mItems.get(i);
            if (parentCode.equals(question.getParent())) {
                notifyItemChanged(i);
            }
        }
    }

    public void activateQuestion (Question question){
        for (Question questionIndex : mItems){
            if (questionIndex.getCode().equals(question.getCode())){
                mIntereactive.set(mItems.indexOf(questionIndex), true);
                notifyDataSetChanged();
            }
        }
    }

    public void activateGpsQuestions(){
        for (Question questionIndex : mItems){
            if (questionIndex.needGeo()){
                mIntereactive.set(mItems.indexOf(questionIndex), true);
                notifyDataSetChanged();
            }
        }
    }

    private QuestionListener mQuestionListener = new QuestionListener() {
        @Override
        public void onQuestionValueChange(Question question, String newValue, String oldValue) {
            mListener.onQuestionValueChange(question, newValue, oldValue);
            manageActiveQuestions(question);
        }

        @Override
        public void onGpsMapDialogClick(Question question) {
            mListener.onGpsMapDialogClick(question);
        }
    };

    public abstract static class QuestionViewHolder extends RecyclerView.ViewHolder {

        public QuestionViewHolder(View itemView) {
            super(itemView);
        }

        public final void bind(Question question, String parentValue, QuestionListener questionListener, boolean showAnswers) {
            if (question.getParent() != null) {
                boolean enable = parentValue != null &&
                        (parentValue.equals(question.getParentValue()) || question.getParentValue() == null);
                enable(enable);
                question.setActive(enable);
                if (!enable) {
                    question.setValue(null);
                }
            } else {
                question.setActive(true);
                enable(true);
            }
            onBind(question, questionListener, showAnswers);
            showError(question.isError());
            showGeoReference(question.needGeo());
            disable((ViewGroup) itemView, question.isEnabled());
        }

        public abstract void onBind(Question question, QuestionListener questionListener, boolean showAnswers);

        public abstract void showError(boolean showError);

        public abstract void showGeoReference(boolean shouldShow);

        public void enable(boolean enable) {
            RecyclerView.LayoutParams param = (RecyclerView.LayoutParams) itemView.getLayoutParams();

            if (enable) {
                param.height = LinearLayout.LayoutParams.WRAP_CONTENT;
                param.width = LinearLayout.LayoutParams.MATCH_PARENT;
                itemView.setVisibility(View.VISIBLE);
            } else {
                param.height = 0;
                param.width = 0;
                itemView.setVisibility(View.GONE);
            }
            itemView.setLayoutParams(param);
        }

        private void disable(ViewGroup layout, boolean enabled) {
            layout.setEnabled(enabled);
            for (int i = 0; i < layout.getChildCount(); i++) {
                View child = layout.getChildAt(i);
                if (child instanceof ViewGroup) {
                    disable((ViewGroup) child, enabled);
                } else {
                    child.setEnabled(enabled);
                }
            }
        }
    }

    public interface QuestionListener {
        void onQuestionValueChange(Question question, String newValue, String oldValue);
        void onGpsMapDialogClick (Question question);
    }
}
