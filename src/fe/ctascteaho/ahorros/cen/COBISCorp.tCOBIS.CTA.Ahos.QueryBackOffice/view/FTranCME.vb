Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FTranCMEClass
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
    Public VLArgument As String = ""
    Dim VLTipoConsulta As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLBuscar(False)
            Case 2
                PLLimpiar()
            Case 4
                Me.Close()
            Case 5
                GeneraDatosGrid_Excel(grdResultado, FMLoadResString(1517))
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
        mskCuenta.Mask = VGMascaraCtaAho
        VLArgument = Me.GetPageArgumentsByName("OP")
        cmdBoton(5).Enabled = False
        If VLArgument = "Cuentas_Menor_de_Edad" Then
            VLTipoConsulta = "CMEED"
            cmdBoton(5).Visible = False
        End If
        If VLArgument = "Cuentas_Proximo_Mayor_de_Edad" Then
            VLTipoConsulta = "PMAED"
        End If
    End Sub

    Private Sub grdCuentas_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdResultado.Click
        PMLineaG(grdResultado)
    End Sub

    Private Sub grdResultado_ClickEvent(sender As Object, e As EventArgs) Handles grdResultado.ClickEvent
        PMMarcaFilaCobisGrid(grdResultado, grdResultado.Row)
    End Sub

    Private Sub grdCuentas_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdResultado.DblClick
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
        If Keycode = 46 Then
            lblCliente.Text = ""
        End If
        If Keycode <> F5 Then
            Exit Sub
        End If
        txtCliente.Text = ""
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
    Private Sub PLValidaEtiquetaCriterios()
        If txtOficina.Text <> "" And lblOficina.Text = "" Then
            PLBuscarOficina()
        End If
        If txtCliente.Text <> "" And lblCliente.Text = "" Then
            PLBuscarCliente()
        End If
        If mskCuenta.ClipText <> "" And lblCuenta.Text = "" Then
            PLBuscarCuenta()
        End If
    End Sub

    Private Sub PLBuscar(ByRef VTAnadir As Integer)
        Me.PLValidaEtiquetaCriterios()
        If txtOficina.Text <> "" Then
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtOficina.Text)
        End If
        If txtCliente.Text <> "" Then
            PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, txtCliente.Text)
        End If
        If mskCuenta.ClipText <> "" Then
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "537")
        PMPasoValores(sqlconn, "@i_tipo_trn", 0, SQLCHAR, VLTipoConsulta)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_prod_menoredad", True, "") Then
            PMMapeaGrid(sqlconn, grdResultado, VTAnadir)
            PMMapeaTextoGrid(grdResultado)
            PMAnchoColumnasGrid(grdResultado)
            PMChequea(sqlconn)
            If VLTipoConsulta = "PMAED" Then
                grdResultado.Row = 1
                grdResultado.Col = 1
                If Trim(grdResultado.CtlText) <> "" Then
                    cmdBoton(5).Enabled = True
                End If
            Else
                cmdBoton(5).Enabled = False
            End If
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(1098))
        Else
            PMLimpiaG(grdResultado)
            PMChequea(sqlconn)
        End If
        grdResultado.Row = 1
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        mskCuenta.Mask = VGMascaraCtaAho
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        lblCuenta.Text = ""
        txtCliente.Text = ""
        lblCliente.Text = ""
        txtOficina.Text = ""
        lblOficina.Text = ""
        cmdBoton(5).Enabled = False
        PMLimpiaG(grdResultado)
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

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBExcel.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub txtOficina_Enter(sender As Object, e As EventArgs) Handles txtOficina.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2520))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub txtOficina_KeyDown(sender As Object, e As KeyEventArgs) Handles txtOficina.KeyDown
        Dim KeyCode As Integer = e.KeyCode
        If KeyCode <> VGTeclaAyuda Then
            Exit Sub
        End If
        If KeyCode = VGTeclaAyuda Then
            VGOperacion = "sp_oficina"
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(503007)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtOficina.Text = VGACatalogo.Codigo
                lblOficina.Text = VGACatalogo.Descripcion
                If txtOficina.Text <> "" Then
                    txtOficina.Focus()
                End If
                FCatalogo.Dispose()
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtOficina_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtOficina.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 48 Or KeyAscii > 58) And (KeyAscii <> 37) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
        lblOficina.Text = ""
    End Sub

    Private Sub txtOficina_Leave(sender As Object, e As EventArgs) Handles txtOficina.Leave
        PLBuscarOficina()
    End Sub

    Private Sub PLBuscarOficina()
        If txtOficina.Text <> "" Then
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtOficina.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtOficina.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblOficina)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                txtOficina.Text = ""
                lblOficina.Text = ""
                txtOficina.Focus()
            End If
        Else
            lblOficina.Text = ""
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

        If txtCliente.Text <> "" Then
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
            End If
        Else
            lblCliente.Text = ""
            txtCliente.Text = ""
        End If
    End Sub

    Private Sub mskCuenta_Enter(sender As Object, e As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509031))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

  

    Private Sub mskCuenta_KeyDown(sender As Object, e As KeyEventArgs) Handles mskCuenta.KeyDown
        Dim KeyAscii As Integer = Strings.Asc(e.KeyCode)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 48 Or KeyAscii > 58) And (KeyAscii <> 37) And (KeyAscii <> 22) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If

        lblCuenta.Text = ""
    End Sub

    Private Sub mskCuenta_KeyPress(sender As Object, e As KeyPressEventArgs) Handles mskCuenta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 48 Or KeyAscii > 58) And (KeyAscii <> 37) And (KeyAscii <> 22) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
        lblCuenta.Text = ""
    End Sub

    Private Sub mskCuenta_Leave(sender As Object, e As EventArgs) Handles mskCuenta.Leave
        PLBuscarCuenta()
    End Sub

    Private Sub PLBuscarCuenta()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblCuenta)
                        PMChequea(sqlconn)
                        PMLimpiaGrid(grdResultado)
                    Else
                        PMChequea(sqlconn)
                        lblCuenta.Text = ""
                        mskCuenta.Text = ""
                        mskCuenta.Mask = VGMascaraCtaAho
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    lblCuenta.Text = ""
                    mskCuenta.Text = ""
                    mskCuenta.Focus()
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub grdResultado_Enter(sender As Object, e As EventArgs) Handles grdResultado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1099))
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