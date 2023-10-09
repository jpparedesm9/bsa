Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class FTran408Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLTipoR As String = ""
	Dim VLTotal As String = ""

	Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
	End Sub

	Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        If cmbTipo.Text = FMLoadResString(502554) Then
            mskCuenta.Mask = VGMascaraCtaCte
        Else
            mskCuenta.Mask = VGMascaraCtaAho
        End If
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTModo As Boolean = false
		Select Case Index
			Case 0
				If mskCuenta.ClipText <> "" Then
					VTModo = False
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "408")
                    If cmbTipo.Text = FMLoadResString(502554) Then
                        PMPasoValores(sqlconn, "@i_prod", 0, SQLCHAR, "CTE")
                    Else
                        PMPasoValores(sqlconn, "@i_prod", 0, SQLCHAR, "AHO")
                    End If
					PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
					PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
					PMPasoValores(sqlconn, "@i_tiporem", 0, SQLCHAR, VLTipoR)
					PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT2, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_chequexcta", True, FMLoadResString(508821)) Then
                        PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                        PMAnchoColumnasGrid(grdRegistros)
                        PMMapeaVariable(sqlconn, VLTotal)
                        PMChequea(sqlconn)
                        If grdRegistros.Rows <= 2 Then
                            grdRegistros.Row = 1
                            grdRegistros.Col = 1
                            If grdRegistros.CtlText = "" Then
                                lblTotal.Text = ""
                                Exit Sub
                            End If
                        End If
                        cmbTipo.Enabled = False
                        mskCuenta.Enabled = False
                        grdRegistros.ColAlignment(10) = 1
                        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20 Then
                            cmbTipo.Enabled = False
                            mskCuenta.Enabled = False
                            cmdBoton(4).Enabled = True
                        Else
                            cmdBoton(4).Enabled = False
                            If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                                lblTotal.Text = VLTotal
                            End If
                        End If
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar()
                    End If
				Else
                    If cmbTipo.Text = FMLoadResString(502554) Then
                        COBISMessageBox.Show(FMLoadResString(508543), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Else
                        COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    End If
					mskCuenta.Focus()
				End If
			Case 1
				PLLimpiar()
			Case 2
				Me.Close()
			Case 4
				If mskCuenta.ClipText <> "" Then
					VTModo = True
					grdRegistros.Row = grdRegistros.Rows - 1
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "408")
					PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
					PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
					PMPasoValores(sqlconn, "@i_tiporem", 0, SQLCHAR, VLTipoR)
					grdRegistros.Col = 9
					PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT2, grdRegistros.CtlText)
					grdRegistros.Col = 6
					PMPasoValores(sqlconn, "@i_carta", 0, SQLINT4, grdRegistros.CtlText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_chequexcta", True, FMLoadResString(508833)) Then
                        PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                        PMAnchoColumnasGrid(grdRegistros)
                        PMChequea(sqlconn)
                        grdRegistros.ColAlignment(10) = 1
                        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20 Then
                            cmdBoton(4).Enabled = True
                        Else
                            cmdBoton(4).Enabled = False
                            mskCuenta.Enabled = True
                            'cmbTipo.Enabled = True
                            VTModo = False
                            lblTotal.Text = VLTotal
                        End If
                    Else
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = False
                    End If
				Else
                    COBISMessageBox.Show(FMLoadResString(508543), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
				End If
        End Select
        PLTSEstado()
	End Sub

	Private Sub FTran408_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
	End Sub

    Private Sub PLTSEstado()
        TSBSiguiente.Enabled = _cmdBoton_4.Enabled
        TSBSiguiente.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
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
        mskCuenta.Mask = VGMascaraCtaCte
        cmbTipo.Items.Insert(0, FMLoadResString(502554)) 'CUENTAS CORRIENTES
        cmbTipo.Items.Insert(1, FMLoadResString(502555)) 'CUENTAS AHORROS
        cmbTipo.SelectedIndex = 1 'SELECCIONA CUENTAS AHORROS
        cmbTipo.Enabled = False 'PARA QUE NO SE SELECCIONE CTE (APLICA SI NO ESTA INSTALADO)
        optTipoR(0).Checked = True
        VLTipoR = "T"
    End Sub


	Private Sub FTran408_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500333))
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
		Try 
			If mskCuenta.ClipText <> "" Then
                If cmbTipo.Text = FMLoadResString(502554) Then
                    If mskCuenta.ClipText <> "9999999999" Then
                        If FMChequeaCtaCte(mskCuenta.ClipText) Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2274) & mskCuenta.Text & "]") Then
                                PMMapeaObjeto(sqlconn, lblDescripcion(0))
                                PMChequea(sqlconn)
                            Else
                                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                                lblDescripcion(0).Text = System.String.Empty
                                mskCuenta.Focus()
                                PMChequea(sqlconn)
                                Exit Sub
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501391), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(0).Text = System.String.Empty
                            mskCuenta.Focus()
                            Exit Sub
                        End If
                    Else
                        lblDescripcion(0).Text = FMLoadResString(502423)
                    End If
                Else
                    If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(0).Text = System.String.Empty
                            mskCuenta.Focus()
                            PMChequea(sqlconn)
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(0).Text = System.String.Empty
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                End If
				FrameTipoR.Enabled = True
                'optTipoR(0).Focus()
                'optTipoR_ClickHelper(0, True)
                'cmdBoton(0).Focus()
            Else
                lblTotal.Text = System.String.Empty
                lblDescripcion(0).Text = System.String.Empty
            End If
		Catch exc As System.Exception
			NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
		End Try
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub optTipoR_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optTipoR_3.CheckedChanged, _optTipoR_2.CheckedChanged, _optTipoR_1.CheckedChanged, _optTipoR_0.CheckedChanged
		If eventSender.Checked Then
			If isInitializingComponent Then
				Exit Sub
			End If
			Dim Index As Integer = Array.IndexOf(optTipoR, eventSender)
			Dim Value As Integer = optTipoR(Index).Checked
			optTipoR_ClickHelper(Index, Value)
		End If
	End Sub

	Private Sub optTipoR_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
		Select Case Index
			Case 0
				VLTipoR = "T"
				optTipoR(1).Checked = False
				optTipoR(2).Checked = False
				optTipoR(3).Checked = False
			Case 1
				VLTipoR = "P"
				optTipoR(0).Checked = False
				optTipoR(2).Checked = False
				optTipoR(3).Checked = False
			Case 2
				VLTipoR = "C"
				optTipoR(0).Checked = False
				optTipoR(1).Checked = False
				optTipoR(3).Checked = False
			Case 3
				VLTipoR = "D"
				optTipoR(0).Checked = False
				optTipoR(1).Checked = False
				optTipoR(2).Checked = False
		End Select
		PMLimpiaGrid(grdRegistros)
        lblTotal.Text = System.String.Empty
		cmdBoton(4).Enabled = False
	End Sub

    Private Sub PLLimpiar()
        'PMLimpiaGrid(grdRegistros)
        optTipoR(0).Checked = True
        optTipoR_ClickHelper(0, True)
        'cmbTipo.Enabled = True
        mskCuenta.Enabled = True
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        lblDescripcion(0).Text = System.String.Empty
        'lblTotal.Text = System.String.Empty
        FrameTipoR.Enabled = False
        mskCuenta.Enabled = True
        mskCuenta.Focus()
        'cmdBoton(4).Enabled = False
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub
End Class


