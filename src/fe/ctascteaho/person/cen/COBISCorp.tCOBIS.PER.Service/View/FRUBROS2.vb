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
Partial Public Class FRubrosClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0
    Dim VLMoneda As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_2.Click, _cmdBoton_5.Click, _cmdBoton_3.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTFilas As Integer
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim Response As String = ""
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
        TSBotones.Focus()
        Select Case Index
            Case 0
                If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1272), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4015")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT4, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_cod_subser", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_cod_detalle", 0, SQLCHAR, lblDescripcion(11).Text)
                PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, txtCampo(3).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rubros", True, FMLoadResString(1602)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(3))
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                Else
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                cmdBoton_Click(cmdBoton(5), New EventArgs())
                PLTSEstado()
            Case 1
                If txtCampo(0).Text <> "" Or txtCampo(1).Text <> "" Or txtCampo(3).Text <> "" Then
                    txtCampo(3).Text = ""
                    txtCampo(3).Enabled = True
                    lblDescripcion(3).Text = ""
                    txtCampo(1).Text = ""
                    txtCampo(1).Enabled = True
                    lblDescripcion(9).Text = ""
                    txtCampo(0).Text = ""
                    txtCampo(0).Enabled = True
                    lblDescripcion(1).Text = ""
                    lblDescripcion(5).Text = ""
                    lblDescripcion(11).Text = ""
                    txtCampo(0).Focus()
                    cmdBoton(3).Enabled = False
                    cmdBoton(4).Enabled = False
                    PLTSEstado()
                Else
                    If txtCampo(2).Text <> "" Then
                        txtCampo(2).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(2).Enabled = True
                        txtCampo(2).Focus()
                    Else
                        txtCampo(4).Text = ""
                        For i As Integer = 0 To 12
                            lblDescripcion(i).Text = ""
                        Next i
                        txtCampo(4).Enabled = True
                        txtCampo(4).Focus()
                    End If
                End If
                PMObjetoSeguridad(cmdBoton(0))
                'PMObjetoSeguridad(cmdBoton(4))
                'cmdBoton(4).Enabled = False
                PMLimpiaGrid(grdRubros)
                PLTSEstado()
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            Case 2
                Me.Close()
                'FAyudaProdFinal.Close() '19/05/2016 migracion
                FAyudaProdFinal.Dispose()
                'FAyudaSubserv.Close() '19/05/2016 migracion
                FAyudaSubserv.Dispose()
            Case 3
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4013")
                grdRubros.Row = grdRubros.Rows - 1
                grdRubros.Col = 1
                PMPasoValores(sqlconn, "@i_cod_subser", 0, SQLINT2, grdRubros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corubros", True, FMLoadResString(1560)) Then
                    PMMapeaGrid(sqlconn, grdRubros, True)
                    PMMapeaTextoGrid(grdRubros)
                    PMAnchoColumnasGrid(grdRubros)
                    PMChequea(sqlconn)
                    If Conversion.Val(Convert.ToString(grdRubros.Tag)) > 0 Then
                        grdRubros.ColWidth(2) = 1
                        grdRubros.ColWidth(4) = 1
                        grdRubros.ColWidth(6) = 1
                        grdRubros.ColWidth(8) = 1
                        grdRubros.ColWidth(10) = 1
                        grdRubros.ColWidth(14) = 1
                    End If
                    cmdBoton(3).Enabled = Conversion.Val(Convert.ToString(grdRubros.Tag)) = VGMaxRows
                    PLTSEstado()
                    grdRubros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
            Case 4
                Response = CStr("¿" & COBISMsgBox.MsgBox(FMLoadResString(1858) & (lblDescripcion(3).Text) & "?", DgDef, FMLoadResString(1867)))
                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4016")
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLINT2, lblDescripcion(3).Text)
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rubros", True, FMLoadResString(1609)) Then
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = False
                        PLTSEstado()
                    Else
                        PMChequea(sqlconn)
                    End If
                    cmdBoton_Click(cmdBoton(5), New EventArgs())
                Else
                    Exit Sub
                End If
            Case 5
                If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4013")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corubros", True, FMLoadResString(1560)) Then
                    PMMapeaGrid(sqlconn, grdRubros, False)
                    PMMapeaTextoGrid(grdRubros)
                    PMAnchoColumnasGrid(grdRubros)
                    PMChequea(sqlconn)
                    If Conversion.Val(Convert.ToString(grdRubros.Tag)) > 0 Then
                        grdRubros.ColIsVisible(2) = False
                        grdRubros.ColIsVisible(4) = False
                        grdRubros.ColIsVisible(6) = False
                        grdRubros.ColIsVisible(8) = False
                        grdRubros.ColIsVisible(10) = False
                        grdRubros.ColIsVisible(14) = False
                    End If

                    VTFilas = Conversion.Val(Convert.ToString(grdRubros.Tag))
                    If VTFilas = VGMaxRows Then cmdBoton(3).Enabled = True

                    PLTSEstado()
                    grdRubros.Row = 1
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub FRubros_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMObjetoSeguridad(cmdBoton(5))
        PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(0))
        cmdBoton(3).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub FRubros_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRubros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRubros.ClickEvent
        grdRubros.Col = 0
        grdRubros.SelStartCol = 1
        grdRubros.SelEndCol = grdRubros.Cols - 1
        If grdRubros.Row = 0 Then
            grdRubros.SelStartRow = 1
            grdRubros.SelEndRow = 1
        Else
            grdRubros.SelStartRow = grdRubros.Row
            grdRubros.SelEndRow = grdRubros.Row
        End If
    End Sub

    Private Sub grdRubros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRubros.DblClick
        Dim VTRow As Integer = grdRubros.Row
        grdRubros.Row = 1
        grdRubros.Col = 1
        If grdRubros.CtlText <> "" Then
            grdRubros.Row = VTRow
            PMMarcarRubro()
        End If
    End Sub

    Private Sub grdRubros_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRubros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1392))
    End Sub

    Private Sub grdRubros_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdRubros.KeyUp
        grdRubros.Col = 0
        grdRubros.SelStartCol = 1
        grdRubros.SelEndCol = grdRubros.Cols - 1
        If grdRubros.Row = 0 Then
            grdRubros.SelStartRow = 1
            grdRubros.SelEndRow = 1
        Else
            grdRubros.SelStartRow = grdRubros.Row
            grdRubros.SelEndRow = grdRubros.Row
        End If
    End Sub

    Private Sub PMMarcarRubro()
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(0).Enabled = False
        grdRubros.Col = 1
        lblDescripcion(3).Text = grdRubros.CtlText
        txtCampo(4).Enabled = False
        grdRubros.Col = 2
        txtCampo(2).Text = grdRubros.CtlText
        txtCampo(2).Enabled = False
        grdRubros.Col = 3
        lblDescripcion(0).Text = grdRubros.CtlText
        grdRubros.Col = 4
        txtCampo(0).Text = grdRubros.CtlText
        txtCampo(0).Enabled = False
        grdRubros.Col = 5
        lblDescripcion(1).Text = grdRubros.CtlText
        grdRubros.Col = 6
        lblDescripcion(11).Text = grdRubros.CtlText
        grdRubros.Col = 7
        lblDescripcion(5).Text = grdRubros.CtlText
        grdRubros.Col = 8
        lblDescripcion(6).Text = grdRubros.CtlText
        grdRubros.Col = 9
        lblDescripcion(4).Text = grdRubros.CtlText
        grdRubros.Col = 10
        lblDescripcion(7).Text = grdRubros.CtlText
        grdRubros.Col = 11
        lblDescripcion(8).Text = grdRubros.CtlText
        grdRubros.Col = 12
        lblDescripcion(10).Text = grdRubros.CtlText
        If lblDescripcion(10).Text = "R" Then
            lblDescripcion(2).Text = "REGIONAL"
        End If
        grdRubros.Col = 14
        txtCampo(1).Text = grdRubros.CtlText
        txtCampo(1).Enabled = False
        grdRubros.Col = 13
        lblDescripcion(9).Text = grdRubros.CtlText
        grdRubros.Col = 15
        txtCampo(3).Text = grdRubros.CtlText
        txtCampo(3).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub PMSubserv()
        If VGDetalle(0) = "S" Then
            If txtCampo(0).Text = "" Then
                lblDescripcion(1).Text = VGDetalle(1)
                lblDescripcion(5).Text = VGDetalle(2)
                txtCampo(0).Text = VGDetalle(3)
                lblDescripcion(11).Text = VGDetalle(4)
            Else
                lblDescripcion(1).Text = VGDetalle(1)
                lblDescripcion(5).Text = VGDetalle(2)
                lblDescripcion(11).Text = VGDetalle(3)
            End If
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1711))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1774))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1666))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1386))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTFilas As Integer = 0
        Dim VTCodigo As String = String.Empty
        Dim VTMoneda As String = String.Empty
        Dim VTProFinal As String = String.Empty
        Dim VTGrupo As String = String.Empty
        Dim VTRango As String = String.Empty
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    FAyudaSubserv.ShowPopup(Me)
                    If VGDetalle(1) <> "" Then
                        PMSubserv()
                        VLPaso = True
                    Else
                        lblDescripcion(1).Text = ""
                        lblDescripcion(11).Text = ""
                        lblDescripcion(5).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        VLPaso = True
                    End If
                    FAyudaSubserv.Dispose() '18/05/2016 migracion
                Case 1
                    If txtCampo(2).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Focus()
                        Exit Sub
                    End If
                    VLPaso = True
                    VGOperacion = "sp_help_rango_pe"
                    VGTipo = "T"
                    VTFilas = VGMaxRows
                    VTCodigo = "0"
                    VTMoneda = VLMoneda
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCodigo)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VTMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502081)) Then
                            If VTCodigo = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTCodigo = FRegistros.grdRegistros.CtlText
                            FRegistros.grdRegistros.Col = 3
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTMoneda = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            VGOperacion = ""
                            VGTipo = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    txtCampo(3).Text = ""
                    If VGValores(1) <> "" Then
                        txtCampo(1).Text = VGValores(1)
                        lblDescripcion(9).Text = VGValores(2)
                        VLPaso = True
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 2
                    If txtCampo(4).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(4).Focus()
                        Exit Sub
                    End If
                    VTFilas = VGMaxRows
                    VTProFinal = "0"
                    VGOperacion = "sp_prodfin2"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text)
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
                            lblDescripcion(0).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(3).Text = ""
                            lblDescripcion(9).Text = ""
                            VGOperacion = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(2).Text = VGValores(1)
                        lblDescripcion(0).Text = VGValores(2)
                        VLMoneda = VGValores(3)
                        txtCampo(1).Text = ""
                        txtCampo(3).Text = ""
                        lblDescripcion(9).Text = ""
                        VLPaso = True
                    Else
                        txtCampo(2).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(1).Text = ""
                        txtCampo(3).Text = ""
                        lblDescripcion(9).Text = ""
                        VLMoneda = ""
                        VGOperacion = ""
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 3
                    If txtCampo(1).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    VGOperacion = "sp_help_rango_pe"
                    VGTipo = "G"
                    VTFilas = VGMaxRows
                    VTGrupo = "0"
                    VTRango = "0"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "G")
                        PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT2, VTGrupo)
                        PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, VTRango)
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502089)) Then
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
                            If FRegistros.grdRegistros.Cols > 2 Then
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
                    If VGACatalogo.Codigo <> "" Then
                        txtCampo(3).Text = VGACatalogo.Codigo
                        VLPaso = True
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 4
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(4).Text = VGValores(1)
                            lblDescripcion(12).Text = VGValores(2)
                        Else
                            txtCampo(4).Text = ""
                            lblDescripcion(12).Text = ""
                            VGOperacion = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        'TBA 05/07/2016 Se limpian campos dependientes
                        txtCampo(1).Text = ""
                        txtCampo(2).Text = ""
                        txtCampo(3).Text = ""
                        lblDescripcion(0).Text = ""

                        lblDescripcion(0).Text = ""
                        lblDescripcion(9).Text = ""
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(4).Text = ""
                        lblDescripcion(12).Text = ""
                        'TBA 05/07/2016 Se limpian campos dependientes
                        txtCampo(1).Text = ""
                        txtCampo(2).Text = ""
                        txtCampo(3).Text = ""
                        lblDescripcion(0).Text = ""

                        lblDescripcion(0).Text = ""
                        lblDescripcion(9).Text = ""
                        VGOperacion = ""
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        FAyudaSubserv.ShowPopup(Me)
                        If VGDetalle(1) <> "" Then
                            PMSubserv()
                        Else
                            lblDescripcion(1).Text = ""
                            lblDescripcion(11).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(0).Text = ""
                            txtCampo(0).Focus()
                            VLPaso = True
                        End If
                        FAyudaSubserv.Dispose() '18/05/2016 migracion
                    Else
                        lblDescripcion(1).Text = ""
                        lblDescripcion(11).Text = ""
                        lblDescripcion(5).Text = ""
                        VLPaso = True
                    End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")

            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        If txtCampo(2).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Text = ""
                            txtCampo(2).Focus()
                            Exit Sub
                        End If
                        If CDbl(txtCampo(1).Text) > 251 Then
                            COBISMessageBox.Show(FMLoadResString(1000), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VLMoneda)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502081)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(9))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(1).Text = ""
                            lblDescripcion(9).Text = ""
                            txtCampo(1).Focus()
                            VLPaso = True
                        End If
                    Else
                        VLPaso = True
                        lblDescripcion(9).Text = ""
                    End If
                    txtCampo(3).Text = ""
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                'COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(1382))
            Case 2
                If Not VLPaso Then
                    If txtCampo(4).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Text = ""
                        VLPaso = True
                        txtCampo(4).Focus()
                        Exit Sub
                    End If
                    If txtCampo(2).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text)
                        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                            Dim VTArreglo(2) As String
                            FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            lblDescripcion(0).Text = VTArreglo(1)
                            VLMoneda = VTArreglo(2)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(0).Text = ""
                            txtCampo(2).Text = ""
                            VLMoneda = ""
                            txtCampo(2).Focus()
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(0).Text = ""
                    End If
                    txtCampo(1).Text = ""
                    txtCampo(3).Text = ""
                    lblDescripcion(9).Text = ""
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
            Case 3
                If Not VLPaso Then
                    If txtCampo(3).Text <> "" Then
                        If txtCampo(1).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            VLPaso = True
                            txtCampo(1).Focus()
                            txtCampo(3).Text = ""
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT2, txtCampo(3).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "G")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502089)) Then
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            txtCampo(3).Focus()
                            VLPaso = True
                        End If
                    End If
                End If
            Case 4
                If Not VLPaso Then
                    If txtCampo(4).Text <> "" Then
                        If CDbl(txtCampo(4).Text) > 32000 Then
                            COBISMessageBox.Show(FMLoadResString(1263), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(4).Text = ""
                            txtCampo(4).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(4).Text)
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(12))
                            PMChequea(sqlconn)
                        Else
                            lblDescripcion(12).Text = ""
                            txtCampo(4).Text = ""
                            VLPaso = True
                            txtCampo(4).Focus()
                            PMChequea(sqlconn)
                        End If
                    Else
                        lblDescripcion(12).Text = ""
                    End If
                    'TBA 05/07/2016 Se limpian campos dependientes
                    txtCampo(1).Text = ""
                    txtCampo(2).Text = ""
                    txtCampo(3).Text = ""
                    lblDescripcion(0).Text = ""
                    lblDescripcion(9).Text = ""

                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        End Select
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_4.MouseDown, _txtCampo_3.MouseDown, _txtCampo_0.MouseDown, _txtCampo_2.MouseDown, _txtCampo_1.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4
                My.Computer.Clipboard.Clear()
        End Select
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_5.Enabled
        TSBBuscar.Visible = _cmdBoton_5.Visible
        TSBSiguiente.Enabled = _cmdBoton_3.Enabled
        TSBSiguiente.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBEliminar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub grdRubros_Leave(sender As Object, e As EventArgs) Handles grdRubros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub
End Class


