Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class FDevRecCBClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLValida As Boolean = False
	Dim i As Integer = 0
	Dim VLPaso As Integer = 0
	Dim fila As Integer = 0
	Dim columna As Integer = 0
    Dim valor As String = ""
    Dim VLDia_FecIni As Integer
    Dim VLMes_FecIni As Integer
    Dim VLAni_FecIni As Integer
    Dim VLDia_FecFin As Integer
    Dim VLMes_FecFin As Integer
    Dim VLAni_FecFin As Integer
    Dim VLOperacion As String = ""
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
    Private Sub FDevRecCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
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

	Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
		PMLineaG(grdRegistros)
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
		Dim VTValido As Integer = 0
		Dim VTDias As String = string.Empty
        Dim VTFechaini As String = String.Empty
        Dim VTFechadesde As String = String.Empty
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
                            mskFecha(0).Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                            mskFecha(1).Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
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
                            mskFecha(1).Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                            Exit Sub
                        End If
                    End If

            End Select
		Catch exc As System.Exception
			NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
		End Try
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
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1051")
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
                grid_valores.Dispose()
            Else
                PMChequea(sqlconn)
                VLPaso = True
            End If

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
                        lblCupo.Text = VTArreglo(2)
                        lblCuentaCB.Text = VTArreglo(3)
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    PMChequea(sqlconn)
                    txtCB.Text = ""
                    lblCB.Text = ""
                    lblCupo.Text = ""
                    lblCuentaCB.Text = ""
                    VLPaso = False
                End If
            Else
                txtCB.Text = ""
                lblCB.Text = ""
                lblCuentaCB.Text = ""
            End If
        End If
    End Sub

	Sub PLLimpiar()
		txtCB.Text = ""
		lblCB.Text = ""
		lblCuentaCB.Text = ""
		mskFecha(0).Mask = ""
		mskFecha(1).Mask = ""
		mskFecha(0).Text = ""
		mskFecha(1).Text = ""
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
		lblCupo.Text = ""
		txtDiasDev.Text = ""
		PMLimpiaG(grdRegistros)
	End Sub

	Private Sub txtDiasDev_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDiasDev.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508528))
		txtDiasDev.SelectionStart = 0
		txtDiasDev.SelectionLength = Strings.Len(txtDiasDev.Text)
	End Sub

	Private Sub txtDiasDev_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtDiasDev.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
			KeyAscii = 0
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Sub PLBuscar()
		Dim VTFecha As String = ""
		Try 
			PLValidarCampos()
			If VLValida Then
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "703")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
				PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLINT2, txtCB.Text)
				PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, lblCuentaCB.Text)
				PMPasoValores(sqlconn, "@i_dias_dev", 0, SQLINT2, txtDiasDev.Text)
				VTFecha = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
				PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFecha)
				VTFecha = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
				PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha)
				PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_devolucion_val_recaudo", True, FMLoadResString(508803)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                    FormatoGrid()
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
                Else
                    PMChequea(sqlconn)
                    PMLimpiaG(grdRegistros)
                End If
                PLTSEstado()
			End If
		Catch excep As System.Exception
            COBISMessageBox.Show(FMLoadResString(508551) & " " & excep.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			Exit Sub
		End Try
	End Sub

	Sub PLSiguiente()
		Dim VTFecha As String = ""
		Try 
			PLValidarCampos()
			If VLValida Then
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "703")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
				PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLINT2, txtCB.Text)
				PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, lblCuentaCB.Text)
				PMPasoValores(sqlconn, "@i_dias_dev", 0, SQLINT2, txtDiasDev.Text)
				VTFecha = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
				PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFecha)
				VTFecha = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
				PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha)
				PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
				grdRegistros.Col = 1
				grdRegistros.Row = grdRegistros.Rows - 1
				PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_devolucion_val_recaudo", True, FMLoadResString(508803)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                    FormatoGrid()
                    cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
                Else
                    PMChequea(sqlconn)
                End If
                PLTSEstado()
			End If
		Catch excep As System.Exception
            COBISMessageBox.Show(FMLoadResString(508551) & " " & excep.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			Exit Sub
		End Try
	End Sub

	Sub FormatoGrid()
		grdRegistros.ColAlignment(1) = 0
		grdRegistros.ColAlignment(2) = 0
		grdRegistros.ColAlignment(3) = 1
		grdRegistros.ColAlignment(4) = 1
		grdRegistros.ColAlignment(5) = 1
		grdRegistros.ColAlignment(6) = 1
		grdRegistros.ColAlignment(7) = 1
		grdRegistros.ColAlignment(8) = 1
        grdRegistros.ColIsVisible(1) = False
		grdRegistros.ColWidth(2) = 1350
		grdRegistros.ColWidth(3) = 1500
		grdRegistros.ColWidth(4) = 1500
		grdRegistros.ColWidth(5) = 1500
		grdRegistros.ColWidth(6) = 1500
		grdRegistros.ColWidth(7) = 1500
		grdRegistros.ColWidth(8) = 1500
	End Sub

	Sub PLValidarCampos()
		VLValida = False
		If txtCB.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508613), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCB.Focus()
			Exit Sub
		End If
		If lblCuentaCB.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508489), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCB.Focus()
			Exit Sub
		End If
		If mskFecha(0).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508615), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskFecha(0).Focus()
			Exit Sub
		End If
		If mskFecha(1).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508616), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskFecha(1).Focus()
			Exit Sub
		End If
		Dim VTDias As Integer = FMDateDiff("d", mskFecha(0).Text, mskFecha(1).Text, VGFormatoFecha)
		If VTDias < 0 Then
            COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			For i As Integer = 0 To 1
                mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha(i).DateType = PLFormatoFecha()
                mskFecha(i).Connection = VGMap
			Next i
			Exit Sub
		End If
		If txtDiasDev.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508614), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtDiasDev.Focus()
			Exit Sub
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
		Try 
			Dim XlsApl As Excel.Application
			Dim xlsLibro As Excel.Workbook
			Dim xlhoja As Excel.Worksheet
			XlsApl = New Excel.Application()
            XlsApl.Caption = FMLoadResString(508790)
			XlsApl.WindowState = Excel.XlWindowState.xlMinimized
				XlsApl.Workbooks.Add()
				xlsLibro = XlsApl.ActiveWorkbook
				xlhoja = xlsLibro.Worksheets.Add()
				xlhoja.Name = "DEVOLUCION_VALORES"
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508564) & " [" & svArchivo & "] ...")
					Fil = 1
					col = 4
            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = FMLoadResString(508790)
					Fil = 3
					col = 2
            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = FMLoadResString(508791)
					col = 3
					xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = lblCB.Text
					col = 4
            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = FMLoadResString(508792)
					col = 5
					xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = lblCupo.Text
					Fil = 4
					col = 2
            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = FMLoadResString(508793)
					col = 3
					xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = "'" & mskFecha(0).Text
					col = 4
            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = FMLoadResString(508794)
					col = 5
					xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = "'" & mskFecha(1).Text
					Fil = 5
					col = 2
            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = FMLoadResString(508795)
					col = 3
					xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil, col).Value2 = txtDiasDev.Text
					col = 1
					For fila As Integer = 0 To grdRegistros.Rows - 1
						Fil += 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508565) & " [" & fila & "] " & FMLoadResString(508796) & CStr(grdRegistros.Rows - 1) & " ...")
						grdRegistros.Row = fila
						col = 0
						For columna As Integer = 2 To grdRegistros.Cols - 1
							col += 1
							grdRegistros.Col = columna
							valor = grdRegistros.CtlText
							If col = 1 Then
                        If FMConvFecha(valor, VGFormatoFecha, VGFormatoFecha) <> "" Then
                            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil + 1, col).Value2 = "'" & grdRegistros.CtlText
                        Else
                            xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil + 1, col).Value2 = grdRegistros.CtlText
                        End If
							Else
								xlsLibro.Worksheets("DEVOLUCION_VALORES").Cells(Fil + 1, col).Value2 = grdRegistros.CtlText
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

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBuscar.Enabled Then cmdBuscar_Click(_cmdBuscar, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdSiguientes.Enabled Then cmdSiguientes_Click(_cmdSiguientes, e)
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

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = cmdBuscar.Enabled
        TSBBuscar.Visible = cmdBuscar.Visible()
        TSBSiguiente.Enabled = cmdSiguientes.Enabled
        TSBSiguiente.Visible = cmdSiguientes.Visible()
        TSBExcel.Enabled = _cmdExcel_1.Enabled
        TSBExcel.Visible = _cmdExcel_1.Visible()
        TSBLimpiar.Enabled = _cmdLimpiar_2.Enabled
        TSBLimpiar.Visible = _cmdLimpiar_2.Visible()
        TSBSalir.Enabled = _cmdSalir_3.Enabled
        TSBSalir.Visible = _cmdSalir_3.Visible()

    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub txtCB_TextChanged(sender As Object, e As EventArgs) Handles txtCB.TextChanged
        VLPaso = False
    End Sub
End Class


