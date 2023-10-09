Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class FGesCtaCBClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLOperacion As String = ""
    Dim VLValida As Boolean = False
    Dim VLFormatoFecha As String = ""

	Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdBuscar.Click
		PLBuscar()
	End Sub

	Private Sub cmdExcel_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdExcel_1.Click
		PLExcel()
	End Sub

	Private Sub cmdLimpiar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdLimpiar_2.Click
        PLLimpiar()
        txtCB.Focus()
	End Sub

	Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdSalir_3.Click
		Me.Close()
	End Sub

	Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
		PLSiguiente()
	End Sub

    Private Sub PLInicializar()
        PLLimpiar()
        VLOperacion = "I"
    End Sub

	Private Sub FGesCtaCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha(0).Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha(0).DateType = PLFormatoFecha()
        mskFecha(0).Connection = VGMap
        mskFecha(0).Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)

        VLFecha = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha(1).Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha(1).DateType = PLFormatoFecha()
        mskFecha(1).Connection = VGMap
        mskFecha(1).Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)

        cmdSiguientes.Enabled = False
        PLTSEstado()
        txtCB.Focus()
	End Sub

	Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskFecha_1.Enter, _mskFecha_0.Enter
		Dim Index As Integer = Array.IndexOf(mskFecha, eventSender)
		If Index = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508574) & " (" & VGFormatoFecha & ")")
		Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508571) & " (" & VGFormatoFecha & ")")
		End If
	End Sub

	Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskFecha_1.Leave, _mskFecha_0.Leave
		Dim Index As Integer = Array.IndexOf(mskFecha, eventSender)
		Dim VTDias As Integer = 0
		Dim VTValido As Integer = 0
		Try 
			Select Case Index
				Case 0, 1
					If mskFecha(Index).ClipText <> "" Then
						VTValido = FMVerFormato(mskFecha(Index).Text, VGFormatoFecha)
						If Not VTValido Then
                            COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
							mskFecha(Index).Mask = ""
							mskFecha(Index).Text = ""
                            mskFecha(Index).Mask = FMMascaraFecha(VGFormatoFecha)
                            mskFecha(Index).DateType = PLFormatoFecha()
                            mskFecha(Index).Connection = VGMap
							mskFecha(Index).Focus()
							Exit Sub
						End If
                    Else

                        For i As Integer = 0 To 1
                            mskFecha(i).Mask = ""
                            mskFecha(i).Text = ""
                            mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
                            mskFecha(i).DateType = PLFormatoFecha()
                            mskFecha(i).Connection = VGMap
                            mskFecha(i).Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                        Next i
                    End If
                    If CDate(mskFecha(0).Text) > CDate(VGFechaProceso) Then
                        COBISMessageBox.Show(FMLoadResString(5254), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskFecha(0).Mask = ""
                        mskFecha(0).Text = ""
                        mskFecha(0).Mask = FMMascaraFecha(VGFormatoFecha)
                        mskFecha(0).DateType = PLFormatoFecha()
                        mskFecha(0).Connection = VGMap
                        mskFecha(0).Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                        mskFecha(0).Focus()
                        Exit Sub
                    End If
                    If CDate(mskFecha(1).Text) > CDate(VGFechaProceso) Then
                        COBISMessageBox.Show(FMLoadResString(508587), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskFecha(1).Mask = ""
                        mskFecha(1).Text = ""
                        mskFecha(1).Mask = FMMascaraFecha(VGFormatoFecha)
                        mskFecha(1).DateType = PLFormatoFecha()
                        mskFecha(1).Connection = VGMap
                        mskFecha(1).Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                        mskFecha(1).Focus()
                        Exit Sub
                    End If
                    If mskFecha(0).ClipText <> "" And mskFecha(1).ClipText <> "" Then
                        VTDias = FMDateDiff("d", mskFecha(0).Text, mskFecha(1).Text, VGFormatoFecha)
                        If VTDias < 0 Then
                            COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            mskFecha(1).Mask = ""
                            mskFecha(1).Text = ""
                            mskFecha(1).Mask = FMMascaraFecha(VGFormatoFecha)
                            mskFecha(1).DateType = PLFormatoFecha()
                            mskFecha(1).Connection = VGMap
                            mskFecha(1).Focus()
                            mskFecha(1).Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
                            Exit Sub
                        End If
                    End If

            End Select
		Catch exc As System.Exception
			NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
		End Try
	End Sub

	Private Sub mskHora_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskHora_1.Enter, _mskHora_0.Enter
		Dim Index As Integer = Array.IndexOf(mskHora, eventSender)
		If Index = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508596))
		Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508594))
		End If
		mskHora(Index).SelectionStart = 0
		mskHora(Index).SelectionLength = Strings.Len(mskHora(Index).Text)
	End Sub

	Private Sub mskHora_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskHora_1.Leave, _mskHora_0.Leave
		If mskHora(0).ClipText <> "" And mskHora(1).ClipText <> "" Then
			If mskHora(0).ClipText > mskHora(1).ClipText Then
                COBISMessageBox.Show(FMLoadResString(508597), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
				mskHora(1).Mask = ""
				mskHora(1).Text = ""
				mskHora(1).Mask = "##:##:##"
				mskHora(1).Focus()
				Exit Sub
			End If
		End If
		If mskHora(0).ClipText > "23:59:59" And mskHora(0).ClipText <> "" Then
            COBISMessageBox.Show(FMLoadResString(508546), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
			mskHora(0).Mask = ""
			mskHora(0).Text = ""
			mskHora(0).Mask = "##:##:##"
			mskHora(0).Focus()
			Exit Sub
		End If
		If mskHora(1).ClipText > "23:59:59" And mskHora(1).ClipText <> "" Then
            COBISMessageBox.Show(FMLoadResString(508547), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
			mskHora(1).Text = ""
			mskHora(1).Mask = ""
			mskHora(1).Mask = "##:##:##"
			mskHora(1).Focus()
			Exit Sub
		End If
		If mskHora(0).ClipText <> "" And mskHora(1).ClipText <> "" Then
			If mskHora(0).ClipText = mskHora(1).ClipText Then
                COBISMessageBox.Show(FMLoadResString(508545), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
				mskHora(1).Mask = ""
				mskHora(1).Text = ""
				mskHora(1).Mask = "##:##:##"
				mskHora(1).Focus()
				Exit Sub
			End If
		End If
	End Sub

	Private Sub txtCB_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCB.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508511))
        VLPaso = True
        txtCB.SelectionStart = 0
		txtCB.SelectionLength = Strings.Len(txtCB.Text)
	End Sub

	Private Sub txtCB_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCB.KeyDown
		Dim Keycode As Integer = eventArgs.KeyCode
		If Keycode = VGTeclaAyuda Then
			txtCB.Enabled = True
			VLPaso = True
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1051")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S1")
			PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "2")
			PMPasoValores(sqlconn, "@i_siguiente", 0, SQLINT2, "0")
			PMHelpG("cobis", "sp_clasoser", 3, 1)
			PMBuscarG(1, "@t_trn", "1051", SQLINT2)
			PMBuscarG(2, "@i_operacion", "S1", SQLCHAR)
			PMBuscarG(3, "@i_modo", "2", SQLINT1)
			PMSigteG(1, "@i_siguiente", 1, SQLINT4)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_clasoser", True, FMLoadResString(508802)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtCB.Text = Temporales(1)
                    lblCB.Text = Temporales(2)
                    VLPaso = False
                Else
                    VLPaso = False
                    txtCB_Leave(txtCB, New EventArgs())
                End If
            Else
                PMChequea(sqlconn)
            End If
            grid_valores.Dispose()

		End If
	End Sub

	Private Sub txtCB_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCB.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
			KeyAscii = 0
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCB_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCB.Leave
        Dim VTArreglo(3) As String
        If Not VLPaso Then
            If txtCB.Text.Trim() <> "" Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1052")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S1")
                If VLOperacion = "U" Then
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, CStr(5))
                Else
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, CStr(4))
                End If
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCB.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_clasoser", True, FMLoadResString(508808)) Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMChequea(sqlconn)
                    lblCB.Text = VTArreglo(2)
                    'Busca la cuenta 
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "703")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLINT4, txtCB.Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_devolucion_val_recaudo", True, FMLoadResString(508803)) Then
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblCuentaCB.Text = VTArreglo(3)
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    PMChequea(sqlconn)
                    txtCB.Text = ""
                    lblCB.Text = ""
                    lblCuentaCB.Text = ""
                    txtCB.Focus()
                End If
            Else
                txtCB.Text = ""
                lblCB.Text = ""
                lblCuentaCB.Text = ""
                txtPuntoIni.Text = ""
                txtPuntoFin.Text = ""
                lblPuntoIni.Text = ""
                lblPuntoFin.Text = ""
            End If
        End If
	End Sub

	Sub PLLimpiar()
		txtCB.Text = ""
		lblCB.Text = ""
		lblCuentaCB.Text = ""
		txtPuntoIni.Text = ""
		lblPuntoIni.Text = ""
		txtPuntoFin.Text = ""
        lblPuntoFin.Text = ""
        mskFecha(0).Mask = ""
        mskFecha(1).Mask = ""
		mskHora(0).Mask = ""
		mskHora(1).Mask = ""
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha(0).Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha(0).DateType = PLFormatoFecha()
        mskFecha(0).Connection = VGMap
        mskFecha(0).Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)

        VLFecha = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha(1).Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha(1).DateType = PLFormatoFecha()
        mskFecha(1).Connection = VGMap
        mskFecha(1).Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
		For i As Integer = 0 To 1
			mskHora(i).Mask = ""
			mskHora(i).Text = ""
			mskHora(i).Mask = "##:##:##"
		Next i
		txtMonto(0).Text = ""
		txtMonto(1).Text = ""
		PMLimpiaG(grdRegistros)
		txtTran.Text = ""
		lblTipoTran.Text = ""
	End Sub

	Sub PLBuscar()
		Dim VTFecha As String = ""
        Dim HoraIni As String = "" 'JSA
        Dim HoraFin As String = ""
		PLValidarCampos()
		If VLValida Then
			If mskHora(0).ClipText = "" Then
                HoraIni = "00:00:00"
            Else
                HoraIni = mskHora(0).Text
            End If
			If mskHora(1).ClipText = "" Then
                HoraFin = "23:59:59"
            Else
                HoraFin = mskHora(1).Text
            End If
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "705")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
			PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLINT4, txtCB.Text)
			PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, lblCuentaCB.Text)
			PMPasoValores(sqlconn, "@i_punto_ini", 0, SQLVARCHAR, txtPuntoIni.Text)
			PMPasoValores(sqlconn, "@i_punto_fin", 0, SQLVARCHAR, txtPuntoFin.Text)
			VTFecha = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFecha & " " & HoraIni)
			VTFecha = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha & " " & HoraFin)
			PMPasoValores(sqlconn, "@i_tipo_tran", 0, SQLINT4, txtTran.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_trn_cb", True, FMLoadResString(508803)) Then
                PMMapeaGrid(sqlconn, grdRegistros, False)
                PMMapeaTextoGrid(grdRegistros)
                PMAnchoColumnasGrid(grdRegistros)
                PMChequea(sqlconn)
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
                grdRegistros.ColWidth(13) = 1
            Else
                PMChequea(sqlconn)
                PMLimpiaG(grdRegistros)
            End If
        End If
        PLTSEstado()
	End Sub

	Sub PLSiguiente()
		Dim VTFecha As String = ""
        Dim HoraIni As String = "" 'JSA
        Dim HoraFin As String = ""
		PLValidarCampos()
		If VLValida Then
			If mskHora(0).ClipText = "" Then
				HoraIni = "00:00:00"
			End If
			If mskHora(1).ClipText = "" Then
				HoraFin = "23:59:59"
			End If
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "705")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
			PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLINT2, txtCB.Text)
			PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, lblCuentaCB.Text)
			PMPasoValores(sqlconn, "@i_punto_ini", 0, SQLVARCHAR, txtPuntoIni.Text)
			PMPasoValores(sqlconn, "@i_punto_fin", 0, SQLVARCHAR, txtPuntoFin.Text)
			VTFecha = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFecha & " " & HoraIni)
			VTFecha = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha & " " & HoraFin)
			PMPasoValores(sqlconn, "@i_tipo_tran", 0, SQLINT4, txtTran.Text)
			grdRegistros.Col = grdRegistros.Cols - 1
			grdRegistros.Row = grdRegistros.Rows - 1
			PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_trn_cb", True, FMLoadResString(508803)) Then
                PMMapeaGrid(sqlconn, grdRegistros, True)
                PMMapeaTextoGrid(grdRegistros)
                PMAnchoColumnasGrid(grdRegistros)
                PMChequea(sqlconn)
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
            Else
                PMChequea(sqlconn)
            End If
        End If
        PLTSEstado()
	End Sub

	Sub PLValidarCampos()
		Dim VTDias As Integer = 0
		VLValida = False
		If txtCB.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508613), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCB.Focus()
			Exit Sub
		End If
		If lblCuentaCB.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508489), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			Exit Sub
		End If
		If txtPuntoIni.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508611), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtPuntoIni.Focus()
			Exit Sub
		End If
		If txtPuntoFin.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508612), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtPuntoFin.Focus()
			Exit Sub
		End If
		If mskFecha(0).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508612), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskFecha(0).Focus()
			Exit Sub
		End If
		If mskFecha(1).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508608), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskFecha(1).Focus()
			Exit Sub
		End If
		VTDias = FMDateDiff("d", mskFecha(0).Text, mskFecha(1).Text, VGFormatoFecha)
		If VTDias < 0 Then
            COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			For i As Integer = 0 To 1
				mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
			Next i
			Exit Sub
		End If
		If mskHora(0).ClipText <> "" And mskHora(1).ClipText <> "" Then
			If mskHora(0).ClipText > mskHora(1).ClipText Then
                COBISMessageBox.Show(FMLoadResString(508597), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				mskFecha(ContainerHelper.GetControlIndex(Me)).Focus()
				Exit Sub
			End If
		End If
		VLValida = True
	End Sub

	Private Sub PLExcel()
		grdRegistros.Row = 1
		grdRegistros.Col = 1
		If grdRegistros.CtlText <> "" Then
			GeneraDatos_Excel()
		Else
            COBISMessageBox.Show(FMLoadResString(502290), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
		End If
	End Sub

	Sub GeneraDatos_Excel()
		Dim valor As String = ""
		Try 
			Dim XlsApl As Excel.Application
			Dim xlsLibro As Excel.Workbook
			Dim xlhoja As Excel.Worksheet
			XlsApl = New Excel.Application()
            XlsApl.Caption = FMLoadResString(508874)
			XlsApl.WindowState = Excel.XlWindowState.xlMinimized
				XlsApl.Workbooks.Add()
				xlsLibro = XlsApl.ActiveWorkbook
				xlhoja = xlsLibro.Worksheets.Add()
				xlhoja.Name = "GESTION_CTAS_CORR"
					XlsApl.Columns("E:F", Type.Missing).Select()
					XlsApl.Rows("5:10", Type.Missing).Select()
					XlsApl.Selection.NumberFormat = "@"
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508564) & " [" & svArchivo & "] ...")
					Fil = 1
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508874)
					Fil = 2
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508875)
					Fil = 4
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508499)
					col = 5
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = txtCB.Text
					Fil = 5
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508876)
					col = 5
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = txtTran.Text
					Fil = 6
					col = 5
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508877)
					col = 6
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508878)
					Fil = 7
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508879)
					col = 5
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = txtPuntoIni.Text
					col = 6
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = txtPuntoFin.Text
					Fil = 8
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508880)
					col = 5
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = mskFecha(0).Text
					col = 6
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = mskFecha(1).Text
					Fil = 9
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508881)
					col = 5
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = mskHora(0).Text
					col = 6
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = mskHora(1).Text
					Fil = 10
					col = 4
            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = FMLoadResString(508882)
					col = 5
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = txtMonto(0).Text
					col = 6
					xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil, col).Value2 = txtMonto(1).Text
					col = 1
					For fila As Integer = 0 To grdRegistros.Rows - 1
						Fil += 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508565) & " [" & fila & "] " & FMLoadResString(508796) & CStr(grdRegistros.Rows - 1) & " ...")
						grdRegistros.Row = fila
						col = 0
						For columna As Integer = 1 To grdRegistros.Cols - 2
							col += 1
							grdRegistros.Col = columna
							valor = grdRegistros.CtlText
							If col = 1 Then
                        If FMConvFecha(valor, VGFormatoFecha, VGFormatoFecha) <> "" Then
                            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil + 1, col).Value2 = "'" & grdRegistros.CtlText
                        Else
                            xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil + 1, col).Value2 = grdRegistros.CtlText
                        End If
							Else
								xlsLibro.Worksheets("GESTION_CTAS_CORR").Cells(Fil + 1, col).Value2 = grdRegistros.CtlText
							End If
						Next 
					Next 
			XlsApl.Visible = True
			XlsApl.WindowState = Excel.XlWindowState.xlMaximized
			XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
			XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
			XlsApl.Cells.EntireColumn.AutoFit()
		Catch excep As System.Exception
			COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
			Exit Sub
		End Try
	End Sub

    Private Sub txtMonto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtMonto_0.Enter, _txtMonto_1.Enter
        Dim Index As Integer = Array.IndexOf(txtMonto, eventSender)
        If Index = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508636))
        Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508634))
        End If
    End Sub
    Private Sub txtMonto_Leave(ByVal eventSender As Object, eventArgs As EventArgs) Handles _txtMonto_0.Leave, _txtMonto_1.Leave
        Dim valormin, valormax As Double
        If txtMonto(0).Text <> "0.00" And txtMonto(1).Text <> "0.00" Then
            valormin = Conversion.Val(Replace(txtMonto(0).Text, ",", ""))
            valormax = Conversion.Val(Replace(txtMonto(1).Text, ",", ""))
            If valormin > valormax Then
                COBISMessageBox.Show(FMLoadResString(9996), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtMonto(1).Text = ""
                txtMonto(1).Focus()
                Exit Sub
            End If
        End If
    End Sub

	Private Sub txtPuntoFin_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtPuntoFin.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508692))
		txtPuntoFin.SelectionStart = 0
		txtPuntoFin.SelectionLength = Strings.Len(txtPuntoFin.Text)
		VLPaso = True
    End Sub

    Private Sub txtPuntoFin_KeyPress(sender As Object, EventArgs As KeyPressEventArgs) Handles txtPuntoFin.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub


	Private Sub txtPuntoFin_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtPuntoFin.KeyDown
		Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            If txtCB.Text.Trim = "" Then
                COBISMessageBox.Show(FMLoadResString(508613), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtPuntoFin.Text = ""
                txtCB.Focus()
                Exit Sub
            End If
            txtCB.Enabled = True
            VLPaso = True
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "704")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S1")
            PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLINT4, txtCB.Text)
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
            PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, txtPuntoIni.Text)
            PMHelpG("cob_remesas", "sp_punto_red_cb", 4, 1)
            PMBuscarG(1, "@t_trn", "704", SQLINT2)
            PMBuscarG(2, "@i_operacion", "S1", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT2)
            PMBuscarG(4, "@i_codigo_cb", txtCB.Text, SQLINT4)
            PMSigteG(1, "@i_codigo_punto", 1, SQLVARCHAR)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, FMLoadResString(508802)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtPuntoFin.Text = Temporales(2)
                    lblPuntoFin.Text = Temporales(3)
                    VLPaso = True
                    SendKeys.Send("{TAB}")
                Else
                    VLPaso = False
                    txtCB_Leave(txtCB, New EventArgs())
                End If
            Else
                PMChequea(sqlconn)
            End If
            grid_valores.Dispose()
        End If
	End Sub

	Private Sub txtPuntoFin_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtPuntoFin.Leave
        Dim VTArreglo(3) As String
		If Not VLPaso Then
            If txtPuntoFin.Text.Trim() <> "" Then
                If txtCB.Text.Trim = "" Then
                    COBISMessageBox.Show(FMLoadResString(508613), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    txtPuntoFin.Text = ""
                    txtCB.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "704")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLINT4, txtCB.Text)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
                PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, txtPuntoFin.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, FMLoadResString(508803)) Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMChequea(sqlconn)
                    If VTArreglo(1) <> "" Then
                        txtPuntoFin.Text = VTArreglo(1)
                        lblPuntoFin.Text = VTArreglo(2)
                    Else
                        COBISMessageBox.Show(FMLoadResString(500361), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtPuntoFin.Text = ""
                        lblPuntoFin.Text = ""
                        txtPuntoFin.Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                    VLPaso = True
                    txtPuntoFin.Text = ""
                    lblPuntoFin.Text = ""
                End If
            End If
        End If
	End Sub

	Private Sub txtPuntoIni_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtPuntoIni.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508694))
		txtPuntoIni.SelectionStart = 0
		txtPuntoIni.SelectionLength = Strings.Len(txtPuntoIni.Text)
		VLPaso = True
	End Sub

    Private Sub txtPuntoIni_KeyPress(sender As Object, EventArgs As KeyPressEventArgs) Handles txtPuntoIni.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

	Private Sub txtPuntoIni_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtPuntoIni.KeyDown
		Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            If txtCB.Text.Trim = "" Then
                COBISMessageBox.Show(FMLoadResString(508613), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtPuntoIni.Text = ""
                txtCB.Focus()
                Exit Sub
            End If
            txtCB.Enabled = True
            VLPaso = True
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "704")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S1")
            PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLINT4, txtCB.Text)
            PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, "")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMHelpG("cob_remesas", "sp_punto_red_cb", 4, 1)
            PMBuscarG(1, "@t_trn", "704", SQLINT2)
            PMBuscarG(2, "@i_operacion", "S1", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            PMBuscarG(4, "@i_codigo_cb", txtCB.Text, SQLINT4)
            PMSigteG(1, "@i_codigo_punto", 1, SQLVARCHAR)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, FMLoadResString(508802)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtPuntoIni.Text = Temporales(2)
                    lblPuntoIni.Text = Temporales(3)
                    VLPaso = True
                    SendKeys.Send("{TAB}")
                Else
                    VLPaso = False
                    txtCB_Leave(txtCB, New EventArgs())
                End If
            Else
                PMChequea(sqlconn)
            End If
            grid_valores.Dispose()
        End If
	End Sub

	Private Sub txtPuntoIni_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtPuntoIni.Leave
        Dim VTArreglo(3) As String
		If Not VLPaso Then
            If txtPuntoIni.Text.Trim() <> "" Then
                If txtCB.Text.Trim = "" Then
                    COBISMessageBox.Show(FMLoadResString(508613), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    txtPuntoIni.Text = ""
                    lblPuntoIni.Text = ""
                    txtCB.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "704")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_codigo_cb", 0, SQLINT2, txtCB.Text)
                PMPasoValores(sqlconn, "@i_codigo_punto", 0, SQLVARCHAR, txtPuntoIni.Text)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, CStr(1))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_punto_red_cb", True, FMLoadResString(508803)) Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMChequea(sqlconn)
                    If VTArreglo(1) <> "" Then
                        txtPuntoIni.Text = VTArreglo(1)
                        lblPuntoIni.Text = VTArreglo(2)
                    Else
                        COBISMessageBox.Show(FMLoadResString(500361), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtPuntoIni.Text = ""
                        lblPuntoIni.Text = ""
                        txtPuntoIni.Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                    VLPaso = True
                    txtPuntoIni.Text = ""
                    lblPuntoIni.Text = ""
                End If
            End If
        End If
	End Sub

	Private Sub txtTran_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTran.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508503))
		txtTran.SelectionStart = 0
		txtTran.SelectionLength = Strings.Len(txtTran.Text)
	End Sub

	Private Sub txtTran_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtTran.KeyDown
		Dim Keycode As Integer = eventArgs.KeyCode
		If Keycode = VGTeclaAyuda Then
			VLPaso = True
			PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "ws_tran_canales")
			PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(508806)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtTran.Text = VGACatalogo.Codigo
                lblTipoTran.Text = VGACatalogo.Descripcion
            Else
                PMChequea(sqlconn)
                txtTran.Text = ""
                txtTran.Focus()
                lblTipoTran.Text = ""
            End If

            FCatalogo.Dispose()
		End If
	End Sub

	Private Sub txtTran_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtTran.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
			KeyAscii = 0
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtTran_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTran.Leave
		If txtTran.Text <> "" Then
			PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
			PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "ws_tran_canales")
			PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtTran.Text)
			PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
			PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502692) & "[" & txtTran.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblTipoTran)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                VLPaso = True
                txtTran.Text = ""
                lblTipoTran.Text = ""
            End If
		Else
			lblTipoTran.Text = ""
		End If
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = cmdBuscar.Enabled
        TSBBuscar.Visible = cmdBuscar.Visible
        TSBSiguientes.Enabled = cmdSiguientes.Enabled
        TSBSiguientes.Visible = cmdSiguientes.Visible
        TSBExcel.Enabled = _cmdExcel_1.Enabled
        TSBExcel.Visible = _cmdExcel_1.Visible
        TSBLimpiar.Enabled = _cmdLimpiar_2.Enabled
        TSBLimpiar.Visible = _cmdLimpiar_2.Visible
        TSBSalir.Enabled = _cmdSalir_3.Enabled
        TSBSalir.Visible = _cmdSalir_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If cmdBuscar.Enabled Then cmdBuscar_Click(sender, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If cmdSiguientes.Enabled Then cmdSiguientes_Click(sender, e)
    End Sub

    Private Sub TSBExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBExcel.Click
        If _cmdExcel_1.Enabled Then cmdExcel_Click(_cmdExcel_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdLimpiar_2.Enabled Then cmdLimpiar_Click(_cmdLimpiar_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdSalir_3.Enabled Then cmdSalir_Click(_cmdSalir_3, e)
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub txtCB_TextChanged(sender As Object, e As EventArgs) Handles txtCB.TextChanged
        VLPaso = False
    End Sub

    Private Sub txtPuntoIni_TextChanged(sender As Object, e As EventArgs) Handles txtPuntoIni.TextChanged
        VLPaso = False
    End Sub

    Private Sub txtPuntoFin_TextChanged(sender As Object, e As EventArgs) Handles txtPuntoFin.TextChanged
        VLPaso = False
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent        
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

End Class


