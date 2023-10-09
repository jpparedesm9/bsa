Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Partial Public Class FAyuda2Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdSeleccion_0.Enabled
        TSBBuscar.Visible = _cmdSeleccion_0.Visible
        TSBSigg.Enabled = _cmdSeleccion_1.Enabled
        TSBSigg.Visible = _cmdSeleccion_1.Visible
        TSBEscoger.Enabled = _cmdSeleccion_2.Enabled
        TSBEscoger.Visible = _cmdSeleccion_2.Visible
        TSBSalir.Enabled = _cmdSeleccion_3.Enabled
        TSBSalir.Visible = _cmdSeleccion_3.Visible
    End Sub

    Private Sub cmdSeleccion_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdSeleccion_3.Click, _cmdSeleccion_2.Click, _cmdSeleccion_1.Click, _cmdSeleccion_0.Click
        Dim Index As Integer = Array.IndexOf(cmdSeleccion, eventSender)
        Select Case Index
            Case 0
                PLBuscar(VGOperacion)
            Case 1
                PLSiguientes(VGOperacion)
            Case 2
                PLSeleccionar()
            Case 3
                PLSalir()
        End Select
    End Sub

    Private Sub cmdSeleccion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdSeleccion_3.Enter, _cmdSeleccion_2.Enter, _cmdSeleccion_1.Enter, _cmdSeleccion_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdSeleccion, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500011))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500012))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500121))
            Case 3
                PLSalir()
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500371))
        End Select
    End Sub

    Private Sub FAyuda2_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles MyBase.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = 27 Then
            PLSalir()
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLInicializar()
        mskCuenta.Mask = VGMascaraConta
        Select Case VGOperacion
            Case "sp_busca_cuenta"
                If VGAyuda(4).Trim() <> "" Then
                    mskCuenta.Text = FMMascara(VGAyuda(4), VGMascaraConta)
                End If
        End Select
    End Sub

    Private Sub FAyuda2_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
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
        PLSeleccionar()
    End Sub

    Private Sub grdRegistros_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdRegistros.KeyDown

    End Sub

    Private Sub grdRegistros_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles grdRegistros.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = 13 Then
            PLSeleccionar()
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500122))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub PLBuscar(ByRef tipo As String)
        Select Case tipo
            Case "sp_busca_cuenta"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6017")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText) & "%")
                PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, "%")
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, "%")
                PMPasoValores(sqlconn, "@i_movimiento", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_busca_cuenta", True, FMLoadResString(509234)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                    grdRegistros.ColWidth(1) = 1155
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
            cmdSeleccion(2).Enabled = True
            cmdSeleccion(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            cmdSeleccion(2).Enabled = False
        End If
    End Sub

    Private Sub PLSalir()
        ReDim VGAyuda(5)
        For i As Integer = 1 To 5
            VGAyuda(i) = ""
        Next i
        Me.Close()
    End Sub

    Private Sub PLSeleccionar()
        If (grdRegistros.Cols - 1) = 1 Or grdRegistros.Row = 0 Then
            ReDim VGAyuda(5)
            For i As Integer = 1 To 5
                VGAyuda(i) = ""
            Next i
        Else
            ReDim VGAyuda(grdRegistros.Cols - 1)
            For i As Integer = 1 To grdRegistros.Cols - 1
                grdRegistros.Col = i
                VGAyuda(i) = grdRegistros.CtlText
            Next i
        End If
        Me.Close()
    End Sub

    Private Sub PLSiguientes(ByRef tipo As String)
        Select Case tipo
            Case "sp_busca_cuenta"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6017")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGAyuda(1))
                PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText) & "%")
                PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, "%")
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, "%")
                PMPasoValores(sqlconn, "@i_movimiento", 0, SQLCHAR, "S")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_cuenta1", 0, SQLVARCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_busca_cuenta", True, FMLoadResString(509234)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                    grdRegistros.ColWidth(1) = 1155
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        cmdSeleccion(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
    End Sub

    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdSeleccion_0.Enabled Then cmdSeleccion_Click(_cmdSeleccion_0, e)
    End Sub

    Private Sub TSBSIGG_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSigg.Click
        If _cmdSeleccion_1.Enabled Then cmdSeleccion_Click(_cmdSeleccion_1, e)
    End Sub

    Private Sub TSBESCOGER_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdSeleccion_2.Enabled Then cmdSeleccion_Click(_cmdSeleccion_2, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdSeleccion_3.Enabled Then cmdSeleccion_Click(_cmdSeleccion_3, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2526))
    End Sub
End Class


