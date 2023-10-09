Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class Ftran302Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Dim VLPaso As Integer = 0
	Dim VLUltLinea As Integer = 0
    Dim VLSec As String = System.String.Empty
    Dim VLAlt As String = System.String.Empty

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_5.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
            Case 1
                TSBotones.Focus()
                PLSiguientes()
            Case 2
                TSBotones.Focus()
                PLTransmitir()
			Case 3
				Me.Close()
			Case 4
				PLLimpiar()
            Case 5
                TSBotones.Focus()
                PLImprimir()
        End Select
	End Sub

	Private Sub Ftran302_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
	End Sub
    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = System.String.Empty
        ' txtcampo(3).Connection = VGMap
        ' txtcampo(3).AsociatedLabel = lbletiqueta(3).Text
        VLPaso = True
        txtcampo(0).Text = StringsHelper.Format(txtcampo(0).Text, "#,##0.00")
    End Sub
	Private Sub grdOperaciones_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdOperaciones.Click
        Dim VTTipoDato As String = System.String.Empty
		Dim VTCol As Integer = grdOperaciones.Col
		Dim VTFil As Integer = grdOperaciones.Row
		grdOperaciones.Col = 0
		grdOperaciones.SelStartCol = 1
		grdOperaciones.SelEndCol = grdOperaciones.Cols - 1
		If grdOperaciones.Row = 0 Then
			grdOperaciones.SelStartRow = 1
			grdOperaciones.SelEndRow = 1
		Else
			grdOperaciones.SelStartRow = grdOperaciones.Row
			grdOperaciones.SelEndRow = grdOperaciones.Row
			If VTFil <= grdOperaciones.TopRow Then
				Select Case VTCol
					Case 1
						VTTipoDato = "N"
					Case 2
						VTTipoDato = "A"
					Case 3
						VTTipoDato = "A"
					Case 4
						VTTipoDato = "N"
					Case 5
						VTTipoDato = "A"
					Case 6
						VTTipoDato = "A"
					Case 7
						VTTipoDato = "M"
					Case 8
						VTTipoDato = "A"
					Case 9
						VTTipoDato = "A"
					Case 10
						VTTipoDato = "D"
					Case 11
						VTTipoDato = "N"
					Case 12
						VTTipoDato = "N"
				End Select
				PMOrdenaGrid(grdOperaciones, VTTipoDato, VTCol, "A")
				grdOperaciones.Col = VTCol
				grdOperaciones.Row = VTFil
			End If
		End If
    End Sub

    Private Sub grdOperaciones_ClickEvent(sender As Object, e As EventArgs) Handles grdOperaciones.ClickEvent
        PMMarcaFilaCobisGrid(grdOperaciones, grdOperaciones.Row)
    End Sub

	Private Sub grdOperaciones_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdOperaciones.DblClick
        Dim VTTipoDato As String = System.String.Empty
		Dim VTCol As Integer = grdOperaciones.Col
		Dim VTFil As Integer = grdOperaciones.Row
		If VTFil <= grdOperaciones.TopRow Then
			Select Case VTCol
				Case 1
					VTTipoDato = "A"
				Case 2
					VTTipoDato = "A"
				Case 3
					VTTipoDato = "A"
				Case 4
					VTTipoDato = "N"
				Case 5
					VTTipoDato = "A"
				Case 6
					VTTipoDato = "A"
				Case 7
					VTTipoDato = "M"
				Case 8
					VTTipoDato = "A"
				Case 9
					VTTipoDato = "A"
				Case 10
					VTTipoDato = "D"
				Case 11
					VTTipoDato = "N"
				Case 12
					VTTipoDato = "N"
			End Select
            PMOrdenaGrid(grdOperaciones, VTTipoDato, VTCol, "D")

		End If
	End Sub

	Private Sub PLEliminarDup()
		Dim VTSec As String = string.Empty
		Dim  VTAlt As String = string.Empty
		Dim VTLinea As Integer = VLUltLinea
		Do 
			If grdOperaciones.Rows - 1 >= VLUltLinea + 1 Then
				grdOperaciones.Row = VLUltLinea + 1
			Else
				Exit Do
			End If
			grdOperaciones.Col = 11
			VTSec = grdOperaciones.CtlText
			grdOperaciones.Col = 12
			VTAlt = grdOperaciones.CtlText
			If VLSec = VTSec And VLAlt >= VTAlt Then
				grdOperaciones.RemoveItem(CShort(VLUltLinea + 1))
			Else
				VLUltLinea += 1
			End If
		Loop Until VLSec <> VTSec
		grdOperaciones.Col = 0
		grdOperaciones.Row = VTLinea
		For i As Integer = grdOperaciones.Row To grdOperaciones.Rows - 1
			grdOperaciones.Row = i
			grdOperaciones.CtlText = CStr(grdOperaciones.Row)
		Next i
	End Sub

	Private Sub PLImprimir()
		Dim VTInicio As Integer = 0
		Dim  VTFin As Integer = 0
        Dim Linea As String = System.String.Empty
        Dim VTResp As DialogResult = COBISMessageBox.Show(FMLoadResString(500396), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNoCancel)
        If VTResp = System.Windows.Forms.DialogResult.No Or VTResp = System.Windows.Forms.DialogResult.Cancel Then
            Exit Sub
        End If
		Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Orientation = 2
        FMCabeceraReporte(VGBanco, FMConvFecha(DateTimeHelper.ToString(DateTime.Today), "mm/dd/yyyy", VGFormatoFecha), FMLoadResString(5088732) & " " & txtcampo(0).Text & " " & FMLoadResString(5088733), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Page))

        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(5088734), VGMoneda)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 6.5
		COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(5088735) & "       " & FMLoadResString(502473) & "                           " & FMLoadResString(5088736) & "              " & FMLoadResString(508884) & "   " & FMLoadResString(5088737) & "            " & FMLoadResString(9028) & "           " & FMLoadResString(5088738) & "            " & FMLoadResString(9948) & "         " & FMLoadResString(9003) & "        " & FMLoadResString(5088739) & "     " & FMLoadResString(5088740))
		COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
		COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
		Dim cont As Integer = 1
		If VTResp = System.Windows.Forms.DialogResult.Yes Then
			VTInicio = grdOperaciones.TopRow
            If grdOperaciones.TopRow + 30 > grdOperaciones.Rows - 1 Then
                VTFin = grdOperaciones.Rows - 1
            Else
                VTFin = grdOperaciones.TopRow + 30
            End If
		End If
		If VTResp = System.Windows.Forms.DialogResult.No Then
			VTInicio = 1
			VTFin = grdOperaciones.Rows - 1
		End If
		For j As Integer = VTInicio To VTFin
			grdOperaciones.Row = j
			grdOperaciones.Col = 1
			Linea = grdOperaciones.CtlText
			Linea = Linea & New String(" "c, 15 - Strings.Len(grdOperaciones.CtlText))
			grdOperaciones.Col = 2
			grdOperaciones.CtlText = Strings.Left(grdOperaciones.CtlText, 35)
			Linea = Linea & grdOperaciones.CtlText
			Linea = Linea & New String(" "c, 35 - Strings.Len(grdOperaciones.CtlText))
			grdOperaciones.Col = 3
			grdOperaciones.CtlText = Strings.Left(grdOperaciones.CtlText, 19)
			Linea = Linea & grdOperaciones.CtlText
			Linea = Linea & New String(" "c, 20 - Strings.Len(grdOperaciones.CtlText))
			grdOperaciones.Col = 4
			Linea = Linea & New String(" "c, 6 - Strings.Len(grdOperaciones.CtlText)) & grdOperaciones.CtlText & " "
			grdOperaciones.Col = 5
			Linea = Linea & New String(" "c, 6 - Strings.Len(grdOperaciones.CtlText)) & grdOperaciones.CtlText & " "
			grdOperaciones.Col = 6
			Linea = Linea & " " & grdOperaciones.CtlText & " "
			grdOperaciones.Col = 7
			Linea = Linea & New String(" "c, 21 - Strings.Len(grdOperaciones.CtlText)) & grdOperaciones.CtlText & " "
			grdOperaciones.Col = 8
			grdOperaciones.CtlText = Strings.Left(grdOperaciones.CtlText, 25)
			Linea = Linea & grdOperaciones.CtlText
			Linea = Linea & New String(" "c, 26 - Strings.Len(grdOperaciones.CtlText))
			grdOperaciones.Col = 9
			grdOperaciones.CtlText = Strings.Left(grdOperaciones._Text, 15)
			Linea = Linea & grdOperaciones.CtlText
			Linea = Linea & New String(" "c, 16 - Strings.Len(grdOperaciones.CtlText))
			grdOperaciones.Col = 10
			Linea = Linea & grdOperaciones.CtlText
			Linea = Linea & New String(" "c, 6 - Strings.Len(grdOperaciones.CtlText))
			grdOperaciones.Col = 11
			Linea = Linea & New String(" "c, 10 - Strings.Len(grdOperaciones.CtlText)) & grdOperaciones.CtlText & " "
			grdOperaciones.Col = 12
			Linea = Linea & New String(" "c, 4 - Strings.Len(grdOperaciones.CtlText)) & grdOperaciones.CtlText & " "
			COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
			cont += 1
			If cont = 50 Then
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
				cont = 1
                FMCabeceraReporte(VGBanco, DateTimeHelper.ToString(DateTime.Today), FMLoadResString(5088732) & txtcampo(0).Text & FMLoadResString(5088733), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Page))
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(5088734) & " ", VGMoneda)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 6.5
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(5088735) & "       " & FMLoadResString(502473) & "                           " & FMLoadResString(5088736) & "              " & FMLoadResString(508884) & "   " & FMLoadResString(5088737) & "            " & FMLoadResString(9028) & "           " & FMLoadResString(5088738) & "            " & FMLoadResString(9948) & "         " & FMLoadResString(9003) & "        " & FMLoadResString(5088739) & "     " & FMLoadResString(5088740))
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
				COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
			End If
		Next j
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
		COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(" _________________                                                 _________________")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("   " & FMLoadResString(5088741) & "                                                     " & FMLoadResString(5088742))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(System.String.Empty)
		If VGCodPais <> "CO" Then
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(5088743))
		End If
		COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
		Me.Cursor = System.Windows.Forms.Cursors.Default
	End Sub

	Private Sub PLLimpiar()
		PMLimpiaGrid(grdOperaciones)
		grdOperaciones.ColWidth(1) = 650
		cmdBoton(1).Enabled = False
		cmdBoton(5).Enabled = False
        txtcampo(3).Text = System.String.Empty
        lbletiqueta(3).Text = System.String.Empty
        lbletiqueta(6).Text = System.String.Empty
        lbletiqueta(7).Text = System.String.Empty
        txtcampo(1).Text = System.String.Empty
        txtcampo(2).Text = System.String.Empty
		txtcampo(0).Enabled = True
        txtcampo(0).Text = StringsHelper.Format("0.00", "#,###0.00")
        PLTSEstado()
	End Sub

	Private Sub PLSiguientes()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "302")
		PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, txtcampo(0).Text)
		PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
		VLUltLinea = grdOperaciones.Rows - 1
		PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VLSec)
		PMPasoValores(sqlconn, "@i_cod_alterno", 0, SQLINT4, VLAlt)
		PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
        If txtcampo(3).Text <> System.String.Empty Then
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtcampo(3).Text)
        End If
        If txtcampo(1).Text <> System.String.Empty Then
            PMPasoValores(sqlconn, "@i_territorial", 0, SQLINT4, txtcampo(1).Text)
        End If
        If txtcampo(2).Text <> System.String.Empty Then
            PMPasoValores(sqlconn, "@i_zona", 0, SQLINT4, txtcampo(2).Text)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ahop_superiores_a", True, FMLoadResString(508832)) Then
            PMMapeaGrid(sqlconn, grdOperaciones, True)
            PMChequea(sqlconn)
            PLEliminarDup()
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdOperaciones.Tag)) = 21
            grdOperaciones.Row = grdOperaciones.Rows - 1
            grdOperaciones.Col = 11
            VLSec = grdOperaciones.CtlText
            grdOperaciones.Col = 12
            VLAlt = grdOperaciones.CtlText
            PMAnchoColumnasGrid(grdOperaciones)
            PLTSEstado()
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private Sub PLTransmitir()
        If txtcampo(1).Text = System.String.Empty And txtcampo(2).Text = System.String.Empty And txtcampo(3).Text = System.String.Empty Then
            COBISMessageBox.Show(FMLoadResString(508520), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtcampo(1).Focus()
            Exit Sub
        End If
        If CDbl(txtcampo(0).Text) <= 0 Then
            COBISMessageBox.Show(FMLoadResString(500397), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtcampo(0).Focus()
            Exit Sub
        End If
        If CDbl(txtcampo(0).Text) > CDbl(99999999999999.9) Then
            COBISMessageBox.Show(FMLoadResString(501098), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) ' Valor Excede maximo permitido
            txtcampo(0).Focus()
            Exit Sub
        End If

		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "302")
        PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, CDbl(txtcampo(0).Text))
		PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
		PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
        If txtcampo(3).Text <> System.String.Empty Then
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtcampo(3).Text)
        End If
        If txtcampo(1).Text <> System.String.Empty Then
            PMPasoValores(sqlconn, "@i_territorial", 0, SQLINT4, txtcampo(1).Text)
        End If
        If txtcampo(2).Text <> System.String.Empty Then
            PMPasoValores(sqlconn, "@i_zona", 0, SQLINT4, txtcampo(2).Text)
        End If
        cmdBoton(5).Enabled = False
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ahop_superiores_a", True, FMLoadResString(508823)) Then
            PMMapeaGrid(sqlconn, grdOperaciones, False)
            PMChequea(sqlconn)
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdOperaciones.Tag)) = 20
            If Conversion.Val(Convert.ToString(grdOperaciones.Tag)) >= 1 Then
                cmdBoton(5).Enabled = True
            End If
            txtcampo(0).Enabled = False
            grdOperaciones.Row = grdOperaciones.Rows - 1
            grdOperaciones.Col = 11
            VLSec = grdOperaciones.CtlText
            grdOperaciones.Col = 12
            VLAlt = grdOperaciones.CtlText
            PMAnchoColumnasGrid(grdOperaciones)
            PLTSEstado()
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private isInitializingComponent As Boolean = false

    Private Sub txtcampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtcampo_3.TextChanged, _txtcampo_2.TextChanged, _txtcampo_1.TextChanged, _txtcampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                VLPaso = False
        End Select
    End Sub

    Private Sub txtcampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtcampo_3.Enter, _txtcampo_2.Enter, _txtcampo_1.Enter, _txtcampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509075))
                txtcampo(0).SelectionStart = 0
                txtcampo(0).SelectionLength = Strings.Len(txtcampo(0).Text)
                txtcampo(0).Text = StringsHelper.Format(txtcampo(0).Text, "#,###0.00")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509072))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509073))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509074))
        End Select
    End Sub

    Private Sub txtcampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtcampo_3.KeyPress, _txtcampo_2.KeyPress, _txtcampo_1.KeyPress, _txtcampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtcampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtcampo_3.Leave, _txtcampo_2.Leave, _txtcampo_1.Leave, _txtcampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 0
                If txtcampo(0).Text <> System.String.Empty Then
                    txtcampo(0).Text = StringsHelper.Format(txtcampo(0).Text, "#,###0.00")
                Else
                    txtcampo(0).Text = StringsHelper.Format("0.00", "#,###0.00")
                End If
                cmdBoton(2).Enabled = True
            Case 1
                If Not VLPaso Then
                    If txtcampo(1).Text <> System.String.Empty Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "VS")
                        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "R")
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtcampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(508826)) Then
                            PMMapeaObjeto(sqlconn, lbletiqueta(6).Text)
                            PMChequea(sqlconn)
                            If Trim(lbletiqueta(6).Text) = System.String.Empty Then
                                COBISMessageBox.Show(FMLoadResString(509034), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                lbletiqueta(6).Text = System.String.Empty
                                txtcampo(1).Text = System.String.Empty
                                If txtcampo(1).Enabled Then
                                    txtcampo(1).Focus()
                                End If
                                Exit Sub
                            End If
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtcampo(1).Text = System.String.Empty
                            lbletiqueta(6).Text = System.String.Empty
                            If txtcampo(1).Enabled Then
                                txtcampo(1).Focus()
                            End If
                        End If
                    Else
                        lbletiqueta(6).Text = System.String.Empty
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtcampo(2).Text <> System.String.Empty Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "VS")
                        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "Z")
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtcampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(508841)) Then
                            PMMapeaObjeto(sqlconn, lbletiqueta(7).Text)
                            PMChequea(sqlconn)
                            If Trim(lbletiqueta(7).Text) = System.String.Empty Then
                                COBISMessageBox.Show(FMLoadResString(509034), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                lbletiqueta(7).Text = System.String.Empty
                                txtcampo(2).Text = System.String.Empty
                                If txtcampo(2).Enabled Then
                                    txtcampo(2).Focus()
                                End If
                                Exit Sub
                            End If
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtcampo(2).Text = System.String.Empty
                            lbletiqueta(7).Text = System.String.Empty
                            If txtcampo(2).Enabled Then
                                txtcampo(2).Focus()
                            End If
                        End If
                    Else
                        lbletiqueta(7).Text = System.String.Empty
                    End If
                End If
            Case 3
                If Not VLPaso Then
                    If txtcampo(3).Text <> System.String.Empty Then
                        If CDbl(txtcampo(3).Text) >= 32000 Then
                            COBISMessageBox.Show(FMLoadResString(508623), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtcampo(3).Focus()
                            Exit Sub
                        End If
                        PMCatalogo("V", "cl_oficina", txtcampo(3), lbletiqueta(3))
                    Else
                        lbletiqueta(3).Text = ""
                        txtcampo(3).Clear()
                        'txtcampo(3).Focus()
                    End If
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub txtcampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtcampo_3.KeyDown, _txtcampo_2.KeyDown, _txtcampo_1.KeyDown, _txtcampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            Select Case Index
                Case 1
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(508826)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtcampo(1).Text = VGACatalogo.Codigo
                        lbletiqueta(6).Text = VGACatalogo.Descripcion
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn)
                        txtcampo(1).Text = System.String.Empty
                        lbletiqueta(6).Text = System.String.Empty
                        txtcampo(1).Focus()
                    End If
                Case 2
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "O")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(508841)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtcampo(2).Text = VGACatalogo.Codigo
                        lbletiqueta(7).Text = VGACatalogo.Descripcion
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn)
                        txtcampo(2).Text = System.String.Empty
                        lbletiqueta(7).Text = System.String.Empty
                        txtcampo(2).Focus()
                    End If
                Case 3
                    txtcampo(3).Text = ""
                    PMCatalogo("A", "cl_oficina", txtcampo(3), lbletiqueta(3))
                    VLPaso = False
            End Select
        End If
    End Sub

    Private Sub txtcampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtcampo_3.MouseDown, _txtcampo_2.MouseDown, _txtcampo_1.MouseDown, _txtcampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 0
                My.Computer.Clipboard.Clear()
                My.Computer.Clipboard.SetText(StringsHelper.Format("0.00", "#,##0.00"))
            Case 1, 2, 3
                My.Computer.Clipboard.Clear()
                My.Computer.Clipboard.SetText(" ")
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBImprimir.Enabled = _cmdBoton_5.Enabled
        TSBImprimir.Visible = _cmdBoton_5.Visible
        TSBSiguientes.Enabled = _cmdBoton_1.Enabled
        TSBSiguientes.Visible = _cmdBoton_1.Visible
        TSBBuscar.Enabled = _cmdBoton_2.Enabled
        TSBBuscar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub
End Class


