Attribute VB_Name = "Mess"
Option Explicit
Public Declare Function InternetGetConnectedState Lib "wininet.dll" (ByRef lpdwFlags As Long, ByVal dwReserved As Long) As Long
Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, lpKeyName As Any, ByVal lpDefault As String, ByVal lpRetunedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Private Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lplFileName As String) As Long
Private Declare Function SHFileExists Lib "shell32" Alias "#45" (ByVal szPath As String) As Long

 '�����������������.
Public Const ProxyConnection As Long = &H4
'Modem æ.
Public Const ModemConnectionIsBusy As Long = &H8

'�����ر�
Public Const InternetIsOffline As Long = &H20

'�����Ѿ��������
Public Const InternetConnectionIsConfigured As Long = &H40

'ͨ�����ƽ������������.
Public Const ModemConnection As Long = &H1

'Զ�̷��ʷ��� (Remote Access Server)�Ƿ�װ.
Public Const RasInstalled As Long = &H10

'ͨ����������������.
Public Const LanConnection As Long = &H2


Private Type MYUSER '�û��ṹ
username As String
password As String
regTime As String 'ע��ʱ��
lastTime As String '����½ʱ��
End Type
Dim IniPath As String
'=======================================================�����˳���Ҫ����õı���=================================================================
Dim MyPort As String
Dim MyLog As String '��־����·��
Dim MyUserNum As String
Dim MyOption As Boolean
Dim hideAsTrayWhenStart As Boolean
Dim StartWithWindows As Boolean
Dim ServiceWhenStart As Boolean '��������ʱ��������

Dim user() As MYUSER '�û�����
'========================================================�����˳���Ҫ����õı���=================================================================



'========================================================��ȡ��Ϣ=================================================================
Function GetFromINI(AppName As String, KeyName As String, FileName As String) As String
   Dim RetStr As String
   RetStr = String(255, Chr(0))
   GetFromINI = Left(RetStr, GetPrivateProfileString(AppName, ByVal KeyName, "", RetStr, Len(RetStr), FileName))
End Function '�˺�����readini����

Public Sub ReadIni()
    Dim i As Integer
    IniPath = App.Path + "\set\set.ini"
    i = str$(SHFileExists(IniPath))
    If i = 1 Then 'Str$ֵֻ�����ֿ��ܣ�0����1
    Exit Sub
    Else
    MyPort = GetFromINI("�������", "MyPort", IniPath)
    MyLog = GetFromINI("�������", "MyLog", IniPath)
    MyUserNum = GetFromINI("�������", "MyUserNum", IniPath)
    MyOption = GetFromINI("�������", "MyOption", IniPath)
    hideAsTrayWhenStart = GetFromINI("�������", "hideAsTrayWhenStart", IniPath)
    StartWithWindows = GetFromINI("�������", "StartWithWindows", IniPath)
    ServiceWhenStart = GetFromINI("�������", "ServiceWhenStart", IniPath)
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
'========================================================��ȡ��Ϣ=================================================================



'========================================================������Ϣ=================================================================
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
    WritePrivateProfileString "�������", "MyPort", MyPort, IniPath
    WritePrivateProfileString "�������", "MyLog", MyLog, IniPath
    WritePrivateProfileString "�������", "hideAsTrayWhenStart", CStr(hideAsTrayWhenStart), IniPath
    WritePrivateProfileString "�������", "StartWithWindows", CStr(StartWithWindows), IniPath
    WritePrivateProfileString "�������", "ServiceWhenStart", CStr(ServiceWhenStart), IniPath
    End If
End Sub


'========================================================������Ϣ=================================================================




'========================================================��ȡ������ʽ=================================================================
'�����Ƿ�ͨ������������
Public Function IsLanConnection() As Boolean
    Dim dwFlags As Long
    Call InternetGetConnectedState(dwFlags, 0&)
    IsLanConnection = dwFlags And LanConnection
End Function

'�����Ƿ�ʹ�õ��ƽ��������
Public Function IsModemConnection() As Boolean
    Dim dwFlags As Long
    Call InternetGetConnectedState(dwFlags, 0&)
    IsModemConnection = dwFlags And ModemConnection
End Function

'�����Ƿ�ʹ�ô������������
Public Function IsProxyConnection() As Boolean
    Dim dwFlags As Long
    Call InternetGetConnectedState(dwFlags, 0&)
    IsProxyConnection = dwFlags And ProxyConnection
End Function

'���ػ������Ƿ�����
Public Function IsConnected() As Boolean
    IsConnected = InternetGetConnectedState(0&, 0&)
End Function

'����Զ�̷��ʷ����Ƿ�װ RAS.
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
            msg = msg & "�������Ѿ��������." & vbCrLf
        End If

        If dwFlags And LanConnection Then
            msg = msg & "������ͨ��������(LAN)����������."
        End If

        If dwFlags And ProxyConnection Then
            msg = msg & ",����������ͨ���������������."
        Else
            msg = msg & "."
        End If

        If dwFlags And ModemConnection Then
            msg = msg & "������ͨ�����ƽ����(Modem)��������������. "
        End If

        If dwFlags And InternetIsOffline Then
            msg = msg & "�Ѿ��رյ�ǰ����������."
        End If

        If dwFlags And ModemConnectionIsBusy Then
            msg = msg & "���ƽ����(Modem)��æ��ʱ�޷�����������."
        End If

        If dwFlags And RasInstalled Then
            msg = msg & "Զ�̷��ʷ���װ�ڱ���ϵͳ."
        End If

    Else
        msg = "��ǰ������û�����ӵ�����."

    End If

    ConnectionTypeMsg = msg

End Function
'========================================================��ȡ������ʽ=================================================================


