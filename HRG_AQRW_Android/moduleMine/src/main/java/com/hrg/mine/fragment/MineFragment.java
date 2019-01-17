package com.hrg.mine.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hrg.common.base.BaseFragment;
import com.hrg.mine.R;

/**
 * 我的Fragment
 * */
public class MineFragment extends BaseFragment {

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @return A new instance of fragment GirlsFragment.
     */
    public static MineFragment newInstance() {
        return new MineFragment();
    }


    public MineFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.mine_fragment_riclist, container, false);
    }


}
