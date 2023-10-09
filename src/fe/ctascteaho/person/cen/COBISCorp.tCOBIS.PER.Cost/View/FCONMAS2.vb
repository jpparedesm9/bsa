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
 Public  Partial  Class FConsulMas2Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
    Dim VLFormatoFecha As String = ""

	Sub PMLimpiaGrid(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISGrid)
		grdGrid.Rows = 2
		grdGrid.Cols = 2
		For i As Integer = 0 To 1
			grdGrid.Col = i
			For j As Integer = 0 To 1
				grdGrid.Row = j
				grdGrid.CtlText = ""
			Next j
		Next i
		grdGrid.Tag = ""
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_4.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTRango As String = String.Empty
        TSBotones.Focus()
        Select Case Index
            Case 0
                If mskFecha.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1429), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                    Exit Sub
                End If

                If mskFecha.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1429), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                    Exit Sub
                End If


                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1284), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
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
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4084")
                PMPasoValores(sqlconn, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, lblDescripcion(9).Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_suc", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_fecha_vig", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, VGFormatoFecha, "mm/dd/yyyy"))
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
                If txtCampo(5).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_ser_disp", 0, SQLINT2, txtCampo(5).Text)
                End If
                If lblDescripcion(2).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Text)
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_con_costot_no_linea", True, FMLoadResString(1591)) Then
                    If VTRango = "0" Then
                        PMMapeaGrid(sqlconn, grdRegistros, False)
                    Else
                        PMMapeaGrid(sqlconn, grdRegistros, True)
                    End If
                    PMMapeaTextoGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMAgregarDecimal(grdRegistros, 9)
                    PMAgregarDecimal(grdRegistros, 10)
                    PMAgregarDecimal(grdRegistros, 11)
                    PMChequea(sqlconn)
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                        grdRegistros.ColAlignment(1) = 1
                        grdRegistros.ColAlignment(2) = 1
                        grdRegistros.ColAlignment(3) = 1
                        grdRegistros.ColAlignment(4) = 1
                        grdRegistros.ColAlignment(5) = 1
                        grdRegistros.ColAlignment(6) = 1
                        grdRegistros.ColAlignment(7) = 1
                        grdRegistros.ColAlignment(8) = 1
                        grdRegistros.ColAlignment(9) = 1
                        grdRegistros.ColAlignment(10) = 1
                        grdRegistros.ColAlignment(11) = 1
                        grdRegistros.ColAlignment(12) = 1
                        grdRegistros.ColAlignment(13) = 1
                        cmdBoton(4).Enabled = True
                    Else
                        cmdBoton(3).Enabled = False
                        cmdBoton(4).Enabled = False
                    End If
                    grdRegistros.Col = 1
                    PMAnchoColumnasGrid(grdRegistros)
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows + 5 Then cmdBoton(3).Enabled = True
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdRegistros)
                    cmdBoton(3).Enabled = False
                    cmdBoton(4).Enabled = False
                End If
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
                                        txtCampo(0).Focus()
                                    Else
                                        If mskFecha.Text <> "" Then
                                            mskFecha.Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
                                            mskFecha.Focus()
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
                VLPaso = True
                PMLimpiaGrid(grdRegistros)
                PMObjetoSeguridad(cmdBoton(0))
                PMObjetoSeguridad(cmdBoton(3))
                PMObjetoSeguridad(cmdBoton(4))
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            Case 2
                Me.Close()
            Case 3
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 13
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4084")
                PMPasoValores(sqlconn, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, lblDescripcion(9).Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_suc", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_fecha_vig", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, VGFormatoFecha, "mm/dd/yyyy"))
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
                If txtCampo(5).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_ser_disp", 0, SQLINT2, txtCampo(5).Text)
                End If
                If lblDescripcion(2).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Text)
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_con_costot_no_linea", True, FMLoadResString(1591)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMMapeaTextoGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMAgregarDecimal(grdRegistros, 9)
                    PMAgregarDecimal(grdRegistros, 10)
                    PMAgregarDecimal(grdRegistros, 11)
                    PMChequea(sqlconn)
                    cmdBoton(3).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = VGMaxRows + 5
                    grdRegistros.Row = 1
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdRegistros)
                    cmdBoton(3).Enabled = False
                    cmdBoton(4).Enabled = False
                End If
            Case 4
                    PLConfirmar()
        End Select
        PLTSEstado()
    End Sub

    Private Sub FConsulMas2_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        mskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        PMBotonSeguridad(Me, 3)
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        mskFecha.Focus()
        PLTSEstado()

    End Sub

    Private Sub FConsulMas2_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1371) & "[" & VGFormatoFecha & "]")
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
        Dim VTValido As Integer = 0
        Dim VLFecha As String = ""
        VLFecha = VGFechaProceso
        If mskFecha.ClipText <> "" Then
            VTValido = FMVerFormato(mskFecha.Text, VGFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(1378), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Mask = ""
                mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
                mskFecha.Focus()
                Exit Sub
            End If
        End If
        If mskFecha.Text <> FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha) Then
            If FMDateDiff("d", FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha), mskFecha.Text, VGFormatoFecha) < 0 Then
                COBISMessageBox.Show(FMLoadResString(1368), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskFecha.Mask = ""
                mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
                mskFecha.Focus()
                mskFecha.Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
                Exit Sub
            End If
        End If
    End Sub

    Private Sub PMSubserv()
        If VGDetalle(0) = "S" Then
            If txtCampo(5).Text = "" Then
                txtCampo(5).Text = VGDetalle(3)
                lblDescripcion(8).Text = VGDetalle(1)
                lblDescripcion(2).Text = VGDetalle(4)
                lblDescripcion(1).Text = VGDetalle(2)
                PMLimpiaGrid(grdRegistros)
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
            Else
                lblDescripcion(8).Text = VGDetalle(1)
                lblDescripcion(1).Text = VGDetalle(2)
                lblDescripcion(2).Text = VGDetalle(3)
                PMLimpiaGrid(grdRegistros)
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
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
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1476))
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
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_prod_bancario"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4002")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
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
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
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
                        PMChequea(sqlconn)
                        txtCampo(1).Text = ""
                        lblDescripcion(4).Text = ""
                        VGOperacion = ""
                    End If
                Case 2
                    PMCatalogo("A", "pe_categoria", txtCampo(2), lblDescripcion(3), FRegistros)
                    VLPaso = True
                Case 3
                    PMCatalogo("A", "cc_tipo_banca", txtCampo(3), lblDescripcion(0), FRegistros)
                    VLPaso = True
                Case 4
                    VGOperacion = "sp_promon"
                    VGTipo = "H"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4075")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1532)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
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
                        Else
                            txtCampo(4).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(9).Text = ""
                            lblDescripcion(11).Text = ""
                            txtCampo(4).Focus()
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                        VGTipo = ""
                    End If
                    VLPaso = True
                Case 5
                    FAyudaSubserv2.ShowPopup(Me)
                    VGForma = "FConsulMas2"
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
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(10).Text = ""
                            txtCampo(0).Focus()
                            VLPaso = True
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
                            lblDescripcion(4).Text = ""
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
                            PMChequea(sqlconn)
                            lblDescripcion(4).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(4).Text = ""
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text = "" Then
                        lblDescripcion(3).Text = ""
                        Exit Sub
                    End If
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Text = ""
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                    PMCatalogo("V", "pe_categoria", txtCampo(2), lblDescripcion(3), Nothing)
                    If txtCampo(2).Text = "" Then txtCampo(2).Focus()
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
                            txtCampo(4).Focus()
                            Exit Sub
                        End If
                        VGOperacion = "sp_promon"
                        VGTipo = "Q"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4076")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(4).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1532)) Then
                            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMAnchoColumnasGrid(FRegistros.grdRegistros)
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
                                txtCampo(4).Text = ""
                                lblDescripcion(9).Text = ""
                                lblDescripcion(7).Text = ""
                                lblDescripcion(11).Text = ""
                                txtCampo(4).Focus()
                            End If
                            For i As Integer = 1 To 5
                                VGValores(i) = ""
                            Next i
                            FRegistros.Dispose() '18/05/2016 migracion
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtCampo(2).Text = ""
                            lblDescripcion(9).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(11).Text = ""
                            txtCampo(4).Focus()
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
                        VGForma = "FConsulMas2"
                        FAyudaSubserv2.ShowPopup(Me)
                        If VGDetalle(1) <> "" Then
                            PMSubserv()
                        Else
                            lblDescripcion(8).Text = ""
                            lblDescripcion(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(5).Text = ""
                            txtCampo(5).Focus()
                            VLPaso = True
                        End If
                        FAyudaSubserv2.Dispose() '18/05/2016 migracion
                    Else
                        lblDescripcion(8).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(2).Text = ""
                    End If
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Public Sub PLConfirmar()
        Dim msg As String = String.Empty
        Dim aux As String = String.Empty
        Dim Ini_row_grid As Integer = 0
        Dim Fin_row_grid As Integer = 0
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1352), FMLoadResString(1630), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1351), FMLoadResString(1630), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1353), FMLoadResString(1630), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        End If
        If lblDescripcion(9).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1506), FMLoadResString(1630), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If mskFecha.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1429), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFecha.Focus()
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
        If grdRegistros.Rows <= 2 Or grdRegistros.Cols <= 2 Then
            If grdRegistros.Cols > 2 Then
                grdRegistros.Col = 2
                grdRegistros.Row = 1
                If grdRegistros.CtlText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1508), FMLoadResString(1630), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(1508), FMLoadResString(1630), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        If grdRegistros.SelStartCol = 1 And grdRegistros.SelEndCol = 13 Then
            msg = FMLoadResString(1868)
            aux = CStr(COBISMessageBox.Show(msg, FMLoadResString(1630), COBISMessageBox.COBISButtons.YesNo))
            If aux = System.Windows.Forms.DialogResult.Yes Then
                Ini_row_grid = grdRegistros.SelStartRow
                Fin_row_grid = grdRegistros.SelEndRow
            Else
                Exit Sub
            End If
        Else
            msg = FMLoadResString(1869)
            aux = CStr(COBISMessageBox.Show(msg, FMLoadResString(1630), COBISMessageBox.COBISButtons.YesNo))
            If aux = System.Windows.Forms.DialogResult.Yes Then
                Ini_row_grid = 1
                Fin_row_grid = grdRegistros.Rows - 1
            Else
                Exit Sub
            End If
        End If
        For i As Integer = Ini_row_grid To Fin_row_grid
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4085")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
            PMPasoValores(sqlconn, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text)
            PMPasoValores(sqlconn, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, lblDescripcion(9).Text)
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text)
            PMPasoValores(sqlconn, "@i_suc", 0, SQLINT2, txtCampo(1).Text)
            PMPasoValores(sqlconn, "@i_fecha_vig", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, VGFormatoFecha, "mm/dd/yyyy"))
            grdRegistros.Row = i
            grdRegistros.Col = 13
            PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdRegistros.CtlText)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_con_costot_no_linea", True, FMLoadResString(1589)) Then
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                msg = " " & FMLoadResString(1251) & " " & grdRegistros.CtlText
                grdRegistros.Row = 1
                msg = msg & " " & FMLoadResString(1718) & " " & grdRegistros.CtlText
            End If
        Next i
        cmdBoton_Click(cmdBoton(0), New EventArgs())
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

    Private Sub TSBAprobar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAprobar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub
    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBSiguientes.Visible = _cmdBoton_3.Visible
        TSBSiguientes.Enabled = _cmdBoton_3.Enabled
        TSBAprobar.Visible = _cmdBoton_4.Visible
        TSBAprobar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
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


