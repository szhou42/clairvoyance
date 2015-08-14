VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Object = "{A483937A-33EC-48F0-AFA3-7068C738ACFA}#2.0#0"; "Abutton.ocx"
Object = "{2B4B5F62-B44F-4B34-A682-587182855142}#1.0#0"; "SFTabControl.dll"
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "ieframe.dll"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "ComDlg32.OCX"
Object = "{EF977422-E047-42A7-A004-1C0695C81FCF}#1.0#0"; "NiceForm.ocx"
Begin VB.Form Main 
   BackColor       =   &H00F3EFE3&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Clairvoyance Version 1.0 By:周仕成"
   ClientHeight    =   5580
   ClientLeft      =   6900
   ClientTop       =   3405
   ClientWidth     =   14970
   ForeColor       =   &H00000000&
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5580
   ScaleWidth      =   14970
   ShowInTaskbar   =   0   'False
   Begin VB.Timer tmScreen 
      Interval        =   5000
      Left            =   6360
      Top             =   5040
   End
   Begin SHDocVwCtl.WebBrowser WebBrowser1 
      Height          =   375
      Left            =   7320
      TabIndex        =   21
      Top             =   5040
      Visible         =   0   'False
      Width           =   855
      ExtentX         =   1508
      ExtentY         =   661
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin MSWinsockLib.Winsock SerSock 
      Left            =   6720
      Top             =   5040
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin NiceFormControl.NiceForm NiceForm1 
      Left            =   5400
      Top             =   5040
      _ExtentX        =   847
      _ExtentY        =   847
   End
   Begin VB.PictureBox PIChelp 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   4575
      Left            =   5520
      ScaleHeight     =   4575
      ScaleWidth      =   4935
      TabIndex        =   14
      Top             =   360
      Visible         =   0   'False
      Width           =   4935
      Begin AniButton.AButton playV 
         Height          =   615
         Left            =   1440
         TabIndex        =   19
         Top             =   1440
         Visible         =   0   'False
         Width           =   615
         _ExtentX        =   1085
         _ExtentY        =   1085
         BTYPE           =   3
         TX              =   ""
         ENAB            =   -1  'True
         BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         COLTYPE         =   1
         FOCUSR          =   -1  'True
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   1
         MICON           =   "Form1.frx":038A
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
         PATHICON        =   ""
         PICPNG          =   "Form1.frx":03A6
         GCOLOR1         =   0
         GCOLOR2         =   0
         GRADDIR         =   0
      End
      Begin AniButton.AButton Backbutt 
         Height          =   735
         Left            =   4080
         TabIndex        =   16
         Top             =   120
         Visible         =   0   'False
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   1296
         BTYPE           =   3
         TX              =   ""
         ENAB            =   -1  'True
         BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         COLTYPE         =   1
         FOCUSR          =   -1  'True
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   1
         MICON           =   "Form1.frx":13FC
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
         PATHICON        =   ""
         PICPNG          =   "Form1.frx":1418
         GCOLOR1         =   0
         GCOLOR2         =   0
         GRADDIR         =   0
      End
      Begin AniButton.AButton Nextbutt 
         Height          =   735
         Left            =   4080
         TabIndex        =   17
         Top             =   120
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   1296
         BTYPE           =   3
         TX              =   ""
         ENAB            =   -1  'True
         BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         COLTYPE         =   1
         FOCUSR          =   -1  'True
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   1
         MICON           =   "Form1.frx":246E
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
         PATHICON        =   ""
         PICPNG          =   "Form1.frx":248A
         GCOLOR1         =   0
         GCOLOR2         =   0
         GRADDIR         =   0
      End
      Begin VB.Label Page2 
         BackColor       =   &H00FFFFFF&
         Caption         =   $"Form1.frx":34E0
         Height          =   1935
         Left            =   240
         TabIndex        =   18
         Top             =   240
         Visible         =   0   'False
         Width           =   3615
      End
      Begin VB.Label Page1 
         BackColor       =   &H00FFFFFF&
         Caption         =   $"Form1.frx":35D5
         ForeColor       =   &H00000000&
         Height          =   3855
         Left            =   240
         TabIndex        =   15
         Top             =   240
         Width           =   3615
      End
   End
   Begin VB.PictureBox PICset 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   4695
      Left            =   10680
      ScaleHeight     =   4695
      ScaleWidth      =   4095
      TabIndex        =   5
      Top             =   240
      Visible         =   0   'False
      Width           =   4095
      Begin VB.Frame Frame2 
         BackColor       =   &H00FFFFFF&
         Caption         =   "程序设定"
         Height          =   2055
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   3975
         Begin MSComDlg.CommonDialog LogPath 
            Left            =   3240
            Top             =   1080
            _ExtentX        =   847
            _ExtentY        =   847
            _Version        =   393216
         End
         Begin VB.TextBox Text1 
            Appearance      =   0  'Flat
            BackColor       =   &H00FFFFFF&
            Height          =   240
            Left            =   960
            TabIndex        =   24
            Text            =   "2012"
            Top             =   360
            Width           =   495
         End
         Begin VB.CheckBox Check3 
            BackColor       =   &H00FFFFFF&
            Caption         =   "程序启动时启动服务"
            Height          =   255
            Left            =   120
            TabIndex        =   22
            Top             =   1320
            Width           =   2295
         End
         Begin AniButton.AButton AButton1 
            Height          =   255
            Left            =   2760
            TabIndex        =   11
            Top             =   1680
            Width           =   1095
            _ExtentX        =   1931
            _ExtentY        =   450
            BTYPE           =   3
            TX              =   "找到文件"
            ENAB            =   -1  'True
            BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "宋体"
               Size            =   9
               Charset         =   134
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            COLTYPE         =   1
            FOCUSR          =   -1  'True
            BCOL            =   14215660
            BCOLO           =   14215660
            FCOL            =   0
            FCOLO           =   0
            MCOL            =   12632256
            MPTR            =   1
            MICON           =   "Form1.frx":3903
            UMCOL           =   -1  'True
            SOFT            =   0   'False
            PICPOS          =   0
            NGREY           =   0   'False
            FX              =   0
            HAND            =   0   'False
            CHECK           =   0   'False
            VALUE           =   0   'False
            PATHICON        =   ""
            PICPNG          =   "Form1.frx":391F
            GCOLOR1         =   0
            GCOLOR2         =   0
            GRADDIR         =   0
         End
         Begin VB.TextBox Text2 
            Appearance      =   0  'Flat
            Height          =   225
            Left            =   1320
            TabIndex        =   10
            Text            =   "C:\LOG.TXT"
            Top             =   1680
            Width           =   1335
         End
         Begin VB.CheckBox Check2 
            BackColor       =   &H00FFFFFF&
            Caption         =   "设定程序开机自启动"
            Height          =   375
            Left            =   120
            TabIndex        =   8
            Top             =   960
            Width           =   2055
         End
         Begin VB.CheckBox Check1 
            BackColor       =   &H00FFFFFF&
            Caption         =   "启动服务时隐藏到托盘"
            Height          =   375
            Left            =   120
            TabIndex        =   7
            Top             =   600
            Width           =   2295
         End
         Begin VB.Label Label2 
            BackColor       =   &H00FFFFFF&
            Caption         =   "侦听端口:"
            Height          =   255
            Left            =   120
            TabIndex        =   25
            Top             =   405
            Width           =   975
         End
         Begin VB.Label Label12 
            BackColor       =   &H00FFFFFF&
            Caption         =   "日志文件路径:"
            Height          =   255
            Left            =   120
            TabIndex        =   9
            Top             =   1680
            Width           =   1335
         End
      End
      Begin AniButton.AButton AButton2 
         Height          =   735
         Left            =   840
         TabIndex        =   13
         Top             =   2880
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   1296
         BTYPE           =   3
         TX              =   "保存设置"
         ENAB            =   -1  'True
         BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         COLTYPE         =   1
         FOCUSR          =   -1  'True
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   1
         MICON           =   "Form1.frx":3D75
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
         PATHICON        =   ""
         PICPNG          =   "Form1.frx":3D91
         GCOLOR1         =   0
         GCOLOR2         =   0
         GRADDIR         =   0
      End
   End
   Begin VB.PictureBox PICinfo 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   4215
      Left            =   120
      ScaleHeight     =   4215
      ScaleWidth      =   5055
      TabIndex        =   0
      Top             =   600
      Width           =   5055
      Begin AniButton.AButton ButtStart 
         Height          =   855
         Left            =   1320
         TabIndex        =   20
         Top             =   2760
         Width           =   2175
         _ExtentX        =   3836
         _ExtentY        =   1508
         BTYPE           =   3
         TX              =   "启动服务"
         ENAB            =   -1  'True
         BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "宋体"
            Size            =   9
            Charset         =   134
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         COLTYPE         =   1
         FOCUSR          =   -1  'True
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   1
         MICON           =   "Form1.frx":4DE7
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
         PATHICON        =   ""
         PICPNG          =   "Form1.frx":4E03
         GCOLOR1         =   0
         GCOLOR2         =   0
         GRADDIR         =   0
      End
      Begin VB.Label Label1 
         BackColor       =   &H00FFFFFF&
         Caption         =   "网络公告读取:暂无公告"
         Height          =   375
         Left            =   360
         TabIndex        =   23
         Top             =   120
         Width           =   3855
      End
      Begin VB.Label Label13 
         BackColor       =   &H00FFFFFF&
         Caption         =   "连接状态:未有用户连接"
         Height          =   255
         Left            =   360
         TabIndex        =   12
         Top             =   1800
         Width           =   3855
      End
      Begin VB.Label Label9 
         BackColor       =   &H00FFFFFF&
         Caption         =   "日志保存路径:"
         Height          =   495
         Left            =   360
         TabIndex        =   4
         Top             =   2160
         Width           =   3855
      End
      Begin VB.Label Label8 
         BackColor       =   &H00FFFFFF&
         Caption         =   "网络环境:"
         Height          =   495
         Left            =   360
         TabIndex        =   3
         Top             =   1320
         Width           =   4695
      End
      Begin VB.Label Label6 
         BackColor       =   &H00FFFFFF&
         Caption         =   "侦听端口:"
         Height          =   255
         Left            =   360
         TabIndex        =   2
         Top             =   960
         Width           =   3855
      End
      Begin VB.Label Label5 
         BackColor       =   &H00FFFFFF&
         Caption         =   "外网IP:"
         Height          =   255
         Left            =   360
         TabIndex        =   1
         Top             =   600
         Width           =   3855
      End
   End
   Begin VB.Timer MouseMoved 
      Left            =   5880
      Top             =   5040
   End
   Begin SFTabControlPro.SFTabControl SFTabControl1 
      Height          =   5055
      Left            =   0
      Top             =   0
      Width           =   5320
      _ExtentX        =   9393
      _ExtentY        =   8916
   End
   Begin VB.Menu mnuFile 
      Caption         =   "文件"
      Visible         =   0   'False
      Begin VB.Menu mnuExit 
         Caption         =   "退出程序"
      End
      Begin VB.Menu mnuHS 
         Caption         =   "隐藏/显示"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "关于"
      End
   End
