Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2810Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim MhTab1CurrentTab As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_14.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_6.Click, _cmdBoton_10.Click, _cmdBoton_9.Click, _cmdBoton_7.Click, _cmdBoton_8.Click, _cmdBoton_12.Click, _cmdBoton_16.Click, _cmdBoton_13.Click, _cmdBoton_15.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLBuscar(0)
            Case 1
                PLIngresar(0)
            Case 2
                PLActualizar(0)
            Case 3
                PLEliminar(0)
            Case 4
                PLLimpiar(0)
            Case 5
                Me.Close()
            Case 6
                PLBuscar(1)
            Case 7
                PLIngresar(1)
            Case 8
                PLActualizar(1)
            Case 9
                PLEliminar(1)
            Case 10
                PLLimpiar(1)
            Case 14
                PLSiguiente(0)
        End Select
        PLTSEstado()
    End Sub

    Private Sub FTran2810_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLInicializar()
        Me._MhTab1_TabPage0.Text = FMLoadResString(9105)
        Me._MhTab1_TabPage1.Text = FMLoadResString(502602)
    End Sub

    Private Sub grdOfiCanje_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdOfiCanje.Click
        grdOfiCanje.Col = 0
        grdOfiCanje.SelStartCol = 1
        grdOfiCanje.SelEndCol = grdOfiCanje.Cols - 1
        If grdOfiCanje.Row = 0 Then
            grdOfiCanje.SelStartRow = 1
            grdOfiCanje.SelEndRow = 1
        Else
            grdOfiCanje.SelStartRow = grdOfiCanje.Row
            grdOfiCanje.SelEndRow = grdOfiCanje.Row
        End If
        PLTSEstado()
    End Sub

    Private Sub grdOfiCanje_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdOfiCanje.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        grdOfiCanje.Col = 1
        txtCampo(2).Text = grdOfiCanje.CtlText
        txtCampo_Leave(txtCampo(2), New EventArgs())
        grdOfiCanje.Col = 3
        txtCampo(3).Text = grdOfiCanje.CtlText
        txtCampo_Leave(txtCampo(3), New EventArgs())
        grdOfiCanje.Col = 2
        txtCampo(4).Text = grdOfiCanje.CtlText
        txtCampo_Leave(txtCampo(4), New EventArgs())
        cmdBoton(7).Enabled = False
        cmdBoton(8).Enabled = True
        cmdBoton(9).Enabled = True
        txtCampo(2).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        grdRegistros.Col = 0
        grdRegistros.SelStartCol = 1
        grdRegistros.SelEndCol = grdRegistros.Cols - 1
        If grdRegistros.Row = 0 Then
            grdRegistros.SelStartRow = 1
            grdRegistros.SelEndRow = 1
        Else
            grdRegistros.SelStartRow = grdRegistros.Row
            grdRegistros.SelEndRow = grdRegistros.Row
        End If
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row) 'JSA
        grdRegistros.Col = 1
        lblSecuencial.Text = grdRegistros.CtlText
        grdRegistros.Col = 2
        txtCampo(0).Text = grdRegistros.CtlText
        txtCampo_Leave(txtCampo(0), New EventArgs())
        grdRegistros.Col = 3
        txtDesc.Text = grdRegistros.CtlText
        grdRegistros.Col = 4
        txtCampo(1).Text = grdRegistros.CtlText
        txtCampo_Leave(txtCampo(1), New EventArgs())
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = True
        cmdBoton(3).Enabled = True
        txtCampo(0).Focus()
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_1.TextChanged, _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_2.TextChanged, _txtCampo_5.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If txtCampo(Index).Text.Trim() = "" Then
            lblDescripcion(Index).Text = ""
        End If
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_1.Enter, _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_5.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502656))
            Case 1, 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502849))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502858))
                txtCampo(Index).SelectionStart = 0
                txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
        End Select
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_1.KeyDown, _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_5.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode <> VGTeclaAyuda Then
            Exit Sub
        End If
        Select Case Index
            Case 0, 2
                If KeyCode = VGTeclaAyuda Then
                    VGOperacion = "sp_oficina"
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(503007)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        'PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(Index).Text = VGACatalogo.Codigo
                        lblDescripcion(Index).Text = VGACatalogo.Descripcion
                        If txtCampo(Index).Text <> "" Then
                            txtCampo(Index).Focus()
                        End If
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn) 'JSA
                    End If
                End If
            Case 1, 3
                VGOperacion = "sp_centro_canje"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502608)) Then
                    PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    PMMapeaTextoGrid(FRegistros.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                    'FRegistros.grdRegistros.ColWidth(1) = 1500
                    'FRegistros.grdRegistros.ColWidth(2) = 3300
                    PMAnchoColumnasGrid(FRegistros.grdRegistros)
                    FRegistros.ShowPopup(Me)
                    txtCampo(Index).Text = VGACatalogo.Codigo
                    lblDescripcion(Index).Text = VGACatalogo.Descripcion
                    FRegistros.Dispose()
                Else
                    PMChequea(sqlconn) 'JSA
                    txtCampo(Index).Text = ""
                    lblDescripcion(Index).Text = ""
                End If
            Case 4
                VGOperacion = "sp_centro_canje1"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "H1")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502958)) Then
                    PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    PMMapeaTextoGrid(FRegistros.grdRegistros) 'JSA
                    PMChequea(sqlconn)
                    'FRegistros.grdRegistros.ColWidth(1) = 1500
                    'FRegistros.grdRegistros.ColWidth(2) = 3300
                    PMAnchoColumnasGrid(FRegistros.grdRegistros)
                    FRegistros.ShowPopup(Me)
                    txtCampo(Index).Text = VGACatalogo.Codigo
                    lblDescripcion(Index).Text = VGACatalogo.Descripcion
                    FRegistros.Dispose()
                Else
                    PMChequea(sqlconn) 'JSA
                    txtCampo(Index).Text = ""
                    lblDescripcion(Index).Text = ""
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_1.KeyPress, _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_5.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4
                If KeyAscii < 48 Or KeyAscii > 57 Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        PLTSEstado()
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_1.Leave, _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_5.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2
                If txtCampo(Index).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(Index).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtCampo(Index).Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn) 'JSA
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
                        txtCampo(Index).Focus()
                    End If
                Else
                    lblDescripcion(0).Text = ""
                End If
            Case 1, 3
                If txtCampo(Index).Text <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(Index).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502606)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn) 'JSA
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
                    End If
                Else
                    lblDescripcion(Index).Text = ""
                    txtCampo(Index).Text = ""
                End If
            Case 4
                If txtCampo(4).Text <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "H1")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, txtCampo(Index).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502955)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn) 'JSA
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
                    End If
                Else
                    lblDescripcion(Index).Text = ""
                    txtCampo(Index).Text = ""
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub txtDesc_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDesc.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509091)) 'JSA
    End Sub

    Private Sub txtDesc_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtDesc.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii > 47 And KeyAscii < 58) Or (KeyAscii > 64 And KeyAscii < 91) Or (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        Else
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        PLTSEstado()
    End Sub

    Public Sub PLIngresar(ByRef parOpc As Integer)
        Select Case parOpc
            Case 0
                If txtCampo(0).Text.Trim() = "" Or lblDescripcion(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502565), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Or lblDescripcion(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502911), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtDesc.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502941), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtDesc.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "I")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(0).Text.Trim())
                PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtDesc.Text.Trim())
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(1).Text.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502526)) Then
                    PMChequea(sqlconn)
                    PLLimpiar(0)
                    PLBuscar(0)
                    COBISMessageBox.Show(FMLoadResString(502586), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn) 'JSA
                    COBISMessageBox.Show(FMLoadResString(502920), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
            Case 1
                If txtCampo(2).Text.Trim() = "" Or lblDescripcion(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502915), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text.Trim() = "" Or lblDescripcion(3).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502561), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(4).Text.Trim() = "" Or lblDescripcion(4).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502910), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2811")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "I")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(2).Text.Trim())
                PMPasoValores(sqlconn, "@i_centro", 0, SQLINT4, txtCampo(4).Text.Trim())
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(3).Text.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_ofi_canje", True, FMLoadResString(502525)) Then
                    PMChequea(sqlconn)
                    PLLimpiar(1)
                    PLBuscar(1)
                    COBISMessageBox.Show(FMLoadResString(502585), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn) 'JSA
                    COBISMessageBox.Show(FMLoadResString(502921), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
        End Select
    End Sub

    Public Sub PLLimpiar(ByRef parOpc As Integer)
        Select Case parOpc
            Case 0
                txtCampo(0).Text = ""
                txtCampo(1).Text = ""
                txtDesc.Text = ""
                lblDescripcion(0).Text = ""
                lblDescripcion(1).Text = ""
                lblSecuencial.Text = ""
                cmdBoton(1).Enabled = True
                cmdBoton(2).Enabled = False
                cmdBoton(3).Enabled = False
                PMLimpiaG(grdRegistros)
                txtCampo(0).Focus()
            Case 1
                txtCampo(2).Text = ""
                txtCampo(3).Text = ""
                txtCampo(4).Text = ""
                lblDescripcion(2).Text = ""
                lblDescripcion(3).Text = ""
                lblDescripcion(4).Text = ""
                cmdBoton(6).Enabled = True
                cmdBoton(7).Enabled = True
                cmdBoton(8).Enabled = False
                cmdBoton(9).Enabled = False
                PMLimpiaG(grdOfiCanje)
                txtCampo(2).Enabled = True
                txtCampo(2).Focus()
        End Select
        PLTSEstado()
    End Sub

    Public Sub PLBuscar(ByRef parOpc As Integer)
        Dim VTSecuencial As String = ""
        Select Case parOpc
            Case 0
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "S")
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, "0")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502517)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMMapeaTextoGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdBoton(14).Enabled = (grdRegistros.Rows - 1) >= 20
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2811")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "S1")
                grdOfiCanje.Col = 1
                If grdOfiCanje.Rows > 1 And grdOfiCanje.CtlText <> "" Then
                    grdOfiCanje.Row = grdOfiCanje.Rows - 1
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, grdOfiCanje.CtlText)
                Else
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, CStr(0))
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_ofi_canje", True, FMLoadResString(502521)) Then
                    PMMapeaGrid(sqlconn, grdOfiCanje, False)
                    PMChequea(sqlconn)
                    Conversion.Val(Convert.ToString(grdOfiCanje.Tag))
                    grdOfiCanje.Row = grdOfiCanje.Rows - 1
                    grdOfiCanje.Col = 1
                    VTSecuencial = grdOfiCanje.CtlText
                    While CDbl(Convert.ToString(grdOfiCanje.Tag)) >= 20
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2811")
                        PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "S1")
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, VTSecuencial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_ofi_canje", True, FMLoadResString(502871)) Then
                            PMMapeaGrid(sqlconn, grdOfiCanje, True)
                            PMMapeaTextoGrid(grdOfiCanje)
                            PMAnchoColumnasGrid(grdOfiCanje)
                            PMChequea(sqlconn)
                            Conversion.Val(Convert.ToString(grdOfiCanje.Tag))
                            grdOfiCanje.Row = grdOfiCanje.Rows - 1
                            grdOfiCanje.Col = 1
                            VTSecuencial = grdOfiCanje.CtlText
                        Else
                            PMChequea(sqlconn)
                        End If
                    End While
                    cmdBoton(6).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado() 'JSA
    End Sub

    Public Sub PLSiguiente(ByRef parOpc As Integer)
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "S")
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502517)) Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            cmdBoton(14).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Public Sub PLActualizar(ByRef parOpc As Integer)
        Dim i As Integer = 0
        Select Case parOpc
            Case 0
                If txtCampo(0).Text.Trim() = "" Or lblDescripcion(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502565), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Or lblDescripcion(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502911), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtDesc.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502941), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtDesc.Focus()
                    Exit Sub
                End If
                i = COBISMessageBox.Show(FMLoadResString(502576), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
                If i = System.Windows.Forms.DialogResult.No Then
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "U")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(0).Text.Trim())
                PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtDesc.Text.Trim())
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(1).Text.Trim())
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, lblSecuencial.Text.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502877)) Then
                    PMChequea(sqlconn)
                    PLLimpiar(0)
                    PLBuscar(0)
                    COBISMessageBox.Show(FMLoadResString(502938), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn)
                    COBISMessageBox.Show(FMLoadResString(502573), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
            Case 1
                If txtCampo(2).Text.Trim() = "" Or lblDescripcion(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502915), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text.Trim() = "" Or lblDescripcion(3).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502561), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(4).Text.Trim() = "" Or lblDescripcion(4).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502910), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                i = COBISMessageBox.Show(FMLoadResString(502927), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
                If i = System.Windows.Forms.DialogResult.No Then
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2811")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "U")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(2).Text.Trim())
                PMPasoValores(sqlconn, "@i_centro", 0, SQLINT4, txtCampo(4).Text.Trim())
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(3).Text.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_ofi_canje", True, FMLoadResString(502528)) Then
                    PMChequea(sqlconn)
                    PLLimpiar(1)
                    PLBuscar(1)
                    COBISMessageBox.Show(FMLoadResString(502587), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn) 'JSA
                    COBISMessageBox.Show(FMLoadResString(502922), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
        End Select
    End Sub

    Public Sub PLEliminar(ByRef parOpc As Integer)
        Dim i As Integer = 0
        Select Case parOpc
            Case 0
                If txtCampo(0).Text.Trim() = "" Or lblDescripcion(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502565), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Or lblDescripcion(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502911), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtDesc.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502941), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtDesc.Focus()
                    Exit Sub
                End If
                i = COBISMessageBox.Show(FMLoadResString(502574), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
                If i = System.Windows.Forms.DialogResult.No Then
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2810")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "D")
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, lblSecuencial.Text.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_centro_canje", True, FMLoadResString(502873)) Then
                    PMChequea(sqlconn)
                    PLLimpiar(0)
                    PLBuscar(0)
                    COBISMessageBox.Show(FMLoadResString(502934), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn) 'JSA
                    COBISMessageBox.Show(FMLoadResString(502569), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
            Case 1
                If txtCampo(2).Text.Trim() = "" Or lblDescripcion(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502915), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text.Trim() = "" Or lblDescripcion(3).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502561), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(4).Text.Trim() = "" Or lblDescripcion(4).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502910), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                i = COBISMessageBox.Show(FMLoadResString(502925), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
                If i = System.Windows.Forms.DialogResult.No Then
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2811")
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLVARCHAR, "D")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(2).Text.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_ofi_canje", True, FMLoadResString(502524)) Then
                    PMChequea(sqlconn)
                    PLLimpiar(1)
                    PLBuscar(1)
                    COBISMessageBox.Show(FMLoadResString(502583), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn) 'JSA
                    COBISMessageBox.Show(FMLoadResString(502918), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_14.Enabled
        TSBSiguientes.Visible = _cmdBoton_14.Visible
        TSBIngresar.Enabled = _cmdBoton_1.Enabled
        TSBIngresar.Visible = _cmdBoton_1.Visible
        TSBModificar.Enabled = _cmdBoton_2.Enabled
        TSBModificar.Visible = _cmdBoton_2.Visible
        TSBEliminar.Enabled = _cmdBoton_3.Enabled
        TSBEliminar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_5.Enabled
        TSBSalir.Visible = _cmdBoton_5.Visible

        TSBBuscar2.Enabled = _cmdBoton_6.Enabled
        TSBBuscar2.Visible = _cmdBoton_6.Visible
        TSBIngresar2.Enabled = _cmdBoton_7.Enabled
        TSBIngresar2.Visible = _cmdBoton_7.Visible
        TSBModificar2.Enabled = _cmdBoton_8.Enabled
        TSBModificar2.Visible = _cmdBoton_8.Visible
        TSBEliminar2.Enabled = _cmdBoton_9.Enabled
        TSBEliminar2.Visible = _cmdBoton_9.Visible
        TSBLimpiar2.Enabled = _cmdBoton_10.Enabled
        TSBLimpiar2.Visible = _cmdBoton_10.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_14.Enabled Then cmdBoton_Click(_cmdBoton_14, e)
    End Sub

    Private Sub TSBIngresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBModificar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBBuscar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar2.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBIngresar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar2.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub

    Private Sub TSBModificar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar2.Click
        If _cmdBoton_8.Enabled Then cmdBoton_Click(_cmdBoton_8, e)
    End Sub

    Private Sub TSBEliminar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar2.Click
        If _cmdBoton_9.Enabled Then cmdBoton_Click(_cmdBoton_9, e)
    End Sub

    Private Sub TSBLimpiar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar2.Click
        If _cmdBoton_10.Enabled Then cmdBoton_Click(_cmdBoton_10, e)
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMLineaG(grdRegistros)
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdOfiCanje_ClickEvent(sender As Object, e As EventArgs) Handles grdOfiCanje.ClickEvent
        PMLineaG(grdOfiCanje)
        PMMarcaFilaCobisGrid(grdOfiCanje, grdOfiCanje.Row)
    End Sub

    Private Sub _MhTab1_TabPage0_Enter(sender As Object, e As EventArgs) Handles _MhTab1_TabPage0.Enter
        _cmdBoton_0.Visible = True
        _cmdBoton_14.Visible = True
        _cmdBoton_1.Visible = True
        _cmdBoton_2.Visible = True
        _cmdBoton_3.Visible = True
        _cmdBoton_4.Visible = True

        _cmdBoton_6.Visible = False
        _cmdBoton_7.Visible = False
        _cmdBoton_8.Visible = False
        _cmdBoton_9.Visible = False
        _cmdBoton_10.Visible = False
        PLTSEstado()
    End Sub

    Private Sub _MhTab1_TabPage1_Enter(sender As Object, e As EventArgs) Handles _MhTab1_TabPage1.Enter
        _cmdBoton_0.Visible = False
        _cmdBoton_14.Visible = False
        _cmdBoton_1.Visible = False
        _cmdBoton_2.Visible = False
        _cmdBoton_3.Visible = False
        _cmdBoton_4.Visible = False

        _cmdBoton_6.Visible = True
        _cmdBoton_7.Visible = True
        _cmdBoton_8.Visible = True
        _cmdBoton_9.Visible = True
        _cmdBoton_10.Visible = True
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509098)) 'JSA
    End Sub

    Private Sub grdOfiCanje_Enter(sender As Object, e As EventArgs) Handles grdOfiCanje.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509099)) 'JSA
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("") 'JSA
    End Sub

    Private Sub grdOfiCanje_Leave(sender As Object, e As EventArgs) Handles grdOfiCanje.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("") 'JSA
    End Sub
End Class


