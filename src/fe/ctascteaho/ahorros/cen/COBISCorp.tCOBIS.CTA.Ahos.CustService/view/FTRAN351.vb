Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FTran351Class

    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    
    Dim VLNumero As Integer = 0
    Dim VLContador As Integer = 0
    Dim VLNumSol As String = ""
    Dim VLTitular As Integer = 0
    Dim VLTipoEnteTitular As String = ""
    Dim VLPaso As Boolean = False
    Dim VLFormatoFecha As String = ""
    Dim VLImprimio As Boolean = False
    Dim VLyaingreso As Integer = 0
    Dim FDatoCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
    Dim FBuscarCliente As COBISCorp.tCOBIS.BClientes.FBuscarClienteClass

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_5.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        If Not VLPaso Then 'JSA
            TSBBotones.Focus()
            If VLPaso = True Then Exit Sub
        End If
        Select Case Index
            Case 0
                PLAniadir()
            Case 1
                PLEliminar()
            Case 2
                PLTransmitir()
            Case 3
                PLLimpiar()
            Case 4
                PLSalir()
            Case 5
                PLImprimir()
        End Select
    End Sub

    Private Sub FTran351_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBAnadir.Enabled = _cmdBoton_0.Enabled
        TSBAnadir.Visible = _cmdBoton_0.Visible
        TSBEliminar.Enabled = _cmdBoton_1.Enabled
        TSBEliminar.Visible = _cmdBoton_1.Visible
        TSBImprimir.Enabled = _cmdBoton_5.Enabled
        TSBImprimir.Visible = _cmdBoton_5.Visible
        TSBTransmitir.Enabled = _cmdBoton_2.Enabled
        TSBTransmitir.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBAnadir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAnadir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Public Sub PLInicializar()
        grdPropietarios.set_ColIsVisible(0, False)
        grdPropietarios.ColWidth(1) = 960
        grdPropietarios.ColWidth(2) = 1440
        grdPropietarios.ColWidth(3) = 300
        grdPropietarios.ColWidth(4) = 3915
        grdPropietarios.ColWidth(5) = 375
        grdPropietarios.ColWidth(6) = 3915 'JSA 1230
        grdPropietarios.Row = 0
        grdPropietarios.Col = 1
        grdPropietarios.CtlText = FMLoadResString(9919)
        grdPropietarios.Col = 2
        grdPropietarios.CtlText = FMLoadResString(9938)
        grdPropietarios.Col = 3
        grdPropietarios.CtlText = FMLoadResString(508988)
        grdPropietarios.Col = 4
        grdPropietarios.CtlText = FMLoadResString(9940)
        grdPropietarios.Col = 5
        grdPropietarios.CtlText = FMLoadResString(508989)
        grdPropietarios.Col = 6
        grdPropietarios.CtlText = FMLoadResString(9095)
        txtCampo(5).Enabled = False
        VLFormatoFecha = Get_Preferencia(FMLoadResString(509187))
        lblDescripcion(1).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        VLNumero = 0
        VLContador = 0
        VLTitular = 0
        txtCampo(5).Text = FMLoadResString(509361)
        lblDescripcion(9).Text = FMLoadResString(509362)
        txtCampo(3).Text = ""
        lblDescripcion(7).Text = ""
        txtCampo(3).Enabled = True
        VLImprimio = True
        VLyaingreso = 0
        PLTSEstado()
    End Sub

    Private Sub FTran351_Closing(ByVal eventSender As Object, ByVal eventArgs As FormClosingEventArgs) Handles MyBase.Closing
        Dim Cancel As Integer = IIf(eventArgs.Cancel, 1, 0)
        Dim Msg As String = ""
        If Not VLImprimio Then
            Msg = FMLoadResString(502444)
            If COBISMsgBox.MsgBox(Msg, 36, Me.Text) = System.Windows.Forms.DialogResult.No Then Cancel = True
        End If
        eventArgs.Cancel = Cancel <> 0
    End Sub

    Private Sub FTran351_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row) 'JSA
    End Sub

    Private Sub grdPropietarios_DblClick(sender As Object, e As EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row) 'JSA
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
    End Sub

    Private Sub PLAniadir()
        Dim VTCadena As String = ""
        Dim VTR1 As Integer = 0
        Dim vti As Integer = 1
        Dim VTArreglo(10) As String
        Dim VTValores(15) As String
        If VLContador < 20 Then
            If txtCampo(0).Text <> "" Then
                For i As Integer = 1 To grdPropietarios.Rows - 1
                    grdPropietarios.Col = 1
                    grdPropietarios.Row = i
                    If grdPropietarios.CtlText = txtCampo(0).Text Then
                        COBISMessageBox.Show(FMLoadResString(501132), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Text = ""
                        lblDescripcion(2).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(3).Text = ""
                        txtCampo(1).Text = ""
                        lblDescripcion(5).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                Next i
                If lblDescripcion(3).Text = "C" And lblDescripcion(2).Text = "" Then
                    lblDescripcion(2).Text = FMLoadResString(502404)
                End If
                If lblDescripcion(2).Text <> "" Then
                    If lblDescripcion(4).Text <> "" Then
                        If lblDescripcion(3).Text <> "" Then
                            If txtCampo(1).Text <> "" Then
                                If txtCampo(1).Text <> "T" And VLyaingreso = 0 Then
                                    COBISMessageBox.Show(FMLoadResString(501133), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                    Exit Sub
                                End If
                                If txtCampo(1).Text = "U" Then
                                    COBISMessageBox.Show(FMLoadResString(2527), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                    txtCampo(1).Focus()
                                    Exit Sub
                                End If
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
                                PMPasoValores(sqlconn, "@i_retorna", 0, SQLINT1, "1")
                                VTCadena = ""
                                VTCadena = VTCadena & (txtCampo(0).Text) & "@"
                                VTCadena = VTCadena & (txtCampo(1).Text) & "@"
                                VTCadena = VTCadena & (lblDescripcion(4).Text) & "@"
                                PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2528)) Then
                                    VTR1 = FMMapeaArreglo(sqlconn, VTValores)
                                    PMChequea(sqlconn)
                                    If VTR1 > 0 Then
                                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_rol")
                                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, "U")
                                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", False, "") Then
                                            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                                            PMChequea(sqlconn)
                                        Else
                                            PMChequea(sqlconn)
                                        End If
                                    End If
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(0).Text = ""
                                    txtCampo(0).Focus()
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(3).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(5).Text = ""
                                    Exit Sub
                                End If
                                If ((lblDescripcion(3).Text = "P") Or (lblDescripcion(3).Text = "C")) And (txtCampo(1).Text = "T") And (Convert.ToString(grdPropietarios.Tag) <> "T") Then
                                    VLTitular = VLNumero + 1
                                    grdPropietarios.Tag = "T"
                                    If VLNumero = 0 Then
                                        grdPropietarios.Row = 1
                                        grdPropietarios.Col = 1
                                        grdPropietarios.CtlText = txtCampo(0).Text
                                        grdPropietarios.Col = 2
                                        grdPropietarios.CtlText = lblDescripcion(2).Text
                                        grdPropietarios.Col = 3
                                        grdPropietarios.CtlText = lblDescripcion(3).Text
                                        VLTipoEnteTitular = lblDescripcion(3).Text
                                        grdPropietarios.Col = 4
                                        grdPropietarios.CtlText = lblDescripcion(4).Text
                                        grdPropietarios.Col = 5
                                        grdPropietarios.CtlText = txtCampo(1).Text
                                        grdPropietarios.Col = 6
                                        grdPropietarios.CtlText = lblDescripcion(5).Text
                                    Else
                                        grdPropietarios.AddItem(Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                    End If
                                    If VTR1 > 0 Then
                                        grdPropietarios.AddItem(Strings.Chr(9).ToString() & VTValores(1) & Strings.Chr(9).ToString() & VTValores(2) & Strings.Chr(9).ToString() & VTValores(3) & Strings.Chr(9).ToString() & VTValores(4) & Strings.Chr(9).ToString() & "U" & Strings.Chr(9).ToString() & VTArreglo(1), VLNumero + 2)
                                        VLNumero += 1
                                        VLContador += 1
                                        txtCampo(0).Focus()
                                    End If
                                    If txtCampo(1).Text = "T" Then
                                        VLyaingreso = 1
                                    End If
                                    VLNumero += 1
                                    VLContador += 1
                                    txtCampo(0).Text = ""
                                    grdPropietarios.Row = grdPropietarios.Rows - 1
                                    grdPropietarios.Col = 4
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(3).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(5).Text = ""
                                ElseIf (lblDescripcion(3).Text = "P") And (txtCampo(1).Text <> "T") Then
                                    If VLNumero = 0 Then
                                        grdPropietarios.Row = 1
                                        grdPropietarios.Col = 1
                                        grdPropietarios.CtlText = txtCampo(0).Text
                                        grdPropietarios.Col = 2
                                        grdPropietarios.CtlText = lblDescripcion(2).Text
                                        grdPropietarios.Col = 3
                                        grdPropietarios.CtlText = lblDescripcion(3).Text
                                        grdPropietarios.Col = 4
                                        grdPropietarios.CtlText = lblDescripcion(4).Text
                                        grdPropietarios.Col = 5
                                        grdPropietarios.CtlText = txtCampo(1).Text
                                        grdPropietarios.Col = 6
                                        grdPropietarios.CtlText = lblDescripcion(5).Text
                                    Else
                                        If VLTipoEnteTitular = "C" Then
                                            If txtCampo(1).Text = "C" Then
                                                COBISMessageBox.Show(FMLoadResString(501134), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                                If Convert.ToString(grdPropietarios.Tag) <> "T" Then
                                                    VLNumero -= 1
                                                End If
                                                Exit Sub
                                            Else
                                                grdPropietarios.AddItem(Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                            End If
                                        Else
                                            grdPropietarios.AddItem(Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                        End If
                                    End If
                                    VLNumero += 1
                                    VLContador += 1
                                    txtCampo(0).Text = ""
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(3).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(5).Text = ""
                                ElseIf (lblDescripcion(3).Text = "C") And (txtCampo(1).Text = "T") And (Convert.ToString(grdPropietarios.Tag) <> "T") Then
                                    VLTitular = VLNumero + 1
                                    grdPropietarios.Tag = "T"
                                    If VLNumero = 0 Then
                                        grdPropietarios.Row = 1
                                        grdPropietarios.Col = 1
                                        grdPropietarios.CtlText = txtCampo(0).Text
                                        grdPropietarios.Col = 2
                                        grdPropietarios.CtlText = lblDescripcion(2).Text
                                        grdPropietarios.Col = 3
                                        grdPropietarios.CtlText = lblDescripcion(3).Text
                                        grdPropietarios.Col = 4
                                        grdPropietarios.CtlText = lblDescripcion(4).Text
                                        grdPropietarios.Col = 5
                                        grdPropietarios.CtlText = txtCampo(1).Text
                                        grdPropietarios.Col = 6
                                        grdPropietarios.CtlText = lblDescripcion(5).Text
                                        grdPropietarios.Col = 3
                                        VLTipoEnteTitular = grdPropietarios.CtlText
                                    Else
                                        grdPropietarios.AddItem(Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                    End If
                                    VLNumero += 1
                                    VLContador += 1
                                    txtCampo(0).Text = ""
                                    grdPropietarios.Row = grdPropietarios.Rows - 1
                                    grdPropietarios.Col = 4
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(3).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(5).Text = ""
                                ElseIf (lblDescripcion(3).Text = "C") And (txtCampo(1).Text <> "T") Then
                                    COBISMessageBox.Show(FMLoadResString(501135), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                                    Exit Sub
                                ElseIf (lblDescripcion(3).Text = "C") And (txtCampo(1).Text <> "T") Then
                                    If VLNumero = 0 Then
                                        grdPropietarios.Row = 1
                                        grdPropietarios.Col = 1
                                        grdPropietarios.CtlText = txtCampo(0).Text
                                        grdPropietarios.Col = 2
                                        grdPropietarios.CtlText = lblDescripcion(2).Text
                                        grdPropietarios.Col = 3
                                        grdPropietarios.CtlText = lblDescripcion(3).Text
                                        grdPropietarios.Col = 4
                                        grdPropietarios.CtlText = lblDescripcion(4).Text
                                        grdPropietarios.Col = 5
                                        grdPropietarios.CtlText = txtCampo(1).Text
                                        grdPropietarios.Col = 6
                                        grdPropietarios.CtlText = lblDescripcion(5).Text
                                    Else
                                        grdPropietarios.AddItem(Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                    End If
                                    VLNumero += 1
                                    VLContador += 1
                                    txtCampo(0).Text = ""
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(3).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(5).Text = ""
                                Else
                                    COBISMessageBox.Show(FMLoadResString(501929), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                    txtCampo(1).Text = ""
                                    lblDescripcion(5).Text = ""
                                    txtCampo(1).Focus()
                                    Exit Sub
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(501137), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(1).Focus()
                                Exit Sub
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501138), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(501139), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501140), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(501141), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(0).Text = ""
                txtCampo(0).Focus()
                lblDescripcion(2).Text = ""
                lblDescripcion(3).Text = ""
                lblDescripcion(4).Text = ""
                txtCampo(1).Text = ""
                lblDescripcion(5).Text = ""
            End If
            txtCampo(0).Focus()
        Else
            COBISMessageBox.Show(FMLoadResString(501142), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            lblDescripcion(2).Text = ""
            lblDescripcion(3).Text = ""
            lblDescripcion(4).Text = ""
            txtCampo(0).Text = ""
            txtCampo(1).Text = ""
            lblDescripcion(5).Text = ""
            Exit Sub
        End If
    End Sub

    Private Sub PLEliminar()
        Dim VTPosTmp As Integer = 0
        Dim VTFlag As Boolean = False
        grdPropietarios.Col = 5
        If grdPropietarios.CtlText = "U" Then
            COBISMessageBox.Show(FMLoadResString(2529), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End If
        If grdPropietarios.CtlText = "T" Then
            grdPropietarios.Tag = ""
            VLTitular = 0
            txtCampo(2).Text = ""
            lblDescripcion(6).Text = ""
            VLyaingreso = 0
            VTFlag = True
        End If
        If grdPropietarios.Rows = 2 Then
            VLNumero = 0
            VLContador = 0
            grdPropietarios.Row = 1
            For i As Integer = 0 To 6
                grdPropietarios.Col = i
                grdPropietarios.CtlText = ""
            Next i
        Else
            VLNumero -= 1
            VLContador -= 1
            grdPropietarios.RemoveItem(CShort(grdPropietarios.Row))
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
            If VTFlag Then
                If grdPropietarios.Rows = 2 Then
                    VLNumero = 0
                    VLContador = 0
                    grdPropietarios.Row = 1
                    grdPropietarios.Col = 5
                    If grdPropietarios.CtlText = "U" Then
                        For i As Integer = 0 To 6
                            grdPropietarios.Col = i
                            grdPropietarios.CtlText = ""
                        Next i
                    End If
                Else
                    grdPropietarios.Row = 1
                    grdPropietarios.Col = 5
                    For i As Integer = 1 To (grdPropietarios.Rows - 1)
                        grdPropietarios.Row = i
                        If grdPropietarios.CtlText = "U" Then
                            VTPosTmp = i
                            Exit For
                        End If
                    Next i
                    If VTPosTmp > 0 Then
                        VLNumero -= 1
                        VLContador -= 1
                        grdPropietarios.SelStartRow = VTPosTmp
                        grdPropietarios.SelEndRow = VTPosTmp
                        grdPropietarios.RemoveItem(CShort(VTPosTmp))
                    End If
                End If
            End If
        End If
        If Not FBuscarCliente Is Nothing Then 'JSA
            FBuscarCliente = Nothing
        End If
        txtCampo(0).Focus()
    End Sub

    Private Sub PLImprimir()
        Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
        Dim archivos As String = VGPath & "\solicitu.mdb"
        Dim baseDatoss As DAO.Database = DAO_DBEngine_definst.OpenDatabase(archivos)
        Dim tablas1 As DAO.Recordset = baseDatoss.OpenRecordset(FMLoadResString(509363))
        Dim tablas2 As DAO.Recordset = baseDatoss.OpenRecordset(FMLoadResString(509364))
        baseDatoss.Execute(FMLoadResString(509365))
        baseDatoss.Execute(FMLoadResString(509366))
        tablas1.AddNew()
        tablas1.Fields(FMLoadResString(509367)).Value = VGOficina
        tablas1.Fields(FMLoadResString(509368)).Value = VGFecha
        tablas1.Fields(FMLoadResString(509369)).Value = lblDescripcion(0).Text
        tablas1.Fields(FMLoadResString(509370)).Value = lblDescripcion(8).Text
        tablas1.Fields(FMLoadResString(509371)).Value = lblDescripcion(6).Text
        tablas1.Fields(FMLoadResString(509372)).Value = lblDescripcion(7).Text
        tablas1.Fields(FMLoadResString(509373)).Value = 1
        tablas1.Fields(FMLoadResString(509374)).Value = Conversion.Val(VGLOGO)
        tablas1.Update()
        For i As Integer = 1 To (grdPropietarios.Rows - 1)
            grdPropietarios.Row = i
            tablas2.AddNew()
            grdPropietarios.Col = 2
            tablas2.Fields(FMLoadResString(509375)).Value = grdPropietarios.CtlText
            grdPropietarios.Col = 4
            tablas2.Fields(FMLoadResString(509376)).Value = grdPropietarios.CtlText
            grdPropietarios.Col = 6
            tablas2.Fields(FMLoadResString(509377)).Value = grdPropietarios.CtlText
            tablas2.Fields(FMLoadResString(509378)).Value = 1
            tablas2.Fields(FMLoadResString(509374)).Value = Conversion.Val(VGLOGO)
            tablas2.Update()
        Next i
        tablas2.Close()
        Dim reporte As String = VGPath & "\solicte.rpt"
        rptReporte.ReportFileName = reporte
        For i As Integer = 1 To 2
            tablas1.MoveFirst()
            tablas1.Edit()
            If i = 1 Then
                tablas1.Fields(FMLoadResString(509379)).Value = FMLoadResString(509380)
            Else
                tablas1.Fields(FMLoadResString(509379)).Value = FMLoadResString(509381)
                rptReporte.CopiesToPrinter = 2
            End If
            tablas1.Fields(FMLoadResString(509374)).Value = Conversion.Val(VGLOGO)
            tablas1.Update()
            rptReporte.DataFiles(0) = archivos
            rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToPrinter
            rptReporte.Action = 1
        Next i
        tablas1.Close()
        baseDatoss.Close()
        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private Sub PLLimpiar()
        Dim Msg As String = ""
        If Not VLImprimio Then
            Msg = FMLoadResString(2530)
            If COBISMsgBox.MsgBox(Msg, 36, Me.Text) = System.Windows.Forms.DialogResult.No Then
                Exit Sub
            Else
                VLImprimio = True
            End If
        End If
        For i As Integer = 0 To 5
            If i <> 4 Then
                txtCampo(i).Text = ""
            End If
        Next i
        For i As Integer = 0 To 9
            If i <> 8 Then
                lblDescripcion(i).Text = ""
            End If
        Next i
        VLFormatoFecha = Get_Preferencia(FMLoadResString(509187))
        lblDescripcion(1).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        grdPropietarios.Rows = 2
        grdPropietarios.Row = 1
        For i As Integer = 0 To 6
            grdPropietarios.Col = i
            grdPropietarios.CtlText = ""
        Next i
        grdPropietarios.Tag = ""
        VLNumero = 0
        VLTitular = 0
        txtCampo(0).Focus()
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = True
        cmdBoton(2).Enabled = True
        txtCampo(5).Text = FMLoadResString(509361)
        lblDescripcion(9).Text = FMLoadResString(509362)
        lblmalaref.Text = ""
        txtCampo(5).Enabled = False
        VLContador = 0
        VLTipoEnteTitular = ""
        VLyaingreso = 0
        If Not FBuscarCliente Is Nothing Then 'JSA
            FBuscarCliente = Nothing
        End If
        PLTSEstado()
    End Sub

    Private Sub PLSalir()
        If Not FBuscarCliente Is Nothing Then 'JSA
            FBuscarCliente = Nothing
        End If
        Me.Dispose()
        Me.Close()
    End Sub

    Private Sub PLTransmitir()
        If VLTitular <= 0 Then
            COBISMessageBox.Show(FMLoadResString(502006), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501083), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501084), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        End If
        If Not FLVerificarTitularidad() Then
            Exit Sub
        End If
        If Not FLVerificarMenor() Then
            Exit Sub
        End If
        Dim registro As Integer = grdPropietarios.Row - 1
        Dim cadena1 As String = ""
        Dim cadena2 As String = ""
        If registro < 5 Then
            For j As Integer = 1 To VLContador
                grdPropietarios.Row = j
                grdPropietarios.Col = 1
                If cadena1 = "" Then
                    cadena1 = grdPropietarios.CtlText
                Else
                    cadena1 = cadena1 & "|" & grdPropietarios.CtlText
                End If
            Next j
        Else
            For j As Integer = 1 To 5
                grdPropietarios.Row = j
                grdPropietarios.Col = 1
                If cadena1 = "" Then
                    cadena1 = grdPropietarios.CtlText
                Else
                    cadena1 = cadena1 & "|" & grdPropietarios.CtlText
                End If
            Next j
            For j As Integer = 6 To VLContador
                grdPropietarios.Row = j
                grdPropietarios.Col = 1
                If cadena2 = "" Then
                    cadena2 = grdPropietarios.CtlText
                Else
                    cadena2 = cadena2 & "|" & grdPropietarios.CtlText
                End If
            Next j
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "352")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_depart", 0, SQLCHAR, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
        If cadena1 <> "" Then
            cadena1 = cadena1 & "|"
            PMPasoValores(sqlconn, "@i_codigos1", 0, SQLVARCHAR, cadena1)
            If cadena2 <> "" Then
                cadena2 = cadena2 & "|"
                PMPasoValores(sqlconn, "@i_codigos2", 0, SQLVARCHAR, cadena2)
            End If
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(2531)) Then
            Dim VTArreglo(20) As String, VTArreglo1(20) As String
            If txtCampo(2).Text.Trim() = "···&&2" Then
                FMMapeaArreglo(sqlconn, VTArreglo1)
            End If
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            cmdBoton(0).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = False
            lblDescripcion(0).Text = VTArreglo(1)
            VLNumSol = VTArreglo(1)
            If VTArreglo(2) = "S" Then
                lblmalaref.Text = FMLoadResString(502411)
                lblmalaref.Visible = True
            Else
                lblmalaref.Text = ""
                lblmalaref.Visible = False
            End If
            For j As Integer = 1 To grdPropietarios.Rows - 1
                grdPropietarios.Row = j
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "353")
                PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, VLNumSol)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I1")
                grdPropietarios.Col = 1
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, grdPropietarios.CtlText)
                grdPropietarios.Col = 5
                PMPasoValores(sqlconn, "@i_tiptit", 0, SQLCHAR, grdPropietarios.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(2532)) Then
                    PMChequea(sqlconn)
                Else
                PMChequea(sqlconn)
                End If
            Next j
        Else
            PMChequea(sqlconn)
            lblDescripcion(0).Text = ""
            lblDescripcion(1).Text = ""
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_2.TextChanged, _txtCampo_0.TextChanged, _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_2.Enter, _txtCampo_0.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500415))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501145))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501146))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501095))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501092))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501147))
        End Select
        VLPaso = True
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_2.KeyDown, _txtCampo_0.KeyDown, _txtCampo_1.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTCliente As String = ""
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    txtCampo(0).Text = ""
                    VLPaso = True

                    If FBuscarCliente Is Nothing Then
                        FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
                    End If

                    If FDatoCliente Is Nothing Then
                        FDatoCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
                    End If

                    FBuscarCliente.optCliente(1).Enabled = True
                    FBuscarCliente.optCliente(0).Checked = True
                    FBuscarCliente.ShowPopup(Me)
                    FBuscarCliente.optCliente(1).Enabled = True
                    VGBusqueda = FDatoCliente.PMRetornaCliente()

                    FBuscarCliente = Nothing
                    If Not (VGBusqueda(1) Is Nothing) Then
                        If VGBusqueda(1) <> "" Then
                            txtCampo(0).Text = VGBusqueda(1)
                            lblDescripcion(3).Text = VGBusqueda(0)
                            If VGBusqueda(0) = "P" Then
                                lblDescripcion(2).Text = VGBusqueda(5)
                                VTCliente = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                                lblDescripcion(4).Text = VTCliente
                            Else
                                lblDescripcion(2).Text = VGBusqueda(3)
                                lblDescripcion(4).Text = VGBusqueda(2)
                            End If
                        End If
                    End If
                    txtCampo(1).Focus()

                Case 1
                    PMCatalogo("A", "cl_rol", _txtCampo_1, _lblDescripcion_5)
                    VLPaso = True
                    If txtCampo(1).Text <> "" Then
                        cmdBoton(0).Focus()
                    End If

                Case 2
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Focus()
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2533)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(2).Text = VGACatalogo.Codigo
                        lblDescripcion(6).Text = VGACatalogo.Descripcion
                        If txtCampo(2).Text <> "" Then
                            VLPaso = True
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    txtCampo(3).Text = ""
                    lblDescripcion(7).Text = ""
                Case 3
                    If txtCampo(2).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(500647), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(3).Text = ""
                        lblDescripcion(7).Text = ""
                        txtCampo(2).Focus()
                        Exit Sub
                    End If
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(502007), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2534)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(3).Text = VGACatalogo.Codigo
                        lblDescripcion(7).Text = VGACatalogo.Descripcion
                        If txtCampo(3).Text.Trim() <> "" Then
                            VLPaso = True
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 4
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "8")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_departamento", True, FMLoadResString(2535)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(4).Text = VGACatalogo.Codigo
                        lblDescripcion(8).Text = VGACatalogo.Descripcion
                        If txtCampo(4).Text <> "" Then
                            VLPaso = True
                            cmdBoton(2).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 5
                    VLPaso = True
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_2.KeyPress, _txtCampo_0.KeyPress, _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2, 4, 14
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 1
                If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            Case 3
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_2.Leave, _txtCampo_0.Leave, _txtCampo_1.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VLMensajeBlq As String = String.Empty
        Dim VLBloqueado As String = ""
        Dim VLMalaref As String = ""
        Dim VLLista As String = ""
        Dim VTSubtipo As String = String.Empty
        Dim VTCliente As String = String.Empty
        Dim VTValores(15) As String
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1181")
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente", True, FMLoadResString(2536) & " " & "[" & txtCampo(0).Text & "]") Then
                            FMMapeaArreglo(sqlconn, VTValores)
                            PMChequea(sqlconn)
                            VTSubtipo = VTValores(3)
                            lblDescripcion(3).Text = VTSubtipo
                            If VTSubtipo = "P" Then
                                lblDescripcion(2).Text = VTValores(1)
                                VTCliente = VTValores(2)
                                lblDescripcion(4).Text = VTCliente
                            Else
                                lblDescripcion(2).Text = VTValores(1)
                                lblDescripcion(4).Text = VTValores(2)
                            End If
                            If txtCampo(1).Text = "" Then
                                txtCampo(1).Focus()
                            Else
                                cmdBoton(0).Focus()
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(2).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(3).Text = ""
                            txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion(2).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(3).Text = ""
                    End If
                End If
                If txtCampo(0).Text <> "" Then
                    VLMensajeBlq = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "175")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "B")
                    PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(0).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_ente_bloqueado", True, FMLoadResString(2537)) Then
                        PMMapeaVariable(sqlconn, VLBloqueado)
                        PMMapeaVariable(sqlconn, VLMalaref)
                        PMMapeaVariable(sqlconn, VLLista)
                        PMMapeaVariable(sqlconn, VLMensajeBlq)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLBloqueado = "S" And VLMalaref = "N" Then
                        COBISMessageBox.Show(FMLoadResString(2538), FMLoadResString(2539), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLMalaref = "S" Then
                        FMLoadResString(2530)
                        COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2540), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLMalaref = "N" And VLMensajeBlq <> "" Then
                        FMLoadResString(2530)
                        COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2540), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    End If
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        PMCatalogo("V", "cl_rol", txtCampo(1), lblDescripcion(5))
                    Else
                        lblDescripcion(5).Text = ""
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text <> "" Then
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(2).Focus()
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2541)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(6))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(6).Text = ""
                            txtCampo(2).Focus()
                        End If
                    Else
                        lblDescripcion(6).Text = ""
                    End If
                    txtCampo(3).Text = ""
                    lblDescripcion(7).Text = ""
                End If
            Case 3
                If Not VLPaso Then
                    If txtCampo(3).Text <> "" Then
                        If txtCampo(2).Text.Trim() = "" Then
                            COBISMessageBox.Show(FMLoadResString(500647), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Text = ""
                            lblDescripcion(7).Text = ""
                            txtCampo(2).Focus()
                            Exit Sub
                        End If
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(502007), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Text = ""
                            lblDescripcion(7).Text = ""
                            txtCampo(0).Focus()
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2534)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(7))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(7).Text = ""
                            txtCampo(3).Focus()
                        End If
                    Else
                        lblDescripcion(7).Text = ""
                    End If
                End If
            Case 4
                If Not VLPaso Then
                    If txtCampo(4).Text <> "" Then
                        If CInt(txtCampo(4).Text) > 32767 Then
                            COBISMessageBox.Show(FMLoadResString(501098), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(4).Text = ""
                            lblDescripcion(8).Text = ""
                            txtCampo(4).Focus()
                        End If
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "8")
                        PMPasoValores(sqlconn, "@i_dep", 0, SQLINT2, txtCampo(4).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_departamento", True, FMLoadResString(2535)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(8))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(4).Text = ""
                            lblDescripcion(8).Text = ""
                            txtCampo(4).Focus()
                        End If
                    Else
                        lblDescripcion(8).Text = ""
                    End If
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Function FLVerificarMenor() As Boolean
        Dim result As Boolean = False
        Dim VTCadena As String = ""
        Dim vti As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
        'II JSA CUENTAS MENOR DE EDAD
        If txtCampo(2).Text <> "" Then 'JSA
            PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLCHAR, txtCampo(2).Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        End If
        'FI JSA CUENTAS MENOR DE EDAD
        For j As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Row = j
            grdPropietarios.Col = 5
            VTCadena = ""
            vti += 1
            grdPropietarios.Col = 1
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 5
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 4
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
        Next j
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2528)) Then
            'II JSA CUENTAS MENOR DE EDAD
            PMMapeaVariable(sqlconn, VTCadena)
            If VTCadena <> "" Then
                COBISMessageBox.Show(VTCadena, FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            End If
            'FI JSA CUENTAS MENOR DE EDAD
            PMChequea(sqlconn)
            vti = FMRetStatus(sqlconn)
            If vti <> 0 Then
                result = False
            Else
                result = True
            End If
        Else
            PMChequea(sqlconn)
            result = False
        End If
        Return result
    End Function

    Private Function FLVerificarTitularidad() As Boolean
        Dim result As Boolean = False
        Dim VTCadena As String = ""
        Dim vti As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "344")
        PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, txtCampo(2).Text)
        For j As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Row = j
            grdPropietarios.Col = 5
            VTCadena = ""
            If grdPropietarios.CtlText = "T" Or grdPropietarios.CtlText = "C" Then
                vti += 1
                grdPropietarios.Col = 1
                VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
                grdPropietarios.Col = 4
                VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
                PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
            End If
        Next j
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_titularidad", True, FMLoadResString(2528)) Then
            PMChequea(sqlconn)
            vti = FMRetStatus(sqlconn)
            If vti <> 0 Then
                result = False
            Else
                result = True
            End If
        Else
            PMChequea(sqlconn)
            result = False
        End If
        Return result
    End Function

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_3.MouseDown, _txtCampo_5.MouseDown, _txtCampo_4.MouseDown, _txtCampo_2.MouseDown, _txtCampo_0.MouseDown, _txtCampo_1.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub grdPropietarios_Leave(sender As Object, e As EventArgs) Handles grdPropietarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


