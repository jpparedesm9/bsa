Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs
Imports COBISCorp.tCOBIS.CTA.Ahos.Query
Partial Public Class FTran214Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLContractual As String = ""
    Dim VLProdbanc As String = ""
    Dim VLCategoria As String = ""
    Dim VLTipoEnte As String = ""
    Dim VLCuentaAct As String = ""
    Dim VLPaso As Boolean = False
    Dim VLFormatoFecha As String = ""
    Dim FDatoCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
    Dim FBuscarCliente As COBISCorp.tCOBIS.BClientes.FBuscarClienteClass

    Private Sub chknomulta_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles chknomulta.CheckStateChanged
        Dim Value As CheckState = chknomulta.Checked
        chknomulta_ClickHelper(Value)
    End Sub

    Private Sub chknomulta_ClickHelper(ByRef Value As CheckState)
        cmdBoton_Click(cmdBoton(0), New EventArgs())
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_7.Click, _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_6.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_8.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTMsg As String = ""
        Dim VTR As Integer = 0
        Dim VTResp As DialogResult
        TSBotones.Focus()
        Select Case Index
            Case 0
                If mskCuenta.ClipText <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "214")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_val_inac", 0, SQLVARCHAR, "N")
                    If Me.Text = "Cancelación de Cuentas C.B." Then
                        PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                    End If
                    If chknomulta.Checked Then
                        PMPasoValores(sqlconn, "@i_cob_multa", 0, SQLVARCHAR, "N")
                    Else
                        PMPasoValores(sqlconn, "@i_cob_multa", 0, SQLVARCHAR, "S")
                    End If
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_cons_cierre_ah", True, FMLoadResString(2234)) Then
                        Dim VTArreglo(20) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        For i As Integer = 1 To 9
                            lblDescripcion(i).Text = VTArreglo(i)
                        Next i
                        lblDescripcion(9).Text = VTArreglo(10)
                        VLContractual = VTArreglo(12)
                        VLCategoria = VTArreglo(13)
                        VLTipoEnte = VTArreglo(14)
                        VLProdbanc = VTArreglo(15)
                        lblDescripcion(10).Text = VTArreglo(16)
                        If lblDescripcion(5).Text.Trim() <> "" Then
                            If CDec(lblDescripcion(5).Text) <> 0 Then
                                VTMsg = FMLoadResString(2235) & " " & StringsHelper.Format(CStr(CDec(lblDescripcion(5).Text)), "#,##0.00") & ". "
                                VTMsg = VTMsg & FMLoadResString(2236) & ChrW(13)
                                VTMsg = VTMsg & FMLoadResString(2237)
                                VTR = COBISMessageBox.Show(VTMsg, FMLoadResString(501875), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
                                If VTR = System.Windows.Forms.DialogResult.No Then
                                    Exit Sub
                                End If
                            End If
                        End If
                        If VLContractual = "S" Then
                            cmdBoton(8).Enabled = True
                        End If
                        txtcausa.Enabled = True
                        lblEtiqueta(14).Enabled = True
                        cmdBoton(4).Enabled = False
                        cmdBoton(0).Enabled = False
                        cmdBoton(5).Enabled = True
                        cmdBoton(3).Enabled = True
                        txtcausa.Focus()
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
            Case 1
                For i As Integer = 0 To 12
                    lblDescripcion(i).Text = ""
                Next i
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                cmdBoton(5).Enabled = False
                cmdBoton(8).Enabled = False
                txtcausa.Text = ""
                txtCampo(0).Text = ""
                txtCampo(2).Text = ""
                txtCampo(3).Text = ""
                lblDescripcion(11).Text = ""
                txtcausa.Enabled = True
                lblEtiqueta(14).Enabled = False
                PMLimpiaGrid(grdPropietarios)
                mskCuenta.Focus()
                chknomulta.Enabled = True
                chknomulta.Checked = False
                optFPago(0).Enabled = True
                optFPago(1).Enabled = True
                optFPago(2).Enabled = True
            Case 2
                Me.Close()
            Case 3
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "298")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_val_inac", 0, SQLVARCHAR, "N")
                If Me.Text = "Cancelación de Cuentas C.B." Then
                    PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2238)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMMapeaTextoGrid(grdPropietarios)
                    PMAnchoColumnasGrid(grdPropietarios)
                    PMChequea(sqlconn)
                Else
                    PMLimpiaGrid(grdPropietarios)
                    PMMapeaTextoGrid(grdPropietarios)
                    PMAnchoColumnasGrid(grdPropietarios)
                    PMChequea(sqlconn)
                End If
            Case 4
                PLImprimir()
            Case 5
                cmdBoton_Click(cmdBoton(0), New EventArgs())
                VTResp = COBISMessageBox.Show(FMLoadResString(2234), FMLoadResString(500092), COBISMessageBox.COBISButtons.OKCancel)
                If VTResp = System.Windows.Forms.DialogResult.OK Then
                    PLCancelar()
                Else
                    Exit Sub
                End If
            Case 6
                If mskCuenta.ClipText <> "" Then
                    ReDim VGADatosI(4)
                    VGADatosI(1) = mskCuenta.ClipText
                    VGADatosI(2) = "AHO"
                    VGADatosI(3) = "0"
                    'If Me.Text = "Cancelación de Cuentas C.B." Then
                    ' VGADatosI(4) = "S"
                    'Else
                    'VGADatosI(4) = "N"
                    'End If
                    'JTA el Objeto NO VINO desde Compatibility.VB6 
                    FImagenes.Text = FMLoadResString(502403) & mskCuenta.Text & "]"
                    'JTA el Objeto NO VINO desde Compatibility.VB6 
                    'FImagenes.ShowDialog()
                    FImagenes.ShowPopup()
                Else
                    COBISMessageBox.Show(FMLoadResString(500792), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
            Case 8
                PLBuscar_marca()
        End Select
        PLTSEstado()
    End Sub

    Private Sub PLCancelar()
        Dim VTSaldomulta As String = String.Empty
        Dim VTImpuesto As String = String.Empty
        Dim VTNuevoInteres As String = String.Empty
        Dim VTSaldomulta1 As String = ""
        If txtcausa.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(501877), FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        If Not optFPago(0).Checked And Not optFPago(1).Checked And Not optFPago(2).Checked Then
            COBISMessageBox.Show(FMLoadResString(2235), FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "213")
        PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, lblDescripcion(8).Text)
        PMPasoValores(sqlconn, "@i_sldlib", 0, SQLMONEY, CStr(0))
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_cau", 0, SQLVARCHAR, txtcausa.Text)
        PMPasoValores(sqlconn, "@i_ord", 0, SQLVARCHAR, "M")
        PMPasoValores(sqlconn, "@i_aut", 0, SQLVARCHAR, VGLogin)
        PMPasoValores(sqlconn, "@i_nctrl", 0, SQLINT2, CStr(0))
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@i_monto_maximo", 0, SQLVARCHAR, "S")
        PMPasoValores(sqlconn, "@i_tadmin", 0, SQLINT1, "1")
        If optFPago(0).Checked Then
            PMPasoValores(sqlconn, "@i_fcancel", 0, SQLVARCHAR, "E")
        ElseIf optFPago(1).Checked Then
            PMPasoValores(sqlconn, "@i_fcancel", 0, SQLVARCHAR, "G")
        ElseIf optFPago(2).Checked Then
            PMPasoValores(sqlconn, "@i_fcancel", 0, SQLVARCHAR, "C")
        End If
        PMPasoValores(sqlconn, "@i_codbene", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_cobra", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_observacion", 0, SQLVARCHAR, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_observacion1", 0, SQLVARCHAR, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_val_inac", 0, SQLVARCHAR, "N")
        If chknomulta.Checked Then
            PMPasoValores(sqlconn, "@i_cobra_multa_ant", 0, SQLVARCHAR, "N")
        Else
            PMPasoValores(sqlconn, "@i_cobra_multa_ant", 0, SQLVARCHAR, "S")
        End If
        If VGOcucol = "S" Then
            PMPasoValores(sqlconn, "@i_gmf_reintegro", 0, SQLMONEY, "0")
        Else
            PMPasoValores(sqlconn, "@i_gmf_reintegro", 0, SQLMONEY, lblDescripcion(10).Text)
        End If
        PMPasoValores(sqlconn, "@o_multa", 1, SQLMONEY, "0")
        PMPasoValores(sqlconn, "@o_ssn", 1, SQLINT4, "0")
        PMPasoValores(sqlconn, "@o_nombre", 1, SQLCHAR, "0")
        PMPasoValores(sqlconn, "@o_valir", 1, SQLMONEY, "0")
        PMPasoValores(sqlconn, "@o_sldint", 1, SQLMONEY, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_cierre", True, FMLoadResString(2236)) Then
            PMChequea(sqlconn)
            If VGCodPais <> "CO" Then
                VTSaldomulta = FMRetParam(sqlconn, 1)
                VTImpuesto = FMRetParam(sqlconn, 4)
                VTNuevoInteres = FMRetParam(sqlconn, 5)
                lblDescripcion(3).Text = StringsHelper.Format(VTImpuesto, "#,##0.00")
                If VTSaldomulta.Trim() = "" Then VTSaldomulta = "0"
                If VTSaldomulta1.Trim() = "" Then VTSaldomulta1 = "0"
                lblDescripcion(2).Text = StringsHelper.Format(CStr(CDec(VTNuevoInteres)), "#,##0.00")
                lblDescripcion(4).Text = StringsHelper.Format(CStr(CDec(VTSaldomulta) + CDec(VTSaldomulta1)), "#,##0.00")
                lblDescripcion(8).Text = StringsHelper.Format(CDbl(CStr(CDec(lblDescripcion(1).Text) + CDec(lblDescripcion(2).Text) + CDec(lblDescripcion(9).Text))) - (CDec(lblDescripcion(5).Text) + CDec(lblDescripcion(3).Text) + CDec(lblDescripcion(6).Text) + CDec(lblDescripcion(4).Text)), "#,##0.00")
            End If
            cmdBoton(5).Enabled = False
            cmdBoton(4).Enabled = True
            cmdBoton(3).Enabled = False
            chknomulta.Enabled = False
            COBISMessageBox.Show(FMLoadResString(501313), FMLoadResString(501875), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        Else
            PMChequea(sqlconn)
            cmdBoton(4).Enabled = False
        End If
        PLTSEstado()
    End Sub

    Private Sub FTran214_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaAho
        lblDescripcion(0).Text = VLClienteb
        cmdBoton(4).Enabled = False
        If VGCodPais = "CO" Then
            lblEtiqueta(4).Visible = True
            lblEtiqueta(10).Visible = True
            lblDescripcion(3).Visible = True
            lblDescripcion(6).Visible = True
        Else
            lblEtiqueta(4).Visible = False
            lblEtiqueta(10).Visible = False
            lblDescripcion(3).Visible = False
            lblDescripcion(6).Visible = False
        End If
        If VGLineaPend = "N" Then
            lblEtiqueta(9).Visible = False
            lblDescripcion(7).Visible = False
        Else
            lblEtiqueta(9).Visible = True
            lblDescripcion(7).Visible = True
        End If
        txtCampo(0).Visible = False
        lblEtiqueta(13).Visible = False
        lblDescripcion(11).Visible = False
        If VGCB Then
            optFPago(2).Checked = True
            optFPago(0).Enabled = False
            optFPago(1).Enabled = False
            lblEtiqueta(3).Visible = False
            lblDescripcion(2).Visible = False
            lblEtiqueta(15).Visible = False
            lblDescripcion(10).Visible = False
            lblEtiqueta(4).Visible = False
            lblDescripcion(3).Visible = False
            lblEtiqueta(7).Visible = False
            lblDescripcion(9).Visible = False
            lblEtiqueta(10).Visible = False
            lblDescripcion(6).Visible = False
            lblEtiqueta(5).Visible = False
            lblDescripcion(4).Visible = False
        End If
        If Me.Text = "CC" Then
            Me.Text = FMLoadResString(3839)
        Else
            Me.Text = FMLoadResString(509028)
        End If

        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        If VGOcucol = "S" Then
            lblEtiqueta(15).Visible = False
            lblDescripcion(10).Visible = False
        ElseIf lblEtiqueta(9).Visible = False Then
            lblEtiqueta(15).Location =
                New System.Drawing.Point(lblEtiqueta(15).Location.X, lblEtiqueta(15).Location.Y - 21)
            lblDescripcion(10).Location =
                New System.Drawing.Point(lblDescripcion(10).Location.X, lblDescripcion(10).Location.Y - 21)
        End If
        _optFPago_1.Visible = False
    End Sub

    Private Sub FTran214_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        VGCB = False
    End Sub

    Private Sub grdPropietarios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Click
        grdPropietarios.Col = 0
        grdPropietarios.SelStartCol = 1
        grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
        If grdPropietarios.Row = 0 Then
            grdPropietarios.SelStartRow = 1
            grdPropietarios.SelEndRow = 1
        Else
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
        End If
        PLTSEstado()
    End Sub

    Private Sub grdPropietarios_DblClick(sender As Object, e As EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If Me.Text = "Cancelación de Cuentas C.B." Then
                    PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                End If
                PMPasoValores(sqlconn, "@i_val_inac", 0, SQLVARCHAR, "N")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                    cmdBoton(3).Enabled = True
                    If VLCuentaAct <> mskCuenta.ClipText Then
                        PMLimpiaGrid(grdPropietarios)
                    End If
                Else
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    PMChequea(sqlconn)
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                cmdBoton_Click(cmdBoton(1), New EventArgs())
                Exit Sub
            End If
            VLCuentaAct = mskCuenta.ClipText
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        PLTSEstado()
    End Sub

    Private Sub PLImprimir()
        Dim banderaContinuar As Boolean = True
        If COBISMessageBox.Show(FMLoadResString(2238), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.No Then
            banderaContinuar = False
        End If
        If banderaContinuar Then
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            FMCabeceraReporte(VGBanco, DateTimeHelper.ToString(DateTime.Today), "SOLICITUD DE CANCELACIÓN DE CUENTAS DE AHORROS", DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Número de Cuenta           :", FileSystem.TAB(32), mskCuenta.Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Nombre de la Cuenta        :", FileSystem.TAB(32), lblDescripcion(0).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Saldo Disponible           :", FileSystem.TAB(32), lblDescripcion(1).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
            If lblDescripcion(2).Text <> "0.00" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Intereses Ganados          :", FileSystem.TAB(32), lblDescripcion(2).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
            End If
            If lblDescripcion(9).Text <> "0.00" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Mant. de Valor             :", FileSystem.TAB(32), lblDescripcion(9).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
            End If
            If lblDescripcion(4).Text <> "0.00" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Multa                      :", FileSystem.TAB(32), lblDescripcion(4).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
            End If
            If lblDescripcion(3).Text <> "0.00" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Impuesto                   :", FileSystem.TAB(32), lblDescripcion(3).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
            End If
            If lblDescripcion(5).Text <> "0.00" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Valores en Suspenso        :", FileSystem.TAB(32), lblDescripcion(5).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
            End If
            If lblDescripcion(6).Text <> "0.00" Then
                If VGCodPais = "CO" Then
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  GMF                        :", FileSystem.TAB(32), lblDescripcion(6).Text)
                Else
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Imp. al Débito Bancario    :", FileSystem.TAB(32), lblDescripcion(6).Text)
                End If
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Saldo de Cancelación       :", FileSystem.TAB(32), lblDescripcion(8).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  ")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Causa Cancelación          :", FileSystem.TAB(32), txtcausa.Text & " - " & lblDescripcion(12).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Observaciones              :", FileSystem.TAB(32), txtCampo(2).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("                              ", FileSystem.TAB(32), txtCampo(3).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  " & New String("_", 130))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), VGLogin)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  _________________                                                 _________________")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("    PROCESADO POR                                                     AUTORIZADO POR ")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  _________________")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  FIRMA DEL CLIENTE")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        Else
            Exit Sub
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optFPago_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optFPago_2.CheckedChanged, _optFPago_1.CheckedChanged, _optFPago_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optFPago, eventSender)
            txtCampo(0).Text = ""
            lblDescripcion(11).Text = ""
            txtCampo(0).Visible = False
            lblEtiqueta(13).Visible = False
            lblDescripcion(11).Visible = False
            Select Case Index
                Case 1
                    txtCampo(0).Visible = True
                    lblEtiqueta(13).Visible = True
                    lblDescripcion(11).Visible = True
            End Select
        End If
        PLTSEstado()
    End Sub

    Private Sub optFPago_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optFPago_2.Enter, _optFPago_1.Enter, _optFPago_0.Enter
        Dim Index As Integer = Array.IndexOf(optFPago, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2228))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2229))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2230))
        End Select

    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_3.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
        PLTSEstado()
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_3.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2231))
            Case 2, 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501319))
        End Select
        VLPaso = True
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)

    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_3.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTCliente As String = 0
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    txtCampo(0).Text = ""
                    VLPaso = True                    'DLL CLIENTES
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
                            lblDescripcion(11).Text = VGBusqueda(4) & " " & VGBusqueda(2) & " " & VGBusqueda(3)
                        End If
                    Else
                        txtCampo(0).Text = ""
                        lblDescripcion(11).Text = ""
                        txtCampo(0).Focus()
                    End If
            End Select
            VLPaso = True
        End If
        PLTSEstado()
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("U", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        PLTSEstado()
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_3.Leave
        Dim VLMensajeBlq As String = String.Empty
        Dim VLBloqueado As String = ""
        Dim VLMalaref As String = ""
        Dim VLLista As String = ""
        Dim VTCliente As String = 0
        If Not VLPaso Then
            If txtCampo(0).Text <> "" Then
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1225")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente", True, FMLoadResString(2239) & txtCampo(0).Text & "]") Then
                    Dim VTValores(15) As String
                    FMMapeaArreglo(sqlconn, VTValores)
                    PMChequea(sqlconn)
                    VTCliente = VTValores(1) ' + " " + VTValores(3) + " " + VTValores(4)
                    lblDescripcion(11).Text = VTCliente
                Else
                    PMChequea(sqlconn)
                    txtCampo(0).Text = ""
                    lblDescripcion(11).Text = ""
                    txtCampo(0).Focus()
                End If
            Else
                lblDescripcion(11).Text = ""
            End If
        End If
        If txtCampo(0).Text <> "" Then
            VLMensajeBlq = ""
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "175")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "B")
            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(0).Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_ente_bloqueado", True, FMLoadResString(2240)) Then
                PMMapeaVariable(sqlconn, VLBloqueado)
                PMMapeaVariable(sqlconn, VLMalaref)
                PMMapeaVariable(sqlconn, VLLista)
                PMMapeaVariable(sqlconn, VLMensajeBlq)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                lblDescripcion(11).Text = ""
                txtCampo(0).Text = ""
                txtCampo(0).Focus()
                Exit Sub
            End If
            If VLBloqueado = "S" And VLMalaref = "N" Then
                COBISMessageBox.Show(FMLoadResString(2241), FMLoadResString(2242), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                lblDescripcion(11).Text = ""
                txtCampo(0).Text = ""
                txtCampo(0).Focus()
                Exit Sub
            End If
            If VLMalaref = "S" Then
                COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2243), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                lblDescripcion(11).Text = ""
                txtCampo(0).Text = ""
                txtCampo(0).Focus()
                Exit Sub
            End If
            If VLMalaref = "N" And VLMensajeBlq <> "" Then
                COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2243), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        PLTSEstado()
    End Sub

    Private Sub txtcausa_Change(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtcausa.Change
        VLPaso = False
    End Sub

    Private Sub txtcausa_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtcausa.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2232))
    End Sub

    Private Sub txtcausa_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles txtcausa.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            PMCatalogo("A", "ah_causa_cierre", txtcausa, lblDescripcion(12))
            If txtcausa.Text <> "" Then
                VLPaso = True
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub txtcausa_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtcausa.Leave
        Dim VTParContracual(15, 2) As String
        If Not VLPaso Then
            If txtcausa.Text <> "" Then
                PMCatalogo("V", "ah_causa_cierre", txtcausa, lblDescripcion(12))
                VLPaso = True
            Else
                lblDescripcion(12).Text = ""
            End If
        End If
        If txtcausa.Text = "6" Then
            optFPago(2).Checked = True
            optFPago(0).Enabled = False
            optFPago(1).Enabled = False
            optFPago(2).Enabled = False
        Else
            If Not optFPago(0).Enabled Or Not optFPago(1).Enabled Or Not optFPago(1).Enabled Then
                optFPago(0).Enabled = True
                optFPago(1).Enabled = True
                optFPago(2).Enabled = True
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHCT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VTParContracual)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        If VLContractual = "S" And VLProdbanc = VTParContracual(6, 1) Then
            If txtcausa.Text = "1" Or txtcausa.Text = "" Then
                chknomulta.Checked = False
                chknomulta.Enabled = False
            Else
                If txtcausa.Text <> "" Then
                    chknomulta.Checked = True
                    chknomulta.Enabled = False
                End If
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub PLBuscar_marca()
        Dim VLParametro(15, 2) As String
        Dim VTCambiaCategoria As String = ""
        Dim VLMarca As String = ""
        Dim VLProdfinal As String = ""
        Dim VLParametriza As String = ""
        Dim VLContractual As String = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "CAMCAT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(3, 1) = VLCategoria Then
                VTCambiaCategoria = "S"
            Else
                VTCambiaCategoria = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(734))
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, VLCategoria)
        PMPasoValores(sqlconn, "@i_prodban", 0, SQLVARCHAR, VLProdbanc)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_tipoente", 0, SQLCHAR, VLTipoEnte)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_aho_contractual", True, FMLoadResString(2245)) Then
            PMMapeaVariable(sqlconn, VLMarca)
            PMMapeaVariable(sqlconn, VLProdfinal)
            PMMapeaVariable(sqlconn, VLParametriza)
            PMMapeaVariable(sqlconn, VLContractual)
            PMChequea(sqlconn)
            If VLMarca = "S" Then
                If StringsHelper.ToDoubleSafe(VLParametriza) <> 0 Or VTCambiaCategoria = "S" Then
                    VGcategoria = VLCategoria
                    VGprofinal = VLProdfinal
                    VGCuenta = mskCuenta.ClipText
                    VGOrigen = "1"
                    Ftran434.ShowPopup()
                Else
                    COBISMessageBox.Show(FMLoadResString(2246) & " " & VLProdfinal & " " & FMLoadResString(2247) & " " & lblDescripcion(14).Text & " ", FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
            Else
                VGCancelar = "N"
            End If
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBPropietario.Enabled = _cmdBoton_3.Enabled
        TSBPropietario.Visible = _cmdBoton_3.Visible
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBFirmas.Enabled = _cmdBoton_6.Enabled
        TSBFirmas.Visible = False '_cmdBoton_6.Visible
        TSBTransmitir.Enabled = _cmdBoton_5.Enabled
        TSBTransmitir.Visible = _cmdBoton_5.Visible
        TSBSiguientes.Enabled = _cmdBoton_8.Enabled
        TSBSiguientes.Visible = _cmdBoton_8.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBPropietario_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPropietario.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBFirmas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBFirmas.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_8.Enabled Then cmdBoton_Click(_cmdBoton_8, e)
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

    Private Sub grdPropietarios_Leave(sender As Object, e As EventArgs) Handles grdPropietarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMLineaG(grdPropietarios)
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub
End Class



