Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class FMantenimientoCBClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLOperacion As String = ""
	Dim VLResultado As Boolean = false
	Dim VLValida As Boolean = false
	Dim VLCliente As Boolean = false
	Dim VLEnte As String = ""
	Dim VLPaso As Integer = 0
    Dim VTFecha As String = ""
    Dim VLFormatoFecha As String = ""

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_5.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
		Select Case Index
			Case 0
				PLBuscar()
			Case 1
				PLSiguientes()
			Case 2
				If VLOperacion = "I" Then
					PLTransmitir()
				End If
				If VLOperacion = "U" Then
					PLModificar()
				End If
			Case 3
				If txtCorresponsal.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(508642), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCorresponsal.Focus()
					Exit Sub
				End If
				If txtEstado.Text <> "H" Then
                    COBISMessageBox.Show(FMLoadResString(508695), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					Exit Sub
				End If
                VGCorresponsal = CInt(txtCorresponsal.Text)
                FPUNTOCB.Show(Me)

			Case 4
				PLLimpiar()
			Case 5
                Me.Close()
		End Select
	End Sub

	Private Sub FMantenimientoCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" 'JSA
        PMLoadResStrings(Me)
		PMLoadResIcons(Me)
        PLInicializar() 'JSA
        'mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
        'mskFecha.DateType = PLFormatoFecha()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        mskCuentaCupo.Mask = VGMascaraCtaAho
        mskCuentaComision.Mask = VGMascaraCtaAho
        VLOperacion = "I"
        txtEstado.Text = "H"
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        mskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        txtEstado_Leave(txtEstado, New EventArgs())
        txtEstado.Enabled = False
        cmdBoton(3).Enabled = False
    End Sub

	Private Sub FMantenimientoCB_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles MyBase.MouseDown
		Dim Button As Integer = CInt(eventArgs.Button)
		If Button = 2 Then
			Button = 0
		End If
    End Sub

    Private Sub grdCorresponsales_ClickEvent(sender As Object, e As EventArgs) Handles grdCorresponsales.ClickEvent        
        PMMarcaFilaCobisGrid(grdCorresponsales, grdCorresponsales.Row)
    End Sub

	Private Sub grdCorresponsales_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCorresponsales.DblClick
		txtEstado.Enabled = True
		VLOperacion = "U"
		grdCorresponsales.Col = 1
		txtCorresponsal.Text = grdCorresponsales.CtlText
		txtCorresponsal_Leave(txtCorresponsal, New EventArgs())
		grdCorresponsales.Col = 2
		txtCodRed.Text = grdCorresponsales.CtlText
		grdCorresponsales.Col = 4
		txtNumContrato.Text = grdCorresponsales.CtlText
		grdCorresponsales.Col = 5
		mskFecha.Text = grdCorresponsales.CtlText
		grdCorresponsales.Col = 6
		Dim VLCuentaCupo As String = grdCorresponsales.CtlText
		mskCuentaCupo.Text = FMMascara(VLCuentaCupo, VGMascaraCtaAho)
		grdCorresponsales.Col = 7
		Dim VLCuentaComision As String = grdCorresponsales.CtlText
		mskCuentaComision.Text = FMMascara(VLCuentaComision, VGMascaraCtaAho)
		grdCorresponsales.Col = 8
		txtEstado.Text = Strings.Mid(grdCorresponsales.CtlText, 1, 1)
		txtEstado_Leave(txtEstado, New EventArgs())
	End Sub

	Private Sub mskCuentaComision_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentaComision.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508670))
	End Sub

	Private Sub mskCuentaComision_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentaComision.Leave
		If mskCuentaComision.ClipText <> "" Then
			PLValida(mskCuentaComision.ClipText, "N")
			If Not VLResultado Then
				mskCuentaComision.Mask = ""
				mskCuentaComision.Text = ""
				mskCuentaComision.Mask = VGMascaraCtaAho
				mskCuentaComision.Focus()
				Exit Sub
			End If
		End If
	End Sub

	Private Sub mskCuentaCupo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentaCupo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508668))
	End Sub

	Private Sub mskCuentaCupo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentaCupo.Leave
		If mskCuentaCupo.ClipText <> "" Then
			PLValida(mskCuentaCupo.ClipText, "S")
			If Not VLResultado Then
				mskCuentaCupo.Mask = ""
				mskCuentaCupo.Text = ""
				mskCuentaCupo.Mask = VGMascaraCtaAho
				mskCuentaCupo.Focus()
			End If
		End If
	End Sub

	Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508577) & "  (" & VGFormatoFecha & ")")
	End Sub

	Private Sub mskFecha_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskFecha.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
			KeyAscii = 0
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
        Dim VTValido As Integer = 0
		If mskFecha.ClipText <> "" Then
			VTValido = FMVerFormato(mskFecha.Text, VGFormatoFecha)
			If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
				mskFecha.Mask = ""
				mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFecha_Pref)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
				mskFecha.Focus()
				Exit Sub
            End If
            If CDate(mskFecha.Text) < CDate(VGFechaProceso) Then
                COBISMessageBox.Show(FMLoadResString(508584), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Mask = ""
                mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
                mskFecha.Focus()
                mskFecha.Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
            End If
        End If
	End Sub

	Private Sub txtCodRed_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCodRed.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508499))
	End Sub

	Private Sub txtCodRed_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCodRed.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCorresponsal_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCorresponsal.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508510))
		txtCorresponsal.SelectionStart = 0
		txtCorresponsal.SelectionLength = Strings.Len(txtCorresponsal.Text)
	End Sub

	Private Sub txtCorresponsal_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCorresponsal.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            PLLimpiar()
            txtCorresponsal.Enabled = True
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1052")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S1")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "2")
            PMHelpG("cobis", "sp_clasoser", 3, 1)
            PMBuscarG(1, "@t_trn", "1052", SQLINT2)
            PMBuscarG(2, "@i_operacion", "S1", SQLVARCHAR)
            PMBuscarG(3, "@i_modo", "2", SQLINT2)
            PMSigteG(1, "@i_siguiente", 1, SQLINT4)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_clasoser", True, FMLoadResString(508808)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                VLPaso = True
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtCorresponsal.Text = Temporales(1)
                    VGCorresponsal = CInt(Temporales(1))
                    lblCorresponsal.Text = Temporales(2)
                    VLEnte = Temporales(3)
                    PLDatos_Cliente()
                    VLPaso = True
                Else
                    txtCorresponsal.Text = ""
                    txtCorresponsal.Focus()
                    lblCorresponsal.Text = ""
                End If
            Else
                PMChequea(sqlconn)
                VLPaso = False
                PLLimpiar()
                txtCorresponsal.Focus()
            End If
        End If
	End Sub

	Private Sub txtCorresponsal_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCorresponsal.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
			KeyAscii = 0
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

 

	Private Sub txtCorresponsal_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCorresponsal.Leave
		Dim VTArregloCab(3) As String
		txtCorresponsal.Enabled = True
        If Not VLPaso Then
            If txtCorresponsal.Text.Trim() <> "" Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1052")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S1")
                If VLOperacion = "U" Then
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, CStr(5))
                Else
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, CStr(4))
                End If
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCorresponsal.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_clasoser", True, FMLoadResString(508808)) Then
                    FMMapeaArreglo(sqlconn, VTArregloCab)
                    PMChequea(sqlconn)
                    lblCorresponsal.Text = VTArregloCab(2)
                    VGCorresponsal = CInt(txtCorresponsal.Text)
                    VLEnte = VTArregloCab(3)
                    PLDatos_Cliente()
                    cmdBoton(3).Enabled = True
                Else
                    PMChequea(sqlconn)
                    VLPaso = False
                    txtCorresponsal.Text = ""
                    txtCorresponsal.Focus()
                    lblCorresponsal.Text = ""
                    PLLimpiar()
                End If
            End If
        End If
    End Sub

	Private Sub txtCorresponsal_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtCorresponsal.MouseDown
		Dim Button As Integer = CInt(eventArgs.Button)
		If Button = 2 Then
			txtCorresponsal.Enabled = False
			txtCorresponsal.Enabled = True
		End If
	End Sub

	Private Sub txtCorresponsal_MouseUp(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtCorresponsal.MouseUp
		Dim Button As Integer = CInt(eventArgs.Button)
		If Button = 2 Then
			Exit Sub
		End If
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtEstado_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtEstado.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		txtEstado.Text = txtEstado.Text.ToUpper()
	End Sub

	Private Sub txtEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2454))
	End Sub

	Private Sub txtEstado_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtEstado.KeyDown
		Dim Keycode As Integer = eventArgs.KeyCode
		If Keycode = VGTeclaAyuda Then
			txtEstado.Text = ""
			lblEstado.Text = ""
			PMLimpiaG(grid_valores.gr_SQL)
			PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
			PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "re_estado_servicio")
			PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(508804)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtEstado.Text = Temporales(1)
                    lblEstado.Text = Temporales(2)
                Else
                    txtEstado.Text = ""
                    txtEstado.Focus()
                    lblEstado.Text = ""
                End If
            Else
                PMChequea(sqlconn)
            End If
		End If
	End Sub

	Sub PLDatos_Cliente()
		Dim VTArreglo(500) As String
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1218")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
		PMPasoValores(sqlconn, "@i_compania", 0, SQLINT4, VLEnte)
		If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_compania_cons", True, "") Then
            FMMapeaArreglo(sqlconn, VTArreglo)
			PMChequea(sqlconn)
			lblTipoDoc.Text = VTArreglo(2)
			If lblTipoDoc.Text = "N" Then
				lblDescTipoDoc.Visible = True
			End If
			PMValida_TipoDoc(lblTipoDoc.Text, "C")
			lblDescTipoDoc.Text = VGMTipoDoc(1)
			lblNumDoc.Text = VTArreglo(3)
			lblRegimen.Text = VTArreglo(55)
			lblDescRegimen.Text = VTArreglo(56)
        Else
            PMChequea(sqlconn)
		End If
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1227")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
		PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, VLEnte)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, "") Then
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            lblDepartamento.Text = VTArreglo(8)
            lblDescDepto.Text = VTArreglo(9)
            lblCiudad.Text = VTArreglo(3)
            lblDescCiudad.Text = VTArreglo(4)
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Sub PLLimpiar()
		lblCiudad.Text = ""
		lblCorresponsal.Text = ""
		lblDepartamento.Text = ""
		lblDescCiudad.Text = ""
		lblDescDepto.Text = ""
		lblDescRegimen.Text = ""
		lblDescTipoDoc.Text = ""
		lblEstado.Text = ""
		lblNumDoc.Text = ""
		lblNumDocDig.Text = ""
		lblRegimen.Text = ""
		lblTipoDoc.Text = ""
		txtCodRed.Text = ""
		txtCorresponsal.Text = ""
		txtEstado.Text = ""
		txtNumContrato.Text = ""
		mskCuentaComision.Mask = ""
		mskCuentaCupo.Mask = ""
        mskCuentaComision.Text = ""
		mskCuentaCupo.Text = ""
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        mskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
		mskCuentaCupo.Mask = VGMascaraCtaAho
		mskCuentaComision.Mask = VGMascaraCtaAho
        mskFecha.Connection = VGMap
        PMLimpiaG(grdCorresponsales)
        VLOperacion = "I"
        VLPaso = False
        txtEstado.Text = "H"
        txtEstado_Leave(txtEstado, New EventArgs())
        VLPaso = True
		txtEstado.Enabled = False
        cmdBoton(3).Enabled = False
        PLTSEstado()
	End Sub

	Private Sub txtEstado_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtEstado.Leave
		If Not VLPaso Then
			If txtEstado.Text <> "" Then
				PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
				PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_estado_servicio")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtEstado.Text)
				PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
				PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True,
                                   FMLoadResString(502692) & " [" & txtEstado.Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblEstado)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    VLPaso = True
                    txtEstado.Text = ""
                    lblEstado.Text = ""
                    txtEstado.Focus()
                End If
			Else
				lblEstado.Text = ""
			End If
		End If
	End Sub

	Sub PLBuscar()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "396")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
		If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
            PMMapeaGrid(sqlconn, grdCorresponsales, False)
            PMMapeaTextoGrid(grdCorresponsales)
            PMAnchoColumnasGrid(grdCorresponsales)
			PMChequea(sqlconn)
            cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdCorresponsales.Tag)) = 20
            cmdBoton(3).Enabled = True
		Else
			PMChequea(sqlconn)
		End If
        PLTSEstado()
	End Sub

	Sub PLSiguientes()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "396")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
		grdCorresponsales.Col = 1
		grdCorresponsales.Row = grdCorresponsales.Rows - 1
		PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLINT4, grdCorresponsales.CtlText)
		If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
            PMMapeaGrid(sqlconn, grdCorresponsales, False)
            PMMapeaTextoGrid(grdCorresponsales)
            PMAnchoColumnasGrid(grdCorresponsales)
			PMChequea(sqlconn)
			cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdCorresponsales.Tag)) = 20
		Else
			PMChequea(sqlconn)
		End If
        cmdBoton(3).Enabled = True
        PLTSEstado()
	End Sub

	Sub PLTransmitir()
		PLValidarCampos()
		If VLValida Then
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "396")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VLOperacion)
			PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLINT4, CStr(VGCorresponsal))
			PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLVARCHAR, txtCodRed.Text)
			PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtEstado.Text)
			PMPasoValores(sqlconn, "@i_num_contrato", 0, SQLVARCHAR, txtNumContrato.Text)
			PMPasoValores(sqlconn, "@i_cta_cupo", 0, SQLVARCHAR, mskCuentaCupo.ClipText)
			PMPasoValores(sqlconn, "@i_cta_comision", 0, SQLVARCHAR, mskCuentaComision.ClipText)
			VTFecha = FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_ven", 0, SQLDATETIME, VTFecha)
			If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
				PMChequea(sqlconn)
				PLLimpiar()
				PLBuscar()
				cmdBoton(3).Enabled = True
            Else
                PMChequea(sqlconn)
			End If
        End If
        PLTSEstado()
	End Sub

	Sub PLModificar()
		PLValidarCampos()
		If VLValida Then
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "396")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VLOperacion)
			PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLINT4, txtCorresponsal.Text)
			PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLVARCHAR, txtCodRed.Text)
			PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtEstado.Text)
			PMPasoValores(sqlconn, "@i_num_contrato", 0, SQLVARCHAR, txtNumContrato.Text)
			PMPasoValores(sqlconn, "@i_cta_cupo", 0, SQLVARCHAR, mskCuentaCupo.ClipText)
			PMPasoValores(sqlconn, "@i_cta_comision", 0, SQLVARCHAR, mskCuentaComision.ClipText)
			VTFecha = FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_ven", 0, SQLDATETIME, VTFecha)
			If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
				PMChequea(sqlconn)
				PLLimpiar()
				PLBuscar()
			Else
				PMChequea(sqlconn)
			End If
		End If
	End Sub

	Sub PLValida(ByRef Cuenta As String, ByRef CB As String)
		If txtCorresponsal.Text <> "" Then
			If FMChequeaCtaAho(Cuenta) Then
				PMPasoValores(sqlconn, "@i_ctaint", 0, SQLINT2, "0")
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
				PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Cuenta)
				PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
				PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "N")
				PMPasoValores(sqlconn, "@i_trn", 0, SQLINT2, Convert.ToString(Me.Tag))
				PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, CB)
				PMPasoValores(sqlconn, "@o_estado", 1, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(508811)) Then
                    PMChequea(sqlconn)
                    VLResultado = True
                Else
                    VLResultado = False
                    PMChequea(sqlconn)
                End If
			Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				VLResultado = False
				Exit Sub
			End If
		Else
            COBISMessageBox.Show(FMLoadResString(508445), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			VLResultado = False
		End If
	End Sub

	Sub PLValidarCampos()
		If txtCorresponsal.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508598), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCorresponsal.Focus()
			cmdBoton(3).Enabled = False
			VLValida = False
			Exit Sub
		End If
		If txtCodRed.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508599), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCodRed.Focus()
			cmdBoton(3).Enabled = False
			VLValida = False
			Exit Sub
		End If
		If txtNumContrato.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508602), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtNumContrato.Focus()
			cmdBoton(3).Enabled = False
			VLValida = False
			Exit Sub
		End If
		If mskCuentaCupo.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508604), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskCuentaCupo.Focus()
			cmdBoton(3).Enabled = False
			VLValida = False
			Exit Sub
		End If
		If txtEstado.Text = "" And lblEstado.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508600), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtEstado.Focus()
			cmdBoton(3).Enabled = False
			VLValida = False
			Exit Sub
		End If
		If txtEstado.Text = "N" And VLOperacion = "I" Then
            COBISMessageBox.Show(FMLoadResString(508532), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtEstado.Text = ""
			VLValida = False
			lblEstado.Text = ""
			txtEstado.Focus()
			cmdBoton(3).Enabled = False
			Exit Sub
		End If
		If mskFecha.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508601), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskFecha.Focus()
			cmdBoton(3).Enabled = False
			VLValida = False
			Exit Sub
        End If
        If CDate(mskFecha.Text) < CDate(VGFecha) Then
            COBISMessageBox.Show(FMLoadResString(508618), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFecha.Focus()
            cmdBoton(3).Enabled = False
            VLValida = False
            Exit Sub
        End If
        VLValida = True
        PLTSEstado()
	End Sub

	Private Sub txtNumContrato_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtNumContrato.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508666))
	End Sub

	Private Sub txtNumContrato_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtNumContrato.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible
        TSBTransmitir.Enabled = _cmdBoton_2.Enabled
        TSBTransmitir.Visible = _cmdBoton_2.Visible
        TSBPuntos.Enabled = _cmdBoton_3.Enabled
        TSBPuntos.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_5.Enabled
        TSBSalir.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBPuntos_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPuntos.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdCorresponsales_Load(sender As Object, e As EventArgs) Handles grdCorresponsales.Load

    End Sub

    Private Sub txtCorresponsal_TextChanged(sender As Object, e As EventArgs) Handles txtCorresponsal.TextChanged
        VLPaso = False
    End Sub
End Class


