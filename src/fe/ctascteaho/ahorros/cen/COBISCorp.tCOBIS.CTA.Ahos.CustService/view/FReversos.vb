Imports System.Drawing
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice
Public Class FReversosClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    'Variables
    Dim VLPaso As Boolean
    Dim VLStyle As Short
    'Constantes
    Const CLColIco As Short = 1
    Const CLColTrn As Short = 2
    Const CLColDes As Short = 3
    Const CLColFec As Short = 4
    Const CLColHor As Short = 5
    Const CLColEst As Short = 6
    Const CLColSec As Short = 7
    Const CLColSeB As Short = 8
    Const CLColSeA As Short = 9
    Const CLColMon As Short = 10
    Const CLColCta As Short = 11
    Const CLColNom As Short = 12
    Const CLColTot As Short = 13
    Const CLColEfe As Short = 14
    Const CLColChP As Short = 15
    Const CLColChL As Short = 16
    Const CLColChR As Short = 17
    Const CLColUsr As Short = 18
    Const CLMaxLength As Short = 18
    Const CLFormatoValor As String = "#,##0.00"
    Const CLMaxValor As Double = 999999999999.99
    Private Sub FReversos_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub
    Private Sub FReversosClass_ShowView(sender As Object, e As EventArgs) Handles Me.ShowView
        grdTransacciones.Focus()
    End Sub
    Private Sub TSBotones_ItemClicked(sender As Object, e As Windows.Forms.ToolStripItemClickedEventArgs) Handles TSBotones.ItemClicked

        Select Case e.ClickedItem.Name
            Case "TSBBuscar"
                If Not Me.FLValidarCampos Then Exit Sub
                Me.PLBuscar()
            Case "TSBSiguiente"
                Me.PLBuscar(True)
            Case "TSBTransmitir"
                Dim VTEstReverso As Boolean
                Dim VTSecuencial As String
                Dim VTDescripcion As String
                Dim VTEstado As String
                Dim VTCuenta As String
                Dim VTNombre As String
                Dim VTValor As String
                Dim VTTrn As Integer

                With grdTransacciones
                    .GetText(CLColTrn, .SelBlockRow, VTTrn)
                    .GetText(CLColDes, .SelBlockRow, VTDescripcion)
                    .GetText(CLColSec, .SelBlockRow, VTSecuencial)
                    .GetText(CLColEst, .SelBlockRow, VTEstado)
                    .GetText(CLColCta, .SelBlockRow, VTCuenta)
                    .GetText(CLColNom, .SelBlockRow, VTNombre)
                    .GetText(CLColTot, .SelBlockRow, VTValor)
                End With

                If VTEstado = "R" Then 'Esta transacción ya fue reversada
                    COBISMessageBox.Show(FMLoadResString(509551), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If

                Dim VTMsgConfirma As String = FMLoadResString(509548) & Chr(10) & Chr(10) & _
                                              FMLoadResString(500641) & " " & VTSecuencial & Chr(10) & _
                                              FMLoadResString(5084) & " " & VTDescripcion & Chr(10) & _
                                              FMLoadResString(502158) & " " & VTCuenta & " " & VTNombre & Chr(10) & _
                                              FMLoadResString(5178) & " " & VTValor

                If COBISMessageBox.Show(VTMsgConfirma, FMLoadResString(2615), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = vbNo Then Exit Sub

                Select Case VTTrn
                    Case 252 : VTEstReverso = FLReversarDeposito()
                    Case 263 : VTEstReverso = FLReversarRetiro()
                End Select

                If VTEstReverso Then
                    COBISMessageBox.Show(FMLoadResString(509549) & " " & VTSecuencial, FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    Me.PLIniForm()
                End If

            Case "TSBLimpiar"
                Me.PLIniForm()
            Case "TSBSalir"
                Me.Dispose()
                Me.Close()
        End Select

    End Sub

#Region "Usuario"
    Private Sub chkUsuario_CheckedChanged(sender As Object, e As EventArgs) Handles chkUsuario.CheckedChanged
        If chkUsuario.Checked Then
            pnlUsuario.Visible = True
            txtUsrCodigo.Focus()
        Else
            Me.PLLimpiarUsuario()
        End If
    End Sub
    Private Sub chkUsuario_GotFocus(sender As Object, e As EventArgs) Handles chkUsuario.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509518))
    End Sub
    Private Sub txtUsrCodigo_Load(sender As Object, e As EventArgs) Handles txtUsrCodigo.Load
        '
    End Sub
    Private Sub txtUsrCodigo_Enter(sender As Object, e As EventArgs) Handles txtUsrCodigo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500421))
    End Sub
    Private Sub txtUsrCodigo_Change(sender As Object, e As EventArgs) Handles txtUsrCodigo.Change
        VLPaso = True
    End Sub
    Private Sub txtUsrCodigo_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles txtUsrCodigo.KeyDown

        If e.KeyCode = VGTeclaAyuda Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15001")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "3")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMHelpG("cobis", "sp_funcbusq", 3, 1)
            PMBuscarG(1, "@t_trn", "15001", SQLINT2)
            PMBuscarG(2, "@i_tipo", "3", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            PMSigteG(1, "@i_login", 3, SQLVARCHAR)

            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_funcbusq", True, FMLoadResString(508810)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMMapeaTextoGrid(grid_valores.gr_SQL)
                PMChequea(sqlconn)
                grid_valores.dl_sp.Visible = False
                grid_valores.gr_SQL.Row = 1
                PMMarcaFilaCobisGrid(grid_valores.gr_SQL, grid_valores.gr_SQL.Row)
                PMProcesG()

                grid_valores.ShowPopup(Me)

                If Not String.IsNullOrEmpty(Temporales(3)) Then
                    VLPaso = False
                    txtUsrCodigo.Text = Temporales(3)
                    txtUsrNombre.Text = Temporales(2)
                Else
                    txtUsrCodigo.Text = ""
                    txtUsrNombre.Text = ""
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If

        'If e.KeyCode = VGTeclaAyuda Then
        '    FGFuncionarios.ShowPopup(Me)

        '    If Not String.IsNullOrEmpty(VGBusqueda(1)) Then
        '        VLPaso = False
        '        txtUsrCodigo.Text = VGBusqueda(3)
        '        txtUsrNombre.Text = VGBusqueda(2)
        '    Else
        '        txtUsrCodigo.Text = ""
        '        txtUsrNombre.Text = ""
        '    End If
        'End If

    End Sub
    Private Sub txtUsrCodigo_Leave(sender As Object, e As EventArgs) Handles txtUsrCodigo.Leave
        If VLPaso Then
            txtUsrNombre.Text = ""
            If Not String.IsNullOrEmpty(txtUsrCodigo.Text.Trim) Then
                If Me.FLConsultarUsuario() Then
                    VLPaso = False
                Else
                    txtUsrCodigo.Text = ""
                    txtUsrCodigo.Focus()
                End If
            End If
        End If
    End Sub
    Private Sub txtUsrNombre_TextChanged(sender As Object, e As EventArgs) Handles txtUsrNombre.TextChanged
        '
    End Sub
    Private Sub txtUsrNombre_GotFocus(sender As Object, e As EventArgs) Handles txtUsrNombre.GotFocus
        txtUsrNombre.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Secuencial"
    Private Sub chkSecuencial_CheckedChanged(sender As Object, e As EventArgs) Handles chkSecuencial.CheckedChanged
        If chkSecuencial.Checked Then
            pnlSecuencial.Visible = True
            txtSecIni.Focus()
        Else
            Me.PLLimpiarSecuencial()
        End If
    End Sub
    Private Sub chkSecuencial_GotFocus(sender As Object, e As EventArgs) Handles chkSecuencial.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509519))
    End Sub
    Private Sub txtSecIni_Load(sender As Object, e As EventArgs) Handles txtSecIni.Load
        '
    End Sub
    Private Sub txtSecIni_Enter(sender As Object, e As EventArgs) Handles txtSecIni.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501367))
    End Sub
    Private Sub txtSecFin_Load(sender As Object, e As EventArgs) Handles txtSecFin.Load
        '
    End Sub
    Private Sub txtSecFin_Enter(sender As Object, e As EventArgs) Handles txtSecFin.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501368))
    End Sub
