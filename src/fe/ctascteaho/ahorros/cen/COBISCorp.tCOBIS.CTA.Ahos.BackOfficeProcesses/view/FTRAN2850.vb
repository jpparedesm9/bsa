Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class FTRAN2850Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLCredito As Double = 0
    Dim VLDebito As Double = 0
    Dim VLLin As Integer = 0

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub optEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_3.Enter, _optEstado_2.Enter, _optEstado_1.Enter, _optEstado_0.Enter
        Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
        Select Case Index
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5067) & " [ " & FMLoadResString(500595) & " ] ")
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5067) & " [ " & FMLoadResString(500594) & " ] ")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5067) & " [ " & FMLoadResString(500000) & " ] ")
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5067) & " [ " & FMLoadResString(500001) & " ] ")
        End Select
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509133)) 'Transacciones Crédito/Débito
    End Sub

    Private Sub PLReversar()
        Dim VLMarcadas As Integer = 0
        For i As Integer = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            grdRegistros.Col = 0
            If grdRegistros.Picture.Equals(picVisto(0).Image) Then
                VLMarcadas += 1
            End If
        Next i
        If VLMarcadas = 0 Then
            Exit Sub
        End If
        If COBISMessageBox.Show(FMLoadResString(500600), FMLoadResString(2604), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2) = System.Windows.Forms.DialogResult.No Then '¿Esta seguro de Reversar la(s) Transaccion(es) Seleccionada(s)?
            Exit Sub
        End If
        For i As Integer = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            grdRegistros.Col = 0
            If grdRegistros.Picture.Equals(picVisto(0).Image) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
                grdRegistros.Col = 2
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 18
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "R")
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 7
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Col = 4
                PMPasoValores(sqlconn, "@i_trn", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 9
                PMPasoValores(sqlconn, "@i_funcionario", 0, SQLVARCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 6
                PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, grdRegistros.CtlText)
                grdRegistros.Col = 11
                PMPasoValores(sqlconn, "@i_ssn_branch", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 8
                PMPasoValores(sqlconn, "@i_cau", 0, SQLCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 10
                PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_autorizante", 0, SQLVARCHAR, lblDescripcion(0).Text)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_autndc_ccah", True, FMLoadResString(509044)) Then 'Ok... Reversa Transacciones....
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            End If
        Next i
        PLBuscar()
    End Sub

    Private Sub FTRAN2850_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        'FPrincipal.Cursor = System.Windows.Forms.Cursors.WaitCursor
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)        
        picVisto(0).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31001")
        picVisto(1).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31002")

        cmbTipo.Items.Insert(0, FMLoadResString(502554)) 'CUENTA CORRIENTE
        cmbTipo.Items.Insert(1, FMLoadResString(502555)) 'CUENTA DE AHORROS
        cmbTipo.Items.Insert(2, FMLoadResString(500515)) 'TODAS
        cmbTipo.SelectedIndex = 1
        cmbTipo.Enabled = False
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        PLLimpiar()
        PLConsultaFuncionario()
        PLTSEstado()
    End Sub

    Private Sub PLConsultaFuncionario()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
        PMPasoValores(sqlconn, "@i_login", 0, SQLVARCHAR, VGLogin)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "SF")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "0")
        PMPasoValores(sqlconn, "@i_autorizante", 0, SQLVARCHAR, " ")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_autndc_ccah", True, FMLoadResString(509045)) Then 'Ok.. Consulta de Funcionarios...
            PMMapeaObjetoAB(sqlconn, lblDescripcion(0), lblDescripcion(1))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
            cmbTipo.Enabled = False
            mskCuenta.Enabled = False
            cmdBoton(0).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = False
            cmdBoton(3).Enabled = False
            cmdBoton(4).Enabled = True
            cmdBoton(5).Enabled = False
            optEstado(0).Enabled = False
            optEstado(1).Enabled = False
            optEstado(2).Enabled = False
        End If
        PLTSEstado()
    End Sub

    Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        If cmbTipo.SelectedIndex = 0 Then
            mskCuenta.Mask = VGMascaraCtaCte
        ElseIf cmbTipo.SelectedIndex = 1 Then
            mskCuenta.Mask = VGMascaraCtaAho
        End If
        mskCuenta_Leave(mskCuenta, New EventArgs())
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Try
            If mskCuenta.ClipText <> "" Then
                If cmbTipo.SelectedIndex = 0 Then
                    If FMChequeaCtaCte(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(502522) & "[" & mskCuenta.Text & "]") Then 'Ok... Cuenta
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(2).Text = ""
                            mskCuenta.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El dígito verificador de la cuenta está incorrecto
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(2).Text = ""
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                ElseIf cmbTipo.SelectedIndex = 1 Then
                    If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502522) & "[" & mskCuenta.Text & "]") Then 'Ok... Cuenta
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(2).Text = ""
                            mskCuenta.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(508917), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El dígito verificador de la cuenta de ahorros está incorrecto
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(2).Text = ""
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500430), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Si se desea consultar una cuenta especifica se debe escoger el producto de la cuenta
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    If cmbTipo.Enabled Then cmbTipo.Focus()
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 4
                Me.Close()
            Case 3
                PLLimpiar()
            Case 2
                PLTransmitir()
            Case 1
                PLRechazar()
            Case 0
                PLBuscar()
            Case 5
                PLImprimir()
                'PLBuscar()
            Case 6
                PLReversar()
        End Select
        PLTSEstado()
    End Sub

    Private Sub PLImprimir()
        Dim VTProducto As String = ""
        Dim VTEstadond As String = ""
        Dim VTTitulo As String = String.Empty
        VLDebito = 0
        VLCredito = 0
        VLLin = 0
        PMLimpiaGrid(grdRegistros)
        grdRegistros.Col = 0
        grdRegistros.Picture = picVisto(1).Image
        Dim VTRegistros As Integer = 10
        Dim VTFlag As Boolean = False
        Dim VTSecuencial As Integer = 0        
        While VTRegistros = 10
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
            PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, CStr(VTSecuencial))
            PMPasoValores(sqlconn, "@i_autorizante", 0, SQLVARCHAR, lblDescripcion(0).Text)
            Select Case cmbTipo.SelectedIndex
                Case 0
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
                    VTProducto = " -CORRIENTES- "
                Case 1
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
                    PMPasoValores(sqlconn, "@i_producto1", 0, SQLINT4, "4") 'agregado jta
                    VTProducto = " -AHORROS- "
                Case 2
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
                    PMPasoValores(sqlconn, "@i_producto1", 0, SQLINT4, "4")
                    VTProducto = " -TODOS- "
            End Select
            If optEstado(0).Checked Then
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "I")
                VTEstadond = " (INGRESADAS) "
            Else
                If optEstado(1).Checked Then
                    PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "A")
                    VTEstadond = " (AUTORIZADAS) "
                Else
                    If optEstado(2).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "R")
                        VTEstadond = " (RECHAZADAS) "
                    Else
                        If optEstado(3).Checked Then
                            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
                            VTEstadond = " (REVERSADA) "
                        End If
                    End If
                End If
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_autndc_ccah", True, FMLoadResString(509046)) Then 'Ok... Consulta de Transacciones Por Autorizar
                PMMapeaGrid(sqlconn, grdRegistros, VTFlag)
                PMChequea(sqlconn)
                VTFlag = True
                VTRegistros = Conversion.Val(Convert.ToString(grdRegistros.Tag))
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                If VTRegistros <> 0 Then
                    VTSecuencial = CInt(grdRegistros.CtlText)
                End If
            Else
                PMChequea(sqlconn)
                VTRegistros = 0
            End If
        End While
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                cmdBoton(2).Enabled = False
                cmdBoton(1).Enabled = False
                cmdBoton(6).Enabled = False
            Else
                If optEstado(0).Checked Then
                    cmdBoton(2).Enabled = True
                    cmdBoton(1).Enabled = True
                End If
            End If
        Else
            If optEstado(0).Checked Then
                cmdBoton(2).Enabled = True
                cmdBoton(1).Enabled = True
            End If
        End If
        PMAnchoColumnasGrid(grdRegistros)
        PLTSEstado()
        Try
            If COBISMessageBox.Show(FMLoadResString(500602), FMLoadResString(500018), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.Yes Then 'Esta seguro de imprimir el reporte de Notas de Débito/Crédito
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Orientation = COBISCorp.Framework.UI.Components.COBISPrinterNet.Constants.vbPRDPHorizontal
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                VTTitulo = FMLoadResString(509047) & VTProducto & VTEstadond 'NOTAS CREDITO Y NOTAS DEBITO
                FMCabeceraReporteSob(VGBanco, DateTimeHelper.ToString(DateTime.Today), VTTitulo, DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Page))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 7
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 180))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(9026), FileSystem.TAB(13), FMLoadResString(509048), FileSystem.TAB(45)) 'Cuenta'Nombre.
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509049), FileSystem.TAB(110), FMLoadResString(509050), FileSystem.TAB(119)) 'Transaccion.'  Monto.
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509051), FileSystem.TAB(129), FMLoadResString(509052), FileSystem.TAB(169), FMLoadResString(509053), FileSystem.TAB(105)) '  Causa.'Concepto.'  Usuario.
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 180))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                For j As Integer = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = j
                    grdRegistros.Col = 1
                    For i As Integer = 2 To 8
                        grdRegistros.Col = i
                        Select Case i
                            Case 2
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(1 + 11 - Strings.Len(grdRegistros.CtlText)))
                            Case 3
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(13))
                            Case 4
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(45))
                            Case 5
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(118 - Strings.Len(grdRegistros.CtlText)))
                            Case 6
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(126 - Strings.Len(grdRegistros.CtlText)))
                            Case 7
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(129))
                            Case 8
                                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(169))
                        End Select
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, grdRegistros.CtlText)
                    Next i
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                    VLLin += 1
                    If VLLin = 50 Then
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
                        FMCabeceraReporteSob(VGBanco, DateTimeHelper.ToString(DateTime.Today), VTTitulo, DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Page))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 180))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(9026), FileSystem.TAB(13), FMLoadResString(509048), FileSystem.TAB(45)) 'Cuenta'Nombre.
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509049), FileSystem.TAB(110), FMLoadResString(509050), FileSystem.TAB(119)) 'Transaccion.'  Monto.
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509051), FileSystem.TAB(129), FMLoadResString(509052), FileSystem.TAB(169), FMLoadResString(509053), FileSystem.TAB(105)) '  Causa.'Concepto.'  Usuario.
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 180))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                    End If
                Next j
                For j As Integer = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = j
                    grdRegistros.Col = 10
                    If grdRegistros.CtlText = "48" Or grdRegistros.CtlText = "253" Then
                        grdRegistros.Col = 5
                        VLCredito += CDbl(grdRegistros.CtlText)
                    End If
                    If grdRegistros.CtlText = "240" Or grdRegistros.CtlText = "2502" Or grdRegistros.CtlText = "264" Or grdRegistros.CtlText = "50" Then
                        grdRegistros.Col = 5
                        VLDebito += CDbl(grdRegistros.CtlText)
                    End If
                Next j
                lblDescripcion(3).Text = StringsHelper.Format(VLCredito, "#,##0.00")
                lblDescripcion(4).Text = StringsHelper.Format(VLDebito, "#,##0.00")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 7
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 180))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509054), FileSystem.TAB(55 + 10 - Strings.Len(lblDescripcion(3).Text)), lblDescripcion(3).Text) 'Total Notas Crédito                   :
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509055), FileSystem.TAB(55 + 10 - Strings.Len(lblDescripcion(4).Text)), lblDescripcion(4).Text) 'Total Notas Débito                    :
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                If VGCodPais <> "CO" Then
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(5088743)) '---  U L T I M A   L I N E A  ---
                End If
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
                Me.Cursor = System.Windows.Forms.Cursors.Default
            End If
        Catch
            COBISMessageBox.Show(FMLoadResString(500603) & Conversion.ErrorToString(), My.Application.Info.ProductName) 'Se generó el siguiente error al intetar realizar la impresión, favor contacte a soporte:
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Exit Sub
        End Try
    End Sub

    Private Sub PLSiguiente()
        Dim VTSecuencial As String = ""
        Dim VTFlag As Boolean = True
        Dim VTRegistros As Integer = 10
        While VTRegistros = 10
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            VTSecuencial = grdRegistros.CtlText
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            If mskCuenta.ClipText <> "" Then
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            End If
            PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VTSecuencial)
            PMPasoValores(sqlconn, "@i_autorizante", 0, SQLVARCHAR, lblDescripcion(0).Text)
            Select Case cmbTipo.SelectedIndex
                Case 0
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
                Case 1
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
                Case 2
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
                    PMPasoValores(sqlconn, "@i_producto1", 0, SQLINT4, "4")
            End Select
            If optEstado(0).Checked Then
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "I")
            Else
                If optEstado(1).Checked Then
                    PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "A")
                Else
                    If optEstado(2).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "R")
                    Else
                        If optEstado(3).Checked Then
                            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
                        End If
                    End If
                End If
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_autndc_ccah", True, FMLoadResString(509046)) Then 'Ok... Consulta de Transacciones Por Autorizar
                PMMapeaGrid(sqlconn, grdRegistros, VTFlag)
                PMChequea(sqlconn)
                VTFlag = True
                If Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 10 Then
                    VTRegistros = 0
                End If
            Else
                PMChequea(sqlconn)
                VTRegistros = 0
            End If
        End While
        grdRegistros.ColWidth(1) = 900
        grdRegistros.ColWidth(2) = 1000
        grdRegistros.ColWidth(3) = 2700
        grdRegistros.ColWidth(4) = 900
        grdRegistros.ColWidth(11) = 3000
        grdRegistros.ColWidth(12) = 1500
    End Sub

    Private Sub PLBuscar()
        PMLimpiaGrid(grdRegistros)
        grdRegistros.Col = 0
        grdRegistros.Picture = picVisto(1).Image        
        Dim VTFlag As Boolean = False
        Dim VTSecuencial As Integer = 0        
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        If mskCuenta.ClipText <> "" Then
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        End If
        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, CStr(VTSecuencial))
        PMPasoValores(sqlconn, "@i_autorizante", 0, SQLVARCHAR, lblDescripcion(0).Text)
        Select Case cmbTipo.SelectedIndex
            Case 0
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
            Case 1
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
                PMPasoValores(sqlconn, "@i_producto1", 0, SQLINT4, "4")
            Case 2
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
                PMPasoValores(sqlconn, "@i_producto1", 0, SQLINT4, "4")
        End Select
        If optEstado(0).Checked Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "I")
        Else
            If optEstado(1).Checked Then
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "A")
            Else
                If optEstado(2).Checked Then
                    PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "R")
                Else
                    If optEstado(3).Checked Then
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
                    End If
                End If
            End If
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_autndc_ccah", True, FMLoadResString(509046)) Then 'Ok... Consulta de Transacciones Por Autorizar
            PMMapeaGrid(sqlconn, grdRegistros, VTFlag)
            PMChequea(sqlconn)
            grdRegistros.Col = 0
            For i As Integer = 1 To grdRegistros.Rows - 1
                grdRegistros.Row = i
                grdRegistros.Picture = picVisto(1).Image
            Next i
            VTFlag = True
            If Conversion.Val(CStr(grdRegistros.Rows - 1)) >= 10 Then
                PLSiguiente()
            End If
            If grdRegistros.Rows <= 2 Then
                grdRegistros.Col = 1
                grdRegistros.Row = 1
            End If
        Else
            PMChequea(sqlconn)
        End If
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                cmdBoton(2).Enabled = False
                cmdBoton(1).Enabled = False
                cmdBoton(6).Enabled = False
            Else
                If optEstado(0).Checked Then
                    cmdBoton(2).Enabled = True
                    cmdBoton(1).Enabled = True
                End If
            End If
        Else
            If optEstado(0).Checked Then
                cmdBoton(2).Enabled = True
                cmdBoton(1).Enabled = True
                cmdBoton(6).Enabled = True
            End If
        End If
        If CDbl(Convert.ToString(grdRegistros.Tag)) = 0 Then
            cmdBoton(5).Enabled = False
        Else
            cmdBoton(5).Enabled = True
        End If

        PMAnchoColumnasGrid(grdRegistros)
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500604), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'No existen Registros por Autorizar
                Exit Sub
            End If
        Else
            If optEstado(2).Checked Then
                COBISMessageBox.Show(FMLoadResString(500605), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'No Puede seleccionar Transacciones Rechazadas
                Exit Sub
            End If
        End If
        PMMarcarRegistro()
    End Sub

    Private Sub PMMarcarRegistro()
        grdRegistros.Col = 0
        If grdRegistros.Picture.Equals(picVisto(1).Image) Then
            grdRegistros.CtlText = Conversion.Str(grdRegistros.Row)
            grdRegistros.Picture = picVisto(0).Image
        Else
            grdRegistros.CtlText = Conversion.Str(grdRegistros.Row)
            grdRegistros.Picture = picVisto(1).Image
        End If
    End Sub

    Private Sub PLTransmitir()
        Dim VTTransaccion As String = ""
        Dim VLMarcadas As Integer = 0
        For i As Integer = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            grdRegistros.Col = 0
            If grdRegistros.Picture.Equals(picVisto(0).Image) Then
                VLMarcadas += 1
            End If
        Next i
        If VLMarcadas = 0 Then
            Exit Sub
        End If
        If COBISMessageBox.Show(FMLoadResString(500606), FMLoadResString(2604), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2) = System.Windows.Forms.DialogResult.No Then '¿Esta seguro de Autorizar la(s) Transaccion(es) Seleccionada(s)?
            Exit Sub
        End If
        For i As Integer = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            grdRegistros.Col = 0
            If grdRegistros.Picture.Equals(picVisto(0).Image) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
                grdRegistros.Col = 2
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 18
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 7
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Col = 4
                VTTransaccion = grdRegistros.CtlText
                PMPasoValores(sqlconn, "@i_trn", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 9
                PMPasoValores(sqlconn, "@i_funcionario", 0, SQLVARCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 6
                PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, grdRegistros.CtlText)
                grdRegistros.Col = 11
                PMPasoValores(sqlconn, "@i_ssn_branch", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 8
                PMPasoValores(sqlconn, "@i_cau", 0, SQLCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 10
                PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 11
                PMPasoValores(sqlconn, "@i_sec_branch", 0, SQLINT4, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_autorizante", 0, SQLVARCHAR, lblDescripcion(0).Text)
                Select Case VTTransaccion
                    Case "2502"
                        grdRegistros.Col = 13
                        PMPasoValores(sqlconn, "@i_ctachq", 0, SQLVARCHAR, grdRegistros.CtlText)
                        grdRegistros.Col = 14
                        PMPasoValores(sqlconn, "@i_nchq", 0, SQLINT4, grdRegistros.CtlText)
                        grdRegistros.Col = 15
                        PMPasoValores(sqlconn, "@i_tipchq", 0, SQLVARCHAR, grdRegistros.CtlText)
                        grdRegistros.Col = 16
                        PMPasoValores(sqlconn, "@i_codbanco", 0, SQLVARCHAR, grdRegistros.CtlText)
                    Case "240"
                        grdRegistros.Col = 13
                        PMPasoValores(sqlconn, "@i_ctachq", 0, SQLVARCHAR, grdRegistros.CtlText)
                        grdRegistros.Col = 14
                        PMPasoValores(sqlconn, "@i_nchq", 0, SQLINT4, grdRegistros.CtlText)
                        grdRegistros.Col = 16
                        PMPasoValores(sqlconn, "@i_codbanco", 0, SQLVARCHAR, grdRegistros.CtlText)
                End Select
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_autndc_ccah", True, FMLoadResString(509056)) Then ' Ok... Autoriza Transacciones....
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            End If
        Next i
        PLBuscar()
    End Sub

    Private Sub PLRechazar()
        Dim VLMarcadas As Integer = 0
        For i As Integer = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            grdRegistros.Col = 0
            If grdRegistros.Picture.Equals(picVisto(0).Image) Then
                VLMarcadas += 1
            End If
        Next i
        If VLMarcadas = 0 Then
            Exit Sub
        End If
        If COBISMessageBox.Show(FMLoadResString(500607), FMLoadResString(2604), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2) = System.Windows.Forms.DialogResult.No Then '¿Esta seguro de Rechazar la(s) Transaccion(es) Seleccionada(s)?
            Exit Sub
        End If
        For i As Integer = 1 To (grdRegistros.Rows - 1)
            grdRegistros.Row = i
            grdRegistros.Col = 0
            If grdRegistros.Picture.Equals(picVisto(0).Image) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
                grdRegistros.Col = 2
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 18
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "R")
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 7
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, grdRegistros.CtlText)
                grdRegistros.Col = 4
                PMPasoValores(sqlconn, "@i_trn", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 9
                PMPasoValores(sqlconn, "@i_funcionario", 0, SQLVARCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 6
                PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, grdRegistros.CtlText)
                grdRegistros.Col = 11
                PMPasoValores(sqlconn, "@i_ssn_branch", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 8
                PMPasoValores(sqlconn, "@i_cau", 0, SQLCHAR, grdRegistros.CtlText)
                grdRegistros.Col = 10
                PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@i_autorizante", 0, SQLVARCHAR, lblDescripcion(0).Text)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "R")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_autndc_ccah", True, FMLoadResString(509056)) Then 'Ok... Autoriza Transacciones....
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            End If
        Next i
        PLBuscar()
    End Sub

    Private Sub PLLimpiar()
        PMLimpiaGrid(grdRegistros)
        grdRegistros.Col = 0
        ' grdRegistros.Picture = picVisto(1).Image
        grdRegistros.Picture = Nothing
        cmbTipo.SelectedIndex = 1
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        lblDescripcion(2).Text = ""
        cmbTipo.Focus()
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = False
        cmdBoton(6).Enabled = False
        cmdBoton(2).Enabled = False
        cmdBoton(3).Enabled = True
        cmdBoton(4).Enabled = True
        cmdBoton(5).Enabled = False
        optEstado(0).Enabled = True
        optEstado(1).Enabled = True
        optEstado(2).Enabled = True
        optEstado(0).Checked = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optEstado_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_1.CheckedChanged, _optEstado_0.CheckedChanged, _optEstado_2.CheckedChanged, _optEstado_3.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
            Dim Value As Integer = optEstado(Index).Checked
            optEstado_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optEstado_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        If Index = 0 Then
            cmdBoton(6).Enabled = True
            cmdBoton(1).Enabled = True
        Else
            If Index = 1 Then
                cmdBoton(6).Enabled = False
                cmdBoton(1).Enabled = False
            End If
        End If
        PLBuscar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBImprimir.Enabled = _cmdBoton_5.Enabled
        TSBImprimir.Visible = _cmdBoton_5.Visible
        TSBRechazar.Enabled = _cmdBoton_1.Enabled
        TSBRechazar.Visible = _cmdBoton_1.Visible
        TSBAutorizar.Enabled = _cmdBoton_2.Enabled
        TSBAutorizar.Visible = _cmdBoton_2.Visible
        TSBReversar.Enabled = _cmdBoton_6.Enabled
        TSBReversar.Visible = _cmdBoton_6.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBRechazar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBRechazar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBAutorizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAutorizar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBReversar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBReversar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

End Class


