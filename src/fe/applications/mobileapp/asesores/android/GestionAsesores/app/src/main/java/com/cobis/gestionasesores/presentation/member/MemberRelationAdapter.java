package com.cobis.gestionasesores.presentation.member;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.MemberRelation;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 9/26/2017.
 */

public class MemberRelationAdapter extends RecyclerView.Adapter<MemberRelationAdapter.MemberRelationViewHolder> {

    private List<MemberRelation> mItems;
    private MemberRelationListener mListener;

    public MemberRelationAdapter(MemberRelationListener listener) {
        mListener = listener;
        mItems = new ArrayList<>();
    }

    @Override
    public MemberRelationViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View rowView = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_member_relation, parent, false);
        return new MemberRelationViewHolder(rowView);
    }

    @Override
    public void onBindViewHolder(final MemberRelationViewHolder holder, int position) {
        holder.bindMemberRelation(mItems.get(position));
        holder.mRemoveImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                mListener.onClickRemove(mItems.get(holder.getAdapterPosition()));
            }
        });
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    public void setMemberRelations(List<MemberRelation> memberRelations) {
        mItems.clear();
        mItems.addAll(memberRelations);
        notifyDataSetChanged();
    }

    public List<MemberRelation> getMemberRelations() {
        return mItems;
    }

    public void addMemberRelation(MemberRelation relation) {
        mItems.add(relation);
        notifyItemInserted(mItems.size() - 1);
    }

    public void removeMemberRelation(MemberRelation relation) {
        int remove = -1;
        for (int i = 0; i < mItems.size(); i++) {
            if (mItems.get(i).getCustomerId() == relation.getCustomerId()) {
                remove = i;
                break;
            }
        }
        if (remove >= 0) {
            mItems.remove(remove);
            notifyItemRemoved(remove);
        }
    }

    public static class MemberRelationViewHolder extends RecyclerView.ViewHolder {

        @BindView(R.id.text_name)
        TextView mNameText;
        @BindView(R.id.text_relationship)
        TextView mRelationshipText;
        @BindView(R.id.img_remove)
        ImageView mRemoveImg;

        public MemberRelationViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bindMemberRelation(MemberRelation memberRelation) {
            mNameText.setText(memberRelation.getName());
            mRelationshipText.setText(memberRelation.getRelationName());
        }
    }

    interface MemberRelationListener {
        void onClickRemove(MemberRelation relation);
    }
}
