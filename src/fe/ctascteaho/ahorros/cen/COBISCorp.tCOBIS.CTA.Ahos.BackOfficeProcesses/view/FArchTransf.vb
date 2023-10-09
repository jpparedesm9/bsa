Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.Query
Partial Public Class FArchTransfClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLCodArch As Integer = 0
    Dim VLPaso As Integer = 0
    Dim VLExisteCliente As Boolean = False
    Dim VLTipoId As String = ""
    Dim VLIdentificacion As String = ""
    Dim VLFormatoFecha As String = ""
    Dim VLSecuencial As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                PLBuscar()
                Me.Cursor = System.Windows.Forms.Cursors.Default
            Case 1
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                PLExcel()
                Me.Cursor = System.Windows.Forms.Cursors.Default
            Case 2
                PLLimpiar()
            Case 3
                Me.Close()
        End Select
    End Sub

    Private Sub PLExcel()
        grdDetalle.Row = 1
        grdDetalle.Col = 1
        If grdDetalle.CtlText <> "" Then
            GeneraDatos_Excel(txtCampo(1).Text)
        Else
            COBISMessageBox.Show(FMLoadResString(502290), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub PLInicializar()
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        MskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        MskFecha.DateType = PLFormatoFecha()
        MskFecha.Connection = VGMap
        MskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        PLLimpiar()
        VLExisteCliente = False
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBExcel.Enabled = _cmdBoton_1.Enabled
        TSBExcel.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub FArchTransf_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        MyAppGlobals.AppActiveForm = ""
        PLInicializar()
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCliente_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCliente.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCliente_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCliente.Enter
        If StringsHelper.ToDoubleSafe(VGCliente) <> 0 Then txtCliente.Text = VGCliente
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508514))
        txtCliente.SelectionStart = 0
        txtCliente.SelectionLength = Strings.Len(txtCliente.Text)
    End Sub

    Private Sub txtCliente_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCliente.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode       
        Dim F5 As Integer = 0
        Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
        Dim FDatoCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
        If Keycode <> F5 And Keycode <> 116 Then
            Exit Sub
        End If
        txtCliente.Text = ""
        If VGFBusCliente Is Nothing Then
            FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
            FDatoCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
        End If

        FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
        FDatoCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
        FBuscarCliente.optCliente(1).Enabled = True
        FBuscarCliente.optCliente(0).Checked = True
        FBuscarCliente.ShowPopup(Me)
        FBuscarCliente.optCliente(1).Enabled = True
        VGBusqueda = FDatoCliente.PMRetornaCliente()
        If VGBusqueda(1) <> "" Then
            VGCliente = CDbl(VGBusqueda(1))
            txtCliente.Text = VGBusqueda(1)
            If VGBusqueda(0) = "P" Then
                lblDescripcion(1).Text = VGBusqueda(6)
                lblDescripcion(2).Text = VGBusqueda(5)
                lblDescripcion(3).Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
            Else
                lblDescripcion(1).Text = VGBusqueda(4)
                lblDescripcion(2).Text = VGBusqueda(3)
                lblDescripcion(3).Text = VGBusqueda(2)
                If VGBusqueda(4) = "N" Then lblDescripcion(1).Text = "NI"
            End If
            VLPaso = True
            'txtCliente.Focus()
        End If

        PMChequea(sqlconn)
    End Sub

    Private Sub txtCliente_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCliente.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCliente_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCliente.Leave
        Dim VTFecha As String = String.Empty
        If Not VLPaso Then
            VGCliente = CStr(0)
            If txtCliente.Text <> "" Then
                VTFecha = FMConvFecha(MskFecha.Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "E")
                PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCliente.Text)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "702")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_alianza", True, FMLoadResString(2239) & txtCliente.Text & "]") Then
                    Dim VTValores(3) As String
                    FMMapeaArreglo(sqlconn, VTValores)
                    PMChequea(sqlconn)
                    lblDescripcion(1).Text = VTValores(2).Trim()
                    lblDescripcion(2).Text = VTValores(1).Trim()
                    lblDescripcion(3).Text = VTValores(3).Trim()
                    VLExisteCliente = True
                Else
                    PMChequea(sqlconn)
                    VLExisteCliente = False
                    txtCliente.Text = ""
                    lblDescripcion(1).Text = ""
                    lblDescripcion(2).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCliente.Focus()
                    PLLimpiar()
                End If
                VLPaso = True
            Else
                If Not (VGFBusCliente Is Nothing) Then
                    lblDescripcion(1).Text = VGBusqueda(0)
                    lblDescripcion(2).Text = VGBusqueda(3)
                    lblDescripcion(3).Text = VGBusqueda(2)
                    PLLimpiar()
                End If
            End If
        End If
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500415))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508434))
        End Select
        VLPaso = True
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 1
                    If lblDescripcion(1).Text <> "" And lblDescripcion(2).Text <> "" Then
                        ReDim VGADatosO(3)
                        FBusArchAlianza.txtCliente.Text = lblDescripcion(2).Text
                        FBusArchAlianza.txtTipoId.Text = lblDescripcion(1).Text
                        FBusArchAlianza.lblFecha.Text = MskFecha.Text
                        FBusArchAlianza.VLExisteCliente = VLExisteCliente
                        FBusArchAlianza.ShowPopup(Me)
                        If VGADatosO(0).Trim() <> "" Then
                            VLCodArch = CInt(VGADatosO(0))
                            txtCampo(1).Text = VGADatosO(1)
                            VLTipoId = VGADatosO(2)
                            VLIdentificacion = VGADatosO(3)
                        End If
                        Me.Dispose()
                        VLPaso = True
                    Else
                        COBISMessageBox.Show(FMLoadResString(500728), FMLoadResString(508471), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                        txtCliente.Focus()
                    End If
            End Select
        Else
            COBISMessageBox.Show(FMLoadResString(508434), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If ((KeyAscii < 48) Or (KeyAscii > 57)) And KeyAscii <> 8 Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLBuscar()
        If txtCampo(1).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508518), FMLoadResString(508471), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtCampo(1).Focus()
            Exit Sub
        End If
        Dim VTFecha As String = FMConvFecha(MskFecha.Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
        PMPasoValores(sqlconn, "@i_codigo_arch", 0, SQLINT4, CStr(VLCodArch))
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "702")
        PMPasoValores(sqlconn, "@i_identificacion", 0, SQLCHAR, VLIdentificacion)
        PMPasoValores(sqlconn, "@i_tipo_ident", 0, SQLCHAR, VLTipoId)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_alianza", True, FMLoadResString(2239) & txtCliente.Text & "]") Then
            Dim VTValores(15) As String
            FMMapeaArreglo(sqlconn, VTValores)
            PMChequea(sqlconn)
            lblValor(0).Text = VTValores(1)
            lblValor(1).Text = VTValores(2)
            lblValor(3).Text = VTValores(3)
            lblValor(2).Text = VTValores(4)
            lblValor(5).Text = VTValores(5)
            lblValor(4).Text = VTValores(6)
            lblValor(7).Text = VTValores(7)
            lblValor(8).Text = VTValores(8)
            lblValor(6).Text = VTValores(9)
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(508552), FMLoadResString(508549), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
        PLCargarDetalle()
    End Sub

    Private Sub PLCargarDetalle()
        Dim VTFecha As String = FMConvFecha(MskFecha.Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCliente.Text)
        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
        PMPasoValores(sqlconn, "@i_codigo_arch", 0, SQLINT4, CStr(VLCodArch))
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "702")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_alianza", True, FMLoadResString(2239) & txtCliente.Text & "]") Then
            PMMapeaGrid(sqlconn, grdDetalle, False)
            PMMapeaTextoGrid(grdDetalle)
            PMChequea(sqlconn)
            grdDetalle.ColWidth(1) = 855
            grdDetalle.ColWidth(2) = 885
            grdDetalle.ColWidth(3) = 1080
            grdDetalle.ColWidth(4) = 1000
            grdDetalle.ColWidth(5) = 1200
            grdDetalle.ColWidth(6) = 3000
            cmdBoton(1).Enabled = True
            If CDbl(Convert.ToString(grdDetalle.Tag)) = 20 Then
                PLSiguientes()
            End If
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(508552), FMLoadResString(508549), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub PLSiguientes()
        grdDetalle.Row = grdDetalle.Rows - 1
        grdDetalle.Col = 1
        VLSecuencial = grdDetalle.CtlText
        Dim VTFecha As String = FMConvFecha(MskFecha.Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
        PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCliente.Text)
        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
        PMPasoValores(sqlconn, "@i_codigo_arch", 0, SQLINT4, CStr(VLCodArch))
        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VLSecuencial)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "702")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_alianza", True, FMLoadResString(2239) & txtCliente.Text & "]") Then
            PMMapeaGrid(sqlconn, grdDetalle, True)
            PMMapeaTextoGrid(grdDetalle)
            PMChequea(sqlconn)
            If CDbl(Convert.ToString(grdDetalle.Tag)) = 20 Then
                PLSiguientes()
            End If
            grdDetalle.ColWidth(1) = 855
            grdDetalle.ColWidth(2) = 885
            grdDetalle.ColWidth(3) = 1080
            grdDetalle.ColWidth(4) = 1000
            grdDetalle.ColWidth(5) = 1200
            grdDetalle.ColWidth(6) = 3000
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(508552), FMLoadResString(508549), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub PLLimpiar()
        txtCliente.Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        lblDescripcion(3).Text = ""
        txtCampo(1).Text = ""
        lblValor(0).Text = ""
        lblValor(1).Text = ""
        lblValor(3).Text = ""
        lblValor(2).Text = ""
        lblValor(5).Text = ""
        lblValor(4).Text = ""
        lblValor(7).Text = ""
        lblValor(6).Text = ""
        lblValor(8).Text = ""
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        MskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        MskFecha.DateType = PLFormatoFecha()
        MskFecha.Connection = VGMap
        MskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        PMLimpiaGrid(grdDetalle)
        grdDetalle.ColWidth(1) = 650
        cmdBoton(1).Enabled = False
    End Sub

    Sub GeneraDatos_Excel(ByRef svArchivo As String)
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            Dim valor As String = ""
            XlsApl = New Excel.Application()
            XlsApl.Caption = "PROCESAMIENTO ARCHIVO ALIANZAS " & svArchivo
            XlsApl.WindowState = Excel.XlWindowState.xlMinimized
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = svArchivo
            xlsLibro.Worksheets(svArchivo).Columns("D:D", Type.Missing).Select()
            XlsApl.Selection.NumberFormat = "####00-000-00000-0"
            xlsLibro.Worksheets(svArchivo).Activate(Me)
            XlsApl.Columns("A:A", Type.Missing).Select()
            XlsApl.Selection.NumberFormat = "@"
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508564) & " [" & svArchivo & "] ...")
            Fil = 1
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "NOMBRE REPORTE:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "CONSULTA ARCHIVO TRANSFERENCIA"
            Fil = 2
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "NOMBRE ARCHIVO:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = svArchivo
            Fil = 3
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "FECHA:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = MskFecha.Text
            Fil = 4
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "VALOR INICIAL TRANSFERENCIA:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = lblValor(0).Text
            Fil = 5
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "CONCEPTO:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = lblValor(6).Text
            Fil = 7
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "TOTAL REGISTROS:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = lblValor(1).Text
            Fil = 8
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "TOTAL PROCESADOS:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = lblValor(2).Text
            Fil = 9
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "VALOR PROCESADOS:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = lblValor(3).Text
            Fil = 10
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "TOTAL NO PROCESADOS:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = lblValor(4).Text
            Fil = 11
            col = 1
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = "VALOR NO PROCESADOS:"
            col = 2
            xlsLibro.Worksheets(svArchivo).Cells(Fil, col).Value2 = lblValor(5).Text
            col = 1
            For fila As Integer = 0 To grdDetalle.Rows - 1
                Fil += 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500274) & fila & "] de " & CStr(grdDetalle.Rows - 1) & " ...")
                grdDetalle.Row = fila
                col = 0
                For columna As Integer = 1 To grdDetalle.Cols - 1
                    col += 1
                    grdDetalle.Col = columna
                    valor = grdDetalle.CtlText
                    If FMConvFecha(valor, VGFecha_Pref, CGFORMATOFECHA) <> "" Then
                        xlsLibro.Worksheets(svArchivo).Cells(Fil + 1, col).Value2 = "'" & grdDetalle.CtlText
                    Else
                        xlsLibro.Worksheets(svArchivo).Cells(Fil + 1, col).Value2 = grdDetalle.CtlText
                    End If
                Next
            Next
            XlsApl.Visible = True
            XlsApl.WindowState = Excel.XlWindowState.xlMaximized
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Catch excep As System.Exception
            COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End Try
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508601) & "[" & VGFormatoFecha & "]")
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MskFecha.Leave
        Dim VTValido As Integer = 0
        Dim VTDias As Integer = 0
        Dim VLFecha As String = ""
        VLFecha = VGFechaProceso
        If mskFecha.ClipText <> "" Then
            VTValido = FMVerFormato(mskFecha.Text, VGFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(509173), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Mask = ""
                mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
                mskFecha.Focus()
                Exit Sub
            End If
        Else
            If MskFecha.Text <> FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha) Then
                VTDias = FMDateDiff("d", MskFecha.Text, FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha), VGFormatoFecha)
                If VTDias < 0 Then
                    COBISMessageBox.Show(FMLoadResString(9999), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    MskFecha.Mask = ""
                    MskFecha.Text = ""
                    MskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                    MskFecha.DateType = PLFormatoFecha()
                    MskFecha.Connection = VGMap
                    MskFecha.Focus()
                    MskFecha.Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                    Exit Sub
                End If
                If MskFecha.ClipText = "" Then
                    MskFecha.Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                End If
            End If
        End If
    End Sub

    Private Sub ToolStripButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBEXCEL_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBExcel.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub grdDetalle_ClickEvent(sender As Object, e As EventArgs) Handles grdDetalle.ClickEvent
        PMMarcaFilaCobisGrid(grdDetalle, grdDetalle.Row)
    End Sub
End Class


