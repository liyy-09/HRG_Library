package com.hrg.mine.delegete;

import android.support.annotation.Keep;

import com.hrg.common.base.ViewManager;
import com.hrg.common.delegate.IApplicationDelegate;
import com.hrg.mine.fragment.MineFragment;

/**
 * <p>类说明</p>
 *
 * @name MineAppDelegate
 */
@Keep
public class MineAppDelegate implements IApplicationDelegate {
    @Override
    public void onCreate() {
        // 主动添加
        ViewManager.getInstance().addFragment(0, MineFragment.newInstance());
    }

    @Override
    public void onTerminate() {

    }

    @Override
    public void onLowMemory() {

    }

    @Override
    public void onTrimMemory(int level) {

    }
}
