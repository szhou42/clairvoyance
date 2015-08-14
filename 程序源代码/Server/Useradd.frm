VERSION 5.00
Object = "{A483937A-33EC-48F0-AFA3-7068C738ACFA}#2.0#0"; "Abutton.ocx"
Object = "{EF977422-E047-42A7-A004-1C0695C81FCF}#1.0#0"; "NiceForm.ocx"
Begin VB.Form Useradd 
   BackColor       =   &H00F3EFE3&
   Caption         =   "添加用户"
   ClientHeight    =   1650
   ClientLeft      =   9525
   ClientTop       =   6585
   ClientWidth     =   3825
   Icon            =   "Useradd.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1650
   ScaleWidth      =   3825
   Begin NiceFormControl.NiceForm NiceForm1 
      Left            =   3840
      Top             =   240
      _ExtentX        =   847
      _ExtentY        =   847
   End
   Begin VB.PictureBox PICadduser 
      BackColor       =   &H00F3EFE3&
      BorderStyle     =   0  'None
      Height          =   1215
      Left            =   0
      ScaleHeight     =   1215
      ScaleWidth      =   3735
      TabIndex        =   0
      Top             =   120
      Width           =   3735
      Begin AniButton.AButton add 
         Height          =   975
         Left            =   2880
         TabIndex        =   7
         Top             =   120
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   1720
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
         MICON           =   "Useradd.frx":038A
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
         PATHICON        =   ""
         PICPNG          =   "Useradd.frx":03A6
         GCOLOR1         =   0
         GCOLOR2         =   0
         GRADDIR         =   0
      End
      Begin VB.TextBox password2 
         Appearance      =   0  'Flat
         Height          =   270
         Left            =   1080
         TabIndex        =   6
         Top             =   840
         Width           =   1695
      End
      Begin VB.TextBox password 
         Appearance      =   0  'Flat
         Height          =   270
         Left            =   1080
         TabIndex        =   5
         Top             =   480
         Width           =   1695
      End
      Begin VB.TextBox username 
         Appearance      =   0  'Flat
         Height          =   270
         Left            =   1080
         TabIndex        =   4
         Top             =   120
         Width           =   1695
      End
      Begin VB.Label Label1 
         BackColor       =   &H00F3EFE3&
         Caption         =   "密码确认:"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   840
         Width           =   975
      End
      Begin VB.Label Label4 
         BackColor       =   &H00F3EFE3&
         Caption         =   "密码:"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   480
         Width           =   615
      End
      Begin VB.Label Label3 
         BackColor       =   &H00F3EFE3&
         Caption         =   "用户名:"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   120
         Width           =   735
      End
   End
End
Attribute VB_Name = "Useradd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub add_Click()
    If (username <> "" And password <> "" And password2 <> "") And (password = password2) Then
        Main.UserList.ListItems.add , , username, , 1
        Me.Hide
    Else
        ShowMessage "千里眼提示:", "请准确填写好信息"
    End If
End Sub

Private Sub Form_Load()
    NiceForm1.LoadSkin NiceForm1.MnuStyleIdx
End Sub
