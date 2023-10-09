Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FCosEspClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
	Dim VLMoneda As String = ""
	Dim VLFecha As String = ""
	Dim VLDato As String = ""
	Dim VLRango As String = ""

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1291), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(4).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1427), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(5).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(5).Focus()
					Exit Sub
				End If
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(5).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "P" Then
					For i As Integer = 0 To 2
						If Conversion.Val(mskCosto(i).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1298), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
							mskCosto(i).Text = ""
							mskCosto(i).Focus()
							Exit Sub
						End If
					Next i
				End If
				If mskCosto(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1307), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto(1).Focus()
					Exit Sub
				End If
				If mskCosto(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1304), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto(2).Focus()
					Exit Sub
				End If
				If mskCosto(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1296), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto(0).Focus()
					Exit Sub
				End If
				If mskCosto(1).Text <> "" Then
					If Conversion.Val(mskCosto(1).Text.ToString()) > Conversion.Val(mskCosto(2).Text.ToString()) Then
                        COBISMessageBox.Show(FMLoadResString(1305), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto(2).Text = ""
						mskCosto(2).Focus()
						Exit Sub
					End If
				End If
				If mskCosto(2).Text <> "" Then
					If Conversion.Val(mskCosto(0).Text.ToString()) > Conversion.Val(mskCosto(2).Text.ToString()) Then
                        COBISMessageBox.Show(FMLoadResString(1297), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto(0).Text = ""
						mskCosto(0).Focus()
						Exit Sub
					End If
				End If
				If mskCosto(1).Text <> "" Then
					If Conversion.Val(mskCosto(0).Text.ToString()) < Conversion.Val(mskCosto(1).Text.ToString()) Then
                        COBISMessageBox.Show(FMLoadResString(1297), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto(0).Text = ""
						mskCosto(0).Focus()
						Exit Sub
					End If
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4087")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, lblDescripcion(8).Text)
				PMPasoValores(sqlconn, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text)
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, txtCampo(5).Text)
				PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT1, VLRango)
				PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_val_minimo", 0, SQLMONEY, mskCosto(1).Text)
				PMPasoValores(sqlconn, "@i_val_base", 0, SQLMONEY, mskCosto(0).Text)
				PMPasoValores(sqlconn, "@i_val_maximo", 0, SQLMONEY, mskCosto(2).Text)
                PMPasoValores(sqlconn, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, VGFormatoFecha, "mm/dd/yyyy"))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales", True, FMLoadResString(1606)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
				cmdBoton_Click(cmdBoton(3), New EventArgs())
			Case 1
				If lblDescripcion(8).Text <> "" Then
					txtCampo(0).Text = ""
					txtCampo(1).Text = ""
					lblDescripcion(8).Text = ""
					txtCampo(4).Text = ""
					txtCampo(5).Text = ""
					lblDescripcion(0).Text = ""
					lblDescripcion(2).Text = ""
					For i As Integer = 3 To 7
						lblDescripcion(i).Text = ""
					Next i
					txtCampo(1).Enabled = True
					txtCampo(4).Enabled = True
					COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
					COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
					cmdBoton(4).Enabled = False
					txtCampo(3).Focus()
					For i As Integer = 0 To 2
						mskCosto(i).Text = ""
						mskCosto(i).Text = "#,##0.00"
						VLMoneda = ""
					Next i
				Else
					txtCampo(1).Text = ""
					For i As Integer = 3 To 4
						txtCampo(i).Text = ""
					Next i
					For i As Integer = 0 To 2
						lblDescripcion(i).Text = ""
					Next i
					txtCampo(4).Enabled = True
					COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
					COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
					PMLimpiaGrid(grdProductos)
					cmdBoton(4).Enabled = False
					txtCampo(3).Focus()
				End If
				cmdBoton(0).Enabled = True
				VLPaso = False
			Case 2
                Me.Close()
            Case 3
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4086")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, lblDescripcion(8).Text)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales", True, FMLoadResString(1552)) Then
                    PMMapeaGrid(sqlconn, grdProductos, False)
                    PMMapeaTextoGrid(grdProductos)
                    PMChequea(sqlconn)
                    grdProductos.Col = 1
                    grdProductos.Row = grdProductos.Rows - 1
                Else
                    PMChequea(sqlconn)
                End If
                grdProductos.Row = 1
                grdProductos.ColWidth(1) = 1300
                grdProductos.ColWidth(6) = 3500
                grdProductos.ColWidth(7) = 1500
                grdProductos.ColWidth(8) = 1500
                For i As Integer = 12 To 15
                    grdProductos.ColWidth(CShort(i)) = 1
                Next i
			Case 4
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1291), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(4).Focus()
					Exit Sub
				End If
				If mskCosto(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1307), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto(1).Focus()
					Exit Sub
				End If
				If mskCosto(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1304), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto(2).Focus()
					Exit Sub
				End If
				If mskCosto(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1296), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto(0).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "P" Then
					For i As Integer = 0 To 2
						If Conversion.Val(mskCosto(i).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1298), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
							mskCosto(i).Text = ""
							mskCosto(i).Focus()
							Exit Sub
						End If
					Next i
				End If
				If mskCosto(1).Text <> "" Then
					If Conversion.Val(mskCosto(1).Text.ToString()) > Conversion.Val(mskCosto(2).Text.ToString()) Then
                        COBISMessageBox.Show(FMLoadResString(1305), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto(2).Text = ""
						mskCosto(2).Focus()
						Exit Sub
					End If
				End If
				If mskCosto(2).Text <> "" Then
					If Conversion.Val(mskCosto(0).Text.ToString()) > Conversion.Val(mskCosto(2).Text.ToString()) Then
                        COBISMessageBox.Show(FMLoadResString(1297), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto(0).Text = ""
						mskCosto(0).Focus()
						Exit Sub
					End If
				End If
				If mskCosto(1).Text <> "" Then
					If Conversion.Val(mskCosto(0).Text.ToString()) < Conversion.Val(mskCosto(1).Text.ToString()) Then
                        COBISMessageBox.Show(FMLoadResString(1297), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto(0).Text = ""
						mskCosto(0).Focus()
						Exit Sub
					End If
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4088")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, lblDescripcion(8).Text)
				PMPasoValores(sqlconn, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text)
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, txtCampo(5).Text)
				PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT1, VLRango)
				PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_val_minimo", 0, SQLMONEY, mskCosto(1).Text)
				PMPasoValores(sqlconn, "@i_val_base", 0, SQLMONEY, mskCosto(0).Text)
				PMPasoValores(sqlconn, "@i_val_maximo", 0, SQLMONEY, mskCosto(2).Text)
                PMPasoValores(sqlconn, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, VGFormatoFecha, "mm/dd/yyyy"))
                PMPasoValores(sqlconn, "@i_fecha_mod", 0, SQLVARCHAR, FMConvFecha(VGFecha, VGFormatoFecha, "mm/dd/yyyy"))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales", True, FMLoadResString(1588)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
				cmdBoton_Click(cmdBoton(3), New EventArgs())
		End Select
          PLTSEstado()
	End Sub

	Private Sub FCosEsp_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		mskCosto(0).Text = VGDecimales
		mskCosto(0).Text = StringsHelper.Format(0, VGDecimales)
		mskCosto(0).MaxLength = 14
		mskCosto(1).Text = VGDecimales
		mskCosto(1).Text = StringsHelper.Format(0, VGDecimales)
		mskCosto(1).MaxLength = 14
		mskCosto(2).Text = VGDecimales
		mskCosto(2).Text = StringsHelper.Format(0, VGDecimales)
		mskCosto(2).MaxLength = 14
        Dim VLFormatoFecha As String = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        VLFecha = FMConvFecha(VGFecha, VLFormatoFecha, VGFormatoFecha)
        VLFecha = FMDateAdd(VLFecha, "d", 1, VLFormatoFecha)
		mskFecha.Text = VLFecha
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(4))
        PLTSEstado()
        mskFecha.Focus()
	End Sub

	Private Sub FCosEsp_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdProductos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.ClickEvent
        grdProductos.Col = 0
        grdProductos.SelStartCol = 1
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
        End If
    End Sub

	Private Sub grdProductos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdProductos.DblClick
		Dim VTRow As Integer = grdProductos.Row
		grdProductos.Row = 1
		grdProductos.Col = 1
		If grdProductos.CtlText <> "" Then
			grdProductos.Row = VTRow
			PMMarcarRegistro()
			VLPaso = False
			txtCampo_Leave(txtCampo(5), New EventArgs())
			mskCosto(1).Focus()
		End If
	End Sub

	Private Sub grdProductos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
	End Sub

	Private Sub grdProductos_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdProductos.KeyUp
        grdProductos.Col = 0
		grdProductos.SelStartCol = 1
		grdProductos.SelEndCol = grdProductos.Cols - 1
		If grdProductos.Row = 0 Then
			grdProductos.SelStartRow = 1
			grdProductos.SelEndRow = 1
		Else
			grdProductos.SelStartRow = grdProductos.Row
			grdProductos.SelEndRow = grdProductos.Row
		End If
	End Sub

	Private Sub PMMarcarRegistro()
		cmdBoton(0).Enabled = False
		cmdBoton(4).Enabled = True
          PLTSEstado()
		grdProductos.Col = 4
		lblDescripcion(8).Text = grdProductos.CtlText
		grdProductos.Col = 12
		lblDescripcion(0).Text = grdProductos.CtlText
		grdProductos.Col = 5
		If grdProductos.CtlText = "P" Then
			lblDescripcion(2).Text = "PORCENTAJE"
		Else
			lblDescripcion(2).Text = "MONTO"
		End If
		txtCampo(4).Text = grdProductos.CtlText
		grdProductos.Col = 6
		txtCampo(1).Text = grdProductos.CtlText
		grdProductos.Col = 13
		txtCampo(5).Text = grdProductos.CtlText
		grdProductos.Col = 14
		VLRango = grdProductos.CtlText
		grdProductos.Col = 15
		txtCampo(0).Text = grdProductos.CtlText
		grdProductos.Col = 9
		mskCosto(1).Text = grdProductos.CtlText
		grdProductos.Col = 10
		mskCosto(0).Text = grdProductos.CtlText
		grdProductos.Col = 11
		mskCosto(2).Text = grdProductos.CtlText
		grdProductos.Col = 7
		lblDescripcion(4).Text = grdProductos.CtlText
		grdProductos.Col = 8
		lblDescripcion(5).Text = grdProductos.CtlText
	End Sub

	Private Sub mskCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_2.Enter, _mskCosto_1.Enter, _mskCosto_0.Enter
		Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
		If VLDato = "M" Then
			If VLMoneda = "S" Then
				mskCosto(Index).Text = "#,##0.00"
			ElseIf VLMoneda = "N" Then 
				mskCosto(Index).Text = "#,##0"
			End If
		Else
			mskCosto(Index).Text = "##0.00"
		End If
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1117))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1810))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1808))
		End Select
		mskCosto(Index).SelectionStart = 0
		mskCosto(Index).SelectionLength = Strings.Len(mskCosto(Index).Text)
	End Sub

	Private Sub mskCosto_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskCosto_2.KeyPress, _mskCosto_1.KeyPress, _mskCosto_0.KeyPress
		Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
		Select Case Index
			Case 0, 1, 2
				If VLDato = "P" Then
					If (Strings.Chr(Asc(eventArgs.KeyChar)).ToString()) <> "." And (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
						eventArgs.KeyChar = Chr(0)
					End If
					Exit Sub
				End If
				If VLMoneda = "S" Then
					If (Strings.Chr(Asc(eventArgs.KeyChar)).ToString()) <> "." And (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
						eventArgs.KeyChar = Chr(0)
					End If
				ElseIf VLMoneda = "N" Then 
					If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
						eventArgs.KeyChar = Chr(0)
					End If
				End If
		End Select
	End Sub

	Private Sub mskCosto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_2.Leave, _mskCosto_1.Leave, _mskCosto_0.Leave
		Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
		If mskCosto(Index).Text <> "" Then
			If txtCampo(3).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(1273), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				mskCosto(0).Text = ""
				txtCampo(3).Focus()
				Exit Sub
			End If
		End If
		Select Case Index
			Case 0
				If mskCosto(0).Text <> "" Then
					Dim dbNumericTemp As Double = 0
					If Not Double.TryParse(mskCosto(0).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
						mskCosto(0).Text = ""
						mskCosto(0).Focus()
						Exit Sub
					End If
					If VLDato = "P" Then
						If Conversion.Val(mskCosto(0).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1298), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
							mskCosto(0).Text = ""
							mskCosto(0).Focus()
							Exit Sub
						End If
					End If
				End If
			Case 1
				If mskCosto(1).Text <> "" Then
					Dim dbNumericTemp2 As Double = 0
					If Not Double.TryParse(mskCosto(1).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
						mskCosto(1).Text = ""
						mskCosto(1).Focus()
						Exit Sub
					End If
					If VLDato = "P" Then
						If Conversion.Val(mskCosto(1).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1306), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
							mskCosto(1).Text = ""
							mskCosto(1).Focus()
							Exit Sub
						End If
					End If
				End If
			Case 2
				If mskCosto(2).Text <> "" Then
					Dim dbNumericTemp3 As Double = 0
					If Not Double.TryParse(mskCosto(2).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp3) Then
						mskCosto(2).Text = ""
						mskCosto(2).Focus()
						Exit Sub
					End If
					If VLDato = "P" Then
						If Conversion.Val(mskCosto(2).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1303), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
							mskCosto(2).Text = ""
							mskCosto(2).Focus()
							Exit Sub
						End If
					End If
				End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1367))
		mskFecha.SelectionStart = 0
		mskFecha.SelectionLength = Strings.Len(mskFecha.Text)
	End Sub

	Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
		Dim VTValido As Integer = 0
		If mskFecha.ClipText <> "" Then
			VTValido = FMVerFormato(mskFecha.Text, VGFormatoFecha)
			If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(1378), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
				mskFecha.Mask = ""
				mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
				mskFecha.Focus()
				Exit Sub
			End If
		End If
		If mskFecha.Text <> StringsHelper.Format(VLFecha, VGFormatoFecha) Then
			If FMDateDiff("d", StringsHelper.Format(VLFecha, VGFormatoFecha), mskFecha.Text, VGFormatoFecha) < 0 Then
                COBISMessageBox.Show(FMLoadResString(1368), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				mskFecha.Mask = ""
				mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
				mskFecha.Focus()
				Exit Sub
			End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_3.TextChanged, _txtCampo_4.TextChanged, _txtCampo_0.TextChanged, _txtCampo_5.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 2, 3, 4, 5
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_3.Enter, _txtCampo_4.Enter, _txtCampo_0.Enter, _txtCampo_5.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1680))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1189))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1690))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1165))
			Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1778))
			Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1774))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_3.KeyDown, _txtCampo_4.KeyDown, _txtCampo_0.KeyDown, _txtCampo_5.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTGrupo As String = string.Empty
		Dim  VTRango As String = string.Empty
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VLPaso = True
                    If txtCampo(5).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(5).Focus()
                        Exit Sub
                    End If
                    VLPaso = True
                    VGOperacion = "sp_help_rango_pe"
                    VGTipo = "T"
                    VTFilas = VGMaxRows
                    VTGrupo = "0"
                    VTRango = "0"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "G")
                        PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT2, VTGrupo)
                        PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, VTRango)
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, txtCampo(5).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", False, FMLoadResString(1595)) Then
                            If VTGrupo = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTGrupo = FRegistros.grdRegistros.CtlText
                            If FRegistros.grdRegistros.Col > 2 Then
                                FRegistros.grdRegistros.Col = 2
                            End If
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTRango = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            VGOperacion = ""
                            VGTipo = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        VLRango = VGValores(1)
                        txtCampo(0).Text = VGValores(2)
                        lblDescripcion(4).Text = VGValores(3)
                        lblDescripcion(5).Text = VGValores(4)
                        VLPaso = True
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 3
                    VGForma = "FCosEsp"
                    FAyudaSubserv2.ShowPopup(Me)
                    If VGDetalle(1) <> "" Then
                        PMSubserv()
                        VLPaso = True
                    End If
                    FAyudaSubserv2.Dispose() '18/05/2016 migracion
                Case 4
                    PMCatalogo("A", "pe_tipo_dato", txtCampo(4), lblDescripcion(2), FRegistros)
                    txtCampo(1).Focus()
                    VLPaso = True
                Case 5
                    VLPaso = True
                    VGOperacion = "sp_costos_especiales"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4086")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales", False, FMLoadResString(1597)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        txtCampo(5).Text = VGACatalogo.Codigo
                        lblDescripcion(6).Text = VGACatalogo.Descripcion
                        If txtCampo(5).Text <> "" Then
                            cmdBoton_Click(cmdBoton(3), New EventArgs())
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                    End If
                    VLPaso = True
                    If txtCampo(5).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, txtCampo(5).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        Dim Valores(10) As String
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", False, FMLoadResString(1595)) Then
                            FMMapeaArreglo(sqlconn, Valores)
                            PMChequea(sqlconn)
                            lblDescripcion(3).Text = Valores(2)
                            lblDescripcion(7).Text = Valores(3)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4044")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(3).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", False, FMLoadResString(1562)) Then
                                PMMapeaVariable(sqlconn, VLMoneda)
                                PMChequea(sqlconn)
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(3).Text = ""
                            lblDescripcion(7).Text = ""
                            VLDato = ""
                        End If
                    End If
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_3.KeyPress, _txtCampo_4.KeyPress, _txtCampo_0.KeyPress, _txtCampo_5.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1, 2, 4
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
					KeyAscii = 0
				Else
					KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
				End If
			Case 0, 3, 5
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_3.Leave, _txtCampo_4.Leave, _txtCampo_0.Leave, _txtCampo_5.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim Valores() As String
		Select Case Index
			Case 0
				If Not VLPaso Then
					If txtCampo(0).Text = "" Then
						lblDescripcion(4).Text = ""
						lblDescripcion(5).Text = ""
						Exit Sub
					End If
					If txtCampo(5).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						txtCampo(5).Text = ""
						txtCampo(5).Focus()
						Exit Sub
					End If
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4047")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
					PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, txtCampo(5).Text)
					PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, VLRango)
					PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, txtCampo(0).Text)
                    ReDim Valores(5)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corango_pe", False, FMLoadResString(1595)) Then
                        FMMapeaArreglo(sqlconn, Valores)
                        PMChequea(sqlconn)
                        lblDescripcion(4).Text = Valores(1)
                        lblDescripcion(5).Text = Valores(2)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        VLPaso = True
                    End If
				End If
			Case 3
				If Not VLPaso Then
					If txtCampo(3).Text <> "" Then
						VGForma = "FCosEsp"
						FAyudaSubserv2.ShowPopup(Me)
						If VGDetalle(1) <> "" Then
							PMSubserv()
						Else
							If lblDescripcion(1).Text = "" Then
								txtCampo(3).Text = ""
								txtCampo(3).Focus()
								VLPaso = True
							End If
						End If
						FAyudaSubserv2.Dispose() '18/05/2016 migracion
					Else
						VLPaso = True
						lblDescripcion(1).Text = ""
						lblDescripcion(0).Text = ""
						lblDescripcion(8).Text = ""
					End If
				End If
			Case 4
				If Not VLPaso Then
					If txtCampo(4).Text <> "" Then
                        PMCatalogo("V", "pe_tipo_dato", txtCampo(4), lblDescripcion(2), Nothing)
						txtCampo(1).Focus()
					Else
						txtCampo(4).Text = ""
						lblDescripcion(2).Text = ""
					End If
				End If
			Case 5
				If Not VLPaso Then
					If txtCampo(5).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4086")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(5).Text)
						PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales", False, FMLoadResString(1597)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(6))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(5).Text = ""
                            lblDescripcion(6).Text = ""
                            lblDescripcion(3).Text = ""
                            lblDescripcion(7).Text = ""
                        End If
					Else
						VLPaso = True
						lblDescripcion(6).Text = ""
					End If
					If txtCampo(5).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, txtCampo(5).Text)
						PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
						ReDim Valores(10)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", False, FMLoadResString(1595)) Then
                            FMMapeaArreglo(sqlconn, Valores)
                            PMChequea(sqlconn)
                            lblDescripcion(3).Text = Valores(2)
                            lblDescripcion(7).Text = Valores(3)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4044")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(3).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", False, FMLoadResString(1596)) Then
                                PMMapeaVariable(sqlconn, VLMoneda)
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(0).Text = ""
                            lblDescripcion(2).Text = ""
                            VLDato = ""
                        End If
					End If
				End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private Sub PMSubserv()
		If VGDetalle(0) = "S" Then
			If txtCampo(3).Text = "" Then
				lblDescripcion(1).Text = VGDetalle(1)
				lblDescripcion(0).Text = VGDetalle(2)
				txtCampo(3).Text = VGDetalle(3)
				lblDescripcion(8).Text = VGDetalle(4)
				txtCampo(1).Text = VGDetalle(1)
			Else
				lblDescripcion(1).Text = VGDetalle(1)
				lblDescripcion(0).Text = VGDetalle(2)
				lblDescripcion(8).Text = VGDetalle(3)
				txtCampo(1).Text = VGDetalle(1)
			End If
		End If
	End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBBuscar.Visible = _cmdBoton_3.Enabled
        TSBCrear.Visible = _cmdBoton_0.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Enabled
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdProductos_Leave(sender As Object, e As EventArgs) Handles grdProductos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