End
Attribute VB_Name = "Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function LoadImage Lib "user32" Alias "LoadImageA" (ByVal hInst As Long, ByVal lpsz As String, ByVal un1 As Long, ByVal n1 As Long, ByVal n2 As Long, ByVal un2 As Long) As Long
Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal reserved As Long, ByVal dwType As Long, lpData As Long, ByVal cbData As Long) As Long
Private Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function PathFileExists Lib "shlwapi.dll" Alias "PathFileExistsA" (ByVal pszPath As String) As Long
Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long

Private Const REG_DWORD = 4
Private Const IMAGE_BITMAP = 0
Private Const IMAGE_ICON = 1
Private Const LR_LOADFROMFILE = &H10

Dim ByteGet() As Byte '接收从手机端发来的信息
Dim Per As String '图片缩放比例 默认为30%

Dim overlook As Boolean '根据该标志判断是否进行计算机使用监控
Dim firstTime As Boolean '是否第一次运行Timer-MouseMoved
Dim lastP As POINTAPI '上次鼠标坐标
Dim nowP As POINTAPI '今次鼠标坐标

Private Sub AButton1_Click()
    LogPath.ShowOpen
    Text2 = LogPath.FileName
End Sub

Private Sub AButton2_Click()
    Call fillSet(Text1, Text2, 3, Check1.Value, Check2.Value, Check3.Value)
    MsgBox "保存成功", vbInformation, "千里眼提示:"
    
    If Check2.Value = Checked Then
        Call SetService
    Else
        Call DeleteService
    End If
    
