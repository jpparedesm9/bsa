Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FTran204Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_3.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "204")
				PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
				PMPasoValores(sqlconn, "@i_aut", 0, SQLVARCHAR, VGLogin)
				PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtCampo.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_reapertura_ah", True, FMLoadResString(509247)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
			Case 1
				mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
				lblDescripcion(0).Text = ""
				PMLimpiaGrid(grdPropietarios)
				cmdBoton(3).Enabled = False
				cmdBoton(0).Enabled = True
				mskCuenta.Focus()
				lblDescripcion(1).Text = ""
				lblDescripcion(2).Text = ""
				lblDescripcion(4).Text = ""
				lblDescripcion(7).Text = ""
				txtCampo.Text = ""
			Case 2
				Me.Close()
			Case 3
				PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "298")
				PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2250)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdPropietarios)
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Enter, _cmdBoton_1.Enter, _cmdBoton_0.Enter, _cmdBoton_3.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500934))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500047))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500370))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500371))
        End Select
    End Sub

	Private Sub FTran204_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
		PMLoadResStrings(Me)
		PMLoadResIcons(Me)
        PLInicializar()
	End Sub

    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        mskCuenta.Mask = VGMascaraCtaAho
        PLTSEstado()
    End Sub

	Private Sub FTran204_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub grdPropietarios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Click
		grdPropietarios.Col = 0
		grdPropietarios.SelStartCol = 1
		grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
		If grdPropietarios.Row = 0 Then
			grdPropietarios.SelStartRow = 1
			grdPropietarios.SelEndRow = 1
		Else
			grdPropietarios.SelStartRow = grdPropietarios.Row
			grdPropietarios.SelEndRow = grdPropietarios.Row
		End If
	End Sub

	Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500934))
	End Sub

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501862))
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
		Try 
			If mskCuenta.ClipText <> "" Then
				If FMChequeaCtaAho(mskCuenta.ClipText) Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
					PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
					PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
					PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2544) & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = True
                        PMLimpiaGrid(grdPropietarios)
                    Else
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
				Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					cmdBoton_Click(cmdBoton(1), New EventArgs())
					Exit Sub
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "204")
				PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
				PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
				PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_reapertura_ah", True, FMLoadResString(508782)) Then
                    Dim VTArreglo(10) As String
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMChequea(sqlconn)
                    lblDescripcion(2).Text = VTArreglo(1)
                    lblDescripcion(1).Text = VTArreglo(2)
                    lblDescripcion(4).Text = VTArreglo(3)
                    lblDescripcion(7).Text = VTArreglo(4)
                Else
                    PMChequea(sqlconn)
                End If
			End If
		Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
		End Try
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501109))
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCampo.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		KeyAscii = FMVAlidaTipoDato("U", KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLTSEstado()
        TSBPropietarios.Visible = _cmdBoton_3.Visible
        TSBPropietarios.Enabled = _cmdBoton_3.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub TSBPropietarios_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPropietarios.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBlimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBlimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub
End Class


