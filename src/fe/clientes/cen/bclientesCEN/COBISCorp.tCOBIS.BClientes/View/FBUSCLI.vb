Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class FBuscarClienteClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLcriterio As Integer = 0
    Dim VLCriterio_soc As Integer = 0
    Dim VLCliente As Integer = 0
    Dim VLNumLin As Integer = 0
    Dim VTArreglo1(1) As String
    Dim VLPaso As Integer = 0
    Dim VLNumCaracT As Boolean = True
    Dim VLvalorAnt As Integer = -1

    Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_1.Click, _cmdBuscar_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
        Dim VTCriterio As String = ""
        Dim VTModo As Integer = 0
        Dim VTsp As String = String.Empty
        Dim VTParametro As String = String.Empty
        Dim VTTope As String = String.Empty
        Dim nombreCompleto As String = String.Empty
        VLNumCaracT = True
        TSBotones.Focus()
        If VLNumCaracT Then
            If OptionProspecto.Checked Then
                VTsp = "sp_prospectos_ofi"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1318")
                PMPasoValores(SqlConn, "@i_alianza", 0, SQLINT1, txtAlianza.Text)
            ElseIf OptionCliente.Checked Then
                VTsp = "sp_se_ente"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1182")
                PMPasoValores(SqlConn, "@i_subgrupo", 0, SQLINT1, "1")
                PMPasoValores(SqlConn, "@i_alianza", 0, SQLINT1, txtAlianza.Text)
            ElseIf OptionAmbos.Checked Then
                VTsp = "sp_se_ente_ofi"
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1241")
                PMPasoValores(SqlConn, "@i_alianza", 0, SQLINT1, txtAlianza.Text)
            Else
                COBISMessageBox.Show(FMLoadResString(5034), My.Application.Info.ProductName)

                Exit Sub
            End If
            If txtOficinaOpt.Text <> "" Then
                PMPasoValores(SqlConn, "@i_oficina", 0, SQLINT2, txtOficinaOpt.Text)
            End If
            If txtValor.Text.IndexOf("%"c) >= 0 Then
                VTParametro = Strings.Left(txtValor.Text, Strings.Len(txtValor.Text) - 1)
            Else
                VTParametro = txtValor.Text
            End If
            If optCliente(0).Checked Then
                PMPasoValores(SqlConn, "@i_subtipo", 0, SQLCHAR, "P")
            Else
                PMPasoValores(SqlConn, "@i_subtipo", 0, SQLCHAR, "C")
            End If
            If optCriterio(0).Checked Then  'Consecutivo
                If VTParametro.Length > 8 Then
                    COBISMessageBox.Show(FMLoadResString(5035), FMLoadResString(5042), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    txtValor.Focus()
                    Exit Sub
                End If
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLINT1, "1")
                If VTParametro = "" Then
                    VTParametro = CStr(0)
                End If
                PMPasoValores(SqlConn, "@i_ente", 0, SQLINT4, VTParametro)
                VTCriterio = "C"
            ElseIf optCriterio(1).Checked Then  'Numero de ID
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLINT1, "2")
                If VTParametro = "" Then
                    VTParametro = ""
                End If
                PMPasoValores(SqlConn, "@i_ced_ruc", 0, SQLVARCHAR, VTParametro)
                VTCriterio = "R"
            ElseIf optCriterio(2).Checked Then  'No se usa
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLINT1, "3")
                If VTParametro = "" Then
                    VTParametro = ""
                End If
                PMPasoValores(SqlConn, "@i_pasaporte", 0, SQLVARCHAR, VTParametro)
                VTCriterio = "P"
            Else                              ' alfabetico
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLINT1, "4")
                If VTParametro = "" Then
                    VTParametro = ""
                End If
                PMPasoValores(SqlConn, "@i_valor", 0, SQLVARCHAR, VTParametro)
                VTCriterio = "A"
            End If
            Select Case Index
                Case 0
                    VTModo = False
                    VLNumLin = 0
                    If (txtValor.Text.IndexOf("%"c) + 1) = 0 Then
                        PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "2")
                    Else
                        PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
                    End If
                Case 1
                    VTModo = True
                    PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "1")
                    grdResultados.Row = grdResultados.Rows - 1
                    VTTope = CStr(grdResultados.Row)
                    Select Case VTCriterio
                        Case "A"   'alfabetico
                            grdResultados.Col = 2
                            nombreCompleto = grdResultados.CtlText.Trim() & " "
                            If optCliente(0).Checked Then
                                PMPasoValores(SqlConn, "@i_p_apellido", 0, SQLVARCHAR, grdResultados.CtlText)
                                grdResultados.Col = 3
                                nombreCompleto = (nombreCompleto & grdResultados.CtlText.Trim()).Trim() & " "
                                PMPasoValores(SqlConn, "@i_s_apellido", 0, SQLVARCHAR, grdResultados.CtlText)
                                grdResultados.Col = 4
                                nombreCompleto = nombreCompleto & grdResultados.CtlText.Trim()
                                PMPasoValores(SqlConn, "@i_nombre", 0, SQLVARCHAR, grdResultados.CtlText)
                                PMPasoValores(SqlConn, "@i_nombre_completo", 0, SQLVARCHAR, nombreCompleto)
                            Else
                                PMPasoValores(SqlConn, "@i_nombre", 0, SQLVARCHAR, grdResultados.CtlText)
                            End If
                        Case "C"  'consecitivo
                            grdResultados.Col = 1
                            PMPasoValores(SqlConn, "@i_ente", 0, SQLINT4, grdResultados.CtlText)
                        Case "R"   'numero de ID
                            If optCliente(0).Checked Then
                                grdResultados.Col = 5
                            Else
                                grdResultados.Col = 3
                            End If
                            PMPasoValores(SqlConn, "@i_ced_ruc", 0, SQLCHAR, grdResultados.CtlText)
                        Case "P"  'pasaporte
                            grdResultados.Col = 8
                            PMPasoValores(SqlConn, "@i_pasaporte", 0, SQLCHAR, grdResultados.CtlText)
                    End Select
            End Select
            If FMTransmitirRPC(SqlConn, ServerName, "cobis", VTsp, True, FMLoadResString(10000)) Then
                PMMapeaGrid(SqlConn, grdResultados, VTModo)
                If optCliente(0).Checked Then
                    grdResultados.Cols = 14
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
                Else
                    PMChequea(SqlConn)
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
                PMChequea(SqlConn)
                cmdEscoger.Enabled = True
                PLTSEstado()
                If Conversion.Val(Convert.ToString(grdResultados.Tag)) >= (VGMaximoRows - 1) Then
                    cmdBuscar(1).Enabled = True
                    PLTSEstado()
                    If VTModo Then
                        If grdResultados.Rows > VGMaximoRows Then
                            grdResultados.TopRow = CInt(VTTope)
                        End If
                    End If

                Else
                    cmdBuscar(1).Enabled = False
                    PLTSEstado()
                    If VTModo Then
                        cmdBuscar(1).Enabled = False
                        PLTSEstado()
                    End If
                End If
            Else
                PMChequea(SqlConn)
            End If

        End If

    End Sub

    Private Sub cmdBuscar_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_1.Enter, _cmdBuscar_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
        Select Case Index
            Case 0
                FMMsgAyuda(4000, "")
            Case 1
                FMMsgAyuda(4001, "")
        End Select
    End Sub

    Private Sub cmdEscoger_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Click
        Dim VTCliente As Integer = 0
        Dim VTCols As Integer = 0
        Dim VTMP1 As String = String.Empty
        Dim VTMP2 As String = String.Empty
        Dim VTR1 As Integer = 0
        Dim VTR2 As Integer = 0
        Dim VTR3 As Integer = 0
        Dim VTRow As Integer = grdResultados.Row
        grdResultados.Col = 1
        grdResultados.Row = 1
        If grdResultados.Rows >= 2 And grdResultados.CtlText <> "" Then
            grdResultados.Row = VTRow
            VTCols = grdResultados.Cols - 1
            ReDim VGDatosCliente(VTCols + 1)
            If optCliente(0).Checked Then
                VGDatosCliente(0) = "P"
            Else
                VGDatosCliente(0) = "C"
            End If
            For i As Integer = 1 To grdResultados.Cols - 1
                grdResultados.Col = i
                VGDatosCliente(i) = grdResultados.CtlText
                If i = 1 Then
                    VTCliente = CInt(grdResultados.CtlText)
                End If
            Next i
            If VTCliente <> StringsHelper.ToDoubleSafe("") And VTRow > 0 Then
                ReDim VGOtrosDatosCliente(5, 1)
                PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1414")
                PMPasoValores(SqlConn, "@i_ente", 0, SQLINT4, CStr(VTCliente))
                If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_dir_tel_cons", True, "Ayuda de lista de Funcionarios") Then
                    PMMapeaVariable(SqlConn, VTMP1)
                    PMMapeaVariable(SqlConn, VTMP2)
                    ReDim VGDireccionesCliente(1, CInt(VTMP1))
                    VTR1 = FMMapeaMatriz(SqlConn, VGDireccionesCliente)
                    ReDim VGTelefonosCliente(1, CInt(VTMP2))
                    VTR2 = FMMapeaMatriz(SqlConn, VGTelefonosCliente)
                    VTR3 = FMMapeaMatriz(SqlConn, VGOtrosDatosCliente)
                    PMChequea(SqlConn)
                Else
                    PMChequea(SqlConn)
                End If
            End If
            PMBorrarMensajes()
            Me.Close()
        End If
    End Sub

    Private Sub cmdEscoger_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Enter
        FMMsgAyuda(4002, "")
    End Sub

    Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
        ReDim VGDatosCliente(1)
        VGCodigoCliente = ""
        VGNombreCliente = ""
        VGOrigenCliente = ""
        txtAlianza.Text = ""
        lblAlianza.Text = ""
        PMBorrarMensajes()
        Me.Close()
    End Sub

    Private Sub cmdSalir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Enter
        ReDim VGDatosCliente(1)
        VGCodigoCliente = ""
        VGNombreCliente = ""
        VGOrigenCliente = ""
        txtAlianza.Text = ""
        lblAlianza.Text = ""
        PMBorrarMensajes()
    End Sub


    Private Sub FBuscarCliente_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)

        PLInitModule(3)

        OptionAmbos.Checked = True
        OptionCliente.Enabled = True
        OptionProspecto.Enabled = True
        OptionAmbos.Enabled = True
        optCliente(1).Checked = False
        optCliente(0).Checked = True
        MyAppGlobals.AppActiveForm = ""
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
        txtAlianza.Text = ""
        lblAlianza.Text = ""
        FMOcultarCampos()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(4000))
    End Sub

    Private Sub FBuscarCliente_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        PMBorrarMensajes()
        VLcriterio = 0
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
        PMBorrarMensajes()
        If Convert.ToString(Me.Tag) = "C" Then
            PMBorrarMensajes()
        Else
            FMMsgAyuda(4004, "")
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
            Case 0  'P natural
                If Value Then
                    If VGProducto <> "PERSON" Then
                        lblEtiqueta(1).Visible = True
                        lblAlianza.Visible = True
                        txtAlianza.Visible = True
                    End If
                    If VLCliente = 1 Then
                        VLCliente = 0
                        PMLimpiag(grdResultados)
                        cmdBuscar(0).Enabled = True
                        cmdBuscar(1).Enabled = False
                        cmdEscoger.Enabled = False
                        txtValor.Text = "%"
                        PLTSEstado()
                    End If
                    optCriterio(2).Enabled = True
                    optCriterio(2).Text = "Pasapo&rte"
                    optCriterio(1).Text = "Número de &D.I."
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5048))
                End If
            Case 1 'P juridica
                If Value Then
                    lblEtiqueta(1).Visible = False
                    lblAlianza.Visible = False
                    txtAlianza.Visible = False
                    If VLCliente = 0 Then
                        VLCliente = 1
                        PMLimpiag(grdResultados)
                        cmdBuscar(0).Enabled = True
                        cmdBuscar(1).Enabled = False
                        cmdEscoger.Enabled = False
                        txtValor.Text = "%"
                        PLTSEstado()
                    End If
                    optCriterio(2).Text = "Pasapo&rte"
                    optCriterio(1).Text = "Número de &D.I."
                    optCriterio(2).Enabled = False
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5047))
                    If optCriterio(2).Checked Then
                        optCriterio(3).Checked = True
                    End If
                End If
            Case 2
                optCriterio(2).Enabled = True
                optCriterio(2).Text = "&Tipo"
                optCriterio(1).Text = "&NIT"
                If Value Then
                    VLCliente = 2
                    PMLimpiag(grdResultados)
                    cmdBuscar(1).Enabled = False
                    PLTSEstado()
                End If
        End Select
    End Sub

    Private Sub optCliente_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCliente_0.Enter, _optCliente_1.Enter
        PMBorrarMensajes()
        FMMsgAyuda(4005, "")
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
        PMLimpiag(grdResultados)
        Select Case Index
            Case 0  'Cod cliente consecuitivo
                If Value Then
                    If VLcriterio <> 0 Then
                        VLcriterio = 0
                        txtValor.Text = "%"
                        cmdBuscar(0).Enabled = True
                        cmdBuscar(1).Enabled = False
                        cmdEscoger.Enabled = False
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5045))
                        PLTSEstado()
                    End If
                End If
            Case 1 ' numero de ID
                If Value Then
                    If VLcriterio <> 1 Then
                        VLcriterio = 1
                        txtValor.Text = "%"
                        cmdBuscar(0).Enabled = True
                        cmdBuscar(1).Enabled = False
                        cmdEscoger.Enabled = False
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5046))
                        PLTSEstado()
                    End If
                End If
            Case 2
                If Value Then
                    If VLcriterio <> 2 Then
                        VLcriterio = 2
                        txtValor.Text = "%"
                        cmdBuscar(0).Enabled = True
                        cmdBuscar(1).Enabled = False
                        cmdEscoger.Enabled = False
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5044))
                        PLTSEstado()
                    End If
                End If
            Case 3   'alfabetico
                If Value Then
                    If VLcriterio <> 3 Then
                        VLcriterio = 3
                        txtValor.Text = "%"
                        cmdBuscar(0).Enabled = True
                        cmdBuscar(1).Enabled = False
                        cmdEscoger.Enabled = False
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5044))
                        PLTSEstado()
                    End If
                End If
        End Select
    End Sub

    Private Sub optCriterio_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCriterio_3.Enter, _optCriterio_1.Enter, _optCriterio_0.Enter, _optCriterio_2.Enter
        PMBorrarMensajes()
        FMMsgAyuda(4006, "")
    End Sub

    Private Sub OptionAmbos_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles OptionAmbos.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Value As Integer = OptionAmbos.Checked
            OptionAmbos_ClickHelper(Value)
        End If
    End Sub

    Private Sub OptionAmbos_ClickHelper(ByRef Value As Integer)
        PMLimpiag(grdResultados)
    End Sub

    Private Sub OptionCliente_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles OptionCliente.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Value As Integer = OptionCliente.Checked
            OptionCliente_ClickHelper(Value)
        End If
    End Sub

    Private Sub OptionCliente_ClickHelper(ByRef Value As Integer)
        PMLimpiag(grdResultados)
    End Sub

    Private Sub OptionProspecto_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles OptionProspecto.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Value As Integer = OptionProspecto.Checked
            OptionProspecto_ClickHelper(Value)
        End If
    End Sub

    Private Sub OptionProspecto_ClickHelper(ByRef Value As Integer)
        PMLimpiag(grdResultados)
    End Sub

    Private Sub txtAlianza_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtAlianza.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtAlianza_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtAlianza.Enter
        VLPaso = True
    End Sub

    Private Sub txtAlianza_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtAlianza.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000

        If KeyCode = 116 Then
            VGOperacion = "sp_alianzas"
            VLPaso = True
            Dim FAyuda As New FAyudaClass
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
            PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "V")
            PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1615")
            PMPasoValores(SqlConn, "@i_alianza", 0, SQLINT2, txtAlianza.Text)
            If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_alianzas", True, "Ayuda Cliente") Then
                VTR = FMMapeaArreglo(SqlConn, VTArreglo1)
                PMChequea(SqlConn)
                lblAlianza.Text = VTArreglo1(1)
            Else
                PMChequea(SqlConn)
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
        txtOficinaOpt.SelectionStart = 0
        txtOficinaOpt.SelectionLength = Strings.Len(txtOficinaOpt.Text)
    End Sub

    Private Sub txtOficinaOpt_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtOficinaOpt.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
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
                PMPasoValores(SqlConn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(SqlConn, "@i_codigo", 0, SQLVARCHAR, txtOficinaOpt.Text)
                If FMTransmitirRPC(SqlConn, ServerNameLocal, "cobis", "sp_hp_catalogo", True, "") Then
                    PMMapeaObjeto(SqlConn, lblDesOficina)
                    PMChequea(SqlConn)
                Else
                    PMChequea(SqlConn)
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
        VLPaso = True
        If txtValor.Text = "%" And Strings.Len(txtValor.Text.Trim) = 1 Then
            VLNumCaracT = True
        End If
        If VLvalorAnt = 999999999 Then
            VLNumCaracT = False
            VLvalorAnt = -1
        Else
            VLNumCaracT = True
        End If

        PMBorrarMensajes()
        FMMsgAyuda(4011, "")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5043))
    End Sub

    Private Sub txtValor_KeyDown(sender As Object, e As KeyEventArgs) Handles txtValor.KeyDown
        VLPaso = True
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
        If Not VLPaso Then

            txtValor.Text = txtValor.Text.Trim().ToUpper()
            Dim VTTam As Integer = Strings.Len(txtValor.Text)
            Dim VTpos As Integer = (txtValor.Text.IndexOf("%"c) + 1)


            If ((VTpos > 1) And (VTpos <> VTTam)) Or ((VTTam > 1) And (VTpos = 1)) Then
                COBISMessageBox.Show(FMLoadResString(5036), FMLoadResString(5042), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtValor.Text = "%"
                txtValor.Focus()
                Exit Sub
            End If

            If Strings.Len(txtValor.Text) > 0 Then
                VTParametro = Strings.Left(txtValor.Text, Strings.Len(txtValor.Text) - 1)
            Else
                VTParametro = ""
            End If

            If optCriterio(0).Checked Then
                If Conversion.Val(VTParametro) > 999999999 Then
                    COBISMessageBox.Show(FMLoadResString(5040), FMLoadResString(5042), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    VLvalorAnt = 999999999
                    txtValor.Text = "%"
                    VLNumCaracT = False
                    txtValor.Focus()
                    Exit Sub
                End If
            End If

            If optCriterio(1).Checked Then
                If VTParametro.Length > 16 Then
                    COBISMessageBox.Show(FMLoadResString(5041), FMLoadResString(5042), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    txtValor.Text = "%"
                    VLNumCaracT = False
                    txtValor.Focus()
                    Exit Sub
                End If
            End If

            If optCriterio(3).Checked And (VTpos = 0 Or VTpos >= 4) Then
                cmdBuscar(0).Enabled = True
                PLTSEstado()
            End If

            If optCriterio(3).Checked And VTpos <> 0 And VTpos < 4 Then
                COBISMessageBox.Show(FMLoadResString(5037), FMLoadResString(5042), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                cmdBuscar(0).Enabled = True
                cmdBuscar(1).Enabled = False
                VLNumCaracT = False
                PLTSEstado()
                Exit Sub
            Else
                VLNumCaracT = True
            End If
            If optCriterio(1).Checked And (VTpos = 0 Or VTpos >= 4) Then
                cmdBuscar(0).Enabled = True
                PLTSEstado()
            End If
            'If optCriterio(1).Checked And VTpos <> 0 And VTpos < 4 Then
            '    COBISMessageBox.Show(FMLoadResString(5037), FMLoadResString(5042), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)

            '    cmdBuscar(0).Enabled = True
            '    cmdBuscar(1).Enabled = False
            '    PLTSEstado()
            '    Exit Sub
            'End If
            If optCriterio(0).Checked And (VTpos = 0 Or VTpos >= 2) Then
                cmdBuscar(0).Enabled = True
                PLTSEstado()
            End If
            'If optCriterio(0).Checked And VTpos <> 0 And VTpos < 2 Then
            '    COBISMessageBox.Show(FMLoadResString(5039), FMLoadResString(5042), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            '    cmdBuscar(0).Enabled = False
            '    cmdBuscar(1).Enabled = False
            '    txtValor.Focus()
            '    PLTSEstado()
            '    Exit Sub
            'End If
            If VTParametro <> "" Then
                cmdBuscar(0).Focus()
            End If

        End If

    End Sub


    Private Sub FMOcultarCampos()
        If VGProducto = "PERSON" Then
            txtAlianza.Enabled = False
            lblAlianza.Enabled = False
            Frame3D1.Enabled = False
            fraAlianza.Enabled = False
            fraAlianza.Visible = False
        End If
        If VGTipoCli = "E" Then
            optCliente(0).Enabled = False
            optCliente(0).Checked = False
            optCliente(1).Checked = True
            optCliente(1).Enabled = True
        End If
        If VGTipoCli = "P" Then
            optCliente(0).Enabled = True
            optCliente(0).Checked = True
            optCliente(1).Checked = False
            optCliente(1).Enabled = False
        End If
        If VGTipoCli = "C" Then
            cmdBuscar(0).Enabled = True
            cmdBuscar(1).Enabled = False
            cmdEscoger.Enabled = False
        End If


    End Sub


    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBuscar_0.Enabled
        TSBBuscar.Visible = _cmdBuscar_0.Visible
        TSBSiguiente.Enabled = _cmdBuscar_1.Enabled
        TSBSiguiente.Visible = _cmdBuscar_1.Visible
        TSBEscoger.Enabled = cmdEscoger.Enabled
        TSBEscoger.Visible = cmdEscoger.Visible
        TSBSalir.Visible = cmdSalir.Enabled
        TSBSalir.Enabled = cmdSalir.Enabled
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
            PMLimpiag(grdResultados)
            txtOficinaOpt.Text = ""
            lblDesOficina.Text = ""
            OptionProspecto.Checked = False
            OptionCliente.Checked = False
            cmdBuscar(0).Enabled = False
            cmdBuscar(1).Enabled = False
            optCliente(1).Checked = False
            optCliente(0).Checked = True
            optCliente(0).Focus()
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
            PMObjetoSeguridad(cmdBuscar(0))
        End If
        FMOcultarCampos()
        PLTSEstado()
    End Sub


    Private Sub TSBBuscar_Click(sender As Object, e As EventArgs) Handles TSBBuscar.Click
        If _cmdBuscar_0.Enabled Then cmdBuscar_Click(_cmdBuscar_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(sender As Object, e As EventArgs) Handles TSBSiguiente.Click
        If _cmdBuscar_1.Enabled Then cmdBuscar_Click(_cmdBuscar_1, e)
    End Sub

    Private Sub TSBEscoger_Click(sender As Object, e As EventArgs) Handles TSBEscoger.Click
        If cmdEscoger.Enabled Then cmdEscoger_Click(cmdEscoger, e)
    End Sub

    Private Sub TSBSalir_Click(sender As Object, e As EventArgs) Handles TSBSalir.Click
        If cmdSalir.Enabled Then cmdSalir_Click(cmdSalir, e)
    End Sub

    Private Sub txtValor_TextChanged(sender As Object, e As EventArgs) Handles txtValor.TextChanged
        VLPaso = False
        If Len(txtValor.Text) > 1 Then

        End If
    End Sub
End Class

