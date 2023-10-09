package com.cobis.gestionasesores.widgets.form.singlechoice;

import android.content.Context;
import android.support.annotation.LayoutRes;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.QuestionOption;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by bqtdesa02 on 8/17/2017.
 */

public class SingleQuestionAdapter extends ArrayAdapter<QuestionOption> {

    private List<QuestionOption> mItems;

    @StringRes
    private int mError;

    public SingleQuestionAdapter(@NonNull Context context, @LayoutRes int resource) {
        super(context, resource);
        mItems = new ArrayList<>();
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = LayoutInflater.from(getContext()).inflate(android.R.layout.simple_spinner_item, parent, false);
            viewHolder.mValueText = (TextView) convertView;
            convertView.setTag(viewHolder);

        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }

        QuestionOption item = getItem(position);
        if (item != null) {
            viewHolder.mValueText.setText(item.getValue());
            viewHolder.mValueText.setError(mError > 0 ? getContext().getString(mError) : null);
        }
        return convertView;
    }

    @Override
    public View getDropDownView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = LayoutInflater.from(getContext()).inflate(android.R.layout.simple_dropdown_item_1line, parent, false);
            viewHolder.mValueText = (TextView) convertView;
            convertView.setTag(viewHolder);

        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }

        QuestionOption item = getItem(position);
        if (item != null) {
            viewHolder.mValueText.setText(item.getValue());
        }
        return convertView;
    }

    @Nullable
    @Override
    public QuestionOption getItem(int position) {
        return mItems.get(position);
    }

    @Override
    public int getCount() {
        return mItems.size();
    }

    public void setQuestions(List<QuestionOption> questions) {
        mItems.clear();
        mItems.add(getDefaultItem());
        mItems.addAll(questions);
        addAll(mItems);
    }

    public void showError(@StringRes int error) {
        mError = error;
        notifyDataSetChanged();
    }

    public void clearError() {
        mError = -1;
        notifyDataSetChanged();
    }

    public String getItemCode(int position) {
        if (position == -1) return null;
        return mItems.get(position).getCode();
    }

    public int getItemPositionByCode(String code) {
        if(code == null) return 0;
        for (int i = 0; i < mItems.size(); i++) {
            if (code.equals(mItems.get(i).getCode())) {
                return i;
            }
        }
        return 0;
    }

    private QuestionOption getDefaultItem(){
        return new QuestionOption(null,getContext().getString(R.string.form_hint_select_spinner));
    }

    public static class ViewHolder{
        TextView mValueText;
    }
}
