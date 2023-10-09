Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost
 Public  Partial  Class FParComClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VTValido As Integer = 0
    Dim VLNumTranValido As Boolean = True
    Dim VTFechaValida As Boolean = True

    Private Sub cmbEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1333))
    End Sub

    Private Sub cmbEstado_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles cmbEstado.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = 0
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_8.Enter, _cmdBoton_6.Enter, _cmdBoton_7.Enter, _cmdBoton_3.Enter, _cmdBoton_0.Enter, _cmdBoton_4.Enter, _cmdBoton_1.Enter, _cmdBoton_5.Enter, _cmdBoton_2.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1125))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1435))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1697))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1313))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1013))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1030))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1126))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1014))
            Case 8
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1315))
        End Select
    End Sub

    Private Sub FParCom_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMBotonSeguridad(Me, 5)
        PMObjetoSeguridad(cmdBoton(5))
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        PMObjetoSeguridad(cmdBoton(3))
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        Dim VLFormatoFecha As String = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        cmbEstado.Items.Insert(0, "V")
        cmbEstado.Items.Insert(1, "C")
        cmbEstado.SelectedIndex = 0
        mskFecha.Text = VGFechaProceso
        'COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1346))
        PLTSEstado()
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1371) & "[" & VGFormatoFecha & "]")
        mskFecha.SelectionStart = 0
        mskFecha.SelectionLength = Strings.Len(mskFecha.Text)
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave

        Dim VTValido1 As String = String.Empty
        Dim VTValido2 As String = String.Empty
        Dim VGFechaProceso As String = String.Empty
        If Not VLPaso Then
            If mskFecha.ClipText <> "" Then
                VTValido = FMVerFormato(mskFecha.Text, VGFormatoFecha)
                If Not VTValido Then
                    COBISMessageBox.Show(FMLoadResString(1378), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    mskFecha.Focus()
                    Exit Sub
                End If
                VTValido1 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
                VTValido2 = StringsHelper.Format(VGFecha, VGFormatoFecha)
                If FMDateDiff("d", VTValido1, VTValido2, VGFormatoFecha) > 0 Then
                    mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                    'COBISMessageBox.Show(FMLoadResString(1373) & VGFechaProceso, My.Application.Info.ProductName)
                    COBISMessageBox.Show(FMLoadResString(1373), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                    Exit Sub
                End If
                VTFechaValida = False
            End If
        End If
        VLPaso = True
    End Sub

    Private Sub mskMonto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskMonto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1484))
    End Sub

    Private Sub mskMonto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskMonto.Enter
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii < 48 And KeyAscii <> 8 And KeyAscii <> 9 And KeyAscii <> 46) Or KeyAscii > 57 Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Change(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Change, _txtCampo_2.Change, _txtCampo_3.Change, _txtCampo_1.Change, _txtCampo_4.Change
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                VLPaso = False

            Case 4
                If txtCampo(4).Text = "T" Then
                    txtTotTrans.Enabled = True
                    txtDebito.Enabled = False
                    txtCredito.Enabled = False
                    txtConsulta.Enabled = False
                    FraTransaccion.Enabled = False
                ElseIf txtCampo(4).Text = "C" Then
                    txtTotTrans.Enabled = False
                    txtDebito.Enabled = True
                    txtCredito.Enabled = True
                    txtConsulta.Enabled = True
                    FraTransaccion.Enabled = False
                ElseIf txtCampo(4).Text = "M" Then
                    txtTotTrans.Enabled = False
                    txtDebito.Enabled = False
                    txtCredito.Enabled = False
                    txtConsulta.Enabled = False
                    FraTransaccion.Enabled = False
                ElseIf txtCampo(4).Text = "W" Then
                    txtTotTrans.Enabled = False
                    txtDebito.Enabled = False
                    txtCredito.Enabled = False
                    txtConsulta.Enabled = False
                    txtCanal.Enabled = True
                    txtCampo(0).Enabled = True
                    txtCausal.Enabled = True
                    txtNumTrn.Enabled = True
                    mskMonto.Enabled = True
                    FraTransaccion.Enabled = True
                End If
                If txtCampo(4).Text = "T" Or txtCampo(4).Text = "C" Or txtCampo(4).Text = "M" Then
                    txtCanal.Clear() : lblDesCanal.Text = ""
                    txtCampo(0).Clear() : lblDescripcion(0).Text = ""
                    txtCausal.Clear() : lblDesCausal.Text = ""
                    txtNumTrn.Clear()
                    mskMonto.Clear()
                End If
                VLPaso = False
                txtTotTrans.Text = ""
                txtDebito.Text = ""
                txtCredito.Text = ""
                txtConsulta.Text = ""
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_4.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1791))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1163))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1153))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1767))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1054))
        End Select
    End Sub

    Private Sub txtCampo_KeyDownEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_4.KeyDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTFilas As Integer = 0
        Dim VTProFinal As String = String.Empty
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    txtCausal.Text = ""
                    lblDesCausal.Text = ""
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "pe_transaccion")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1103) & "[" & txtCampo(4).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                        txtCausal.Enabled = IIf(txtCampo(0).Text = "253" Or txtCampo(0).Text = "264", True, False)
                        txtCausal.Focus()
                        If txtCampo(0).Text <> "" Then
                            txtCampo(0).Focus()
                        End If
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Focus()
                    End If
                Case 1
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(1).Text = VGValores(1)
                            lblDescripcion(1).Text = VGValores(2)
                            txtCampo(2).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(3).Text = ""
                            lblDescripcion(3).Text = ""
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(1).Text = ""
                            PLLimpiar()
                            VGOperacion = ""
                        End If
                        VLPaso = True
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        VGOperacion = ""
                    End If
                Case 2
                    If txtCampo(1).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1417), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    VTFilas = VGMaxRows
                    VTProFinal = "0"
                    VGOperacion = "sp_prodfin3"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                            If VTProFinal = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMAnchoColumnasGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTProFinal = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(2).Text = ""
                            VGOperacion = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(2).Text = VGValores(1)
                        lblDescripcion(2).Text = VGValores(2)
                        txtCampo(3).Text = String.Empty
                        lblDescripcion(3).Text = String.Empty
                        VLPaso = True
                    Else
                        txtCampo(2).Text = ""
                        lblDescripcion(2).Text = ""
                        VGOperacion = ""
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 3
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "N")
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1545)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(3).Text = VGACatalogo.Codigo
                        lblDescripcion(3).Text = VGACatalogo.Descripcion
                        If txtCampo(3).Text <> "" Then
                            txtCampo(3).Focus()
                        End If
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(3).Text = ""
                        lblDescripcion(3).Text = ""
                        txtCampo(3).Focus()
                    End If
                Case 4
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "pe_tipo_cobro")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1103) & "[" & txtCampo(4).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(4).Text = VGACatalogo.Codigo
                        lblDescripcion(4).Text = VGACatalogo.Descripcion
                        If txtCampo(4).Text <> "" Then
                            txtCampo(4).Focus()
                        End If
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(4).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(4).Focus()
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(sender As Object, e As KeyPressEventArgs) Handles _txtCampo_0.KeyPress

    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_4.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then
                    txtCampo(0).Text = txtCampo(0).Text.Trim()
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "pe_transaccion")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(0).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1103) & "[" & txtCampo(4).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                            If txtCampo(0).Text = "253" Or txtCampo(0).Text = "264" Then
                                txtCausal.Enabled = True
                                txtCausal.Focus()
                            Else
                                txtCausal.Enabled = False
                                txtNumTrn.Focus()
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCampo(0).Focus()
                            VLPaso = True
                        End If
                    End If
                Else
                    txtCampo(0).Text = txtCampo(0).Text.Trim()
                End If
                If txtCampo(0).Text = "" And lblDescripcion(0).Text <> "" Then
                    lblDescripcion(0).Text = ""
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(3).Text = ""
                            lblDescripcion(3).Text = ""
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(1).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                        txtCampo(1).SetFocus()
                        PLLimpiar()
                        VLPaso = True
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text.Trim() = "" Then
                        lblDescripcion(2).Text = ""
                        txtCampo(3).Clear()
                        lblDescripcion(3).Text = String.Empty

                        Exit Sub
                    End If
                    If txtCampo(1).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472),
                             COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Text = ""
                        txtCampo(1).Focus()
                        lblDescripcion(2).Text = ""

                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1112)) Then
                        Dim VTArreglo(3) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblDescripcion(2).Text = VTArreglo(1)
                        txtCampo(3).Clear()
                        lblDescripcion(3).Text = String.Empty
                    Else
                        PMChequea(sqlconn)
                        txtCampo(2).Text = ""
                        lblDescripcion(2).Text = ""
                        txtCampo(2).Focus()
                        txtCampo(3).Clear()
                        lblDescripcion(3).Text = String.Empty
                        'PLLimpiar()
                        VLPaso = True
                    End If
                End If
            Case 3
                If Not VLPaso Then
                    txtCampo(3).Text = txtCampo(3).Text.Trim()
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "N")
                        PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1545)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(3))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(3).Text = ""
                            txtCampo(3).SetFocus()
                            VLPaso = True
                        End If
                    End If
                Else
                    txtCampo(3).Text = txtCampo(3).Text.Trim()
                End If
                If txtCampo(3).Text = "" And lblDescripcion(3).Text <> "" Then
                    lblDescripcion(3).Text = ""
                    txtCampo(3).SetFocus()
                End If
            Case 4
                If Not VLPaso Then
                    txtCampo(4).Text = txtCampo(4).Text.Trim()
                    If txtCampo(4).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "pe_tipo_cobro")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(4).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1103) & "[" & txtCampo(4).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(4))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(4).Text = ""
                            lblDescripcion(4).Text = ""
                            txtCampo(4).SetFocus()
                            VLPaso = True
                        End If
                    End If
                Else
                    txtCampo(4).Text = txtCampo(4).Text.Trim()
                End If
                If txtCampo(4).Text = "" And lblDescripcion(4).Text <> "" Then
                    lblDescripcion(4).Text = ""
                    txtCampo(4).SetFocus()
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_8.Click, _cmdBoton_6.Click, _cmdBoton_7.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim Response As String = String.Empty
        Dim VLSucursal As String = String.Empty
        Dim VLProdFinal As String = String.Empty
        Dim VLCategoria As String = String.Empty
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
        TSBotones.Focus()
        Select Case Index
            Case 0, 6
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1250), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1276), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1430), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                    Exit Sub
                Else
                    If (VTFechaValida) Then
                        Exit Sub
                    End If
                End If
                If Index = 6 Then
                    If txtCampo(4).Text = "W" Then
                        If txtCampo(0).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1244), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                    End If
                    If txtCampo(4).Text = "W" Then
                        If txtNumTrn.Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1420), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtNumTrn.Focus()
                            Exit Sub
                        End If
                    End If
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4110")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_numtot", 0, SQLINT2, txtTotTrans.Text)
                PMPasoValores(sqlconn, "@i_numcre", 0, SQLINT2, txtCredito.Text)
                PMPasoValores(sqlconn, "@i_numdeb", 0, SQLINT2, txtDebito.Text)
                PMPasoValores(sqlconn, "@i_numco", 0, SQLINT2, txtConsulta.Text)
                PMPasoValores(sqlconn, "@i_fechavig", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, "mm/dd/yy"))
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, cmbEstado.Text)
                PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_numtrn", 0, SQLINT2, txtNumTrn.Text)
                PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, txtCausal.Text)
                PMPasoValores(sqlconn, "@i_canal", 0, SQLCHAR, txtCanal.Text)
                PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, mskMonto.Text)
                If Index = 6 Then
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "T")
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cobcom_profinal", True, FMLoadResString(1600)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    cmdBoton_Click(cmdBoton(5), New EventArgs())
                    PLTSEstado()
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                txtCampo(1).Enabled = True
                txtCampo(2).Enabled = True
                txtCampo(1).Text = ""
                txtCampo(4).Text = ""
                txtCampo(4).Enabled = True
                PLLimpiar()
                txtCampo(1).Focus()
            Case 2
                Me.Close()
            Case 3
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1250), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                cmdBoton(4).Enabled = False
                PMObjetoSeguridad(cmdBoton(0))
                Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1863) & (txtCampo(4).Text) & " - " & lblDescripcion(4).Text & "?", DgDef, FMLoadResString(1867)))
                PLTSEstado()
                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4112")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text)
                    PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, txtCausal.Text)
                    PMPasoValores(sqlconn, "@i_canal", 0, SQLCHAR, txtCanal.Text)
                    PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, mskMonto.Text)
                    If Index = 8 Then
                        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "T")
                    End If
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cobcom_profinal", True, FMLoadResString(1583)) Then
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = False
                        PLLimpiar()

                    Else
                        PMChequea(sqlconn)

                    End If
                    PLTSEstado()
                Else
                    cmdBoton(0).Enabled = False
                    cmdBoton(4).Enabled = True
                    PLTSEstado()
                    Exit Sub
                End If
            Case 8
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1178), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    grdParamTrans.Focus()
                    Exit Sub
                End If
                Response = CStr(COBISMsgBox.MsgBox("¿" & FMLoadResString(1864) & (txtCampo(0).Text) & " - " & lblDescripcion(0).Text & "?", DgDef, FMLoadResString(1867)))
                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    VLSucursal = txtCampo(1).Text
                    VLProdFinal = txtCampo(2).Text
                    VLCategoria = txtCampo(3).Text
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4112")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text)
                    PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "T")
                    PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, txtCausal.Text)
                    PMPasoValores(sqlconn, "@i_canal", 0, SQLCHAR, txtCanal.Text)
                    PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, mskMonto.Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cobcom_profinal", True, FMLoadResString(1583)) Then
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = False
                        PLLimpiar()
                        txtCampo(1).Text = VLSucursal
                        txtCampo_Leave(txtCampo(1), New EventArgs())
                        txtCampo(2).Text = VLProdFinal
                        txtCampo_Leave(txtCampo(2), New EventArgs())
                        txtCampo(3).Text = VLCategoria
                        txtCampo_Leave(txtCampo(3), New EventArgs())
                        cmdBoton_Click(cmdBoton(5), New EventArgs())
                        PLTSEstado()
                    Else
                        PMChequea(sqlconn)
                    End If

                Else
                    Exit Sub
                End If
            Case 4, 7
                If Not VTValido Then
                    If mskFecha.ClipText = "" Then
                        COBISMessageBox.Show(FMLoadResString(1430), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    End If
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1250), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1276), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If Index = 7 Then
                    If txtCampo(4).Text = "W" Then
                        If txtCampo(0).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1244), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                    End If
                    If txtCampo(4).Text = "W" Then
                        If txtNumTrn.Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1420), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtNumTrn.Focus()
                            Exit Sub
                        End If
                    End If
                End If
                cmdBoton(3).Enabled = False
                PLTSEstado()
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4111")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_numtot", 0, SQLINT2, txtTotTrans.Text)
                PMPasoValores(sqlconn, "@i_numcre", 0, SQLINT2, txtCredito.Text)
                PMPasoValores(sqlconn, "@i_numdeb", 0, SQLINT2, txtDebito.Text)
                PMPasoValores(sqlconn, "@i_numco", 0, SQLINT2, txtConsulta.Text)
                PMPasoValores(sqlconn, "@i_fechavig", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, cmbEstado.Text)
                PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_numtrn", 0, SQLINT2, txtNumTrn.Text)
                PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, txtCausal.Text)
                PMPasoValores(sqlconn, "@i_canal", 0, SQLCHAR, txtCanal.Text)
                PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, mskMonto.Text)
                If Index = 7 Then
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "T")
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cobcom_profinal", True, FMLoadResString(1611)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    cmdBoton_Click(cmdBoton(5), New EventArgs())
                    PLTSEstado()
                Else
                    PMChequea(sqlconn)
                End If
            Case 5
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4109")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, CStr(103))
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cobcom_profinal", True, FMLoadResString(1548)) Then
                    PMMapeaGrid(sqlconn, grdParamCobCom, False)
                    PMMapeaTextoGrid(grdParamCobCom)
                    PMAnchoColumnasGrid(grdParamCobCom)
                    PMAnchoColumnasGrid(grdParamCobCom)
                    PMMapeaGrid(sqlconn, grdParamTrans, False)
                    PMMapeaTextoGrid(grdParamTrans)
                    PMAnchoColumnasGrid(grdParamTrans)
                    PMAnchoColumnasGrid(grdParamTrans)
                    PMChequea(sqlconn)
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtNumTrn.Text = ""
                    txtCanal.Text = ""
                    lblDesCanal.Text = ""
                    txtCausal.Text = ""
                    lblDesCausal.Text = ""
                    mskMonto.Text = ""
                    lblDesCanal.Text = ""
                    lblDesCausal.Text = ""
                    lblDesEstado.Text = ""
                    lblEstado.Text = ""
                    txtCampo(1).Enabled = False
                    txtCampo(2).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub PLLimpiar()
        txtCampo(1).Enabled = True
        txtCampo(2).Enabled = True
        txtCampo(3).Enabled = True
        txtCampo(4).Text = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        txtCampo(4).Text = ""
        txtCampo(0).Clear() : txtCampo(0).Enabled = False
        lblDescripcion(0).Text = ""
        txtNumTrn.Clear() : txtNumTrn.Enabled = False
        txtTotTrans.Text = ""
        txtCredito.Text = ""
        txtDebito.Text = ""
        txtConsulta.Text = ""
        mskFecha.Mask = ""
        mskFecha.Text = ""
        mskMonto.Clear() : mskMonto.Enabled = False
        txtCanal.Clear() : txtCanal.Enabled = False
        txtCausal.Clear() : txtCausal.Enabled = False
        lblDesCanal.Text = ""
        lblDesCausal.Text = ""
        lblDesEstado.Text = ""
        lblEstado.Text = ""
        Dim VLFormatoFecha As String = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        mskFecha.Text = VGFechaProceso
        mskMonto.Text = ""
        txtTotTrans.Clear() : txtTotTrans.Enabled = False
        txtDebito.Clear() : txtDebito.Enabled = False
        txtCredito.Clear() : txtCredito.Enabled = False
        txtConsulta.Clear() : txtConsulta.Enabled = False

        For i As Integer = 1 To 4
            lblDescripcion(i).Text = ""
        Next i
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(String.Empty)
        PMObjetoSeguridad(cmdBoton(0))
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        grdParamCobCom.Rows = 2
        grdParamCobCom.Cols = 2
        grdParamCobCom.Row = 0
        grdParamCobCom.Col = 1
        grdParamCobCom.CtlText = ""
        grdParamCobCom.Row = 1
        grdParamCobCom.Col = 0
        grdParamCobCom.CtlText = ""
        grdParamCobCom.Col = 1
        grdParamCobCom.CtlText = ""
        grdParamTrans.Rows = 2
        grdParamTrans.Cols = 2
        grdParamTrans.Row = 0
        grdParamTrans.Col = 1
        grdParamTrans.CtlText = ""
        grdParamTrans.Row = 1
        grdParamTrans.Col = 0
        grdParamTrans.CtlText = ""
        grdParamTrans.Col = 1
        grdParamTrans.CtlText = ""
        cmbEstado.SelectedIndex = 0
        PLTSEstado()
    End Sub

    Private Sub FParCom_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(String.Empty)
    End Sub

    Private Sub grdParamCobCom_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdParamCobCom.ClickEvent
        grdParamCobCom.Col = 0
        grdParamCobCom.SelStartCol = 1
        grdParamCobCom.SelEndCol = grdParamCobCom.Cols - 1
        If grdParamCobCom.Row = 0 Then
            grdParamCobCom.SelStartRow = 1
            grdParamCobCom.SelEndRow = 1
        Else
            grdParamCobCom.SelStartRow = grdParamCobCom.Row
            grdParamCobCom.SelEndRow = grdParamCobCom.Row
        End If
    End Sub

    Private Sub grdParamCobCom_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdParamCobCom.DblClick
        Dim VTRow As Integer = grdParamCobCom.Row
        grdParamCobCom.Row = 1
        grdParamCobCom.Col = 1
        If grdParamCobCom.CtlText <> "" Then
            grdParamCobCom.Row = VTRow
            PMMarcarRegistro()
        End If
        cmdBoton_Click(cmdBoton(5), New EventArgs())
    End Sub

    Private Sub grdParamCobCom_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdParamCobCom.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
    End Sub

    Private Sub grdParamCobCom_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdParamCobCom.KeyUp
        grdParamCobCom.Col = 0
        grdParamCobCom.SelStartCol = 1
        grdParamCobCom.SelEndCol = grdParamCobCom.Cols - 1
        If grdParamCobCom.Row = 0 Then
            grdParamCobCom.SelStartRow = 1
            grdParamCobCom.SelEndRow = 1
        Else
            grdParamCobCom.SelStartRow = grdParamCobCom.Row
            grdParamCobCom.SelEndRow = grdParamCobCom.Row
        End If
    End Sub

    Private Sub grdParamTrans_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdParamTrans.ClickEvent
        grdParamTrans.Col = 0
        grdParamTrans.SelStartCol = 1
        grdParamTrans.SelEndCol = grdParamTrans.Cols - 1
        If grdParamTrans.Row = 0 Then
            grdParamTrans.SelStartRow = 1
            grdParamTrans.SelEndRow = 1
        Else
            grdParamTrans.SelStartRow = grdParamTrans.Row
            grdParamTrans.SelEndRow = grdParamTrans.Row
        End If
    End Sub

    Private Sub grdParamTrans_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdParamTrans.DblClick
        Dim VTRow As Integer = grdParamTrans.Row
        grdParamTrans.Col = 1
        If grdParamTrans.CtlText <> "" Then
            grdParamTrans.Row = VTRow
            PMMarcarRegistroTx()
        End If
    End Sub

    Private Sub grdParamTrans_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdParamTrans.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
    End Sub

    Private Sub grdParamTrans_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdParamTrans.KeyUp
        grdParamTrans.Col = 0
        grdParamTrans.SelStartCol = 1
        grdParamTrans.SelEndCol = grdParamTrans.Cols - 1
        If grdParamTrans.Row = 0 Then
            grdParamTrans.SelStartRow = 1
            grdParamTrans.SelEndRow = 1
        Else
            grdParamTrans.SelStartRow = grdParamTrans.Row
            grdParamTrans.SelEndRow = grdParamTrans.Row
        End If
    End Sub

    Private Sub PMMarcarRegistro()
        PMObjetoSeguridad(cmdBoton(4))
        PMObjetoSeguridad(cmdBoton(3))
        cmdBoton(0).Enabled = False
        grdParamCobCom.Col = 2
        txtCampo(3).Text = grdParamCobCom.CtlText
        txtCampo_Leave(txtCampo(3), New EventArgs())
        grdParamCobCom.Col = 3
        txtCampo(4).Text = grdParamCobCom.CtlText
        txtCampo_Leave(txtCampo(4), New EventArgs())
        grdParamCobCom.Col = 4
        txtTotTrans.Text = grdParamCobCom.CtlText
        grdParamCobCom.Col = 5
        txtCredito.Text = grdParamCobCom.CtlText
        grdParamCobCom.Col = 6
        txtDebito.Text = grdParamCobCom.CtlText
        grdParamCobCom.Col = 7
        txtConsulta.Text = grdParamCobCom.CtlText
        grdParamCobCom.Col = 8
        mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
        mskFecha.Text = StringsHelper.Format(grdParamCobCom.CtlText, VGFormatoFecha)
        grdParamCobCom.Col = 9
        If grdParamCobCom.CtlText = "V" Then
            cmbEstado.SelectedIndex = 0
        Else
            cmbEstado.SelectedIndex = 1
        End If
        PLTSEstado()
    End Sub

    Sub PMMarcarRegistroTx()
        grdParamTrans.Col = 1
        txtCampo(0).Text = grdParamTrans.CtlText
        txtCampo_Leave(txtCampo(0), New EventArgs())
        grdParamTrans.Col = 2
        txtNumTrn.Text = grdParamTrans.CtlText
        grdParamTrans.Col = 4
        txtCanal.Text = grdParamTrans.CtlText
        txtCanal_Leave(txtCanal, New EventArgs())
        If txtCanal.Text = "" Then
            lblDesCanal.Text = ""
        End If
        grdParamTrans.Col = 6
        txtCausal.Text = grdParamTrans.CtlText
        txtCausal_Leave(txtCausal, New EventArgs())
        If txtCausal.Text = "" Then
            lblDesCausal.Text = ""
        End If
        grdParamTrans.Col = 8
        If grdParamTrans.CtlText = "" Then
            grdParamTrans.CtlText = CStr(0)
        End If
        mskMonto.Text = grdParamTrans.CtlText
        grdParamTrans.Col = 9
        lblEstado.Text = grdParamTrans.CtlText
        grdParamTrans.Col = 10
        lblDesEstado.Text = grdParamTrans.CtlText
    End Sub

    Private Sub txtCanal_Change(sender As Object, e As EventArgs) Handles txtCanal.Change
        VLPaso = False
    End Sub

    Private Sub txtCanal_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCanal.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2500))
    End Sub

    Private Sub txtCanal_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles txtCanal.KeyDown
        If eventArgs.KeyCode = VGTeclaAyuda Then
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_canales")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1103) & "[" & txtCampo(4).Text & "]") Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCanal.Text = VGACatalogo.Codigo
                lblDesCanal.Text = VGACatalogo.Descripcion
                If txtCanal.Text <> "" Then
                    txtCanal.Focus()
                End If
                FCatalogo.Dispose() '18/05/2016 migracion
                VLPaso = True
            Else
                PMChequea(sqlconn)
                txtCanal.Text = ""
                lblDesCanal.Text = ""
                txtCanal.Focus()
            End If
        End If
    End Sub

    Private Sub txtCanal_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtCanal.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii < 48 And KeyAscii <> 8 And KeyAscii <> 9) Or KeyAscii > 57 Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCanal_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCanal.Leave
        txtCanal.Text = txtCanal.Text.Trim()
        If Not VLPaso Then
            If txtCanal.Text <> "" Then
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_canales")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCanal.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, "") Then
                    PMMapeaObjeto(sqlconn, lblDesCanal)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCanal.Text = ""
                    lblDesCanal.Text = ""
                    txtCanal.SetFocus()
                    VLPaso = True
                End If
            Else
                lblDesCanal.Text = ""
                'txtCanal.SetFocus()
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtCausal_Change(sender As Object, e As EventArgs) Handles txtCausal.Change
        VLPaso = False
    End Sub

    Private Sub txtCausal_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCausal.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2510))
    End Sub

    Private Sub txtCausal_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles txtCausal.KeyDown
        Dim VLTabla As String = ""
        If eventArgs.KeyCode = VGTeclaAyuda Then
            If txtCampo(0).Text <> "" Then
                If CDbl(txtCampo(0).Text) = 264 Or CDbl(txtCampo(0).Text) = 253 Then
                    If CDbl(txtCampo(0).Text) = 264 Then
                        VLTabla = "ah_causa_nd"
                    End If
                    If CDbl(txtCampo(0).Text) = 253 Then
                        VLTabla = "ah_causa_nc"
                    End If
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1103) & "[" & txtCampo(4).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCausal.Text = VGACatalogo.Codigo
                        lblDesCausal.Text = VGACatalogo.Descripcion
                        If txtCausal.Text <> "" Then
                            txtCausal.Focus()
                        End If
                        FCatalogo.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCausal.Text = ""
                        lblDesCausal.Text = ""
                        txtCausal.Focus()
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub txtCausal_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCausal.Leave
        Dim VLTabla As String = ""
        If Not VLPaso Then
            If txtCausal.Text <> "" Then
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1419), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    txtCausal.Text = ""
                    Exit Sub
                End If
                If CDbl(txtCampo(0).Text) = 264 Or CDbl(txtCampo(0).Text) = 253 Then
                    If CDbl(txtCampo(0).Text) = 264 Then
                        VLTabla = "ah_causa_nd"
                    End If
                    If CDbl(txtCampo(0).Text) = 253 Then
                        VLTabla = "ah_causa_nc"
                    End If
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCausal.Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1103) & "[" & txtCampo(4).Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDesCausal)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        txtCausal.Text = ""
                        lblDesCausal.Text = ""
                        txtCausal.Focus()
                        VLPaso = True
                    End If
                Else
                    txtCausal.Text = ""
                    lblDesCausal.Text = ""
                    txtNumTrn.Focus()
                End If
            Else
                lblDesCausal.Text = ""
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtConsulta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtConsulta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1047))
    End Sub

    Private Sub txtCredito_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCredito.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1049))
    End Sub

    Private Sub txtDebito_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDebito.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1051))
    End Sub

    Private Sub txtNumTrn_Change(sender As Object, e As EventArgs) Handles txtNumTrn.Change
        VLPaso = False
    End Sub

    Private Sub txtNumTrn_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtNumTrn.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1053))
    End Sub

    Private Sub txtNumTrn_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtNumTrn.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii < 48 And KeyAscii <> 8 And KeyAscii <> 9) Or KeyAscii > 57 Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtTotTrans_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTotTrans.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1787))
    End Sub

    Private Sub PLTSEstado()
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBEliminar.Enabled = _cmdBoton_3.Enabled
        TSBEliminar.Visible = _cmdBoton_3.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBBuscar.Enabled = _cmdBoton_5.Enabled
        TSBBuscar.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TBSEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdParamCobCom_Leave(sender As Object, e As EventArgs) Handles grdParamCobCom.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdParamTrans_Leave(sender As Object, e As EventArgs) Handles grdParamTrans.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtNumTrn_Leave(sender As Object, e As EventArgs) Handles txtNumTrn.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        Dim VLValid As Integer
        If Not VLPaso Then
            If txtNumTrn.Text = "" Then
                VLValid = 0
            Else
                VLValid = CInt(txtNumTrn.Text)
            End If
            If VLValid > 255 Then
                COBISMessageBox.Show(FMLoadResString(1422), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                VLNumTranValido = False
                txtNumTrn.Text = ""
                txtNumTrn.Focus()
                Exit Sub
            Else
                VLNumTranValido = True
            End If
        End If
        VLPaso = True
    End Sub

    Private Sub mskMonto_Leave(sender As Object, e As EventArgs) Handles mskMonto.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub


    Private Sub mskFecha_TextChanged(sender As Object, e As EventArgs) Handles mskFecha.TextChanged
        VLPaso = False
    End Sub
End Class


