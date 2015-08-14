VERSION 5.00
Begin VB.Form Lockme 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   4155
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6210
   LinkTopic       =   "Form1"
   ScaleHeight     =   4155
   ScaleWidth      =   6210
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer2 
      Interval        =   1000
      Left            =   120
      Top             =   0
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   270
      Left            =   2520
      TabIndex        =   0
      Top             =   840
      Width           =   1335
   End
   Begin VB.Timer Timer1 
      Interval        =   10
      Left            =   5640
      Top             =   3720
   End
   Begin VB.Image Image2 
      Height          =   540
      Left            =   2400
      Picture         =   "Lockme.frx":0000
      Stretch         =   -1  'True
      Top             =   1200
      Width           =   1500
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "输 入 密 码"
      Height          =   255
      Left            =   2640
      TabIndex        =   1
      Top             =   600
      Width           =   1095
   End
   Begin VB.Image Image1 
      Height          =   4335
      Left            =   0
      Picture         =   "Lockme.frx":072C
      Stretch         =   -1  'True
      Top             =   0
      Width           =   6255
   End
End
Attribute VB_Name = "Lockme"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long

Const HWND_TOPMOST = -1 '顶置
Const HWND_NOTOPMOST = -2 '不顶置
Dim trueOrFalse As Boolean

Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Form_Load()
    Label1.Left = Screen.Width / 2 - Screen.Width / 20
    Text1.Left = Screen.Width / 2 - Screen.Width / 20
    Image2.Left = Screen.Width / 2 - Screen.Width / 20
    
    Label1.Top = Screen.Height / 4 - Label1.Height - 230
    Text1.Top = Screen.Height / 4 - Text1.Height - 20
    Image2.Top = Screen.Height / 4
End Sub

Private Sub Form_Resize()
    Image1.Top = 0
    Image1.Left = 0
    Image1.Height = Me.ScaleHeight
    Image1.Width = Me.ScaleWidth
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then Call Image2_Click
End Sub

Private Sub Timer1_Timer()
SetWindowPos Me.hwnd, HWND_TOPMOST, Me.Left / Screen.TwipsPerPixelX, Me.Top \ Screen.TwipsPerPixelY, Me.Width \ Screen.TwipsPerPixelX, Me.Height \ Screen.TwipsPerPixelY, 0
End Sub

Private Sub Image2_Click()
Dim i As Integer, j As Integer
If Text1.Text = Base.myKey Then
'    ucAniGIF1.LoadAnimatedGIF_File App.Path & "\image\QQ表情\正确\Yeah.gif"
    DoEvents
        PlaySound "sound/unlock.wav", 0, &H1
    Sleep (1300)
    DoEvents
    Unload Me
    Main.Show
'Else
'    ucAniGIF1.LoadAnimatedGIF_File App.Path & "\image\QQ表情\错误\摇手指.gif"
End If
End Sub
