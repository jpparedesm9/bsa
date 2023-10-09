Option Strict Off
Option Explicit On
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran493Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0
    Dim VLTabla As String = ""
    Dim VLSecuencial As String = ""
    Dim VLMatrizTrans(2, 80) As String
    Dim VLBuscar As String = ""
    Dim VLCausa As String = ""
    Dim VLPosGrid As Integer = 0
    Dim VLValorMin As Integer = 0
    Dim VLPos As Integer = 0
    Dim VLValorInter As Integer = 0
    Dim VLClip As String = ""
    Dim VLTransac As Integer = 0

    Private Sub PLEliminar()
        If VLSecuencial <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "689")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, VLSecuencial)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_trn_contabilizar", True, FMLoadResString(502655)) Then
                PMChequea(sqlconn)
                PLBuscar()
                cmdBoton(3).Enabled = False
                cmdBoton(6).Enabled = False
            Else
                PMChequea(sqlconn)
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(502250), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub CmbContab_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CmbContab.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502732))
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_5.Click, _cmdBoton_4.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim Msg As String = ""
        TSBotones.Focus()
        Select Case Index
            Case 0
                VLBuscar = "S"
                PLBuscar()
            Case 1
                PLLimpiar()
            Case 2
                PLIngresar()
            Case 3
                PLModificar()
            Case 4
                PLImprimir()
            Case 5
                Me.Close()
            Case 6
                grdRegistros.Col = 0
                Msg = FMLoadResString(502975) & " " & grdRegistros.CtlText & " ?"
                If COBISMessageBox.Show(Msg, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo) = System.Windows.Forms.DialogResult.Yes Then
                    VLBuscar = "N"
                    PLEliminar()
                    PLLimpiar()
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Enter, _cmdBoton_2.Enter, _cmdBoton_3.Enter, _cmdBoton_0.Enter, _cmdBoton_5.Enter, _cmdBoton_4.Enter, _cmdBoton_6.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502232))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502233))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502234))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502235))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502782))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500371))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502236))
        End Select
    End Sub

    Private Sub FTran493Class_DragLeave(sender As Object, e As EventArgs) Handles Me.DragLeave

    End Sub

    Private Sub FTran493_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBIngresar.Enabled = _cmdBoton_2.Enabled
        TSBIngresar.Visible = _cmdBoton_2.Visible
        TSBModificar.Enabled = _cmdBoton_3.Enabled
        TSBModificar.Visible = _cmdBoton_3.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBEliminar.Enabled = _cmdBoton_6.Enabled
        TSBEliminar.Visible = _cmdBoton_6.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_5.Enabled
        TSBSalir.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBIngresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBModificar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub


    Public Sub PLInicializar()
        VLBuscar = "S"
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_trn_causa_contb")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502626)) Then
            FMMapeaMatriz(sqlconn, VLMatrizTrans)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        VLTabla = "cc_campo_contable"
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
            PMMapeaGrid(sqlconn, grdConta, False)
            PMChequea(sqlconn)
            grdConta.Col = 2
            For i As Integer = 0 To grdConta.Rows - 2
                grdConta.Row = i + 1
                CmbContab.Items.Insert(i, grdConta.CtlText)
            Next i
        Else
            PMChequea(sqlconn)
        End If
        Me.Text = FMLoadResString(9955)
        cmdBoton(3).Enabled = False 'modificar
        cmdBoton(4).Enabled = False 'imprimir
        cmdBoton(6).Enabled = False 'eliminar
    End Sub

    Private Sub FTran493_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
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
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        Dim causa_sus As Integer = 0
        Dim causa As String = ""
        Dim VTCampo As Integer = 0
        txtCampo(7).Enabled = False
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(501027), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 1
        txtCampo(0).Text = grdRegistros.CtlText.Trim()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "494")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
            PMMapeaObjeto(sqlconn, lblDescripcion(0))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        VLTabla = ""
        txtCampo(1).Enabled = False
        For i As Integer = 1 To VLMatrizTrans.GetUpperBound(1)
            If txtCampo(0).Text = VLMatrizTrans(0, i) Then
                VLTabla = VLMatrizTrans(1, i)
                txtCampo(1).Enabled = True
                Exit For
            End If
        Next i
        grdRegistros.Col = 2
        txtCampo(3).Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        txtCampo(6).Text = grdRegistros.CtlText.Trim()
        If txtCampo(6).Text = "C" Then
            lblDescripcion(4).Text = FMLoadResString(502652)
        Else
            lblDescripcion(4).Text = FMLoadResString(502653)
        End If
        grdRegistros.Col = 4
        If grdRegistros.CtlText.Trim() <> "0" Then
            txtCampo(1).Text = grdRegistros.CtlText.Trim()
            If VLTabla <> "" Then
                Dim dbNumericTemp As Double = 0
                If Not Double.TryParse(grdRegistros.CtlText.Trim(), NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                    txtCampo(1).Text = grdRegistros.CtlText.Trim()
                    PMCatalogo("V", VLTabla, txtCampo(1), lblDescripcion(1))
                Else
                    If txtCampo(0).Text = "48" Or txtCampo(0).Text = "50" Or txtCampo(0).Text = "264" Or txtCampo(0).Text = "253" Then
                        causa_sus = CInt(txtCampo(1).Text)
                        causa = txtCampo(1).Text
                        If causa_sus > 500 Then
                            causa_sus -= 500
                        End If
                    Else
                        causa = txtCampo(1).Text
                        causa_sus = CInt(txtCampo(1).Text)
                    End If
                    txtCampo(1).Text = CStr(causa_sus)
                    PMCatalogo("V", VLTabla, txtCampo(1), lblDescripcion(1))
                    txtCampo(1).Text = causa
                    If CInt(txtCampo(1).Text) > 500 Then
                        lblDescripcion(1).Text = FMLoadResString(502654) & " " & lblDescripcion(1).Text
                    End If
                End If
            End If
        Else
            txtCampo(1).Text = grdRegistros.CtlText.Trim()
            lblDescripcion(1).Text = ""
        End If
        grdRegistros.Col = 5
        txtCampo(8).Text = grdRegistros.CtlText
        grdRegistros.Col = 6
        If grdRegistros.CtlText.Trim() <> "" Then
            txtCampo(2).Text = grdRegistros.CtlText.Trim()
            PMCatalogo("V", "cc_tipo_indicador", txtCampo(2), lblDescripcion(2))
        Else
            txtCampo(2).Text = ""
            lblDescripcion(2).Text = ""
        End If
        grdRegistros.Col = 7
        CmbContab.Text = grdRegistros.CtlText.Trim()
        grdRegistros.Col = 8
        txtCampo(9).Text = grdRegistros.CtlText.Trim()
        If txtCampo(9).Text = "V" Then
            lblDescripcion(5).Text = FMLoadResString(9951)
        Else
            lblDescripcion(5).Text = FMLoadResString(9952)
        End If
        grdRegistros.Col = 9
        txtCampo(4).Text = grdRegistros.CtlText
        grdRegistros.Col = 12
        VLSecuencial = grdRegistros.CtlText
        grdRegistros.Col = 13
        txtCampo(10).Text = grdRegistros.CtlText
        grdRegistros.Col = 14
        If grdRegistros.CtlText.Trim() <> "" Then
            txtCampo(11).Text = grdRegistros.CtlText.Trim()
            PMCatalogo("V", "cc_clase_clte", txtCampo(11), lblDescripcion(7))
        End If
        grdRegistros.Col = 15
        If grdRegistros.CtlText.Trim() <> "" Then
            txtCampo(12).Text = grdRegistros.CtlText.Trim()
            PMCatalogo("V", "re_campo_totaliza", txtCampo(12), lblDescripcion(8))
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(10).Text)
        If CDbl(txtCampo(7).Text) = 10 Then
            VTCampo = 3
            PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, CStr(VTCampo))
        Else
            PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, txtCampo(7).Text)
        End If
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2466)) Then
            PMMapeaObjeto(sqlconn, lblDescripcion(6))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        cmdBoton(3).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(6).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        Dim VTBusqueda As String = String.Empty
        Dim Msg As String = String.Empty
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim a As Integer = 0
        Dim num As Integer = 0
        Dim Var As Integer = 0
        If txtCampo(7).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502266), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        Dim VTRegistros As Integer = 20
        Dim VTSecuencial As String = "0"
        Dim VTFlag As Boolean = False
        Dim VTCodigoTrn As String = txtCampo(0).Text.Trim()
        If VTCodigoTrn = "" Then
            VTBusqueda = "P"
            VTCodigoTrn = "0"
        Else
            VTBusqueda = "T"
        End If
        If txtCampo(1).Text = "" Then
            VLCausa = "0"
        Else
            VLCausa = txtCampo(1).Text
            VTBusqueda = "C"
        End If
        While VTRegistros = 20
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "494")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VTBusqueda)
            PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, VLCausa)
            PMPasoValores(sqlconn, "@i_orden", 0, SQLINT4, VTSecuencial)
            PMPasoValores(sqlconn, "@i_prod", 0, SQLINT1, txtCampo(7).Text)
            PMPasoValores(sqlconn, "@i_codtrn", 0, SQLINT2, VTCodigoTrn)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_trn_contabilizar", True, FMLoadResString(503001)) Then
                PMMapeaGrid(sqlconn, grdRegistros, VTFlag)
                PMChequea(sqlconn)
                VTFlag = True
                VTRegistros = Conversion.Val(Convert.ToString(grdRegistros.Tag))
                If VTRegistros > 0 Then
                    cmdBoton(4).Enabled = True
                End If
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 12
                VTSecuencial = grdRegistros.CtlText
                grdRegistros.Col = 1
                VTCodigoTrn = grdRegistros.CtlText
            Else
                PMChequea(sqlconn)
                VTRegistros = 0
            End If
        End While
        grdRegistros.ColWidth(2) = 4600
        grdRegistros.ColWidth(4) = 1000
        grdRegistros.ColWidth(5) = 1
        grdRegistros.ColWidth(6) = 900
        grdRegistros.ColWidth(7) = 1200
        grdRegistros.ColWidth(8) = 650
        grdRegistros.ColWidth(9) = 700
        grdRegistros.ColWidth(10) = 800
        grdRegistros.ColWidth(11) = 1
        grdRegistros.ColWidth(12) = 700
        grdRegistros.ColWidth(13) = 700
        If grdRegistros.Rows > 2 And VLBuscar = "S" Then
            Msg = FMLoadResString(503084)
            If COBISMsgBox.MsgBox(Msg, 33, Me.Text) = System.Windows.Forms.DialogResult.OK Then
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                i = grdRegistros.Rows - 1
                grdRegistros.Col = 4
                VLPosGrid = 1
                While i >= 1
                    j = i - 1
                    grdRegistros.Row = i
                    a = Strings.Len(grdRegistros.CtlText)
                    num = 0
                    For M As Integer = 1 To a
                        grdRegistros.Col = 1
                        If CDbl(grdRegistros.CtlText) = 2679 Or CDbl(grdRegistros.CtlText) = 2680 Or CDbl(grdRegistros.CtlText) = 2681 Or CDbl(grdRegistros.CtlText) = 2682 Or CDbl(grdRegistros.CtlText) = 2689 Or CDbl(grdRegistros.CtlText) = 2690 Or CDbl(grdRegistros.CtlText) = 2691 Or CDbl(grdRegistros.CtlText) = 2692 Or CDbl(grdRegistros.CtlText) = 250 Then
                            grdRegistros.Col = 4
                            Var = Strings.AscW(Strings.Mid(grdRegistros.CtlText, M, 1))
                            num += Var
                        Else
                            grdRegistros.Col = 4
                            num = CInt(grdRegistros.CtlText)
                        End If
                    Next M
                    VLValorMin = num
                    VLPos = i
                    While j >= 1
                        grdRegistros.Row = j
                        a = Strings.Len(grdRegistros.CtlText)
                        num = 0
                        For M As Integer = 1 To a
                            grdRegistros.Col = 1
                            If CDbl(grdRegistros.CtlText) = 2679 Or CDbl(grdRegistros.CtlText) = 2680 Or CDbl(grdRegistros.CtlText) = 2681 Or CDbl(grdRegistros.CtlText) = 2682 Or CDbl(grdRegistros.CtlText) = 2689 Or CDbl(grdRegistros.CtlText) = 2690 Or CDbl(grdRegistros.CtlText) = 2691 Or CDbl(grdRegistros.CtlText) = 2692 Or CDbl(grdRegistros.CtlText) = 250 Then
                                grdRegistros.Col = 4
                                Var = Strings.AscW(Strings.Mid(grdRegistros.CtlText, M, 1))
                                num += Var
                            Else
                                grdRegistros.Col = 4
                                num = CInt(grdRegistros.CtlText)
                            End If
                        Next M
                        VLValorInter = num
                        If VLValorInter < VLValorMin Then
                            VLValorMin = num
                            VLPos = j
                        End If
                        j -= 1
                    End While
                    grdRegistros.SelStartCol = 1
                    grdRegistros.SelEndCol = grdRegistros.Cols - 1
                    grdRegistros.SelStartRow = VLPos
                    grdRegistros.SelEndRow = VLPos
                    VLClip = grdRegistros.Clip
                    grdRegistros.RemoveItem(CShort(VLPos))
                    grdRegistros.AddItem(Conversion.Str(VLPosGrid) & ChrW(9) & VLClip)
                    i -= 1
                    VLPosGrid += 1
                End While
                COBISMessageBox.Show(FMLoadResString(503085), Me.Text, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Me.Cursor = System.Windows.Forms.Cursors.Default
            End If
        End If
        PMMapeaTextoGrid(grdRegistros)
        PMAnchoColumnasGrid(grdRegistros)
    End Sub

    Private Sub PLIngresar()
        Dim VTCausaOrg As String = String.Empty
        Dim VTIndicador As String = String.Empty
        If txtCampo(7).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(7).Enabled Then txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(6).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502239), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(6).Enabled Then txtCampo(6).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500385), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled Then txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(3).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502240), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(3).Enabled Then txtCampo(3).Focus()
            Exit Sub
        End If
        If txtCampo(4).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502244), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(4).Enabled Then txtCampo(4).Focus()
            Exit Sub
        End If
        If txtCampo(9).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502242), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(9).Enabled Then txtCampo(9).Focus()
            Exit Sub
        End If
        If txtCampo(10).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502736), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(10).Enabled Then txtCampo(10).Focus()
            Exit Sub
        End If
        If txtCampo(11).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502737), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(11).Enabled Then txtCampo(11).Focus()
            Exit Sub
        End If
        If txtCampo(12).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502738), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(12).Enabled Then txtCampo(12).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" Then
            VTCausaOrg = "0"
        Else
            VTCausaOrg = txtCampo(1).Text
        End If
        If txtCampo(2).Text.Trim() = "" Then
            VTIndicador = "0"
        Else
            VTIndicador = txtCampo(2).Text
        End If
        If (txtCampo(0).Text = "48" Or txtCampo(0).Text = "50" Or txtCampo(0).Text = "253" Or txtCampo(0).Text = "255" Or txtCampo(0).Text = "262" Or txtCampo(0).Text = "264" Or txtCampo(0).Text = "2679" Or txtCampo(0).Text = "2680" Or txtCampo(0).Text = "2681" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2689" Or txtCampo(0).Text = "2690" Or txtCampo(0).Text = "2691" Or txtCampo(0).Text = "2692" Or txtCampo(0).Text = "2752" Or txtCampo(0).Text = "329" Or txtCampo(0).Text = "676" Or txtCampo(0).Text = "259" Or txtCampo(0).Text = "2505" Or txtCampo(0).Text = "2766" Or txtCampo(0).Text = "2770" Or txtCampo(0).Text = "2772" Or txtCampo(0).Text = "250" Or txtCampo(0).Text = "2908") And VTCausaOrg = "0" Then
            COBISMessageBox.Show(FMLoadResString(502739) & " " & txtCampo(0).Text, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(1).Enabled Then txtCampo(1).Focus()
            Exit Sub
        End If
        If CmbContab.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(20017), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If CmbContab.Enabled Then CmbContab.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "493")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_prod", 0, SQLINT1, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_credeb", 0, SQLCHAR, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_tran", 0, SQLINT2, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg)
        PMPasoValores(sqlconn, "@i_indicador", 0, SQLINT1, VTIndicador)
        PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_perfil", 0, SQLVARCHAR, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_contabiliza", 0, SQLVARCHAR, CmbContab.Text)
        PMPasoValores(sqlconn, "@i_estado", 0, SQLVARCHAR, txtCampo(9).Text)
        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT1, txtCampo(10).Text)
        PMPasoValores(sqlconn, "@i_clase", 0, SQLVARCHAR, txtCampo(11).Text)
        PMPasoValores(sqlconn, "@i_totaliza", 0, SQLVARCHAR, txtCampo(12).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_trn_contabilizar", True, FMLoadResString(502999)) Then
            txtCampo(0).Focus()
            COBISMessageBox.Show(FMLoadResString(503090) & " (" & txtCampo(4).Text & ")", FMLoadResString(502741), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        PLLimpiar()
    End Sub

    Private Sub PLLimpiar()
        If (txtCampo(6).Text.Trim() <> "") And (txtCampo(4).Text.Trim() <> "") Then
            lblDescripcion(1).Text = ""
            lblDescripcion(2).Text = ""
            lblDescripcion(5).Text = ""
            lblDescripcion(6).Text = ""
            lblDescripcion(7).Text = ""
            lblDescripcion(8).Text = ""
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            txtCampo(3).Text = ""
            txtCampo(4).Text = ""
            txtCampo(8).Text = ""
            txtCampo(9).Text = ""
            txtCampo(10).Text = ""
            txtCampo(11).Text = ""
            txtCampo(12).Text = ""
        ElseIf txtCampo(0).Text.Trim() <> "" Then
            lblDescripcion(0).Text = ""
            txtCampo(0).Text = ""
            lblDescripcion(1).Text = ""
            txtCampo(1).Text = ""
            lblDescripcion(4).Text = ""
            txtCampo(6).Text = ""
            PMLimpiaGrid(grdRegistros)
        Else
            For i As Integer = 0 To 8
                lblDescripcion(i).Text = ""
            Next i
            For i As Integer = 0 To 12
                If i <> 5 Then txtCampo(i).Text = ""
            Next i
            PMLimpiaGrid(grdRegistros)
        End If
        cmdBoton(3).Enabled = False
        cmdBoton(6).Enabled = False
        cmdBoton(2).Enabled = True
        txtCampo(7).Enabled = True
        cmdBoton(4).Enabled = False
        CmbContab.SelectedIndex = -1
        PLTSEstado()
    End Sub

    Private Sub PLModificar()
        Dim VTCausaOrg As String = String.Empty
        Dim VTCausaDst As String = String.Empty
        Dim VTIndicador As String = String.Empty
        If VLSecuencial <> "" Then
            If txtCampo(7).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(7).Enabled Then txtCampo(7).Focus()
                Exit Sub
            End If
            If txtCampo(6).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502239), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(6).Enabled Then txtCampo(6).Focus()
                Exit Sub
            End If
            If txtCampo(0).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500385), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(0).Enabled Then txtCampo(0).Focus()
                Exit Sub
            End If
            If txtCampo(3).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502240), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(3).Enabled Then txtCampo(3).Focus()
                Exit Sub
            End If
            If txtCampo(4).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502244), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(4).Enabled Then txtCampo(4).Focus()
                Exit Sub
            End If
            If txtCampo(9).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502242), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(9).Enabled Then txtCampo(9).Focus()
                Exit Sub
            End If
            If txtCampo(10).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502736), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(10).Enabled Then txtCampo(10).Focus()
                Exit Sub
            End If
            If txtCampo(11).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502737), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(11).Enabled Then txtCampo(11).Focus()
                Exit Sub
            End If
            If txtCampo(12).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502738), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(12).Enabled Then txtCampo(12).Focus()
                Exit Sub
            End If
            If txtCampo(1).Text.Trim() = "" Then
                VTCausaOrg = "0"
            Else
                VTCausaOrg = txtCampo(1).Text
            End If
            If txtCampo(8).Text.Trim() = "" Then
                VTCausaDst = "0"
            Else
                VTCausaDst = txtCampo(8).Text
            End If
            If txtCampo(2).Text.Trim() = "" Then
                VTIndicador = "0"
            Else
                VTIndicador = txtCampo(2).Text
            End If
            If (txtCampo(0).Text = "48" Or txtCampo(0).Text = "50" Or txtCampo(0).Text = "253" Or txtCampo(0).Text = "255" Or txtCampo(0).Text = "262" Or txtCampo(0).Text = "264" Or txtCampo(0).Text = "2679" Or txtCampo(0).Text = "2680" Or txtCampo(0).Text = "2681" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2689" Or txtCampo(0).Text = "2690" Or txtCampo(0).Text = "2691" Or txtCampo(0).Text = "2692" Or txtCampo(0).Text = "2752" Or txtCampo(0).Text = "329" Or txtCampo(0).Text = "259" Or txtCampo(0).Text = "2669" Or txtCampo(0).Text = "2753" Or txtCampo(0).Text = "2756" Or txtCampo(0).Text = "2758" Or txtCampo(0).Text = "2699" Or txtCampo(0).Text = "2505" Or txtCampo(0).Text = "2766" Or txtCampo(0).Text = "2770" Or txtCampo(0).Text = "2772") And VTCausaOrg = "0" Then
                COBISMessageBox.Show(FMLoadResString(502739) & " " & txtCampo(0).Text, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(1).Enabled Then txtCampo(1).Focus()
                Exit Sub
            End If
            If CmbContab.Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(20017), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If CmbContab.Enabled Then CmbContab.Focus()
                Exit Sub
            End If
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "493")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
            PMPasoValores(sqlconn, "@i_prod", 0, SQLINT1, txtCampo(7).Text)
            PMPasoValores(sqlconn, "@i_credeb", 0, SQLCHAR, txtCampo(6).Text)
            PMPasoValores(sqlconn, "@i_tran", 0, SQLINT2, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg)
            PMPasoValores(sqlconn, "@i_causa_dst", 0, SQLVARCHAR, VTCausaDst)
            PMPasoValores(sqlconn, "@i_indicador", 0, SQLINT1, VTIndicador)
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_perfil", 0, SQLVARCHAR, txtCampo(4).Text)
            PMPasoValores(sqlconn, "@i_contabiliza", 0, SQLVARCHAR, CmbContab.Text)
            PMPasoValores(sqlconn, "@i_estado", 0, SQLVARCHAR, txtCampo(9).Text)
            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, VLSecuencial)
            PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT1, txtCampo(10).Text)
            PMPasoValores(sqlconn, "@i_clase", 0, SQLCHAR, txtCampo(11).Text)
            PMPasoValores(sqlconn, "@i_totaliza", 0, SQLCHAR, txtCampo(12).Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_trn_contabilizar", True, FMLoadResString(502999)) Then
                PMChequea(sqlconn)
                txtCampo(0).Focus()
            Else
                PMChequea(sqlconn)
            End If
            PLBuscar()
        Else
            COBISMessageBox.Show(FMLoadResString(502248), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_12.TextChanged, _txtCampo_11.TextChanged, _txtCampo_10.TextChanged, _txtCampo_9.TextChanged, _txtCampo_8.TextChanged, _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_4.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_3.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_12.Enter, _txtCampo_11.Enter, _txtCampo_10.Enter, _txtCampo_9.Enter, _txtCampo_8.Enter, _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_4.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_3.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502251))
            Case 1
                cmdBoton(2).Enabled = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502252))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502253))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502254))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502255))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502256))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502257))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502258))
            Case 8
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502259))
            Case 9
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502260))
            Case 10
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502743))
            Case 11
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502744))
            Case 12
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502745))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
        VLPaso = True
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_12.KeyDown, _txtCampo_11.KeyDown, _txtCampo_10.KeyDown, _txtCampo_9.KeyDown, _txtCampo_8.KeyDown, _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_4.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_3.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTCampo As Integer = 0
        If Keycode <> VGTeclaAyuda Then
            Exit Sub
        End If
        VGProductoConta = txtCampo(7).Text.Trim()
        Select Case Index
            Case 0
                If txtCampo(7).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502983), My.Application.Info.ProductName)
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                VLPaso = True
                VGOperacion = "sp_pro_transaccion"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15020")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "9")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(7).Text)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT4, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_pro_transaccion", True, FMLoadResString(2277)) Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(0).Text = VGACatalogo.Codigo
                    lblDescripcion(0).Text = VGACatalogo.Descripcion
                    If txtCampo(0).Text.Trim() = "" Then
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                If VLTabla = "" Then
                    Exit Sub
                End If
                VGOperacion = ""
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(503324) & "[" & txtCampo(Index).Text & "]") Then
                    VLPaso = True
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(1).Text = VGACatalogo.Codigo
                    lblDescripcion(1).Text = VGACatalogo.Descripcion
                    If txtCampo(1).Text.Trim() = "" Then
                        lblDescripcion(1).Text = ""
                        txtCampo(1).Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case 2
                VGOperacion = ""
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502635) & "[" & txtCampo(Index).Text & "]") Then
                    VLPaso = True
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(2).Text = VGACatalogo.Codigo
                    lblDescripcion(2).Text = VGACatalogo.Descripcion
                    If txtCampo(2).Text.Trim() = "" Then
                        lblDescripcion(2).Text = ""
                        txtCampo(2).Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case 4
                If txtCampo(7).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502983), My.Application.Info.ProductName)
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                VLPaso = True
                VGOperacion = "sp_perfil"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6907")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "0")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(7).Text)
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_perfil", 0, SQLVARCHAR, "%")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_perfil", True, FMLoadResString(2277)) Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(4).Text = VGACatalogo.Descripcion
                    If txtCampo(0).Text.Trim() = "" Then
                        txtCampo(4).Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case 7
                VLPaso = True
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "475")
                PMPasoValores(sqlconn, "@i_ope", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_prod", True, FMLoadResString(2348)) Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(7).Text = VGACatalogo.Codigo
                    lblDescripcion(3).Text = VGACatalogo.Descripcion
                    If txtCampo(7).Text.Trim() = "" Then
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        lblDescripcion(3).Text = ""
                        txtCampo(7).Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case 9
                VGOperacion = ""
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_estado_ser")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502637) & "[" & txtCampo(Index).Text & "]") Then
                    VLPaso = True
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(9).Text = VGACatalogo.Codigo
                    lblDescripcion(5).Text = VGACatalogo.Descripcion
                    If txtCampo(9).Text.Trim() = "" Then
                        lblDescripcion(5).Text = ""
                        txtCampo(9).Focus()
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case 10
                If LTrim(RTrim(txtCampo(0).Text)) <> "" Then
                    If CDbl(txtCampo(0).Text) = 2679 Or CDbl(txtCampo(0).Text) = 2680 Or CDbl(txtCampo(0).Text) = 2681 Or CDbl(txtCampo(0).Text) = 2682 Or CDbl(txtCampo(0).Text) = 2689 Or CDbl(txtCampo(0).Text) = 2690 Or CDbl(txtCampo(0).Text) = 2691 Or CDbl(txtCampo(0).Text) = 2692 Then
                        COBISMessageBox.Show(FMLoadResString(502746), My.Application.Info.ProductName)
                    Else
                        VGOperacion = ""
                        If txtCampo(7).Text <> "" Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                            If CDbl(txtCampo(7).Text) = 10 Then
                                VTCampo = 3
                                PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, CStr(VTCampo))
                            Else
                                PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, txtCampo(7).Text)
                            End If
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(502869)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(10).Text = VGACatalogo.Codigo
                                lblDescripcion(6).Text = VGACatalogo.Descripcion
                            Else
                                PMChequea(sqlconn)
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(502238), FMLoadResString(500989), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        End If
                    End If
                End If
            Case 11
                VGOperacion = ""
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_clase_clte")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502635) & "[" & txtCampo(Index).Text & "]") Then
                    VLPaso = True
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(11).Text = VGACatalogo.Codigo
                    lblDescripcion(7).Text = VGACatalogo.Descripcion
                    If txtCampo(11).Text.Trim() = "" Then
                        lblDescripcion(7).Text = ""
                        txtCampo(11).Focus()
                    End If
                    txtCampo(12).Focus()
                Else
                    PMChequea(sqlconn)
                End If
            Case 12
                VGOperacion = ""
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_campo_totaliza")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502635) & "[" & txtCampo(Index).Text & "]") Then
                    VLPaso = True
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(12).Text = VGACatalogo.Codigo
                    lblDescripcion(8).Text = VGACatalogo.Descripcion
                    If txtCampo(12).Text.Trim() = "" Then
                        lblDescripcion(8).Text = ""
                    End If
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_12.KeyPress, _txtCampo_11.KeyPress, _txtCampo_10.KeyPress, _txtCampo_9.KeyPress, _txtCampo_8.KeyPress, _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_4.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_3.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 7, 8, 10
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 4
                KeyAscii = FMVAlidaTipoDato("AN", KeyAscii)
            Case 3
                If (KeyAscii > 47 And KeyAscii < 58) Or (KeyAscii > 64 And KeyAscii < 91) Or (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                Else
                    KeyAscii = 0
                End If
            Case 5
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToLower())
            Case 6, 9, 11, 12
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_12.Leave, _txtCampo_11.Leave, _txtCampo_10.Leave, _txtCampo_9.Leave, _txtCampo_8.Leave, _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_4.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_3.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTTranVal As Integer = 0
        Dim causa As String = ""
        Dim causa_sus As Integer = 0
        Dim VTCampo As Integer = 0
        Select Case Index
            Case 0
                If txtCampo(0).Text.Trim() = "" Then
                    lblDescripcion(0).Text = ""
                    Exit Sub
                End If
                If txtCampo(7).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                VTTranVal = Conversion.Val(txtCampo(0).Text)
                Select Case txtCampo(7).Text.Trim()
                    Case "3"
                        If VTTranVal > 2999 Or (VTTranVal < 600 And VTTranVal > 99) Or (VTTranVal < 2500 And VTTranVal > 700) Then
                            If VTTranVal <> 401 And VTTranVal <> 402 And VTTranVal <> 403 And VTTranVal <> 404 And VTTranVal <> 405 And VTTranVal <> 406 And VTTranVal <> 407 And VTTranVal <> 408 And VTTranVal <> 409 And VTTranVal <> 410 And VTTranVal <> 489 Then
                                COBISMessageBox.Show(FMLoadResString(502636), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Text = ""
                                lblDescripcion(0).Text = ""
                                txtCampo(0).Focus()
                                Exit Sub
                            End If
                        End If
                    Case "4"
                        If VTTranVal <= 200 Or VTTranVal >= 399 Or VTTranVal = 401 Then
                            If VTTranVal <> 401 And VTTranVal <> 402 And VTTranVal <> 403 And VTTranVal <> 404 And VTTranVal <> 405 And VTTranVal <> 406 And VTTranVal <> 407 And VTTranVal <> 408 And VTTranVal <> 409 And VTTranVal <> 410 And VTTranVal <> 489 Then
                                COBISMessageBox.Show(FMLoadResString(502986), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Text = ""
                                lblDescripcion(0).Text = ""
                                txtCampo(0).Focus()
                                Exit Sub
                            End If
                        End If
                    Case "10"
                        If (VTTranVal >= 500 Or VTTranVal < 400) Or VTTranVal = 401 Then
                            If VTTranVal >= 700 Or VTTranVal < 600 Then
                                COBISMessageBox.Show(FMLoadResString(503319), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Text = ""
                                lblDescripcion(0).Text = ""
                                txtCampo(0).Focus()
                                Exit Sub
                            End If
                        End If
                End Select
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "494")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                Else
                    PMChequea(sqlconn)
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(0).Focus()
                End If
                VLTabla = ""
                txtCampo(1).Enabled = False
                For i As Integer = 1 To VLMatrizTrans.GetUpperBound(1)
                    If txtCampo(0).Text = VLMatrizTrans(0, i) Then
                        VLTabla = VLMatrizTrans(1, i)
                        txtCampo(1).Enabled = True
                        Exit For
                    End If
                Next i
            Case 1
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    lblDescripcion(1).Text = ""
                    Exit Sub
                End If
                causa = txtCampo(1).Text
                If VLTabla = "" Then
                    COBISMessageBox.Show(FMLoadResString(502266), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If
                Dim dbNumericTemp As Double = 0
                If txtCampo(0).Text <> "" And Double.TryParse(txtCampo(1).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                    VLTransac = CInt(txtCampo(0).Text)
                End If
                If VLTransac = 50 Or VLTransac = 264 Then
                    Dim dbNumericTemp2 As Double = 0
                    If txtCampo(1).Text <> "" And Double.TryParse(txtCampo(1).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                        causa_sus = CInt(txtCampo(1).Text)
                        causa = txtCampo(1).Text
                        VLTransac = CInt(txtCampo(0).Text)
                        If causa_sus > 500 And (VLTransac = 50 Or VLTransac = 264) Then
                            causa_sus -= 500
                        End If
                        causa = CStr(causa_sus)
                    End If
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, causa)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502637) & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(1))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    txtCampo(1).Focus()
                End If
            Case 2
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    lblDescripcion(2).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(2).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502639) & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(2))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(2).Text = ""
                    lblDescripcion(2).Text = ""
                    txtCampo(2).Focus()
                End If
            Case 4
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(7).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6906")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "0")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(7).Text)
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_perfil", 0, SQLVARCHAR, txtCampo(4).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_perfil", True, FMLoadResString(2277)) Then
                    PMChequea(sqlconn)
                    txtCampo(4).Text = txtCampo(4).Text
                Else
                    PMChequea(sqlconn)
                    txtCampo(4).Text = ""
                    If txtCampo(4).Enabled Then txtCampo(4).Focus()
                End If
            Case 6
                If txtCampo(6).Text.Trim() = "" Then
                    lblDescripcion(4).Text = ""
                    Exit Sub
                End If
                If txtCampo(7).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(6).Text = ""
                    lblDescripcion(4).Text = ""
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502267), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(6).Text = ""
                    lblDescripcion(4).Text = ""
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(6).Text.Trim() = "D" Then
                    lblDescripcion(4).Text = FMLoadResString(503234)
                ElseIf txtCampo(6).Text.Trim() = "C" Then
                    lblDescripcion(4).Text = FMLoadResString(503235)
                Else
                    COBISMessageBox.Show(FMLoadResString(502268), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(6).Text = ""
                    lblDescripcion(4).Text = ""
                    txtCampo(6).Focus()
                    Exit Sub
                End If
            Case 7
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(7).Text.Trim() = "" Then
                    lblDescripcion(3).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "475")
                PMPasoValores(sqlconn, "@i_ope", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, txtCampo(7).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_prod", True, FMLoadResString(502642) & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(3))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(7).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCampo(7).Focus()
                End If
                If txtCampo(7).Text = "3" Then
                End If
            Case 9
                If txtCampo(9).Text.Trim() = "" Then
                    lblDescripcion(5).Text = ""
                    Exit Sub
                End If
                If txtCampo(9).Text.Trim() = "V" Then
                    lblDescripcion(5).Text = FMLoadResString(9951)
                ElseIf txtCampo(9).Text.Trim() = "C" Then
                    lblDescripcion(5).Text = FMLoadResString(9952)
                Else
                    COBISMessageBox.Show(FMLoadResString(502269), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(9).Text = ""
                    lblDescripcion(5).Text = ""
                    txtCampo(9).Focus()
                    Exit Sub
                End If
            Case 10
                If Not VLPaso Then
                    If txtCampo(10).Text <> "" Then
                        If CDbl(txtCampo(0).Text) = 2679 Or CDbl(txtCampo(0).Text) = 2680 Or CDbl(txtCampo(0).Text) = 2681 Or CDbl(txtCampo(0).Text) = 2682 Or CDbl(txtCampo(0).Text) = 2689 Or CDbl(txtCampo(0).Text) = 2690 Or CDbl(txtCampo(0).Text) = 2691 Or CDbl(txtCampo(0).Text) = 2692 Then
                            If txtCampo(10).Text = "1" Then
                                lblDescripcion(6).Text = FMLoadResString(502749)
                            End If
                            If txtCampo(10).Text = "2" Then
                                lblDescripcion(6).Text = FMLoadResString(502750)
                            End If
                            If txtCampo(10).Text = "3" Then
                                lblDescripcion(6).Text = FMLoadResString(502751)
                            End If
                        Else
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                            PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(10).Text)
                            If txtCampo(7).Text = "10" Then
                                VTCampo = 3
                            Else
                                VTCampo = CInt(txtCampo(7).Text)
                            End If
                            PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, CStr(VTCampo))
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2466)) Then
                                PMMapeaObjeto(sqlconn, lblDescripcion(6))
                                PMChequea(sqlconn)
                                VLPaso = True
                            Else
                                PMChequea(sqlconn)
                                txtCampo(10).Text = ""
                                lblDescripcion(6).Text = ""
                                txtCampo(10).Focus()
                            End If
                        End If
                    Else
                        lblDescripcion(6).Text = ""
                    End If
                End If
            Case 11
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(11).Text.Trim() = "" Then
                    lblDescripcion(7).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_clase_clte")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(11).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502639) & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(7))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(11).Text = ""
                    lblDescripcion(7).Text = ""
                    txtCampo(11).Focus()
                End If
            Case 12
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(12).Text.Trim() = "" Then
                    lblDescripcion(8).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_campo_totaliza")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(12).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502989) & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(8))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(12).Text = ""
                    lblDescripcion(8).Text = ""
                    txtCampo(12).Focus()
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub PLImprimir()
        Dim Y As Integer = 0
        If COBISMessageBox.Show(FMLoadResString(503102) & (FMLoadResString(503103)).Trim(), FMLoadResString(500092), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.OK Then
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Orientation = 2
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 3000
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 500
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 16
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("MANTENIMIENTO DE TRANSACCIONES A CONTABILIZAR")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Num")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Trans.")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 1200
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Descripcion")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 1200
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Transaccion")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Causa")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Origen")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6700
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Numero")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6700
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Indicador")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8000
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Campo a ")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8000
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Contabilizar")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Estado")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Trans.")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 10800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Perfil")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 10800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Contable")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 11800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Producto")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 11800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Bancario")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 12800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Clase")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 12800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Cliente")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 13800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1100
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Campo")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 13800
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1400
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("Totaliza")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 1650
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 17
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 130))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 6
            Y = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY
            For j As Integer = 1 To (grdRegistros.Rows - 1)
                Y = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY + 300
                grdRegistros.Row = j
                grdRegistros.Col = 1
                For i As Integer = 1 To 15
                    If i <> 3 And i <> 10 And i <> 11 And i <> 5 And i <> 12 Then
                        Select Case i
                            Case 1
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 2
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 1200
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 4
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 5800
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 6
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 6700
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 7
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 8000
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 8
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 9800
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 9
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 10800
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 13
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 11800
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 14
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 12800
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                            Case 15
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 13800
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y
                        End Select
                        grdRegistros.Col = i
                        If i = 5 Then
                            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, Strings.Left(grdRegistros.CtlText, 22))
                        Else
                            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
                        End If
                    End If
                Next i
            Next j
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 17
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 350
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = Y + 500
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 130))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End If
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMLineaG(grdRegistros)
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502230))
    End Sub
End Class


