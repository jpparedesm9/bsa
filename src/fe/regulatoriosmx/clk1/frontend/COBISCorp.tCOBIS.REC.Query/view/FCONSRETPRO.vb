Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.REC.SharedLibrary

Partial Public Class FCONSRETPROClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Const F5 As Integer = 116
    Dim VLProdbanc As String = ""
    Dim VLCategoria As String = ""
    Dim VLTipoEnte As String = ""
    Dim VLNumDoc As String = ""
    Dim VLTitularidad As String = ""
    Dim VLTipoTran As String = ""
    Dim VLProdBancBloq As String = ""
    Dim VLCliente As String = ""
    Dim VTFila As Integer = 0
    Dim VTR1 As Integer = 0
    Dim VLPaso As Boolean = False
    Dim VLPaso2 As Boolean = False
    Public VLArgument As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                TSBotones.Focus()
                If VLPaso = True Then
                    VLPaso = False
                    Exit Sub
                End If
                PLBuscar(False)
            Case 2
                PLLimpiar()
            Case 4
                VLPaso2 = True
                Me.Close()
            Case 5
                GeneraDatosGrid_Excel(grdResultado, FMLoadResString(600036))
        End Select
    End Sub

    Private Sub FTranCME_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        VLArgument = Me.GetPageArgumentsByName("OP")
        mskFechaDesde.DateType = PLFormatoFecha()
        mskFechaHasta.DateType = PLFormatoFecha()
        mskFechaDesde.Text = VGFechaProceso
        mskFechaHasta.Text = VGFechaProceso
        cmdBoton(5).Enabled = False
    End Sub

    Private Sub grdResultado_ClickEvent(sender As Object, e As EventArgs) Handles grdResultado.ClickEvent
        PMMarcaFilaCobisGrid(grdResultado, grdResultado.Row)
    End Sub

    Private Sub txtCliente_Change(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCliente.Change
        PMLimpiaG(grdResultado)
    End Sub

    Private Sub txtCliente_Enter(sender As Object, e As EventArgs) Handles txtCliente.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500415))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub txtCliente_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles txtCliente.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        Dim VLFormatoFecha As String = ""
        Dim VLPaso As Integer = 0
        If Keycode <> F5 Then
            Exit Sub
        End If
        txtCliente.Text = ""
        'DLL CLIENTES
        VGFBusCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
        Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
        VGFBusCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
        FBuscarCliente.optCliente(1).Enabled = True
        FBuscarCliente.optCliente(0).Checked = True
        FBuscarCliente.ShowPopup(Me)
        FBuscarCliente.optCliente(1).Enabled = True
        VGBusqueda = VGFBusCliente.PMRetornaCliente()
        If Not (VGBusqueda Is Nothing) Then
            If ("").Equals(VGBusqueda(1)) Then
                txtCliente.Text = ""
            Else
                txtCliente.Text = VGBusqueda(1)
                lblCliente.Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
            End If
        End If
        PMChequea(sqlconn)
    End Sub

    Private Sub PLBuscar(ByRef VTAnadir As Integer)
        If txtProducto.Text <> "" Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, txtProducto.Text)
        End If
        If txtCliente.Text <> "" Then
            PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, txtCliente.Text)
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "36003")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha(mskFechaDesde.Text, VGFormatoFecha, CGFormatoBase))
        PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskFechaHasta.Text, VGFormatoFecha, CGFormatoBase))
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta_super", "sp_tran_prod_isr", True, "") Then
            PMMapeaGrid(sqlconn, grdResultado, VTAnadir)
            PMMapeaTextoGrid(grdResultado)
            PMAnchoColumnasGrid(grdResultado)
            PMChequea(sqlconn)
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(600035))
            cmdBoton(5).Enabled = True
        Else
            PMLimpiaG(grdResultado)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = False
        End If
        grdResultado.Row = 1
        VLPaso = False
        VLPaso2 = False
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        txtCliente.Text = ""
        lblCliente.Text = ""
        txtProducto.Text = ""
        lblAplicativo.Text = ""
        mskFechaDesde.DateType = PLFormatoFecha()
        mskFechaHasta.DateType = PLFormatoFecha()
        mskFechaDesde.Text = VGFechaProceso
        mskFechaHasta.Text = VGFechaProceso
        PMLimpiaG(grdResultado)
        cmdBoton(5).Enabled = False
        mskFechaDesde.Focus()
        VLPaso = False
        VLPaso2 = False
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
        TSBExcel.Enabled = _cmdBoton_5.Enabled
        TSBExcel.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBExcel.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub txtProducto_Enter(sender As Object, e As EventArgs) Handles txtProducto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502800))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub txtProducto_KeyDown(sender As Object, e As KeyEventArgs) Handles txtProducto.KeyDown
        Dim KeyCode As Integer = e.KeyCode
        If KeyCode <> VGTeclaAyuda Then
            Exit Sub
        End If
        If KeyCode = VGTeclaAyuda Then
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "sb_aplicativo_isr")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502992)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtProducto.Text = VGACatalogo.Codigo
                lblAplicativo.Text = VGACatalogo.Descripcion
                If txtProducto.Text <> "" Then
                    txtProducto.Focus()
                End If
                FCatalogo.Dispose()
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub PLBuscarProducto()
        If txtProducto.Text <> "" And VLPaso2 = False Then
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "sb_aplicativo_isr")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtProducto.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(600037) & txtProducto.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblAplicativo)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                txtProducto.Text = ""
                lblAplicativo.Text = ""
                txtProducto.Focus()
                VLPaso = True
            End If
        Else
            lblAplicativo.Text = ""
            VLPaso = False
        End If
    End Sub

    Private Sub txtCliente_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtCliente.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 48 Or KeyAscii > 58) And (KeyAscii <> 37) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
        lblCliente.Text = ""
    End Sub

    Private Sub txtCliente_Leave(sender As Object, e As EventArgs) Handles txtCliente.Leave
        PLBuscarCliente()
    End Sub

    Private Sub PLBuscarCliente()
        Dim VTValores(15) As String
        Dim VTSubtipo As String = String.Empty
        Dim VTCliente As String = String.Empty

        If txtCliente.Text <> "" And VLPaso2 = False Then
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
            PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCliente.Text)
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1181")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente", True, FMLoadResString(2536) & " " & "[" & txtCliente.Text & "]") Then
                FMMapeaArreglo(sqlconn, VTValores)
                PMLimpiaGrid(grdResultado)
                PMChequea(sqlconn)
                VTSubtipo = VTValores(3)
                lblCliente.Text = VTValores(2)
                If txtCliente.Text = "" Then
                    txtCliente.Focus()
                Else
                    cmdBoton(0).Focus()
                End If
            Else
                PMChequea(sqlconn)
                txtCliente.Text = ""
                lblCliente.Text = ""
                txtCliente.Focus()
                VLPaso = True
            End If
        Else
            lblCliente.Text = ""
            VLPaso = False
        End If
    End Sub

    Private Sub grdResultado_DblClick(sender As Object, e As EventArgs) Handles grdResultado.DblClick
        PMMarcaFilaCobisGrid(grdResultado, grdResultado.Row)
    End Sub

    Private Sub grdResultado_Enter(sender As Object, e As EventArgs) Handles grdResultado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(600034))
    End Sub

    Private Sub mskFechaDesde_Enter(sender As Object, e As EventArgs) Handles mskFechaDesde.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500358) & VGFormatoFecha & "]")
        mskFechaDesde.SelectionStart = 0
        mskFechaDesde.SelectionLength = Strings.Len(mskFechaDesde.Text)
    End Sub

    Private Sub mskFechaDesde_KeyPress(sender As Object, e As KeyPressEventArgs) Handles mskFechaDesde.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            e.Handled = True
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFechaHasta_Enter(sender As Object, e As EventArgs) Handles mskFechaHasta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500359) & VGFormatoFecha & "]")
        mskFechaHasta.SelectionStart = 0
        mskFechaHasta.SelectionLength = Strings.Len(mskFechaHasta.Text)
    End Sub

    Private Sub mskFechaHasta_KeyPress(sender As Object, e As KeyPressEventArgs) Handles mskFechaHasta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            e.Handled = True
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtProducto_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtProducto.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 48 Or KeyAscii > 58) And (KeyAscii <> 37) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
        lblAplicativo.Text = ""
    End Sub

    Private Sub txtProducto_Leave(sender As Object, e As EventArgs) Handles txtProducto.Leave
        PLBuscarProducto()
    End Sub

    Private Sub mskFechaDesde_Leave(sender As Object, e As EventArgs) Handles mskFechaDesde.Leave
        Dim VT As Integer
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        If mskFechaDesde.ClipText <> "" And VLPaso2 = False Then
            VT = FMVerFormato((mskFechaDesde.Text), VGFormatoFecha)
            If Not VT% Then
                COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskFechaDesde.Focus()
                VLPaso = True
                Exit Sub
            Else
                'Verificar que fecha de consulta sea menor que la fecha del sistema
                VTFecha1 = mskFechaDesde.Text

                If mskFechaHasta.ClipText <> "" Then
                    VT = FMVerFormato((mskFechaHasta.Text), VGFormatoFecha)
                    If Not VT% Then
                        COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskFechaHasta.Focus()
                        VLPaso = True
                        Exit Sub
                    Else
                        VTFecha2 = mskFechaHasta.Text
                        If FMDateDiff("d", VTFecha1, VTFecha2, VGFormatoFecha) < 0 Then
                            mskFechaDesde.Text = mskFechaHasta.Text
                        End If
                    End If
                End If
                If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    mskFechaDesde.Text = mskFechaHasta.Text
                End If
            End If
        Else
            VLPaso = False
        End If
    End Sub

    Private Sub mskFechaHasta_Leave(sender As Object, e As EventArgs) Handles mskFechaHasta.Leave
        Dim VT As Integer
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        If mskFechaHasta.ClipText <> "" And VLPaso2 = False Then
            VT = FMVerFormato((mskFechaHasta.Text), VGFormatoFecha)
            If Not VT Then
                COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskFechaHasta.Focus()
                VLPaso = True
                Exit Sub
            Else
                'Verificar que fecha de consulta sea menor que la fecha del sistema
                VTFecha1 = mskFechaHasta.Text

                If mskFechaDesde.ClipText <> "" Then
                    VT = FMVerFormato((mskFechaDesde.Text), VGFormatoFecha)
                    If Not VT% Then
                        COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskFechaDesde.Focus()
                        VLPaso = True
                        Exit Sub
                    Else
                        VTFecha2 = mskFechaDesde.Text
                        If FMDateDiff("d", VTFecha1, VTFecha2, VGFormatoFecha) > 0 Then
                            mskFechaHasta.Text = mskFechaDesde.Text
                        End If
                    End If
                End If
                If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    mskFechaHasta.Text = VGFechaProceso
                End If
            End If
        Else
            VLPaso = False
        End If
    End Sub

    Sub GeneraDatosGrid_Excel(ByRef grilla As COBISCorp.Framework.UI.Components.COBISGrid, ByRef svTitulo As String)
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = svTitulo
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = svTitulo
            For Fil As Integer = 0 To grilla.Rows - 1
                grilla.Row = Fil
                For Col As Integer = 1 To grilla.Cols - 1
                    grilla.Col = Col
                    xlsLibro.Worksheets(svTitulo).Cells(Fil + 1, Col).NumberFormat = "@"
                    xlsLibro.Worksheets(svTitulo).Cells(Fil + 1, Col).Value2 = grilla.CtlText.ToUpper().ToString()
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets(svTitulo).Rows("1:1", Type.Missing).Select()
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
        Catch excep As System.Exception
            COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        End Try
    End Sub
End Class