Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Artinsoft.VB6.VB
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FManteEspecialClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()

	Dim VLPaso As Integer = 0
    Dim VLFecha As String = ""
	Dim VLAProbar As String = ""
	Dim VLFormatoFecha As String = ""

	Sub PLTransmitir()
		Dim VTPerson As String = string.Empty
		Dim  VTMsg As String = string.Empty
		If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1288), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(0).Focus()
			Exit Sub
		End If
		If mskFecha.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(1431), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskFecha.Focus()
			Exit Sub
		End If
		Dim VTConfirmar As String = "N"
		Dim VTVigente As String = "N"
		grdServicios(0).Row = 1
		grdServicios(0).Col = 1
		If grdServicios(0).CtlText <> "" Then
			grdServicios(0).Col = 2
			For i As Integer = 1 To grdServicios(0).Rows - 1
				grdServicios(0).Row = i
				grdServicios(0).Col = 0
				If grdServicios(0).CtlText = "X" Then
					grdServicios(0).Col = 2
					If Strings.Mid(grdServicios(0).CtlText, 1, 1) = "V" Then
						VTVigente = "V"
					End If
					grdServicios(0).Col = 3
					If Strings.Mid(grdServicios(0).CtlText, 1, 1) = "A" Then
						VTConfirmar = "A"
					End If
				End If
			Next i
		End If
		If VTConfirmar = "A" Then
			If VLAProbar = "S" Then
                COBISMessageBox.Show(FMLoadResString(1511), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				Exit Sub
			End If
		End If
		If VTVigente = "V" Then
			If VLAProbar = "N" Then
                COBISMessageBox.Show(FMLoadResString(1513), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				Exit Sub
			End If
		End If
		If VLAProbar = "S" Then
			VTPerson = "N"
			grdServicios(1).Row = 1
			grdServicios(1).Col = 1
			If grdServicios(1).CtlText <> "" Then
				grdServicios(1).Col = 2
				For i As Integer = 1 To grdServicios(1).Rows - 1
					grdServicios(1).Row = i
					grdServicios(1).Col = 0
					If grdServicios(1).CtlText = "X" Then
						VTPerson = "S"
					End If
				Next i
			End If
			If VTPerson = "S" Then
                COBISMessageBox.Show(FMLoadResString(1512), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				Exit Sub
			End If
		End If
		Dim VTGeneral As String = "N"
		VTPerson = "N"
		For j As Integer = 0 To 1
			grdServicios(j).Col = 0
			For i As Integer = 1 To grdServicios(j).Rows - 1
				grdServicios(j).Row = i
				If grdServicios(j).CtlText = "X" Then
					If j = 0 Then
						VTGeneral = "G"
					Else
						VTPerson = "P"
					End If
				End If
			Next i
		Next j
		If VLAProbar = "S" Then
            VTMsg = " APROBAR "
		Else
            VTMsg = " ELIMINAR "
		End If
		If VTGeneral = "N" And VTPerson = "N" Then
            COBISMessageBox.Show(FMLoadResString(1700) & VTMsg, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			Exit Sub
		End If
        If COBISMessageBox.Show(FMLoadResString(1332) & VTMsg & FMLoadResString(1870), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK Or COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) <> System.Windows.Forms.DialogResult.Yes Then
            Exit Sub
        Else
            If VTGeneral = "G" Then
                For i As Integer = 1 To grdServicios(0).Rows - 1
                    grdServicios(0).Col = 0
                    grdServicios(0).Row = i
                    If grdServicios(0).CtlText = "X" Then
                        If VLAProbar = "S" Then
                            PMPasoValores(sqlconn, "@i_aprobado", 0, SQLCHAR, "S")
                        Else
                            PMPasoValores(sqlconn, "@i_aprobado", 0, SQLCHAR, "E")
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4092")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                        PMPasoValores(sqlconn, "@i_person", 0, SQLCHAR, VTGeneral)
                        grdServicios(0).Col = 1
                        PMPasoValores(sqlconn, "@i_fecha_vigencia", 0, SQLVARCHAR, grdServicios(0).CtlText)
                        grdServicios(0).Col = 4
                        PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, grdServicios(0).CtlText)
                        grdServicios(0).Col = 10
                        PMPasoValores(sqlconn, "@i_tipo_dato", 0, SQLCHAR, grdServicios(0).CtlText)
                        grdServicios(0).Col = 13
                        PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, grdServicios(0).CtlText)
                        grdServicios(0).Col = 14
                        PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, grdServicios(0).CtlText)
                        grdServicios(0).Col = 15
                        PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, grdServicios(0).CtlText)
                        grdServicios(0).Col = 16
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, grdServicios(0).CtlText)
                        grdServicios(0).Col = 7
                        PMPasoValores(sqlconn, "@i_valor_per", 0, SQLMONEY, grdServicios(0).CtlText)
                        grdServicios(0).Col = 8
                        PMPasoValores(sqlconn, "@i_val_minimo", 0, SQLMONEY, grdServicios(0).CtlText)
                        grdServicios(0).Col = 9
                        PMPasoValores(sqlconn, "@i_val_maximo", 0, SQLMONEY, grdServicios(0).CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_especiales", True, FMLoadResString(1610)) Then
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            COBISMessageBox.Show(FMLoadResString(1321) & VTMsg & FMLoadResString(1871), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        End If
                    End If
                Next i
                mskFecha_Leave(mskFecha, New EventArgs())
            End If
            If VTPerson = "P" Then
                For i As Integer = 1 To grdServicios(1).Rows - 1
                    grdServicios(1).Col = 0
                    grdServicios(1).Row = i
                    If grdServicios(1).CtlText = "X" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4092")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                        PMPasoValores(sqlconn, "@i_person", 0, SQLCHAR, VTPerson)
                        grdServicios(1).Col = 16
                        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdServicios(1).CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_especiales", True, FMLoadResString(1610)) Then
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            COBISMessageBox.Show(FMLoadResString(1321) & VTMsg & FMLoadResString(1872), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        End If
                    End If
                Next i
                cmdBoton_Click(cmdBoton(3), New EventArgs())
            End If
        End If
    End Sub

    Private Sub cmbPerso_Leave(sender As Object, e As EventArgs) Handles cmbPerso.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

	Private Sub cmbPerso_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbPerso.SelectedIndexChanged
		Dim Index As Integer = 0
		For i As Integer = 1 To grdServicios(0).Rows - 1
			grdServicios(Index).Col = 0
			grdServicios(Index).Row = i
			grdServicios(Index).CtlText = Conversion.Str(grdServicios(Index).Row)
			grdServicios(Index).Picture = picVisto(1).Image
		Next i
		grdServicios(1).Rows = 2
		grdServicios(1).Cols = 2
		grdServicios(1).Row = 0
		grdServicios(1).Col = 1
		grdServicios(1).CtlText = ""
		grdServicios(1).Row = 1
		grdServicios(1).Col = 0
		grdServicios(1).CtlText = ""
		grdServicios(1).Row = 1
		grdServicios(1).Col = 1
		grdServicios(1).CtlText = ""
		grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
		Select Case cmbPerso.Text
			Case "CTA CORRIENTE", "CTA AHORROS"
				lblEtiqueta(2).Visible = True
				lblDescripcion(0).Visible = True
				lblEtiqueta(2).Text = "Nro. Cuenta:"
				mskCuenta.Visible = True
				txtCampo(1).Visible = False
				txtCampo(2).Visible = False
				txtCampo(1).Text = ""
				txtCampo(2).Text = ""
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				mskCuenta_Enter(mskCuenta, New EventArgs())
				lblDescripcion(0).Text = ""
				If mskCuenta.Visible Then mskCuenta.Focus()
			Case "CLIENTE"
				lblEtiqueta(2).Visible = True
				lblDescripcion(0).Visible = True
				lblEtiqueta(2).Text = "Código Cliente:"
				mskCuenta.Visible = False
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				lblDescripcion(0).Text = ""
				txtCampo(1).Text = ""
				txtCampo(1).Visible = False
				txtCampo(2).Text = ""
				txtCampo(2).Visible = True
				txtCampo(2).Focus()
			Case "OFICINA"
				lblEtiqueta(2).Visible = True
				lblDescripcion(0).Visible = True
				lblEtiqueta(2).Text = "Código Oficina:"
				mskCuenta.Visible = False
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				lblDescripcion(0).Text = ""
				txtCampo(1).Text = ""
				txtCampo(1).Visible = True
				txtCampo(2).Text = ""
				txtCampo(2).Visible = False
				txtCampo(1).Focus()
		End Select
	End Sub

	Private Sub cmbPerso_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbPerso.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1771))
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_5.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				VLAProbar = "S"
				PLTransmitir()
			Case 5
				VLAProbar = "N"
				PLTransmitir()
			Case 1
				cmbPerso.Items.Clear()
				cmbPerso.Items.Insert(0, "CTA CORRIENTE")
				cmbPerso.Items.Insert(1, "CTA AHORROS")
				cmbPerso.Items.Insert(2, "CLIENTE")
				cmbPerso.Items.Insert(3, "OFICINA")
				cmbPerso.SelectedIndex = 0
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				mskCuenta_Enter(mskCuenta, New EventArgs())
				For i As Integer = 0 To 3
					lblDescripcion(i).Text = ""
				Next i
				mskFecha.Text = StringsHelper.Format(VLFecha, VLFormatoFecha)
				For i As Integer = 0 To 2
					txtCampo(i).Text = ""
				Next i
				For i As Integer = 0 To 1
					grdServicios(i).Rows = 2
					grdServicios(i).Cols = 2
					grdServicios(i).Row = 0
					grdServicios(i).Col = 1
					grdServicios(i).CtlText = ""
					grdServicios(i).Row = 1
					grdServicios(i).Col = 0
					grdServicios(i).CtlText = ""
					grdServicios(i).Row = 1
					grdServicios(i).Col = 1
					grdServicios(i).CtlText = ""
					grdServicios(i).ColWidth(1) = grdServicios(i).ColWidth(0)
				Next i
				cmdBoton(0).Enabled = True
				txtCampo(0).Focus()
			Case 2
                'Me.Close() '19/05/2016 migracion
                Me.Dispose()
                'FBuscarCliente.Close() '19/05/2016 migracion
                FBuscarCliente.Dispose()
			Case 3
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1288), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1431), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskFecha.Focus()
					Exit Sub
				End If
				If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
                    COBISMessageBox.Show(FMLoadResString(1226), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" And cmbPerso.Text = "OFICINA" Then
                    COBISMessageBox.Show(FMLoadResString(1222), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" And cmbPerso.Text = "CLIENTE" Then
                    COBISMessageBox.Show(FMLoadResString(1223), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4091")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
				PMPasoValores(sqlconn, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy"))
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(3).Text)
				PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCampo(2).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_especiales", True, FMLoadResString(1549)) Then
                    PMMapeaGrid(sqlconn, grdServicios(1), False)
                    PMMapeaTextoGrid(grdServicios(1))
                    PMChequea(sqlconn)
                    grdServicios(1).Col = 0
                    grdServicios(1).Row = 1
                    grdServicios(1).Picture = picVisto(1).Image
                Else
                    PMChequea(sqlconn)
                End If
				grdServicios(1).ColWidth(1) = 1300
				grdServicios(1).ColWidth(8) = 1800
				grdServicios(1).ColWidth(6) = 1500
				grdServicios(1).ColWidth(7) = 1500
				For i As Integer = 12 To 18
					grdServicios(1).ColWidth(CShort(i)) = 1
				Next i
			Case 4
				PLImprimir()
		End Select
	End Sub

	Private Sub PLImprimir()
		Dim VTPrint As String = "N"
		grdServicios(0).Row = 1
		grdServicios(0).Col = 1
		If grdServicios(0).CtlText <> "" Then
			VTPrint = "S"
			Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Courier New"
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 0
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 0
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 14
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("                             " & VGBanco)
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("             REPORTE DE COSTOS ESPECIALES PERSONALIZADOS")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 12
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   FECHA IMPRESION: " & VGFecha)
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   COSTOS GENERALES")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 7
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   ______________________________________________________________________________________________________________________________")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("     F. Vigencia   Estado     Descripción                               Tipo  Desde           Hasta                Valor Costo")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   ______________________________________________________________________________________________________________________________")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
			Y = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY
			For j As Integer = 1 To grdServicios(0).Rows - 1
				Y += 150
				grdServicios(0).Row = j
				grdServicios(0).Col = 1
				For i As Integer = 1 To grdServicios(0).Cols - 1
					Select Case i
						Case 1
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 400
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 2
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 1600
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 11
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 2500
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 10
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6200
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 5
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6500
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 6
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8000
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 7
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9700
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
					End Select
					Select Case i
						Case 1, 2, 5, 6, 7, 10, 11
							grdServicios(0).Col = i
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(grdServicios(0).CtlText)
					End Select
				Next i
			Next j
		End If
		grdServicios(1).Row = 1
		grdServicios(1).Col = 1
		If grdServicios(1).CtlText <> "" Then
			VTPrint = "S"
			Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Courier New"
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 12
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   COSTOS PERSONALIZADOS")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			If mskCuenta.ClipText <> "" Then
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("    Cuenta: " & mskCuenta.Text & " " & lblDescripcion(0).Text)
			End If
			If txtCampo(1).Text <> "" Then
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("    Oficina: " & txtCampo(1).Text & " " & lblDescripcion(0).Text)
			End If
			If txtCampo(2).Text <> "" Then
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("    Cliente: " & txtCampo(2).Text & " " & lblDescripcion(0).Text)
			End If
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 7
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   ______________________________________________________________________________________________________________________________")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("     F. Vigencia   Tipo Costo       Descripción                 Tipo    Desde            Hasta                  Valor Costo")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   ______________________________________________________________________________________________________________________________")
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
			Y = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY
			For j As Integer = 1 To grdServicios(1).Rows - 1
				Y += 150
				grdServicios(1).Row = j
				grdServicios(1).Col = 1
				For i As Integer = 1 To grdServicios(1).Cols - 1
					Select Case i
						Case 1
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 400
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 2
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 1600
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 4
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 3000
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 5
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5500
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 6
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6000
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 7
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 7500
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
						Case 8
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9500
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
					End Select
					Select Case i
						Case 1, 2, 4, 5, 6, 7, 8
							grdServicios(1).Col = i
							COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(grdServicios(1).CtlText)
					End Select
				Next i
			Next j
		End If
		If VTPrint = "S" Then
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
			Me.Cursor = System.Windows.Forms.Cursors.Default
			Me.Cursor = System.Windows.Forms.Cursors.Default
		End If
	End Sub

	Private Sub FManteEspecial_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
         PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMBotonSeguridad(Me, 3)
		cmbPerso.Items.Clear()
		cmbPerso.Items.Insert(0, "CTA CORRIENTE")
		cmbPerso.Items.Insert(1, "CTA AHORROS")
		cmbPerso.Items.Insert(2, "CLIENTE")
		cmbPerso.Items.Insert(3, "OFICINA")
		cmbPerso.SelectedIndex = 0
        VLFormatoFecha = VGFormatoFecha
		mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        VLFecha = FMConvFecha(VGFecha, "mm/dd/yyyy", VGFormatoFecha)
		mskFecha.Text = VLFecha
          PLTSEstado()
	End Sub

	Private Sub FManteEspecial_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub PMMarcarRegistro(ByRef Index As Integer)
		grdServicios(Index).Col = 0
		If grdServicios(Index).CtlText <> "X" Then
			grdServicios(Index).CtlText = "X"
			grdServicios(Index).Picture = picVisto(0).Image
		Else
			If grdServicios(Index).CtlText = "X" Then
				grdServicios(Index).CtlText = Conversion.Str(grdServicios(Index).Row)
				grdServicios(Index).Picture = picVisto(1).Image
			End If
		End If
	End Sub

	Private Sub grdServicios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles _grdServicios_1.DblClick, _grdServicios_0.DblClick
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		Dim VTRow As Integer = grdServicios(Index).Row
		grdServicios(Index).Row = 1
		grdServicios(Index).Col = 1
		If grdServicios(Index).CtlText <> "" Then
			grdServicios(Index).Row = VTRow
			Select Case Index
				Case 0, 1
					If Conversion.Val(Convert.ToString(grdServicios(Index).Tag)) > 0 Then
						cmdBoton(0).Enabled = True
						PMMarcarRegistro(Index)
					End If
			End Select
		End If
    End Sub

    Private Sub grdServicios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_0.Enter, _grdServicios_1.Enter
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1875))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1876))
        End Select
    End Sub

	Private Sub grdServicios_KeyUpEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyUpEvent) Handles _grdServicios_1.KeyUpEvent, _grdServicios_0.KeyUpEvent
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		Select Case Index
			Case 0, 1
				grdServicios(Index).Col = 0
				grdServicios(Index).SelStartCol = 1
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

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
		If cmbPerso.Text <> "" Then
			If cmbPerso.Text = "CTA CORRIENTE" Then
				mskCuenta.Mask = VGMascaraCtaCte
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1527))
			Else
				mskCuenta.Mask = VGMascaraCtaAho
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1528))
			End If
		End If
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim  VTR1 As Integer = 0
        Dim VTArreglo() As String
		Try 
			If cmbPerso.Text <> "CTA CORRIENTE" And cmbPerso.Text <> "CTA AHORROS" Then
                COBISMessageBox.Show(FMLoadResString(1289), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				cmbPerso.Focus()
				Exit Sub
			End If
			If mskCuenta.ClipText <> "" Then
				If cmbPerso.Text = "CTA CORRIENTE" Then
					If FMChequeaCtaCte(mskCuenta.ClipText) Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
						PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1590)) Then
                            ReDim VTArreglo(10)
                            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            If VTR1 <> 0 Then
                                lblDescripcion(0).Text = VTArreglo(1)
                            Else
                                COBISMessageBox.Show(FMLoadResString(1323), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1278), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						lblDescripcion(0).Text = ""
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
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1590)) Then
                            ReDim VTArreglo(10)
                            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            If VTR1 <> 0 Then
                                lblDescripcion(0).Text = VTArreglo(1)
                            Else
                                COBISMessageBox.Show(FMLoadResString(1323), FMLoadResString(1473), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1279), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						lblDescripcion(0).Text = ""
						mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
						mskCuenta.Focus()
						VLPaso = True
						Exit Sub
					End If
				End If
			End If
		Catch exc As System.Exception
			NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
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
				mskFecha.Focus()
				Exit Sub
			End If
			PMBuscarServicio()
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1165))
			Case 1
				VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1155))
			Case 2
				VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1159))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1690))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		VLPaso = False
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            Select Case Index
                Case 0
                    VGForma = "FManteEspecial"
                    FAyudaSubserv2.ShowPopup(Me)
                    If VGDetalle(1) <> "" Then
                        PMSubserv()
                        VLPaso = True
                    End If
                    FAyudaSubserv2.Dispose() '18/05/2016 migracion
                Case 1
                    VGOperacion = "sp_oficina"
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1109) & "[" & txtCampo(0).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                    End If
                    VLPaso = True
                Case 2
                    FBuscarCliente.optCliente(0).Checked = True
                    FBuscarCliente.ShowPopup(Me)
                    FBuscarCliente.optCliente(1).Enabled = True
                    If VGBusqueda(1) <> "" Then
                        txtCampo(2).Text = VGBusqueda(1)
                        lblDescripcion(0).Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                    End If
                    FBuscarCliente.Dispose() '18/05/2016 migracion
                    VLPaso = True
                Case 3
                    PMCatalogo("A", "pe_rubro", txtCampo(3), lblDescripcion(2), FRegistros)
                    VLPaso = True
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
			KeyAscii = 0
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If Not VLPaso Then
			Select Case Index
				Case 0
					If Not VLPaso Then
						If txtCampo(0).Text <> "" Then
							VGForma = "FManteEspecial"
							FAyudaSubserv2.ShowPopup(Me)
							If VGDetalle(1) <> "" Then
								PMSubserv()
							Else
								If lblDescripcion(2).Text = "" Then
									txtCampo(0).Text = ""
									txtCampo(0).Focus()
									VLPaso = True
								End If
							End If
							FAyudaSubserv2.Dispose() '18/05/2016 migracion
						Else
							VLPaso = True
							lblDescripcion(1).Text = ""
							lblDescripcion(2).Text = ""
							lblDescripcion(3).Text = ""
						End If
					End If
				Case 1
					If txtCampo(1).Text <> "" Then
						PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1109) & "[" & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
                        End If
					Else
						lblDescripcion(0).Text = ""
					End If
				Case 2
					If txtCampo(2).Text <> "" Then
						Dim VTArreglo(7) As String
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1190")
						PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(2).Text)
						If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_qrente", False, "") Then
                            FMMapeaArreglo(sqlconn, VTArreglo)
							PMChequea(sqlconn)
							lblDescripcion(0).Text = VTArreglo(1)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
						End If
					End If
				Case 3
					If Not VLPaso Then
						If txtCampo(3).Text <> "" Then
                            PMCatalogo("V", "pe_rubro", txtCampo(3), lblDescripcion(2), Nothing)
						Else
							lblDescripcion(2).Text = ""
						End If
					End If
            End Select
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
		End If
	End Sub

	Private Sub PMSubserv()
		If VGDetalle(0) = "S" Then
			If txtCampo(0).Text = "" Then
				lblDescripcion(1).Text = VGDetalle(1)
				lblDescripcion(2).Text = VGDetalle(2)
				txtCampo(0).Text = VGDetalle(3)
				lblDescripcion(3).Text = VGDetalle(4)
			Else
				lblDescripcion(1).Text = VGDetalle(1)
				lblDescripcion(2).Text = VGDetalle(2)
				lblDescripcion(3).Text = VGDetalle(3)
			End If
			PMBuscarServicio()
		End If
	End Sub

	Sub PMBuscarServicio()
		grdServicios(0).Col = 0
		grdServicios(0).Row = 1
		grdServicios(0).Picture = picVisto(1).Image
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4091")
		PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, lblDescripcion(3).Text)
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
		PMPasoValores(sqlconn, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy"))
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_especiales", True, FMLoadResString(1552)) Then
            PMMapeaGrid(sqlconn, grdServicios(0), False)
            PMMapeaTextoGrid(grdServicios(0))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
		grdServicios(0).Row = 1
		grdServicios(0).ColWidth(1) = 1300
		grdServicios(0).ColWidth(11) = 3500
		grdServicios(0).ColWidth(5) = 1500
		grdServicios(0).ColWidth(6) = 1500
		For i As Integer = 13 To 16
			grdServicios(0).ColWidth(CShort(i)) = 1
		Next i
	End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBAprobar.Enabled = _cmdBoton_0.Enabled
        TSBAprobar.Visible = _cmdBoton_0.Visible
        TSBEliminar.Enabled = _cmdBoton_5.Enabled
        TSBEliminar.Visible = _cmdBoton_5.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBAprobar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAprobar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdServicios_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_0.Leave, _grdServicios_1.Leave
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        End Select
    End Sub
    Private Sub grdServicios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_1.ClickEvent, _grdServicios_0.ClickEvent
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
        Select Case Index
            Case 0, 1
                grdServicios(Index).Col = 0
                grdServicios(Index).SelStartCol = 1
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
End Class


