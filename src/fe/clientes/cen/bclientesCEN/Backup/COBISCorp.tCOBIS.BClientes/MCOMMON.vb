Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
public Module MCOMMON
	Public VGResourceManager As String = "<MODULO>ResourceManager" 'COBISMigrator: Coincide con Enteprise Library
	Private flagStarted As Boolean = False
	Public Sub MCOMMONLoad()
		If Not flagStarted Then
			PLInitModule(0)
			flagStarted = True
		End If
	End Sub
    Public Const WM_SYSCOMMAND As Integer = &H112S
    Public Const SC_SCREENSAVE As Integer = &HF140
    Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer

    Public Sub PMBloquearPantalla(ByVal parHwd As Integer)
        PostMessage(parHwd, WM_SYSCOMMAND, SC_SCREENSAVE, 0)
    End Sub

    Public Function FMInitMap(ByVal parHelpLine As Control, ByVal parTrnLine As Control, ByVal parFocoL As Control, ByVal parFocoT As Control, ByVal parFocoR As Control, ByVal parFocoP As Control, ByVal parLogFile As String) As Integer
        Dim VTHelpLine As Object = DBNull.Value
        VTHelpLine = parHelpLine
        Dim VTTrnLine As Object = DBNull.Value
        VTTrnLine = parTrnLine
        Dim VTFocoL As Object = DBNull.Value
        VTFocoL = parFocoL
        Dim VTFocoT As Object = DBNull.Value
        VTFocoT = parFocoT
        Dim VTFocoR As Object = DBNull.Value
        VTFocoR = parFocoR
        Dim VTFocoP As Object = DBNull.Value
        VTFocoP = parFocoP
        FMInitMap = VGMap.FMInitMap32(VTHelpLine, VTTrnLine, VTFocoL, VTFocoT, VTFocoR, VTFocoP, parLogFile)
    End Function
End Module

