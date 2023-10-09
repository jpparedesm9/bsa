package com.cobis.gestionasesores.presentation.groups;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.PositionGroup;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MemberAdapter extends RecyclerView.Adapter<MemberAdapter.ViewHolder> {
    private List<Member> mData;
    private OnItemClickListener mListener;

    public MemberAdapter(List<Member> data, OnItemClickListener listener) {
        mData = data;
        mListener = listener;
    }

    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        final View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_group_member, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, final int position) {
        holder.bind(mData.get(position), mListener);
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public List<Member> getMembers() {
        return mData;
    }

    public void updateAll(List<Member> members) {
        mData = members;
        notifyDataSetChanged();
    }


    public class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.text_name)
        TextView nameText;
        @BindView(R.id.text_position)
        TextView positionText;
        @BindView(R.id.img_sync_status)
        ImageView syncStatusImg;

        public ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }

        public void bind(final Member member, final OnItemClickListener listener) {
            nameText.setText(member.getName());
            String position = member.getPosition();
            if (StringUtils.isNotEmpty(position)) {
                int positionRes = getPositionResource(position);
                if (positionRes > 0) {
                    positionText.setText(positionRes);
                    positionText.setVisibility(View.VISIBLE);
                } else {
                    positionText.setVisibility(View.GONE);
                }
            } else {
                positionText.setVisibility(View.GONE);
            }
            syncStatusImg.setImageResource(ResourcesUtil.getSyncStatusResource(member.getStatus()));

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(member);
                }
            });
        }
    }

    public int getPositionResource(@PositionGroup String position) {
        switch (position) {
            case PositionGroup.PRESIDENT:
                return R.string.position_president;
            case PositionGroup.SECRETARY:
                return R.string.position_secretary;
            case PositionGroup.TREASURER:
                return R.string.position_treasurer;
            default:
                return -1;
        }
    }

    public interface OnItemClickListener {
        void onItemClick(Member item);
    }

}