#End Region

#Region "Nemónico"
    Private Sub chkNemonico_CheckedChanged(sender As Object, e As EventArgs) Handles chkNemonico.CheckedChanged
        If chkNemonico.Checked Then
            pnlNemonico.Visible = True
            txtNemonico.Focus()
        Else
            Me.PLLimpiarNemonico()
        End If
    End Sub
    Private Sub chkNemonico_GotFocus(sender As Object, e As EventArgs) Handles chkNemonico.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509527))
    End Sub
    Private Sub txtNemonico_Load(sender As Object, e As EventArgs) Handles txtNemonico.Load
        '
    End Sub
    Private Sub txtNemonico_Enter(sender As Object, e As EventArgs) Handles txtNemonico.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509525))
    End Sub
#End Region

#Region "Hora"
    Private Sub chkHora_CheckedChanged(sender As Object, e As EventArgs) Handles chkHora.CheckedChanged
        If chkHora.Checked Then
            pnlHora.Visible = True
            mskHoraIni.Focus()
        Else
            Me.PLLimpiarHora()
        End If
    End Sub
    Private Sub chkHora_GotFocus(sender As Object, e As EventArgs) Handles chkHora.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509528))
    End Sub
    Private Sub mskHoraIni_MaskInputRejected(sender As Object, e As Windows.Forms.MaskInputRejectedEventArgs) Handles mskHoraIni.MaskInputRejected
        '
    End Sub
    Private Sub mskHoraIni_GotFocus(sender As Object, e As EventArgs) Handles mskHoraIni.GotFocus
        mskHoraIni.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509529))
    End Sub
    Private Sub mskHoraFin_MaskInputRejected(sender As Object, e As Windows.Forms.MaskInputRejectedEventArgs) Handles mskHoraFin.MaskInputRejected
        '
    End Sub
    Private Sub mskHoraFin_GotFocus(sender As Object, e As EventArgs) Handles mskHoraFin.GotFocus
        mskHoraFin.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509530))
    End Sub
