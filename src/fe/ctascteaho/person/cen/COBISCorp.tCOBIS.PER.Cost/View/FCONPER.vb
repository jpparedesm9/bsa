Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FConsultaPerClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0

	Private Sub cmbCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1779))
	End Sub

	Private Sub cmbCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbCuenta.Leave
		If cmbCuenta.Text <> "" Then
			If cmbCuenta.Text = "CTA CORRIENTE" Then
				mskCuenta.Mask = VGMascaraCtaCte
			Else
				mskCuenta.Mask = VGMascaraCtaAho
			End If
		End If
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VLValor As String = ""
        Dim VLLongitud As Integer
        Dim VLPosDeci As Integer
        TSBotones.Focus()
		Select Case Index
			Case 0
				If mskCuenta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1225), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1271), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4073")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
				If cmbCuenta.Text = "CTA AHORROS" Then
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
				Else
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
				End If
				PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "1")
				Dim VTValores(4) As String
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(2521)) Then
                    FMMapeaArreglo(sqlconn, VTValores)
                    PMChequea(sqlconn)
                    If VTValores(1) <> "" Then
                        VLValor = VTValores(2)
                        lblDescripcion(4).Text = VTValores(1)
                        If VLValor.IndexOf("."c) >= 0 Then
                            VLValor = Strings.Mid(VLValor, 1, VLValor.IndexOf("."c) + 1) & (Strings.Mid(VLValor, (VLValor.IndexOf("."c) + 1) + 1, 2))
                            VLLongitud = Len(VLValor)
                            VLPosDeci = InStr(VLValor, ".") 'Si el punto(.) es el separador decimal
                            If VLPosDeci = VLLongitud - 1 Then
                                VLValor = VLValor + "0" 'Se agrega 0 decimal a la derecha
                                VLPosDeci = 0
                            End If
                        End If
                        lblDescripcion(3).Text = VLValor
                    End If
                Else
                    PMChequea(sqlconn)
                    lblDescripcion(4).Text = ""
                    lblDescripcion(3).Text = ""
                End If
			Case 1
				If cmbCuenta.Text = "CTA CORRIENTE" Then
					mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
				Else
					mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
				End If
				cmbCuenta.Items.Clear()
				cmbCuenta.Items.Insert(0, "CTA AHORROS")
				cmbCuenta.Items.Insert(1, "CTA CORRIENTE")
				cmbCuenta.SelectedIndex = 0
				txtCampo(0).Text = ""
				txtCampo(1).Text = ""
				For i As Integer = 0 To 4
					lblDescripcion(i).Text = ""
				Next i
				lblDescripcion(6).Text = ""
				lblDescripcion(7).Text = ""
			Case 2
                Me.Close()
        End Select
	End Sub

	Private Sub FConsultaPer_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		cmbCuenta.Items.Clear()
		cmbCuenta.Items.Insert(0, "CTA AHORROS")
        '  cmbCuenta.Items.Insert(1, "CTA CORRIENTE")
		cmbCuenta.SelectedIndex = 0
		mskCuenta.Mask = VGMascaraCtaAho
        PMObjetoSeguridad(cmdBoton(0))
        PLTSEstado()
        cmbCuenta.Focus()
	End Sub

	Private Sub FConsultaPer_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        If cmbCuenta.Text <> "" Then
            If cmbCuenta.Text = "CTA CORRIENTE" Then
                mskCuenta.Mask = VGMascaraCtaCte  
            Else
                mskCuenta.Mask = VGMascaraCtaAho
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1529))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VTR1 As Integer = 0
        Dim VTArreglo() As String
		Try 
			If cmbCuenta.Text = "" Then
                COBISMessageBox.Show(FMLoadResString(1289), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				cmbCuenta.Focus()
				Exit Sub
			End If
			If mskCuenta.ClipText <> "" Then
				If cmbCuenta.Text = "CTA CORRIENTE" Then
					If FMChequeaCtaCte(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
						PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1550)) Then
                            ReDim VTArreglo(10)
                            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            If VTR1 <> 0 Then
                                lblDescripcion(0).Text = VTArreglo(1)
                                lblDescripcion(7).Text = VTArreglo(2)
                                lblDescripcion(6).Text = VTArreglo(3)
                            Else
                                COBISMessageBox.Show(FMLoadResString(1323), FMLoadResString(1473), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(0).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(6).Text = ""
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1278), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        lblDescripcion(0).Text = ""
                        lblDescripcion(7).Text = ""
                        lblDescripcion(6).Text = ""
						mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
						mskCuenta.Focus()
						VLPaso = True
						Exit Sub
					End If
				Else
					If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
						PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1550)) Then
                            ReDim VTArreglo(10)
                            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            If VTR1 <> 0 Then
                                lblDescripcion(0).Text = VTArreglo(1)
                                lblDescripcion(6).Text = VTArreglo(3)
                                lblDescripcion(7).Text = VTArreglo(2)
                            Else
                                COBISMessageBox.Show(FMLoadResString(1323), FMLoadResString(1473), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(0).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(6).Text = ""
                            txtCampo(0).Text = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(1).Text = ""
                            lblDescripcion(2).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(3).Text = ""
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1279), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        lblDescripcion(0).Text = ""
                        lblDescripcion(7).Text = ""
                        lblDescripcion(6).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(2).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(3).Text = ""
						mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
						mskCuenta.Focus()
						VLPaso = True
						Exit Sub
					End If
				End If
            End If
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
		Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1711))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1692))
        End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_help_serv_pe"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", True, FMLoadResString(1558)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGACatalogo.Codigo <> "" Then
                            txtCampo(0).Text = VGACatalogo.Codigo
                            lblDescripcion(1).Text = VGACatalogo.Descripcion
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(1).Focus()
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                Case 1
                    If txtCampo(0).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1272), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    VGOperacion = "sp_valor_contratado"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1557)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGACatalogo.Codigo <> "" Then
                            txtCampo(1).Text = VGACatalogo.Codigo
                            lblDescripcion(2).Text = VGACatalogo.Descripcion
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(1).Text = ""
                        lblDescripcion(2).Text = ""
                    End If
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
			Case 1
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
					KeyAscii = 0
				Else
					KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
				End If
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_0.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", True, FMLoadResString(1558)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Text = ""
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(1).Text = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(0).Text = ""
                            txtCampo(0).Focus()
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                        txtCampo(1).Text = ""
                        lblDescripcion(2).Text = ""
                    End If
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        If txtCampo(0).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1272), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                        If txtCampo(1).Text <> "" Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "I")
                            PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(0).Text)
                            PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, txtCampo(1).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1557)) Then
                                PMMapeaObjeto(sqlconn, lblDescripcion(2))
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                                lblDescripcion(2).Text = ""
                                txtCampo(1).Text = ""
                                txtCampo(1).Focus()
                            End If
                        Else
                            lblDescripcion(2).Text = ""
                        End If
                    Else
                        lblDescripcion(2).Text = ""
                    End If
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_1.MouseDown, _txtCampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				My.Computer.Clipboard.Clear()
        End Select
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

    Private Sub PLTSEstado()
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBTransmitir.Visible = _cmdBoton_0.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Enabled
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

End Class


