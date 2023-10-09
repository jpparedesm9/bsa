Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FCtaBcoOfiClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_5.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TBotones.Focus()
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLTransmitir("I")
            Case 2
                PLTransmitir("D")
            Case 3
                PLTransmitir("U")
            Case 4
                PLLimpiar()
            Case 5
                Me.Close()
        End Select
    End Sub

    Private Sub PLInicializar()
        For i As Integer = 0 To 1
            PMObjetoSeguridad(cmdBoton(i))
        Next i

        'Dim eventSender As Object = Nothing
        'Dim eventArgs As EventArgs = Nothing
        'txtCampo_Leave(eventSender, eventArgs)

        'cmdBoton(4).Enabled = True
        'cmdBoton(5).Enabled = True
        'cmdBoton(0).Enabled = True
        'cmdBoton(1).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub Optcompensa_Enter(ByVal eventSender As Object, e As EventArgs) Handles _Optcompensa_0.Enter, _Optcompensa_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502515))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508869))

        End Select


    End Sub

    Private Sub FCtaBcoOfi_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub FCtaBcoOfi_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        cmdBoton(5).Enabled = False

    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        grdRegistros.Col = 1
        txtCampo(0).Text = grdRegistros.CtlText
        grdRegistros.Col = 2
        lblDescripcion(0).Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        Optcompensa(0).Checked = False
        Optcompensa(1).Checked = False
        If grdRegistros.CtlText = "S" Then
            Optcompensa(0).Checked = True
        End If
        If grdRegistros.CtlText = "N" Then
            Optcompensa(1).Checked = True
        End If
        grdRegistros.Col = 4
        If grdRegistros.CtlText <> "" Then
            txtCampo(1).Text = grdRegistros.CtlText
            grdRegistros.Col = 5
            lblDescripcion(1).Text = grdRegistros.CtlText
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Text = ""
        End If
        grdRegistros.Col = 6
        If grdRegistros.CtlText <> "" Then
            txtCampo(2).Text = grdRegistros.CtlText
            grdRegistros.Col = 7
            lblDescripcion(2).Text = grdRegistros.CtlText
        Else
            txtCampo(2).Text = ""
            lblDescripcion(2).Text = ""
        End If
        For i As Integer = 0 To 5
            cmdBoton(i).Enabled = False
        Next i
        cmdBoton(4).Enabled = True
        cmdBoton(5).Enabled = True
        'cmdBoton(2).Enabled = True
        'cmdBoton(3).Enabled = True
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(2))
        PMObjetoSeguridad(cmdBoton(3))
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub Optcompensa_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _Optcompensa_0.CheckedChanged, _Optcompensa_1.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(Optcompensa, eventSender)
            If Index = 1 Then
                txtCampo(1).Enabled = True
                txtCampo(2).Enabled = True
            Else
                txtCampo(1).Enabled = False
                txtCampo(1).Text = ""
                lblDescripcion(1).Text = ""
                txtCampo(2).Enabled = False
                txtCampo(2).Text = ""
                lblDescripcion(2).Text = ""
            End If
        End If
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_2.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                txtCampo(2).Text = ""
                lblDescripcion(1).Text = ""
                lblDescripcion(2).Text = ""
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_2.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502515))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508869))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502296))
        End Select
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_2.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode <> VGTeclaAyuda Then
            Exit Sub
        End If
        Dim VTReg As String = ""
        Select Case Index
            Case 0
                VGOperacion = "sp_oficina"
                VLPaso = True
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502657)) Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(Index).Text = VGACatalogo.Codigo
                    lblDescripcion(Index).Text = VGACatalogo.Descripcion
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Text = ""
                    txtCampo(Index).Focus()
                    lblDescripcion(Index).Text = ""
                End If

                VLPaso = True
            Case 1
                VLPaso = False
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "452")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                VGOperacion = "sp_catalogo_bancos"
                If FMTransmitirRPC(sqlconn, "", "cob_remesas", "sp_cat_bancos", True, FMLoadResString(508886)) Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    lblDescripcion(1).Text = VGACatalogo.Descripcion
                    txtCampo(1).Text = VGACatalogo.Codigo
                    txtCampo(1).Focus()
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Focus()
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                End If

                VLPaso = True
            Case 2
                VLPaso = True
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508887), My.Application.Info.ProductName)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(29265))
                PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "C")
                PMPasoValores(sqlconn, "@i_comercial", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_bco", 0, SQLINT2, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_sbancarios", "sp_bus_subtipos", True, FMLoadResString(508888)) Then
                    PMMapeaVariable(sqlconn, VTReg)
                    PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                    PMChequea(sqlconn)
                    grid_valores.ShowPopup(Me)
                    If txtCampo(1).Text.Trim() = "" Then
                        txtCampo(1).Text = Temporales(1)
                        lblDescripcion(1).Text = Temporales(2)
                    End If
                    grid_valores.Dispose()
                    txtCampo(Index).Text = Temporales(3)
                    lblDescripcion(Index).Text = Temporales(4)
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Text = ""
                    txtCampo(Index).Focus()
                    lblDescripcion(Index).Text = ""
                End If

                VLPaso = True
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_2.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_2.Leave, _txtCampo_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTArreglo(10) As String
        Dim VTR As Integer = 0
        Dim VTReg As String = ""
        Select Case Index
            Case 0
                If txtCampo(Index).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(Index).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502503) & "[" & txtCampo(Index).Text & "]") Then
                        VLPaso = True
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        txtCampo(Index).Focus()
                        lblDescripcion(Index).Text = ""
                    End If
                End If
            Case 1
                'If Not VLPaso And txtCampo(Index).Text <> "" Then
                If txtCampo(Index).Text <> "" Then
                    VGOperacion = "sp_cat_bancos"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "452")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, txtCampo(Index).Text)
                    If FMTransmitirRPC(sqlconn, "", "cob_remesas", "sp_cat_bancos", True, FMLoadResString(508886)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        txtCampo(Index).Focus()
                        lblDescripcion(Index).Text = ""
                    End If
                End If
            Case 2
                If txtCampo(Index).Text <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(29265))
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_comercial", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_bco", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLCHAR, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_sbancarios", "sp_bus_subtipos", True, FMLoadResString(508888)) Then
                        PMMapeaVariable(sqlconn, VTReg)
                        VTR = FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        If VTR > 0 Then
                            txtCampo(Index).Text = VTArreglo(3)
                            lblDescripcion(Index).Text = VTArreglo(4)
                        Else
                            txtCampo(Index).Text = ""
                            lblDescripcion(Index).Text = ""
                            txtCampo(Index).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        txtCampo(Index).Focus()
                        lblDescripcion(Index).Text = ""
                    End If
                End If
        End Select
        If txtCampo(Index).Text = "" Then
            lblDescripcion(Index).Text = ""
        End If
    End Sub

    Public Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "696")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ctabco_oficina", True, FMLoadResString(502658)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
            While Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
                PLSiguientes()
            End While
            grdRegistros.ColWidth(1) = 700
            grdRegistros.ColWidth(2) = 1800
            grdRegistros.ColWidth(3) = 1000
            grdRegistros.ColWidth(4) = 400
            grdRegistros.ColWidth(5) = 1900
            grdRegistros.ColWidth(6) = 1100
            grdRegistros.ColWidth(7) = 2500
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Public Sub PLTransmitir(ByRef operacion As String)
        Dim VTTran As String = CStr(697)
        If operacion = "I" Or operacion = "U" Then
            If Not FLChequea() Then
                Exit Sub
            End If
        End If
        If operacion = "D" Then
            If txtCampo(0).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502659), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(0).Focus()
                Exit Sub
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VTTran)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, operacion)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(0).Text)
        If operacion = "I" Or operacion = "U" Then
            If Optcompensa(0).Checked Then
                PMPasoValores(sqlconn, "@i_compensa", 0, SQLCHAR, "S")
            Else
                PMPasoValores(sqlconn, "@i_compensa", 0, SQLCHAR, "N")
                PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, _lblDescripcion_2.Text)

            End If
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ctabco_oficina", True, FMLoadResString(503008)) Then
            PMChequea(sqlconn)
            PLLimpiar()
        Else
            PMChequea(sqlconn)
            txtCampo(0).Focus()
        End If
        PLBuscar()
    End Sub

    Public Sub PLLimpiar()
        For i As Integer = 0 To 2
            txtCampo(i).Text = ""
            lblDescripcion(i).Text = ""
            If i > 0 Then
                txtCampo(i).Enabled = False
            End If
        Next i
        grdRegistros.Rows = 2
        For i As Integer = 0 To grdRegistros.Cols - 1
            grdRegistros.Col = i
            For j As Integer = 0 To 1
                grdRegistros.Row = j
                grdRegistros.CtlText = ""
            Next j
        Next i
        For i As Integer = 0 To 5
            cmdBoton(i).Enabled = False
        Next i
        For i As Integer = 0 To 1
            PMObjetoSeguridad(cmdBoton(i))
        Next i
        cmdBoton(4).Enabled = True
        cmdBoton(5).Enabled = True
        Optcompensa(0).Checked = True
        Optcompensa(1).Checked = False
        PMLimpiaG(grdRegistros)
        PLTSEstado()
    End Sub

    Public Sub PLSiguientes()
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "696")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, grdRegistros.CtlText)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ctabco_oficina", True, FMLoadResString(502658)) Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Public Function FLChequea() As Boolean
        Dim result As Boolean = False
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502659), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Return result
        End If
        If Not Optcompensa(0).Checked And Not Optcompensa(1).Checked Then
            COBISMessageBox.Show(FMLoadResString(508889), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return result
        End If
        If Optcompensa(1).Checked Then
            If txtCampo(1).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(508890), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(1).Focus()
                Return result
            End If
            If txtCampo(2).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(508891), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(2).Focus()
                Return result
            End If
        End If
        Return True
    End Function

    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If __cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBINGRESAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
        If __cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBELIMINAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If __cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBMODIFICAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar.Click
        If __cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If __cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If __cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible()
        TSBIngresar.Enabled = _cmdBoton_1.Enabled
        TSBIngresar.Visible = _cmdBoton_1.Visible()
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible()
        TSBModificar.Enabled = _cmdBoton_3.Enabled
        TSBModificar.Visible = _cmdBoton_3.Visible()
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible()
        TSBSalir.Enabled = _cmdBoton_5.Enabled
        TSBSalir.Visible = _cmdBoton_5.Visible()
    End Sub

    Private Sub _Optcompensa_0_Leave(sender As Object, e As EventArgs) Handles _Optcompensa_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508861))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