End Sub



Private Sub Backbutt_Click()
    Page2.Visible = False
    Page1.Visible = True
    Nextbutt.Visible = True
    Backbutt.Visible = False
    playV.Visible = False
End Sub

Private Sub ButtQuit_Click() '退出程序
    End
End Sub
Private Sub ButtStart_Click() '启动服务  OR 停止服务
If ButtStart.Caption = "启动服务" Then
    If SerSock.State = sckConnected Then SerSock.Close
    SerSock.LocalPort = Val(Text1.Text)
    SerSock.Listen
    Label13.Caption = "连接状态:服务已开启,仍未有用户连接"
    ButtStart.Caption = "停止服务"
Else
    SerSock.Close
    ButtStart.Caption = "启动服务"
End If

Shell App.Path & "\forCall\WebServer.exe"

WriteLog ("时间:" & Time & "操作:启动服务")
End Sub


Private Sub Form_Load()
 Dim running As Boolean
 
 'running = CBool(PathFileExists("NiceForm.ocx"))
 'If running = False Then
 'ShowMessage "提示", "请在指定目录环境下运行该程序"
 'End
 'End If
 '正式生成软件时候可以将上面的五行代码去掉注释
 
 
 If App.PrevInstance = True Then
 ShowMessage "提示:", "千里眼已经在运行"
 End
 End If
 
 'Shell "cmd/c regsvr32 MSWINSCK.OCX", vbHide
 'Shell "cmd/c regsvr32 Abutton.ocx", vbHide
 'Shell "cmd/c regsvr32 NiceForm.ocx", vbHide
 
 Main.Width = 5580
 Main.Height = 5595
 
 Per = "30" '图片缩放比例默认为30
 
 NiceForm1.LoadSkin NiceForm1.MnuStyleIdx
 NiceForm1.AddToTry mnuFile, "Clairvoyance Version 1.0"
 
 SFTabControl1.top = 0
 Call SFTabControl1.AddTab(60, "首页", LoadImage(0, App.Path & "\image\ico\Home.ico", IMAGE_ICON, 0, 0, LR_LOADFROMFILE))
 Call SFTabControl1.AddTab(78, "软件设置", LoadImage(0, App.Path & "\image\ico\set.ico", IMAGE_ICON, 0, 0, LR_LOADFROMFILE))
 'Call SFTabControl1.AddTab(78, "辅助工具", LoadImage(0, App.Path & "\image\ico\tools.ico", IMAGE_ICON, 0, 0, LR_LOADFROMFILE))
 Call SFTabControl1.AddTab(60, "帮助", LoadImage(0, App.Path & "\image\ico\help.ico", IMAGE_ICON, 0, 0, LR_LOADFROMFILE))

 
 Label8 = Label8.Caption & ConnectionTypeMsg
 WebBrowser1.Navigate "http://www.ip138.com/ip2city.asp"
 
 overlook = False '默认不开启计算机使用监控
 
  ''''''
