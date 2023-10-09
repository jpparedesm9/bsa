package com.cobis.gestionasesores.presentation.member;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Member;

import java.util.List;

/**
 * Created by bqtdesa02 on 6/20/2017.
 */

public class RelatedMemberAdapter extends ArrayAdapter<Member> {

    private List<Member> mData;

    @StringRes
    private int mHint;

    @StringRes
    private int mError;

    public RelatedMemberAdapter(@NonNull Context context, List<Member> members, @StringRes int hint) {
        super(context, android.R.layout.simple_list_item_1,members);
        mData = members;
        mData.add(0,getDefaultItem());
        mHint = hint;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        ItemViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ItemViewHolder();
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.row_spinner_item, parent, false);
            viewHolder.name = (TextView) convertView.findViewById(R.id.text_value);
            viewHolder.hint = (TextView) convertView.findViewById(R.id.text_hint);
            convertView.setTag(viewHolder);

        } else {
            viewHolder = (ItemViewHolder) convertView.getTag();
        }

        Member item = getItem(position);
        if (item != null) {
            viewHolder.name.setText(item.getName());
            viewHolder.hint.setText(mHint);
            viewHolder.name.setError(mError > 0 ? getContext().getString(mError) : null);
        }
        return convertView;
    }

    public void showError(@StringRes int error) {
        mError = error;
        notifyDataSetChanged();
    }

    public void clearError() {
        mError = -1;
        notifyDataSetChanged();
    }

    public int getItemPositionByRfc(String rfc){
        if(rfc == null ) return 0;
        for (int i = 0; i < mData.size(); i++){
            if(rfc.equals(mData.get(i).getRfc())){
                return i;
            }
        }
        return 0;
    }

    private Member getDefaultItem() {
        return new Member.Builder()
                .addName(getContext().getString(R.string.form_hint_select_spinner))
                .build();
    }

    private static final class ItemViewHolder {
        TextView name;
        TextView hint;
    }
}
