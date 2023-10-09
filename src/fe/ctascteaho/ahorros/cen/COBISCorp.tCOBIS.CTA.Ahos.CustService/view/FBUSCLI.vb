Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FBuscarClienteClass

    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLCriterio_soc As Integer = 0
    Dim VLCriterio As Integer = 0
    Dim VLCliente As Integer = 0
    Dim VLNumLin As Integer = 0
    Dim VTArreglo1(1) As String
    Dim VLPaso As Boolean = False

    Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_1.Click, _cmdBuscar_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
        Dim VTCriterio As String = ""
        Dim VTModo As Integer = 0
        Dim VTsp As String = String.Empty
        Dim VTParametro As String = String.Empty
        Dim VTTope As Integer = 0
        Dim nombreCompleto As String = ""
        If OptionProspecto.Checked Then
            VTsp = "sp_prospectos_ofi"
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1318")
            PMPasoValores(sqlconn, "@i_alianza", 0, SQLINT1, txtAlianza.Text)
        ElseIf OptionCliente.Checked Then
            VTsp = "sp_se_ente"
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1182")
            PMPasoValores(sqlconn, "@i_subgrupo", 0, SQLINT1, "1")
            PMPasoValores(sqlconn, "@i_alianza", 0, SQLINT1, txtAlianza.Text)
        ElseIf OptionAmbos.Checked Then
            VTsp = "sp_se_ente_ofi"
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1241")
            PMPasoValores(sqlconn, "@i_alianza", 0, SQLINT1, txtAlianza.Text)
        Else
            COBISMessageBox.Show("Debe escoger alguna opción en Buscar", My.Application.Info.ProductName)
            Exit Sub
        End If
        If txtOficinaOpt.Text <> "" Then
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtOficinaOpt.Text)
        End If
        If txtValor.Text.IndexOf("%"c) >= 0 Then
            VTParametro = Strings.Left(txtValor.Text, Strings.Len(txtValor.Text) - 1)
        Else
            VTParametro = txtValor.Text
        End If
        If optCliente(0).Checked Then
            PMPasoValores(sqlconn, "@i_subtipo", 0, SQLCHAR, "P")
        Else
            PMPasoValores(sqlconn, "@i_subtipo", 0, SQLCHAR, "C")
        End If
        If optCriterio(0).Checked Then
            If VTParametro.Length > 8 Then
                COBISMessageBox.Show("El Consecutivo del cliente no es valido", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtValor.Focus()
                Exit Sub
            End If
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT1, "1")
            If VTParametro = "" Then
                VTParametro = CStr(0)
            End If
            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, VTParametro)
            VTCriterio = "C"
        ElseIf optCriterio(1).Checked Then
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT1, "2")
            If VTParametro = "" Then
                VTParametro = " "
            End If
            PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLVARCHAR, VTParametro)
            VTCriterio = "R"
        ElseIf optCriterio(2).Checked Then
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT1, "3")
            If VTParametro = "" Then
                VTParametro = " "
            End If
            PMPasoValores(sqlconn, "@i_pasaporte", 0, SQLVARCHAR, VTParametro)
            VTCriterio = "P"
        Else
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT1, "4")
            If VTParametro = "" Then
                VTParametro = " "
            End If
            PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, VTParametro)
            VTCriterio = "A"
        End If
        Select Case Index
            Case 0
                VTModo = False
                VLNumLin = 0
                If (txtValor.Text.IndexOf("%"c) + 1) = 0 Then
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "2")
                Else
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                End If
            Case 1
                VTModo = True
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                grdResultados.Row = grdResultados.Rows - 1
                VTTope = grdResultados.Row
                Select Case VTCriterio
                    Case "A"
                        grdResultados.Col = 2
                        nombreCompleto = grdResultados.CtlText.Trim() & " "
                        If optCliente(0).Checked Then
                            PMPasoValores(sqlconn, "@i_p_apellido", 0, SQLVARCHAR, grdResultados.CtlText)
                            grdResultados.Col = 3
                            nombreCompleto = (nombreCompleto & grdResultados.CtlText.Trim()).Trim() & " "
                            PMPasoValores(sqlconn, "@i_s_apellido", 0, SQLVARCHAR, grdResultados.CtlText)
                            grdResultados.Col = 4
                            nombreCompleto = nombreCompleto & grdResultados.CtlText.Trim()
                            PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, grdResultados.CtlText)
                            PMPasoValores(sqlconn, "@i_nombre_completo", 0, SQLVARCHAR, nombreCompleto)
                        Else
                            PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, grdResultados.CtlText)
                        End If
                    Case "C"
                        grdResultados.Col = 1
                        PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdResultados.CtlText)
                    Case "R"
                        If optCliente(0).Checked Then
                            grdResultados.Col = 5
                        Else
                            grdResultados.Col = 3
                        End If
                        PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLCHAR, grdResultados.CtlText)
                    Case "P"
                        grdResultados.Col = 8
                        PMPasoValores(sqlconn, "@i_pasaporte", 0, SQLCHAR, grdResultados.CtlText)
                End Select
        End Select
        If FMTransmitirRPC(sqlconn, FMGetServer(), "cobis", VTsp, True, "Búsqueda de Clientes") Then
            PMMapeaGrid(sqlconn, grdResultados, VTModo)
            If optCliente(0).Checked Then
                grdResultados.Cols = 16
                PMAnchoColGrid(grdResultados, 1)
                PMAnchoColGrid(grdResultados, 2)
                PMAnchoColGrid(grdResultados, 3)
                PMAnchoColGrid(grdResultados, 4)
                PMAnchoColGrid(grdResultados, 5)
                PMAnchoColGrid(grdResultados, 6)
                PMAnchoColGrid(grdResultados, 7)
                PMAnchoColGrid(grdResultados, 8)
                PMAnchoColGrid(grdResultados, 9)
                PMAnchoColGrid(grdResultados, 10)
                PMAnchoColGrid(grdResultados, 11)
                PMAnchoColGrid(grdResultados, 12)
                PMAnchoColGrid(grdResultados, 13)
                PMAnchoColGrid(grdResultados, 14)
            Else
                grdResultados.Cols = 12
                PMAnchoColGrid(grdResultados, 1)
                PMAnchoColGrid(grdResultados, 2)
                PMAnchoColGrid(grdResultados, 3)
                PMAnchoColGrid(grdResultados, 4)
                PMAnchoColGrid(grdResultados, 5)
                PMAnchoColGrid(grdResultados, 6)
                PMAnchoColGrid(grdResultados, 7)
                PMAnchoColGrid(grdResultados, 8)
                PMAnchoColGrid(grdResultados, 9)
                PMAnchoColGrid(grdResultados, 10)
                PMAnchoColGrid(grdResultados, 11)
            End If
            PMChequea(sqlconn)
            If Conversion.Val(Convert.ToString(grdResultados.Tag)) >= (VGMaximoRows - 1) Then
                cmdBuscar(1).Enabled = True
                If VTModo Then
                    If grdResultados.Rows > VGMaximoRows Then
                        grdResultados.TopRow = VTTope
                    End If
                End If
            Else
                If VTModo Then
                    cmdBuscar(1).Enabled = False
                End If
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub cmdBuscar_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_1.Enter, _cmdBuscar_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500150))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500151))
        End Select
    End Sub

    Private Sub cmdEscoger_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Click
        Dim VTCols As Integer = 0
        Dim VTRow As Integer = grdResultados.Row
        grdResultados.Col = 1
        grdResultados.Row = 1
        If grdResultados.Rows >= 2 And grdResultados.CtlText <> "" Then
            grdResultados.Row = VTRow
            VTCols = grdResultados.Cols - 1
            ReDim VGBusqueda(VTCols + 1)
            If optCliente(0).Checked Then
                VGBusqueda(0) = "P"
            Else
                VGBusqueda(0) = "C"
            End If
            For i As Integer = 1 To grdResultados.Cols - 1
                grdResultados.Col = i
                VGBusqueda(i) = grdResultados.CtlText
            Next i
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            If Convert.ToString(Me.Tag) <> "C" Then
                Me.Hide()
            End If
        End If
        optCliente(1).Enabled = True
    End Sub

    Private Sub cmdEscoger_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500152))
    End Sub

    Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
        ReDim VGBusqueda(1)
        optCliente(1).Enabled = True
        cmdEscoger.Visible = True
        optCliente(0).Enabled = True
        txtAlianza.Text = ""
        lblAlianza.Text = ""
        txtValor.Text = "%"
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        Me.Hide()
    End Sub

    Private Sub cmdSalir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500153))
    End Sub


    Private Sub PLInicializar()
        Me.Top = Compatibility.VB6.TwipsToPixelsY(1100)
        Me.Left = Compatibility.VB6.TwipsToPixelsX(15)
        If Not VGOnline Then
            OptionAmbos.Checked = True
            OptionCliente.Enabled = True
            OptionProspecto.Enabled = True
            OptionAmbos.Enabled = True
            txtAlianza.Text = ""
            lblAlianza.Text = ""
        End If
        If optCliente(1).Checked Then
            lblEtiqueta(1).Visible = False
            txtAlianza.Visible = False
            lblAlianza.Visible = False
        End If
        If optCliente(0).Checked Then
            lblEtiqueta(1).Visible = True
            txtAlianza.Visible = True
            lblAlianza.Visible = True
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBuscar_0.Enabled
        TSBBuscar.Visible = _cmdBuscar_0.Visible
        TSBSiguiente.Enabled = _cmdBuscar_1.Enabled
        TSBSiguiente.Visible = _cmdBuscar_1.Visible
        TSBEscoger.Enabled = cmdEscoger.Enabled
        TSBEscoger.Visible = cmdEscoger.Visible
        TSBSalir.Enabled = cmdSalir.Enabled
        TSBSalir.Visible = cmdSalir.Visible
    End Sub


    Private Sub FBuscarCliente_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = MyBase.Name
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        MyAppGlobals.AppActiveForm = MyBase.Name
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub FBuscarCliente_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        VLCriterio = 0
        VLCriterio_soc = 0
        VLNumLin = 0
        txtAlianza.Text = ""
        lblAlianza.Text = ""
    End Sub

    Private Sub grdResultados_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdResultados.Click
        PMLineaG(grdResultados)
    End Sub

    Private Sub grdResultados_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdResultados.DblClick
        cmdEscoger_Click(cmdEscoger, New EventArgs())
    End Sub

    Private Sub grdResultados_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdResultados.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        If Convert.ToString(Me.Tag) = "C" Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500154))
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optCliente_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCliente_0.CheckedChanged, _optCliente_1.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optCliente, eventSender)
            Dim Value As Integer = optCliente(Index).Checked
            optCliente_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optCliente_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        Select Case Index
            Case 0
                If Value Then
                    If VLCliente = 1 Then
                        VLCliente = 0
                        PMLimpiaG(grdResultados)
                        cmdBuscar(1).Enabled = False
                    End If
                    optCriterio(2).Enabled = True
                    optCriterio(2).Text = "Pasapo&rte"
                    optCriterio(1).Text = "Número de &D.I."
                    lblEtiqueta(1).Visible = True
                    txtAlianza.Visible = True
                    lblAlianza.Visible = True
                End If
            Case 1
                If Value Then
                    If VLCliente = 0 Then
                        VLCliente = 1
                        PMLimpiaG(grdResultados)
                        cmdBuscar(1).Enabled = False
                    End If
                    optCriterio(2).Text = "Pasapo&rte"
                    optCriterio(1).Text = "Número de &D.I."
                    optCriterio(2).Enabled = False
                    If optCriterio(2).Checked Then
                        optCriterio(3).Checked = True
                    End If
                    lblEtiqueta(1).Visible = False
                    txtAlianza.Visible = False
                    lblAlianza.Visible = False
                End If
            Case 2
                optCriterio(2).Enabled = True
                optCriterio(2).Text = "&Tipo"
                optCriterio(1).Text = "&NIT"
                If Value Then
                    VLCliente = 2
                    PMLimpiaG(grdResultados)
                    cmdBuscar(1).Enabled = False
                End If
        End Select
    End Sub

    Private Sub optCliente_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCliente_0.Enter, _optCliente_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500155))
    End Sub

    Private Sub optCriterio_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCriterio_3.CheckedChanged, _optCriterio_1.CheckedChanged, _optCriterio_0.CheckedChanged, _optCriterio_2.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optCriterio, eventSender)
            Dim Value As Integer = optCriterio(Index).Checked
            optCriterio_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optCriterio_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        Select Case Index
            Case 0
                If Value Then
                    If VLCriterio <> 0 Then
                        VLCriterio = 0
                        txtValor.Text = "%"
                        cmdBuscar(0).Enabled = False
                        cmdBuscar(1).Enabled = False
                    End If
                End If
            Case 1
                If Value Then
                    If VLCriterio <> 1 Then
                        VLCriterio = 1
                        txtValor.Text = "%"
                        cmdBuscar(0).Enabled = False
                        cmdBuscar(1).Enabled = False
                    End If
                End If
            Case 2
                If Value Then
                    If VLCriterio <> 2 Then
                        VLCriterio = 2
                        txtValor.Text = "%"
                        cmdBuscar(1).Enabled = False
                    End If
                End If
            Case 3
                If Value Then
                    If VLCriterio <> 3 Then
                        VLCriterio = 3
                        txtValor.Text = "%"
                        cmdBuscar(0).Enabled = False
                        cmdBuscar(1).Enabled = False
                    End If
                End If
        End Select
    End Sub

    Private Sub optCriterio_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCriterio_3.Enter, _optCriterio_1.Enter, _optCriterio_0.Enter, _optCriterio_2.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500156))
    End Sub

    Private Sub txtAlianza_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtAlianza.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtAlianza_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtAlianza.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2519))
    End Sub

    Private Sub txtAlianza_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtAlianza.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        If KeyCode = 116 Then
            VGOperacion = "sp_alianzas"
            VLPaso = True
            FAyuda.ShowPopup(Me)
            txtAlianza.Text = VGAyuda(1)
            lblAlianza.Text = VGAyuda(2)
            FAyuda.Dispose()
        End If
    End Sub

    Private Sub txtAlianza_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtAlianza.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtAlianza_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtAlianza.Leave
        Dim VTR As Integer = 0
        If txtAlianza.Text <> "" Then
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1615")
            PMPasoValores(sqlconn, "@i_alianza", 0, SQLINT2, txtAlianza.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_alianzas", True, "Ayuda Cliente") Then
                VTR = FMMapeaArreglo(sqlconn, VTArreglo1)
                PMChequea(sqlconn)
                lblAlianza.Text = VTArreglo1(1)
            Else
                PMChequea(sqlconn)
                txtAlianza.Text = ""
                lblAlianza.Text = ""
            End If
        Else
            txtAlianza.Text = ""
            lblAlianza.Text = ""
        End If
    End Sub

    Private Sub txtOficinaOpt_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficinaOpt.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2520))
        txtOficinaOpt.SelectionStart = 0
        txtOficinaOpt.SelectionLength = Strings.Len(txtOficinaOpt.Text)
    End Sub

    Private Sub txtOficinaOpt_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtOficinaOpt.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        If KeyCode = 116 Then
            VLPaso = True
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMHelpG("cobis", "sp_hp_catalogo", 3, 0)
            PMBuscarG(1, "@i_tabla", "cl_oficina", SQLCHAR)
            PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            If FMTransmitirRPC(sqlconn, ServerNameLocal, "cobis", "sp_hp_catalogo", True, "") Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    Application.DoEvents()
                    txtOficinaOpt.Text = Temporales(1)
                    lblDesOficina.Text = Temporales(2)
                    VLPaso = True
                    SendKeys.Send("{TAB}")
                Else
                    VLPaso = False
                    txtOficinaOpt_Leave(txtOficinaOpt, New EventArgs())
                End If
                grid_valores.Dispose()
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtOficinaOpt_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtOficinaOpt.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtOficinaOpt_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficinaOpt.Leave
        If Not VLPaso Then
            txtOficinaOpt.Text = txtOficinaOpt.Text.Trim()
            If txtOficinaOpt.Text <> "" Then
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtOficinaOpt.Text)
                If FMTransmitirRPC(sqlconn, ServerNameLocal, "cobis", "sp_hp_catalogo", True, "") Then
                    PMMapeaObjeto(sqlconn, lblDesOficina)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtOficinaOpt.Text = ""
                    lblDesOficina.Text = ""
                End If
            End If
        Else
            txtOficinaOpt.Text = txtOficinaOpt.Text.Trim()
        End If
        If txtOficinaOpt.Text = "" And lblDesOficina.Text <> "" Then
            lblDesOficina.Text = ""
        End If
    End Sub

    Private Sub txtValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtValor.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2521))
    End Sub

    Private Sub txtValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtValor.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If optCriterio(0).Checked Then
            If (KeyAscii < 48 Or KeyAscii > 57) And KeyAscii <> 37 And KeyAscii <> 8 Then
                KeyAscii = 0
            End If
        Else
            If optCriterio(1).Checked Then
                If KeyAscii = 8 Or (KeyAscii >= 48 And KeyAscii <= 57) Or (KeyAscii >= 65 And KeyAscii <= 90) Or (KeyAscii >= 97 And KeyAscii <= 122) Or KeyAscii = 37 Then
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                Else
                    KeyAscii = 0
                End If
            Else
                If optCriterio(2).Checked Then
                    If KeyAscii = 8 Or (KeyAscii >= 48 And KeyAscii <= 57) Or (KeyAscii >= 65 And KeyAscii <= 90) Or (KeyAscii >= 97 And KeyAscii <= 122) Or KeyAscii = 37 Or KeyAscii = 45 Then
                        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                    Else
                        KeyAscii = 0
                    End If
                Else
                    If optCriterio(3).Checked Then
                        If KeyAscii = 8 Or KeyAscii = 241 Or KeyAscii = 209 Or (KeyAscii >= 32 And KeyAscii <= 122) Then
                            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                        Else
                            KeyAscii = 0
                        End If
                    End If
                End If
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtValor.Leave
        Dim VTParametro As String = ""
        txtValor.Text = txtValor.Text.Trim().ToUpper()
        Dim vttam As String = CStr(Strings.Len(txtValor.Text))
        Dim VTpos As Integer = (txtValor.Text.IndexOf("%"c) + 1)
        If optCriterio(0).Checked Or optCriterio(1).Checked Then
            If ((VTpos > 1) And (VTpos <> StringsHelper.ToDoubleSafe(vttam))) Or ((StringsHelper.ToDoubleSafe(vttam) > 1) And (VTpos = 1)) Then
                COBISMessageBox.Show("Criterio de Búsqueda inválido, utilice caracter % solo al final del valor de búsqueda", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtValor.Text = "%"
                txtValor.Focus()
                Exit Sub
            End If
        End If
        If Strings.Len(txtValor.Text) > 0 Then
            VTParametro = Strings.Left(txtValor.Text, Strings.Len(txtValor.Text) - 1)
        Else
            VTParametro = ""
        End If
        If optCriterio(3).Checked And (VTpos = 0 Or VTpos >= 4) Then
            cmdBuscar(0).Enabled = True
        End If
        If optCriterio(3).Checked And VTpos <> 0 And VTpos < 4 Then
            COBISMessageBox.Show("Criterio de Búsqueda inválido, utilice minimo 3 caracteres y % solo al final del valor de búsqueda ", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            cmdBuscar(0).Enabled = False
            cmdBuscar(1).Enabled = False
            Exit Sub
        End If
        If optCriterio(1).Checked And (VTpos = 0 Or VTpos >= 4) Then
            cmdBuscar(0).Enabled = True
        End If
        If optCriterio(1).Checked And VTpos <> 0 And VTpos < 4 Then
            COBISMessageBox.Show("Criterio de Búsqueda inválido, utilice minimo 3 caracteres y % solo al final del valor de búsqueda ", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            cmdBuscar(0).Enabled = False
            cmdBuscar(1).Enabled = False
            Exit Sub
        End If
        If optCriterio(0).Checked And (VTpos = 0 Or VTpos >= 2) Then
            cmdBuscar(0).Enabled = True
        End If
        If optCriterio(0).Checked And VTpos <> 0 And VTpos < 2 Then
            COBISMessageBox.Show("Criterio de Búsqueda inválido, utilice minimo 1 caracter y % solo al final del valor de búsqueda ", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            cmdBuscar(0).Enabled = False
            cmdBuscar(1).Enabled = False
            txtValor.Focus()
            Exit Sub
        End If
        If optCriterio(0).Checked Then
            If Conversion.Val(VTParametro) > 999999999 Then
                COBISMessageBox.Show("El código no puede ser mayor a 999,999,999", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtValor.Text = "%"
                txtValor.Focus()
                Exit Sub
            End If
        End If
        If optCriterio(1).Checked Then
            If VTParametro.Length > 16 Then
                COBISMessageBox.Show("La longitud del Documento de Identificación NO puede ser mayor de 16 caracteres", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtValor.Text = "%"
                txtValor.Focus()
                Exit Sub
            End If
        End If
        cmdBuscar(0).Focus()
    End Sub

    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBuscar_0.Enabled Then cmdBuscar_Click(_cmdBuscar_0, e)
    End Sub

    Private Sub TSBSIGUIENTE_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBuscar_1.Enabled Then cmdBuscar_Click(_cmdBuscar_1, e)
    End Sub

    Private Sub TSBESCOGER_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdEscoger.Enabled Then cmdEscoger_Click(_cmdEscoger, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdSalir.Enabled Then cmdSalir_Click(_cmdSalir, e)
    End Sub

    Private Sub TSBOTONES_ItemClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ToolStripItemClickedEventArgs) Handles TSBotones.ItemClicked

    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        'If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
        '	Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
        PMLimpiaGrid(grdResultados)
        txtOficinaOpt.Text = ""
        lblDesOficina.Text = ""
        OptionProspecto.Checked = False
        OptionCliente.Checked = True
        cmdBuscar(0).Enabled = False
        cmdBuscar(1).Enabled = False
        txtValor.Text = "%"
        If Not VGOnline Then
            OptionAmbos.Checked = True
            OptionCliente.Enabled = True
            OptionProspecto.Enabled = True
            OptionAmbos.Enabled = True
        End If
        VLPaso = True
        If optCliente(1).Checked Then
            lblEtiqueta(1).Visible = False
            txtAlianza.Visible = False
            lblAlianza.Visible = False
        End If
        If optCliente(0).Checked Then
            lblEtiqueta(1).Visible = True
            txtAlianza.Visible = True
            lblAlianza.Visible = True
        End If
        'End If
    End Sub
End Class