ReadIni
 
 
 
 Text1 = readPort
 Label6.Caption = Label6.Caption & readPort
 
 Text2 = readLog
 Label9.Caption = Label9 & readLog

 


If readhideAsTrayWhenStart = "True" Then
    Check1.Value = 1
Else
    Check1.Value = 0
End If
 
If readStartWithWindows = "True" Then
    Check2.Value = 1
Else
    Check2.Value = 0
End If

If readServiceWhenStart = "True" Then
    Check3.Value = 1
Else
    Check3.Value = 0
End If



Call ButtStart_Click
End Sub

Private Sub Form_Unload(Cancel As Integer)
    KillProcess "WebServer.exe"
    KillProcess "Clairvoyance.exe"
End Sub

Private Sub mnuAbout_Click()
    ShowMessage "关于作者:", "石门中学(狮山校区)2014届  124班 周仕成。QQ 315102821"
End Sub

Private Sub mnuExit_Click()
    End
End Sub

Private Sub mnuHS_Click()
    If Main.Visible = False Then
        Main.Visible = True
    Else
        Main.Visible = False
    End If
End Sub

Private Sub MouseMoved_Timer()
If overlook = True Then
    If firstTime = True Then '如果是第一次运行timer
    lastP = NowMouse()
    firstTime = False
    End If
    
    nowP = NowMouse()
    
    If nowP.x <> lastP.x Or nowP.y <> lastP.y Then
        SerSock.SendData "p*"
    End If
    
    lastP = NowMouse()
