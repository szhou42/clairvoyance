Attribute VB_Name = "Base"
'－－基本操作
'关机 SwitchOff
'重启 Reset
'锁定 Lockit
'注销 StandBy

'API与系统常量
Public Declare Function RtlAdjustPrivilege& Lib "ntdll" (ByVal Privilege&, ByVal NewValue&, ByVal NewThread&, OldValue&)
'提权
Public Declare Function NtShutdownSystem& Lib "ntdll" (ByVal ShutdownAction&)
    Public Const SE_SHUTDOWN_PRIVILEGE& = 19
    Public Const shutdown& = 0
    Public Const RESTART& = 1
    Public Const POWEROFF& = 2
'关机 重启 注销都用这函数
Private Declare Function SendScreenMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Const MONITOR_ON = -1&
Private Const MONITOR_LOWPOWER = 1&
Private Const MONITOR_OFF = 2&
Private Const SC_MONITORPOWER = &HF170&
Private Const WM_SYSCOMMAND = &H112
'关闭和开启显示屏的API(有一个延时函数)

Public myKey As String

Public Sub SwitchOff()
Shell "cmd.exe /c shutdown -s -t 0", vbHide
End Sub

Public Sub Reset()
Shell "cmd.exe /c shutdown -r -t 0", vbHide
End Sub

Public Sub StandBy()
Shell "cmd.exe /c shutdown -l -t 1", vbHide
End Sub

'开启或关闭显示器
Public Function MonitorCtrl(Form As Form, shutOpen As Boolean)
    If shutOpen = True Then
        Call SendScreenMessage(Form.hwnd, WM_SYSCOMMAND, SC_MONITORPOWER, ByVal MONITOR_ON)
    Else
        Call SendScreenMessage(Form.hwnd, WM_SYSCOMMAND, SC_MONITORPOWER, ByVal MONITOR_OFF)
    End If
End Function
