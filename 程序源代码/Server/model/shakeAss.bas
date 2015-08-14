Attribute VB_Name = "shakeAss"
Option Explicit
'API
Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function MoveWindow Lib "user32" (ByVal hwnd As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal bRepaint As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function GetForegroundWindow Lib "user32" () As Long
'矩形类型
Private Type RECT
    Left As Long
    top As Long
    Right As Long
    Bottom As Long
End Type
Public StopShaking As Boolean

'开始震动
Public Sub StartShaking(shake As Integer) '震动强度
    Dim hwnd As Long
    Dim rc As RECT
    Dim Cwidth As Integer, Cheight As Integer, Cleft As Integer, Ctop As Integer
    Dim i As Integer
    StopShaking = True
    Do
    hwnd = GetForegroundWindow()
    GetWindowRect hwnd, rc
    
    Cwidth = rc.Right - rc.Left
    Cheight = rc.Bottom - rc.top
    Cleft = rc.Left
    Ctop = rc.top
    
    For i = 0 To 10
        MoveWindow hwnd, Cleft, Ctop - shake, Cwidth, Cheight, 1: Sleep 40: DoEvents
        MoveWindow hwnd, Cleft - shake, Ctop, Cwidth, Cheight, 1: Sleep 40: DoEvents
        MoveWindow hwnd, Cleft, Ctop + shake, Cwidth, Cheight, 1: Sleep 40: DoEvents
        MoveWindow hwnd, Cleft + shake, Ctop, Cwidth, Cheight, 1: Sleep 40: DoEvents
    Next i
    
    If StopShaking = False Then Exit Sub
    Loop
End Sub
