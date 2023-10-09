Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTranUpGMFClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLFormatoFechaMar As String = ""
    Dim VLTipoPer As String = ""
    Dim VLUnicTit As String = ""
    Dim VLProducto_ac As String = ""
    Dim VLNatTit As String = ""
    Dim VLContCoTit As Integer = 0
    Dim VLMarcar As String = ""
    Dim VLPermisoMarcar As Boolean = False
    Dim VLPermisoDesmarcar As Boolean = False
    Dim VLFormatoFecha As String = ""

    Private Sub cmbTipo_Enter(sender As Object, e As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5048))
    End Sub

    Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If cmbTipo.Text = FMLoadResString(502554) Then
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        Else
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        End If
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 1
                PLBuscar()
            Case 2
                FRTACIFIN.Show(Me)
            Case 3
                PLLimpiar()
            Case 4
                Me.Close()
            Case 5
                VLMarcar = "S"
                PLTransmitir()
                PLBuscar()
            Case 6
                VLMarcar = "N"
                PLTransmitir()
                PLBuscar()
        End Select
    End Sub

    Private Sub FTranUpGMF_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_1.Enabled
        TSBBuscar.Visible = _cmdBoton_1.Visible
        TSBRtaCifin.Enabled = _cmdBoton_2.Enabled
        TSBRtaCifin.Visible = _cmdBoton_2.Visible
        TSBMarcar.Enabled = _cmdBoton_5.Enabled
        TSBMarcar.Visible = _cmdBoton_5.Visible
        TSBDesmarcar.Enabled = _cmdBoton_6.Enabled
        TSBDesmarcar.Visible = _cmdBoton_6.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBRtaCifin_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBRtaCifin.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBMarcar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBMarcar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBDesmarcar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBDesmarcar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Public Sub PLInicializar()
        PMObjetoSeguridad(Me.cmdBoton(5))
        VLPermisoMarcar = Me.cmdBoton(5).Enabled
        PMObjetoSeguridad(Me.cmdBoton(6))
        VLPermisoDesmarcar = Me.cmdBoton(6).Enabled
        cmbTipo.Items.Insert(0, FMLoadResString(502554))
        cmbTipo.Items.Insert(1, FMLoadResString(502555))
        cmbTipo.SelectedIndex = 1
        FMLoadResString(2525)
        If cmbTipo.Text = FMLoadResString(502554) Then
            mskCuenta.Mask = VGMascaraCtaCte
        Else
            mskCuenta.Mask = VGMascaraCtaAho
        End If
        cmbTipo.Enabled = False
        VLProducto_ac = New String(" "c, 0)
        VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
        VLFormatoFechaMar = VLFormatoFecha
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub PLBuscar()
        Dim VTArreglo(8) As String
        If mskCuenta.ClipText <> "" Then
            If cmbTipo.Text = FMLoadResString(502554) Then
                If FMChequeaCtaCte(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VLMarcar)
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2747")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_upd_gmf_cc", True, FMLoadResString(503281)) Then
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblDescripcion(0).Text = VTArreglo(1)
                        VLNatTit = VTArreglo(7)
                        VLContCoTit = CInt(VTArreglo(8))
                        VLProducto_ac = "3"
                        If VTArreglo(2) = "S" Then
                            lblFecMarca.Text = StringsHelper.Format(VTArreglo(3), VLFormatoFechaMar)
                            txtCampo(12).Text = VTArreglo(4)
                            txtCampo_Leave(txtCampo(12), New EventArgs())
                            lblDescripcion(14).Text = VTArreglo(5)
                        End If
                        If VTArreglo(2) = "N" Then
                            txtCampo(12).Text = VTArreglo(4)
                            txtCampo_Leave(txtCampo(12), New EventArgs())
                            txtCampo(12).Enabled = False
                            lblFecMarca.Text = StringsHelper.Format(VTArreglo(3), VLFormatoFechaMar)
                            lblDescripcion(14).Text = VTArreglo(5)
                        End If
                        cmdBoton(2).Enabled = True
                    Else
                        PMChequea(sqlconn)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(0).Text = ""
                        If mskCuenta.Enabled Then
                            mskCuenta.Focus()
                        End If
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501391), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(0).Text = ""
                    If mskCuenta.Enabled Then
                        mskCuenta.Focus()
                    End If
                    Exit Sub
                End If
            Else
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4106")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_upd_gmf_ac", True, FMLoadResString(503281)) Then
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        VLProducto_ac = "4"
                        lblDescripcion(0).Text = VTArreglo(1)
                        VLNatTit = VTArreglo(7)
                        VLContCoTit = CInt(VTArreglo(8))
                        lblDescripcion(2).Text = FMLoadResString(503283)
                        cmdBoton(2).Enabled = False
                        If VTArreglo(17) = "S" Then
                            cmdBoton(2).Enabled = True
                        End If
                        If VTArreglo(2) <> "" Then
                            If VTArreglo(2) = "S" Then
                                lblDescripcion(2).Text = FMLoadResString(503284)
                                txtCampo(12).Enabled = False
                                cmdBoton(5).Enabled = False
                                cmdBoton(6).Enabled = VLPermisoDesmarcar
                                If VTArreglo(3).Trim() <> "" Then
                                    lblFecMarca.Text = StringsHelper.Format(VTArreglo(3), VLFormatoFechaMar)
                                    txtCampo(12).Text = VTArreglo(4)
                                    txtCampo_Leave(txtCampo(12), New EventArgs())
                                    lblDescripcion(14).Text = VTArreglo(5)
                                    lblOfiMarca.Text = VTArreglo(9)
                                    lblOficinaMarca.Text = VTArreglo(11)
                                    lblFecDesm.Text = ""
                                    lblDescripcion(1).Text = ""
                                    lblOfiDesmarca.Text = ""
                                    lblOficinaDesm.Text = ""
                                End If
                            Else
                                lblDescripcion(2).Text = FMLoadResString(503283)
                                txtCampo(12).Enabled = True
                                cmdBoton(5).Enabled = VLPermisoMarcar
                                cmdBoton(6).Enabled = False
                                If VTArreglo(3).Trim() <> "" Then
                                    lblFecMarca.Text = ""
                                    txtCampo(12).Text = ""
                                    txtdescripcion.Text = ""
                                    lblDescripcion(14).Text = ""
                                    lblOfiMarca.Text = ""
                                    lblOficinaMarca.Text = ""
                                    lblFecDesm.Text = StringsHelper.Format(VTArreglo(13), VLFormatoFechaMar)
                                    lblDescripcion(1).Text = VTArreglo(14)
                                    lblOfiDesmarca.Text = VTArreglo(15)
                                    lblOficinaDesm.Text = VTArreglo(16)
                                End If
                            End If
                        End If
                    Else
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(3), New EventArgs())
                        lblDescripcion(0).Text = ""
                        If mskCuenta.Enabled Then
                            mskCuenta.Focus()
                        End If
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(503285), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(0).Text = ""
                    If mskCuenta.Enabled Then
                        mskCuenta.Focus()
                    End If
                    Exit Sub
                End If
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        cmbTipo.SelectedIndex = 1
        If cmbTipo.Text = FMLoadResString(502554) Then
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        Else
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        End If
        txtCampo(12).Text = ""
        txtdescripcion.Text = ""
        lblDescripcion(14).Text = ""
        lblDescripcion(0).Text = ""
        lblFecMarca.Text = ""
        cmdBoton(2).Enabled = False
        lblOfiMarca.Text = ""
        lblOficinaMarca.Text = ""
        lblFecDesm.Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        lblOfiDesmarca.Text = ""
        lblOficinaDesm.Text = ""
        cmdBoton(5).Enabled = False
        cmdBoton(6).Enabled = False
        mskCuenta.Focus()
        PLTSEstado()
    End Sub

    Private Sub PLTransmitir()
        If cmbTipo.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503286), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If mskCuenta.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503287), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
        If VLMarcar = "S" And txtCampo(12).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503288), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(12).Focus()
            Exit Sub
        End If
        If VLTipoPer <> "Y" And VLMarcar = "S" Then
            If VLTipoPer <> VLNatTit Then
                COBISMessageBox.Show(FMLoadResString(503289), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        If VLUnicTit = "S" And VLMarcar = "S" Then
            If VLContCoTit > 1 Then
                COBISMessageBox.Show(FMLoadResString(503290), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        If mskCuenta.Text = "" Or mskCuenta.Text = "_-____-_-_____-_" Then
            COBISMessageBox.Show(FMLoadResString(503291), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_gmfmarca", 0, SQLCHAR, VLMarcar)
        PMPasoValores(sqlconn, "@i_fecmarca", 0, SQLDATETIME, FMConvFecha(lblFecMarca.Text, VLFormatoFecha, "mm/dd/yyyy"))
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLINT2, txtCampo(12).Text)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, txtdescripcion.Text)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2747")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_upd_gmf_cc", True, FMLoadResString(503292)) Then
                cmdBoton(2).Enabled = False
            End If
        Else
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4106")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_upd_gmf_ac", True, FMLoadResString(503292)) Then
                cmdBoton(2).Enabled = False
            End If
        End If
        PMChequea(sqlconn)
        If FMRetStatus(sqlconn) = 0 Then
            If VLMarcar = "S" Then
                COBISMessageBox.Show(FMLoadResString(503293), My.Application.Info.ProductName)
            Else
                COBISMessageBox.Show(FMLoadResString(503294), My.Application.Info.ProductName)
            End If
            FRTACIFIN.Show(Me)
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_12.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_12.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 12
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2456))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_12.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VGOperacion = ""
            Select Case Index
                Case 12
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "F")
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4105")
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT2, "0")
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto_ac)
                    VGOperacion = "sp_exencion"
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_calcula_gmf", True, FMLoadResString(503295)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(12).Text = VGACatalogo.Codigo
                        txtdescripcion.Text = VGACatalogo.Descripcion
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn)
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_12.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 12
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_12.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTArreglo(5) As String
        Select Case Index
            Case 12
                If txtCampo(12).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "B")
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4105")
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT2, txtCampo(12).Text)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto_ac)
                    FMLoadResString(2525)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_calcula_gmf", True, FMLoadResString(503295)) Then
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        txtdescripcion.Text = VTArreglo(1)
                        VLTipoPer = VTArreglo(2)
                        VLUnicTit = VTArreglo(3)
                    Else
                        PMChequea(sqlconn)
                        txtdescripcion.Text = ""
                        txtCampo(12).Text = ""
                        txtCampo(12).Focus()
                    End If
                Else
                    txtdescripcion.Text = ""
                End If
        End Select
    End Sub

    Private Sub mskCuenta_Leave(sender As Object, e As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


