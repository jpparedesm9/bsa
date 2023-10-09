Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FCatalogoClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
		ListBoxHelper.SetSelectedIndex(lstCatalogo, lstCatalogo.Items.Count - 1)
		Dim VTUb1 As Integer = (lstCatalogo.Text.IndexOf(Strings.Chr(9).ToString()) + 1)
		Select Case VGOperacion
			Case "sp_filial"
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
				PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
				PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_filial", True, FMLoadResString(1568)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
			Case "sp_oficina"
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
				PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
				PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
				PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(1570)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
			Case "sp_moneda"
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
				PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
				PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_moneda", True, FMLoadResString(1569)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
			Case "sp_tipo_chequera"
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
				PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "35")
				PMPasoValores(sqlconn, "@i_tchq", 0, SQLVARCHAR, Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tipo_chequera", True, FMLoadResString(1567)) Then
                    PMMapeaListaH(sqlconn, Me.lstCatalogo, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
		End Select
	End Sub


	Private Sub FCatalogo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles MyBase.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim VTUb1 As Integer = 0
		Dim  VTUb2 As Integer = 0
		If KeyAscii = 27 Then
			VGACatalogo.Codigo = ""
			VGACatalogo.Descripcion = ""
			Me.Close()
		Else
			If KeyAscii = 13 Then
				If Me.lstCatalogo.Items.Count <> 0 Then
					VTUb1 = (lstCatalogo.Text.IndexOf(Strings.Chr(9).ToString()) + 1)
					VGACatalogo.Codigo = Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1)
					VTUb2 = Strings.InStr(VTUb1 + 1, Me.lstCatalogo.Text, Strings.Chr(9).ToString())
					If VTUb2 <> 0 Then
						VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, VTUb2 - VTUb1 - 1)
					Else
						VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, Strings.Len(Me.lstCatalogo.Text) - VTUb1 + 1)
					End If
				Else
					VGACatalogo.Codigo = ""
					VGACatalogo.Descripcion = ""
				End If
				Me.Close()
			End If
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub lstCatalogo_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles lstCatalogo.DoubleClick
		Dim VTUb1 As Integer = 0
		Dim  VTUb2 As Integer = 0
		If Me.lstCatalogo.Items.Count <> 0 Then
			VTUb1 = (lstCatalogo.Text.IndexOf(Strings.Chr(9).ToString()) + 1)
			VGACatalogo.Codigo = Strings.Mid(Me.lstCatalogo.Text, 1, VTUb1 - 1)
			VTUb2 = Strings.InStr(VTUb1 + 1, Me.lstCatalogo.Text, Strings.Chr(9).ToString())
			If VTUb2 <> 0 Then
				VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, VTUb2 - VTUb1 - 1)
			Else
				VGACatalogo.Descripcion = Strings.Mid(Me.lstCatalogo.Text, VTUb1 + 1, Strings.Len(Me.lstCatalogo.Text) - VTUb1 + 1)
			End If
		Else
			VGACatalogo.Codigo = ""
			VGACatalogo.Descripcion = ""
		End If
		Me.Close()
	End Sub

    Private Sub FCatalogo_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        VGACatalogo.Codigo = ""
        VGACatalogo.Descripcion = ""
        If VGOperacion <> "sp_filial" And VGOperacion <> "sp_oficina" And VGOperacion <> "sp_moneda" And VGOperacion <> "sp_tipo_chequera" Then
            cmdSiguientes.Enabled = False
            cmdSiguientes.Visible = False
        Else
            cmdSiguientes.Enabled = True
            cmdSiguientes.Visible = True
        End If
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBSiguientes.Enabled = cmdSiguientes.Enabled
        TSBSiguientes.Visible = cmdSiguientes.Visible
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If TSBSiguientes.Enabled Then cmdSiguientes_Click(TSBSiguientes, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
			cmdSiguientes.Enabled = Not (lstCatalogo.Items.Count < 20)
    End Sub

    Private Sub TSBEscoger_Click(sender As Object, e As EventArgs) Handles TSBEscoger.Click
        lstCatalogo_DoubleClick(lstCatalogo, New EventArgs)
    End Sub

    Private Sub TSBSalir_Click(sender As Object, e As EventArgs) Handles TSBSalir.Click
        VGACatalogo.Codigo = ""
        VGACatalogo.Descripcion = ""
        Me.Close()
    End Sub

    Private Sub lstCatalogo_Enter(sender As Object, e As EventArgs) Handles lstCatalogo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1847))
    End Sub

    Private Sub lstCatalogo_Leave(sender As Object, e As EventArgs) Handles lstCatalogo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


