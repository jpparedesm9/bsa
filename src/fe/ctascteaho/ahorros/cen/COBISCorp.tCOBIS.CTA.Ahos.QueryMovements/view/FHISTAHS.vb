Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FHistoricoASClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLcompara As Integer = 0
    Dim VLVista As String = ""
    Dim VLTran As String = ""
    Dim VLSP As String = ""
    Dim VLPosGrid As Integer = 0
    Dim VTModo As Integer = 0
    Dim VLBandera As Boolean = False
    Dim VTColumna As Integer = 0
    Dim VT As Integer = 0

    Private Property EventHandler As Object


    Private Sub FHistoricoAS_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" 'JSA
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar() 'JSA
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
        mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha)
        mskfechahasta.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        mskCuenta.Mask = VGMascaraCtaAho

        mskValor(0).Text = VGDecimales
        mskValor(0).Text = StringsHelper.Format(0, VGDecimales)
        mskValor(1).Text = VGDecimales
        mskValor(1).Text = StringsHelper.Format(0, VGDecimales)

        txtCampo(4).Text = StringsHelper.Format(0, "#,###,###,##0")
        txtCampo(5).Text = StringsHelper.Format(0, VGDecimales)
        cmdBoton(7).Enabled = False
        VLPosGrid = 1
        VLBandera = False
        PLFormatoFecha()
    End Sub

    Private Sub FHistoricoAS_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub


    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click

        TSBotones.Focus()
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VLTabla As String = ""
        Select Case Index
            Case 0
                txtCampo(4).Text = StringsHelper.Format(0, "#,###,###,##0")
                txtCampo(5).Text = StringsHelper.Format(0, VGDecimales)
                If Not VLBandera Then
                    VTModo = False
                End If
                If (CInt(mskValor(1).ClipText) < CInt(mskValor(0).ClipText)) Then
                    COBISMessageBox.Show(FMLoadResString(9996), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    mskValor(0).Text = "0.00"
                    mskValor(0).Focus()
                    Exit Sub
                ElseIf txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500691), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                ElseIf mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(503356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                    Exit Sub
                ElseIf mskfechahasta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(503357), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskfechahasta.Focus()
                    Exit Sub
                Else
                    VLcompara = Conversion.Val(txtCampo(1).Text)
                    If mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha) And CDate(mskFecha.Text) = CDate(mskfechahasta.Text) Or VLBandera Then
                        VLBandera = False
                        VLTran = "282"
                        VLSP = "sp_qry_trnsrv_ah"
                    ElseIf CDate(mskFecha.Text) <= CDate(mskfechahasta.Text) Then
                        VLBandera = True
                        VLTran = "283"
                        VLSP = "sp_qry_hists_ah"
                    Else
                        mskfechahasta.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                        VLTran = "283"
                        VLSP = "sp_qry_hists_ah"
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTran)
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_ofi_desde", 0, SQLINT2, txtCampo(0).Text)
                    End If
                    If txtCampo(2).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_ofi_hasta", 0, SQLINT2, txtCampo(2).Text)
                    End If
                    If CDec(mskValor(0).Text.Trim()) > 0 Then
                        PMPasoValores(sqlconn, "@i_monto_desde", 0, SQLMONEY, mskValor(0).Text)
                    End If
                    If CDec(mskValor(1).Text.Trim()) > 0 Then
                        PMPasoValores(sqlconn, "@i_monto_hasta", 0, SQLMONEY, mskValor(1).Text)
                    End If
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, txtCampo(3).Text)
                    End If
                    PMPasoValores(sqlconn, "@i_tipotrn", 0, SQLINT4, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                    PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    PMPasoValores(sqlconn, "@i_vista", 0, SQLINT2, VLVista)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_alt", 0, SQLINT4, "0")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", VLSP, True, FMLoadResString(509088)) Then
                        PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                        If VLBandera Then
                            VTModo = False
                        End If
                        PMChequea(sqlconn)
                        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20 Then
                            cmdBoton(1).Enabled = True
                        End If
                        If VLTran = "282" And VLSP = "sp_qry_trnsrv_ah" And Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 20 Then
                            cmdBoton(1).Enabled = False
                        End If
                        grdRegistros.Col = 1
                        grdRegistros.Row = VLPosGrid
                        grdRegistros.Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionActiveCell
                        PMMarcaFilaGrid(grdRegistros, VLPosGrid)
                        PMBloqueaGrid(grdRegistros)
                        cmdBoton(4).Enabled = grdRegistros.MaxRows > 0
                        cmdBoton(7).Enabled = grdRegistros.MaxRows > 0
                        txtCampo(4).Text = StringsHelper.Format(grdRegistros.MaxRows, "#,###,###,##0")
                        Select Case VLVista
                            Case "2", "5", "6", "7", "9", "10", "11", "12", "13", "14", "15", "19"
                                txtCampo(5).Text = StringsHelper.Format(FLObtenerTotalMonto(2), VGDecimales)
                        End Select
                    Else
                        PMChequea(sqlconn)
                    End If
                End If
                If VLBandera And Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 20 And CDate(mskFecha.Text) <= CDate(mskfechahasta.Text) Then
                    VTModo = True
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                End If
                VLBandera = False
            Case 1
                txtCampo(4).Text = StringsHelper.Format(0, "#,###,###,##0")
                txtCampo(5).Text = StringsHelper.Format(0, VGDecimales)
                VTModo = True
                VLBandera = True
                grdRegistros.Col = grdRegistros.MaxCols
                grdRegistros.Row = grdRegistros.MaxRows
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTran)
                If txtCampo(0).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_ofi_desde", 0, SQLINT2, txtCampo(0).Text)
                End If
                If txtCampo(2).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_ofi_hasta", 0, SQLINT2, txtCampo(2).Text)
                End If
                If CDec(mskValor(0).Text.Trim()) > 0 Then
                    PMPasoValores(sqlconn, "@i_monto_desde", 0, SQLMONEY, mskValor(0).Text)
                End If
                If CDec(mskValor(1).Text.Trim()) > 0 Then
                    PMPasoValores(sqlconn, "@i_monto_hasta", 0, SQLMONEY, mskValor(1).Text)
                End If
                If txtCampo(3).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, txtCampo(3).Text)
                End If
                PMPasoValores(sqlconn, "@i_tipotrn", 0, SQLINT4, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_vista", 0, SQLINT2, VLVista)
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_alt", 0, SQLINT4, grdRegistros.Text)
                VTColumna = grdRegistros.MaxCols
                grdRegistros.Col = VTColumna - 1
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, grdRegistros.Text)
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", VLSP, True, FMLoadResString(509088)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                    PMChequea(sqlconn)
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20 Then
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Else
                        cmdBoton(1).Enabled = False
                    End If
                    txtCampo(4).Text = StringsHelper.Format(grdRegistros.MaxRows, "#,###,###,##0")
                    Select Case VLVista
                        Case "2", "5", "6", "7", "9", "10", "11", "12", "13", "14", "15", "19"
                            txtCampo(5).Text = StringsHelper.Format(FLObtenerTotalMonto(2), VGDecimales)
                    End Select
                Else
                    PMChequea(sqlconn)
                End If
            Case 2
                PLLimpiar()
            Case 3
                Me.Close()
            Case 4
                PLConfigurarImpresion()
            Case 7
                GeneraDatosExcel(grdRegistros)
        End Select
        PLTSEstado()
    End Sub

    Private Sub GeneraDatosExcel(ByVal grilla As COBISCorp.Framework.UI.Components.COBISSpread)
        Dim XlsApl As Excel.Application
        Dim xlsLibro As Excel.Workbook
        Dim xlhoja As Excel.Worksheet
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        If grdRegistros.Text <> "" Then
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = FMLoadResString(3865)
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = FMLoadResString(1106)
            For Fil As Integer = 0 To grilla.MaxRows
                grilla.Row = Fil
                For Col As Integer = 1 To grilla.MaxCols
                    grilla.Col = Col
                    xlsLibro.Worksheets(FMLoadResString(1106)).Cells(Fil + 1, Col).NumberFormat = "@"
                    xlsLibro.Worksheets(FMLoadResString(1106)).Cells(Fil + 1, Col).Value2 = grilla.Text.ToUpper().ToString()
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets(FMLoadResString(1106)).Rows("1:1", Type.Missing).Select()
                    XlsApl.Selection.Interior.ColorIndex = 37
                    XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
                    XlsApl.Selection.Font.Bold = True
                    XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
                    XlsApl.Cells.Select()
                    XlsApl.Range("E1").Activate()
                    XlsApl.Cells.EntireColumn.AutoFit()
                End If
            Next
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Else
            COBISMessageBox.Show(FMLoadResString(500879), FMLoadResString(500880), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Exit Sub
        End If

    End Sub

    Function PMComprobarFechasIF(ByVal inicio As Date, ByVal final As Date) As Boolean
        If (inicio > final) Then
            COBISMessageBox.Show(FMLoadResString(509170), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        Else
            Return True
        End If
    End Function

    Function PMComprobarFecha(ByVal fecha As String) As Boolean
        If (IsDate(fecha)) Then
            Return True
        Else
            COBISMessageBox.Show(FMLoadResString(509173), FMLoadResString(500267), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If
    End Function


    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaCte(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_val_inac", 0, SQLCHAR, "N")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(2))
                    Else
                        PMChequea(sqlconn)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(2).Text = ""
                    End If
                    PMChequea(sqlconn)
                Else
                    COBISMessageBox.Show(FMLoadResString(503358), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(2).Text = ""
                End If
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                lblDescripcion(2).Text = ""
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub mskfechahasta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskfechahasta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501860) & VGFormatoFecha & "]")
        mskfechahasta.SelectionStart = 0
        mskfechahasta.SelectionLength = Strings.Len(mskfechahasta.Text)
    End Sub

    Private Sub mskfechahasta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskfechahasta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskfechahasta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskfechahasta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If PMComprobarFecha(mskfechahasta.Text) = False Then
            mskfechahasta.Select()
            mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha)
            mskfechahasta.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        End If
        Dim VTDias As Integer = 0
        If mskfechahasta.ClipText <> "" Then
            VT = FMVerFormato(mskfechahasta.Text, VGFormatoFecha)
            If Not VT Then
                'Formato de Fecha Inválido
                COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskfechahasta.Focus()
                Exit Sub
            End If
        End If

        If mskFecha.ClipText <> "" And mskfechahasta.ClipText <> "" Then
            VTDias = FMDateDiff("d", mskFecha.Text, mskfechahasta.Text, VGFormatoFecha)
            If VTDias < 0 Then
                COBISMessageBox.Show(FMLoadResString(20000), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                mskfechahasta.Focus()
                Exit Sub
            End If
        End If
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501861) & VGFormatoFecha & "]")
        mskFecha.SelectionStart = 0
        mskFecha.SelectionLength = Strings.Len(mskFecha.Text)
    End Sub

    Private Sub mskFecha_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskFecha.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
        If PMComprobarFecha(mskFecha.Text) = False Then
            mskFecha.Select()
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
            mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If mskFecha.ClipText <> "" Then
            VT = FMVerFormato(mskFecha.Text, VGFormatoFecha)
            If Not VT Then
                'Formato de Fecha Inválido
                COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500356), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Focus()
                Exit Sub
            End If
        End If
    End Sub

    Private Sub PLLimpiar()
        mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        mskfechahasta.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        PMBorrarGrid(grdRegistros)
        txtCampo(0).Enabled = True
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        txtCampo(0).Focus()
        If cmdBoton(1).Enabled Then
            cmdBoton(1).Enabled = False
        End If
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        lblDescripcion(2).Text = ""
        lblDescripcion(3).Text = ""
        lblDescripcion(4).Text = ""
        mskValor(0).Text = VGDecimales
        mskValor(0).Text = StringsHelper.Format(0, VGDecimales)
        mskValor(1).Text = VGDecimales
        mskValor(1).Text = StringsHelper.Format(0, VGDecimales)
        txtCampo(4).Text = StringsHelper.Format(0, "#,###,###,##0")
        txtCampo(5).Text = StringsHelper.Format(0, VGDecimales)
        cmdBoton(4).Enabled = False
        cmdBoton(7).Enabled = False
        VLPosGrid = 1
        PLTSEstado()
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Enter, _mskValor_1.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500704))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500705))
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_0.KeyPress, _mskValor_1.KeyPress
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        If Asc(eventArgs.KeyChar) <> 46 And Asc(eventArgs.KeyChar) <> 8 And (Asc(eventArgs.KeyChar) < 48 Or Asc(eventArgs.KeyChar) > 57) Then
            eventArgs.KeyChar = Chr(0)
        End If
        If eventArgs.KeyChar = Chr(46) Then
            If mskValor(Index).Text.IndexOf("."c) + 1 Then
                eventArgs.KeyChar = Chr(0)
            End If
        End If
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Leave, _mskValor_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        If mskValor(Index).ClipText = "" Then
            mskValor(Index).Text = "0.00"
        End If
        If (Index = 1) Then
            If (CInt(mskValor(1).ClipText) < CInt(mskValor(0).ClipText)) Then
                COBISMessageBox.Show(FMLoadResString(9996), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskValor(0).Text = "0.00"
                mskValor(0).Focus()
            End If
        End If
        mskValor(Index).Text = StringsHelper.Format(mskValor(Index).ClipText, VGDecimales)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_4.TextChanged, _txtCampo_5.TextChanged, _txtCampo_3.TextChanged, _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                VLPaso = False
        End Select
        If Index = 0 Then lblDescripcion(0).Text = ""
        If Index = 2 Then lblDescripcion(3).Text = ""
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_4.Enter, _txtCampo_5.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500706))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500694))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500707))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500578))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_4.KeyDown, _txtCampo_5.KeyDown, _txtCampo_3.KeyDown, _txtCampo_1.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_oficina"
                    txtCampo(Index).Text = ""
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502502) & txtCampo(0).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                        If txtCampo(Index).Text <> "" Then
                            txtCampo(1).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(Index).Focus()
                    End If
                Case 1
                    VGOperacion = "sp_tranhistoricos"
                    txtCampo(Index).Text = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2576")
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, VGProducto)
                    PMPasoValores(sqlconn, "@i_qry", 0, SQLCHAR, "T")
                    PMPasoValores(sqlconn, "@i_tipotrn", 0, SQLINT4, "0")
                    PMPasoValores(sqlconn, "@i_tipohis", 0, SQLCHAR, VGTipoHis)
                    PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_qry_tranms", True, FMLoadResString(509062)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup()
                        FRegistros.cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag)) = VGMaxRows
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        If txtCampo(Index).Text <> "" Then
                            mskFecha.Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(Index).Focus()
                    End If
                Case 2
                    VGOperacion = "sp_oficina"
                    txtCampo(Index).Text = ""
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtCampo(2).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(Index).Text = VGACatalogo.Codigo
                        lblDescripcion(3).Text = VGACatalogo.Descripcion
                        If txtCampo(Index).Text <> "" Then
                            txtCampo(1).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(3).Text = ""
                        txtCampo(Index).Focus()
                    End If
                Case 3
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2467)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        VLPaso = True
                        FCatalogo.ShowPopup(Me)
                        txtCampo(3).Text = VGACatalogo.Codigo
                        lblDescripcion(4).Text = VGACatalogo.Descripcion
                        mskCuenta.Focus()
                    Else
                        PMChequea(sqlconn)
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_4.KeyPress, _txtCampo_5.KeyPress, _txtCampo_3.KeyPress, _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_4.Leave, _txtCampo_5.Leave, _txtCampo_3.Leave, _txtCampo_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso And txtCampo(Index).Text <> "" Then
            Select Case Index
                Case 0
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(0).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502502) & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCampo(0).Focus()
                            PMBorrarGrid(grdRegistros)
                        End If
                    End If
                Case 1
                    If txtCampo(1).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2576")
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, VGProducto)
                        PMPasoValores(sqlconn, "@i_qry", 0, SQLCHAR, "I")
                        PMPasoValores(sqlconn, "@i_tipohis", 0, SQLCHAR, VGTipoHis)
                        PMPasoValores(sqlconn, "@i_tipotrn", 0, SQLINT4, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_qry_tranms", True, FMLoadResString(509088)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                            mskFecha.Focus()
                        Else
                            PMChequea(sqlconn)
                            txtCampo(1).Text = ""
                            lblDescripcion(1).Text = ""
                            txtCampo(1).Focus()
                        End If
                    End If
                Case 2
                    If txtCampo(2).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(509088) & txtCampo(2).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(3))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(3).Text = ""
                            txtCampo(2).Focus()
                            PMBorrarGrid(grdRegistros)
                        End If
                    Else
                        lblDescripcion(3).Text = ""
                    End If
                Case 3
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(3).Text)
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2466)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(4))
                            PMChequea(sqlconn)
                            VLPaso = True
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(4).Text = ""
                            txtCampo(3).Focus()
                        End If
                    Else
                        lblDescripcion(4).Text = ""
                    End If
            End Select
        End If
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As Framework.UI.Components._DSpreadEvents_ClickEvent) Handles grdRegistros.ClickEvent
        PMMarcaFilaGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(sender As Object, e As EventArgs) Handles grdRegistros.DoubleClick
        PMMarcaFilaGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_LeaveCell(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components._DSpreadEvents_LeaveCellEvent) Handles grdRegistros.LeaveCell
        If eventArgs.NewRow > -1 Then
            PMMarcaFilaGrid(grdRegistros, eventArgs.NewRow)
            VLPosGrid = eventArgs.NewRow
        End If
    End Sub

    Sub PLConfigurarImpresion()
        Dim VTColumnas() As Integer
        Dim VTSepColumnas() As Integer
        Dim VTNumColumnas As Integer = 0
        Dim VTAlineacion() As Integer
        VLcompara = Conversion.Val(txtCampo(1).Text)
        Select Case VLcompara
            Case 201
                VLVista = "1"
                VTNumColumnas = 12
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13}
                VTSepColumnas = New Integer() {9, 7, 20, 9, 12, 7, 9, 8, 9, 5, 8, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_CENTER_ALIGN, CG_LEFT_ALIGN}
            Case 202, 205
                VLVista = "1"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 9, 10}
                VTSepColumnas = New Integer() {15, 12, 15, 12, 15, 12, 15, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 280
                VLVista = "2"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 8}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 203, 204, 267, 242
                VLVista = "3"
                VTNumColumnas = 6
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 9}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 206, 207
                VLVista = "4"
                VTNumColumnas = 7
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 9, 10}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 211, 212, 217, 218, 327, 328
                VLVista = "5"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 8, 12}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 213
                VLVista = "6"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 12, 13, 5, 9}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 224, 225, 226, 227
                VLVista = "7"
                VTNumColumnas = 9
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 8, 9}
                VTSepColumnas = New Integer() {12, 12, 12, 12, 12, 12, 12, 12, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 234
                VLVista = "8"
                VTNumColumnas = 6
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 8}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 249, 250, 256, 257, 264
                VLVista = "9"
                VTNumColumnas = 7
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 9}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 259
                VLVista = "10"
                VTNumColumnas = 7
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 9}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 268, 269
                VLVista = "11"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 7, 8, 9}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 401
                VLVista = "12"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 10}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 402, 416
                VLVista = "13"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 11}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 403, 404, 406
                VLVista = "14"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 11}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 271
                VLVista = "15"
                VTNumColumnas = 7
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 8}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 220
                VLVista = "17"
                VTNumColumnas = 9
                VTColumnas = New Integer() {1, 3, 4, 5, 6, 7, 8, 9, 10}
                VTSepColumnas = New Integer() {12, 12, 12, 12, 12, 12, 12, 12, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 230
                VLVista = "18"
                VTNumColumnas = 9
                VTColumnas = New Integer() {1, 3, 4, 5, 6, 7, 8, 9, 10}
                VTSepColumnas = New Integer() {12, 12, 12, 12, 12, 12, 12, 12, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 332
                VLVista = "19"
                VTNumColumnas = 7
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 8}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 367
                VLVista = "20"
                VTNumColumnas = 5
                VTColumnas = New Integer() {1, 2, 3, 4, 6}
                VTSepColumnas = New Integer() {15, 15, 15, 8, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case Else
                VLVista = "21"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 8}
                VTSepColumnas = New Integer() {12, 9, 27, 15, 15, 12, 12, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
        End Select
        Dim VTCapSubtitulos() As Integer = New Integer() {5122, 5123, 5005, 5084, 5179, 5180, 5176, 5016}
        Dim VTValSubtitulos() As String = New String() {"", "", "", "", "", "", "", "", "", "", "", ""}
        VTValSubtitulos(0) = FMLoadResString(5121).ToString
        VTValSubtitulos(1) = VGLogin
        If txtCampo(0).Text = "" And txtCampo(2).Text = "" Then
            VTValSubtitulos(2) = FMLoadResString(9037).ToString
        Else
            If txtCampo(0).Text = "" And txtCampo(2).Text <> "" Then
                VTValSubtitulos(2) = "1 Hasta " & txtCampo(2).Text & " " & lblDescripcion(3).Text
            Else
                If txtCampo(0).Text <> "" And txtCampo(2).Text = "" Then
                    VTValSubtitulos(2) = txtCampo(0).Text & " " & lblDescripcion(0).Text & FMLoadResString(503359)
                Else
                    If txtCampo(0).Text <> "" And txtCampo(2).Text <> "" Then
                        VTValSubtitulos(2) = txtCampo(0).Text & " " & lblDescripcion(0).Text & FMLoadResString(503360) & txtCampo(2).Text & " " & lblDescripcion(3).Text
                    End If
                End If
            End If
        End If
        If txtCampo(1).Text = "" Then
            VTValSubtitulos(3) = FMLoadResString(9037).ToString
        Else
            VTValSubtitulos(3) = txtCampo(1).Text & " " & lblDescripcion(1).Text
        End If
        VTValSubtitulos(4) = FMLoadResString(503362) & mskFecha.Text & FMLoadResString(503360) & mskfechahasta.Text
        If CDec(mskValor(0).Text.Trim()) = 0 And CDec(mskValor(1).Text.Trim()) = 0 Then
            VTValSubtitulos(5) = FMLoadResString(503361)
        Else
            If CDec(mskValor(0).Text.Trim()) > 0 And CDec(mskValor(1).Text.Trim()) = 0 Then
                VTValSubtitulos(5) = FMLoadResString(503362) & StringsHelper.Format(mskValor(0).Text, VGDecimales) & FMLoadResString(503358)
            Else
                VTValSubtitulos(5) = FMLoadResString(503362) & StringsHelper.Format(mskValor(0).Text, VGDecimales) & FMLoadResString(503360) & StringsHelper.Format(mskValor(1).Text, VGDecimales)
            End If
        End If
        If txtCampo(3).Text = "" Then
            VTValSubtitulos(6) = FMLoadResString(9037).ToString
        Else
            VTValSubtitulos(6) = txtCampo(3).Text & " " & lblDescripcion(4).Text
        End If
        If mskCuenta.ClipText = "" Then
            VTValSubtitulos(7) = FMLoadResString(9037).ToString()
        Else
            VTValSubtitulos(7) = mskCuenta.Text & " " & lblDescripcion(2).Text
        End If
        PMImprimirReporte(grdRegistros, VTNumColumnas, VTColumnas, VTSepColumnas, 3865, VTCapSubtitulos, VTValSubtitulos, VTAlineacion, CG_LANDSCAPE)
    End Sub

    Private Function FLObtenerTotalMonto(ByVal parCol As Integer) As Decimal
        Dim result As Decimal = 0
        If grdRegistros.MaxRows <= 0 Then
            result = 0
        Else
            For i As Integer = 1 To grdRegistros.MaxRows
                grdRegistros.Row = i
                grdRegistros.Col = parCol
                Dim dbNumericTemp As Double = 0
                If Double.TryParse(grdRegistros.Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                    result += CDec(grdRegistros.Text)
                End If
            Next i
        End If
        Return result
    End Function

    Private Sub PLTSEstado()
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBExcel.Enabled = _cmdBoton_7.Enabled
        TSBExcel.Visible = _cmdBoton_7.Visible
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        VGProducto = "AHO"
        VGTipoHis = "S"
    End Sub

    Private Sub GBRegistros_Enter(sender As Object, e As EventArgs) Handles GBRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500688))
    End Sub

    Private Sub GBRegistros_Leave(sender As Object, e As EventArgs) Handles GBRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub mskfechahasta_LostFocus(sender As Object, e As EventArgs) Handles mskfechahasta.LostFocus
        Dim VT As Integer
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        If mskfechahasta.ClipText <> "" Then
            VT = FMVerFormato((mskfechahasta.Text), VGFormatoFecha)
            If Not VT Then
                mskfechahasta.Focus()
                Exit Sub
            Else
                'Verficar que fecha de consulta sea menor que la fecha del sistema
                VTFecha1 = mskfechahasta.Text
                VTFecha2 = mskFecha.Text
                If FMDateDiff("d", VTFecha1, VTFecha2, VGFormatoFecha) > 0 Then
                    mskfechahasta.Text = mskFecha.Text
                    mskfechahasta.Focus()
                    Exit Sub
                End If
                If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    mskfechahasta.Text = VGFechaProceso
                End If
            End If
        End If
    End Sub

    Private Sub mskFecha_LostFocus(sender As Object, e As EventArgs) Handles mskFecha.LostFocus
        Dim VT As Integer
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        If mskFecha.ClipText <> "" Then
            VT = FMVerFormato((mskFecha.Text), VGFormatoFecha)
            If Not VT% Then
                mskFecha.Focus()
                Exit Sub
            Else
                'Verficar que fecha de consulta sea menor que la fecha del sistema
                VTFecha1 = mskFecha.Text
                VTFecha2 = mskfechahasta.Text
                If FMDateDiff("d", VTFecha1, VTFecha2, VGFormatoFecha) <= 0 Then
                    mskFecha.Text = mskfechahasta.Text
                End If
                If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    mskFecha.Text = mskfechahasta.Text
                End If
            End If
        End If
    End Sub

    Private Sub TSBExcel_Click(sender As Object, e As EventArgs) Handles TSBExcel.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub
End Class


