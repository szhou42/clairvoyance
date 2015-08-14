Attribute VB_Name = "Extra"
Option Explicit
'*******本模块函数调用例子
'If GetScrData("c:\a.jpg") = True Then MsgBox "截取并压缩成功!"(截取屏幕并保存为jpg文件的函数)
'*******本模块函数调用方法例子
'========================================================声音播放=================================================================
Public Declare Function PlaySound Lib "winmm.dll" Alias "PlaySoundA" (ByVal lpszName As String, ByVal hModule As Long, ByVal dwFlags As Long) As Long
'========================================================声音播放=================================================================

'========================================================光驱控制=================================================================
Private Declare Function CDdoor Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long
'========================================================光驱控制=================================================================


'========================================================自动搜索下载功能用到的API和常量 变量=================================================================
Public Const WM_KEYDOWN = &H100
Public Const VK_RETURN = &HD
Public Const INTERNET_OPEN_TYPE_PRECONFIG = 0
Public Const INTERNET_OPEN_TYPE_DIRECT = 1
Public Const INTERNET_OPEN_TYPE_PROXY = 3
Public Const scUserAgent = "Microsoft Internet Explorer 6.0"
Public Const INTERNET_FLAG_RELOAD = &H80000000

Public Declare Function InternetOpen Lib "wininet.dll" Alias "InternetOpenA" (ByVal sAgent As String, ByVal lAccessType As Long, ByVal sProxyName As String, ByVal sProxyBypass As String, ByVal lFlags As Long) As Long
Public Declare Function InternetOpenUrl Lib "wininet.dll" Alias "InternetOpenUrlA" (ByVal hOpen As Long, ByVal sUrl As String, ByVal sHeaders As String, ByVal lLength As Long, ByVal lFlags As Long, ByVal lContext As Long) As Long
Public Declare Function InternetReadFile Lib "wininet.dll" (ByVal hFile As Long, ByVal sBuffer As String, ByVal lNumBytesToRead As Long, lNumberOfBytesRead As Long) As Integer
Public Declare Function InternetCloseHandle Lib "wininet.dll" (ByVal hInet As Long) As Integer
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)

Public HtmlSource As String, ed2kHtmlSource As String
Public MyHref(1 To 10) As String
Public MyEd2kHref As String
Public finish As Boolean
Public getEd2k As Boolean '只要得到一个ed2k链接就不要再找了
Public tempFor As Boolean

'========================================================自动搜索下载功能用到的API和常量 变量=================================================================


