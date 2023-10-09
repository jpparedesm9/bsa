Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FTran490Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Boolean = false
	Dim VLTipoCuenta As String = ""
	Private isInitializingComponent As Boolean = false

	Private Sub cmbTipo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		VLPaso = False
		PLLimpiar()
	End Sub

	Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
		Dim aux1 As String = ""
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
		If mskCuenta.ClipText <> "" Then
			aux1 = mskCuenta.Mask
			mskCuenta.Mask = ""
			mskCuenta.Text = ""
			mskCuenta.Mask = aux1
		End If
	End Sub

	Private Sub cmbTipo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles cmbTipo.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If KeyAscii = Strings.AscW("+") Then
			SendKeys.Send("{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If KeyAscii = Strings.AscW("-") Then
			SendKeys.Send("+{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte
        Else
            mskCuenta.Mask = VGMascaraCtaAho
        End If
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				PLEliminar()
			Case 1
				PLTransmitir()
			Case 2
				PLLimpiar()
			Case 3
				Me.Close()
			Case 4
				PLBuscar()
		End Select
	End Sub

	Private Sub cmdBoton_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _cmdBoton_4.KeyPress, _cmdBoton_0.KeyPress, _cmdBoton_3.KeyPress, _cmdBoton_2.KeyPress, _cmdBoton_1.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If KeyAscii = Strings.AscW("+") Then
			SendKeys.Send("{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If KeyAscii = Strings.AscW("-") Then
			SendKeys.Send("+{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub FTran490_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
	End Sub

    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        mskCuenta.Mask = VGMascaraCtaCte
        cmbTipo.Items.Insert(0, "CUENTA CORRIENTE")
        cmbTipo.Items.Insert(1, "CUENTA DE AHORRO")
        cmbTipo.SelectedIndex = 0
        cmbTipo.Enabled = True
        cmdBoton(4).Enabled = True
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_4.Enabled
        TSBBuscar.Visible = _cmdBoton_4.Visible
        TSBEliminar.Enabled = _cmdBoton_0.Enabled
        TSBEliminar.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_1.Enabled
        TSBTransmitir.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub


	Private Sub FTran490_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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

	Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
		If grdRegistros.Rows <= 2 Then
			grdRegistros.Row = 1
			grdRegistros.Col = 1
			If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500665), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				Exit Sub
			End If
		End If
		PMMarcarRegistro()
	End Sub

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskCuenta.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If KeyAscii = Strings.AscW("+") Then
			SendKeys.Send("{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If KeyAscii = Strings.AscW("-") Then
			SendKeys.Send("+{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" And Not VLPaso Then
                If cmbTipo.Text = "CUENTA CORRIENTE" Then
                    If FMChequeaCtaCte(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2330) & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                            VLPaso = True
                            PMLimpiaGrid(grdRegistros)
                            grdRegistros.Col = 0
                            grdRegistros.Picture = picVisto(1).Image
                            txtCampo(0).Focus()
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(2).Text = ""
                            mskCuenta.Focus()
                            PMLimpiaGrid(grdRegistros)
                            grdRegistros.Col = 0
                            grdRegistros.Picture = picVisto(1).Image
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(2).Text = ""
                        mskCuenta.Focus()
                        PMLimpiaGrid(grdRegistros)
                        grdRegistros.Col = 0
                        grdRegistros.Picture = picVisto(1).Image
                        Exit Sub
                    End If
                Else
                    If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2330) & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                            VLPaso = True
                            PMLimpiaGrid(grdRegistros)
                            grdRegistros.Col = 0
                            grdRegistros.Picture = picVisto(1).Image
                            txtCampo(0).Focus()
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(2).Text = ""
                            mskCuenta.Focus()
                            PMLimpiaGrid(grdRegistros)
                            grdRegistros.Col = 0
                            grdRegistros.Picture = picVisto(1).Image
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(2).Text = ""
                        mskCuenta.Focus()
                        PMLimpiaGrid(grdRegistros)
                        grdRegistros.Col = 0
                        grdRegistros.Picture = picVisto(1).Image
                        Exit Sub
                    End If
                End If
            End If
            If mskCuenta.ClipText = "" Then
                lblDescripcion(2).Text = ""
                PMLimpiaGrid(grdRegistros)
                grdRegistros.Col = 0
                grdRegistros.Picture = picVisto(1).Image
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
	End Sub

	Private Sub PLBuscar()
		If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500666), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskCuenta.Focus()
			Exit Sub
		End If
		If cmbTipo.Text = "CUENTA CORRIENTE" Then
			VLTipoCuenta = "3"
		Else
			VLTipoCuenta = "4"
		End If
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "490")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
		PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLTipoCuenta)
		PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_domic_pagos", True, FMLoadResString(509249)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            PMLimpiaGrid(grdRegistros)
            grdRegistros.Col = 0
            grdRegistros.Picture = picVisto(1).Image
            txtCampo(0).Focus()
            Exit Sub
        End If
	End Sub

	Private Sub PLEliminar()
		If cmbTipo.Text = "CUENTA CORRIENTE" Then
			VLTipoCuenta = "3"
		Else
			VLTipoCuenta = "4"
		End If
		For i As Integer = 1 To (grdRegistros.Rows - 1)
			grdRegistros.Row = i
			grdRegistros.Col = 0
            If grdRegistros.Picture Is Nothing Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "490")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLTipoCuenta)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "E")
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_tipo_pago", 0, SQLVARCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_domic_pagos", True, FMLoadResString(509250)) Then
                    PMChequea(sqlconn)
                    PLBuscar()
                Else
                    PMChequea(sqlconn)
                End If
            End If
		Next i
	End Sub

	Private Sub PLLimpiar()
		PMLimpiaGrid(grdRegistros)
		mskCuenta.Enabled = True
		mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
		lblDescripcion(2).Text = ""
		txtCampo(0).Text = ""
		txtCampo(1).Text = ""
		lblDescripcion(0).Text = ""
		cmbTipo.Focus()
		mskCuenta.Enabled = True
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub PLTransmitir()
		If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500666), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskCuenta.Focus()
			Exit Sub
		End If
		If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500667), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(0).Focus()
			Exit Sub
		End If
		If cmbTipo.Text = "CUENTA CORRIENTE" Then
			VLTipoCuenta = "3"
		Else
			VLTipoCuenta = "4"
		End If
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "490")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
		PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLTipoCuenta)
		PMPasoValores(sqlconn, "@i_tipo_pago", 0, SQLVARCHAR, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_comentario", 0, SQLVARCHAR, txtCampo(1).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_domic_pagos", True, FMLoadResString(509249)) Then
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
		txtCampo(0).Text = ""
		lblDescripcion(0).Text = ""
		txtCampo(1).Text = ""
		txtCampo(0).Focus()
	End Sub

	Private Sub PMMarcarRegistro()
		grdRegistros.Col = 0
        If grdRegistros.Picture Is Nothing Then
            grdRegistros.CtlText = Conversion.Str(grdRegistros.Row)
            grdRegistros.Picture = picVisto(0).Image
        Else
            grdRegistros.CtlText = Conversion.Str(grdRegistros.Row)
            grdRegistros.Picture = picVisto(1).Image
        End If
	End Sub

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		VLPaso = False
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500668))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500669))

                txtCampo(Index).SelectionStart = 0
                txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
        End Select
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
		Dim Keycode As Integer = eventArgs.KeyCode
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If Keycode = VGTeclaAyuda Then
					VLPaso = True
					txtCampo(0).Text = ""
					PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_tipo_pago")
					PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(509251) & "[" & txtCampo(0).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                        If txtCampo(0).Text <> "" Then
                            VLPaso = True
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
				End If
		End Select
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If KeyAscii = Strings.AscW("+") Then
			SendKeys.Send("{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If KeyAscii = Strings.AscW("-") Then
			SendKeys.Send("+{TAB}")
			KeyAscii = 0
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		Select Case Index
			Case 0
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
			Case 1
				KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_0.Leave

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If Not VLPaso And txtCampo(0).Text <> "" Then
					If txtCampo(0).Text <> "" Then
						PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_tipo_pago")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(0).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(509251) & "[" & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCampo(0).Focus()
                        End If
					Else
						lblDescripcion(0).Text = ""
					End If
				End If
		End Select
	End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
			Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
		End If
    End Sub

    Private Sub cmbTipo_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbTipo.SelectedIndexChanged

    End Sub

    Private Sub mskCuenta_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles mskCuenta.MaskInputRejected

    End Sub

    Private Sub grdRegistros_Load(sender As Object, e As EventArgs) Handles grdRegistros.Load

    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500661))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


