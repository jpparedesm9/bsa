Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost

Partial Public Class FCaracteristicasClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0
    Dim VTFinal As Integer = 0
    Dim VLTipoR As String = ""
    Public VTProFinal As String = ""
    Public VGSUCURSAL As String = ""

    Private Sub FCaracteristicasclass_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        _txtCampo_4.Enabled = False
        _optBoton_0.Focus()
        PLConsultar()
        PLPbancario()
        ConsultaRangoFechas()
    End Sub

    Private Sub TSBSalir_Click(sender As Object, e As EventArgs) Handles TSBSalir.Click
        Me.Close()
    End Sub
    Private Sub PLLimpiar()
        PLConsultar()
        _txtCampo_1.Text = ""
        _txtCampo_4.Text = ""
        _txtCampo_4.Enabled = False
        _lblDescripcion_3.Text = ""
        chkproducto.Checked = False
        _lblDescripcion_6.Text = ""


    End Sub

    Private Sub TSBLlimpiar_Click(sender As Object, e As EventArgs) Handles TSBLlimpiar.Click
        PLLimpiar()
    End Sub





    Private Sub chkproducto_CheckStateChanged(sender As Object, e As EventArgs) Handles chkproducto.CheckStateChanged
        If chkproducto.CheckState = CheckState.Checked Then
            PLHabilitarProducto(True)
            _txtCampo_4.Focus()
        Else
            PLHabilitarProducto(False)
            _txtCampo_4.Text = ""
            _lblDescripcion_6.Text = ""
        End If
    End Sub

    Public Sub PLHabilitarProducto(ByRef valor As Boolean)
        If valor Then
            _txtCampo_4.Enabled = True
        Else
            _txtCampo_4.Enabled = False
        End If

    End Sub

    Private Sub _txtCampo_1_Enter(sender As Object, e As EventArgs) Handles _txtCampo_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502095))
    End Sub

    Private Sub _txtCampo_4_Enter(sender As Object, e As EventArgs) Handles _txtCampo_4.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502096))

    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_4.KeyDown, _txtCampo_1.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTFilas As Integer = 0
        Dim VTProFinal1 As String = ""
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 1
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "732")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_fechas", True, FMLoadResString(2468)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(1).Text = VGACatalogo.Codigo
                        _lblDescripcion_3.Text = VGACatalogo.Descripcion

                    Else
                        PMChequea(sqlconn)
                    End If

                Case 4
                    VLPaso = True
                    VTFilas = VGMaxRows
                    VTProFinal1 = "0"
                    VGOperacion = "sp_prodfin3"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, VGSUCURSAL)
                        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal1)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1112)) Then
                            If VTProFinal1 = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMAnchoColumnasGrid(FRegistros.grdRegistros)
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTProFinal1 = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            PMChequea(sqlconn)
                            txtCampo(4).Text = ""
                            _lblDescripcion_6.Text = ""
                            VGOperacion = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(4).Text = VGValores(1)
                        _lblDescripcion_6.Text = VGValores(2)
                        VLPaso = True
                    Else
                        txtCampo(4).Text = ""
                        _lblDescripcion_6.Text = ""
                        VGOperacion = ""
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
            End Select
        End If


    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_4.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            Case 1, 4
                KeyAscii = FMValidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)

        If txtCampo(1).Text = "" Then
            _lblDescripcion_3.Text = ""
        End If
    End Sub



    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Leave, _txtCampo_1.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                If txtCampo(1).Text <> "" Then

                    If CDbl(txtCampo(1).Text) > 100 Then
                        COBISMessageBox.Show(FMLoadResString(502037), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Text = ""
                        txtCampo(1).Focus()
                        _lblDescripcion_3.Text = ""
                        Exit Sub
                    End If

                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "732")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, _txtCampo_1.Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_fechas", True, FMLoadResString(2468)) Then
                        PMMapeaObjeto(sqlconn, _lblDescripcion_3)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        txtCampo(1).Text = ""
                        _lblDescripcion_6.Text = ""
                        txtCampo(1).Focus()

                    End If
                Else
                    _lblDescripcion_3.Text = ""
                End If
            Case 4
                If txtCampo(4).Text <> "" Then
                    If CDbl(txtCampo(4).Text) > 32000 Then
                        COBISMessageBox.Show(FMLoadResString(502039), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(4).Text = ""
                        txtCampo(4).Focus()
                        _lblDescripcion_6.Text = ""
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4077")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, VGSUCURSAL)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(4).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1112)) Then

                        Dim VTArreglo(3) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        _lblDescripcion_6.Text = VTArreglo(1)
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar()
                        txtCampo(1).Focus()
                        VLPaso = True
                    End If
                Else
                    _lblDescripcion_6.Text = ""
                End If



        End Select
    End Sub

    Private Sub ConsultaRangoFechas()

        If _txtCampo_1.Text <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "732")
            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, _txtCampo_1.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_fechas", True, FMLoadResString(2468)) Then
                PMMapeaObjeto(sqlconn, _lblDescripcion_3)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)


            End If
        End If

    End Sub
    Private Sub PLConsultar()
        Dim VTR1 As Integer = 0
        Dim VTArreglo(3) As String

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "425")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_caradicionales", True, FMLoadResString(2467)) Then
            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            If Not (VTArreglo(1) Is "" And VTArreglo(2) Is "" And VTArreglo(3) Is "") Then
                If VTArreglo(1) = "S" Then
                    _optBoton_0.Checked = True
                Else
                    _optBoton_1.Checked = True
                End If
                If _txtCampo_4.Text <> "" Then
                    chkproducto.Checked = True
                End If
                _txtCampo_1.Text = VTArreglo(3)
                _txtCampo_4.Text = VTArreglo(2)
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub
    Private Sub PLPbancario()
        If txtCampo(4).Text <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, VGSUCURSAL)
            PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(4).Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1112)) Then
                Dim VTArreglo(3) As String
                FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                _lblDescripcion_6.Text = VTArreglo(1)

                If txtCampo(4).Text <> "" Then
                    chkproducto.Checked = True
                End If
                '    PMBusca_Datos()
            Else
                PMChequea(sqlconn)
                PLLimpiar()
                txtCampo(4).Focus()
                VLPaso = True
            End If






        End If
    End Sub

    Private Sub PLActualizar()
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502040), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            chkproducto.Checked = False
            Exit Sub
        End If

        If CDbl(txtCampo(1).Text) > 100 Then
            COBISMessageBox.Show(FMLoadResString(502037), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Text = ""
            txtCampo(1).Focus()
            _lblDescripcion_3.Text = ""
            Exit Sub
        End If

        If chkproducto.Checked = True And txtCampo(4).Text = "" Then
            COBISMessageBox.Show("Debe Ingresar el Producto Final", FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub

        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "426")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        If _optBoton_0.Checked = True Then
            PMPasoValores(sqlconn, "@i_provisiona", 0, SQLCHAR, "S")
        Else
            PMPasoValores(sqlconn, "@i_provisiona", 0, SQLCHAR, "N")
        End If
        PMPasoValores(sqlconn, "@i_depende", 0, SQLINT4, _txtCampo_4.Text)
        PMPasoValores(sqlconn, "@i_cod_rango_edad", 0, SQLINT4, _txtCampo_1.Text)
        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_caradicionales", True, FMLoadResString(2511)) Then
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(502036), FMLoadResString(501547), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            PLLimpiar()
            FCaracteristicas.Close()
        Else
            PMChequea(sqlconn)

        End If


    End Sub

    Private Sub optBoton_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)

        Select Case Index
            Case 0
                VLTipoR = 1
                optBoton(1).Checked = False
            Case 1
                VLTipoR = 0
                optBoton(0).Checked = False

        End Select


    End Sub

    Private Sub TSBTransmitir_Click(sender As Object, e As EventArgs) Handles TSBTransmitir.Click
        PLActualizar()
    End Sub

    Private Sub _optBoton_0_CheckedChanged(sender As Object, e As EventArgs) Handles _optBoton_0.CheckedChanged

    End Sub

    Private Sub _txtCampo_1_RightToLeftChanged(sender As Object, e As EventArgs) Handles _txtCampo_1.RightToLeftChanged

    End Sub

    Private Sub _txtCampo_1_SystemColorsChanged(sender As Object, e As EventArgs) Handles _txtCampo_1.SystemColorsChanged

    End Sub

    Private Sub _txtCampo_1_TextChanged(sender As Object, e As EventArgs) Handles _txtCampo_1.TextChanged
        If txtCampo(1).Text = "" Then
            _lblDescripcion_3.Text = ""
        End If
    End Sub

    Private Sub _txtCampo_4_TextChanged(sender As Object, e As EventArgs) Handles _txtCampo_4.TextChanged
        If txtCampo(4).Text = "" Then
            _lblDescripcion_6.Text = ""
        End If
    End Sub

    Private Sub _optBoton_0_Enter(sender As Object, e As EventArgs) Handles _optBoton_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502108))
    End Sub

    Private Sub _optBoton_0_Leave(sender As Object, e As EventArgs) Handles _optBoton_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502108))
    End Sub

    Private Sub _optBoton_1_CheckedChanged(sender As Object, e As EventArgs) Handles _optBoton_1.CheckedChanged
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502108))
    End Sub

    Private Sub _optBoton_1_Enter(sender As Object, e As EventArgs) Handles _optBoton_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502108))
    End Sub

    Private Sub _optBoton_1_Leave(sender As Object, e As EventArgs) Handles _optBoton_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502108))
    End Sub

 

    Private Sub chkproducto_Enter(sender As Object, e As EventArgs) Handles chkproducto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502097))
    End Sub
End Class