#End Region

#Region "Valor"
    Private Sub chkValor_CheckedChanged(sender As Object, e As EventArgs) Handles chkValor.CheckedChanged
        If chkValor.Checked Then
            pnlValor.Visible = True
            mskValorIni.Focus()
        Else
            Me.PLLimpiarValor()
        End If
    End Sub
    Private Sub chkValor_GotFocus(sender As Object, e As EventArgs) Handles chkValor.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509536))
    End Sub
    Private Sub mskValorIni_Change(sender As Object, e As EventArgs) Handles mskValorIni.Change
        '
    End Sub
    Private Sub mskValorIni_GotFocus(sender As Object, e As EventArgs) Handles mskValorIni.GotFocus
        mskValorIni.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500704))
    End Sub
    Private Sub mskValorIni_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskValorIni.KeyDown
        Select Case e.KeyCode
            Case 110, 190
                Dim VTPos As Short = mskValorIni.Text.IndexOf(".")
                If VTPos > -1 Then mskValorIni.SelectionStart = VTPos + 1
        End Select
    End Sub
    Private Sub mskValorIni_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles mskValorIni.KeyPress
        If mskValorIni.SelectionLength <> mskValorIni.TextLength Then
            If mskValorIni.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = mskValorIni.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (mskValorIni.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
    End Sub
    Private Sub mskValorFin_Change(sender As Object, e As EventArgs) Handles mskValorFin.Change
        '
    End Sub
    Private Sub mskValorFin_GotFocus(sender As Object, e As EventArgs) Handles mskValorFin.GotFocus
        mskValorFin.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500705))
    End Sub
    Private Sub mskValorFin_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskValorFin.KeyDown
        Select Case e.KeyCode
            Case 110, 190
                Dim VTPos As Short = mskValorFin.Text.IndexOf(".")
                If VTPos > -1 Then mskValorFin.SelectionStart = VTPos + 1
        End Select
    End Sub
    Private Sub mskValorFin_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles mskValorFin.KeyPress
        If mskValorFin.SelectionLength <> mskValorFin.TextLength Then
            If mskValorFin.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = mskValorFin.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (mskValorFin.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
    End Sub
#End Region

#Region "Cuenta"
    Private Sub chkCuenta_CheckedChanged(sender As Object, e As EventArgs) Handles chkCuenta.CheckedChanged
        If chkCuenta.Checked Then
            pnlCuenta.Visible = True
            mskCuenta.Focus()
        Else
            Me.PLLimpiarCuenta()
        End If
    End Sub
    Private Sub chkCuenta_GotFocus(sender As Object, e As EventArgs) Handles chkCuenta.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509539))
    End Sub
    Private Sub mskCuenta_MaskInputRejected(sender As Object, e As Windows.Forms.MaskInputRejectedEventArgs) Handles mskCuenta.MaskInputRejected
        '
    End Sub
    Private Sub mskCuenta_GotFocus(sender As Object, e As EventArgs) Handles mskCuenta.GotFocus
        mskCuenta.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
    End Sub
    Private Sub mskCuenta_Leave(sender As Object, e As EventArgs) Handles mskCuenta.Leave

        txtNomCuenta.Text = ""

        If Not String.IsNullOrEmpty(mskCuenta.ClipText.Trim) Then
            If Not Me.FLConsultarCuenta() Then
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                mskCuenta.Focus()
            End If
        End If

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)

    End Sub
    Private Sub txtNomCuenta_TextChanged(sender As Object, e As EventArgs) Handles txtNomCuenta.TextChanged
        '
    End Sub
    Private Sub txtNomCuenta_GotFocus(sender As Object, e As EventArgs) Handles txtNomCuenta.GotFocus
        txtNomCuenta.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Moneda"
    Private Sub chkMoneda_CheckedChanged(sender As Object, e As EventArgs) Handles chkMoneda.CheckedChanged
        If chkMoneda.Checked Then
            pnlMoneda.Visible = True
            txtCodMoneda.Focus()
        Else
            Me.PLLimpiarMoneda()
        End If
    End Sub
    Private Sub chkMoneda_GotFocus(sender As Object, e As EventArgs) Handles chkMoneda.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509540))
    End Sub
    Private Sub txtCodMoneda_Load(sender As Object, e As EventArgs) Handles txtCodMoneda.Load
        '
    End Sub
    Private Sub txtCodMoneda_Change(sender As Object, e As EventArgs) Handles txtCodMoneda.Change
        VLPaso = True
    End Sub
    Private Sub txtCodMoneda_Enter(sender As Object, e As EventArgs) Handles txtCodMoneda.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509550))
    End Sub
    Private Sub txtCodMoneda_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles txtCodMoneda.KeyDown

        If e.KeyCode = VGTeclaAyuda Then
            VGOperacion = ""
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_moneda")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(508804)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.cmdSiguientes.Enabled = False
                FCatalogo.ShowPopup()

                If Not String.IsNullOrEmpty(VGACatalogo.Codigo) Then
                    VLPaso = False
                    txtCodMoneda.Text = VGACatalogo.Codigo
                    txtNomMoneda.Text = VGACatalogo.Descripcion
                Else
                    txtCodMoneda.Text = ""
                    txtNomMoneda.Text = ""
                End If

                FCatalogo.Dispose()
                txtCodMoneda.Focus()
            Else
                PMChequea(sqlconn)
            End If
        End If

    End Sub
    Private Sub txtCodMoneda_Leave(sender As Object, e As EventArgs) Handles txtCodMoneda.Leave
        If VLPaso Then
            txtNomMoneda.Text = ""
            If Not String.IsNullOrEmpty(txtCodMoneda.Text.Trim) Then
                If Me.FLConsultarMoneda() Then
                    VLPaso = False
                Else
                    txtCodMoneda.Text = ""
                    txtCodMoneda.Focus()
                End If
            End If
        End If
    End Sub
    Private Sub txtNomMoneda_TextChanged(sender As Object, e As EventArgs) Handles txtNomMoneda.TextChanged
        '
    End Sub
    Private Sub txtNomMoneda_GotFocus(sender As Object, e As EventArgs) Handles txtNomMoneda.GotFocus
        txtNomMoneda.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Transacciones"
    Private Sub grdTransacciones_CellClick(sender As Object, e As FarPoint.Win.Spread.CellClickEventArgs) Handles grdTransacciones.CellClick
        '
    End Sub
    Private Sub grdTransacciones_Enter(sender As Object, e As EventArgs) Handles grdTransacciones.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Procedures"
    Private Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        VLStyle = FLStyle(VGFormatoFecha)
        Me.PLHabilitaBotones("I")
        mskValorIni.MaxReal = CLMaxValor
        mskValorFin.MaxReal = CLMaxValor
        mskCuenta.Mask = VGMascaraCtaAho
        Me.PLIniciarGrid()
    End Sub
    Private Sub PLHabilitaBotones(ByVal pTipo As String)

        Select Case pTipo
            Case "I"
                TSBotones.Items("TSBBuscar").Enabled = True
                TSBotones.Items("TSBSiguiente").Enabled = False
                TSBotones.Items("TSBTransmitir").Enabled = False
            Case "B"
                TSBotones.Items("TSBBuscar").Enabled = False
                TSBotones.Items("TSBSiguiente").Enabled = False
                TSBotones.Items("TSBTransmitir").Enabled = True
            Case "S"
                TSBotones.Items("TSBBuscar").Enabled = False
                TSBotones.Items("TSBSiguiente").Enabled = True
                TSBotones.Items("TSBTransmitir").Enabled = True
        End Select

    End Sub
    Private Sub PLBuscar(Optional ByVal pSiguiente As Boolean = False)

        Try
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "500")
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            PMPasoValores(sqlconn, "@i_formato", 0, SQLINT2, VLStyle)

            If chkUsuario.Checked Then
                PMPasoValores(sqlconn, "@i_usuario", 0, SQLVARCHAR, txtUsrCodigo.Text.Trim)
            End If

            If chkSecuencial.Checked Then
                PMPasoValores(sqlconn, "@i_sec_ini", 0, SQLINT4, txtSecIni.Text.Trim)
                PMPasoValores(sqlconn, "@i_sec_fin", 0, SQLINT4, txtSecFin.Text.Trim)
            End If

            If chkNemonico.Checked Then
                PMPasoValores(sqlconn, "@i_tran", 0, SQLINT4, txtNemonico.Text.Trim)
            End If

            If chkHora.Checked Then
                PMPasoValores(sqlconn, "@i_hora_ini", 0, SQLVARCHAR, mskHoraIni.Text.Trim)
                PMPasoValores(sqlconn, "@i_hora_fin", 0, SQLVARCHAR, mskHoraFin.Text.Trim)
            End If

            If chkValor.Checked Then
                PMPasoValores(sqlconn, "@i_val_ini", 0, SQLMONEY, mskValorIni.Text.Trim)
                PMPasoValores(sqlconn, "@i_val_fin", 0, SQLMONEY, mskValorFin.Text.Trim)
            End If

            If chkCuenta.Checked Then
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText.Trim)
            End If

            If chkMoneda.Checked Then
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, txtCodMoneda.Text.Trim)
            Else
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            End If

            If pSiguiente Then
                grdTransacciones.Row = grdTransacciones.MaxRows
                grdTransacciones.Col = CLColSec
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdTransacciones.Text)
                grdTransacciones.Col = CLColSeA
                PMPasoValores(sqlconn, "@i_cod_alterno", 0, SQLINT4, grdTransacciones.Text)
            End If

            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_rev_tran_monet", True, FMLoadResString(20001)) Then
                If pSiguiente Then PLEliminarCol()
                PMMapeaGrid(sqlconn, grdTransacciones, pSiguiente)
                PMChequea(sqlconn)

                Me.PLAumentarIconos()
                Me.PLGridCabecera()
                If Not pSiguiente Then Me.PLOcultarColumnas()
                Me.PLFormatoCuenta()

                If CInt(grdTransacciones.Tag) < 20 Then
                    Me.PLHabilitaBotones("B")
                Else
                    Me.PLHabilitaBotones("S")
                End If

                ugbBuscar.Enabled = False
                grdTransacciones.Row = grdTransacciones.SelBlockRow
                grdTransacciones.Focus()
            Else
                PMChequea(sqlconn)
            End If

        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

    End Sub
