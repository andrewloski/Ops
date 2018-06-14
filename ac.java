package com.example.user.qr;

import android.accessibilityservice.AccessibilityService;
import android.annotation.TargetApi;
import android.app.Notification;
import android.app.PendingIntent;
import android.os.Build;
import android.os.Parcelable;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

import java.util.ArrayList;
import java.util.List;


public class ac extends AccessibilityService {


    private static final String PNAME = "pname";
    private static final String CLASS = "class";
    private static final String pname = "com.tencent.mm";
    private String mall = "com.tencent.mm.plugin.mall.ui.MallIndexUI";
    private String myWallet = "我的钱包";
    private String pay = "微信支付";
    private String cpClassName = "com.tencent.mm.plugin.offline.ui.WalletOfflineCoinPurseUI";
    private String cp = "收付款";
    private String collect = "二维码收款";
    private String my = "我";

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        //Log.d(TAG, "onAccessibilityEvent: " + event.toString());
        if (event.getEventType() == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED &&
                event.getPackageName().equals(pname)) {
            CharSequence className = event.getClassName();
            Log.d(PNAME, event.getPackageName().toString());
            if (className.toString().equals(cpClassName)) {
                Log.d(CLASS, className.toString());
                AccessibilityNodeInfo rootNode = getRootInActiveWindow();
                //List<AccessibilityNodeInfo> nodes = rootNode.findAccessibilityNodeInfosByText(cp);
                if(rootNode != null) {
                    int count = rootNode.getChildCount();
                    for (int i = 0; i < count; i++) {
                        AccessibilityNodeInfo nodeInfo = rootNode.getChild(i);
                        Log.d(NODE, nodeInfo.toString());
                        if (nodeInfo == rootNode.findAccessibilityNodeInfosByText(collect)) {
                            nodeInfo.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                        }
                    }
                }
            }
        }
    }

    @Override
    public void onInterrupt() {
    }
}
