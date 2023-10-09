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
Imports COBISCorp.tCOBIS.PER.Cost
 Public  Partial  Class FProFinClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0
    Dim VTFinal As Integer = 0

    Dim VTProFinal As String = ""

    
    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim Response As String = ""
        Dim VTFilas As Integer = 0
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
        TSBotones.Focus()
        Select Case Index
            Case 0
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1268), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1426), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4008")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(0).Text)
                PMPasoValores(sqlconn, "@i_tipop", 0, SQLCHAR, lblDescripcion(1).Text)
                PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1601)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = True
                    cmdBoton_Click(cmdBoton(5), New EventArgs())
                    txtCampo(1).Text = ""
                    txtCampo(0).Text = ""
                    txtCampo(2).Text = ""
                    txtCampo(3).Text = ""
                    TSBCARACTERISTICAS.Enabled = True
                    For i As Integer = 0 To 5
                        lblDescripcion(i).Text = ""
                    Next i
                    txtCampo(1).Focus()
                Else
                    PMChequea(sqlconn)
                    txtCampo(1).Focus()
                End If

            Case 1
                txtCampo(1).Enabled = True
                txtCampo(1).Text = ""
                PLLimpiar()
                txtCampo(1).Focus()
                lblDescripcion(5).Text = ""
            Case 2
                Me.Close()
            Case 3
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)


                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1268), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                cmdBoton(4).Enabled = False
                Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1857) & (VTFinal) & "?", DgDef, FMLoadResString(1867)))


                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4010")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(0).Text)
                    PMPasoValores(sqlconn, "@i_tipop", 0, SQLCHAR, lblDescripcion(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1608)) Then
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = False
                        cmdBoton_Click(cmdBoton(5), New EventArgs())
                        txtCampo(0).Focus()
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Focus()
                    End If
                Else
                    Exit Sub
                End If
            Case 4
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1268), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                cmdBoton(3).Enabled = False
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4009")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(0).Text)
                PMPasoValores(sqlconn, "@i_tipop", 0, SQLCHAR, lblDescripcion(1).Text)
                PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1585)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    cmdBoton_Click(cmdBoton(5), New EventArgs())
                    txtCampo(0).Focus()
                Else
                    PMChequea(sqlconn)
                    txtCampo(0).Focus()
                End If
            Case 5
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTProFinal = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                        If VTProFinal = "0" Then
                            grdProductos.ColIsVisible(1) = True
                            PMMapeaGrid(sqlconn, grdProductos, False)

                        Else
                            PMMapeaGrid(sqlconn, grdProductos, True)

                        End If
                        PMMapeaTextoGrid(grdProductos)
                        PMAnchoColumnasGrid(grdProductos)
                        PMChequea(sqlconn)
                        VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                        grdProductos.Col = 1
                        grdProductos.Row = grdProductos.Rows - 1
                        VTProFinal = grdProductos.CtlText
                        txtCampo(1).Focus()
                    Else
                        PMChequea(sqlconn)
                        txtCampo(1).Focus()
                    End If
                End While
                grdProductos.ColIsVisible(1) = False
                grdProductos.ColIsVisible(10) = False
                grdProductos.ColIsVisible(11) = False
                grdProductos.Row = 1
        End Select
        PLTSEstado()
    End Sub

	Private Sub FProFin_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMObjetoSeguridad(cmdBoton(5))
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(4))
        PMObjetoSeguridad(cmdBoton(3))
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        _txtCampo_0.Enabled = False
        TSBCARACTERISTICAS.Enabled = False
        PLTSEstado()
        txtCampo(0).Enabled = True

	End Sub

	Private Sub FProFin_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdProductos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.ClickEvent
        grdProductos.Col = 2
        grdProductos.SelStartCol = 2
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
        End If
        grdProductos.Col = 1
        TextBox1.Text = grdProductos.CtlText
        TSBCARACTERISTICAS.Enabled = True

   


    End Sub

    Private Sub grdProductos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdProductos.DblClick
        Dim VTRow As Integer = grdProductos.Row

        grdProductos.Row = 1
        grdProductos.Col = 1
        If grdProductos.CtlText <> "" Then
            grdProductos.Row = VTRow
            PMMarcarRegistro()
        End If
        If (grdProductos.SelStartRow = grdProductos.SelEndRow) And grdProductos.CtlText <> "" Then
            grdProductos.Col = 1
            FCaracteristicas.VTProFinal = grdProductos.CtlText
            FCaracteristicas.VGSUCURSAL = _txtCampo_1.Text
            FCaracteristicas.ShowPopup(Me)
        End If

    End Sub

    Private Sub grdProductos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
    End Sub

    Private Sub PLLimpiar()
        txtCampo(0).Enabled = True
        txtCampo(2).Enabled = True
        txtCampo(3).Enabled = True
        txtCampo(0).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        For i As Integer = 0 To 4
            lblDescripcion(i).Text = ""
        Next i
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        PMObjetoSeguridad(cmdBoton(3))
        grdProductos.ColIsVisible(1) = True
        PMLimpiaGrid(grdProductos)
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False

        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

	Private Sub PMMarcarRegistro()
		PMObjetoSeguridad(cmdBoton(4))
		PMObjetoSeguridad(cmdBoton(3))
        'cmdBoton(0).Enabled = False
        grdProductos.Col = 1
        TextBox1.Text = grdProductos.CtlText
        grdProductos.Col = 3
		txtCampo(3).Text = grdProductos.CtlText
		grdProductos.Col = 4
		lblDescripcion(4).Text = grdProductos.CtlText
		grdProductos.Col = 5
		txtCampo(2).Text = grdProductos.CtlText
		grdProductos.Col = 6
		lblDescripcion(2).Text = grdProductos.CtlText
		grdProductos.Col = 7
		lblDescripcion(0).Text = grdProductos.CtlText
		grdProductos.Col = 9
        lblDescripcion(1).Text = grdProductos.CtlText
        grdProductos.Col = 10
        txtCampo(1).Text = grdProductos.CtlText
        grdProductos.Col = 11
        lblDescripcion(5).Text = grdProductos.CtlText
		If grdProductos.CtlText = "R" Then
			lblDescripcion(3).Text = "REGIONAL"
		End If
		grdProductos.Col = 2
        txtCampo(0).Text = grdProductos.CtlText
        grdProductos.Col = 1
        VTFinal = grdProductos.CtlText
		For i As Integer = 1 To 3
			txtCampo(i).Enabled = False
		Next i
		txtCampo(0).Focus()
        PLTSEstado()
      
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub _txtCampo_0_Layout(sender As Object, e As LayoutEventArgs) Handles _txtCampo_0.Layout

    End Sub

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_3.TextChanged, _txtCampo_2.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
            Case 1, 2, 3, 4
                VLPaso = False
        End Select
        If txtCampo(1).Text = "" Then
            _lblDescripcion_5.Text = ""
            txtCampo(2).Text = ""
            _lblDescripcion_0.Text = ""
            _lblDescripcion_2.Text = ""

        End If
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_3.Enter, _txtCampo_2.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1207))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1737))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1654))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1476))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_3.KeyDown, _txtCampo_2.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 1
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", False, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(1).Text = VGValores(1)
                            lblDescripcion(5).Text = VGValores(2)
                            txtCampo(2).Text = ""

                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(5).Text = ""
                            VGOperacion = ""
                            txtCampo(2).Text = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(1).Text = ""
                        lblDescripcion(5).Text = ""
                        VGOperacion = ""
                    End If
                Case 2
                    VGOperacion = "sp_promon"
                    VGTipo = "H"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4075")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1112)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(2).Text = VGValores(1)
                            lblDescripcion(0).Text = VGValores(2)
                            lblDescripcion(2).Text = VGValores(3)
                            lblDescripcion(1).Text = VGValores(4)
                            If VGValores(4) = "R" Then
                                lblDescripcion(3).Text = "REGIONAL"
                            End If
                            VLPaso = True
                            txtCampo(0).Focus()
                            For i As Integer = 1 To 10
                                VGValores(i) = ""
                            Next i
                            VLPaso = False
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                        VGTipo = ""
                    End If
                    VLPaso = True
                Case 3
                    VGOperacion = "sp_prodfin"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4012")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", False, "") Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(3).Text = VGValores(1)
                            lblDescripcion(4).Text = VGValores(2) & " " & VGValores(3)
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(3).Text = ""
                        lblDescripcion(4).Text = ""
                        VGOperacion = ""
                    End If

                Case 4

                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2467)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)

                    Else
                        PMChequea(sqlconn)

                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_3.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            Case 1, 2, 3, 4
                KeyAscii = FMValidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)

    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_3.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        If CDbl(txtCampo(1).Text) > 32000 Then
                            COBISMessageBox.Show(FMLoadResString(1263), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(5))
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
                            lblDescripcion(2).Text = ""
                            ' PLLimpiar()
                            VLPaso = True
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(1).Focus()
                            VLPaso = True
                            '  PLLimpiar()
                        End If
                    Else
                        lblDescripcion(5).Text = ""
                        lblDescripcion(0).Text = ""
                        lblDescripcion(2).Text = ""
                        txtCampo(2).Text = ""
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text <> "" Then
                        If txtCampo(2).Text <> "3" And txtCampo(2).Text <> "4" Then
                            COBISMessageBox.Show(FMLoadResString(1142), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(2).Text = ""
                            txtCampo(2).Focus()
                            Exit Sub
                        End If
                        VGOperacion = "sp_promon"
                        VGTipo = "Q"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4076")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1112)) Then
                            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            FRegistros.ShowPopup(Me)
                            If VGValores(1) <> "" Then
                                lblDescripcion(0).Text = VGValores(2)
                                lblDescripcion(2).Text = VGValores(3)
                                lblDescripcion(1).Text = VGValores(4)
                                If VGValores(4) = "R" Then
                                    lblDescripcion(3).Text = "REGIONAL"
                                End If
                            Else
                                If VGValores(1) = "" Then
                                    lblDescripcion(0).Text = ""
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(1).Text = ""
                                    lblDescripcion(3).Text = ""
                                    txtCampo(2).Text = ""
                                    txtCampo(2).Focus()
                                End If
                            End If
                            For i As Integer = 1 To 5
                                VGValores(i) = ""
                            Next i
                            FRegistros.Dispose()
                            VLPaso = True '18/05/2016 migracion
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
                            lblDescripcion(2).Text = ""
                            lblDescripcion(1).Text = ""
                            lblDescripcion(3).Text = ""
                            txtCampo(2).Focus()
                        End If
                    Else
                        lblDescripcion(0).Text = ""
                        lblDescripcion(2).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(3).Text = ""
                    End If
                    VGOperacion = ""
                    VGTipo = ""
                End If
            Case 3
                If Not VLPaso Then
                    If txtCampo(3).Text <> "" Then
                        If CDbl(txtCampo(3).Text) > 255 Then
                            COBISMessageBox.Show(FMLoadResString(1256), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Text = ""
                            txtCampo(3).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4045")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1112)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(4))
                            PMChequea(sqlconn)
                            VLPaso = True
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(4).Text = ""
                            txtCampo(3).Text = ""
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(4).Text = ""
                    End If
                End If
            Case 4
                '  If Not VLPaso Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2467)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                    PMChequea(sqlconn)
                    VLPaso = True
                Else
                    PMChequea(sqlconn) 'JSA
                    txtCampo(4).Text = ""
                    lblDescripcion(6).Text = ""
                    txtCampo(4).Focus()
                    VLPaso = True
                End If
                'End If


        End Select

    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_1.MouseDown, _txtCampo_0.MouseDown, _txtCampo_3.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1, 2, 3, 4


        End Select
    End Sub


    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_5.Enabled
        TSBBuscar.Visible = _cmdBoton_5.Visible
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBEliminar.Enabled = _cmdBoton_3.Enabled
        TSBEliminar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

 

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		
    End Sub

    Private Sub grdProductos_KeyUpEvent(sender As Object, e As Framework.UI.Components.GridEvents_KeyUpEvent) Handles grdProductos.KeyUpEvent
        grdProductos.Col = 2
        grdProductos.SelStartCol = 2
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
        End If
    End Sub

    Private Sub grdProductos_Leave(sender As Object, e As EventArgs) Handles grdProductos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

 

    Private Sub TextBox1_TextChanged(sender As Object, e As EventArgs)

    End Sub

    

    Private Sub TSBCARACTERISTICAS_Click(sender As Object, e As EventArgs) Handles TSBCARACTERISTICAS.Click
        FCaracteristicas.VTProFinal = TextBox1.Text
        FCaracteristicas.VGSUCURSAL = _txtCampo_1.Text
        FCaracteristicas.ShowPopup(Me)
    End Sub

    Private Sub grdProductos_Load(sender As Object, e As EventArgs) Handles grdProductos.Load

    End Sub

    Private Sub GroupBox1_Click(sender As Object, e As EventArgs) Handles GroupBox1.Click

    End Sub
End Class


