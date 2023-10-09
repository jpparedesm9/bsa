Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2589Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLFormatoFecha As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_6.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                PLLimpiar()
                txtCampo(1).Focus()
            Case 2
                PLEliminar()
            Case 3
                PLCrear()
            Case 4
                PLActualizar()
            Case 5
                PLSiguientes()
            Case 6
                PLBuscar()
                txtCampo(5).Focus()
        End Select
    End Sub

    Private Sub FTran2589_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        TSBActualizar.Text = FMLoadResString(2031)
    End Sub

    Public Sub PLInicializar()
        PMBotonSeguridad(Me, 4)
        VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
        lblDescripcion(1).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub FTran2589_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502660), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'No existen Oficinas del Banco
                Exit Sub
            End If
        End If
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        grdRegistros.Col = 1
        txtCampo(1).Text = grdRegistros.CtlText
        grdRegistros.Col = 2
        txtCampo(2).Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        txtCampo(5).Text = grdRegistros.CtlText
        grdRegistros.Col = 4
        lblDescripcion(1).Text = grdRegistros.CtlText
        grdRegistros.Col = 5
        txtCampo(6).Text = grdRegistros.CtlText
        grdRegistros.Col = 6
        txtCampo(7).Text = grdRegistros.CtlText
        txtCampo(1).Enabled = False
        txtCampo(2).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = True
        cmdBoton(2).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub PLActualizar()
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502661), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de Banco [OFICINA] es mandatorio
            txtCampo(1).Focus()
            Exit Sub
        ElseIf txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502109), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de Banco [CIUDAD] es mandatorio
            txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(6).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503012), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Descripción de la Oficina es mandatoria
            txtCampo(6).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2590")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_direccion", 0, SQLVARCHAR, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_telefono", 0, SQLVARCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_ofibanco", True, FMLoadResString(502663)) Then 'Ok... Consulta de Tipos de Oficinas de Banco
            PMChequea(sqlconn)
            cmdBoton(4).Enabled = False
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2591")
        PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_ofibanco", True, FMLoadResString(502663)) Then 'Ok... Consulta de Tipos de Oficinas de Banco
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = Conversion.Val(CStr(grdRegistros.Rows - 1)) >= 20
            If grdRegistros.Rows <= 2 Then
                grdRegistros.Col = 1
                grdRegistros.Row = 1
                If grdRegistros.CtlText = "" Then
                    Exit Sub
                End If
            End If
            VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
            lblDescripcion(1).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
        PMAnchoColumnasGrid(grdRegistros)
        PLTSEstado()
    End Sub

    Private Sub PLCrear()
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502664), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de Oficina es mandatorio
            txtCampo(1).Focus()
            Exit Sub
        ElseIf txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502665), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de Ruta es mandatorio
            txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502662), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Descripción de la Oficina es mandatoria
            txtCampo(5).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2589")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_direccion", 0, SQLVARCHAR, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_telefono", 0, SQLVARCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_ofibanco", True, FMLoadResString(503013)) Then 'Ok... Consulta de Tipos de Oficinas de Banco
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
        PLLimpiar()
        txtCampo(1).Focus()
    End Sub

    Private Sub PLEliminar()
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502664), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"Código de Oficina es mandatorio"
            txtCampo(1).Focus()
            Exit Sub
        ElseIf txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502666), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"Código de Ciudad es mandatorio"
            txtCampo(2).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2592")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_ofibanco", True, FMLoadResString(502663)) Then '"Ok... Consulta de Tipos de Oficinas de Banco"
            PMChequea(sqlconn)
            cmdBoton(3).Enabled = True
            cmdBoton(2).Enabled = False
            cmdBoton(4).Enabled = False
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
        PLBuscar()
        txtCampo(5).Focus()
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        txtCampo(1).Enabled = True
        txtCampo(2).Enabled = True
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(5).Text = ""
        txtCampo(6).Text = ""
        txtCampo(7).Text = ""
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        cmdBoton(3).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        grdRegistros.Rows = 2
        grdRegistros.Cols = 2
        For i As Integer = 0 To 1
            grdRegistros.Row = i
            For j As Integer = 0 To 1
                grdRegistros.Col = j
                grdRegistros.CtlText = ""
            Next j
        Next i
        PLTSEstado()
    End Sub

    Private Sub PLSiguientes()
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2591")
        PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, grdRegistros.CtlText)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_ofibanco", True, FMLoadResString(502663)) Then 'Ok... Consulta de Tipos de Oficinas de Banco
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = Conversion.Val(CStr(grdRegistros.Rows - 1)) Mod 20 = 0
        Else
            PMChequea(sqlconn)
        End If
        PMAnchoColumnasGrid(grdRegistros)
        PLTSEstado()
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502667))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503018))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502669))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503373))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503374))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub


    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 7
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 5
                If (KeyAscii > 47 And KeyAscii < 58) Or (KeyAscii > 64 And KeyAscii < 91) Or (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                Else
                    KeyAscii = 0
                End If
            Case 6
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave
        If Conversion.Val(txtCampo(1).Text) > 32767 Then
            COBISMessageBox.Show(FMLoadResString(502670), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El Código de la Oficina es incorrecto
            txtCampo(1).Text = ""
            txtCampo(1).Focus()
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1, 2, 7
                If Not (Conversion.Val(txtCampo(Index).Text) > 0) Then
                    txtCampo(Index).Text = ""
                End If
        End Select
    End Sub

    Private Sub _txtCampo_GotFocus(sender As Object, e As EventArgs) Handles _txtCampo_1.GotFocus, _txtCampo_2.GotFocus, _txtCampo_7.GotFocus
        Dim Index As Integer = Array.IndexOf(txtCampo, sender)
        Select Case Index
            Case 1, 2, 7
                Clipboard.Clear()
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_6.Visible
        TSBBuscar.Enabled = _cmdBoton_6.Enabled
        TSBSiguientes.Visible = _cmdBoton_5.Visible
        TSBSiguientes.Enabled = _cmdBoton_5.Enabled
        TSBCrear.Visible = _cmdBoton_3.Visible
        TSBCrear.Enabled = _cmdBoton_3.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible
        TSBSalir.Enabled = _cmdBoton_0.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter 'JSA
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509100)) 'Registros de Oficinas del Banco
    End Sub

End Class
