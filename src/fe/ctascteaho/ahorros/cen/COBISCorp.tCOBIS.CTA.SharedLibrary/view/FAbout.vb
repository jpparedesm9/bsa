Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Diagnostics
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FAcercaClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Const CL_REG_KEY_SYS_INFO_LOC As String = "SOFTWARE\Microsoft\Shared Tools Location"
	Const CL_REG_VAL_SYS_INFO_LOC As String = "MSINFO"
	Const CL_REG_KEY_SYS_INFO As String = "SOFTWARE\Microsoft\Shared Tools\MSINFO"
	Const CL_REG_VAL_SYS_INFO As String = "PATH"

	Private Sub cmdSysInfo_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSysInfo.Click
		FLInformacionSistema()
	End Sub

	Private Sub cmdOK_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdOK.Click
		Me.Close()
	End Sub

    Public Sub PLInicializar()
        Dim VTEmpresa As String = string.Empty
        Dim  VTPais As String = string.Empty
        Dim  VTLinea As String = string.Empty
        Dim VTpos As Integer = 0
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        Dim VTDirSystem As String = New String(Strings.Chr(32), 255)
        VTDirSystem = FMGetSystemDirectory()
        Dim VTLong As Integer = VTDirSystem.Length
        If VTLong <= 0 Then
            COBISMessageBox.Show("No se pudo encontrar el directorio del sistema.", My.Application.Info.Title, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        Dim VTMapIni As String = Strings.Mid(VTDirSystem, 1, VTLong) & "\MAP.INI"
        Dim VTFNum As Integer = FLAbrirArchivo(VTMapIni)
        If VTFNum > 0 Then
            VTLinea = FileSystem.LineInput(VTFNum)
            VTpos = (VTLinea.IndexOf(ChrW(9)) + 1)
            If VTpos = 0 Then
                COBISMessageBox.Show("<Map.ini> erróneo. Solicite autorización", My.Application.Info.Title, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            VTLinea = Strings.Mid(VTLinea, 1, VTpos - 1)
            VTpos = (VTLinea.IndexOf("-"c) + 1)
            If VTpos = 0 Then
                COBISMessageBox.Show("<Map.ini> erróneo. Solicite autorización", My.Application.Info.Title, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            VTEmpresa = Strings.Mid(VTLinea, 1, VTpos - 1).Trim()
            VTPais = Strings.Mid(VTLinea, VTpos + 1).Trim()
            FileSystem.FileClose(VTFNum)
        Else
            COBISMessageBox.Show("Archivo " & VTMapIni & " no encontrado.  Solicite autorización.", My.Application.Info.Title, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        Me.Text = "Acerca de " & My.Application.Info.Title
        lblVersion.Text = "Version: " & My.Application.Info.Version.Major & "." & CStr(My.Application.Info.Version.Minor) & "." & CStr(My.Application.Info.Version.Revision) & " - " & My.Application.Info.CompanyName
        lblTitle.Text = My.Application.Info.Title
        lblBank.Text = VTEmpresa
        lblCountry.Text = VTPais
    End Sub

    Private Sub FAcerca_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

	Public Sub FLInformacionSistema()
		Try 
			Dim VTPathInfo As String = ""
			If FMGetKeyValue(CG_HKEY_LOCAL_MACHINE, CL_REG_KEY_SYS_INFO, CL_REG_VAL_SYS_INFO, VTPathInfo) Then
			ElseIf FMGetKeyValue(CG_HKEY_LOCAL_MACHINE, CL_REG_KEY_SYS_INFO_LOC, CL_REG_VAL_SYS_INFO_LOC, VTPathInfo) Then 
				If FileSystem.Dir(VTPathInfo & "\MSINFO32.EXE", FileAttribute.Normal) <> "" Then
					VTPathInfo = VTPathInfo & "\MSINFO32.EXE"
				Else
					Throw New Exception()
				End If
			Else
				Throw New Exception()
			End If
			Dim startInfo As ProcessStartInfo = New ProcessStartInfo(VTPathInfo)
			startInfo.WindowStyle = ProcessWindowStyle.Normal
			Process.Start(startInfo)
		Catch 
			COBISMessageBox.Show("Información del sistema no disponible por el momento", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK)
		End Try
	End Sub

	Function FLAbrirArchivo(ByRef Filename As String) As Integer
		Try 
			Dim VTFNum As Integer = 0
			VTFNum = FileSystem.FreeFile()
			FileSystem.FileOpen(VTFNum, Filename, OpenMode.Input)
			Return VTFNum
		Catch 
			Return 0
		End Try
	End Function
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
			Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
		End If
    End Sub
End Class


