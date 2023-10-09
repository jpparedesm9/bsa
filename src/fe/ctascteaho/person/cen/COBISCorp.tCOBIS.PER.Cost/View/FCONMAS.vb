Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FConsulMasClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTFilas As Integer = 0
        Dim VTRango As String = String.Empty
        TSBotones.Focus()
        Select Case Index
            Case 0
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1284), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1294), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1267), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1423), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1417), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                VTRango = "0"
                PMLimpiaGrid(grdRegistros)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFormatoFechaInt)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4083")
                PMPasoValores(sqlconn, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, lblDescripcion(9).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_suc", 0, SQLINT2, txtCampo(1).Text)

                If txtCampo(5).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_ser_disp", 0, SQLINT2, txtCampo(5).Text)
                End If
                If lblDescripcion(2).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Text)
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_con_costot_linea", True, FMLoadResString(2527)) Then
                    If VTRango = "0" Then
                        PMMapeaGrid(sqlconn, grdRegistros, False)
                    Else
                        PMMapeaGrid(sqlconn, grdRegistros, True)
                    End If
                    PMMapeaTextoGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMChequea(sqlconn)
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                        grdRegistros.ColAlignment(3) = 1
                        grdRegistros.ColAlignment(4) = 1
                        grdRegistros.ColAlignment(5) = 1
                        grdRegistros.ColAlignment(6) = 1
                        grdRegistros.ColAlignment(7) = 1
                        grdRegistros.ColAlignment(8) = 1
                        grdRegistros.ColAlignment(9) = 1
                        grdRegistros.ColAlignment(10) = 1
                    Else
                        cmdBoton(3).Enabled = False
                    End If
                Else
                    cmdBoton(3).Enabled = False
                    'PMLimpiaGrid(grdRegistros)
                    'PMMapeaGrid(sqlconn, grdRegistros, False)
                    PLTSEstado()
                    PMChequea(sqlconn)
                    Exit Sub
                End If
                VTFilas = Conversion.Val(Convert.ToString(grdRegistros.Tag))
                If VTFilas = VGMaxRows + 5 Then cmdBoton(3).Enabled = True
                grdRegistros.Col = 1
                PLTSEstado()
            Case 1
                If txtCampo(5).Text <> "" Then
                    txtCampo(5).Text = ""
                    txtCampo(5).Enabled = True
                    lblDescripcion(8).Text = ""
                    lblDescripcion(2).Text = ""
                    lblDescripcion(1).Text = ""
                    txtCampo(5).Focus()
                Else
                    If txtCampo(1).Text <> "" Then
                        txtCampo(1).Text = ""
                        txtCampo(1).Enabled = True
                        lblDescripcion(4).Text = ""
                        txtCampo(1).Focus()
                    Else
                        If txtCampo(2).Text <> "" Then
                            txtCampo(2).Text = ""
                            txtCampo(2).Enabled = True
                            lblDescripcion(3).Text = ""
                            txtCampo(2).Focus()
                        Else
                            If txtCampo(4).Text <> "" Then
                                txtCampo(4).Text = ""
                                lblDescripcion(7).Text = ""
                                lblDescripcion(9).Text = ""
                                lblDescripcion(11).Text = ""
                                txtCampo(4).Enabled = True
                                txtCampo(4).Focus()
                            Else
                                If txtCampo(3).Text <> "" Then
                                    txtCampo(3).Text = ""
                                    txtCampo(3).Enabled = True
                                    lblDescripcion(0).Text = ""
                                    txtCampo(3).Focus()
                                Else
                                    If txtCampo(0).Text <> "" Then
                                        txtCampo(0).Text = ""
                                        txtCampo(0).Enabled = True
                                        lblDescripcion(10).Text = ""
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
                VLPaso = True
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
                PMLimpiaGrid(grdRegistros)
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                PLTSEstado()
            Case 2
                Me.Close()
            Case 3
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 12
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4083")
                PMPasoValores(sqlconn, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, lblDescripcion(9).Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_suc", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFormatoFechaInt)
                If txtCampo(5).Text <> "" Then
                    grdRegistros.Col = 10
                    PMPasoValores(sqlconn, "@i_ser_disp", 0, SQLINT2, txtCampo(5).Text)
                    PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
                Else
                    PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
                End If
                If lblDescripcion(2).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Text)
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_con_costot_linea", True, FMLoadResString(1591)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdBoton(3).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows + 5
                    grdRegistros.Row = 1
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                        grdRegistros.ColAlignment(3) = 1
                        grdRegistros.ColAlignment(4) = 1
                        grdRegistros.ColAlignment(5) = 1
                        grdRegistros.ColAlignment(6) = 1
                        grdRegistros.ColAlignment(7) = 1
                        grdRegistros.ColAlignment(8) = 1
                        grdRegistros.ColAlignment(9) = 1
                        grdRegistros.ColAlignment(10) = 1
                    Else
                        cmdBoton(3).Enabled = False
                    End If
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub FConsulMas_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(3))
        cmdBoton(3).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub FConsulMas_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub PMSubserv()
        If VGDetalle(0) = "S" Then
            If txtCampo(5).Text = "" Then
                lblDescripcion(8).Text = VGDetalle(1)
                lblDescripcion(1).Text = VGDetalle(2)
                txtCampo(5).Text = VGDetalle(3)
                lblDescripcion(2).Text = VGDetalle(4)
                cmdBoton(3).Enabled = False
                PMLimpiaGrid(grdRegistros)
            Else
                lblDescripcion(8).Text = VGDetalle(1)
                lblDescripcion(1).Text = VGDetalle(2)
                lblDescripcion(2).Text = VGDetalle(3)
                cmdBoton(3).Enabled = False
                PMLimpiaGrid(grdRegistros)
            End If
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False


    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_0.TextChanged, _txtCampo_3.TextChanged, _txtCampo_2.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_0.Enter, _txtCampo_3.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1659))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1068))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1776))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1663))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1156))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_0.KeyDown, _txtCampo_3.KeyDown, _txtCampo_2.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            'VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_prod_bancario"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4002")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(10).Text = VGACatalogo.Descripcion
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                Case 1
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
                            txtCampo(1).Text = VGValores(1)
                            lblDescripcion(4).Text = VGValores(2)
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(4).Text = ""
                            VGOperacion = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        txtCampo(1).Text = ""
                        lblDescripcion(4).Text = ""
                        VGOperacion = ""
                        PMChequea(sqlconn)
                    End If
                Case 2
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1464), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Text = ""
                        lblDescripcion(3).Text = ""
                        VLPaso = True
                        txtCampo(3).Focus()
                        Exit Sub
                    Else
                        PMCatalogo("A", "pe_categoria", txtCampo(2), lblDescripcion(3), FRegistros)
                        VLPaso = True
                    End If
                Case 3
                    PMCatalogo("A", "cc_tipo_banca", txtCampo(3), lblDescripcion(0), FRegistros)
                    VLPaso = True
                Case 4
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
                            txtCampo(4).Text = VGValores(1)
                            lblDescripcion(9).Text = VGValores(2)
                            lblDescripcion(7).Text = VGValores(3)
                            If lblDescripcion(9).Text = "0" Then
                                lblDescripcion(11).Text = "PESOS"
                            Else
                                lblDescripcion(11).Text = "DOLARES"
                            End If
                            For i As Integer = 1 To 10
                                VGValores(i) = ""
                            Next i
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        'COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                        VLPaso = True
                    Else
                        VGOperacion = ""
                        VGTipo = ""
                        PMChequea(sqlconn)
                    End If
                Case 5
                    VGForma = "FConsulMas"
                    FAyudaSubserv2.ShowPopup(Me)
                    If VGDetalle(1) <> "" Then
                        PMSubserv()
                        VLPaso = True
                    End If
                    FAyudaSubserv2.Dispose() '18/05/2016 migracion
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_0.KeyPress, _txtCampo_3.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 2, 3
                KeyAscii = FMValidaTipoDato("A", KeyAscii)
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
            Case 0, 1, 4, 5, 6, 7
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_0.Leave, _txtCampo_3.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4003")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(10))
                            PMChequea(sqlconn)
                        Else
                            txtCampo(0).Text = ""
                            lblDescripcion(10).Text = ""
                            txtCampo(0).Focus()
                            VLPaso = True
                            PMChequea(sqlconn)
                        End If
                    Else
                        lblDescripcion(10).Text = ""
                    End If
                End If
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
                            PMMapeaObjeto(sqlconn, lblDescripcion(4))
                            PMChequea(sqlconn)
                        Else
                            lblDescripcion(4).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            PMChequea(sqlconn)
                        End If
                    Else
                        lblDescripcion(4).Text = ""
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1464), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Text = ""
                        lblDescripcion(3).Text = ""
                        VLPaso = True
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                    If txtCampo(2).Text = "" Then
                        lblDescripcion(3).Text = ""
                        Exit Sub
                    End If
                    PMCatalogo("V", "pe_categoria", txtCampo(2), lblDescripcion(3), Nothing)
                End If
            Case 3
                If Not VLPaso Then
                    If txtCampo(3).Text = "" Then
                        lblDescripcion(0).Text = ""
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                    PMCatalogo("V", "cc_tipo_banca", txtCampo(3), lblDescripcion(0), Nothing)
                End If
            Case 4
                If Not VLPaso Then
                    If txtCampo(4).Text <> "" Then
                        If txtCampo(4).Text <> "3" And txtCampo(4).Text <> "4" Then
                            COBISMessageBox.Show(FMLoadResString(1142), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(4).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(9).Text = ""
                            lblDescripcion(11).Text = ""
                            txtCampo(4).Focus()
                            Exit Sub
                        End If
                        VGOperacion = "sp_promon"
                        VGTipo = "Q"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4076")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(4).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1112)) Then
                            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            FRegistros.ShowPopup(Me)
                            If VGValores(1) <> "" Then
                                lblDescripcion(9).Text = VGValores(2)
                                lblDescripcion(7).Text = VGValores(3)
                                If lblDescripcion(9).Text = "0" Then
                                    lblDescripcion(11).Text = "PESOS"
                                Else
                                    lblDescripcion(11).Text = "DOLARES"
                                End If
                            Else
                                lblDescripcion(7).Text = ""
                                lblDescripcion(9).Text = ""
                                lblDescripcion(11).Text = ""
                                txtCampo(4).Text = ""
                                txtCampo(4).Focus()

                            End If
                            For i As Integer = 1 To 5
                                VGValores(i) = ""
                            Next i
                            FRegistros.Dispose() '18/05/2016 migracion
                            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                        Else
                            VLPaso = True
                            txtCampo(2).Text = ""
                            lblDescripcion(9).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(11).Text = ""
                            txtCampo(4).Focus()
                            PMChequea(sqlconn)
                        End If
                    Else
                        lblDescripcion(9).Text = ""
                        lblDescripcion(7).Text = ""
                        lblDescripcion(11).Text = ""
                    End If
                    VGOperacion = ""
                    VGTipo = ""
                End If
            Case 5
                If Not VLPaso Then
                    If txtCampo(5).Text <> "" Then
                        VGForma = "FConsulMas"
                        FAyudaSubserv2.ShowPopup(Me)
                        If VGDetalle(1) <> "" Then
                            PMSubserv()
                        Else
                            lblDescripcion(8).Text = ""
                            lblDescripcion(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(5).Text = ""
                            cmdBoton(3).Enabled = False
                            PMLimpiaGrid(grdRegistros)
                            txtCampo(5).Focus()
                            VLPaso = True
                        End If
                        FAyudaSubserv2.Dispose() '18/05/2016 migracion
                    Else
                        lblDescripcion(8).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(2).Text = ""
                        cmdBoton(3).Enabled = False
                        PMLimpiaGrid(grdRegistros)
                    End If
                End If
            Case 6
                If Not VLPaso Then
                    If txtCampo(6).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(6).Text)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(9).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(1595)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(6))
                            PMChequea(sqlconn)
                        Else
                            txtCampo(6).Text = ""
                            lblDescripcion(6).Text = ""
                            txtCampo(6).Focus()
                            PMChequea(sqlconn)
                            VLPaso = True
                        End If
                    Else
                        VLPaso = True
                        lblDescripcion(5).Text = ""
                    End If
                End If
            Case 7
                If Not VLPaso Then
                    If txtCampo(6).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(6).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT2, txtCampo(7).Text)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "G")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(6).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(1595)) Then
                        PMChequea(sqlconn)
                    Else
                        txtCampo(7).Text = ""
                        txtCampo(7).Focus()
                        VLPaso = True
                        PMChequea(sqlconn)
                    End If
                End If
        End Select
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_1.MouseDown, _txtCampo_5.MouseDown, _txtCampo_4.MouseDown, _txtCampo_0.MouseDown, _txtCampo_3.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Visible = _cmdBoton_3.Visible
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBSiguientes.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Enabled
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2523))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.ClickEvent
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
    End Sub

End Class


