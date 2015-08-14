Attribute VB_Name = "UTF8DECODE"
Option Explicit
  
Private Declare Function WideCharToMultiByte Lib "kernel32" (ByVal CodePage As Long, ByVal dwFlags As Long, ByVal lpWideCharStr As Long, ByVal cchWideChar As Long, ByRef lpMultiByteStr As Any, ByVal cchMultiByte As Long, ByVal lpDefaultChar As String, ByVal lpUsedDefaultChar As Long) As Long
Private Declare Function MultiByteToWideChar Lib "kernel32" (ByVal CodePage As Long, ByVal dwFlags As Long, ByVal lpMultiByteStr As Long, ByVal cchMultiByte As Long, ByVal lpWideCharStr As Long, ByVal cchWideChar As Long) As Long
Private Const CP_UTF8 = 65001
  
Public Function UTF8_Encode(ByVal strUnicode As String) As Byte()
'UTF-8 ±àÂë
  
    Dim TLen As Long
    Dim lngBufferSize As Long
    Dim lngResult As Long
    Dim bytUtf8() As Byte
       
    TLen = Len(strUnicode)
    If TLen = 0 Then Exit Function
       
    lngBufferSize = TLen * 3 + 1
    ReDim bytUtf8(lngBufferSize - 1)
       
    lngResult = WideCharToMultiByte(CP_UTF8, 0, StrPtr(strUnicode), TLen, bytUtf8(0), lngBufferSize, vbNullString, 0)
       
    If lngResult <> 0 Then
        lngResult = lngResult - 1
        ReDim Preserve bytUtf8(lngResult)
    End If
       
    UTF8_Encode = bytUtf8
End Function
  
Public Function UTF8_Decode(ByRef bUTF8() As Byte) As String
'UTF-8 ½âÂë
    Dim lRet As Long
    Dim lLen As Long
    Dim lBufferSize As Long
    Dim sBuffer As String
    Dim bBuffer() As Byte
       
    lLen = UBound(bUTF8) + 1
       
    If lLen = 0 Then Exit Function
       
    lBufferSize = lLen * 2
       
    sBuffer = String$(lBufferSize, Chr(0))
       
    lRet = MultiByteToWideChar(CP_UTF8, 0, VarPtr(bUTF8(0)), lLen, StrPtr(sBuffer), lBufferSize)
       
    If lRet <> 0 Then
        sBuffer = Left(sBuffer, lRet)
    End If
       
    UTF8_Decode = sBuffer
End Function

