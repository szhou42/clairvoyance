Attribute VB_Name = "Mess"
Option Explicit
Public Declare Function InternetGetConnectedState Lib "wininet.dll" (ByRef lpdwFlags As Long, ByVal dwReserved As Long) As Long
Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, lpKeyName As Any, ByVal lpDefault As String, ByVal lpRetunedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lplFileName As String) As Long
Private Declare Function SHFileExists Lib "shell32" Alias "#45" (ByVal szPath As String) As Long

 '代理服务器访问外网.
Public Const ProxyConnection As Long = &H4
'Modem 忙.
Public Const ModemConnectionIsBusy As Long = &H8

'外网关闭
Public Const InternetIsOffline As Long = &H20

'外网已经配置完毕
Public Const InternetConnectionIsConfigured As Long = &H40

'通过调制解调器访问外网.
Public Const ModemConnection As Long = &H1

'远程访问服务 (Remote Access Server)是否安装.
Public Const RasInstalled As Long = &H10

'通过局域网访问外网.
Public Const LanConnection As Long = &H2


Private Type MYUSER '用户结构
username As String
password As String
regTime As String '注册时间
lastTime As String '最后登陆时间
End Type
Dim IniPath As String
'=======================================================程序退出后要保存好的变量=================================================================
Dim MyPort As String
Dim MyLog As String '日志保存路径
Dim MyUserNum As String
Dim MyOption As Boolean
Dim hideAsTrayWhenStart As Boolean
Dim StartWithWindows As Boolean
Dim ServiceWhenStart As Boolean '启动程序时启动服务

Dim user() As MYUSER '用户数组
'========================================================程序退出后要保存好的变量=================================================================



'========================================================读取信息=================================================================
Function GetFromINI(AppName As String, KeyName As String, FileName As String) As String
   Dim RetStr As String
   RetStr = String(255, Chr(0))
   GetFromINI = Left(RetStr, GetPrivateProfileString(AppName, ByVal KeyName, "", RetStr, Len(RetStr), FileName))
End Function '此函数被readini调用

Public Sub ReadIni()
    Dim i As Integer
    IniPath = App.Path + "\set\set.ini"
    i = str$(SHFileExists(IniPath))
    If i = 1 Then 'Str$值只有两种可能，0或者1
    Exit Sub
    Else
    MyPort = GetFromINI("软件设置", "MyPort", IniPath)
    MyLog = GetFromINI("软件设置", "MyLog", IniPath)
    MyUserNum = GetFromINI("软件设置", "MyUserNum", IniPath)
    MyOption = GetFromINI("软件设置", "MyOption", IniPath)
    hideAsTrayWhenStart = GetFromINI("软件设置", "hideAsTrayWhenStart", IniPath)
    StartWithWindows = GetFromINI("软件设置", "StartWithWindows", IniPath)
    ServiceWhenStart = GetFromINI("软件设置", "ServiceWhenStart", IniPath)
    End If
End Sub

Public Function readPort() As String
    readPort = MyPort
End Function

Public Function readLog() As String
    readLog = MyLog
End Function

Public Function readNum() As String
    readNum = MyUserNum
End Function

Public Function readOption() As String
    readOption = MyOption
End Function

Public Function readhideAsTrayWhenStart() As String
    readhideAsTrayWhenStart = hideAsTrayWhenStart
End Function
'ServiceWhenStart
Public Function readStartWithWindows() As String
    readStartWithWindows = StartWithWindows
End Function

Public Function readServiceWhenStart() As String
    readServiceWhenStart = ServiceWhenStart
End Function
'========================================================读取信息=================================================================



'========================================================保存信息=================================================================
Public Sub fillSet(Optional sPort As String = "2012", Optional sLog As String = "c:\log.txt", Optional sUserNum As String = "1", Optional sHideAsTray As String = False, Optional sStartWithWindows As String = True, Optional sService As String = False)
    MyPort = sPort
    MyLog = sLog
    MyUserNum = sUserNum
    hideAsTrayWhenStart = sHideAsTray
    StartWithWindows = sStartWithWindows
    ServiceWhenStart = sService
    
    Writeini "set"
End Sub

Public Sub Writeini(What As String)
    IniPath = App.Path + "\set\set.ini"
    If What = "set" Then
    WritePrivateProfileString "软件设置", "MyPort", MyPort, IniPath
    WritePrivateProfileString "软件设置", "MyLog", MyLog, IniPath
    WritePrivateProfileString "软件设置", "hideAsTrayWhenStart", CStr(hideAsTrayWhenStart), IniPath
    WritePrivateProfileString "软件设置", "StartWithWindows", CStr(StartWithWindows), IniPath
    WritePrivateProfileString "软件设置", "ServiceWhenStart", CStr(ServiceWhenStart), IniPath
    End If
End Sub


'========================================================保存信息=================================================================




'========================================================获取上网方式=================================================================
'返回是否通过局域网连接
Public Function IsLanConnection() As Boolean
    Dim dwFlags As Long
    Call InternetGetConnectedState(dwFlags, 0&)
    IsLanConnection = dwFlags And LanConnection
End Function

'返回是否使用调制解调器连接
Public Function IsModemConnection() As Boolean
    Dim dwFlags As Long
    Call InternetGetConnectedState(dwFlags, 0&)
    IsModemConnection = dwFlags And ModemConnection
End Function

'返回是否使用代理服务器连接
Public Function IsProxyConnection() As Boolean
    Dim dwFlags As Long
    Call InternetGetConnectedState(dwFlags, 0&)
    IsProxyConnection = dwFlags And ProxyConnection
End Function

'返回互联网是否连接
Public Function IsConnected() As Boolean
    IsConnected = InternetGetConnectedState(0&, 0&)
End Function

'返回远程访问服务是否安装 RAS.
Public Function IsRasInstalled() As Boolean
    Dim dwFlags As Long
    Call InternetGetConnectedState(dwFlags, 0&)
    IsRasInstalled = dwFlags And RasInstalled
End Function

Public Function ConnectionTypeMsg() As String
    Dim dwFlags As Long
    Dim msg As String
    If InternetGetConnectedState(dwFlags, 0&) Then

        If dwFlags And InternetConnectionIsConfigured Then
            msg = msg & "互联网已经配置完毕." & vbCrLf
        End If

        If dwFlags And LanConnection Then
            msg = msg & "本机已通过局域网(LAN)连接至外网."
        End If

        If dwFlags And ProxyConnection Then
            msg = msg & ",而且连接是通过代理服务器连接."
        Else
            msg = msg & "."
        End If

        If dwFlags And ModemConnection Then
            msg = msg & "本机已通过调制解调器(Modem)拨号连接至外网. "
        End If

        If dwFlags And InternetIsOffline Then
            msg = msg & "已经关闭当前互联网连接."
        End If

        If dwFlags And ModemConnectionIsBusy Then
            msg = msg & "调制解调器(Modem)繁忙暂时无法连接至外网."
        End If

        If dwFlags And RasInstalled Then
            msg = msg & "远程访问服务安装在本地系统."
        End If

    Else
        msg = "当前本机还没有连接到外网."

    End If

    ConnectionTypeMsg = msg

End Function
'========================================================获取上网方式=================================================================


