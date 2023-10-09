Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FTran367Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_4.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				If mskCuenta.ClipText <> "" Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "367")
					PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
					PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_inactivacion_ah", True, FMLoadResString(509248)) Then
                        PMChequea(sqlconn)
                        cmdBoton(0).Enabled = False
                        cmdBoton(4).Enabled = True
                        COBISMessageBox.Show(FMLoadResString(501333), FMLoadResString(502011), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    Else
                        PMChequea(sqlconn)
                    End If
				Else
                    COBISMessageBox.Show(FMLoadResString(501497), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
				End If
			Case 1
				lblDescripcion(0).Text = ""
				mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
				PMLimpiaGrid(grdPropietarios)
				grdPropietarios.Tag = ""
				cmdBoton(0).Enabled = True
				cmdBoton(4).Enabled = False
				mskCuenta.Focus()
			Case 2
				Me.Close()
			Case 4
				PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "298")
				PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2250)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMChequea(sqlconn)
                Else
                    PMLimpiaGrid(grdPropietarios)
                    PMChequea(sqlconn)
                End If
		End Select
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Enter, _cmdBoton_1.Enter, _cmdBoton_0.Enter, _cmdBoton_4.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500934))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500047))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500370))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500371))
        End Select
    End Sub

	Private Sub FTran367_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBPropietarios.Enabled = _cmdBoton_4.Enabled
        TSBPropietarios.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBPropietarios_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPropietarios.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Public Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaAho
    End Sub

	Private Sub FTran367_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
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
                        cmdBoton(4).Enabled = True
                        PMLimpiaGrid(grdPropietarios)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(0).Text = ""
                        PMLimpiaGrid(grdPropietarios)
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        cmdBoton(4).Enabled = False
                        If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
                        Exit Sub
                    End If
				Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					cmdBoton_Click(cmdBoton(1), New EventArgs())
					cmdBoton(4).Enabled = False
					Exit Sub
				End If
			End If
		Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
		End Try
    End Sub

End Class


