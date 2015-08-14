VERSION 5.00
Begin VB.Form SendPhoto 
   Caption         =   "图像准备"
   ClientHeight    =   4320
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   7020
   LinkTopic       =   "Form1"
   ScaleHeight     =   4320
   ScaleWidth      =   7020
   StartUpPosition =   3  '窗口缺省
   Begin VB.PictureBox Picture2 
      Height          =   1215
      Left            =   2160
      ScaleHeight     =   1155
      ScaleWidth      =   1875
      TabIndex        =   1
      Top             =   1080
      Width           =   1935
   End
   Begin VB.PictureBox Picture1 
      Height          =   1215
      Left            =   120
      ScaleHeight     =   1155
      ScaleWidth      =   1875
      TabIndex        =   0
      Top             =   1080
      Width           =   1935
   End
End
Attribute VB_Name = "SendPhoto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function StretchBlt Lib "gdi32.dll" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Private Const SRCCOPY As Long = &HCC0020

Public Sub smaller(percent As String)
    On Error Resume Next
    GetScrData "c:\a.jpg"
    
    Picture2.Height = Screen.Height
    Picture2.Width = Screen.Width
    
    Picture1.Height = (Val(percent) / 100) * Screen.Height
    Picture1.Width = (Val(percent) / 100) * Screen.Width
    
    Picture2.ScaleMode = 3
    Picture1.ScaleMode = 3
    Picture2.AutoRedraw = True
    Picture1.AutoRedraw = True

    Picture2.Picture = LoadPicture("c:\a.jpg")
    
    Call StretchBlt(Picture1.hdc, 0, 0, Picture1.ScaleWidth, Picture1.ScaleHeight, Picture2.hdc, 0, 0, Picture2.ScaleWidth, Picture2.ScaleHeight, SRCCOPY)
    SavePicture Picture1.Image, "c:\a2.jpg"
    
    Picture1.Cls
        
End Sub

