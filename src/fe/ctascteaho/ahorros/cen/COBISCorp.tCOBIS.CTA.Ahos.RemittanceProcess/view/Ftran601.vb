Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran601Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLVez As Integer = 0
    Dim VLSalir As Boolean = False
    Dim VLStatus As String = ""
    Dim VLRef As String = ""
    Dim VLConfirmar As String = ""
    Dim VLFila As Integer = 0
    Dim VLDatosCheque() As String

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_6.Click, _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLAcuse()
            Case 2
                PLBuscar()
            Case 4
                Me.Close()
            Case 6
                PLLimpiar()
        End Select
    End Sub


    Private Sub FTran601_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_2.Enabled
        TSBBuscar.Visible = _cmdBoton_2.Visible
        TSBAcuse.Enabled = _cmdBoton_0.Enabled
        TSBAcuse.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_6.Enabled
        TSBLimpiar.Visible = _cmdBoton_6.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub
    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBAcuse_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAcuse.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Public Sub PLInicializar()
        cmdBoton(0).Enabled = False
        cmdBoton(2).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub FTran601_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
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
        VLFila = 0
        PLMarcarRegistro()
    End Sub

    Private Sub PLBuscar()
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
            PMPasoValores(sqlconn, "@i_consulta", 0, SQLVARCHAR, "N")
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            PMPasoValores(sqlconn, "@i_status", 0, SQLVARCHAR, VLStatus)
            PMPasoValores(sqlconn, "@i_ref", 0, SQLINT4, VLRef)
            PMPasoValores(sqlconn, "@i_vez", 0, SQLINT1, Conversion.Str(VLVez))
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, VGTipoOper)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_consulcar", True, FMLoadResString(508809)) Then
                If VLVez = 1 Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMMapeaVariable(sqlconn, VLConfirmar)
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                Else
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                End If
                PMChequea(sqlconn)
                grdRegistros.Col = 8
                VTValor = grdRegistros.CtlText
                If VTValor = "S" Then
                    COBISMessageBox.Show(FMLoadResString(508448), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    cmdBoton(0).Enabled = False
                    Exit Sub
                End If
                VLVez += 1
                If CDbl(Convert.ToString(grdRegistros.Tag)) < 45 Then VLSalir = True
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

    Private Sub PLAcuse()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "603")
        PMPasoValores(sqlconn, "@i_propie", 0, SQLVARCHAR, lblDescripcion(2).Text)
        PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, lblDescripcion(0).Text)
        PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, lblDescripcion(11).Text)
        PMPasoValores(sqlconn, "@i_hablt", 0, SQLVARCHAR, "C")
        PMPasoValores(sqlconn, "@i_acuse", 0, SQLVARCHAR, "S")
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_acuse_remesas", True, FMLoadResString(508818)) Then
            PMChequea(sqlconn)
            cmdBoton(0).Enabled = False
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLHabilitaBotones()
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText = "" Then
                Exit Sub
            End If
        End If
        If VLConfirmar = "S" Then
            cmdBoton(0).Enabled = True
            cmdBoton(2).Enabled = True
            cmdBoton(0).Focus()
        Else
            cmdBoton(0).Enabled = True
            cmdBoton(2).Enabled = False
            cmdBoton(6).Focus()
        End If
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        txtCarta.Enabled = True
        txtCarta.Text = ""
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        lblDescripcion(3).Text = ""
        lblDescripcion(4).Text = ""
        lblDescripcion(5).Text = ""
        lblDescripcion(6).Text = ""
        lblDescripcion(7).Text = ""
        lblDescripcion(8).Text = ""
        lblDescripcion(9).Text = ""
        lblDescripcion(11).Text = ""
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
        cmdBoton(2).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub PLMarcarRegistro()
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
    End Sub

    Private Sub PLObtenerDatos()
        Dim VTArreglo(20) As String
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "407")
            PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_consulta", 0, SQLVARCHAR, "N")
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            PMPasoValores(sqlconn, "@i_status", 0, SQLVARCHAR, VLStatus)
            PMPasoValores(sqlconn, "@i_ref", 0, SQLINT4, VLRef)
            PMPasoValores(sqlconn, "@i_vez", 0, SQLINT1, Conversion.Str(VLVez))
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, VGTipoOper)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_consulcar", True, FMLoadResString(508809)) Then
                If VLVez = 1 Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                Else
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                End If
                PMChequea(sqlconn)
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
            txtCarta.Text = ""
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "447")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, VGTipoOper)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_ayuda", True, FMLoadResString(508822)) Then
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
        VGTipoOper = "A"
    End Sub

End Class