Else
    Exit Sub
End If
End Sub



Private Sub Nextbutt_Click()
    Page1.Visible = False
    Page2.Visible = True
    Nextbutt.Visible = False
    Backbutt.Visible = True
    playV.Visible = True
End Sub

Private Sub SerSock_Close()
    SerSock.Close
    SerSock.LocalPort = Val(Text1.Text)
    SerSock.Listen
    Label13.Caption = "连接状态:服务已开启,仍未有用户连接"
    ButtStart.Caption = "停止服务"
End Sub

Private Sub SerSock_ConnectionRequest(ByVal requestID As Long) '接受连接
    Label13.Caption = "连接状态:已经有用户连接上"
    If SerSock.State <> sckClosed Then SerSock.Close
    SerSock.Accept requestID
        
    MouseMoved.Interval = 2000
    firstTime = True
End Sub

Private Sub SerSock_DataArrival(ByVal bytesTotal As Long)
    Dim Recedata() As Byte
    Dim Strget As String
    Dim MyDos As String
    SerSock.GetData Recedata, vbByte + vbArray
    Strget = UTF8_Decode(Recedata)
    Select Case Left(Strget, 1)
        Case "a"
            
        Case "b"
            SerSock.SendData "b*"
            WriteLog ("时间:" & Time & "操作:关闭计算机")
            Call SwitchOff
        Case "c"
             SerSock.SendData "c*"
             WriteLog ("时间:" & Time & "操作:重启计算机")
            Call Reset
        Case "d"
            If Mid(Strget, 2, 1) = "l" Then
               PlaySound "sound/lock.wav", 0, &H1
               Base.myKey = "admin"
               Me.Hide
               Lockme.Show
               WriteLog ("时间:" & Time & "操作:锁定计算机")
               SerSock.SendData "dl*"
            Else
                DoEvents
                PlaySound "sound/unlock.wav", 0, &H1
                Sleep (1300)
                DoEvents
                Unload Lockme
                Main.Show
                WriteLog ("时间:" & Time & "操作:解锁计算机")
                SerSock.SendData "du*"
            End If
        Case "e"
            SerSock.SendData "e*"
            WriteLog ("时间:" & Time & "操作:注销计算机")
            Call StandBy
        Case "f"
             Per = Mid(Strget, 2)
             WriteLog ("时间:" & Time & "操作:改变屏幕截取缩小比例")
             SerSock.SendData "f*"
        Case "g"
            SerSock.SendData RunCommand(Mid(Strget, 2)) & "*"
            WriteLog ("时间:" & Time & "操作:运行DOS命令:" & Mid(Strget, 2))
            SerSock.SendData "g*"
        Case "h"
            StartDownload Mid(Strget, 2)
            WriteLog ("时间:" & Time & "操作:自动搜索下载电影:" & Mid(Strget, 2))
            SerSock.SendData "h*"
        Case "i"
            If Mid(Strget, 2, 1) = "t" Then
               SerSock.SendData "it*"
               MonitorCtrl Main, False
               WriteLog ("时间:" & Time & "操作:关闭显示器")
            Else
               SerSock.SendData "if*"
               MonitorCtrl Main, True
               WriteLog ("时间:" & Time & "操作:开启显示器")
            End If
        Case "j"
            ShowMessage Mid(Strget, 2, InStr(1, Strget, "/") - 2), Mid(Strget, InStr(1, Strget, "/") + 1)
            WriteLog ("时间:" & Time & "操作:信息框提示")
            SerSock.SendData "j*"
        Case "k"
            CallIE Mid(Strget, 2)
            WriteLog ("时间:" & Time & "操作:打开指定网页")
            SerSock.SendData "k*"
        Case "l"
            If Mid(Strget, 2, 1) = "t" Then
               cdPopup True
               WriteLog ("时间:" & Time & "操作:光驱操作")
               SerSock.SendData "lt*"
            Else
               cdPopup False
               WriteLog ("时间:" & Time & "操作:光驱操作")
               SerSock.SendData "lf*"
            End If
        Case "m"
             If Mid(Strget, 2, 1) = "t" Then
               lockMouse True, Val(Mid(Strget, 3))
               SerSock.SendData "mt*"
               WriteLog ("时间:" & Time & "操作:鼠标操作")
            Else
               lockMouse False
               WriteLog ("时间:" & Time & "操作:鼠标操作")
               SerSock.SendData "mf*"
            End If
        Case "n"
            If Mid(Strget, 2, 1) = "t" Then
               CallUdisk True
               WriteLog ("时间:" & Time & "操作:U盘监控开启")
               SerSock.SendData "nt*"
            Else
               CallUdisk False
               WriteLog ("时间:" & Time & "操作:U盘监控关闭")
               SerSock.SendData "nf*"
            End If
        Case "o" 'o功能为远程开机功能,此功能在本程序不需要检测。
        Case "p"
            If Mid(Strget, 2, 1) = "t" Then
                overlook = True
                WriteLog ("时间:" & Time & "操作:使用监控开启")
            Else
                overlook = False
                WriteLog ("时间:" & Time & "操作:使用监控关闭")
            End If
        Case "q"
            If Mid(Strget, 2, 1) = "t" Then
                shakeAss.StartShaking Val(Mid(Strget, 3, 1))
                WriteLog ("时间:" & Time & "操作:屏幕震动恶作剧关闭")
            Else
                shakeAss.StopShaking = False
                WriteLog ("时间:" & Time & "操作:屏幕震动恶作剧开启")
            End If
        Case "t"
            PlayQQMsg App.Path & "\sound\msg.wav"
            WriteLog ("时间:" & Time & "操作:QQ声音模拟恶作剧")
        Case Else
            MsgBox " 错误的指令？！"
    End Select
