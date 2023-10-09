Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran602Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLFila As Integer = 0
    Dim VLVez As Integer = 0
    Dim VLSalir As Boolean = False
    Dim VLStatus As String = ""
    Dim VLRef As String = ""
    Dim VLDatosCheque() As String

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_6.Click, _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLBloqueoCheques()
                PLBuscar()
            Case 1
                PLAcuseCheques()
                PLBuscar()
            Case 2
                PLDesbloquearCheque()
                PLBuscar()
            Case 3
                PLBuscar()
            Case 4
                Me.Close()
            Case 6
                PLLimpiar()
        End Select
    End Sub

    Private Function FLMarcados(ByRef modo As Integer) As Integer
        Dim result As Integer = 0
        Dim VTVistos As Integer = 0
        Dim VTPendientes As Integer = 0
        For i As Integer = 1 To grdRegistros.Rows - 1
            grdRegistros.Col = 0
            grdRegistros.Row = i
            If grdRegistros.Picture Is Nothing Then
                VTVistos += 1
            End If
            If modo = 1 Then
                grdRegistros.Col = 6
                If grdRegistros.CtlText = "PENDIENTE" Then
                    VTPendientes += 1
                End If
            End If
        Next i
        Select Case modo
            Case 0
                If VTVistos > 0 Then
                    result = 1
                Else
                    result = 0
                End If
            Case 1
                If VTPendientes = grdRegistros.Rows - 1 Then
                    result = 1
                Else
                    result = 0
                End If
        End Select
        Return result
    End Function


    Private Sub FTran602_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBloqChq.Enabled = _cmdBoton_0.Enabled
        TSBBloqChq.Visible = _cmdBoton_0.Visible
        TSBDesChq.Enabled = _cmdBoton_2.Enabled
        TSBDesChq.Visible = _cmdBoton_2.Visible
        TSBAcuse.Enabled = _cmdBoton_1.Enabled
        TSBAcuse.Visible = _cmdBoton_1.Visible
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_6.Enabled
        TSBLimpiar.Visible = _cmdBoton_6.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub
    Private Sub TSBBloqChq_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBloqChq.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBDesChq_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBDesChq.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBAcuse_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAcuse.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Public Sub PLInicializar()
        cmdBoton(0).Enabled = False
        cmdBoton(2).Enabled = False
        For i As Integer = 10 To 17
            lblDescripcion(i).Visible = False
        Next i
        lblDescripcion(11).Visible = True
        For i As Integer = 10 To 16
            lblEtiqueta(i).Visible = False
        Next i
        VGTipoOper = ""
        PLTSEstado()
    End Sub

    Private Sub FTran602_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click, grdRegistros.ClickEvent
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
        If grdRegistros.Cols <= 2 Then
            COBISMessageBox.Show(FMLoadResString(508643), FMLoadResString(500989), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        VLFila = 0
        PLMarcarRegistro()
    End Sub

    Private Sub PLDesbloquearCheque()
        Dim VTSec As String = String.Empty
        Dim VTValor As String = String.Empty
        Dim VTReferencia As String = String.Empty
        If FLMarcados(0) Then
            For i As Integer = 1 To grdRegistros.Rows - 1
                grdRegistros.Col = 0
                grdRegistros.Row = i
                If grdRegistros.Picture Is Nothing Then
                    grdRegistros.Col = 5
                    VTValor = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    VTReferencia = grdRegistros.CtlText
                    grdRegistros.Col = 7
                    VTSec = grdRegistros.CtlText
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "604")
                    PMPasoValores(sqlconn, "@i_propie", 0, SQLVARCHAR, lblDescripcion(2).Text)
                    PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, lblDescripcion(0).Text)
                    PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_chq", 0, SQLINT4, VTReferencia)
                    PMPasoValores(sqlconn, "@i_chq_sec", 0, SQLINT4, VTSec)
                    PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTValor)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@i_bloq", 0, SQLVARCHAR, "D")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_novedad_remesas", True, FMLoadResString(508817)) Then
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                    End If
                End If
            Next i
        End If
    End Sub

    Private Sub PLBloqueoCheques()
        Dim VTCausaDev As String = ""
        Dim VTValor As String = String.Empty
        Dim VTReferencia As String = String.Empty
        Dim VTSec As String = String.Empty
        If FLMarcados(0) Then
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "re_bloqueo_remesa")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                VTCausaDev = VGACatalogo.Codigo
            Else
                PMChequea(sqlconn)
            End If
            If VTCausaDev = "" Then
                COBISMessageBox.Show(FMLoadResString(500314), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            For i As Integer = 1 To grdRegistros.Rows - 1
                grdRegistros.Col = 0
                grdRegistros.Row = i
                If grdRegistros.Picture Is Nothing Then
                    grdRegistros.Col = 5
                    VTValor = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    VTReferencia = grdRegistros.CtlText
                    grdRegistros.Col = 7
                    VTSec = grdRegistros.CtlText
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "605")
                    PMPasoValores(sqlconn, "@i_propie", 0, SQLVARCHAR, lblDescripcion(2).Text)
                    PMPasoValores(sqlconn, "@i_emisor", 0, SQLVARCHAR, lblDescripcion(4).Text)
                    PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, lblDescripcion(0).Text)
                    PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
                    PMPasoValores(sqlconn, "@i_chq", 0, SQLINT4, VTReferencia)
                    PMPasoValores(sqlconn, "@i_chq_sec", 0, SQLINT4, VTSec)
                    PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTValor)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@i_caubloq", 0, SQLVARCHAR, VTCausaDev)
                    PMPasoValores(sqlconn, "@i_bloq", 0, SQLVARCHAR, "B")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_novedad_remesas", True, FMLoadResString(508819)) Then
                        PMChequea(sqlconn)
                        PLObtenerDatos()
                        Exit For
                    Else
                        PMChequea(sqlconn)
                    End If
                End If
            Next i
        End If
    End Sub

    Private Sub PLAcuseCheques()
        FAcuseChq.ShowPopup(Me)
    End Sub

    Private Sub PLHabilitaBotones()
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText = "" Then
                Exit Sub
            End If
        End If
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = True
        cmdBoton(2).Enabled = True
        cmdBoton(3).Enabled = True
        cmdBoton(0).Focus()
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        txtCarta.Enabled = True
        txtCarta.Text = ""
        For i As Integer = 0 To 9
            If i < 2 Or i > 3 Then
                lblDescripcion(i).Visible = True
            End If
        Next i
        lblDescripcion(11).Visible = True
        For i As Integer = 0 To 6
            If i <> 1 Then
                lblEtiqueta(i).Visible = True
            End If
        Next i
        lblEtiqueta(8).Visible = True
        lblEtiqueta(9).Visible = True
        For i As Integer = 10 To 17
            lblDescripcion(i).Visible = False
        Next i
        lblDescripcion(11).Visible = True
        For i As Integer = 10 To 16
            lblEtiqueta(i).Visible = False
        Next i
        For i As Integer = 0 To 17
            lblDescripcion(i).Text = ""
        Next i
        PMLimpiaGrid(grdRegistros)
        txtCarta.Focus()
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText = "" Then
                grdRegistros.Col = 0
                grdRegistros.Picture = picVisto(1).Image
            End If
        End If
        cmdBoton(0).Enabled = False
        cmdBoton(2).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub PLMarcarRegistro()
        For i As Integer = 0 To 9
            lblDescripcion(i).Visible = False
        Next i
        lblDescripcion(11).Visible = False
        For i As Integer = 0 To 6
            lblEtiqueta(i).Visible = False
        Next i
        lblEtiqueta(8).Visible = False
        lblEtiqueta(9).Visible = False
        VLFila = grdRegistros.Row
        grdRegistros.Col = 0
        For i As Integer = 0 To grdRegistros.Rows - 1
            grdRegistros.Row = i
            If grdRegistros.Picture Is Nothing Then
                grdRegistros.CtlText = Conversion.Str(grdRegistros.Row)
                grdRegistros.Picture = picVisto(1).Image
            End If
        Next i
        grdRegistros.Col = 0
        grdRegistros.Row = VLFila
        grdRegistros.Picture = picVisto(0).Image
        For i As Integer = 10 To 17
            lblDescripcion(i).Visible = True
        Next i
        lblDescripcion(11).Visible = False
        For i As Integer = 10 To 16
            lblEtiqueta(i).Visible = True
        Next i
        grdRegistros.Col = 1
        lblDescripcion(10).Text = grdRegistros.CtlText
        grdRegistros.Col = 2
        lblDescripcion(12).Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        lblDescripcion(13).Text = grdRegistros.CtlText
        grdRegistros.Col = 4
        lblDescripcion(14).Text = grdRegistros.CtlText
        grdRegistros.Col = 5
        lblDescripcion(15).Text = grdRegistros.CtlText
        grdRegistros.Col = 6
        lblDescripcion(16).Text = grdRegistros.CtlText
        grdRegistros.Col = 9
        lblDescripcion(17).Text = grdRegistros.CtlText
    End Sub

    Private Sub PLObtenerDatos()
        Dim VTValor As String = ""
        Dim VTArreglo(20) As String
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "407")
            PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_consulta", 0, SQLVARCHAR, "S")
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            PMPasoValores(sqlconn, "@i_status", 0, SQLVARCHAR, VLStatus)
            PMPasoValores(sqlconn, "@i_ref", 0, SQLINT4, VLRef)
            PMPasoValores(sqlconn, "@i_vez", 0, SQLINT1, Conversion.Str(VLVez))
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "N")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_consulcar", True, FMLoadResString(508809)) Then
                If VLVez = 1 Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                Else
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                End If
                PMChequea(sqlconn)
                grdRegistros.Col = 8
                VTValor = grdRegistros.CtlText
                If VTValor = "N" Then
                    COBISMessageBox.Show(FMLoadResString(508664), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    cmdBoton(0).Enabled = False
                    cmdBoton(1).Enabled = False
                    cmdBoton(2).Enabled = False
                    cmdBoton(3).Enabled = False
                    Exit Sub
                End If
                VLVez += 1
                If CDbl(Convert.ToString(grdRegistros.Tag)) < 40 Then VLSalir = True
                grdRegistros.ColAlignment(5) = 1
                lblDescripcion(0).Text = VTArreglo(1)
                lblDescripcion(1).Text = VTArreglo(2)
                lblDescripcion(2).Text = VTArreglo(3)
                lblDescripcion(3).Text = VTArreglo(4)
                lblDescripcion(4).Text = VTArreglo(5)
                lblDescripcion(5).Text = VTArreglo(6)
                lblDescripcion(6).Text = VTArreglo(7)
                lblDescripcion(7).Text = VTArreglo(8)
                lblDescripcion(8).Text = VTArreglo(9)
                lblDescripcion(9).Text = VTArreglo(10)
                lblDescripcion(11).Text = VTArreglo(12)
                txtCarta.Enabled = False
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 6
                VLStatus = grdRegistros.CtlText
                grdRegistros.Col = 7
                VLRef = grdRegistros.CtlText
            Else
                PMChequea(sqlconn)
                PLLimpiar()
                Exit Sub
            End If
        End While
        PLHabilitaBotones()
        PLProducto()
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        VGTipoOper = "N"
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "447")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "N")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, VGTipoOper)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_ayuda", True, FMLoadResString(508809)) Then
            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
            PMChequea(sqlconn)
            If txtCarta.Text <> "" Then
                PLObtenerDatos()
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLProducto()
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Col = 1
            grdRegistros.Row = 1
            If grdRegistros.CtlText = "" Then
                Exit Sub
            End If
        End If
        For i As Integer = 1 To grdRegistros.Rows - 1
            grdRegistros.Col = 3
            grdRegistros.Row = i
            Select Case grdRegistros.CtlText
                Case "3"
                    grdRegistros.CtlText = "CTE"
                Case "4"
                    grdRegistros.CtlText = "AHO"
            End Select
        Next i
    End Sub

    Private Sub grdRegistros_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Enter
        VLPaso = False
    End Sub

    Private Sub grdRegistros_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdRegistros.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "re_bloqueo_remesa")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCarta_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCarta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500323))
        txtCarta.SelectionStart = 0
        txtCarta.SelectionLength = Strings.Len(txtCarta.Text)
    End Sub

    Private Sub txtCarta_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCarta.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            VGOperacion = "sp_rem_ayuda"
            VGTipoOper = "N"
            txtCarta.Text = ""
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "447")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "N")
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, VGTipoOper)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_ayuda", True, FMLoadResString(508809)) Then
                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                PMChequea(sqlconn)
                FRegistros.ShowPopup(Me)
                FRegistros.cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag)) = VGMaxRows
                txtCarta.Text = VGACatalogo.Codigo
                If txtCarta.Text <> "" Then
                    PLObtenerDatos()
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtCarta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCarta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCarta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.Leave
        If Not VLPaso And txtCarta.Text <> "" Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            PLObtenerDatos()
        End If
    End Sub

    Private Sub txtCarta_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtCarta.MouseDown

    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        VGHelpRem = "N"
    End Sub

End Class


