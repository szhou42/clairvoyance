VERSION 5.00
Begin VB.Form frmCamera 
   Caption         =   "摄像头图像获取"
   ClientHeight    =   8730
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6150
   LinkTopic       =   "Form1"
   ScaleHeight     =   8730
   ScaleWidth      =   6150
   StartUpPosition =   3  '窗口缺省
   Begin VB.PictureBox Picture1 
      Height          =   8175
      Left            =   240
      ScaleHeight     =   8115
      ScaleWidth      =   5595
      TabIndex        =   0
      Top             =   240
      Width           =   5655
   End
End
Attribute VB_Name = "frmCamera"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public Sub PreCamera()
    '建立捕获窗口
    On Error Resume Next
    Preview_Handle = capCreateCaptureWindow("Video", WS_CHILD + WS_VISIBLE, 0, 0, 320, 500, Picture1.hwnd, 1)
    
    '建立捕获窗口到捕获设备的连接
    
    SendMessage Preview_Handle, WM_CAP_DRIVER_CONNECT, 0, 0
    '设置捕获的帧频率为30毫秒一帧
    
    SendMessage Preview_Handle, WM_CAP_SET_PREVIEW, 1, 0
    
    capEditCopy Preview_Handle
    Picture1.Picture = Clipboard.GetData
    Call SavePicture(Picture1.Picture, "c:\b.bmp ")
    Unload Me
End Sub


Private Sub Form_Unload(Cancel As Integer)
On Error Resume Next
    '断开到捕获设备的连接
    SendMessage Preview_Handle, WM_CAP_DRIVER_DISCONNECT, 0, 0
End Sub
