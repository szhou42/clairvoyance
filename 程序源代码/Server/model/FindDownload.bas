Attribute VB_Name = "FindDownload"
'ģ��ʹ�÷���,��ʹ��ģ���ں���ǰ�Ƚ�������һЩ���������ĸ�ֵ(�����ڴ��ڼ��ص�ʱ��͸�ֵ�˵�)
'finish = False
'getEd2k = False
'tempFor = True
'Ȼ��ֻҪ����StartDownload�����������ؼ���!
'StartDownload����ʹ�÷���
'ԭ��:StartDownload(movieName As String) As String
'����ֻ��һ��
'movieName:Ҫ�������صĵ�Ӱ����
Option Explicit
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
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public HtmlSource As String, ed2kHtmlSource As String
Public MyHref(1 To 10) As String
Public MyEd2kHref As String
Public finish As Boolean
Public getEd2k As Boolean 'ֻҪ�õ�һ��ed2k���ӾͲ�Ҫ������
Public tempFor As Boolean



Public Function GetUrlStr(URL As String) As String '����ʱ URL ����һ��Ҫ�� http:// ǰ׺
      Dim hOpen                 As Long
      Dim hOpenUrl              As Long
      Dim sUrl                  As String
      Dim bDoLoop               As Boolean
      Dim bRet                  As Boolean
      Dim sReadBuffer           As String * 2048
      Dim lNumberOfBytesRead    As Long
      Dim sBuffer               As String
      sUrl = URL
      hOpen = InternetOpen(scUserAgent, INTERNET_OPEN_TYPE_PRECONFIG, vbNullString, vbNullString, 0)
      hOpenUrl = InternetOpenUrl(hOpen, sUrl, vbNullString, 0, INTERNET_FLAG_RELOAD, 0)
      bDoLoop = True
      While bDoLoop
          sReadBuffer = vbNullString
          bRet = InternetReadFile(hOpenUrl, sReadBuffer, Len(sReadBuffer), lNumberOfBytesRead)
          sBuffer = sBuffer & Left$(sReadBuffer, lNumberOfBytesRead)
          If Not CBool(lNumberOfBytesRead) Then bDoLoop = False
      Wend
      GetUrlStr = sBuffer
      If hOpenUrl <> 0 Then InternetCloseHandle (hOpenUrl)
      If hOpen <> 0 Then InternetCloseHandle (hOpen)
End Function



Public Sub FindBaidu(movieName As String)
    Dim i As Integer, p1 As Long, p2 As Long, p3 As Long, hrefSize As Integer
    Dim htmlHref As String
    HtmlSource = GetUrlStr("http://www.baidu.com/s?wd=" & movieName & " " & "ed2k")
            '''''''''''''''''''�Ұٶ���������������''''''''''''''''
        For i = 1 To 10
    
        If i = 1 Then p1 = InStr(HtmlSource, "��ѯ����")
        
        p1 = InStr(p1, HtmlSource, "<table") + 8
        p1 = InStr(p1, HtmlSource, "href=")
        p2 = InStr(p1, HtmlSource, "target")
        
        hrefSize = (p2 - 2) - (p1 + 6) + 1
        htmlHref = Mid(HtmlSource, p1 + 6, hrefSize)
        MyHref(i) = Replace(htmlHref, Chr(34), "")
        Next i
End Sub




Public Function FindDownLink() As String
Dim p1 As Long, p2 As Long
Dim ed2kSize As Integer
Dim i As Integer
 '''''''''''''''''''''��ÿ���������ҳ����ED2K����''''''''''''''''
         For i = 1 To 10
                If getEd2k = False Then
                    On Error Resume Next
                    ed2kHtmlSource = GetUrlStr(MyHref(i))
                    p1 = InStr(1, ed2kHtmlSource, "ed2k://|file")
                    p2 = InStr(p1, ed2kHtmlSource, "|/")
                    ed2kSize = (p2 + 2) - p1
                    MyEd2kHref = Mid(ed2kHtmlSource, p1, ed2kSize)
                    If Left(MyEd2kHref, 4) = "ed2k" Then getEd2k = True
                    FindDownLink = ReplaceHTML(MyEd2kHref)
                Else
                    Exit For
                End If
         Next i
         getEd2k = False
End Function



Public Sub SetThunderAgentTask(ByVal pURL As String, Optional ByVal pFileName As String = "", Optional ByVal pPath As String = "", Optional ByVal pComments As String = "", Optional ByVal pReferURL As String = "", Optional ByVal nStartMode As Integer = 1, Optional ByVal nOnlyFromOrigin As Integer = 0, Optional ByVal nOriginThreadCount As Integer = -1)
    Dim ThunderAgent As Object '����һ���������
    Dim h1 As Long, i As Long
    Set ThunderAgent = CreateObject("ThunderAgent.Agent") '���ò�����Ѷ�׵��ö���
    ThunderAgent.AddTask pURL, pFileName, pPath, pComments, pReferURL, 1, _
            nOnlyFromOrigin, nOriginThreadCount '�����������
    ThunderAgent.CommitTasks2 (1) '�ύ���������첽��ʽ
    Set ThunderAgent = Nothing '���ٶ���
    
    For i = 1 To 100
    h1 = FindWindow("#32770", "�½�����")
    
    If h1 <> 0 Then
    Exit For
    End If
    
    Sleep (1000)
    Next i
    AppActivate "�½�����"
    SendKeys "{Enter}"
End Sub

Private Function ReplaceHTML(HTML)
    Dim Regex As New RegExp
    Regex.Global = True
    Regex.IgnoreCase = True
    Regex.Pattern = "<!--[\s\S]*?-->|<style.*?>[\s\S]*?</style>|<script.*?>[\s\S]*?</script>|<[\s\S]+?>|\s+"
    ReplaceHTML = Regex.Replace(HTML, "")
End Function



'���պϲ�����StartDownload


Public Function StartDownload(movieName As String)
    finish = False
    getEd2k = False
    tempFor = True
    Call FindBaidu(movieName)
    SetThunderAgentTask FindDownLink(), "d:\movie.avi"
End Function
