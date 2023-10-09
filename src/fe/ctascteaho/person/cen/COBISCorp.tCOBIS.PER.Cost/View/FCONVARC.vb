Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Query
 Public  Partial  Class FconVarCostoClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
	Dim VLMoneda As String = ""
    Dim VLPosGrid As Integer = 0
    Dim VLSucurAux As String = ""
    Dim VLLongitud As Integer = 0
    Dim VLPosDeci As Integer = 0
    Dim VLAuxvalor As String = ""
    Dim VLauxvalorDes As String = ""
	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim Longitud As Integer = 0
        Dim VLPosDeci As Integer = 0
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

                If txtCampo(4).Text = "" Or lblDescripcion(12).Text = "" Then
                    TSBotones.Focus()
                    Exit Sub
                End If


                If txtCampo(2).Text = "" Or lblDescripcion(0).Text = "" Then
                    TSBotones.Focus()
                    Exit Sub
                End If


                If txtCampo(0).Text = "" Or lblDescripcion(1).Text = "" Then
                    TSBotones.Focus()
                    Exit Sub
                End If

                ' TSBotones.Focus()

                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4086")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_servicio_disp", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, lblDescripcion(11).Text)
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, "0")
                PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, IIf(txtCampo(1).Text = "", "0", txtCampo(1).Text))
                PMPasoValores(sqlconn, "@i_desde", 0, SQLMONEY, "0")
                PMPasoValores(sqlconn, "@i_fotmato_fecha", 0, SQLINT2, VGFormatoFechaInt)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_var_costos", True, FMLoadResString(1599)) Then
                    PMMapeaGrid(sqlconn, grdtasas, False)
                    PMChequea(sqlconn)
                    'PMMapeaTextoSGrid(grdtasas)
                    cmdBoton(4).Enabled = True
                    For i As Integer = 1 To 6
                        grdtasas.ColWidth(i) = 12
                    Next i
                    grdtasas.ColWidth(2) = 15
                    grdtasas.ColWidth(1) = 9
                    grdtasas.ColWidth(3) = 15
                    grdtasas.ColWidth(4) = 15
                    grdtasas.ColWidth(5) = 15
                    grdtasas.ColWidth(6) = 20
                    grdtasas.ColWidth(7) = 20
                    grdtasas.ColWidth(8) = 30
                    grdtasas.ColWidth(9) = 15
                    grdtasas.ColWidth(10) = 15
                    grdtasas.ColWidth(11) = 15
                    grdtasas.Row = 0
                    For VTColumn As Integer = 1 To grdtasas.MaxCols
                        grdtasas.Col = VTColumn
                        If grdtasas.Text <> "" And IsNumeric(grdtasas.Text) Then
                            grdtasas.Text = UCase(FMLoadResString(CInt(grdtasas.Text)))
                        End If
                    Next VTColumn
                    For VTi As Integer = 1 To grdtasas.MaxRows
                        grdtasas.RowHeight(VTi) = 12
                    Next VTi
                    grdtasas.Row = 1
                    For VTi As Integer = 1 To grdtasas.MaxRows
                        grdtasas.Row = VTi
                        For VTColumn As Integer = 1 To grdtasas.MaxCols
                            grdtasas.Col = VTColumn
                            VLLongitud = 0
                            If grdtasas.Text <> "" And IsNumeric(grdtasas.Text) Then
                                VLLongitud = Len(grdtasas.Text)
                                If VLLongitud <> 1 Then
                                    If InStr(grdtasas.Text, ".") Then
                                        VLPosDeci = InStr(grdtasas.Text, ".")
                                    End If
                                    If InStr(grdtasas.Text, ",") Then
                                        VLPosDeci = InStr(grdtasas.Text, ",")
                                    End If
                                    If VLPosDeci = VLLongitud - 1 Then
                                        grdtasas.Text = grdtasas.Text + "0"
                                        VLPosDeci = 0
                                    End If

                                End If
                            End If
                        Next VTColumn
                    Next VTi
                    grdtasas.Col = 1
                    If Convert.ToString(grdtasas.Tag) = "" Then
                        grdtasas.Tag = CStr(0)
                    End If
                    VLPosGrid = CInt(grdtasas.MaxRows - Conversion.Val(Convert.ToString(grdtasas.Tag)) + 1)
                    grdtasas.Row = VLPosGrid
                    grdtasas.TopRow = grdtasas.Row
                    grdtasas.Action = 0
                    grdtasas.Focus()
                    PMBloqueaGrid(grdtasas)
                Else
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    grdtasas.Tag = CStr(0)
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                cmdBoton(3).Enabled = Conversion.Val(Convert.ToString(grdtasas.Tag)) = VGMaxRows
            Case 1
                If txtCampo(0).Text <> "" Then
                    txtCampo(1).Text = ""
                    txtCampo(1).Enabled = True
                    lblDescripcion(9).Text = ""
                    txtCampo(0).Text = ""
                    txtCampo(0).Enabled = True
                    lblDescripcion(1).Text = ""
                    lblDescripcion(5).Text = ""
                    lblDescripcion(11).Text = ""
                    VLauxvalorDes = ""
                    VLAuxvalor = ""
                    txtCampo(0).Focus()
                Else
                    If txtCampo(2).Text <> "" Then
                        txtCampo(2).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(2).Enabled = True
                        PMBorrarGrid(grdtasas)
                        cmdBoton(0).Enabled = True
                        cmdBoton(3).Enabled = False
                        txtCampo(2).Focus()
                    Else
                        txtCampo(4).Text = ""
                        lblDescripcion(0).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(5).Text = ""
                        lblDescripcion(9).Text = ""
                        lblDescripcion(11).Text = ""
                        lblDescripcion(12).Text = ""
                        txtCampo(4).Enabled = True
                        PMBorrarGrid(grdtasas)
                        cmdBoton(0).Enabled = True
                        cmdBoton(3).Enabled = False
                        txtCampo(4).Focus()
                    End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
            Case 2
                Me.Close()
                FAyudaSubserv.Dispose()
            Case 3
                grdtasas.Row = grdtasas.MaxRows
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4086")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
                PMPasoValores(sqlconn, "@i_servicio_disp", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT4, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, lblDescripcion(11).Text)
                PMPasoValores(sqlconn, "@i_fotmato_fecha", 0, SQLINT2, VGFormatoFechaInt)
                grdtasas.Col = 9
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdtasas.Text)
                grdtasas.Col = 7
                PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, grdtasas.Text)
                grdtasas.Col = 2
                PMPasoValores(sqlconn, "@i_desde", 0, SQLMONEY, grdtasas.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_var_costos", True, FMLoadResString(1599)) Then
                    PMMapeaGrid(sqlconn, grdtasas, True)
                    PMChequea(sqlconn)
                    grdtasas.Row = 0
                    For VTColumn As Integer = 1 To grdtasas.MaxCols
                        grdtasas.Col = VTColumn
                        If grdtasas.Text <> "" And IsNumeric(grdtasas.Text) Then
                            grdtasas.Text = UCase(FMLoadResString(CInt(grdtasas.Text)))
                        End If
                    Next VTColumn
                    cmdBoton(3).Enabled = Conversion.Val(Convert.ToString(grdtasas.Tag)) = VGMaxRows
                    For VTi As Integer = 1 To grdtasas.MaxRows
                        grdtasas.RowHeight(VTi) = 12
                    Next VTi
                    grdtasas.Col = 1
                    If Convert.ToString(grdtasas.Tag) = "" Then
                        grdtasas.Tag = CStr(0)
                    End If

                    For VTi As Integer = 1 To grdtasas.MaxRows
                        grdtasas.Row = VTi
                        For VTColumn As Integer = 1 To grdtasas.MaxCols
                            grdtasas.Col = VTColumn
                            VLLongitud = 0
                            If grdtasas.Text <> "" And IsNumeric(grdtasas.Text) Then
                                VLLongitud = Len(grdtasas.Text)
                                If VLLongitud <> 1 Then
                                    If InStr(grdtasas.Text, ".") Then
                                        VLPosDeci = InStr(grdtasas.Text, ".")
                                    End If
                                    If InStr(grdtasas.Text, ",") Then
                                        VLPosDeci = InStr(grdtasas.Text, ",")
                                    End If
                                    If VLPosDeci = VLLongitud - 1 Then
                                        grdtasas.Text = grdtasas.Text + "0"
                                        VLPosDeci = 0
                                    End If

                                End If
                            End If
                        Next VTColumn
                    Next VTi



                    VLPosGrid = CInt(grdtasas.MaxRows - Conversion.Val(Convert.ToString(grdtasas.Tag)) + 1)
                    grdtasas.Row = VLPosGrid
                    grdtasas.TopRow = grdtasas.Row
                    grdtasas.Action = 0
                    PMBloqueaGrid(grdtasas)
                Else
                    PMChequea(sqlconn)
                End If

            Case 4
                PLConfigurarImpresion()
        End Select
        PLTSEstado()
    End Sub

    Private Sub FconVarCosto_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        VLPosGrid = -1
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        PLTSEstado()
        txtCampo(4).Focus()
        grdtasas.Sheets(0).OperationMode = FarPoint.Win.Spread.OperationMode.RowMode
        grdtasas.Sheets(0).SelectionBackColor = grdtasasold.ColorSelectedCells
    End Sub

    Private Sub PLLimpiar(ByVal index As Integer)
        If index = 4 Then
            lblDescripcion(11).Text = ""
            lblDescripcion(1).Text = ""
            lblDescripcion(5).Text = ""
            lblDescripcion(9).Text = ""
            lblDescripcion(0).Text = ""
            txtCampo(2).Text = ""
            txtCampo(0).Text = ""
            txtCampo(1).Text = ""
            PMBorrarGrid(grdtasas)

        Else
            lblDescripcion(11).Text = ""
            lblDescripcion(1).Text = ""
            lblDescripcion(5).Text = ""
            lblDescripcion(9).Text = ""
            lblDescripcion(0).Text = ""
            txtCampo(2).Text = ""
            txtCampo(0).Text = ""
            txtCampo(1).Text = ""
            PMBorrarGrid(grdtasas)

        End If

    End Sub

    Private Sub FconVarCosto_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdtasas_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdtasas.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502041))
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                lblDescripcion(1).Text = ""
                lblDescripcion(11).Text = ""
                lblDescripcion(5).Text = ""
                lblDescripcion(9).Text = ""
                txtCampo(1).Text = ""
                PMBorrarGrid(grdtasas)
                VLAuxvalor = ""
                VLauxvalorDes = ""
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                PLTSEstado()
                VLPaso = False
            Case 1
                VLPaso = False
            Case 3
                PMBorrarGrid(grdtasas)
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                PLTSEstado()
                VLPaso = False
            Case 4
                lblDescripcion(1).Text = ""
                lblDescripcion(11).Text = ""
                lblDescripcion(5).Text = ""
                lblDescripcion(9).Text = ""
                lblDescripcion(0).Text = ""
                lblDescripcion(12).Text = ""
                txtCampo(1).Text = ""
                txtCampo(2).Text = ""
                txtCampo(0).Text = ""
                PMBorrarGrid(grdtasas)
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                PLTSEstado()
                VLPaso = False
            Case 2
                lblDescripcion(1).Text = ""
                lblDescripcion(11).Text = ""
                lblDescripcion(5).Text = ""
                lblDescripcion(9).Text = ""
                lblDescripcion(0).Text = ""
                txtCampo(0).Text = ""
                txtCampo(1).Text = ""
                PMBorrarGrid(grdtasas)
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                PLTSEstado()
                VLPaso = False

        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter
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

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_4.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown
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
                    If txtCampo(2).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1259), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VLMoneda)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1596)) Then
                        PMMapeaGrid(sqlconn, FCatalogoServ.grdRegistros, False)
                        PMMapeaTextoGrid(FCatalogoServ.grdRegistros)
                        PMAnchoColumnasGrid(FCatalogoServ.grdRegistros)
                        PMChequea(sqlconn)
                        'If FCatalogoServ.grdRegistros.Rows >= 1 Then FCatalogoServ.grdRegistros.Row = 1
                        VGOperacion = "FCONVAR2-1"
                        FCatalogoServ.ShowPopup(Me)
                        FCatalogoServ.Dispose() '18/05/2016 migracion

                        If lblDescripcion(1).Text <> "" And txtCampo(0).Text <> "" Then
                            VLauxvalorDes = lblDescripcion(1).Text
                            VLAuxvalor = txtCampo(0).Text
                            ' txtCampo(3).Focus()
                        End If

                        If lblDescripcion(1).Text = "" Then
                            txtCampo(0).Text = ""
                            lblDescripcion(11).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(9).Text = ""
                        End If

                    Else
                        PMChequea(sqlconn)
                    End If
                Case 1
                    If txtCampo(2).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1259), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
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
                            PMAnchoColumnasGrid(FRegistros.grdRegistros)
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
                    If VGValores(1) <> "" Then
                        txtCampo(1).Text = VGValores(1)
                        lblDescripcion(9).Text = VGValores(2)
                        VLPaso = True
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 2
                    If txtCampo(4).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1262), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
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
                            PMAnchoColumnasGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTProFinal = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
                            VGOperacion = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(2).Text = VGValores(1)
                        lblDescripcion(0).Text = VGValores(2)
                        VLMoneda = VGValores(3)
                        VLPaso = True
                    Else
                        txtCampo(2).Text = ""
                        lblDescripcion(0).Text = ""
                        PMBorrarGrid(grdtasas)
                        cmdBoton(0).Enabled = True
                        cmdBoton(3).Enabled = False
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
                        PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, VTRango)
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(1595)) Then
                            If VTGrupo = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMAnchoColumnasGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTGrupo = FRegistros.grdRegistros.CtlText
                            FRegistros.grdRegistros.Col = 2
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
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)

                        If VLSucurAux <> txtCampo(0).Text Then
                            PLLimpiar(Index)
                            VLSucurAux = txtCampo(0).Text
                        End If

                        If VGValores(1) <> "" Then
                            txtCampo(4).Text = VGValores(1)
                            lblDescripcion(12).Text = VGValores(2)
                        Else
                            If VLSucurAux <> txtCampo(0).Text Then
                                PLLimpiar(Index)
                                VLSucurAux = txtCampo(0).Text
                            End If
                            txtCampo(4).Text = ""
                            lblDescripcion(12).Text = ""
                            PMBorrarGrid(grdtasas)
                            cmdBoton(0).Enabled = True
                            cmdBoton(3).Enabled = False
                            VGOperacion = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(4).Text = ""
                        lblDescripcion(12).Text = ""
                        VGOperacion = ""
                    End If
            End Select
            PLTSEstado()
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_4.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress
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

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then

                    If (VLauxvalorDes = "" And VLAuxvalor = "") Or VLAuxvalor <> txtCampo(0).Text Then
                        If txtCampo(0).Text <> "" Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4069")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H2")
                            PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, "0")
                            PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(0).Text)
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VLMoneda)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_servicios", True, FMLoadResString(1596)) Then
                                PMMapeaGrid(sqlconn, FCatalogoServ.grdRegistros, False)
                                PMMapeaTextoGrid(FCatalogoServ.grdRegistros)
                                PMAnchoColumnasGrid(FCatalogoServ.grdRegistros)
                                PMChequea(sqlconn)
                                If FCatalogoServ.grdRegistros.Rows >= 1 Then
                                    FCatalogoServ.grdRegistros.Row = 1
                                End If
                                VGOperacion = "FCONVAR2-2"
                                FCatalogoServ.ShowPopup(Me)
                                FCatalogoServ.Dispose() '18/05/2016 migracion
                                If lblDescripcion(1).Text = "" Then
                                    txtCampo(0).Text = ""
                                    lblDescripcion(11).Text = ""
                                    lblDescripcion(5).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(9).Text = ""
                                    txtCampo(0).Focus()
                                End If
                            End If
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(1).Text = ""
                            lblDescripcion(11).Text = ""
                            lblDescripcion(5).Text = ""
                        End If
                    End If
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        If txtCampo(2).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Text = ""
                            txtCampo(2).Focus()
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
                End If
                ' txtCampo(4).Focus()
                'txtCampo(1).Focus()
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text)
                        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                            Dim VTArreglo(3) As String
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
                        PMBorrarGrid(grdtasas)
                        cmdBoton(0).Enabled = True
                        cmdBoton(3).Enabled = False
                    End If
                End If
            Case 3
                If Not VLPaso Then
                    If txtCampo(1).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "G")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(1595)) Then
                        PMChequea(sqlconn)
                    Else
                        txtCampo(3).Text = ""
                        VLPaso = True
                    End If
                End If
            Case 4
                If Not VLPaso Then
                    If CInt(txtCampo(4).Text) > 32000 Then '1418
                        COBISMessageBox.Show(FMLoadResString(1418), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(4).Text = System.String.Empty
                        lblDescripcion(12).Text = System.String.Empty
                        txtCampo(4).Focus()
                        Exit Sub
                    End If
                    If txtCampo(4).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(4).Text)
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(12))
                            PMChequea(sqlconn)

                            If VLSucurAux <> txtCampo(0).Text Then
                                PLLimpiar(Index)
                                VLSucurAux = txtCampo(0).Text
                            End If

                        Else
                            PMChequea(sqlconn)
                            If VLSucurAux <> txtCampo(0).Text Then
                                PLLimpiar(Index)
                                VLSucurAux = txtCampo(0).Text
                            End If


                            lblDescripcion(12).Text = ""
                            txtCampo(4).Text = ""
                            VLPaso = True
                            txtCampo(4).Focus()
                        End If
                    Else
                        lblDescripcion(12).Text = ""
                        PMBorrarGrid(grdtasas)
                        cmdBoton(0).Enabled = True
                        cmdBoton(3).Enabled = False
                    End If

                End If
        End Select
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Sub PLConfigurarImpresion()
        Dim VTNumColumnas As Integer = 6
        Dim VTSepColumnas As Object = New Object() {10, 20, 15, 15, 15, 15}
        Dim VTColumnas As Object = New Object() {1, 8, 2, 3, 5, 10}
        Dim VTCapSubtitulos As Object = New Object() {1904, 1905, 1738, 1668, 1712, 1693, 1760}
        Dim VTValSubtitulos() As String = New String() {"", "", "", "", "", "", "", ""}


        VTValSubtitulos(0) = UCase(FMLoadResString(1902))
        VTValSubtitulos(1) = UCase(VGLogin)
        VTValSubtitulos(2) = txtCampo(4).Text & "  " & lblDescripcion(12).Text
        VTValSubtitulos(3) = txtCampo(2).Text & "  " & lblDescripcion(0).Text
        VTValSubtitulos(4) = txtCampo(0).Text & "  " & lblDescripcion(1).Text
        VTValSubtitulos(5) = lblDescripcion(11).Text & "  " & lblDescripcion(5).Text
        If txtCampo(1).Text = "" Then
            VTValSubtitulos(6) = UCase(FMLoadResString(1784))
        Else
            VTValSubtitulos(6) = txtCampo(1).Text & "  " & lblDescripcion(9).Text
        End If
        Dim VTAlineacion As Object = New Object() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN}
        PMImprimirReporte(grdtasas, VTNumColumnas, VTColumnas, VTSepColumnas, 1903, VTCapSubtitulos, VTValSubtitulos, VTAlineacion, CG_LANDSCAPE)
    End Sub
    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_4.MouseDown, _txtCampo_0.MouseDown, _txtCampo_2.MouseDown, _txtCampo_1.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 4
                My.Computer.Clipboard.Clear()
        End Select
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_3.Enabled
        TSBSiguientes.Visible = _cmdBoton_3.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
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

    Private Sub grdtasas_Leave(sender As Object, e As EventArgs) Handles grdtasas.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


