Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FTran357Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Boolean = False
    Dim VLSolic As Integer = 0
    Dim VLPasoValidacionFecha As Boolean = True

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTFDesde As String = String.Empty
        Dim VTFHasta As String = String.Empty
        Select Case Index
            Case 0 'Transmitir
                VLPasoValidacionFecha = True
                TSBotones.Focus()
                If VLPasoValidacionFecha = False Then
                    Exit Sub
                End If
                If mskValor(0).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500353), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(0).Focus()
                    Exit Sub
                End If
                If mskValor(1).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500354), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(1).Focus()
                    Exit Sub
                End If
                If txtcampo(0).Text <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "356")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtcampo(1).Text)
                    VLSolic = Conversion.Val(txtcampo(0).Text)
                    PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, Conversion.Str(VLSolic))
                    If optVigentes(0).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "SO")
                    End If
                    If optVigentes(1).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "AP")
                    End If
                    If optVigentes(2).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "NE")
                    End If
                    If optVigentes(3).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "PR")
                    End If
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
                    VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
                    PMPasoValores(sqlconn, "@i_zona", 0, SQLINT4, txtcampo(2).Text)
                    PMPasoValores(sqlconn, "@i_territorial", 0, SQLINT4, txtcampo(3).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(508919)) Then
                        PMMapeaGrid(sqlconn, grdValores, False)
                        PMMapeaTextoGrid(grdValores)
                        PMAnchoColumnasGrid(grdValores)
                        PMChequea(sqlconn)
                        grdValores.ColAlignment(1) = 2
                        grdValores.ColAlignment(3) = 1
                        grdValores.ColAlignment(5) = 1
                        If (grdValores.Rows - 1) >= 20 Then
                            cmdBoton_Click(cmdBoton(4), New EventArgs())
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501073), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtcampo(0).Focus()
                End If
            Case 1
                txtcampo(1).Text = VGOficina
                PMCatalogo("V", "cl_oficina", Me.txtcampo(1), Me.lblDescripcion(0))
                VLPaso = True
                txtcampo(2).Text = ""
                txtcampo(3).Text = ""
                txtcampo(0).Text = "0"

                lblDescripcion(1).Text = ""
                lblDescripcion(2).Text = ""
                For i As Integer = 0 To 1
                    mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                Next i
                PMLimpiaG(grdValores)
                'PMLimpiaGrid(grdValores)
                cmdBoton(0).Enabled = True
                cmdBoton(4).Enabled = False
                frmCriterio.Enabled = True
                optVigentes(0).Checked = True
                PLTSEstado()
                txtcampo(0).Focus()
            Case 2
                Me.Close()
            Case 4
                VLPasoValidacionFecha = True
                TSBotones.Focus()
                If VLPasoValidacionFecha = False Then
                    Exit Sub
                End If
                If mskValor(0).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500353), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(0).Focus()
                    Exit Sub
                End If
                If mskValor(1).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500354), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(1).Focus()
                    Exit Sub
                End If
                If txtcampo(0).Text <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "356")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtcampo(1).Text)
                    If optVigentes(0).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "SO")
                    End If
                    If optVigentes(1).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "AP")
                    End If
                    If optVigentes(2).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "NE")
                    End If
                    If optVigentes(3).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "PR")
                        frmCriterio.Enabled = False
                    End If
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    grdValores.Col = 1
                    grdValores.Row = grdValores.Rows - 1
                    PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT2, grdValores.CtlText)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
                    VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
                    PMPasoValores(sqlconn, "@i_zona", 0, SQLINT4, txtcampo(2).Text)
                    PMPasoValores(sqlconn, "@i_territorial", 0, SQLINT4, txtcampo(3).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(508919)) Then
                        PMMapeaGrid(sqlconn, grdValores, True)
                        PMMapeaTextoGrid(grdValores)
                        PMAnchoColumnasGrid(grdValores)
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = (grdValores.Rows - 1) Mod 20 = 0
                        PLTSEstado()
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500950), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
        End Select
        PLTSEstado()
    End Sub


    Private Sub FTran357_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBSiguiente.Enabled = _cmdBoton_4.Enabled
        TSBSiguiente.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub


    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        txtcampo(0).Text = CStr(0)
        txtcampo(1).Text = VGOficina
        PMCatalogo("V", "cl_oficina", Me.txtcampo(1), Me.lblDescripcion(0))
        VLPaso = True
        txtcampo(2).Text = ""
        txtcampo(3).Text = ""
        optVigentes(0).Checked = True
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
        Next i
        cmdBoton(4).Visible = False
        PMObjetoSeguridad(txtcampo(1))
        PMObjetoSeguridad(cmdHab)
        PMInicializarFecha()
    End Sub

    Private Sub FTran357_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdValores_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdValores.Click
        grdValores.Col = 0
        grdValores.SelStartCol = 1
        grdValores.SelEndCol = grdValores.Cols - 1
        If grdValores.Row = 0 Then
            grdValores.SelStartRow = 1
            grdValores.SelEndRow = 1
        Else
            grdValores.SelStartRow = grdValores.Row
            grdValores.SelEndRow = grdValores.Row
        End If
    End Sub

    Private Sub grdValores_ClickEvent(sender As Object, e As EventArgs) Handles grdValores.ClickEvent
        PMLineaG(grdValores)
    End Sub

    Private Sub grdValores_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdValores.DblClick
        If grdValores.Cols <= 2 Then Exit Sub
        grdValores.Col = 8
        If grdValores.CtlText = "SO" Then
            If cmdHab.Enabled Then
                FTRAN354.Show(Me)
                grdValores.Col = 1
                FTRAN354.txtCampo(6).Text = grdValores.CtlText
                FTRAN354.txtCampo_Leave(FTRAN354.txtCampo(6), New EventArgs())
                PMAnchoColumnasGrid(FTRAN354.grdPropietarios)

            Else
                COBISMessageBox.Show(FMLoadResString(501074), FMLoadResString(501075), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            End If
        End If
        If grdValores.CtlText = "AP" Then
            grdValores.Col = 1
            FTran201.Show(Me)
            grdValores.Col = 1
            FTran201.txtCampo(14).Text = grdValores.CtlText
            FTran201.PLBuscar()
        End If
        PMLineaG(grdValores)
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Enter, _mskValor_0.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500410) & VGFormatoFecha & "]")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500359) & VGFormatoFecha & "]")
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Leave, _mskValor_0.Leave
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Try
            Select Case Index
                Case 0, 1
                    FMValidarFecha(Index)

            End Select
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtcampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtcampo_3.TextChanged, _txtcampo_2.TextChanged, _txtcampo_1.TextChanged, _txtcampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                VLPaso = False
                PMLimpiaG(grdValores)
        End Select
        If Index = 1 Then
            lblDescripcion(0).Text = ""
        End If
    End Sub

    Private Sub txtcampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtcampo_3.Enter, _txtcampo_2.Enter, _txtcampo_1.Enter, _txtcampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509035))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509074))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509073))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509072))
        End Select
    End Sub

    Private Sub txtcampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtcampo_3.KeyDown, _txtcampo_2.KeyDown, _txtcampo_1.KeyDown, _txtcampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            Select Case Index
                Case 1
                    txtcampo(1).Text = ""
                    PMCatalogo("A", "cl_oficina", Me.txtcampo(1), Me.lblDescripcion(0))
                    VLPaso = False
                Case 3
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(508826)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtcampo(3).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                        txtcampo(3).Text = ""
                        lblDescripcion(1).Text = ""
                        txtcampo(3).Focus()
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
                        lblDescripcion(2).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                        txtcampo(2).Text = ""
                        lblDescripcion(2).Text = ""
                        txtcampo(2).Focus()
                    End If
            End Select
        End If
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
            Case 1
                If txtcampo(1).Text <> "" Then
                    If CDbl(txtcampo(1).Text) > 32000 Then
                        COBISMessageBox.Show(FMLoadResString(508623), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtcampo(1).Text = ""
                        txtcampo(1).Focus()
                        Exit Sub
                    End If
                    PMCatalogo("V", "cl_oficina", Me.txtcampo(1), Me.lblDescripcion(0))
                    VLPaso = True
                End If
            Case 3
                If Not VLPaso Then
                    If txtcampo(3).Text <> "" Then
                        If CDbl(txtcampo(3).Text) > 32000 Then
                            COBISMessageBox.Show(FMLoadResString(5259), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtcampo(3).Text = ""
                            txtcampo(3).Focus()
                            Exit Sub
                        End If

                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "VS")
                        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "R")
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtcampo(3).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(508826)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                            If Trim(lblDescripcion(1).Text) = System.String.Empty Then
                                COBISMessageBox.Show(FMLoadResString(509034), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                lblDescripcion(1).Text = System.String.Empty
                                txtcampo(3).Text = System.String.Empty
                                If txtcampo(3).Enabled Then
                                    txtcampo(3).Focus()
                                End If
                                Exit Sub
                            End If
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtcampo(3).Text = ""
                            lblDescripcion(1).Text = ""
                            If txtcampo(3).Enabled Then
                                txtcampo(3).Focus()
                            End If
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtcampo(2).Text <> "" Then
                        If CDbl(txtcampo(2).Text) > 32000 Then
                            COBISMessageBox.Show(FMLoadResString(5258), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtcampo(2).Text = ""
                            txtcampo(2).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1574")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "VS")
                        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "Z")
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtcampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(508841)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                            If Trim(lblDescripcion(2).Text) = System.String.Empty Then
                                COBISMessageBox.Show(FMLoadResString(509034), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                lblDescripcion(2).Text = System.String.Empty
                                txtcampo(2).Text = System.String.Empty
                                If txtcampo(2).Enabled Then
                                    txtcampo(2).Focus()
                                End If
                                Exit Sub
                            End If
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtcampo(2).Text = ""
                            lblDescripcion(2).Text = ""
                            If txtcampo(2).Enabled Then
                                txtcampo(2).Focus()
                            End If
                        End If
                    Else
                        lblDescripcion(2).Text = ""
                    End If
                End If
        End Select
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        Me.Text = FMLoadResString(509077)
    End Sub

    Private Sub _optVigentes_0_CheckedChanged(sender As Object, e As EventArgs) Handles _optVigentes_0.CheckedChanged
        PMLimpiaG(grdValores)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509078))
    End Sub

    Private Sub _optVigentes_0_Enter(sender As Object, e As EventArgs) Handles _optVigentes_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509078))
    End Sub

    Private Sub PMInicializarFecha()
        mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(0).DateType = PLFormatoFecha()
        mskValor(0).Connection = VGMap

        mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(1).DateType = PLFormatoFecha()
        mskValor(1).Connection = VGMap

        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
    End Sub

    Private Function FMValidarFecha(Index As Integer) As Boolean
        Dim VTValido As Integer = 0
        Dim VTDias As Integer = 0
        Dim VLRecursoMsjError As Integer

        VLPasoValidacionFecha = True

        'Valida si fecha es válida
        If mskValor(Index).ClipText <> "" Then
            VTValido = FMVerFormato(mskValor(Index).Text, VGFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskValor(Index).Text = ""
                mskValor(Index).Mask = FMMascaraFecha(VGFormatoFecha)
                mskValor(Index).Focus()
                VLPasoValidacionFecha = False
                Return VLPasoValidacionFecha
            End If
        End If
        'Valida si fecha desde es mayor a fecha hasta
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VGFormatoFecha)
            If VTDias < 0 Then
                COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskValor(Index).Text = ""
                mskValor(Index).Mask = FMMascaraFecha(VGFormatoFecha)
                mskValor(Index).Focus()
                VLPasoValidacionFecha = False
                Return VLPasoValidacionFecha
            End If
        End If
        'Valida si fecha es mayor a fecha proceso
        If mskValor(Index).ClipText <> "" Then
            VTDias = FMDateDiff("d", mskValor(Index).Text, VGFechaProceso, VGFormatoFecha)
            If VTDias < 0 Then
                Select Case Index
                    Case 0
                        VLRecursoMsjError = 5254 'Fecha hasta no puede ser mayor a la fecha del sistema
                    Case 1
                        VLRecursoMsjError = 508587 'Fecha hasta no puede ser mayor a la fecha del sistema
                End Select
                COBISMessageBox.Show(FMLoadResString(VLRecursoMsjError), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)

                mskValor(Index).Mask = FMMascaraFecha(VGFormatoFecha)
                mskValor(Index).Text = ""

                mskValor(Index).Focus()
                VLPasoValidacionFecha = False
                Return VLPasoValidacionFecha
            End If
        End If
        Return VLPasoValidacionFecha
    End Function
End Class


