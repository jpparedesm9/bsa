Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Query
 Public  Partial  Class FContratacionClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()

	Dim VLPaso As Integer = 0
	Dim VLTipo As String = ""
	Dim VLEnte As String = ""
	Dim VLCol As Integer = 0
	Dim VLMoneda As String = ""

	Private Sub cmbEnte_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbEnte.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1754))
	End Sub

	Private Sub cmbEnte_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbEnte.Leave
        Select Case cmbEnte.Text
            Case "PERSONAL"
                txtCampo(4).Text = ""
                lblDescripcion(5).Text = ""
                txtCampo(4).Enabled = True
                lblEtiqueta(7).Text = "Código Persona"
                txtCampo(1).Text = "1"
                txtCampo(1).Enabled = False
                lblDescripcion(1).Text = "PROPIETARIO"
                txtCampo(4).Enabled = True
                VLEnte = "P"
            Case "EMPRESARIAL"
                VLEnte = "C"
                txtCampo(1).Text = ""
                lblDescripcion(1).Text = ""
                txtCampo(1).Enabled = True
                lblEtiqueta(7).Text = "Código Empresa"
                txtCampo(1).Enabled = True
                txtCampo(4).Text = "N"
                txtCampo(4).Enabled = False
                lblDescripcion(5).Text = "NORMAL"
                VLEnte = "E"
            Case "GRUPO ECONOMICO"
                txtCampo(1).Text = ""
                lblDescripcion(1).Text = ""
                txtCampo(1).Enabled = True
                lblEtiqueta(7).Text = "Código Grupo"
                txtCampo(1).Enabled = True
                txtCampo(4).Text = "N"
                txtCampo(4).Enabled = False
                lblDescripcion(5).Text = "NORMAL"
                VLEnte = "G"
        End Select
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTFilas1 As Integer = 0
		Dim VTServicio1 As String = string.Empty
		Dim  VTRango1 As String = string.Empty
		Dim VTFilas2 As Integer = 0
		Dim VTServicio2 As String = string.Empty
		Dim  VTRango2 As String = string.Empty
		Select Case Index
			Case 0
				If cmbEnte.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1228), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					cmbEnte.Focus()
					Exit Sub
				End If
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1265), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1270), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1247), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(4).Focus()
					Exit Sub
				End If
				grdServicios(1).Row = 1
				grdServicios(1).Col = 1
				If grdServicios(1).CtlText = "" Then
					Exit Sub
				End If
				For i As Integer = 1 To grdServicios(1).Rows - 1
					grdServicios(1).Row = i
					grdServicios(1).Col = grdServicios(1).Cols - 2
					If grdServicios(1).CtlText <> "" Then
						grdServicios(1).Col = grdServicios(1).Cols - 1
						If grdServicios(1).CtlText <> "" Then
							PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4068")
							PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "T")
							PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, VLEnte)
							PMPasoValores(sqlconn, "@i_rol", 0, SQLCHAR, txtCampo(1).Text)
							PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, lblDescripcion(6).Text)
							PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(0).Text)
							PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(4).Text)
							PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, lblDescripcion(3).Text)
							PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
							grdServicios(1).Col = 2
							PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, grdServicios(1).CtlText)
							grdServicios(1).Col = 4
							PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, grdServicios(1).CtlText)
							grdServicios(1).Col = 6
							PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, grdServicios(1).CtlText)
							grdServicios(1).Col = 8
							PMPasoValores(sqlconn, "@i_rango", 0, SQLINT4, grdServicios(1).CtlText)
							grdServicios(1).Col = grdServicios(1).Cols - 2
							PMPasoValores(sqlconn, "@i_tipo_variacion", 0, SQLCHAR, grdServicios(1).CtlText)
							grdServicios(1).Col = grdServicios(1).Cols - 1
							PMPasoValores(sqlconn, "@i_valor_con", 0, SQLFLT8, grdServicios(1).CtlText)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1577)) Then
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                                COBISMessageBox.Show(CStr(CDbl(FMLoadResString(1349)) + (grdServicios(1).Row)), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
						End If
					End If
					grdServicios(1).Col = grdServicios(1).Cols - 2
					grdServicios(1).CtlText = ""
					grdServicios(1).Col = grdServicios(1).Cols - 1
					grdServicios(1).CtlText = ""
				Next i
			Case 1
				cmbEnte.Items.Clear()
				cmbEnte.Items.Insert(0, "PERSONAL")
				cmbEnte.Items.Insert(1, "EMPRESARIAL")
				cmbEnte.Items.Insert(2, "GRUPO ECONOMICO")
				cmbEnte.SelectedIndex = 0
				For i As Integer = 0 To 5
					txtCampo(i).Text = ""
					txtCampo(i).Enabled = True
				Next i
				txtCampo(6).Text = ""
				For i As Integer = 0 To 9
					lblDescripcion(i).Text = ""
				Next i
				For i As Integer = 0 To 1
					PMLimpiaGrid(grdServicios(i))
				Next i
				lblEtiqueta(7).Text = "Código Persona"
				txtCampo(1).Text = "1"
				txtCampo(1).Enabled = False
				lblDescripcion(1).Text = "PROPIETARIO"
				cmdBoton(0).Enabled = False
                txtCampo(3).Focus()
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
			Case 2
                Me.Close()
                'FBuscarGrupo.Close() '19/05/2016 migracion
                FBuscarGrupo.Dispose()
                'FBuscarCliente.Close() '19/05/2016 migracion
                FBuscarCliente.Dispose()
			Case 3
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1262), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				If cmbEnte.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1229), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					cmbEnte.Focus()
					Exit Sub
				End If
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1265), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1270), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1259), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1247), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(4).Focus()
					Exit Sub
				End If
				VLTipo = ""
				VTFilas1 = VGMaxRows
				VTServicio1 = "0"
				VTRango1 = "0"
				While VTFilas1 = VGMaxRows
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4070")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
					PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, VTServicio1)
					PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, VTRango1)
					PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, lblDescripcion(3).Text)
					PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, VLEnte)
					PMPasoValores(sqlconn, "@i_rol", 0, SQLCHAR, txtCampo(1).Text)
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, lblDescripcion(6).Text)
					PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(0).Text)
					PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(4).Text)
					PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1559)) Then
                        If VTServicio1 = "0" And VTRango1 = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios(0), False)
                        Else
                            PMMapeaGrid(sqlconn, grdServicios(0), True)
                        End If
                        PMMapeaTextoGrid(grdServicios(0))
                        PMChequea(sqlconn)
                        grdServicios(0).Col = 1
                        grdServicios(0).Row = grdServicios(0).Rows - 1
                        VTServicio1 = grdServicios(0).CtlText
                        grdServicios(0).Col = 3
                        grdServicios(0).Row = grdServicios(0).Rows - 1
                        VTRango1 = grdServicios(0).CtlText
                        If Conversion.Val(Convert.ToString(grdServicios(0).Tag)) > 0 Then
                            grdServicios(0).ColAlignment(4) = 1
                            grdServicios(0).ColAlignment(5) = 1
                            grdServicios(0).ColAlignment(7) = 1
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
					VTFilas1 = Conversion.Val(Convert.ToString(grdServicios(0).Tag))
				End While
				grdServicios(0).Row = 1
				If txtCampo(5).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1273), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(5).Focus()
					Exit Sub
				End If
				VTFilas2 = VGMaxRows
				VTServicio2 = "0"
				VTRango2 = "0"
				While VTFilas2 = VGMaxRows
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
					PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, VTServicio2)
					PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, VTRango2)
					PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, lblDescripcion(3).Text)
					PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, VLEnte)
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, lblDescripcion(6).Text)
					PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(4).Text)
					PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
					PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(5).Text)
					PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, txtCampo(6).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1559)) Then
                        If VTServicio2 = "0" And VTRango2 = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios(1), False)
                            PMMapeaTextoGrid(grdServicios(1))
                            If Conversion.Val(Convert.ToString(grdServicios(1).Tag)) > 0 Then
                                grdServicios(1).Cols += 2
                                grdServicios(1).Row = 0
                                grdServicios(1).Col = grdServicios(1).Cols - 2
                                grdServicios(1).CtlText = "M / P"
                                grdServicios(1).Col = grdServicios(1).Cols - 1
                                grdServicios(1).CtlText = "VALOR"
                                grdServicios(1).ColWidth(CShort(grdServicios(1).Cols - 2)) = 500
                                grdServicios(1).ColWidth(CShort(grdServicios(1).Cols - 1)) = 1800
                                grdServicios(1).ColWidth(2) = 1
                                grdServicios(1).ColWidth(4) = 1
                                grdServicios(1).ColWidth(6) = 1
                                grdServicios(1).ColWidth(8) = 1
                                grdServicios(1).ColWidth(9) = 1
                                grdServicios(1).ColAlignment(3) = 1
                                grdServicios(1).ColAlignment(5) = 1
                                grdServicios(1).ColAlignment(7) = 1
                                cmdBoton(0).Enabled = True
                            End If
                        Else
                            PMMapeaGrid(sqlconn, grdServicios(1), True)
                            PMMapeaTextoGrid(grdServicios(1))
                        End If
                        PMChequea(sqlconn)
                        grdServicios(1).Col = 2
                        grdServicios(1).Row = grdServicios(1).Rows - 1
                        VTServicio2 = grdServicios(1).CtlText
                        grdServicios(1).Col = 8
                        grdServicios(1).Row = grdServicios(1).Rows - 1
                        VTRango2 = grdServicios(1).CtlText
                    Else
                        PMChequea(sqlconn)
                        Exit Sub
                    End If
					If Conversion.Val(Convert.ToString(grdServicios(1).Tag)) = 50 Then
						VTFilas2 = 15
					Else
						VTFilas2 = 0
					End If
				End While
				grdServicios(1).Row = 1
		End Select
	End Sub

	Private Sub FContratacion_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMBotonSeguridad(Me, 3)
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(3))
		cmbEnte.Items.Clear()
		cmbEnte.Items.Insert(0, "PERSONAL")
		cmbEnte.Items.Insert(1, "EMPRESARIAL")
		cmbEnte.Items.Insert(2, "GRUPO ECONOMICO")
		cmbEnte.SelectedIndex = 0
		txtCampo(4).Text = ""
		lblDescripcion(5).Text = ""
		txtCampo(4).Enabled = True
		lblEtiqueta(7).Text = "Código Persona"
		txtCampo(1).Text = "1"
		txtCampo(1).Enabled = False
		lblDescripcion(1).Text = "PROPIETARIO"
		txtCampo(4).Enabled = True
		VLEnte = "P"
		cmdBoton(0).Enabled = False
        PLTSEstado()
	End Sub

	Private Sub FContratacion_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub grdServicios_ClickEvent(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_1.ClickEvent, _grdServicios_0.ClickEvent
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		If Index = 1 Then
			VLCol = grdServicios(1).Col
		End If
		If Index = 1 And VLCol > 0 Then
			grdServicios(1).Col = VLCol
		End If
	End Sub

	Private Sub grdServicios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_1.Enter, _grdServicios_0.Enter
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1720))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1721))
		End Select
	End Sub

	Private Sub grdServicios_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyPressEvent) Handles _grdServicios_1.KeyPressEvent, _grdServicios_0.KeyPressEvent
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		Dim VTRow As Integer = 0
		Dim  VTCol As Integer = 0
		Dim VTDato As String = ""
		If Index = 1 Then
			If VLCol > 0 Then
				grdServicios(1).Col = VLCol
			End If
			VTRow = grdServicios(1).Row
			VTCol = grdServicios(1).Col
			grdServicios(1).Row = 1
			grdServicios(1).Col = 1
			If grdServicios(1).CtlText = "" Then
				Exit Sub
			End If
			grdServicios(1).Row = VTRow
			grdServicios(1).Col = VTCol
			If grdServicios(1).Col = grdServicios(1).Cols - 2 Then
				If eventArgs.KeyAscii = 8 Then
					If Strings.Len(grdServicios(1).CtlText) > 0 Then
						grdServicios(1).CtlText = Strings.Mid(grdServicios(1).CtlText, 1, Strings.Len(grdServicios(1).CtlText) - 1)
						VLCol = grdServicios(1).Col
						grdServicios_ClickEvent(grdServicios(1), New EventArgs())
						Exit Sub
					End If
				End If
				If Strings.Len(grdServicios(1).CtlText) > 0 Then
					eventArgs.KeyAscii = 0
					Exit Sub
				End If
				If Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() = "P" Or Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() = "M" Then
					eventArgs.KeyAscii = Strings.AscW(Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper())
					grdServicios(1).CtlText = (Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper())
					VLTipo = grdServicios(1).CtlText
				Else
					eventArgs.KeyAscii = 0
				End If
			ElseIf grdServicios(1).Col = grdServicios(1).Cols - 1 Then 
				VTCol = grdServicios(1).Col
				grdServicios(1).Col = grdServicios(1).Cols - 3
				VTDato = grdServicios(1).CtlText
				grdServicios(1).Col = VTCol
				If VLTipo = "" Then
					eventArgs.KeyAscii = 0
                    COBISMessageBox.Show(FMLoadResString(1291), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					VLCol = grdServicios(1).Col
					grdServicios_ClickEvent(grdServicios(1), New EventArgs())
					Exit Sub
				End If
				If eventArgs.KeyAscii = 8 Then
					If Strings.Len(grdServicios(1).CtlText) > 0 Then
						grdServicios(1).CtlText = Strings.Mid(grdServicios(1).CtlText, 1, Strings.Len(grdServicios(1).CtlText) - 1)
						VLCol = grdServicios(1).Col
						grdServicios_ClickEvent(grdServicios(1), New EventArgs())
						Exit Sub
					End If
				End If
				If VLTipo = "P" Then
					If ((eventArgs.KeyAscii < 48) Or (eventArgs.KeyAscii > 57)) And (Strings.Chr(eventArgs.KeyAscii).ToString()) <> "." And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "+" And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "-" Then
						eventArgs.KeyAscii = 0
						VLCol = grdServicios(1).Col
						grdServicios_ClickEvent(grdServicios(1), New EventArgs())
						Exit Sub
					Else
						grdServicios(1).CtlText = grdServicios(1).CtlText & Strings.Chr(eventArgs.KeyAscii).ToString()
					End If
				Else
					If VLMoneda = "N" And VLTipo = "M" And VTDato = "M" Then
						If ((eventArgs.KeyAscii < 48) Or (eventArgs.KeyAscii > 57)) And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "+" And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "-" Then
							eventArgs.KeyAscii = 0
							VLCol = grdServicios(1).Col
							grdServicios_ClickEvent(grdServicios(1), New EventArgs())
							Exit Sub
						Else
							grdServicios(1).CtlText = grdServicios(1).CtlText & Strings.Chr(eventArgs.KeyAscii).ToString()
						End If
					Else
						If ((eventArgs.KeyAscii < 48) Or (eventArgs.KeyAscii > 57)) And (Strings.Chr(eventArgs.KeyAscii).ToString()) <> "." And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "+" And Strings.Chr(eventArgs.KeyAscii).ToString().ToUpper() <> "-" Then
							eventArgs.KeyAscii = 0
							VLCol = grdServicios(1).Col
							grdServicios_ClickEvent(grdServicios(1), New EventArgs())
							Exit Sub
						Else
							grdServicios(1).CtlText = grdServicios(1).CtlText & Strings.Chr(eventArgs.KeyAscii).ToString()
						End If
					End If
				End If
				If Strings.Len(grdServicios(1).CtlText) > 0 And (grdServicios(1).CtlText <> "." And grdServicios(1).CtlText <> "+" And grdServicios(1).CtlText <> "-") Then
					Dim dbNumericTemp As Double = 0
					If Not Double.TryParse(grdServicios(1).CtlText, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Or ((grdServicios(1).CtlText.IndexOf("+"c) + 1) > 1) Or ((grdServicios(1).CtlText.IndexOf("-"c) + 1) > 1) Then
                        COBISMessageBox.Show(FMLoadResString(1804), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						grdServicios(1).CtlText = ""
						VLCol = grdServicios(1).Col
						grdServicios_ClickEvent(grdServicios(1), New EventArgs())
						Exit Sub
					End If
				End If
				If VLTipo = "P" Then
					If Math.Abs(Conversion.Val(grdServicios(1).CtlText.ToString())) > 100 Then
                        COBISMessageBox.Show(FMLoadResString(1804), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						grdServicios(1).CtlText = ""
						VLCol = grdServicios(1).Col
						grdServicios_ClickEvent(grdServicios(1), New EventArgs())
						Exit Sub
					End If
				End If
			End If
			VLCol = grdServicios(1).Col
			grdServicios_ClickEvent(grdServicios(1), New EventArgs())
		End If
	End Sub

	Private Sub grdServicios_KeyUpEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyUpEvent) Handles _grdServicios_1.KeyUpEvent, _grdServicios_0.KeyUpEvent
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		Select Case Index
			Case 0, 1
				grdServicios(Index).Col = 0
				grdServicios(Index).SelEndCol = grdServicios(Index).Cols - 1
				If grdServicios(Index).Row = 0 Then
					grdServicios(Index).SelStartRow = 1
					grdServicios(Index).SelEndRow = 1
				Else
					grdServicios(Index).SelStartRow = grdServicios(Index).Row
					grdServicios(Index).SelEndRow = grdServicios(Index).Row
				End If
		End Select
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_5.TextChanged, _txtCampo_6.TextChanged, _txtCampo_3.TextChanged, _txtCampo_4.TextChanged, _txtCampo_0.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1, 2, 3, 4, 5, 6
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_5.Enter, _txtCampo_6.Enter, _txtCampo_3.Enter, _txtCampo_4.Enter, _txtCampo_0.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If cmbEnte.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1772), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			cmbEnte.Focus()
			Exit Sub
		End If
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1160))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1687))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1666))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
			Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1068))
			Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1711))
			Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1690))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_5.KeyDown, _txtCampo_6.KeyDown, _txtCampo_3.KeyDown, _txtCampo_4.KeyDown, _txtCampo_0.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTProFinal As String = ""
		If KeyCode <> VGTeclaAyuda Then Exit Sub
        VLPaso = True
		Select Case Index
			Case 0
				Select Case VLEnte
					Case "P"
						FBuscarCliente.optCliente(1).Enabled = False
						FBuscarCliente.optCliente(0).Checked = True
						FBuscarCliente.ShowPopup(Me)
						FBuscarCliente.optCliente(1).Enabled = True
					Case "E"
						FBuscarCliente.optCliente(0).Enabled = False
						FBuscarCliente.optCliente(1).Checked = True
						FBuscarCliente.ShowPopup(Me)
						FBuscarCliente.optCliente(0).Enabled = True
					Case "G"
                        FBuscarGrupo.ShowPopup(Me)
				End Select
				If VGBusqueda(1) <> "" Then
					txtCampo(0).Text = VGBusqueda(1)
					If VLEnte = "P" Then
						lblDescripcion(0).Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
					Else
						lblDescripcion(0).Text = VGBusqueda(2)
					End If
				End If

                '18/05/2016 migracion
                If VLEnte = "P" Or VLEnte = "E" Then
                    FBuscarCliente.Dispose()
                ElseIf VLEnte = "G" Then
                    FBuscarGrupo.Dispose()
                End If
            Case 1
                PMCatalogo("A", "cl_rol_empresa", txtCampo(1), lblDescripcion(1), FRegistros)
            Case 2
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTProFinal = "0"
                VGOperacion = "sp_prodfin2"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S2")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                        If VTProFinal = "0" Then
                            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        Else
                            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                        End If
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                        FRegistros.grdRegistros.Col = 1
                        FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                        VTProFinal = FRegistros.grdRegistros.CtlText
                    Else
                        PMChequea(sqlconn)
                        txtCampo(2).Text = ""
                        lblDescripcion(2).Text = ""
                        VGOperacion = ""
                    End If
                End While
                FRegistros.grdRegistros.Row = 1
                FRegistros.ShowPopup(Me)
                If VGValores(1) <> "" Then
                    txtCampo(2).Text = VGValores(1)
                    lblDescripcion(2).Text = VGValores(2)
                Else
                    txtCampo(2).Text = ""
                    lblDescripcion(2).Text = ""
                    VGOperacion = ""
                End If
                FRegistros.Dispose() '18/05/2016 migracion
            Case 3
                VGOperacion = "sp_hp_sucursal"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", False, FMLoadResString(1913)) Then
                    PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    PMChequea(sqlconn)
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(3).Text = VGValores(1)
                        lblDescripcion(7).Text = VGValores(2)
                    Else
                        txtCampo(3).Text = ""
                        lblDescripcion(7).Text = ""
                        VGOperacion = ""
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Else
                    PMChequea(sqlconn)
                    txtCampo(3).Text = ""
                    lblDescripcion(7).Text = ""
                    VGOperacion = ""
                End If
            Case 4
                VGOperacion = ""
                PMCatalogo("A", "pe_categoria", txtCampo(4), lblDescripcion(5), FRegistros)
            Case 5
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1577)) Then
                    PMMapeaGrid(sqlconn, FCatalogoServ.grdRegistros, False)
                    PMMapeaTextoGrid(FCatalogoServ.grdRegistros)
                    PMChequea(sqlconn)
                    VGOperacion = "operacionHCont"
                    FCatalogoServ.ShowPopup(Me)
                    If txtCampo(5).Text <> "" Then
                        txtCampo(5).Enabled = False
                    End If
                    FCatalogoServ.Dispose() '18/05/2016 migracion
                Else
                    PMChequea(sqlconn)
                End If
        End Select
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_5.KeyPress, _txtCampo_6.KeyPress, _txtCampo_3.KeyPress, _txtCampo_4.KeyPress, _txtCampo_0.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1, 4, 6
				KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
			Case 0, 2, 3, 5
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_5.Leave, _txtCampo_6.Leave, _txtCampo_3.Leave, _txtCampo_4.Leave, _txtCampo_0.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If Not VLPaso Then
					If txtCampo(0).Text <> "" Then
						Dim VTArreglo(7) As String
						Select Case VLEnte
							Case "P"
								PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1190")
								PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(0).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_qrente", False, FMLoadResString(1933)) Then
                                    FMMapeaArreglo(sqlconn, VTArreglo)
                                    PMChequea(sqlconn)
                                    If VTArreglo(2) = "P" Then
                                        lblDescripcion(0).Text = VTArreglo(1)
                                        VLPaso = True
                                    Else
                                        COBISMessageBox.Show(FMLoadResString(1145), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                        txtCampo(0).Text = ""
                                        txtCampo(0).Focus()
                                    End If
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(0).Text = ""
                                    lblDescripcion(0).Text = ""
                                End If
							Case "E"
								PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1190")
								PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(0).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_qrente", False, FMLoadResString(1934)) Then
                                    FMMapeaArreglo(sqlconn, VTArreglo)
                                    PMChequea(sqlconn)
                                    If VTArreglo(2) = "C" Then
                                        lblDescripcion(0).Text = VTArreglo(1)
                                    Else
                                        COBISMessageBox.Show(FMLoadResString(1144), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                        txtCampo(0).Text = ""
                                        txtCampo(0).Focus()
                                    End If
                                Else
                                    PMChequea(sqlconn)
                                    lblDescripcion(0).Text = ""
                                End If
							Case "G"
								PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1184")
								PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT4, txtCampo(0).Text)
								PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_grupo", False, FMLoadResString(1935)) Then
                                    FMMapeaArreglo(sqlconn, VTArreglo)
                                    PMChequea(sqlconn)
                                    lblDescripcion(0).Text = VTArreglo(2)
                                    VLPaso = True
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(0).Text = ""
                                    lblDescripcion(0).Text = ""
                                End If
						End Select
					Else
						lblDescripcion(0).Text = ""
					End If
				End If
			Case 1
				If Not VLPaso Then
					If txtCampo(1).Text <> "" Then
                        PMCatalogo("V", "cl_rol_empresa", txtCampo(1), lblDescripcion(1), Nothing)
					Else
						txtCampo(1).Text = ""
						lblDescripcion(1).Text = ""
					End If
				End If
			Case 2
				If Not VLPaso Then
					If txtCampo(2).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H2")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
						PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(3).Text)
						PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(2).Text = ""
                            txtCampo(2).Text = ""
                            VLPaso = True
                        End If
					Else
						lblDescripcion(2).Text = ""
					End If
				End If
			Case 3
				If Not VLPaso Then
					If txtCampo(3).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(7))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(7).Text = ""
                            txtCampo(3).Text = ""
                            VLPaso = True
                        End If
					Else
						lblDescripcion(7).Text = ""
					End If
				End If
			Case 4
				If Not VLPaso Then
					If txtCampo(4).Text <> "" Then
                        PMCatalogo("V", "pe_categoria", txtCampo(4), lblDescripcion(5), Nothing)
					Else
						lblDescripcion(5).Text = ""
					End If
				End If
			Case 5
				If Not VLPaso Then
					If txtCampo(5).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H2")
						PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
						PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, "")
						PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, "0")
						PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
						PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(5).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1577)) Then
                            PMMapeaGrid(sqlconn, FCatalogoServ.grdRegistros, False)
                            PMMapeaTextoGrid(FCatalogoServ.grdRegistros)
                            PMChequea(sqlconn)
                            VGOperacion = "operacionH2Cont"
                            FCatalogoServ.ShowPopup(Me)
                            If txtCampo(5).Text <> "" Then
                                txtCampo(5).Enabled = False
                            End If
                            FCatalogoServ.Dispose() '18/05/2016 migracion
                        Else
                            PMChequea(sqlconn)
                        End If
					End If
				End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBBuscar.Visible = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Enabled
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdServicios_Leave(sender As Object, e As EventArgs) Handles _grdServicios_1.Leave, _grdServicios_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