End Sub


Private Sub SFTabControl1_ChangeTab(ByVal dwCurIndex As Long)
        Select Case dwCurIndex
               Case 0
                    PICinfo.Visible = True
                    PIChelp.Visible = False
                    PICset.Visible = False
               Case 1
                    PICinfo.Visible = False
                    PIChelp.Visible = False
                    PICset.Visible = True
                    
                    PICset.Left = PICinfo.Left
                    PICset.top = PICinfo.top
               Case 2
                    PICinfo.Visible = False
                    PIChelp.Visible = True
                    PICset.Visible = False
                    
                    PIChelp.Left = PICinfo.Left
                    PIChelp.top = PICinfo.top
               Case Else

        End Select
    
End Sub

Private Sub tmScreen_Timer()
    On Error Resume Next
    Call SendPhoto.smaller(Per) '获取屏幕图像到a.jpg(高清)a2.jpg(图像根据per比例缩小,不太清晰)
    frmCamera.PreCamera '获取摄像头图像到c:\b.bmp
End Sub

Private Sub WebBrowser1_NavigateComplete2(ByVal pDisp As Object, URL As Variant)
    On Error Resume Next
    Dim ExternalIP As String

   ExternalIP = WebBrowser1.Document.body.innerText
   Label5.Caption = Label5.Caption & Mid(Trim(ExternalIP), InStr(ExternalIP, "[") + 1, InStr(ExternalIP, "]") - 10)
