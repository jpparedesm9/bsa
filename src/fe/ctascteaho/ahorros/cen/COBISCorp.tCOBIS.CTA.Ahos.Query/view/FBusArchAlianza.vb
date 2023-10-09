Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FBusArchAlianzaClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLUltLinea As Integer = 0
    Dim VLSec As String = ""
    Dim VLAlt As String = ""
    Public VLExisteCliente As Boolean = False
    Dim i As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLEscoger()
            Case 1
                PLSiguientes()
            Case 2
                PLBuscar()
            Case 3
                Me.Close()
            Case 4
                PLLimpiar()
        End Select
    End Sub


    Private Sub PLInicializar()
        'FBusCta.Left = FPrincipal.Left + Compatibility.VB6.TwipsToPixelsX(50)
        ' FBusCta.Top = FPrincipal.Top + Compatibility.VB6.TwipsToPixelsY(1000)
        'FBusCta.Width = Compatibility.VB6.TwipsToPixelsX(6450)
        'FBusCta.Height = Compatibility.VB6.TwipsToPixelsY(4200)
        cmdBoton(2).Enabled = True
    End Sub


    Private Sub PLTSEstado()
        TSBuscar.Enabled = _cmdBoton_2.Enabled
        TSBuscar.Visible = _cmdBoton_2.Visible
        TSBSigtes.Enabled = _cmdBoton_1.Enabled
        TSBSigtes.Visible = _cmdBoton_1.Visible
        TSBEscoger.Enabled = _cmdBoton_0.Enabled
        TSBEscoger.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub


    Private Sub FBusArchAlianza_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()

    End Sub

    Private Sub grdArchivos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdArchivos.Click
        grdArchivos.Col = 0
        grdArchivos.SelStartCol = 1
        grdArchivos.SelEndCol = grdArchivos.Cols - 1
        If grdArchivos.Row = 0 Then
            grdArchivos.SelStartRow = 1
            grdArchivos.SelEndRow = 1
        Else
            grdArchivos.SelStartRow = grdArchivos.Row
            grdArchivos.SelEndRow = grdArchivos.Row
        End If
    End Sub

    Private Sub grdArchivos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdArchivos.DblClick
        PLEscoger()
    End Sub

    Private Sub PLLimpiar()
        PMLimpiaGrid(grdArchivos)
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
    End Sub

    Private Sub PLSiguientes()
        Dim VTFecha As String = String.Empty
        Dim VLSecuencial As String = String.Empty
        Dim txtCampo As Object = Nothing 'JSA
        If txtCampo.Text.Trim() = "" Then
            COBISMessageBox.Show("El nombre es mandatorio", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo.SetFocus()
            Exit Sub
        End If
        grdArchivos.Row = grdArchivos.Rows - 1
        grdArchivos.Col = 2
        VLSecuencial = grdArchivos.CtlText
        If VLExisteCliente Then
            PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tipo_ident", 0, SQLCHAR, txtTipoId.Text)
            PMPasoValores(sqlconn, "@i_identificacion", 0, SQLCHAR, txtCliente.Text)
        Else
            PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "T")
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "702")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
        VTFecha = FMConvFecha(lblFecha.Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VLSecuencial)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
            PMMapeaGrid(sqlconn, grdArchivos, True)
            PMMapeaTextoGrid(grdArchivos)
            grdArchivos.ColWidth(3) = 0
            grdArchivos.ColWidth(4) = 0
            PMChequea(sqlconn)
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdArchivos.Tag)) = 20
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show("Error en la consulta del archivo de alizanza", "Error Consulta", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub PLBuscar()
        Dim VTFecha As String = ""
        If VLExisteCliente Then
            PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tipo_ident", 0, SQLCHAR, txtTipoId.Text)
            PMPasoValores(sqlconn, "@i_identificacion", 0, SQLCHAR, txtCliente.Text)
        Else
            PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "T")
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "702")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        VTFecha = FMConvFecha(lblFecha.Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFecha)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
            PMMapeaGrid(sqlconn, grdArchivos, False)
            PMMapeaTextoGrid(grdArchivos)
            PMChequea(sqlconn)
            If CDbl(Convert.ToString(grdArchivos.Tag)) = 0 Then
                COBISMessageBox.Show("No existe registro del archivo de alizanza", "Error Consulta", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            cmdBoton(0).Enabled = True
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdArchivos.Tag)) = 20
            PLTSEstado()
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show("Error en la consulta del archivo de alizanza", "Error Consulta", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub PLEscoger()
        grdArchivos.Col = 1
        If grdArchivos.CtlText.Trim() = "" Or grdArchivos.Row = 0 Then
            Exit Sub
        End If
        If grdArchivos.CtlText.Trim() <> "" Then
            VGADatosO(1) = grdArchivos.CtlText
        End If
        grdArchivos.Col = 2
        If grdArchivos.CtlText.Trim() <> "" Then
            VGADatosO(0) = grdArchivos.CtlText
        End If
        grdArchivos.Col = 3
        If grdArchivos.CtlText.Trim() <> "" Then
            VGADatosO(2) = grdArchivos.CtlText
        End If
        grdArchivos.Col = 4
        If grdArchivos.CtlText.Trim() <> "" Then
            VGADatosO(3) = grdArchivos.CtlText
        End If
        Me.Close()
    End Sub

    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBuscar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSIGTES_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSigtes.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBESCOGER_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        PLBuscar()
    End Sub

    Private Sub txtTipoId_Enter(sender As Object, e As EventArgs) Handles txtTipoId.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500155))
    End Sub

    Private Sub txtCliente_Enter(sender As Object, e As EventArgs) Handles txtCliente.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501444))
    End Sub

    Private Sub txtTipoId_Leave(sender As Object, e As EventArgs) Handles txtTipoId.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtCliente_Leave(sender As Object, e As EventArgs) Handles txtCliente.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdArchivos_Enter(sender As Object, e As EventArgs) Handles grdArchivos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2220))
    End Sub

    Private Sub grdArchivos_Leave(sender As Object, e As EventArgs) Handles grdArchivos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


