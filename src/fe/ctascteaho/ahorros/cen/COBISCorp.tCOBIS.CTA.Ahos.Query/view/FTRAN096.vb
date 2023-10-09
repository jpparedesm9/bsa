Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class FTran096Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
        TSBotones.Focus()
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "331")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_reten_locales_ah", True, FMLoadResString(502529) & mskCuenta.Text & " ]") Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMMapeaGrid(sqlconn, grdCheques, False)
                    grdRegistros.Focus()
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdRegistros)
                    PMLimpiaGrid(grdCheques)
                End If
            Case 1
                PMLimpiaGrid(grdRegistros)
                PMLimpiaGrid(grdCheques)
            Case 2
                Me.Close()
        End Select
    End Sub

	Private Sub FTran096_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
	End Sub

    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0       
        mskCuenta.Mask = VGMascaraCtaCte
        Me.Text = FMLoadResString(5256)
        PLTSEstado()
        mskCuenta_Leave(mskCuenta, New EventArgs)
    End Sub

	Private Sub FTran096_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
		grdRegistros.Col = 0
		grdRegistros.SelStartCol = 1
		grdRegistros.SelEndCol = grdRegistros.Cols - 1
		If grdRegistros.Row = 0 Then
			grdRegistros.SelStartRow = 1
			grdRegistros.SelEndRow = 1
		Else
			grdRegistros.SelStartRow = grdRegistros.Row
			grdRegistros.SelEndRow = grdRegistros.Row
		End If
	End Sub

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
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
            Else
                lblDescripcion(0).Text = ""
                PMLimpiaGrid(grdRegistros)
                PMLimpiaGrid(grdCheques)
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub
    Private Sub PLTSEstado()
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
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
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		
    End Sub

    Private Sub grdCheques_ClickEvent(sender As Object, e As EventArgs) Handles grdCheques.ClickEvent
        PMMarcaFilaCobisGrid(grdCheques, grdCheques.Row)
    End Sub

    Private Sub grdCheques_DblClick(sender As Object, e As EventArgs) Handles grdCheques.DblClick
        PMMarcaFilaCobisGrid(grdCheques, grdCheques.Row)
    End Sub

    Private Sub grdCheques_Enter(sender As Object, e As EventArgs) Handles grdCheques.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5255))
    End Sub

    Private Sub grdCheques_Leave(sender As Object, e As EventArgs) Handles grdCheques.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DblClick(sender As Object, e As EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5256))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