#End Region

#Region "Functions"
    Private Function FLReversarDeposito() As Boolean
        Dim VTSecuencial As Integer
        Dim VTCuentaTmp As String
        Dim VTCuenta As String = ""
        Dim VTUser As String
        Dim VTMoneda As Short
        Dim VTTotal As Double
        Dim VTEfectivo As Double
        Dim VTChequesP As Double
        Dim VTChequesL As Double
        Dim VTChequesR As Double

        With grdTransacciones
            .GetText(CLColSeB, .SelBlockRow, VTSecuencial)
            .GetText(CLColMon, .SelBlockRow, VTMoneda)
            .GetText(CLColCta, .SelBlockRow, VTCuentaTmp)
            .GetText(CLColTot, .SelBlockRow, VTTotal)
            .GetText(CLColEfe, .SelBlockRow, VTEfectivo)
            .GetText(CLColChP, .SelBlockRow, VTChequesP)
            .GetText(CLColChL, .SelBlockRow, VTChequesL)
            .GetText(CLColChR, .SelBlockRow, VTChequesR)
            .GetText(CLColUsr, .SelBlockRow, VTUser)
        End With

        For VTi As Short = 0 To VTCuentaTmp.Length - 1 'Obtiene el número de cuenta sin máscara
            If IsNumeric(VTCuentaTmp.Substring(VTi, 1)) Then VTCuenta &= VTCuentaTmp.Substring(VTi, 1)
        Next

        Try
            If VTChequesL <> 0.0 Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "639")
                PMPasoValores(sqlconn, "@t_corr", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@t_ssn_corr", 0, SQLINT4, VTSecuencial)
                PMPasoValores(sqlconn, "@s_user", 0, SQLVARCHAR, VTUser)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_detallecheque", True, FMLoadResString(509507)) Then
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    Return False
                End If
            End If

            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "252")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VTCuenta)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VTMoneda)
            PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTEfectivo)
            PMPasoValores(sqlconn, "@i_loc", 0, SQLMONEY, VTChequesL)
            PMPasoValores(sqlconn, "@i_prop", 0, SQLMONEY, VTChequesP)
            PMPasoValores(sqlconn, "@i_plaz", 0, SQLMONEY, VTChequesR)
            PMPasoValores(sqlconn, "@i_total", 0, SQLMONEY, VTTotal)
            PMPasoValores(sqlconn, "@i_ActTot", 0, SQLCHAR, "N")
            PMPasoValores(sqlconn, "@i_canal", 0, SQLINT1, 0)
            'Reverso
            PMPasoValores(sqlconn, "@t_corr", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@t_ssn_corr", 0, SQLINT4, VTSecuencial)
            PMPasoValores(sqlconn, "@s_user", 0, SQLVARCHAR, VTUser)

            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_depositosl", True, FMLoadResString(509549)) Then
                PMChequea(sqlconn)
                Return True
            Else
                PMChequea(sqlconn)
            End If

        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return False

    End Function
    Private Function FLReversarRetiro() As Boolean
        Dim VTSecuencial As Integer
        Dim VTCuentaTmp As String
        Dim VTCuenta As String = ""
        Dim VTUser As String
        Dim VTValor As Double
        Dim VTMoneda As Short

        With grdTransacciones
            .GetText(CLColSeB, .SelBlockRow, VTSecuencial)
            .GetText(CLColMon, .SelBlockRow, VTMoneda)
            .GetText(CLColCta, .SelBlockRow, VTCuentaTmp)
            .GetText(CLColTot, .SelBlockRow, VTValor)
            .GetText(CLColUsr, .SelBlockRow, VTUser)
        End With

        For VTi As Short = 0 To VTCuentaTmp.Length - 1 'Obtiene el número de cuenta sin máscara
            If IsNumeric(VTCuentaTmp.Substring(VTi, 1)) Then VTCuenta &= VTCuentaTmp.Substring(VTi, 1)
        Next

        Try
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "263")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VTCuenta)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VTMoneda)
            PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTValor)
            PMPasoValores(sqlconn, "@i_ActTot", 0, SQLCHAR, "N")
            PMPasoValores(sqlconn, "@i_canal", 0, SQLINT1, 0)
            'Reverso
            PMPasoValores(sqlconn, "@t_corr", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@t_ssn_corr", 0, SQLINT4, VTSecuencial)
            PMPasoValores(sqlconn, "@s_user", 0, SQLVARCHAR, VTUser)

            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_retirosl", True, FMLoadResString(509549)) Then
                PMChequea(sqlconn)
                Return True
            Else
                PMChequea(sqlconn)
            End If

        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return False

    End Function
    Private Function FLValidarCampos()

        If chkUsuario.Checked Then
            If String.IsNullOrEmpty(txtUsrCodigo.Text.Trim) Then 'El login del operador es mandatorio
                COBISMessageBox.Show(FMLoadResString(500419), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtUsrCodigo.Focus()
                Return False
            Else
                If Not Me.FLConsultarUsuario() Then
                    txtUsrCodigo.Text = ""
                    txtUsrNombre.Text = ""
                    txtUsrCodigo.Focus()
                    Return False
                End If
            End If
        End If

        If chkSecuencial.Checked Then
            If Not IsNumeric(txtSecIni.Text.Trim) Then 'La Secuencia Inicial es mandatorio
                COBISMessageBox.Show(FMLoadResString(501361), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtSecIni.Focus()
                Return False
            Else
                If CLng(txtSecIni.Text.Trim) <= 0 Then 'La Secuencia Inicial debe ser mayor a cero
                    COBISMessageBox.Show(FMLoadResString(509522), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtSecIni.Focus()
                    Return False
                End If
            End If

            If Not IsNumeric(txtSecFin.Text.Trim) Then 'La Secuencia Final es mandatorio
                COBISMessageBox.Show(FMLoadResString(501362), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtSecFin.Focus()
                Return False
            Else
                If CLng(txtSecFin.Text.Trim) <= 0 Then 'La Secuencia Final debe ser mayor a cero
                    COBISMessageBox.Show(FMLoadResString(509523), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtSecFin.Focus()
                    Return False
                End If
            End If

            If CLng(txtSecIni.Text) > CLng(txtSecFin.Text) Then 'La Secuencia Final no puede ser menor a la Secuencia Inicial
                COBISMessageBox.Show(FMLoadResString(509524), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtSecFin.Focus()
                Return False
            End If
        End If

        If chkNemonico.Checked Then
            If Not IsNumeric(txtNemonico.Text.Trim) Then 'El código de la transacción es mandatorio
                COBISMessageBox.Show(FMLoadResString(502093), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtNemonico.Focus()
                Return False
            Else
                If CLng(txtNemonico.Text.Trim) <= 0 Then 'Código de transacción no válido
                    COBISMessageBox.Show(FMLoadResString(509526), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtNemonico.Focus()
                    Return False
                End If
            End If
        End If

        If chkHora.Checked Then
            mskHoraIni.TextMaskFormat = Windows.Forms.MaskFormat.ExcludePromptAndLiterals

            If String.IsNullOrEmpty(mskHoraIni.Text.Trim) Then 'Hora inicial es mandatoria
                mskHoraIni.TextMaskFormat = Windows.Forms.MaskFormat.IncludeLiterals
                COBISMessageBox.Show(FMLoadResString(509531), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskHoraIni.Focus()
                Return False
            Else
                mskHoraIni.TextMaskFormat = Windows.Forms.MaskFormat.IncludeLiterals

                If Not IsDate(mskHoraIni.Text.Trim) Or mskHoraIni.Text.Trim.Length < 5 Then 'Hora inicial no es válida
                    COBISMessageBox.Show(FMLoadResString(509533), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskHoraIni.Focus()
                    Return False
                End If
            End If

            mskHoraFin.TextMaskFormat = Windows.Forms.MaskFormat.ExcludePromptAndLiterals

            If String.IsNullOrEmpty(mskHoraFin.Text.Trim) Then 'Hora final es mandatoria
                mskHoraFin.TextMaskFormat = Windows.Forms.MaskFormat.IncludeLiterals
                COBISMessageBox.Show(FMLoadResString(509532), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskHoraFin.Focus()
                Return False
            Else
                mskHoraFin.TextMaskFormat = Windows.Forms.MaskFormat.IncludeLiterals

                If Not IsDate(mskHoraFin.Text.Trim) Or mskHoraFin.Text.Trim.Length < 5 Then 'Hora final no es válida
                    COBISMessageBox.Show(FMLoadResString(509534), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskHoraFin.Focus()
                    Return False
                End If
            End If

            If CDate(mskHoraIni.Text.Trim) > CDate(mskHoraFin.Text.Trim) Then 'Hora final no puede ser menor a la hora inicial
                COBISMessageBox.Show(FMLoadResString(509535), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskHoraFin.Focus()
                Return False
            End If
        End If

        If chkValor.Checked Then

            If Not IsNumeric(mskValorIni.Text.Trim) Then 'El valor inicial es mandatorio
                COBISMessageBox.Show(FMLoadResString(502210), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskValorIni.Focus()
                Return False
            Else
                If CDbl(mskValorIni.Text.Trim) <= 0 Then 'El valor debe ser mayor a cero
                    COBISMessageBox.Show(FMLoadResString(509537), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValorIni.Focus()
                    Return False
                Else
                    If CDbl(mskValorIni.Text.Trim) > CLMaxValor Then 'Valor excede el máximo permitido
                        COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskValorIni.Focus()
                        Return False
                    End If
                End If
            End If

            If Not IsNumeric(mskValorFin.Text.Trim) Then 'El valor final es mandatorio
                COBISMessageBox.Show(FMLoadResString(502211), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskValorFin.Focus()
                Return False
            Else
                If CDbl(mskValorFin.Text.Trim) <= 0 Then 'El valor debe ser mayor a cero
                    COBISMessageBox.Show(FMLoadResString(509537), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValorFin.Focus()
                    Return False
                Else
                    If CDbl(mskValorFin.Text.Trim) > CLMaxValor Then 'Valor excede el máximo permitido
                        COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskValorFin.Focus()
                        Return False
                    End If
                End If
            End If

            If CDbl(mskValorIni.Text.Trim) > CDbl(mskValorFin.Text.Trim) Then 'El valor final no puede ser menor al valor inicial
                COBISMessageBox.Show(FMLoadResString(509538), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskValorFin.Focus()
                Return False
            End If

        End If

        If chkCuenta.Checked Then
            If String.IsNullOrEmpty(mskCuenta.ClipText.Trim) Then 'INGRESE NUMERO DE CUENTA
                COBISMessageBox.Show(FMLoadResString(508603), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCuenta.Focus()
                Return False
            Else
                If Not Me.FLConsultarCuenta() Then
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    txtNomCuenta.Text = ""
                    mskCuenta.Focus()
                    Return False
                End If
            End If
        End If

        If chkMoneda.Checked Then
            If Not IsNumeric(txtCodMoneda.Text.Trim) Then 'El código de moneda es mandatorio
                COBISMessageBox.Show(FMLoadResString(509541), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCodMoneda.Focus()
                Return False
            Else
                If Not Me.FLConsultarMoneda() Then
                    txtCodMoneda.Text = ""
                    txtNomMoneda.Text = ""
                    txtCodMoneda.Focus()
                    Return False
                End If
            End If
        End If

        Return True

    End Function
    ''' <summary>
    ''' Consulta el nombre de la cuenta
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLConsultarCuenta() As Boolean

        Try
            If FMChequeaCtaAho(mskCuenta.ClipText.Trim) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText.Trim)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2330) & mskCuenta.Text & "]") Then
                    Dim VTArreglo(10) As String
                    Dim VTR1 As Integer = FMMapeaArreglo(sqlconn, VTArreglo)
                    txtNomCuenta.Text = VTArreglo(1)
                    PMChequea(sqlconn)
                    Return True
                Else
                    PMChequea(sqlconn)
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            End If
        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return False

    End Function
    ''' <summary>
    ''' Consulta la descripción de la moneda
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLConsultarMoneda() As Boolean

        Try
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_moneda")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCodMoneda.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(508804)) Then
                PMMapeaObjeto(sqlconn, txtNomMoneda)
                PMChequea(sqlconn)
                Return True
            Else
                PMChequea(sqlconn)
            End If

        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return False

    End Function
    ''' <summary>
    ''' Consulta el nombre del usuario
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLConsultarUsuario() As Boolean

        Try
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15001")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "6")
            PMPasoValores(sqlconn, "@i_login", 0, SQLVARCHAR, txtUsrCodigo.Text.Trim)

            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_funcbusq", True, FMLoadResString(508810)) Then
                PMMapeaObjeto(sqlconn, txtUsrNombre)
                PMChequea(sqlconn)
                Return True
            Else
                PMChequea(sqlconn)
            End If

        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return False

    End Function
    Private Function FLResIcon(ByVal pKey As String) As Image
        Dim VTPicture As Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetIcon(VGResourceManager, pKey).ToBitmap()
        Return VTPicture
    End Function
    Private Function FLStyle(ByVal parFormat As String) As Short
        Select Case parFormat
            Case "yyyy/MM/dd", "yyyy/mm/dd" : Return 111
            Case "dd-MM-yyyy", "dd-mm-yyyy" : Return 105
            Case "dd/MM/yyyy", "dd/mm/yyyy" : Return 103
            Case "MM/dd/yyyy", "mm/dd/yyyy" : Return 101
            Case Else : Return 0
        End Select
    End Function
#End Region

#Region "Grid"
    Private Sub PLIniciarGrid()
        With grdTransacciones
            .MaxCols = 0
            .MaxRows = 0
            .OperationMode = Framework.UI.Components.OperationModeConstants.OperationModeSingle
            .UserResize = Framework.UI.Components.UserResizeConstants.UserResizeColumns
            '.SelectionBlockOptions = FarPoint.Win.Spread.SelectionBlockOptions.Rows
            '.SetOddEvenRowColor(&HEFEFEF, &H80000008, &HF7F7F7, &H80000008)
            .ScrollBarExtMode = True
        End With
    End Sub
    Private Sub PLEliminarCol()
        With grdTransacciones
            .Col = 1
            .Col2 = 1
            .Row = 1
            .Row2 = .MaxRows
            .BlockMode = True
            .Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionDeleteCol
            .MaxCols -= 1
            .BlockMode = False
        End With
    End Sub
    Private Sub PLAumentarIconos()

        With grdTransacciones
            .Col = 1
            .MaxCols = .MaxCols + 1
            .Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionInsertCol
            .set_ColWidth(1, 250)

            For VTi As Integer = 1 To .MaxRows
                Dim VTResIcon As String
                .Row = VTi
                .Col = CLColEst

                If .Text = "R" Then
                    VTResIcon = "ico31136"
                Else
                    VTResIcon = "ico31134"
                End If

                .Col = 1
                .CellType = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypePicture
                .TypePictPicture = FLResIcon(VTResIcon)
                .TypePictCenter = True
                .TypePictStretch = False
                .TypePictMaintainScale = False
            Next

        End With

    End Sub
    Private Sub PLGridCabecera()
        With grdTransacciones
            .Row = 0
            .Col = CLColIco
            .Text = " "
            .Col = CLColTrn
            .Text = FMLoadResString(509542)
            .Col = CLColDes
            .Text = FMLoadResString(502470)
            .Col = CLColFec
            .Text = FMLoadResString(9002)
            .Col = CLColHor
            .Text = FMLoadResString(9003)
            .Col = CLColEst
            .Text = FMLoadResString(9019)
            .Col = CLColSec
            .Text = FMLoadResString(9025)
            .Col = CLColSeB
            .Text = FMLoadResString(9025)
            .Col = CLColSeA
            .Text = FMLoadResString(503216)
            .Col = CLColMon
            .Text = FMLoadResString(509190)
            .Col = CLColCta
            .Text = FMLoadResString(508948)
            .Col = CLColNom
            .Text = FMLoadResString(9940)
            .Col = CLColTot
            .Text = FMLoadResString(509543)
            .Col = CLColEfe
            .Text = FMLoadResString(509544)
            .Col = CLColChP
            .Text = FMLoadResString(509545)
            .Col = CLColChL
            .Text = FMLoadResString(509546)
            .Col = CLColChR
            .Text = FMLoadResString(509547)
            .Col = CLColUsr
            .Text = FMLoadResString(9017)
        End With
    End Sub
    Private Sub PLOcultarColumnas()
        With grdTransacciones
            .Col = CLColFec
            .ColHidden = True
            .Col = CLColEst
            .ColHidden = True
            .Col = CLColSeB
            .ColHidden = True
            .Col = CLColChP
            .ColHidden = True
            .Col = CLColChR
            .ColHidden = True
            .set_ColWidth(CLColCta, 1500)
        End With
    End Sub
    Private Sub PLFormatoCuenta()
        With grdTransacciones
            For VTi As Integer = 1 To .MaxRows
                .Row = VTi
                .Col = CLColCta
                If .Text.IndexOf("-") = -1 Then .Text = FMMascara(.Text, VGMascaraCtaAho)
            Next
        End With
    End Sub
    Private Sub PLLimpiarGrid()
        grdTransacciones.MaxCols = 0
        grdTransacciones.MaxRows = 0
    End Sub
#End Region

#Region "Inicializar"
    Private Sub PLLimpiarCampos()
        Me.PLLimpiarCriterios()
        Me.PLLimpiarTransacciones()
    End Sub
    Private Sub PLLimpiarCriterios()
        ugbBuscar.Enabled = True
        chkUsuario.Checked = False
        Me.PLLimpiarUsuario()
        chkSecuencial.Checked = False
        Me.PLLimpiarSecuencial()
        chkNemonico.Checked = False
        Me.PLLimpiarNemonico()
        chkHora.Checked = False
        Me.PLLimpiarHora()
        chkValor.Checked = False
        Me.PLLimpiarValor()
        chkCuenta.Checked = False
        Me.PLLimpiarCuenta()
        chkMoneda.Checked = False
        Me.PLLimpiarMoneda()
    End Sub
    Private Sub PLLimpiarUsuario()
        pnlUsuario.Visible = False
        txtUsrCodigo.Text = ""
        txtUsrNombre.Text = ""
    End Sub
    Private Sub PLLimpiarSecuencial()
        pnlSecuencial.Visible = False
        txtSecIni.Text = ""
        txtSecFin.Text = ""
    End Sub
    Private Sub PLLimpiarNemonico()
        pnlNemonico.Visible = False
        txtNemonico.Text = ""
    End Sub
    Private Sub PLLimpiarHora()
        pnlHora.Visible = False
        mskHoraIni.Text = ""
        mskHoraFin.Text = ""
    End Sub
    Private Sub PLLimpiarValor()
        pnlValor.Visible = False
        mskValorIni.Text = "0.00"
        mskValorFin.Text = "0.00"
    End Sub
    Private Sub PLLimpiarCuenta()
        pnlCuenta.Visible = False
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        txtNomCuenta.Text = ""
    End Sub
    Private Sub PLLimpiarMoneda()
        pnlMoneda.Visible = False
        txtCodMoneda.Text = ""
        txtNomMoneda.Text = ""
    End Sub
    Private Sub PLLimpiarTransacciones()
        Me.PLLimpiarGrid()
    End Sub
    Private Sub PLIniForm()
        Me.PLIniVar()
        Me.PLHabilitaBotones("I")
        Me.PLLimpiarCampos()
        grdTransacciones.Focus()
    End Sub
    Private Sub PLIniVar()
        VLPaso = False
    End Sub
#End Region

End Class