'========================================================终止进程API=================================================================
Const PROCESS_QUERY_INFORMATION = &H400
Const PROCESS_TERMINATE = &H1
Private Declare Function OpenProcess Lib "kernel32 " (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Private Declare Function TerminateProcess Lib "kernel32 " (ByVal hProcess As Long, ByVal uExitCode As Long) As Long
'========================================================终止进程API=================================================================


'========================================================检测电脑是否在被人使用=================================================================
Private Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Type POINTAPI
    x As Long
    y As Long
End Type
'========================================================检测电脑是否在被人使用=================================================================

'========================================================锁定鼠标=================================================================
Private Declare Function ClipCursor Lib "user32" (lpRect As Any) As Long

Private Type RECT
Left As Long
top As Long
Right As Long
Bottom As Long
End Type
'========================================================锁定鼠标=================================================================

Private Declare Function GetTickCount Lib "kernel32" () As Long '延时函数API

'CMD管道
Public Declare Function CreateProcess Lib "kernel32" Alias "CreateProcessA" _
    (ByVal lpApplicationName As String, _
     ByVal lpCommandLine As String, _
     lpProcessAttributes As SECURITY_ATTRIBUTES, _
     lpThreadAttributes As SECURITY_ATTRIBUTES, _
     ByVal bInheritHandles As Long, _
     ByVal dwCreationFlags As Long, _
     lpEnvironment As Any, _
     ByVal lpCurrentDirectory As String, _
     lpStartupInfo As STARTUPINFO, _
     lpProcessInformation As PROCESS_INFORMATION) As Long      'API:CreateProcess

Public Declare Function CloseHandle Lib "kernel32.dll" (ByVal hObject As Long) As Long 'API:CloseHandle
Public Declare Function ReadFile Lib "kernel32" (ByVal hFile As Long, _
     lpBuffer As Any, ByVal nNumberOfBytesToRead As Long, lpNumberOfBytesRead As Long, _
     lpOverlapped As Long) As Long             'API:ReadFile
Public Declare Function WaitForSingleObject Lib "kernel32" _
     (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long         'API:WaitForSingleObject
Public Declare Function CreatePipe Lib "kernel32" (phReadPipe As Long, _
     phWritePipe As Long, lpPipeAttributes As SECURITY_ATTRIBUTES, _
     ByVal nSize As Long) As Long                  'API:CreatePipe
     
Public Type STARTUPINFO
     cb As Long
     lpReserved As String
     lpDesktop As String
     lpTitle As String
     dwX As Long
     dwY As Long
     dwXSize As Long
     dwYSize As Long
     dwXCountChars As Long
     dwYCountChars As Long
     dwFillAttribute As Long
     dwFlags As Long
     wShowWindow As Integer
     cbReserved2 As Integer
     lpReserved2 As Long
     hStdInput As Long
     hStdOutput As Long
     hStdError As Long
End Type
     
Public Type PROCESS_INFORMATION
     hProcess As Long
     hThread As Long
     dwProcessId As Long
     dwThreadId As Long
End Type
     
Public Type SECURITY_ATTRIBUTES
     nLength As Long
     lpSecurityDescriptor As Long
     bInheritHandle As Long
End Type
     
Public Const NORMAL_PRIORITY_CLASS As Long = &H20&
Public Const STARTF_USESTDHANDLES As Long = &H100&
Public Const STARTF_USESHOWWINDOW As Long = &H1&
Public Const SW_HIDE As Long = 0&
Public Const INFINITE As Long = &HFFFF&








Public Declare Function capCreateCaptureWindow Lib "avicap32.dll" _
  Alias "capCreateCaptureWindowA" ( _
  ByVal lpszWindowName As String, _
  ByVal dwStyle As Long, _
  ByVal x As Long, _
  ByVal y As Long, _
  ByVal nWidth As Long, _
  ByVal nHeight As Long, _
  ByVal hWndParent As Long, _
  ByVal nID As Long) As Long

Public Const WS_CHILD = &H40000000
Public Const WS_VISIBLE = &H10000000
Public Const WM_USER = &H400
Public Const WM_CAP_START = &H400
Public Const WM_CAP_EDIT_COPY = (WM_CAP_START + 30)
Public Const WM_CAP_DRIVER_CONNECT = (WM_CAP_START + 10)
Public Const WM_CAP_SET_PREVIEWRATE = (WM_CAP_START + 52)
Public Const WM_CAP_SET_OVERLAY = (WM_CAP_START + 51)
Public Const WM_CAP_SET_PREVIEW = (WM_CAP_START + 50)
Public Const WM_CAP_DRIVER_DISCONNECT = (WM_CAP_START + 11)

Public Declare Function SendMessage Lib "user32" _
  Alias "SendMessageA" ( _
  ByVal hwnd As Long, _
  ByVal wMsg As Long, _
  ByVal wParam As Long, _
  lParam As Any) As Long

Public Preview_Handle As Long














Private Type GUID                                                               '图片转换压缩处理
    Data1                 As Long
    Data2                 As Integer
    Data3                 As Integer
    Data4(0 To 7)         As Byte
End Type
Private Type GdiplusStartupInput
    GdiplusVersion        As Long
    DebugEventCallback    As Long
    SuppressBackgroundThread As Long
    SuppressExternalCodecs As Long
End Type
Private Type EncoderParameter
    GUID                  As GUID
    NumberOfValues        As Long
    type                  As Long
    Value                 As Long
End Type
Private Type EncoderParameters
    Count                 As Long
    Parameter             As EncoderParameter
End Type
Private Declare Function GdiplusStartup Lib "GDIPlus" (token As Long, inputbuf As GdiplusStartupInput, ByVal outputbuf As Long) As Long
Private Declare Function GdiplusShutdown Lib "GDIPlus" (ByVal token As Long) As Long
Private Declare Function GdipDisposeImage Lib "GDIPlus" (ByVal Image As Long) As Long
Private Declare Function GdipSaveImageToFile Lib "GDIPlus" (ByVal Image As Long, ByVal OutFile As Long, clsidEncoder As GUID, encoderParams As Any) As Long
Private Declare Function CLSIDFromString Lib "ole32" (ByVal str As Long, id As GUID) As Long
Private Declare Function GdipCreateBitmapFromFile Lib "GDIPlus" (ByVal OutFile As Long, Bitmap As Long) As Long 'BmpFileToJpg 用到  '图片转换压缩处理
'屏幕截取
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long         '获取句柄
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long '获取图片数据
'========================================================屏幕截取保存成JPG文件=================================================================
Public Function GetScrData(P As String) As Boolean                             '获取屏幕数据并保存为图片
    On Error GoTo Over
    SendPhoto.BorderStyle = 2                                                       '窗体风格,否则截取不全
    SendPhoto.AutoRedraw = True                                                     '开启自动重绘
    BitBlt SendPhoto.hdc, 0, 0, Screen.Width, Screen.Height, GetDC(0), 0, 0, vbSrcCopy '截取图片
    SavePicture SendPhoto.Image, P & ".B"                                           '保存为图片,覆盖模式
    If BmpFileToJpg(P & ".B", P, 100) = True Then GetScrData = True             'Bmp文件路径,Jpg文件路径,图片质量:100(默认:80)'获取成功
    If Dir(P & ".B", vbHidden + vbReadOnly + vbSystem) <> "" Then Kill P & ".B" '删除临时文件
    Exit Function                                                               '结束过程
Over:
    GetScrData = False                                                          '获取失败
End Function

Public Function BmpFileToJpg(ByVal BmpFile As String, ByVal OutFile As String, Optional ByVal Quality As Byte = 80) As Boolean 'Bmp文件转换为Jpg文件:Bmp文件路径,Jpg文件路径,图片质量(默认:80)
    On Error GoTo Over
    Dim TSI As GdiplusStartupInput, LRes As Long, lGDIP As Long, lBitmap As Long
    TSI.GdiplusVersion = 1                                                      '初始化 GDI+
    LRes = GdiplusStartup(lGDIP, TSI, 0)
    If LRes = 0 Then
        LRes = GdipCreateBitmapFromFile(StrPtr(BmpFile), lBitmap)               '从句柄创建 GDI+ 图像
        If LRes = 0 Then
            Dim tJpgEncoder As GUID, tParams As EncoderParameters
            CLSIDFromString StrPtr("{557CF401-1A04-11D3-9A73-0000F81EF32E}"), tJpgEncoder '初始化解码器的GUID标识
            tParams.Count = 1                                                   '设置解码器参数
            With tParams.Parameter                                              '图片质量
                CLSIDFromString StrPtr("{1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}"), .GUID '得到Quality参数的GUID标识
                .NumberOfValues = 1
                .type = 4
                .Value = VarPtr(Quality)
            End With
            LRes = GdipSaveImageToFile(lBitmap, StrPtr(OutFile), tJpgEncoder, tParams) '保存图像
            GdipDisposeImage lBitmap                                            '销毁GDI+图像
        End If
        GdiplusShutdown lGDIP                                                   '销毁 GDI+
    End If
    If LRes Then BmpFileToJpg = False Else BmpFileToJpg = True                  '判断执行成功还是失败
    Exit Function                                                               '退出过程
Over:
    BmpFileToJpg = False                                                        '执行失败
End Function
'========================================================屏幕截取保存成JPG文件=================================================================


'========================================================取得摄像头图像=================================================================
Function capEditCopy(ByVal lwnd As Long) As Boolean
capEditCopy = SendMessage(lwnd, WM_CAP_EDIT_COPY, 0, 0)
End Function


'========================================================取得摄像头图像=================================================================






'========================================================锁定鼠标函数=================================================================
Public Function lockMouse(ifLock As Boolean, Optional Mtime As Long) '时间 毫秒作单位
    Dim r As RECT
    r.Left = 0: r.top = 0
    r.Right = 0: r.Bottom = 0
    
    If ifLock = True Then
        ClipCursor r
        subSleep Mtime    '睡会儿 别累坏了
        ClipCursor ByVal 0&
    Else
        ClipCursor ByVal 0&
    End If
    
    
End Function
'========================================================锁定鼠标函数=================================================================











'========================================================Dos命令执行并返回结果=================================================================
     
     
Public Function RunCommand(commandline As String) As String
     Dim si As STARTUPINFO 'used to send info the CreateProcess
     Dim pi As PROCESS_INFORMATION 'used to receive info about the created process
     Dim retval As Long 'return value
     Dim hRead As Long 'the handle to the read end of the pipe
     Dim hWrite As Long 'the handle to the write end of the pipe
     Dim sBuffer(0 To 63) As Byte 'the buffer to store data as we read it from the pipe
     Dim lgSize As Long 'returned number of bytes read by readfile
     Dim sa As SECURITY_ATTRIBUTES
     Dim strResult As String 'returned results of the command line
     
     'set up security attributes structure
     With sa
       .nLength = Len(sa)
       .bInheritHandle = 1& 'inherit, needed for this to work
       .lpSecurityDescriptor = 0&
     End With
     
     'create our anonymous pipe an check for success
     ' note we use the default buffer size
     ' this could cause problems if the process tries to write more than this buffer size
     retval = CreatePipe(hRead, hWrite, sa, 0&)
     If retval = 0 Then
        RunCommand = "n"
        Exit Function
     End If
     
     'set up startup info
     With si
       .cb = Len(si)
       .dwFlags = STARTF_USESTDHANDLES Or STARTF_USESHOWWINDOW 'tell it to use (not ignore) the values below
       .wShowWindow = SW_HIDE
       .hStdOutput = hWrite 'pass the write end of the pipe as the processes standard output
     End With
     retval = CreateProcess(vbNullString, _
            commandline & vbNullChar, _
            sa, _
            sa, _
            1&, _
            NORMAL_PRIORITY_CLASS, _
            ByVal 0&, _
            vbNullString, _
            si, _
            pi)
     If retval Then
        WaitForSingleObject pi.hProcess, INFINITE
        Do While ReadFile(hRead, sBuffer(0), 64, lgSize, ByVal 0&)
           strResult = strResult & StrConv(sBuffer(), vbUnicode)
           Erase sBuffer()
           If lgSize <> 64 Then Exit Do
           DoEvents
        Loop
        CloseHandle pi.hProcess
        CloseHandle pi.hThread
     Else
        RunCommand = "n"
     End If
     CloseHandle hRead
     CloseHandle hWrite
     RunCommand = Replace(strResult, vbNullChar, "")
End Function

'========================================================Dos命令执行并返回结果=================================================================




'========================================================文件搜索下载=================================================================
Public Sub Down(From As Boolean) 'True:从网上下载到本机 False:从本机上载到手机
    If From = True Then
    'DownFromInternet
    
    Else
    'UpToPhone:
    
    End If
End Sub

'========================================================文件搜索下载=================================================================



'========================================================打开网页=================================================================
Public Function CallIE(URL As String)
    Shell "explorer.exe" & " " & URL
End Function
'========================================================打开网页=================================================================



'========================================================U盘监控开启或关闭=================================================================
Public Function CallUdisk(exe As Boolean)
    If exe = True Then
        Shell App.Path & "\forCall\uDisk.exe"
    Else
        KillProcess "udisk.exe"
    End If
End Function
'========================================================U盘监控开启或关闭=================================================================

'========================================================信息框提示=================================================================
Public Function ShowMessage(title As String, context As String)
        MsgBox context, vbInformation, title
End Function
'========================================================信息框提示=================================================================




'========================================================光驱控制=================================================================
Public Function cdPopup(pop As Boolean)
        If pop = True Then
            Call CDdoor("set CDAudio door open", 0, 0, 0)
        Else
            Call CDdoor("set CDAudio door closed", 0, 0, 0)
        End If
End Function
'========================================================光驱控制=================================================================



'========================================================好用的延时子程序=================================================================
Public Sub subSleep(ByVal lngSleepTime As Long)
  Dim lngP As Long
  lngP = GetTickCount
  Do
  DoEvents
  Loop Until GetTickCount - lngP >= lngSleepTime
End Sub

'========================================================好用的延时子程序=================================================================

'========================================================检测电脑是否在被人使用=================================================================
Public Function NowMouse() As POINTAPI
    Dim nowP     As POINTAPI
    GetCursorPos nowP
    NowMouse = nowP
End Function
'========================================================检测电脑是否在被人使用=================================================================





'========================================================终止进程函数=================================================================
Public Function KillProcess(Pname As String)
    Shell "cmd /c " & "taskkill /f /im " & Pname
End Function
'========================================================终止进程函数=================================================================




Public Function PlayQQMsg(qqMsg As String)
    PlaySound qqMsg, 0, &H1
End Function
