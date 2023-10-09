Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran303Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLFormatoFecha As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLTransmitir()
            Case 1
                PLLimpiar()
            Case 2
                Me.Close()
            Case 3
                PLBuscar()
            Case 4
                PLSiguientes()
        End Select
    End Sub

    Private Sub FTran303_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        mskCuenta.Mask = VGMascaraCtaAho   'VGMascaraCtaCte
        If VGCB Then
            GroupBox1.Text = FMLoadResString(508915)
        End If
        mskCuenta.Enabled = False
        cmdBoton(0).Enabled = False
        PLTSEstado()
        Me.Text = FMLoadResString(508461)
    End Sub

    Private Sub FTran303_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        VGCB = False
    End Sub

    Private Sub grdValores_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdValores.ClickEvent
        grdValores.Col = 0
        grdValores.SelStartCol = 1
        grdValores.SelEndCol = grdValores.Cols - 1
        If grdValores.Row = 0 Then
            grdValores.SelStartRow = 1
            grdValores.SelEndRow = 1
        Else
            grdValores.SelStartRow = grdValores.Row
            grdValores.SelEndRow = grdValores.Row
        End If
    End Sub

    Private Sub grdValores_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdValores.DblClick
        If grdValores.Rows <= 2 Then
            grdValores.Row = 1
            grdValores.Col = 1
            If grdValores.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500685), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        PMMarcarRegistro()
    End Sub

    Private Sub grdValores_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdValores.KeyUp
        grdValores.Col = 0
        grdValores.SelStartCol = 1
        grdValores.SelEndCol = grdValores.Cols - 1
        If grdValores.Row = 0 Then
            grdValores.SelStartRow = 1
            grdValores.SelEndRow = 1
        Else
            grdValores.SelStartRow = grdValores.Row
            grdValores.SelEndRow = grdValores.Row
        End If
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508672))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If VGCB Then
                    PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & " [" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                    cmdBoton(3).Enabled = True
                    PMLimpiaGrid(grdValores)
                Else
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                cmdBoton_Click(cmdBoton(1), New EventArgs())
                Exit Sub
            End If
        End If
    End Sub

    Private Sub PLBuscar()
        If mskCuenta.ClipText <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "303")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, "0")
            PMPasoValores(sqlconn, "@i_linea", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cobro_vsah", True, FMLoadResString(508815)) Then
                PMMapeaGrid(sqlconn, grdValores, False)
                PMChequea(sqlconn)
                cmdBoton(4).Enabled = Not (Conversion.Val(Convert.ToString(grdValores.Tag)) < 20)
                grdValores.Row = 1
                grdValores.Col = 1
            Else
                PMChequea(sqlconn)
            End If
            If grdValores.Rows > 0 Then
                For i As Integer = 1 To grdValores.Rows - 1
                    grdValores.Col = 0
                    grdValores.Row = i
                    grdValores.CtlText = CStr(grdValores.Row)
                    grdValores.Col = 1
                    If grdValores.CtlText <> "" Then
                        grdValores.Col = 0
                        grdValores.Picture = picVisto(0).Image
                    Else
                        grdValores.Col = 0
                        grdValores.Picture = picVisto(1).Image
                    End If
                Next i
            End If
            If grdValores.Rows <= 2 Then
                grdValores.Row = 1
                grdValores.Col = 1
                If grdValores.CtlText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500685), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton(0).Enabled = False
                    PLTSEstado()
                    Exit Sub
                Else
                    cmdBoton(0).Enabled = True
                    PLTSEstado()
                End If
            End If

        Else
            COBISMessageBox.Show(FMLoadResString(500686), My.Application.Info.ProductName)
            'mskCuenta.Focus()
        End If
    End Sub

    Private Sub PLLimpiar()
        '  mskCuenta.Text = FMMascara("", VGMascaraCtaAho)   'VGMascaraCtaCte
        'lblDescripcion(0).Text = ""
        cmdBoton(3).Enabled = True
        cmdBoton(4).Enabled = False
        cmdBoton(0).Enabled = False
        grdValores.Row = 1
        grdValores.Col = 0
        PMLimpiaGrid(grdValores)
        ' mskCuenta.Focus()
        grdValores.Focus()
        PLTSEstado()
    End Sub

    Private Sub PLSiguientes()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "303")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        grdValores.Col = 1
        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdValores.CtlText)
        PMPasoValores(sqlconn, "@i_linea", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cobro_vsah", True, FMLoadResString(508815)) Then
            PMMapeaGrid(sqlconn, grdValores, True)
            PMChequea(sqlconn)
            cmdBoton(4).Enabled = Not (Conversion.Val(Convert.ToString(grdValores.Tag)) < 20)
            grdValores.Row = 1
            grdValores.Col = 1
        Else
            PMChequea(sqlconn)
        End If
        If grdValores.Rows > 0 Then
            For i As Integer = 1 To grdValores.Rows - 1
                grdValores.Col = 0
                grdValores.Row = i
                grdValores.CtlText = CStr(grdValores.Row)
                grdValores.Col = 1
                If grdValores.CtlText <> "" Then
                    grdValores.Col = 0
                    grdValores.Picture = picVisto(0).Image
                Else
                    grdValores.Col = 0
                    grdValores.Picture = picVisto(1).Image
                End If
            Next i
        End If
    End Sub

    Private Sub PLTransmitir()
        If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(501857), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        Dim VTcontador As Integer = 0
        If Conversion.Val(Convert.ToString(grdValores.Tag)) > 0 Then
            For i As Integer = 1 To (grdValores.Rows - 1)
                grdValores.Row = i
                grdValores.Col = 0
                If grdValores.Picture Is Nothing Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "303")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    If VGCB Then
                        PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                    End If
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                    grdValores.Col = 1
                    PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdValores.CtlText)
                    grdValores.Col = 2
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, grdValores.CtlText)
                    PMPasoValores(sqlconn, "@i_linea", 0, SQLCHAR, "S")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cobro_vsah", True, FMLoadResString(508815)) Then
                        PMChequea(sqlconn)
                        VTcontador += 1
                    Else
                        PMChequea(sqlconn)
                    End If
                End If
            Next i
        End If
        If VTcontador > 0 Then
            PLBuscar()
        End If
    End Sub

    Private Sub PMMarcarRegistro()
        Dim VLBandera As Boolean = False
        grdValores.Col = 0
        If grdValores.Picture Is Nothing Then
            If VLBandera Then
                grdValores.CtlText = Conversion.Str(grdValores.Row)
                grdValores.Picture = picVisto(0).Image
                VLBandera = False
            End If
        Else
            grdValores.CtlText = Conversion.Str(grdValores.Row)
            grdValores.Picture = picVisto(1).Image
            VLBandera = True
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBSiguientes.Enabled = _cmdBoton_4.Enabled
        TSBSiguientes.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub
End Class


