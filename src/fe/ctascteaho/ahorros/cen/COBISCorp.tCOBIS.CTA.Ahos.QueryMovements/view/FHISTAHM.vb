Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FHistoricoAMClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLcompara As Integer = 0
    Dim VLVista As String = "1"
    Dim VLTabla As String = ""
    Dim VLBandera As Boolean = False
    Dim VTModo As Integer = 0


    Private Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaAho
        mskFecha.DateType = PLFormatoFecha()
        mskfechahasta.DateType = PLFormatoFecha()
        mskFecha.Text = VGFechaProceso
        mskfechahasta.Text = VGFechaProceso
        cmdBoton(7).Enabled = False
    End Sub

    Private Sub FHistoricoAM_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub FHistoricoAM_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VLPosGrid As Integer = 0
        TSBotones.Focus()
        Select Case Index
            Case 0
                If Not VLBandera Then
                    VTModo = False
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500691), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(1).Enabled Then txtCampo(1).Focus()
                    Exit Sub
                ElseIf mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(500387), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If mskFecha.Enabled Then mskFecha.Focus()
                    Exit Sub
                ElseIf mskfechahasta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(500388), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If mskfechahasta.Enabled Then mskfechahasta.Focus()
                    Exit Sub
                Else
                    VLcompara = Conversion.Val(txtCampo(1).Text)
                    If mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha) And (mskFecha.Text) = (mskfechahasta.Text) Or VLBandera Then
                        VLBandera = False
                        VLTabla = "S"
                    ElseIf CDate(mskFecha.Text) <= CDate(mskfechahasta.Text) Then
                        VLBandera = True
                        VLTabla = "N"
                    Else
                        VLBandera = True
                        mskfechahasta.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                        VLTabla = "N"
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "281")
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(0).Text)
                    End If
                    PMPasoValores(sqlconn, "@i_tipotrn", 0, SQLINT4, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                    PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    PMPasoValores(sqlconn, "@i_vista", 0, SQLINT2, VLVista)
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "-1000000000")
                    PMPasoValores(sqlconn, "@i_alt", 0, SQLINT4, "0")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_prodbanc", 0, SQLINT2, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_qry_histm_ah", True, FMLoadResString(20001)) Then
                        PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                        If VLBandera Then
                            VTModo = False
                        End If
                        PMChequea(sqlconn)
                        If grdRegistros.MaxRows > 0 Then
                            PMAnchoColumnasGrid(grdRegistros, 25)
                        End If
                        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20 Then
                            cmdBoton(1).Enabled = True
                        End If
                        If VLTabla = "S" And Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 20 Then
                            cmdBoton(1).Enabled = False
                        End If
                        grdRegistros.Col = 1

                        grdRegistros.Col = 1
                        grdRegistros.Row = VLPosGrid
                        grdRegistros.Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionActiveCell
                        PMMarcaFilaGrid(grdRegistros, VLPosGrid)
                        PMBloqueaGrid(grdRegistros)
                        cmdBoton(4).Enabled = grdRegistros.MaxRows > 0
                        cmdBoton(7).Enabled = grdRegistros.MaxRows > 0 'Excel
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar()
                    End If
                End If
                If VLBandera And Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 20 Then
                    VTModo = True
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                End If
                VLBandera = False
            Case 1
                VLBandera = True
                VTModo = True
                grdRegistros.Col = grdRegistros.MaxCols - 1
                grdRegistros.Row = grdRegistros.MaxRows
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "281")
                If txtCampo(0).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(0).Text)
                End If
                PMPasoValores(sqlconn, "@i_tipotrn", 0, SQLINT4, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_vista", 0, SQLINT2, VLVista)
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, CStr(Conversion.Val(grdRegistros.Text)))
                If VLTabla = "S" Then
                    PMPasoValores(sqlconn, "@i_alt", 0, SQLINT4, grdRegistros.Text)
                End If
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_prodbanc", 0, SQLINT2, txtCampo(2).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_qry_histm_ah", True, FMLoadResString(20001)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                    PMChequea(sqlconn)
                    PMAjustaColsGrid(grdRegistros)
                    PMAnchoColumnasGrid(grdRegistros, 25)
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20 Then
                        cmdBoton(1).Enabled = True
                    End If
                    'If VLTabla = "S" And Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 20 Then
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) < 20 Then
                        cmdBoton(1).Enabled = False
                    End If
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

    Private Sub GeneraDatosExcel(ByRef grilla As COBISCorp.Framework.UI.Components.COBISSpread)
        Dim XlsApl As Excel.Application
        Dim xlsLibro As Excel.Workbook
        Dim xlhoja As Excel.Worksheet
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        If grdRegistros.Text <> "" Then
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = FMLoadResString(3873)
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = FMLoadResString(1105)
            For Fil As Integer = 0 To grilla.MaxRows
                grilla.Row = Fil
                For Col As Integer = 1 To grilla.MaxCols
                    grilla.Col = Col
                    xlsLibro.Worksheets(FMLoadResString(1105)).Cells(Fil + 1, Col).NumberFormat = "@"
                    xlsLibro.Worksheets(FMLoadResString(1105)).Cells(Fil + 1, Col).Value2 = grilla.Text.ToUpper().ToString()
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets(FMLoadResString(1105)).Rows("1:1", Type.Missing).Select()
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2544) & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(3))
                    Else
                        PMChequea(sqlconn)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(3).Text = ""
                    End If
                    PMChequea(sqlconn)
                Else
                    COBISMessageBox.Show(FMLoadResString(500509), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(3).Text = ""
                End If
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                lblDescripcion(3).Text = ""
            End If
            PMBorrarGrid(Me.grdRegistros)
        Catch exc As System.Exception
            'NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
            COBISMessageBox.Show(exc.ToString)
        End Try
        PLTSEstado()
    End Sub

    Private Sub mskfechahasta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskfechahasta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2319) & VGFormatoFecha & "]")
        mskfechahasta.SelectionStart = 0
        mskfechahasta.SelectionLength = Strings.Len(mskfechahasta.Text)
    End Sub

    Private Sub mskfechahasta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskfechahasta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFecha_EnabledChanged(sender As Object, e As EventArgs) Handles mskFecha.EnabledChanged

    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2318) & VGFormatoFecha & "]")
        mskFecha.SelectionStart = 0
        mskFecha.SelectionLength = Strings.Len(mskFecha.Text)

    End Sub

    Private Sub mskFecha_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskFecha.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Sub PLConfigurarImpresion()
        Dim VTColumnas() As Integer
        Dim VTSepColumnas() As Integer
        Dim VTNumColumnas As Integer = 0
        Dim VTAlineacion() As Integer
        VLcompara = Conversion.Val(txtCampo(1).Text)
        Select Case VLcompara
            Case 261, 263
                VLVista = "1"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 9, 10}
                VTSepColumnas = New Integer() {15, 12, 15, 12, 15, 12, 15, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 251, 252, 254
                VLVista = "2"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 9, 10}
                VTSepColumnas = New Integer() {15, 12, 15, 12, 15, 12, 15, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 221, 255, 253, 257, 262, 264, 265, 266
                VLVista = "3"
                VTNumColumnas = 10
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 8, 10, 12, 13}
                VTSepColumnas = New Integer() {15, 8, 12, 12, 8, 10, 10, 6, 10, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 215
                VLVista = "4"
                VTNumColumnas = 5
                VTColumnas = New Integer() {1, 2, 3, 4, 5}
                VTSepColumnas = New Integer() {15, 12, 15, 12, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 213
                VLVista = "5"
                VTNumColumnas = 9
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 12, 13}
                VTSepColumnas = New Integer() {15, 12, 10, 12, 25, 12, 12, 12, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 237, 239
                VLVista = "6"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 9, 10}
                VTSepColumnas = New Integer() {15, 12, 15, 12, 15, 12, 15, 12}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case 309, 309
                VLVista = "7"
                VTNumColumnas = 6
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6}
                VTSepColumnas = New Integer() {15, 15, 6, 15, 12, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
            Case Else
                VLVista = "8"
                VTNumColumnas = 8
                VTColumnas = New Integer() {1, 2, 3, 4, 5, 6, 7, 8}
                VTSepColumnas = New Integer() {15, 15, 15, 15, 15, 15, 15, 15}
                VTAlineacion = New Integer() {CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN, CG_LEFT_ALIGN}
        End Select
        Dim VTCapSubtitulos() As Integer = New Integer() {5122, 5123, 501874, 5005, 5084, 5065, 5066}
        Dim VTValSubtitulos() As String = New String() {"", "", "", "", "", "", "", ""}
        VTValSubtitulos(0) = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str5121").ToString()
        VTValSubtitulos(1) = "  " & VGLogin
        If mskCuenta.ClipText = "" Then
            VTValSubtitulos(2) = "  " & COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str9037").ToString()
        Else
            VTValSubtitulos(2) = "  " & mskCuenta.Text
        End If
        If txtCampo(0).Text = "" Then
            VTValSubtitulos(3) = "  " & COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str9037").ToString()
        Else
            VTValSubtitulos(3) = "  " & txtCampo(0).Text
        End If
        If txtCampo(1).Text = "" Then
            VTValSubtitulos(4) = "  " & COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str9037").ToString()
        Else
            VTValSubtitulos(4) = "  " & txtCampo(1).Text & " " & lblDescripcion(1).Text
        End If
        VTValSubtitulos(5) = mskFecha.Text
        VTValSubtitulos(6) = mskfechahasta.Text
        PMImprimirReporte1(grdRegistros, VTNumColumnas, VTColumnas, VTSepColumnas, 3873, VTCapSubtitulos, VTValSubtitulos, VTAlineacion, CG_LANDSCAPE)
    End Sub

    Private Sub PLLimpiar()
        mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        mskfechahasta.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        lblDescripcion(3).Text = ""
        PMBorrarGrid(Me.grdRegistros)
        txtCampo(0).Enabled = True
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(0).Focus()
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        cmdBoton(7).Enabled = False
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500376))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500694))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2317))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_agencia"
                    txtCampo(Index).Text = ""
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(502501) & "[" & txtCampo(0).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(Index).Text = VGACatalogo.Codigo
                        lblDescripcion(Index).Text = VGACatalogo.Descripcion
                        If txtCampo(Index).Text <> "" Then
                            txtCampo(1).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_qry_tranms", True, FMLoadResString(502520)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup()
                        FRegistros.cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag)) = VGMaxRows
                        txtCampo(Index).Text = VGACatalogo.Codigo
                        lblDescripcion(Index).Text = VGACatalogo.Descripcion
                        If txtCampo(Index).Text <> "" Then
                            mskFecha.Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
                        txtCampo(Index).Focus()
                    End If
                Case 2
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(502869)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(2).Text = VGACatalogo.Codigo
                        lblDescripcion(2).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(2).Text = ""
                        lblDescripcion(2).Text = ""
                        txtCampo(2).Focus()
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If txtCampo(Index).Text = "" Then
            lblDescripcion(Index).Text = ""
        End If
        If Not VLPaso And txtCampo(Index).Text <> "" Then
            Select Case Index
                Case 0
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                        PMPasoValores(sqlconn, "@i_sig", 0, SQLINT2, "1")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(502501) & "[" & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCampo(0).Focus()
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
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_qry_tranms", True, FMLoadResString(502520)) Then
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
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2541)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(2).Focus()
                        End If
                    End If
            End Select
            PMBorrarGrid(Me.grdRegistros)
        End If
    End Sub

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
        VGTipoHis = "M"
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As Framework.UI.Components._DSpreadEvents_ClickEvent) Handles grdRegistros.ClickEvent
        PMMarcaFilaGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DblClick(sender As Object, e As Framework.UI.Components._DSpreadEvents_DblClickEvent) Handles grdRegistros.DblClick
        PMMarcaFilaGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500688))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub mskFecha_LostFocus(sender As Object, e As EventArgs) Handles mskFecha.LostFocus
        Dim VT As Integer
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        If mskFecha.ClipText <> "" Then
            VT = FMVerFormato((mskFecha.Text), VGFormatoFecha)
            If Not VT% Then
                COBISMessageBox.Show(FMLoadResString(500063), 48, FMLoadResString(500064))
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

    Private Sub mskfechahasta_LostFocus(sender As Object, e As EventArgs) Handles mskfechahasta.LostFocus
        Dim VT As Integer
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        If mskfechahasta.ClipText <> "" Then
            VT = FMVerFormato((mskfechahasta.Text), VGFormatoFecha)
            If Not VT Then
                COBISMessageBox.Show(FMLoadResString(500063), 48, FMLoadResString(500064))
                mskfechahasta.Focus()
                Exit Sub
            Else
                'Verficar que fecha de consulta sea menor que la fecha del sistema
                VTFecha1 = mskfechahasta.Text
                VTFecha2 = mskFecha.Text
                If FMDateDiff("d", VTFecha1, VTFecha2, VGFormatoFecha) > 0 Then
                    mskfechahasta.Text = mskFecha.Text
                End If
                If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    mskfechahasta.Text = VGFechaProceso
                End If
            End If
        End If
    End Sub

    Private Sub mskFecha_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles mskFecha.MaskInputRejected

    End Sub

    Private Sub mskfechahasta_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles mskfechahasta.MaskInputRejected

    End Sub

    Private Sub TSBExcel_Click(sender As Object, e As EventArgs) Handles TSBExcel.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub
End Class


