#安装应用
C:\Users\User\AppData\Local\Android\Sdk\platform-tools\adb install d:\Workspace\cs\android\app\app\build\outputs\apk\debug\app-debug.apk
cd C:\Users\User\AppData\Local\Android\Sdk\platform-tools\
adb install d:\Workspace\cs\android\app\app\build\outputs\apk\debug\app-debug.apk
#电源键
adb shell input keyevent 26
#上滑解锁
db shell input swipe 300 1000 300 500
#返回键
adb shell input keyevent 4
#模拟home按键
adb shell input keyevent 3
#模拟点击
adb shell input tap 250 250
#模拟滑动
adb shell input swipe 600 600 200 200
#调起 Activity
adb shell am start -n com.tencent.mm/.ui.LauncherUI
#调起 Service
adb shell am startservice -n com.tencent.mm/.plugin.accountsync.model.AccountAuthenticatorService
#输入文本
adb shell input text hello
#屏幕分辨率
adb shell wm size
#屏幕截图
adb shell screencap -p /sdcard/sc.png
#录制屏幕
adb shell screenrecord /sdcard/filename.mp4
#下载
adb pull /sdcard/filename.mp4
#上传
adb push path/filename /sdcard/filename
