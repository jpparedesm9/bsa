Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran433Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Boolean = False
    Dim VLFlag As Boolean = False
    Dim VLExiste As String = ""
    Dim VLValor As String = ""
    Dim VLRespuesta As DialogResult
    Dim VLProducto As Integer = 0

    Private Sub cmbprodb_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.SelectedIndexChanged
        VLPaso = False
        txtCampo(0).Text = ""
        lblDescripcion(1).Text = ""
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                VLFlag = False
                PLBuscar()
            Case 1
                If txtCampo(0).Text = "COM" Then
                    If txtComercio.Text = "" Or txtCelular.Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(509005), My.Application.Info.ProductName)
                        Exit Sub
                    End If
                    PLHuella()
                    If Not VGRegistraHuellaAValidar Then
                        Exit Sub
                    End If
                End If
                PLTransmitir()
            Case 2
                PLLimpiar()
            Case 3
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Me.Close()
        End Select
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Enter, _cmdBoton_0.Enter, _cmdBoton_3.Enter, _cmdBoton_1.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        If Index = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509006))
        End If
        If Index = 1 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509007))
        End If
        If Index = 2 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509008))
        End If
        If Index = 3 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509009))
        End If
    End Sub

    Private Sub FTran433_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_1.Enabled
        TSBTransmitir.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Public Sub PLInicializar()
        cmbprodb.Items.Insert(0, FMLoadResString(509303))
        cmbprodb.Items.Insert(1, FMLoadResString(509304))
        cmbprodb.SelectedIndex = 0
        PMObjetoSeguridad(Me.cmdBoton(1))
        Mskcuentadb.Mask = VGMascaraCtaAho
        VLExiste = "N"
        VLPaso = True
        txtCelular.Enabled = True
        txtComercio.Enabled = True
        mskCuentadbNew.Text = ""
        mskCuentadbNew.Enabled = False
        cmbprodb.Enabled = False
        Mskcuentadb_Leave(Mskcuentadb, New EventArgs())
        txtCampo(0).Focus()
    End Sub

    Private Sub cmbprodb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.Leave
        If Not VLPaso Then
            If cmbprodb.SelectedIndex = 0 Then
                Mskcuentadb.Mask = VGMascaraCtaCte
            Else
                Mskcuentadb.Mask = VGMascaraCtaAho
            End If
            PMLimpiaGrid(grdRegistros)
            cmdBoton(0).Enabled = True
            cmdBoton(1).Enabled = True
            Mskcuentadb_Leave(Mskcuentadb, New EventArgs())
        End If
    End Sub

    Private Sub cmbprodb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.ClickEvent
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
        If grdRegistros.Rows > 0 Then
            grdRegistros.Col = 1
            Select Case grdRegistros.CtlText
                Case FMLoadResString(509304)
                    cmbprodb.SelectedIndex = 1
                Case FMLoadResString(509303)
                    cmbprodb.SelectedIndex = 0
            End Select
            grdRegistros.Col = 3
            txtCampo(0).Text = grdRegistros.CtlText
            grdRegistros.Col = 4
            lblDescripcion(1).Text = grdRegistros.CtlText
            grdRegistros.Col = 5
            txtComercio.Text = grdRegistros.CtlText
            grdRegistros.Col = 6
            txtCelular.Text = grdRegistros.CtlText
            grdRegistros.Col = 7
            lblTOperador.Text = grdRegistros.CtlText
            grdRegistros.Col = 8
            If grdRegistros.CtlText = "S" Then
                optEstado(0).Checked = True
            Else
                optEstado(1).Checked = True
            End If
            If txtCampo(0).Text = FMLoadResString(509359) Then
                If txtCampo(0).Text = FMLoadResString(509359) Then
                    lblDescripcion(2).Text = ""
                    mskCuentadbNew.Enabled = True
                    mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                End If
            End If
        End If
    End Sub

    Private Sub Mskcuentadb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentadb.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
        Mskcuentadb.SelectionStart = 0
        Mskcuentadb.SelectionLength = Strings.Len(Mskcuentadb.Text)
    End Sub

    Private Sub Mskcuentadb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentadb.Leave
        Try
            If Mskcuentadb.ClipText <> "" Then
                If cmbprodb.SelectedIndex = 1 Then
                    If FMChequeaCtaCte(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(0).Text = ""
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(0).Text = ""
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                Else
                    If FMChequeaCtaAho(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(0).Text = ""
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(0).Text = ""
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Sub PLLimpiar()
        PMLimpiaGrid(grdRegistros)
        cmbprodb.SelectedIndex = 0
        optEstado(0).Checked = True
        lblDescripcion(1).Text = ""
        txtCampo(0).Text = ""
        cmdBoton(1).Enabled = True
        cmbprodb.SelectedIndex = 0
        cmbprodb.Focus()
        VLExiste = "N"
        txtCelular.Enabled = True
        txtComercio.Enabled = True
        txtCelular.Text = ""
        lblTOperador.Text = ""
        txtComercio.Text = ""
        mskCuentadbNew.Mask = VGMascaraCtaAho
        mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
        mskCuentadbNew.Enabled = False
        lblDescripcion(2).Text = ""
    End Sub

    Private Sub mskCuentadbNew_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentadbNew.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509010))
        mskCuentadbNew.SelectionStart = 0
        mskCuentadbNew.SelectionLength = Strings.Len(mskCuentadbNew.Text)
    End Sub

    Private Sub mskCuentadbNew_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles mskCuentadbNew.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "727")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "X")
            PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, CStr(VLProducto))
            PMHelpG("cob_remesas", "sp_mto_marca_servicio", 4, 1)
            PMBuscarG(1, "@t_trn", "727", SQLINT2)
            PMBuscarG(2, "@i_operacion", "X", SQLVARCHAR)
            PMBuscarG(3, "@i_cuenta", Mskcuentadb.ClipText, SQLVARCHAR)
            PMBuscarG(4, "@i_producto", CStr(VLProducto), SQLINT4)
            PMSigteG(1, "@i_siguiente", 1, SQLVARCHAR)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, FMLoadResString(509011)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                VLPaso = True
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    mskCuentadbNew.Mask = VGMascaraCtaAho
                    mskCuentadbNew.Text = FMMascara(Temporales(1), VGMascaraCtaAho)
                    mskCuentadbNew_Leave(mskCuentadbNew, New EventArgs())
                Else
                    mskCuentadbNew.Mask = VGMascaraCtaAho
                    mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(2).Text = ""
                End If
            Else
                PMChequea(sqlconn)
                mskCuentadbNew.Mask = VGMascaraCtaAho
                mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                lblDescripcion(2).Text = ""
            End If
        End If
    End Sub

    Private Sub mskCuentadbNew_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskCuentadbNew.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii <> 116 Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskCuentadbNew_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentadbNew.Leave
        Try
            If mskCuentadbNew.Text <> FMMascara("", VGMascaraCtaAho) Then
                If cmbprodb.SelectedIndex = 1 Then
                    If FMChequeaCtaCte(mskCuentadbNew.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuentadbNew.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuentadbNew.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(2).Text = ""
                            If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuentadbNew.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(2).Text = ""
                        If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.Focus()
                        Exit Sub
                    End If
                Else
                    If FMChequeaCtaAho(mskCuentadbNew.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuentadbNew.ClipText.Replace("-", ""))
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(2).Text = ""
                            If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(2).Text = ""
                        If mskCuentadbNew.Enabled And mskCuentadbNew.Visible Then mskCuentadbNew.Focus()
                        Exit Sub
                    End If
                End If
            End If
            txtCampo(0).Focus()
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509012))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_marca_servicio")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(509013) & txtCampo(Index).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                    End If
                    VLPaso = True
            End Select
        End If
        If txtCampo(0).Text = "COM" Then
            txtCelular.Enabled = True
            txtComercio.Enabled = True
        Else
            txtCelular.Text = ""
            txtComercio.Text = ""
            txtCelular.Enabled = False
            txtComercio.Enabled = False
        End If
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_marca_servicio")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(Index).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(509013) & txtCampo(Index).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtCampo(0).Text = ""
                            lblDescripcion(1).Text = ""
                            txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                    End If
                End If
                If txtCampo(0).Text = FMLoadResString(509359) Then
                    txtCelular.Enabled = True
                    txtComercio.Enabled = True
                    txtCelular.Text = ""
                    txtComercio.Text = ""
                    lblTOperador.Text = ""
                Else
                    txtCelular.Text = ""
                    txtComercio.Text = ""
                    lblTOperador.Text = ""
                    txtCelular.Enabled = False
                    txtComercio.Enabled = False
                    If VLExiste = "S" Then
                        mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(2).Text = ""
                        mskCuentadbNew.Enabled = False
                        VLExiste = "N"
                    End If
                End If
        End Select
    End Sub

    Private Sub PLTransmitir()
        If Mskcuentadb.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(502174), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Mskcuentadb.Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502173), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If mskCuentadbNew.Enabled And mskCuentadbNew.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(509014), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuentadbNew.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(727))
        PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        Select Case cmbprodb.SelectedIndex
            Case 0
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
            Case 1
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
        End Select
        If optEstado(0).Checked Then
            PMPasoValores(sqlconn, "@i_habilitado", 0, SQLCHAR, "S")
        Else
            PMPasoValores(sqlconn, "@i_habilitado", 0, SQLCHAR, "N")
            If grdRegistros.Row > 0 Then
                VLRespuesta = COBISMessageBox.Show(FMLoadResString(509015) & txtCampo(0).Text & " " & lblDescripcion(1).Text & " ?", FMLoadResString(500237), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2)
                If VLRespuesta = System.Windows.Forms.DialogResult.Cancel Then
                    Exit Sub
                End If
            End If
        End If
        If VLExiste = "S" Then
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
            PMPasoValores(sqlconn, "@i_cuenta_nueva", 0, SQLVARCHAR, mskCuentadbNew.ClipText.Replace("-", ""))
        Else
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        End If
        PMPasoValores(sqlconn, "@i_servicio", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_celular", 0, SQLVARCHAR, txtCelular.Text)
        PMPasoValores(sqlconn, "@i_comercio", 0, SQLVARCHAR, txtComercio.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, FMLoadResString(509016)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
            Exit Sub
        End If
        PLLimpiar()
    End Sub

    Private Sub PLBuscar()
        PMLimpiaGrid(grdRegistros)
        mskCuentadbNew.Text = FMMascara("", VGMascaraCtaAho)
        lblDescripcion(2).Text = ""
        mskCuentadbNew.Enabled = False
        If Mskcuentadb.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508891), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Mskcuentadb.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(722))
        PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        Select Case cmbprodb.SelectedIndex
            Case 0
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
            Case 1
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
        End Select
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, FMLoadResString(508759)) Then
            PMMapeaGrid(sqlconn, grdRegistros, VLFlag)
            PMChequea(sqlconn)
            VLExiste = "S"
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub txtCelular_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCelular.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim VLProducto As Integer = 0
        If Keycode = VGTeclaAyuda Then
            Select Case cmbprodb.SelectedIndex
                Case 0
                    VLProducto = 4
                Case 1
                    VLProducto = 3
            End Select
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "727")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "H")
            PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, CStr(VLProducto))
            PMHelpG("cob_remesas", "sp_mto_marca_servicio", 4, 1)
            PMBuscarG(1, "@t_trn", "727", SQLINT2)
            PMBuscarG(2, "@i_operacion", "H", SQLVARCHAR)
            PMBuscarG(3, "@i_cuenta", Mskcuentadb.ClipText, SQLVARCHAR)
            PMBuscarG(4, "@i_producto", CStr(VLProducto), SQLINT4)
            PMSigteG(1, "@i_siguiente", 1, SQLVARCHAR)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, FMLoadResString(509017)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                VLPaso = True
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtCelular.Text = Temporales(1)
                    lblTOperador.Text = Temporales(2)
                Else
                    txtCelular.Text = ""
                    lblTOperador.Text = ""
                End If
            Else
                PMChequea(sqlconn)
                txtCelular.Text = ""
                lblTOperador.Text = ""
            End If
        End If
    End Sub

    Private Sub txtCelular_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCelular.KeyPress
       Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCelular_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCelular.Leave
        If txtCelular.Text <> "" Then
            Select Case cmbprodb.SelectedIndex
                Case 0
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
                Case 1
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
            End Select
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "727")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_celular", 0, SQLVARCHAR, txtCelular.Text)
            PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_marca_servicio", True, FMLoadResString(509018)) Then
                PMMapeaVariable(sqlconn, VLValor)
                PMChequea(sqlconn)
                lblTOperador.Text = VLValor
            Else
                PMChequea(sqlconn)
                lblTOperador.Text = ""
            End If
        Else
            lblTOperador.Text = ""
        End If
    End Sub

    Private Sub txtComercio_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtComercio.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLHuella()
        Dim VLNumeroDoc As String = String.Empty
        Dim VLTitularidad As String = String.Empty
        Dim VLCuenta As String = String.Empty
        Dim VLTipoTran As String = String.Empty
        If lblTitularidad.Text = FMLoadResString(509360) Then
            If lblFila.Text = "" Then
                Exit Sub
            End If
            VGTipoDoc = ""
            VLTipoTran = ""
            FMotorBusq.grdCuentas.Row = CInt(lblFila.Text)
            VLTipoTran = "1610"
            FMotorBusq.grdCuentas.Col = 7
            VGTipoDoc = FMotorBusq.grdCuentas.CtlText
            FMotorBusq.grdCuentas.Col = 8
            VLNumeroDoc = FMotorBusq.grdCuentas.CtlText
            VLTipoTran = "722"
            VLCuenta = Mskcuentadb.ClipText
            VLTitularidad = lblTitularidad.Text
            FMRegistraHuellaAValidar(VGTipoDoc, VLNumeroDoc, VLTitularidad, VLCuenta, VLTipoTran)
            VLTipoTran = "722"
            FMVerificaHuella(VLCuenta, VLTipoTran)
            If Not VGRegistraHuellaAValidar Then
                Exit Sub
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(509019), My.Application.Info.ProductName)
            Exit Sub
        End If
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

End Class
