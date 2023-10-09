Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FPARAMDTNClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLTemp(4) As String
    Const MB_YESNO As Integer = 4
    Const MB_ICONQUESTION As Integer = 32
    Const IDYES As DialogResult = System.Windows.Forms.DialogResult.Yes
    Const MB_DEFBUTTON1 As Integer = 0
    Const IDNO As Integer = 7
    Const IDCANCEL As Integer = 2
    Dim DgDef As MsgBoxStyle
    Dim Response As DialogResult

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1
        Select Case Index
            Case 0
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508892), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text <> "" And txtCampo(1).Text <> "" And txtCampo(2).Text <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "389")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    PMPasoValores(sqlconn, "@i_codigo_dtn", 0, SQLCHAR, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                Else
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "388")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    If txtCampo(1).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                    End If
                    If txtCampo(2).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                    End If
                End If
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_parametro_dtn", True, FMLoadResString(508893)) Then
                    PMMapeaGrid(sqlconn, grdCodigos, False)
                    PMChequea(sqlconn)
                    _cmdBoton_1.Enabled = True
                    PLSeteaCabeceras()
                    grdCodigos.Row = grdCodigos.Rows - 1
                    grdCodigos.Col = 1

                    If grdCodigos.Rows <= 2 And grdCodigos.CtlText = "" Then
                        COBISMessageBox.Show(FMLoadResString(508894), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Exit Sub
                    Else
                        If grdCodigos.Rows >= 20 Then
                            cmdBoton(6).Enabled = True
                        End If
                    End If
                Else
                    PMChequea(sqlconn)
                End If
                PLModoInsertar(True)
                PLTSEstado()

            Case 6
                grdCodigos.Row = grdCodigos.Rows - 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "388")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                grdCodigos.Col = 6
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT4, grdCodigos.CtlText)
                grdCodigos.Col = 2
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, CStr(grdCodigos.Row + 1))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_parametro_dtn", True, FMLoadResString(508893)) Then
                    PMMapeaGrid(sqlconn, grdCodigos, True)
                    PMChequea(sqlconn)
                    If grdCodigos.Rows Mod 20 <> 0 Then
                        cmdBoton(6).Enabled = False
                    End If
                Else
                    PMChequea(sqlconn)
                End If

            Case 1
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508892), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508895), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501207), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508896), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "385")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_codigo_dtn", 0, SQLCHAR, txtCampo(3).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_parametro_dtn", True, FMLoadResString(508897)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                    PLLimpiar()
                Else
                    PMChequea(sqlconn)
                End If
            Case 2
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508892), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508895), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501207), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508896), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                Response = COBISMsgBox.MsgBox(FMLoadResString(508898), DgDef, FMLoadResString(502214))
                If Response = System.Windows.Forms.DialogResult.Yes Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "387")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, VLTemp(1))
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, VLTemp(2))
                    PMPasoValores(sqlconn, "@i_codigo_dtn", 0, SQLCHAR, VLTemp(3))
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_parametro_dtn", True, FMLoadResString(508899)) Then
                        PMChequea(sqlconn)
                        PLLimpiar()
                        PMLimpiaGrid(grdCodigos)
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    Exit Sub
                End If
            Case 3
                PLLimpiar()


                PMLimpiaG(grdCodigos)
                txtCampo(0).Focus()
            Case 4
                Me.Close()
            Case 5
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508892), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508895), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(501207, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508896), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "386")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, VLTemp(1))
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, VLTemp(2))
                PMPasoValores(sqlconn, "@i_codigo_dtn", 0, SQLCHAR, VLTemp(3))
                PMPasoValores(sqlconn, "@i_codigo_dtn_new", 0, SQLCHAR, txtCampo(3).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_parametro_dtn", True, FMLoadResString(508900)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                    PLLimpiar()
                Else
                    PMChequea(sqlconn)
                End If

        End Select
        PLTSEstado()
    End Sub

    Private Sub FPARAMDTN_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar() 'JSA
        txtCampo(0).Focus()
    End Sub

    Public Sub PLInicializar()
        PLModoInsertar(True)
        cmdBoton(6).Enabled = False
        cmdBoton(0).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub FPARAMDTN_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdCodigos_ClickEvent(sender As Object, e As EventArgs) Handles grdCodigos.ClickEvent
        PMMarcaFilaCobisGrid(grdCodigos, grdCodigos.Row)
    End Sub

    Private Sub grdCodigos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCodigos.DblClick
        PMMarcaFilaCobisGrid(grdCodigos, grdCodigos.Row)
        Dim VTRow As Integer = grdCodigos.Row
        grdCodigos.Row = 1
        grdCodigos.Col = 1
        If grdCodigos.CtlText.Trim() <> "" Then
            grdCodigos.Row = VTRow
            PLEscoger()
            PLModoInsertar(False)
            _cmdBoton_5.Enabled = True
            _cmdBoton_2.Enabled = True
            PLTSEstado()
        End If
    End Sub

    Private Sub grdCodigos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCodigos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508875))
    End Sub

    Private Sub PLSeteaCabeceras()
        grdCodigos.ColWidth(1) = 1000
        grdCodigos.ColWidth(2) = 1000
        grdCodigos.ColWidth(3) = 2000
        grdCodigos.ColWidth(4) = 1000
        grdCodigos.ColWidth(5) = 2000
        grdCodigos.ColWidth(6) = 1000
        grdCodigos.Row = 0
        grdCodigos.Col = 1
        grdCodigos.CtlText = FMLoadResString(509273)
        grdCodigos.Col = 2
        grdCodigos.CtlText = FMLoadResString(509274)
        grdCodigos.Col = 3
        grdCodigos.CtlText = FMLoadResString(509275)
        grdCodigos.Col = 4
        grdCodigos.CtlText = FMLoadResString(509276)
        grdCodigos.Col = 5
        grdCodigos.CtlText = FMLoadResString(509277)
        grdCodigos.Col = 6
        grdCodigos.CtlText = FMLoadResString(509278)
        grdCodigos.FixedAlignment(1) = 2
        grdCodigos.ColAlignment(1) = 2
        grdCodigos.FixedAlignment(2) = 2
        grdCodigos.ColAlignment(2) = 2
        grdCodigos.FixedAlignment(3) = 2
        grdCodigos.FixedAlignment(4) = 2
        grdCodigos.ColAlignment(4) = 2
        grdCodigos.FixedAlignment(5) = 2
        grdCodigos.FixedAlignment(6) = 2
        grdCodigos.ColAlignment(6) = 2
        grdCodigos.Refresh()
    End Sub

    Private Sub PLLimpiar()
        txtCampo(0).Text = ""
        lblDescripcion(0).Text = ""
        txtCampo(1).Text = ""
        lblDescripcion(1).Text = ""
        txtCampo(2).Text = ""
        lblDescripcion(2).Text = ""
        txtCampo(3).Text = ""
        PLModoInsertar(True)
        PLTSEstado()
    End Sub

    Private Sub PLModoInsertar(ByRef modo As Integer)
        txtCampo(0).Enabled = modo
        txtCampo(1).Enabled = modo
        txtCampo(2).Enabled = modo
        If modo Then
            cmdBoton(2).Enabled = Not modo
            cmdBoton(5).Enabled = Not modo

        Else
            cmdBoton(1).Enabled = modo
        End If
        PLTSEstado()
    End Sub

    Private Sub PLEscoger()
        grdCodigos.Col = 6
        txtCampo(0).Text = grdCodigos.CtlText
        VLTemp(0) = grdCodigos.CtlText
        txtCampo_Leave(txtCampo(0), New EventArgs())
        grdCodigos.Col = 2
        txtCampo(1).Text = grdCodigos.CtlText
        VLTemp(1) = grdCodigos.CtlText
        txtCampo_Leave(txtCampo(1), New EventArgs())
        grdCodigos.Col = 4
        txtCampo(2).Text = grdCodigos.CtlText
        VLTemp(2) = grdCodigos.CtlText
        txtCampo_Leave(txtCampo(2), New EventArgs())
        grdCodigos.Col = 1
        txtCampo(3).Text = grdCodigos.CtlText
        VLTemp(3) = grdCodigos.CtlText
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508866))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508867))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508868))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509273))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTProFinal As String = ""
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_hp_sucursal"
                    txtCampo(0).Text = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", False, "") Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        FRegistros.cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag)) = VGMaxRows
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Focus()
                    End If
                Case 1
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(508892), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    VTProFinal = "0"
                    VGOperacion = "sp_prodfin3"
                    txtCampo(1).Text = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(508824)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        FRegistros.cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag)) = VGMaxRows
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(1).Focus()
                    End If
                    PMChequea(sqlconn)
                Case 2
                    PMCatalogo("A", "pe_categoria", txtCampo(2), lblDescripcion(2))
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 3
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 2
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

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso Then
            Select Case Index
                Case 0
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    If txtCampo(0).Text.Trim() = "" Then
                        lblDescripcion(0).Text = ""
                        Exit Sub
                    End If
                    If CDbl(txtCampo(0).Text) >= 32000 Then
                        COBISMessageBox.Show(FMLoadResString(508623), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(508901)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        ' PLTSEstado()
                        _cmdBoton_0.Enabled = True
                        _cmdBoton_1.Enabled = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Focus()
                        _cmdBoton_0.Enabled = False
                        _cmdBoton_1.Enabled = False
                    End If
                Case 1
                    If txtCampo(1).Text.Trim() = "" Then
                        lblDescripcion(1).Text = ""
                        Exit Sub
                    End If
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(508892), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(508901)) Then
                        Dim VTArreglo(3) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblDescripcion(1).Text = VTArreglo(1)
                    Else
                        PMChequea(sqlconn)
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(1).Focus()
                    End If
                Case 2
                    If txtCampo(2).Text.Trim() = "" Then
                        lblDescripcion(2).Text = ""
                        Exit Sub
                    End If
                    PMCatalogo("V", "pe_categoria", txtCampo(2), lblDescripcion(2))
                    If txtCampo(2).Text.Trim() = "" And lblDescripcion(2).Text.Trim() = "" Then
                        txtCampo(2).Focus()
                    End If
            End Select

        End If
        PLTSEstado()
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_3.MouseDown, _txtCampo_2.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown

    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
        TSBActualizar.Enabled = _cmdBoton_5.Enabled
        TSBActualizar.Visible = _cmdBoton_5.Visible
        TSBSiguiente.Enabled = _cmdBoton_6.Enabled
        TSBSiguiente.Visible = _cmdBoton_6.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub grdCodigos_Leave(sender As Object, e As EventArgs) Handles grdCodigos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