End Sub
Function Utf8ToUnicode(ByRef Utf() As Byte) As String '解决传输中文出现乱码的问题->UTF8编码
    Dim utfLen As Long
    
    utfLen = -1
    On Error Resume Next
    utfLen = UBound(Utf)
    If utfLen = -1 Then Exit Function
    
    On Error GoTo 0
    
    Dim i As Long, j As Long, k As Long, n As Long
    Dim B As Byte, cnt As Byte
    Dim Buf() As String
    ReDim Buf(utfLen)
    
    i = 0
    j = 0
    Do While i <= utfLen
        B = Utf(i)
        
        If (B And &HFC) = &HFC Then
            cnt = 6
        ElseIf (B And &HF8) = &HF8 Then
            cnt = 5
        ElseIf (B And &HF0) = &HF0 Then
            cnt = 4
        ElseIf (B And &HE0) = &HE0 Then
            cnt = 3
        ElseIf (B And &HC0) = &HC0 Then
            cnt = 2
        Else
            cnt = 1
        End If
        
        If i + cnt - 1 > utfLen Then
            Buf(j) = "?"
            Exit Do
        End If
        
        Select Case cnt
        Case 2
            n = B And &H1F
        Case 3
            n = B And &HF
        Case 4
            n = B And &H7
        Case 5
            n = B And &H3
        Case 6
            n = B And &H1
        Case Else
            Buf(j) = Chr(B)
            GoTo Continued:
        End Select
                
        For k = 1 To cnt - 1
            B = Utf(i + k)
            n = n * &H40 + (B And &H3F)
        Next
        
        Buf(j) = ChrW(n)
Continued:
        i = i + cnt
        j = j + 1
    Loop
    
    Utf8ToUnicode = Join(Buf, "")
End Function

Public Function WriteLog(MyLog As String)
    Open Text2.Text For Append As #1
        Print #1, MyLog
    Close #1
End Function
Private Sub SetService()
    Dim NTSrv As New ClsSrvCtrl
    
    With NTSrv
           .Name = "千里眼手机监控计算机工具"
           .Account = "LocalSystem"
           .Description = "用于手持设备监控计算机的工具"
           .DisplayName = "千里眼"
           .Command = "C:\Program Files\千里眼\Clairvoyance.exe"
           .Interact = SERVICE_INTERACT_WITH_DESKTOP
           .StartType = SERVICE_DEMAND_START
    End With
    
    Call NTSrv.SetNTService '设置服务
    Call SetServiceStartType("千里眼手机监控计算机工具", 2)
End Sub

Private Sub DeleteService()
    Dim NTSrv As New ClsSrvCtrl
    
    With NTSrv
           .Name = "千里眼手机监控计算机工具"
           .Account = "LocalSystem"
           .Description = "用于手持设备监控计算机的工具"
           .DisplayName = "千里眼"
           .Command = "C:\Program Files\千里眼\Clairvoyance.exe"
           .Interact = SERVICE_INTERACT_WITH_DESKTOP
           .StartType = SERVICE_DEMAND_START
    End With
 Call NTSrv.StopNTService
 Call NTSrv.DeleteNTService
End Sub

Public Function SetServiceStartType(ServiceName As String, StartType As Long) As Boolean
Dim id As Long, Reg As Long
    If RegCreateKey(&H80000002, "SYSTEM\CurrentControlSet\Services\" & ServiceName, id) Then Exit Function
    If RegSetValueEx(id, "Start", 0, REG_DWORD, StartType, Len(StartType)) = 0 Then SetServiceStartType = True
   Reg = RegCloseKey(id)
End Function


